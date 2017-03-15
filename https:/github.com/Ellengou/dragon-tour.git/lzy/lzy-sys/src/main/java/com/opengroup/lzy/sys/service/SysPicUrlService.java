package com.opengroup.lzy.sys.service;

import java.util.List;
import java.util.Map;

import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.sys.domain.SysPicUrl;

/**
 * 图片服务
 * 
 * @author lc
 *
 * @date 2017年1月15日 下午5:47:25
 */
public interface SysPicUrlService {

	int countByPicTypeId(Integer typeId);

	void insertSelective(SysPicUrl spu);

	/**
	 * 分页
	 * 
	 * @param params
	 * @return
	 */
	PageBean queryPicUrls(Map<String, Object> params);
	
	SysPicUrl selectByPrimaryKey(Integer id);
	
	void updateByPrimaryKeySelective(SysPicUrl spu);
	
	void deleteByPrimaryKey(Integer id);
	
	List<SysPicUrl> selectByPicTypeId(Integer picTypeId);

}
