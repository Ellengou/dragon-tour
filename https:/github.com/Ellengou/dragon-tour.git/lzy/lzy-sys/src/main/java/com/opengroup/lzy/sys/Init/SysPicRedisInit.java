package com.opengroup.lzy.sys.Init;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import com.opengroup.lzy.constants.CommonConstants;
import com.opengroup.lzy.tools.kv.KvClient;
import com.opengroup.lzy.sys.dao.SysPicUrlDao;
import com.opengroup.lzy.sys.domain.SysPicUrl;

/**
 * 基础图片
 * 
 * @author lc
 *
 * @date 2017年1月15日 下午3:12:09
 */
@Component
public class SysPicRedisInit implements
		ApplicationListener<ContextRefreshedEvent> {
	@Resource
	private SysPicUrlDao sysPicUrlDao;
	@Resource
	private KvClient kvClient;

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		if (event.getApplicationContext().getParent() != null) {
			initSysPic();
		}

	}

	//
	public void initSysPic() {

		List<SysPicUrl> spuList = sysPicUrlDao.queryAll();
		// 删除
		for (SysPicUrl o : spuList) {
			kvClient.delete(CommonConstants.SYS_PIC + o.getPicTypeId());
		}
		// 增加
		for (SysPicUrl o : spuList) {
			kvClient.add2List(CommonConstants.SYS_PIC + o.getPicTypeId(), o);
		}

	}
}
