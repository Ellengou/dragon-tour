package com.opengroup.lzy.sys.service;

import java.util.List;
import java.util.Map;

import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.sys.domain.SysRole;

/**
 * 角色服务
 * 
 * @author lc
 *
 * @date 2016年12月31日 下午4:43:54
 */

public interface SysRoleService {
	/**
	 * 删除角色
	 * 
	 * @param id
	 */
	void delete(Integer id) ;

	/**
	 * 新增角色
	 * **/
	int insert(SysRole sysRole) ;

	/**
	 * 更新角色
	 * **/
	int update(SysRole sysRole);

	/**
	 * 根据主键获取role
	 * **/
	SysRole selectById(Integer id);

	/**
	 * 按属性过滤条件列表分页查找对象
	 * **/
	PageBean selectRole(Map<String, Object> params);

	/**
	 * 获取全部角色
	 * **/
	List<SysRole> selectAllByCompany(Integer companyId);

}
