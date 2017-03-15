package com.opengroup.lzy.sys.service.impl;

import com.opengroup.lzy.sys.dao.SysUserRoleDao;
import com.opengroup.lzy.sys.domain.SysUserRole;
import com.opengroup.lzy.sys.service.SysUserRoleService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 
 * @author lc
 *
 * @date 2017年1月1日 下午5:53:02
 */
@Service
@Transactional(readOnly = true)
public class SysUserRoleServiceImpl implements SysUserRoleService {

	@Resource
	private SysUserRoleDao sysUserRoleDao;

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void updateUserRole(Integer userId, List<Integer> oldList,
			List<Integer> newList) {
		// 是否删除
		for (int i = 0, j = oldList.size(); i < j; i++) {
			if (!newList.contains(oldList.get(i))) {
				sysUserRoleDao.delete(new SysUserRole(userId, oldList.get(i)));
			}
		}

		// 是否添加
		for (int m = 0, n = newList.size(); m < n; m++) {
			if (!oldList.contains(newList.get(m))) {
				sysUserRoleDao.insert(new SysUserRole(userId, newList.get(m)));
			}
		}
	}

	@Override
	@Transactional(readOnly = false)
	public List<Integer> getRoleIdList(Integer userId) {
		return sysUserRoleDao.select(userId);
	}

}
