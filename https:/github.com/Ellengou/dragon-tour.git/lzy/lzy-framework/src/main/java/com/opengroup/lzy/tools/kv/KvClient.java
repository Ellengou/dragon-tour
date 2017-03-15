package com.opengroup.lzy.tools.kv;

import java.util.List;
import java.util.Set;

import com.opengroup.lzy.tools.kv.detail.CommonClient;
import com.opengroup.lzy.tools.kv.detail.DistributeLockProcessor;

/**
 * KV类工具缩合操作类
 * 
 * @author lc
 *
 * @date 2017年1月12日 下午2:03:02
 */
public class KvClient {

    /**
     * 类型的实现池子
     */
    private CommonClient commonClient;

    /**
     * 保存
     * 
     * @param key
     * @param value
     * @param expired
     */
    public <V> void save(String key, V value, int expiredSeconds) {
        commonClient.save(key, value, expiredSeconds);
    }

    /**
     * 读取
     * 
     * @param key
     * @param c
     * @return
     */
    public <V> V read(String key, Class<V> c) {
        return commonClient.read(key, c);
    }

    /**
     * 删除
     * 
     * @param key
     */
    public void delete(String key) {
        commonClient.delete(key);
    }

    /**
     * 取得分布式锁并执行
     * 
     * @param key
     * @param processor
     * @param waitTimeMillis
     * @return
     * @throws Exception
     */
    public <T> T lockForProcess(String key, int waitTimeMillis, DistributeLockProcessor<T> processor)
                                                                                                     throws Exception {
        return commonClient.lock(key, processor, waitTimeMillis);
    }

    /**
     * 把一个列表添加到尾部
     * 
     * @param key
     * @param list
     */
    public <T> void add2List(String key, T... list) {
        commonClient.add2List(key, list);
    }

    /**
     * 把一个数组添加到set
     * 
     * @param key
     * @param set
     */
    public <T> void add2Set(String key, T... set) {
        commonClient.add2Set(key, set);
    }

    /**
     * 把一个列表添加到尾部
     * 
     * @param key
     * @param list
     */
    public <T> void add2List(String key, List<T> list) {
        commonClient.add2List(key, list.toArray());
    }

    /**
     * 读取并删除一个list
     * 
     * @param key
     * @param c
     * @return
     */
    public <T> List<T> readAndDelList(String key, Class<T> c) {
        return commonClient.readAndDelList(key, c);
    }

    /**
     * 读取一个列表
     * 
     * @param key
     * @param c
     * @return
     */
    public <T> List<T> readList(String key, Class<T> c) {
        return commonClient.readList(key, c);
    }

    /**
     * 读取一个set
     * 
     * @param key
     * @param c
     * @return
     */
    public <T> Set<T> readSet(String key, Class<T> c) {
        return commonClient.readSet(key, c);
    }

    /**
     * 读取并删除一个set
     * 
     * @param key
     * @param c
     * @return
     */
    public <T> Set<T> readAndDelSet(String key, Class<T> c) {
        return commonClient.readAndDelSet(key, c);
    }

    /**
     * 删除一个set中的一个元素
     * 
     * @param key
     * @param vals
     */
    public <V> void delSetItems(String key, V... vals) {
        commonClient.delSetItems(key, vals);
    }

    public void setCommonClient(CommonClient commonClient) {
        this.commonClient = commonClient;
    }

}
