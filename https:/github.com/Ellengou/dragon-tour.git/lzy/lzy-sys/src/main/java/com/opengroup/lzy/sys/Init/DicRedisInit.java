package com.opengroup.lzy.sys.Init;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import com.opengroup.lzy.constants.PrefixConstants;
import com.opengroup.lzy.tools.kv.KvClient;
import com.opengroup.lzy.sys.dao.SysDicDao;
import com.opengroup.lzy.sys.domain.SysDic;

/**
 * 字典初始化
 * 
 * @author lc
 *
 * @date 2017年1月14日 下午4:13:34
 */
@Component
public class DicRedisInit implements ApplicationListener<ContextRefreshedEvent> {
	@Resource
	private SysDicDao sysDicDao;
	@Resource
	private KvClient kvClient;

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		if (event.getApplicationContext().getParent() != null) {
			intDic();
		}

	}

	// 初始化字典到redis
	public void intDic() {

		List<SysDic> sdList = sysDicDao.queryAll();
		//先删除redis
		for (SysDic o : sdList) {
			kvClient.delete(PrefixConstants.DIC + "_" + o.getPidName());
		}
		//保存redis
		for (SysDic o : sdList) {
			kvClient.add2List(PrefixConstants.DIC + "_" + o.getPidName(), o);
		}
	}
}
