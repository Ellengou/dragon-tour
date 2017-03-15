package com.opengroup.lzy.sys.service.impl;

import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.sys.dao.SysPicUrlDao;
import com.opengroup.lzy.sys.domain.SysPicUrl;
import com.opengroup.lzy.sys.service.SysPicUrlService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
@Service
@Transactional(readOnly = true)
public class SysPicUrlServiceImpl implements SysPicUrlService {
	@Resource
	private SysPicUrlDao sysPicUrlDao;

	@Override
	public int countByPicTypeId(Integer typeId) {
		return sysPicUrlDao.countByPicTypeId(typeId);
	}

	@Transactional(readOnly = false)
	@Override
	public void insertSelective(SysPicUrl spu) {
		sysPicUrlDao.insertSelective(spu);

	}

	@Override
	public PageBean queryPicUrls(Map<String, Object> params) {

		return new PageBean(sysPicUrlDao.countPicUrls(params),
				sysPicUrlDao.queryPicUrls(params));
	}

	@Override
	public SysPicUrl selectByPrimaryKey(Integer id) {
		return sysPicUrlDao.selectByPrimaryKey(id);
	}

	@Transactional(readOnly = false)
	@Override
	public void updateByPrimaryKeySelective(SysPicUrl spu) {
		sysPicUrlDao.updateByPrimaryKeySelective(spu);

	}
	@Transactional(readOnly = false)
	@Override
	public void deleteByPrimaryKey(Integer id) {
		sysPicUrlDao.deleteByPrimaryKey(id);
		
	}

	@Override
	public List<SysPicUrl> selectByPicTypeId(Integer picTypeId) {
		return sysPicUrlDao.selectByPicTypeId(picTypeId);
	}

}
