package com.opengroup.lzy.sys.service.impl;

import com.opengroup.lzy.constants.AdminAjaxConstants;
import com.opengroup.lzy.exception.BaseException;
import com.opengroup.lzy.sys.constants.Constants;
import com.opengroup.lzy.sys.dao.SysResourceDao;
import com.opengroup.lzy.sys.dao.SysRoleResourceDao;
import com.opengroup.lzy.sys.dao.SysUserRoleDao;
import com.opengroup.lzy.sys.domain.SysResource;
import com.opengroup.lzy.sys.domain.SysRoleResource;
import com.opengroup.lzy.sys.domain.SysUserRole;
import com.opengroup.lzy.sys.service.SysResourceService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * 
 * @author lc
 *
 * @date 2017年1月1日 下午6:19:26
 */
@Service
@Transactional(readOnly = true)
public class SysResourceServiceImpl implements SysResourceService {

	@Resource
	private SysUserRoleDao sysUserRoleDao;
	@Resource
	private SysResourceDao sysResourceDao;
	@Resource
	private SysRoleResourceDao sysRoleResourceDao;

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int insert(SysResource sysResource, int type)
			throws BaseException {
		if (type == Constants.RESOURCE_ADMIN_MENU) {
			validatorMenu(sysResource);
		} else {
			validatorButton(sysResource);
		}
		int result = sysResourceDao.insert(sysResource);
		sysRoleResourceDao.insertSelective(new SysRoleResource(1, sysResource
				.getId()));
		return result;
	}

	@Override
	public SysResource selectByPrimaryKey(Integer id) {
		return sysResourceDao.selectByPrimaryKey(id);
	}

	@Override
	@Transactional(readOnly = false)
	public int updateByPrimaryKeySelective(SysResource record) {
		return sysResourceDao.updateByPrimaryKeySelective(record);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int update(SysResource sysResource, int type)
			throws BaseException {
		if (type == Constants.RESOURCE_ADMIN_MENU) {
			validatorMenu(sysResource);
		} else {
			validatorButton(sysResource);
		}
		if (sysResource.getStatus() == 0) {
			int count = countAllChild(null, Constants.RESOURCE_ADMIN_MENU,
					sysResource.getId(), Constants.RESOURCE_STATUS_ABLE, null);
			if (count > 0) {
				throw new BaseException(AdminAjaxConstants.MSG_MENU_SON_USE);
			}
		} else {
			SysResource father = selectByPrimaryKey(sysResource.getPid());
			if (father != null) {
				if (father.getStatus() == Constants.RESOURCE_STATUS_DISABLE) {
					throw new BaseException(AdminAjaxConstants.MSG_MENU_FATHER_STOP);
				}
			}
		}
		return sysResourceDao.updateByPrimaryKeySelective(sysResource);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public void delete(Integer id) throws BaseException {
		int countChild = countChild(null, Constants.RESOURCE_ADMIN_MENU, id,
				null, null);
		if (countChild > 0) {
			throw new BaseException("仍有子资源，当前资源不能删除");
		}

		int countButton = countChild(null, Constants.RESOURCE_BUTTON, id, null,
				null);
		if (countButton > 0) {
			throw new BaseException("仍有子资源，当前资源不能删除");
		}

		sysResourceDao.deleteByPrimaryKey(id);
		sysRoleResourceDao.deleteByResource(id);
	}

	@Override
	public List<SysResource> selectAllResource(Integer userId, Integer type,
			Integer pid, Integer status, String dataType) {
		List<SysResource> sysResources = selectResource(userId, type, pid,
				status, dataType);
		if (sysResources == null)
			return null;

		for (int i = 0; i < sysResources.size(); i++) {
			sysResources.get(i).setChildren(
					setChildren(userId, type, sysResources.get(i).getId(),
							status, dataType));
		}
		return sysResources;
	}

	@Override
	public List<SysResource> selectResource(Integer userId, Integer type,
			Integer pid, Integer status, String dataType) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("resourceIds", null);
		if (userId != null) {
			/** SELECT * FROM sys_user_role where user_id = 1; **/
			List<SysUserRole> sysUserRole = sysUserRoleDao
					.selectForRole(userId);

			/**
			 * SELECT DISTINCT * FROM sys_role_resource where role_id in (1, 2,
			 * 3, 4);
			 **/
			StringBuffer roleIds = new StringBuffer("(-1, ");
			for (int i = 0; i < sysUserRole.size(); i++) {
				roleIds.append(sysUserRole.get(i).getRoleId() + ", ");
			}
			roleIds.append("-1)");
			List<SysRoleResource> sysRoleResource = sysRoleResourceDao
					.selectByRoleIds(roleIds.toString());

			/** SELECT * FROM sys_resource where id in (1, 2, 3, 4, 5, 6); **/
			StringBuffer resourceIds = new StringBuffer("(-1, ");
			for (int i = 0; i < sysRoleResource.size(); i++) {
				resourceIds.append(sysRoleResource.get(i).getResourceId()
						+ ", ");
			}
			resourceIds.append("-1)");
			if (resourceIds.equals("(-1, -1)")) {
				params.put("resourceIds", null);
			} else {
				params.put("resourceIds", resourceIds.toString());
			}
		}
		params.put("type", type);
		params.put("pid", pid);
		params.put("status", status);
		params.put("dataType", dataType);
		List<SysResource> sysResource = sysResourceDao.selectByIds(params);
		return sysResource;
	}

	@Override
	public Integer countAllChild(Integer userId, Integer type, Integer pid,
			Integer status, String dataType) {
		int count = 0;
		List<SysResource> sysResources = selectResource(userId, type, pid,
				status, dataType);
		count = count + sysResources.size();
		if (sysResources != null) {
			for (int i = 0; i < sysResources.size(); i++) {
				count = count
						+ countAllChild(pid, type, userId, status, dataType);
			}
		}
		return count;
	}

	@Override
	public Integer countChild(Integer userId, Integer type, Integer pid,
			Integer status, String dataType) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("resourceIds", null);
		if (userId != null) {
			/** SELECT * FROM sys_user_role where user_id = 1; **/
			List<SysUserRole> sysUserRole = sysUserRoleDao
					.selectForRole(userId);

			/**
			 * SELECT DISTINCT * FROM sys_role_resource where role_id in (1, 2,
			 * 3, 4);
			 **/
			StringBuffer roleIds = new StringBuffer("(-1, ");
			for (int i = 0; i < sysUserRole.size(); i++) {
				roleIds.append(sysUserRole.get(i).getRoleId() + ", ");
			}
			roleIds.append("-1)");
			List<SysRoleResource> sysRoleResource = sysRoleResourceDao
					.selectByRoleIds(roleIds.toString());

			/** SELECT * FROM sys_resource where id in (1, 2, 3, 4, 5, 6); **/
			StringBuffer resourceIds = new StringBuffer("(-1, ");
			for (int i = 0; i < sysRoleResource.size(); i++) {
				resourceIds.append(sysRoleResource.get(i).getResourceId()
						+ ", ");
			}
			resourceIds.append("-1)");
			if (resourceIds.equals("(-1, -1)")) {
				params.put("resourceIds", null);
			} else {
				params.put("resourceIds", resourceIds.toString());
			}
		}
		params.put("type", type);
		params.put("pid", pid);
		params.put("status", status);
		params.put("dataType", dataType);
		return sysResourceDao.countByIds(params);
	}

	@Override
	public SysResource validateSysResource(SysResource sysResource) {
		if (sysResource.getType() == 0) {
			// TODO
		} else if (sysResource.getType() == 2) {
			// TODO
		}
		return sysResource;
	}

	@Override
	public List<SysResource> selectByPid(Map<String, Object> params) {
		return sysResourceDao.selectByPid(params);
	}

	@Override
	public int countByPid(Map<String, Object> params) {
		return sysResourceDao.countByPid(params);
	}

	/**
	 * 递归
	 * **/
	private List<SysResource> setChildren(Integer userId, Integer type,
			Integer pid, Integer status, String dataType) {
		List<SysResource> sysResources = selectResource(userId, type, pid,
				status, dataType);
		if (sysResources != null) {
			for (int i = 0; i < sysResources.size(); i++) {
				sysResources.get(i).setChildren(
						setChildren(userId, type, sysResources.get(i).getId(),
								status, dataType));
			}
		}
		return sysResources;
	}

	/**
	 * 校验 & 过滤菜单信息
	 * 
	 * @param sysResource
	 * @throws PermissionException
	 */
	private void validatorMenu(SysResource sysResource)
			throws BaseException {
		sysResource.setName(sysResource.getName().trim());
		sysResource.setUrl(sysResource.getUrl().trim());
		sysResource.setDisorder((sysResource.getDisorder() < 0 ? 0
				: sysResource.getDisorder()));

		if (sysResource.getName().isEmpty()) {
			throw new BaseException(AdminAjaxConstants.MSG_MENU_NAME_NOTNULL);
		}

		if (sysResource.getUrl().isEmpty()) {
			throw new BaseException(AdminAjaxConstants.MSG_MENU_ULR_NOTNULL);
		}

		if (sysResource.getStatus() == null) {
			throw new BaseException(AdminAjaxConstants.MSG_MENU_STATUS);
		}
	}

	private void validatorButton(SysResource sysResource)
			throws BaseException {
		sysResource.setName(sysResource.getName().trim());
		sysResource.setCode(sysResource.getCode().trim());
		sysResource.setRemark(sysResource.getRemark().trim());

		if (sysResource.getName().isEmpty()) {
			throw new BaseException(AdminAjaxConstants.MSG_RESOURCE_NAME_NOTNULL);
		}

		if (sysResource.getCode().isEmpty()) {
			throw new BaseException(AdminAjaxConstants.MSG_RESOURCE_CODE_NOTNULL);
		}

		if (sysResource.getStatus() == null) {
			throw new BaseException(AdminAjaxConstants.MSG_RESOURCE_STATUS);
		}
	}
}
