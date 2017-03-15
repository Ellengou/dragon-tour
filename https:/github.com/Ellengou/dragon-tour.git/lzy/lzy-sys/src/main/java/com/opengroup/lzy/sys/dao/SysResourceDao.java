package com.opengroup.lzy.sys.dao;

import com.opengroup.lzy.sys.domain.SysResource;

import java.util.List;
import java.util.Map;

/**
 * 资源dao层
 * 
 * @author lc
 *
 * @date 2016年12月31日 下午4:17:36
 */
public interface SysResourceDao {
	int deleteByPrimaryKey(Integer id);

	int insert(SysResource record);

	int insertSelective(SysResource record);

	SysResource selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(SysResource record);

	int updateByPrimaryKey(SysResource record);

	List<SysResource> selectByIds(Map<String, Object> params);

	Integer countByIds(Map<String, Object> params);

	/**
	 * 获取该节点下的子节点
	 * 
	 * @param params
	 * @return
	 */
	List<SysResource> selectByPid(Map<String, Object> params);

	int countByPid(Map<String, Object> params);
}
