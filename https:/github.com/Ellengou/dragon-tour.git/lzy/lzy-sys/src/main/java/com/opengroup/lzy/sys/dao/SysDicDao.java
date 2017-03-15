package com.opengroup.lzy.sys.dao;

import com.opengroup.lzy.sys.domain.SysDic;

import java.util.List;
import java.util.Map;

public interface SysDicDao {
	int deleteByPrimaryKey(Integer id);

	int insert(SysDic record);

	int insertSelective(SysDic record);

	SysDic selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(SysDic record);

	int updateByPrimaryKey(SysDic record);

	List<SysDic> queryAll();

	/**
	 * 分页
	 * 
	 * @param params
	 * @return
	 */
	List<SysDic> querySysDics(Map<String, Object> params);

	/**
	 * 总记录数
	 * 
	 * @param params
	 * @return
	 */
	int countSysDics(Map<String, Object> params);
}