package com.opengroup.lzy.sys.dao;

import com.opengroup.lzy.sys.domain.SysRole;

import java.util.List;
import java.util.Map;

/**
 * 角色dao层
 * 
 * @author lc
 *
 * @date 2016年12月31日 下午4:23:53
 */
public interface SysRoleDao {

	int deleteByPrimaryKey(Integer id);

	int insert(SysRole record);

	int insertSelective(SysRole record);

	SysRole selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(SysRole record);

	int updateByPrimaryKey(SysRole record);

	Integer countRole(Map<String, Object> condition);

	SysRole countRoleByName(SysRole sysRole);

	List selectRole(Map<String, Object> params);

	List<SysRole> selectAllByCompany(Integer companyId);
}
