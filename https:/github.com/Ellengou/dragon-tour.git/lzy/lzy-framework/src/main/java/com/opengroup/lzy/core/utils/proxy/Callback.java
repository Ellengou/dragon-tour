package com.opengroup.lzy.core.utils.proxy;

import org.apache.http.HttpResponse;


/**
 * Created by Jintao on 2015/12/7.
 */
public interface Callback<T> {
    T execute(HttpResponse response, String charset) throws Exception;
}
