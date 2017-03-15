package com.opengroup.lzy.sys.dao;

import com.opengroup.lzy.sys.domain.SysPicUrl;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface SysPicUrlDao {
	int deleteByPrimaryKey(Integer id);

	int insert(SysPicUrl record);

	int insertSelective(SysPicUrl record);

	SysPicUrl selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(SysPicUrl record);

	int updateByPrimaryKey(SysPicUrl record);

	List<SysPicUrl> queryAll();

	/**
	 * 获取 sys_pic_type的ID下的关联图片总数
	 * 
	 * @param typeId
	 * @return
	 */
	int countByPicTypeId(int typeId);

	/**
	 * 分页查询
	 * 
	 * @param params
	 */
	List<SysPicUrl> queryPicUrls(Map<String, Object> params);

	/**
	 * 获取总数
	 * 
	 * @param params
	 * @return
	 */
	int countPicUrls(Map<String, Object> params);

	List<SysPicUrl> selectByPicTypeId(@Param("picTypeId") Integer picTypeId);

}