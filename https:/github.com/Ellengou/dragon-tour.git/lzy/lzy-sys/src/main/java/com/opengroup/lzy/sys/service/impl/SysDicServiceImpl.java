package com.opengroup.lzy.sys.service.impl;

import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.sys.dao.SysDicDao;
import com.opengroup.lzy.sys.service.SysDicService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Map;

/**
 * 字典服务
 * 
 * @author lc
 *
 * @date 2017年1月11日 下午6:49:51
 */
@Service
@Transactional(readOnly = true)
public class SysDicServiceImpl implements SysDicService {
	@Resource
	private SysDicDao sysDicDao;

	@Override
	public PageBean querySysDicsPage(Map<String, Object> params) {
		
		return new PageBean(sysDicDao.countSysDics(params),sysDicDao.querySysDics(params));
	}

}
