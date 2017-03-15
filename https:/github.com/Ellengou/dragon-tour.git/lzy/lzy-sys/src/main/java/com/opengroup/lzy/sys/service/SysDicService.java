package com.opengroup.lzy.sys.service;

import java.util.Map;

import com.opengroup.lzy.component.PageBean;

/**
 * 字典服务
 * 
 * @author lc
 *
 * @date 2017年1月11日 下午6:49:20
 */
public interface SysDicService {

	/**
	 * 分页
	 * 
	 * @param params
	 * @return
	 */
	PageBean querySysDicsPage(Map<String, Object> params);

}
