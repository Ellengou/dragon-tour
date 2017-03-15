package com.opengroup.lzy.sys.service;

import java.util.List;
import org.apache.shiro.subject.PrincipalCollection;

/**
 * 角色资源服务
 * 
 * @author lc
 *
 * @date 2016年12月31日 下午4:42:30
 */

public interface SysRoleResourceService {

	/**
	 * 获取角色权限id集合
	 * 
	 * @param roleId
	 * @return List
	 */
	List<Integer> getResourceIds(Integer roleId);

	/**
	 * 修改角色权限
	 * 
	 * @param id
	 * @param oldList
	 * @param newList
	 */
	void updateRoleResource(Integer id, List<Integer> oldList,
			List<Integer> newList);

	/**
	 * 清空该角色用户的权限缓存
	 */
	void clearUserRecCache(PrincipalCollection pc);
}
