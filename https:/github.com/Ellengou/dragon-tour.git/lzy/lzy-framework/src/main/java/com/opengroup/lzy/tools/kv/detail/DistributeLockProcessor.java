package com.opengroup.lzy.tools.kv.detail;

/**
 * 业务处理接口
 * 
 * @author lc
 *
 * @date 2017年1月12日 下午2:05:43
 */
public interface DistributeLockProcessor<T> {

	T process() throws Exception;
}
