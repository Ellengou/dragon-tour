package com.opengroup.lzy.sys.dao;

import com.opengroup.lzy.sys.domain.SysUserRole;

import java.util.List;

/**
 * 角色用户dao层
 * 
 * @author lc
 *
 * @date 2016年12月31日 下午4:28:26
 */

public interface SysUserRoleDao {
	int deleteByUser(Integer id);

	int deleteByRole(Integer id);

	int delete(SysUserRole record);

	int insert(SysUserRole record);

	List<Integer> select(Integer userId);

	List<SysUserRole> selectForRole(Integer userId);
}
