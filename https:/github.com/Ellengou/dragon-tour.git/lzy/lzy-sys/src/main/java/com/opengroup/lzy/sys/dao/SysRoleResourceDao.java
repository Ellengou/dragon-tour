package com.opengroup.lzy.sys.dao;

import com.opengroup.lzy.sys.domain.SysRoleResource;

import java.util.List;

/**
 * 角色资源dao层
 * 
 * @author lc
 *
 * @date 2016年12月31日 下午4:24:34
 */

public interface SysRoleResourceDao {
	int deleteByRole(Integer id);

	int deleteByResource(Integer id);

	int delete(SysRoleResource record);

	int insertSelective(SysRoleResource record);

	List<Integer> selectByRoleId(Integer roleId);

	List<Integer> selectByResourceId(Integer resourceId);

	List<SysRoleResource> selectByRoleIds(String roleIds);
}
