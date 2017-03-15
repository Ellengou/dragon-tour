package com.opengroup.lzy.tools.kv.detail;

import java.util.List;
import java.util.Set;

/**
 * 实际KV类DB的操作接口
 * 
 * @author lc
 *
 * @date 2017年1月12日 下午2:05:10
 */
public interface CommonClient {
	/**
	 * 保存
	 * 
	 * @param key
	 * @param value
	 * @param expiredSeconds
	 */
	<V> void save(String key, V value, int expiredSeconds);

	/**
	 * 读取
	 * 
	 * @param key
	 * @return
	 */
	<V> V read(String key, Class<V> c);

	/**
	 * 删除
	 * 
	 * @param key
	 */
	void delete(String key);

	/**
	 * 分布式锁，如果超时指定时间还未取得锁，那么抛出异常
	 * 
	 * @param key
	 * @return
	 */
	<T> T lock(String key, DistributeLockProcessor<T> processor,
			int waitTimeMillis) throws Exception;

	/**
	 * 把一个数组插入到list中
	 * 
	 * @param key
	 * @param list
	 */
	<T> void add2List(String key, T... list);

	/**
	 * 把一个数组插入到set中
	 * 
	 * @param key
	 * @param list
	 */
	<T> void add2Set(String key, T... set);

	/**
	 * 读取一个列表并删除
	 * 
	 * @param key
	 * @param c
	 */
	<V> List<V> readAndDelList(String key, Class<V> c);

	/**
	 * 读取一个列表
	 * 
	 * @param key
	 * @param c
	 */
	<V> List<V> readList(String key, Class<V> c);

	/**
	 * 读取一个set
	 * 
	 * @param key
	 * @param c
	 * @return
	 */
	<V> Set<V> readSet(String key, Class<V> c);

	/**
	 * 读取一个set并删除
	 * 
	 * @param key
	 * @param c
	 */
	<V> Set<V> readAndDelSet(String key, Class<V> c);

	/**
	 * 删除set的一个元素
	 * 
	 * @param key
	 * @param vals
	 */
	<V> void delSetItems(String key, V... vals);
}
