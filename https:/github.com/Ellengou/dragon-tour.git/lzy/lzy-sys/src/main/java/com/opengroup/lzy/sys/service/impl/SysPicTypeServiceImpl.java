package com.opengroup.lzy.sys.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.sys.dao.SysPicTypeDao;
import com.opengroup.lzy.sys.domain.SysPicType;
import com.opengroup.lzy.sys.service.SysPicTypeService;

/**
 * 
 * @author lc
 *
 * @date 2017年1月15日 下午4:30:47
 */
@Service
@Transactional(readOnly = true)
public class SysPicTypeServiceImpl implements SysPicTypeService {
	@Resource
	private SysPicTypeDao sysPicTypeDao;

	@Override
	public PageBean queryPicTypes(Map<String, Object> params) {

		return new PageBean(sysPicTypeDao.countPicTypes(params),
				sysPicTypeDao.queryPicTypes(params));
	}

	@Transactional(readOnly = false)
	@Override
	public void insertSelective(SysPicType spt) {
		sysPicTypeDao.insertSelective(spt);
	}
	@Transactional(readOnly = false)
	@Override
	public void updateByPrimaryKeySelective(SysPicType spt) {
		sysPicTypeDao.updateByPrimaryKeySelective(spt);
		
	}

	@Override
	public SysPicType selectByPrimaryKey(int id) {
		return sysPicTypeDao.selectByPrimaryKey(id);
	}

	@Override
	public List<SysPicType> queryByStatus() {
		
		return sysPicTypeDao.queryByStatus();
	}

}
