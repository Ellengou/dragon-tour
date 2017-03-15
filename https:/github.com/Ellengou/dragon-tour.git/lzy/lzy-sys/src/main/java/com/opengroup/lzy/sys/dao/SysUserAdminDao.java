package com.opengroup.lzy.sys.dao;

import com.opengroup.lzy.sys.domain.SysUserAdmin;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 后台用户dao层
 * 
 * @author lc
 *
 * @date 2016年12月31日 下午4:25:13
 */
public interface SysUserAdminDao {
	int deleteByPrimaryKey(Integer id);

	int insert(SysUserAdmin record);

	int insertSelective(SysUserAdmin record);

	int updateByPrimaryKeySelective(SysUserAdmin record);

	int updateByPrimaryKey(SysUserAdmin record);

	void insertUserRoles(Integer userId, Integer[] roleIds);

	SysUserAdmin selectByPrimaryKey(Integer id);

	SysUserAdmin selectByLoginName(String loginName);

	List<Integer> selectForRole(String loginName);

	List<Integer> selectForPermission(String loginName);

	List<SysUserAdmin> selectUser(Map<String, Object> params);

	int countUser(Map<String, Object> params);

	Integer countUserByCond(Map<String, Object> params);

	/**
	 * 获取企业账号列表
	 * 
	 * @param params
	 * @return
	 */
	List<SysUserAdmin> selectUserInComp(Map<String, Object> params);

	int countUserInComp(Map<String, Object> params);

	/**
	 * 获取所有用户
	 * 
	 * @param userType
	 * @param compCoreId
	 * @return
	 */
	List<SysUserAdmin> selectAll(@Param("userType") Integer userType,
			@Param("compCoreId") Integer compCoreId);

	/**
	 * 核心企业下所有用户
	 * 
	 * @param compCoreId
	 * @return
	 */
	List<SysUserAdmin> selectByCompCoreId(Integer compCoreId);

	/**
	 * 修改核心企业下所有后台用户账号状态
	 * 
	 * @param compCoreId
	 * @param enabled
	 * @return
	 */
	int updateByCompanyCoreId(@Param("compCoreId") Integer compCoreId,
			@Param("enabled") String enabled);
}
