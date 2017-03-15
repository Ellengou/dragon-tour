package com.opengroup.lzy.component;

import java.util.List;
import java.util.Map;

/**
 * 分页工具類
 * 
 * @author lc
 *
 * @date 2016年12月31日 下午10:53:50
 */
public class PageMoreBean<T> extends PageBean<T> {
	/**
	 * 携带的参数
	 */
	private Map<String, Object> allPage;

	public PageMoreBean(int total, List<T> rows, Map<String, Object> allPage) {
		super(total, rows);
		this.allPage = allPage;
	}

	public Map<String, Object> getAllPage() {
		return allPage;
	}

	public void setAllPage(Map<String, Object> allPage) {
		this.allPage = allPage;
	}

}
