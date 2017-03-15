package com.opengroup.lzy.sys.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.constants.AdminAjaxConstants;
import com.opengroup.lzy.exception.BaseException;
import com.opengroup.lzy.sys.constants.Constants;
import com.opengroup.lzy.sys.dao.SysRoleDao;
import com.opengroup.lzy.sys.dao.SysRoleResourceDao;
import com.opengroup.lzy.sys.dao.SysUserRoleDao;
import com.opengroup.lzy.sys.domain.SysRole;
import com.opengroup.lzy.sys.service.SysRoleService;
import com.opengroup.lzy.sys.utils.UserUtil;


/**
 * Created by violorch on 2016/4/20.
 */
@Service
@Transactional(readOnly = true)
public class SysRoleServiceImpl implements SysRoleService {

    @Resource
    private SysRoleDao sysRoleDao;

    @Resource
    private SysRoleResourceDao sysRoleResourceDao;

    @Resource
    private SysUserRoleDao sysUserRoleDao;

    @Override
    @Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public void delete(Integer id) throws BaseException {
        SysRole sysRole = sysRoleDao.selectByPrimaryKey(id);
        ifAdmin(sysRole);
        sysRoleDao.deleteByPrimaryKey(id);
        sysUserRoleDao.deleteByRole(id);
        sysRoleResourceDao.deleteByRole(id);
    }

    @Override
    @Transactional(readOnly = false)
    public int insert(SysRole sysRole) throws BaseException {
        validator(sysRole);
        sysRole.setOperateTime(new Date());
        sysRole.setUserId(UserUtil.getCurrentUser().getUserId());
        return sysRoleDao.insert(sysRole);
    }

    @Override
    @Transactional(readOnly = false)
    public int update(SysRole sysRole) throws BaseException {
        ifAdmin(sysRole);
        validator(sysRole);
        return sysRoleDao.updateByPrimaryKeySelective(sysRole);
    }

    /**
     * 校验 & 过滤
     * @throws PermissionException 
     * **/
    private void validator(SysRole sysRole) throws BaseException {
        sysRole.setRlname(sysRole.getRlname().trim());
        sysRole.setMemo(sysRole.getMemo().trim());
        sysRole.setCompCoreId(UserUtil.getCurrentUser().getCompCoreId());
        sysRole.setCompanyId(UserUtil.getCurrentUser().getCompanyId());
        sysRole.setOrgId(UserUtil.getCurrentUser().getOrgId());

        SysRole sysRoleByFind = sysRoleDao.countRoleByName(sysRole);
        if (sysRoleByFind != null && sysRole.getId().intValue() != sysRoleByFind.getId().intValue())
            throw new BaseException(AdminAjaxConstants.MSG_ROLE_EXIST);
    }

    /**
     * 判断是否是超级管理员
     * @throws PermissionException 
     * **/
    private void ifAdmin(SysRole sysRole) throws BaseException {
        if (sysRole.getStatus() == Constants.SYS_PERMISSION_ADMIN) {
            throw new BaseException(AdminAjaxConstants.MSG_USER_NOCHANGE);
        }
    }

    @Override
    public SysRole selectById(Integer id) {
        return sysRoleDao.selectByPrimaryKey(id);
    }

    @Override
    public PageBean selectRole(Map<String, Object> params) {
        return new PageBean(sysRoleDao.countRole(params), sysRoleDao.selectRole(params));
    }

    @Override
    public List<SysRole> selectAllByCompany(Integer companyId) {
        return sysRoleDao.selectAllByCompany(companyId);
    }
}
