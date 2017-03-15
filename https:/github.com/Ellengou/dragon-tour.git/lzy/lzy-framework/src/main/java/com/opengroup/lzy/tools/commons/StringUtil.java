package com.opengroup.lzy.tools.commons;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;


/**
 * 字符串工具类
 * 
 * @author lc
 *
 * @date 2017年1月10日 下午4:54:41
 */
public class StringUtil {

	/**
	 * 替换模板里面的参数
	 *
	 * @param smt
	 * @param params
	 * @return 替换完成的内容
	 */
	@SuppressWarnings("unused")
	public static String replaceParams(String str, Map<String, String> params) {
		if (StringUtils.isBlank(str))
			return null;
		if (null == params || params.size() == 0)
			return str;// 说明不需要替换，只是一个类似于集体推送的消息
		for (String key : params.keySet()) {
			str = str.replace("#{" + key + "}", params.get(key));
		}
		return str;
	}

}
