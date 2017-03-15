package com.opengroup.lzy.sys.service;

import java.util.List;
import java.util.Map;

import com.opengroup.lzy.sys.domain.SysResource;

/**
 * 资源服务
 * 
 * @author lc
 *
 * @date 2016年12月31日 下午4:39:31
 */

public interface SysResourceService {

	/**
	 * 新增资源
	 * 
	 * @param sysResource
	 * @param type
	 * @return
	 **/
	int insert(SysResource sysResource, int type);

	/**
	 * 根据ID号获取资源
	 * 
	 * @param id
	 * **/
	SysResource selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(SysResource record);

	/**
	 * 更新资源
	 * **/
	int update(SysResource sysResource, int type) ;

	/**
	 * 删除权限
	 * 
	 * @param id
	 * **/
	void delete(Integer id) ;

	/**
	 * 根据父节点获取 - 所有子节点
	 * 
	 * @param pid
	 * @param type
	 * @param userId
	 * @param status
	 * @return 资源集合
	 * **/
	List<SysResource> selectAllResource(Integer userId, Integer type,
			Integer pid, Integer status, String dataType);

	/**
	 * 获取该用户的资源 - 一级子节点
	 * 
	 * @param userId
	 * @param type
	 * @param pid
	 * @param status
	 * **/
	List<SysResource> selectResource(Integer userId, Integer type, Integer pid,
			Integer status, String dataType);

	/**
	 * 计算该节点下 - 所有有子节点
	 * 
	 * @param pid
	 * @param type
	 * @param userId
	 * @param status
	 * **/
	Integer countAllChild(Integer userId, Integer type, Integer pid,
			Integer status, String dataType);

	/**
	 * 计算该节点下 - 一级子节点
	 * 
	 * @param pid
	 * @param type
	 * @param userId
	 * @param status
	 * **/
	Integer countChild(Integer userId, Integer type, Integer pid,
			Integer status, String dataType);

	/**
	 * 资源修改、添加的过滤
	 * 
	 * @param sysResource
	 * **/
	SysResource validateSysResource(SysResource sysResource);

	/**
	 * 获取该节点下的子节点
	 * 
	 * @param params
	 * @return
	 */
	List<SysResource> selectByPid(Map<String, Object> params);

	int countByPid(Map<String, Object> params);
}
