package com.opengroup.lzy.sys.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.sys.domain.SysCompany;
import com.opengroup.lzy.sys.domain.SysUserAdmin;

/**
 *后台用户
 * @author lc
 *
 * @date 2016年12月31日 下午11:16:32
 */

public interface SysUserAdminService {
	/** 加密方法 */
	String HASH_ALGORITHM = "MD5";
	int HASH_INTERATIONS = 1024;

	int updateByPrimaryKeySelective(SysUserAdmin record);

	/**
	 * 保存用户
	 *
	 * @param sysUserAdmin
	 */
	void insert(SysUserAdmin sysUserAdmin);

	/**
	 * 修改密码
	 *
	 * @param sysUserAdmin
	 */
	void updatePassword(SysUserAdmin sysUserAdmin);

	/**
	 * 删除用户
	 *
	 * @param id
	 */
	void delete(Integer id);

	/**
	 * 按登录名查询用户
	 *
	 * @param loginName
	 * @return 用户对象
	 */
	SysUserAdmin selectByLoginName(String loginName);

	/**
	 * 按登录名查询用户
	 *
	 * @param id
	 * @return 用户对象
	 */
	SysUserAdmin selectByPrimaryKey(Integer id);

	/**
	 * 获取用户列表
	 *
	 * @param params
	 * @return 用户对象
	 */
	PageBean selectUser(Map<String, Object> params);

	/**
	 * 验证原密码是否正确
	 * 
	 * @param sysUserAdmin
	 * @param oldPassword
	 * @return
	 */
	boolean checkPassword(SysUserAdmin sysUserAdmin, String oldPassword);

	/**
	 * 更新用户登陆信息
	 * 
	 * @param sysUserAdmin
	 */
	void update(SysUserAdmin sysUserAdmin);

	/**
	 * 修改用户信息
	 * 
	 * @param sysUserAdmin
	 */
	void updateInfo(SysUserAdmin sysUserAdmin);

	/**
	 * 获取企业账号列表
	 * 
	 * @param params
	 * @return
	 */
	PageBean selectUserInComp(Map<String, Object> params);

	/**
	 * 获取所有用户
	 * 
	 * @return
	 * @param userType
	 */
	List<SysUserAdmin> selectAll(Integer userType, Integer compCoreId);

	/**
	 * 创建核心企业管理员账号
	 * 
	 * @param sysCompany
	 * @return
	 */
	int addCompCoreAdmin(SysCompany sysCompany, String dataType);

	/**
	 * 核心企业下所有平台用户
	 * 
	 * @param companyId
	 * @return
	 */
	List<SysUserAdmin> selectByCompCoreId(Integer companyId);

	/**
	 * 修改核心企业下所有后台用户账号状态
	 * 
	 * @param compCoreId
	 * @param enabled
	 */
	int updateByCompanyCoreId(Integer compCoreId, String enabled);
}