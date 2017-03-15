package com.opengroup.lzy.tools.kv.detail;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import com.alibaba.fastjson.JSON;
import com.opengroup.lzy.exception.WaitTimeoutException;
import redis.clients.jedis.Jedis;

/**
 * Redis的实现类
 * 
 * @author lc
 *
 * @date 2017年1月12日 下午2:06:18
 */
public class RedisClientImpl implements CommonClient {

	@Resource
	private RedisConnPool redisConnPool;

	@Override
	public <V> void save(String key, V value, int expiredSeconds) {
		Jedis jedis = null;
		try {
			jedis = redisConnPool.getConnection();
			jedis.set(key, JSON.toJSONString(value));
			jedis.expire(key, expiredSeconds);
		} finally {
			if (jedis != null)
				redisConnPool.recycle(jedis);
		}
	}

	@Override
	public <V> V read(String key, Class<V> c) {
		Jedis jedis = null;
		try {
			jedis = redisConnPool.getConnection();
			String value = jedis.get(key);
			if (!StringUtils.isBlank(value)) {
				return JSON.parseObject(value, c);
			}
			return null;
		} finally {
			if (jedis != null)
				redisConnPool.recycle(jedis);
		}
	}

	@Override
	public void delete(String key) {
		Jedis jedis = null;
		try {
			jedis = redisConnPool.getConnection();
			jedis.del(key);
		} finally {
			if (jedis != null)
				redisConnPool.recycle(jedis);
		}
	}

	@Override
	public <T> T lock(String key, DistributeLockProcessor<T> processor,
			int waitTimeMillis) throws Exception {
		Jedis jedis = redisConnPool.getConnection();
		long beatHeartTime = 1000;
		long sleepTime = 0;
		long leftTime = waitTimeMillis;
		try {
			for (int i = 0; i <= waitTimeMillis; i += sleepTime) {
				long result = jedis.setnx(key, "");
				if (result == 1) {
					//业务处理
					return processor.process();
				} else {
					leftTime = waitTimeMillis - i;
					if (leftTime > beatHeartTime) {
						sleepTime = beatHeartTime;
					} else {
						sleepTime = leftTime;
					}
					if (sleepTime <= 0)
						break;
					Thread.sleep(sleepTime);
				}
			}
			throw new WaitTimeoutException("等待分布式锁超时[" + waitTimeMillis + "]");
		} finally {
			try {
				jedis.del(key);
			} finally {
				redisConnPool.recycle(jedis);
			}
		}
	}

	public <T> void add2List(String key, T... list) {
		if (list != null && list.length > 0) {
			Jedis jedis = redisConnPool.getConnection();
			try {
				String[] listString = new String[list.length];
				for (int i = 0; i < list.length; i++) {
					T t = list[i];
					if (t instanceof String) {
						listString[i] = (String) t;
					} else {
						listString[i] = JSON.toJSONString(t);
					}
				}
				jedis.rpush(key, listString);
			} finally {
				redisConnPool.recycle(jedis);
			}
		}
	}

	public <V> List<V> readAndDelList(String key, Class<V> c) {
		Jedis jedis = redisConnPool.getConnection();
		try {
			List<String> list = jedis.lrange(key, 0, -1);
			if (list != null && list.size() > 0) {
				List<V> result = new ArrayList<V>();
				for (String str : list) {
					V value = JSON.parseObject(str, c);
					result.add(value);
				}
				return result;
			}
		} finally {
			try {
				jedis.del(key);
			} finally {
				redisConnPool.recycle(jedis);
			}
		}
		return null;
	}

	@Override
	public <V> List<V> readList(String key, Class<V> c) {
		Jedis jedis = redisConnPool.getConnection();
		try {
			List<String> list = jedis.lrange(key, 0, -1);

			if (list != null && list.size() > 0) {
				List<V> result = new ArrayList<V>();
				for (String str : list) {
					if (c == String.class) {
						result.add(c.cast(str));
					} else {
						V value = JSON.parseObject(str, c);
						result.add(value);
					}
				}
				return result;
			}
		} finally {
			redisConnPool.recycle(jedis);
		}
		return null;
	}



	@Override
	public <T> void add2Set(String key, T... set) {
		if (set == null || set.length == 0)
			return;
		Jedis jedis = redisConnPool.getConnection();
		try {
			for (T t : set) {
				if (t instanceof String) {
					jedis.sadd(key, (String) t);
				} else {
					jedis.sadd(key, JSON.toJSONString(t));
				}
			}
		} finally {
			redisConnPool.recycle(jedis);
		}
	}

	@Override
	public <V> Set<V> readSet(String key, Class<V> c) {
		Jedis jedis = redisConnPool.getConnection();
		try {
			Set<String> values = jedis.smembers(key);
			if (values != null && values.size() > 0) {
				Set<V> result = new HashSet<V>();
				for (String s : values) {
					if (c == String.class) {
						result.add(c.cast(s));
					} else {
						result.add(JSON.parseObject(s, c));
					}
				}
				return result;
			}
			return null;
		} finally {
			redisConnPool.recycle(jedis);
		}
	}

	@Override
	public <V> Set<V> readAndDelSet(String key, Class<V> c) {
		Jedis jedis = redisConnPool.getConnection();
		try {
			Set<String> values = jedis.smembers(key);
			if (values != null && values.size() > 0) {
				Set<V> result = new HashSet<V>();
				for (String s : values) {
					result.add(JSON.parseObject(s, c));
				}
				return result;
			}
			return null;
		} finally {
			try {
				jedis.del(key);
			} finally {
				redisConnPool.recycle(jedis);
			}
		}
	}

	public <V> void delSetItems(String key, V... vals) {
		Jedis jedis = redisConnPool.getConnection();
		try {
			String[] members = new String[vals.length];
			for (int i = 0; i < vals.length; i++) {
				members[i] = JSON.toJSONString(vals[i]);
			}
			jedis.srem(key, members);
		} finally {
			redisConnPool.recycle(jedis);
		}
	}

}
