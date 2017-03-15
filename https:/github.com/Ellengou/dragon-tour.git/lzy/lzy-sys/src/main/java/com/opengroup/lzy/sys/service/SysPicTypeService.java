package com.opengroup.lzy.sys.service;

import java.util.List;
import java.util.Map;

import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.sys.domain.SysPicType;

/**
 * 图片类型服务
 * 
 * @author lc
 *
 * @date 2017年1月15日 下午4:30:23
 */
public interface SysPicTypeService {
	/**
	 * 列表分页
	 * 
	 * @param params
	 * @return
	 */
	PageBean queryPicTypes(Map<String, Object> params);

	void insertSelective(SysPicType spt);

	void updateByPrimaryKeySelective(SysPicType spt);

	SysPicType selectByPrimaryKey(int id);

	List<SysPicType> queryByStatus();
}
