package com.opengroup.lzy.sys.service;

import java.util.List;

/**
 * 用户角色服务
 * 
 * @author lc
 *
 * @date 2016年12月31日 下午4:45:41
 */
public interface SysUserRoleService {

	/**
	 * 添加修改用户角色
	 *
	 * @param userId
	 * @param oldList
	 * @param newList
	 */
	void updateUserRole(Integer userId, List<Integer> oldList,
			List<Integer> newList);

	/**
	 * 获取用户拥有角色id集合
	 *
	 * @param userId
	 * @return 结果集合
	 */
	List<Integer> getRoleIdList(Integer userId);
}
