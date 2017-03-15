package com.opengroup.lzy.tools.kv.detail;

import org.springframework.beans.factory.annotation.Value;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

/**
 * redis的连接池
 * 
 * @author lc
 *
 * @date 2017年1月13日 下午5:08:22
 */

public class RedisConnPool {

	@Value("${framework.kv.redis.max_total}")
	private String maxTotal;
	@Value("${framework.kv.redis.max_wait_millis}")
	private int maxWaitMillis;
	@Value("${framework.kv.redis.max_idle}")
	private int maxIdle;
	@Value("${framework.kv.redis.port}")
	private int port;
	@Value("${framework.kv.redis.host}")
	private String host;
/*	@Value("${framework.kv.redis.auth}")
	private String auth;
	@Value("${framework.kv.redis.timeout}")
	private int timeout;*/
	/**
	 * 连接池
	 */
	private JedisPool pool;

	private static ThreadLocal<Jedis> threadConns = new ThreadLocal<Jedis>();

	private static ThreadLocal<Integer> stackIdx = new ThreadLocal<Integer>();

	public void init() {
		JedisPoolConfig config = new JedisPoolConfig();
		// 设置最大连接数
		config.setMaxTotal(Integer.valueOf(maxTotal));
		// 设置最大阻塞时间，记住是毫秒数milliseconds
		config.setMaxWaitMillis(Long.valueOf(maxWaitMillis));
		// 设置空间连接
		config.setMaxIdle(Integer.valueOf(maxIdle));

		config.setTimeBetweenEvictionRunsMillis(60 * 1000);
		config.setTestWhileIdle(true);
		config.setMinEvictableIdleTimeMillis(1000 * 60 * 2);
		config.setNumTestsPerEvictionRun(-1);

		// 创建连接池
		pool = new JedisPool(config, host, Integer.valueOf(port));
	}

	/**
	 * 从链接池取连接
	 * 
	 * @return
	 */
	public Jedis getConnection() {
		Jedis result = threadConns.get();
		if (result == null) {
			result = pool.getResource();
			stackIdx.set(0);
			threadConns.set(result);
		} else {
			Integer intIdx = stackIdx.get();
			stackIdx.set(intIdx + 1);
		}
		return result;
	}

	/**
	 * 回收连接
	 * 
	 * @param conn
	 */
	public void recycle(Jedis conn) {
		Integer intIdx = stackIdx.get();
		if (intIdx == null) {
			intIdx = 0;
		}
		if (intIdx == 0) {
			threadConns.remove();
			pool.returnResourceObject(conn);
			stackIdx.remove();
		} else {
			stackIdx.set(intIdx - 1);
		}
	}
}
