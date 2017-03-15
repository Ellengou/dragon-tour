package com.opengroup.lzy.sys.service.impl;

import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.constants.AdminAjaxConstants;
import com.opengroup.lzy.exception.BaseException;
import com.opengroup.lzy.sys.constants.Constants;
import com.opengroup.lzy.sys.dao.SysUserAdminDao;
import com.opengroup.lzy.sys.dao.SysUserRoleDao;
import com.opengroup.lzy.sys.domain.SysCompany;
import com.opengroup.lzy.sys.domain.SysUserAdmin;
import com.opengroup.lzy.sys.domain.SysUserRole;
import com.opengroup.lzy.sys.service.SysUserAdminService;
import com.opengroup.lzy.sys.utils.UserUtil;
import com.opengroup.lzy.tools.security.Digests;
import com.opengroup.lzy.tools.security.Encodes;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 
 * @author lc
 *
 * @date 2017年1月1日 下午5:53:45
 */
@Service
@Transactional(readOnly = true)
public class SysUserAdminServiceImpl implements SysUserAdminService {

	private static final int SALT_SIZE = 8; // 盐长度

	@Resource
	private SysUserAdminDao sysUserAdminDao;
	@Resource
	private SysUserRoleDao sysUserRoleDao;


	@Override
	@Transactional(readOnly = false)
	public int updateByPrimaryKeySelective(SysUserAdmin record) {
		return sysUserAdminDao.updateByPrimaryKeySelective(record);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void insert(SysUserAdmin sysUserAdmin) throws BaseException {
		validator(sysUserAdmin, "insert");

		// 初始化用户信息
		sysUserAdmin.setPassword("123456");
		sysUserAdmin.setUserId(UserUtil.getCurrentUser().getUserId());
		entryptPassword(sysUserAdmin);

		sysUserAdmin.setCreateTime(new Date());
		sysUserAdmin.setLoginCount((sysUserAdmin.getLoginCount() == null ? 0
				: sysUserAdmin.getLoginCount()));
		sysUserAdmin.setState(sysUserAdmin.getState() == null ? 0
				: sysUserAdmin.getState());
		sysUserAdmin.setErrorcount(sysUserAdmin.getErrorcount() == null ? 0
				: sysUserAdmin.getErrorcount());
		sysUserAdmin.setCompanyLock(sysUserAdmin.getCompanyLock() == null ? "0"
				: sysUserAdmin.getCompanyLock());

		sysUserAdminDao.insert(sysUserAdmin);

		
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void updateInfo(SysUserAdmin sysUserAdmin) throws BaseException {
		validator(sysUserAdmin, "update");
		sysUserAdminDao.updateByPrimaryKeySelective(sysUserAdmin);

		
	}

	@Override
	public PageBean selectUserInComp(Map<String, Object> params) {
		List<SysUserAdmin> result = sysUserAdminDao.selectUserInComp(params);
		for (int i = 0; i < result.size(); i++) {
			if (result.get(i).getCompanyLock()
					.equals(Constants.USER_ACCOUNT_COMPANY_LOCKED)) {
				result.get(i).setState(3);
			}
		}
		return new PageBean(sysUserAdminDao.countUserInComp(params), result);
	}

	@Override
	public List<SysUserAdmin> selectAll(Integer userType, Integer compCoreId) {
		return sysUserAdminDao.selectAll(userType, compCoreId);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int addCompCoreAdmin(SysCompany sysCompany, String dataType) throws BaseException {
		SysUserAdmin sysUserAdmin = new SysUserAdmin();
		sysUserAdmin.setCompCoreId(sysCompany.getCompCoreId());
		sysUserAdmin.setCompanyId(sysCompany.getId());
		sysUserAdmin.setLoginName(sysCompany.getRegisterName());
		sysUserAdmin.setLoginName(sysUserAdmin.getLoginName().trim());
		if (sysUserAdmin.getCompanyLock() == null) {
			sysUserAdmin.setCompanyLock("0");
		}

		if (sysUserAdmin.getLoginName().isEmpty()) {
			throw new BaseException(AdminAjaxConstants.MSG_USER_NOTNULL);
		}

		SysUserAdmin sysUserAdminByFind = sysUserAdminDao
				.selectByLoginName(sysUserAdmin.getLoginName());
		if (sysUserAdminByFind != null
				&& sysUserAdmin.getId() != sysUserAdminByFind.getId())
			throw new BaseException(AdminAjaxConstants.MSG_USER_EXIST);

		sysUserAdmin.setRealName(sysCompany.getCompName());
		sysUserAdmin.setPassword(sysCompany.getCompPwd());
		sysUserAdmin.setSalt(sysCompany.getSalt());
		sysUserAdmin.setSex(Constants.SYS_USER_ADMIN);
		sysUserAdmin.setEmail(sysCompany.getCompEmail());
		sysUserAdmin.setDataType(dataType);
		sysUserAdmin.setUserId(UserUtil.getCurrentUser().getUserId());
		sysUserAdmin.setCreateTime(new Date());
		sysUserAdmin.setLoginCount((sysUserAdmin.getLoginCount() == null ? 0
				: sysUserAdmin.getLoginCount()));
		sysUserAdmin.setState(sysUserAdmin.getState() == null ? 0
				: sysUserAdmin.getState());
		sysUserAdmin.setErrorcount(sysUserAdmin.getErrorcount() == null ? 0
				: sysUserAdmin.getErrorcount());
		int result = sysUserAdminDao.insert(sysUserAdmin);
		SysUserAdmin sysUserAdminAdd = selectByLoginName(sysCompany
				.getRegisterName());
		sysUserRoleDao.insert(new SysUserRole(sysUserAdminAdd.getId(), Integer
				.parseInt(dataType) + 1));
		return result;
	}

	@Override
	public List<SysUserAdmin> selectByCompCoreId(Integer compCoreId) {
		return sysUserAdminDao.selectByCompCoreId(compCoreId);
	}

	@Override
	public int updateByCompanyCoreId(Integer compCoreId, String enabled) {
		return sysUserAdminDao.updateByCompanyCoreId(compCoreId, enabled);
	}

	@Override
	@Transactional(readOnly = false)
	public void update(SysUserAdmin sysUserAdmin) {
		sysUserAdmin.setLoginCount((sysUserAdmin.getLoginCount() == null ? 0
				: sysUserAdmin.getLoginCount()) + 1);
		sysUserAdmin.setPreviousVisit(sysUserAdmin.getLastVisit());
		sysUserAdmin.setLastVisit(new Date());
		sysUserAdminDao.updateByPrimaryKeySelective(sysUserAdmin);
	}

	@Override
	@Transactional(readOnly = false)
	public void updatePassword(SysUserAdmin sysUserAdmin) {
		entryptPassword(sysUserAdmin);
		sysUserAdminDao.updateByPrimaryKeySelective(sysUserAdmin);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void delete(Integer id) throws BaseException {
		isSupervisor(sysUserAdminDao.selectByPrimaryKey(id));
		sysUserAdminDao.deleteByPrimaryKey(id);
		sysUserRoleDao.deleteByUser(id);
	}

	@Override
	public SysUserAdmin selectByLoginName(String loginName) {
		return sysUserAdminDao.selectByLoginName(loginName);
	}

	@Override
	public SysUserAdmin selectByPrimaryKey(Integer id) {
		return sysUserAdminDao.selectByPrimaryKey(id);
	}

	@Override
	public PageBean selectUser(Map<String, Object> params) {
		return new PageBean(sysUserAdminDao.countUser(params),
				sysUserAdminDao.selectUser(params));
	}

	@Override
	public boolean checkPassword(SysUserAdmin sysUserAdmin, String oldPassword) {
		byte[] salt = Encodes.decodeHex(sysUserAdmin.getSalt());
		byte[] hashPassword = Digests.md5(oldPassword.getBytes(), salt,
				HASH_INTERATIONS);
		if (sysUserAdmin.getPassword().equals(Encodes.encodeHex(hashPassword))) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 校验 & 过滤
	 * **/
	private void validator(SysUserAdmin sysUserAdmin, String type) throws BaseException {
		if (type.equals("insert")) {
			sysUserAdmin.setLoginName(sysUserAdmin.getLoginName().trim());

			SysUserAdmin sysUserAdminByFind = sysUserAdminDao
					.selectByLoginName(sysUserAdmin.getLoginName());
			if (sysUserAdminByFind != null
					&& sysUserAdmin.getId() != sysUserAdminByFind.getId())
				throw new BaseException(AdminAjaxConstants.MSG_USER_EXIST);
		} else {
			sysUserAdmin.setLoginName(null);
		}

		sysUserAdmin.setRealName(sysUserAdmin.getRealName().trim());
		sysUserAdmin.setPhone(sysUserAdmin.getPhone().trim());
		sysUserAdmin.setEmail(sysUserAdmin.getEmail().trim());

		sysUserAdmin.setDataType(UserUtil.getCurrentUser().getDataType());
		sysUserAdmin.setCompCoreId(UserUtil.getCurrentUser().getCompCoreId());
		sysUserAdmin.setCompanyId(UserUtil.getCurrentUser().getCompanyId());
		sysUserAdmin.setOrgId(UserUtil.getCurrentUser().getOrgId());

		if (sysUserAdmin.getState() == null) {
			throw new BaseException(AdminAjaxConstants.MSG_USER_STATUS);
		}
	}

	/**
	 * 判断是否超级管理员
	 * 
	 * @param sysUserAdmin
	 * @return boolean
	 */
	private void isSupervisor(SysUserAdmin sysUserAdmin) throws BaseException {
		if (sysUserAdmin.getSex().equals(Constants.SYS_USER_ADMIN))
			throw new BaseException(AdminAjaxConstants.MSG_USER_NOTDELETE);
	}

	/**
	 * 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
	 */
	private void entryptPassword(SysUserAdmin user) {
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		user.setSalt(Encodes.encodeHex(salt));

		byte[] hashPassword = Digests.md5(user.getPassword().getBytes(), salt,
				HASH_INTERATIONS);
		user.setPassword(Encodes.encodeHex(hashPassword));
	}
}
