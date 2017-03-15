package com.opengroup.lzy.sys.dao;

import com.opengroup.lzy.sys.domain.SysPicType;

import java.util.List;
import java.util.Map;

public interface SysPicTypeDao {
	int deleteByPrimaryKey(Integer id);

	int insert(SysPicType record);

	int insertSelective(SysPicType record);

	SysPicType selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(SysPicType record);

	int updateByPrimaryKey(SysPicType record);

	/**
	 * 分页
	 * 
	 * @param params
	 * @return
	 */
	List<SysPicType> queryPicTypes(Map<String, Object> params);
	/**
	 * 总数
	 * @param params
	 * @return
	 */
	int countPicTypes(Map<String, Object> params);
	
	List<SysPicType> queryByStatus();
}