package com.opengroup.lzy.sys.service;

import com.google.common.base.Objects;
import com.opengroup.lzy.sys.constants.Constants;
import com.opengroup.lzy.sys.dao.SysRoleDao;
import com.opengroup.lzy.sys.dao.SysUserRoleDao;
import com.opengroup.lzy.sys.domain.SysResource;
import com.opengroup.lzy.sys.domain.SysUserAdmin;
import com.opengroup.lzy.sys.domain.SysUserRole;
import com.opengroup.lzy.sys.utils.security.UsernamePasswordCaptchaToken;
import com.opengroup.lzy.tools.security.Encodes;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.jdbc.JdbcRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;

/**
 * 用户登录授权service(shrioRealm)
 *
 * @author lc
 * @date 2016年12月31日 下午4:47:14
 */
public class UserRealm extends JdbcRealm {

    @Resource
    private SysUserAdminService sysUserAdminService;
    @Resource
    private SysUserRoleDao sysUserRoleDao;
    @Resource
    private SysResourceService sysResourceService;
    @Resource
    private SysRoleDao sysRoleDao;

    /**
     * 认证回调函数,登录时调用.
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
        UsernamePasswordCaptchaToken token = (UsernamePasswordCaptchaToken) authcToken;
        SimpleAuthenticationInfo simpleAuthenticationInfo = null;

        SysUserAdmin sysUserAdmin = sysUserAdminService.selectByLoginName(token.getUsername());
        if (sysUserAdmin != null && doCaptchaValidate(token)) {
            if (sysUserAdmin.getState() != Constants.USER_ACCOUNT_COMMON) {
                throw new LockedAccountException();
            }

            byte[] salt = Encodes.decodeHex(sysUserAdmin.getSalt());
            ShiroUser shiroUser = new ShiroUser(sysUserAdmin.getId(), sysUserAdmin.getLoginName());

            // 设置用户session
            Session session = SecurityUtils.getSubject().getSession();
            session.setAttribute(Constants.SYS_USER, sysUserAdmin);

            simpleAuthenticationInfo = new SimpleAuthenticationInfo(shiroUser, sysUserAdmin.getPassword(),
                    ByteSource.Util.bytes(salt), getName());
        } else {
            // 无此账号
            throw new UnknownAccountException();
        }


        return simpleAuthenticationInfo;
    }

    /**
     * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用.
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
        SysUserAdmin user = sysUserAdminService.selectByLoginName(shiroUser.loginName);

        //把principals放session中 key=userId value=principals
        SecurityUtils.getSubject().getSession().setAttribute(String.valueOf(user.getId()),
                SecurityUtils.getSubject().getPrincipals());
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();

        //赋予角色
        List<SysUserRole> sysUserRoles = sysUserRoleDao.selectForRole(user.getId());
        for (int i = 0; i < sysUserRoles.size(); i++) {
            info.addRole(sysRoleDao.selectByPrimaryKey(sysUserRoles.get(i).getRoleId()).getRlname());
        }

        //赋予权限
        List<SysResource> sysResources = sysResourceService.selectResource(user.getId(), null, null,
                Constants.RESOURCE_STATUS_ABLE, null); //UserUtil.getCurrentUser().getDataType());
        for (int i = 0; i < sysResources.size(); i++) {
            if (StringUtils.isNotBlank(sysResources.get(i).getCode())) {
                info.addStringPermission(sysResources.get(i).getCode());
            }
        }

        //设置登录次数、时间
        sysUserAdminService.update(user);
        return info;
    }

    /**
     * 验证码校验
     *
     * @param token
     * @return boolean
     */
    protected boolean doCaptchaValidate(UsernamePasswordCaptchaToken token) {
        String captcha = (String) SecurityUtils.getSubject().getSession().getAttribute("KAPTCHA_SESSION_KEY");
//        if (captcha != null &&!captcha.equalsIgnoreCase(token.getCaptcha())){
//            throw new CaptchaException("验证码错误！");
//        }
        return true;
    }

    /**
     * 设定Password校验的Hash算法与迭代次数.
     */
    @SuppressWarnings("static-access")
    @PostConstruct
    public void initCredentialsMatcher() {
        HashedCredentialsMatcher matcher = new HashedCredentialsMatcher(sysUserAdminService.HASH_ALGORITHM);
        matcher.setHashIterations(sysUserAdminService.HASH_INTERATIONS);
        setCredentialsMatcher(matcher);
    }

    /**
     * 自定义Authentication对象，使得Subject除了携带用户的登录名外还可以携带更多信息.
     */
    public static class ShiroUser implements Serializable {
        private static final long serialVersionUID = 1L;
        public Integer id;
        public String loginName;

        public ShiroUser(Integer id, String loginName) {
            this.id = id;
            this.loginName = loginName;
            // TODO GET　companyId & orgId
        }

        public Integer getId() {
            return id;
        }

        /**
         * 本函数输出将作为默认的<shiro:principal/>输出.
         */
        @Override
        public String toString() {
            return loginName;
        }

        /**
         * 重载hashCode,只计算loginName;
         */
        @Override
        public int hashCode() {
            return Objects.hashCode(loginName);
        }

        /**
         * 重载equals,只计算loginName;
         */
        @Override
        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj == null) {
                return false;
            }
            if (getClass() != obj.getClass()) {
                return false;
            }
            ShiroUser other = (ShiroUser) obj;
            if (loginName == null) {
                if (other.loginName != null) {
                    return false;
                }
            } else if (!loginName.equals(other.loginName)) {
                return false;
            }
            return true;
        }
    }

    @Override
    public void clearCachedAuthorizationInfo(PrincipalCollection principals) {
        super.clearCachedAuthorizationInfo(principals);
    }

    @Override
    public void clearCachedAuthenticationInfo(PrincipalCollection principals) {
        super.clearCachedAuthenticationInfo(principals);
    }

    @Override
    public void clearCache(PrincipalCollection principals) {
        super.clearCache(principals);
    }

    public void clearAllCachedAuthorizationInfo() {
        getAuthorizationCache().clear();
    }

    public void clearAllCachedAuthenticationInfo() {
        getAuthenticationCache().clear();
    }

    public void clearAllCache() {
        clearAllCachedAuthenticationInfo();
        clearAllCachedAuthorizationInfo();
    }

}
