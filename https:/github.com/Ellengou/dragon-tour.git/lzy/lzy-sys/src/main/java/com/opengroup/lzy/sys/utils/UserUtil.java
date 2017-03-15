package com.opengroup.lzy.sys.utils;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;

import com.opengroup.lzy.sys.constants.Constants;
import com.opengroup.lzy.sys.domain.SysUserAdmin;
import com.opengroup.lzy.sys.service.UserRealm;

import java.util.Random;

public class UserUtil {
	/**
	 * 获取当前用户对象shiro
	 * @return shirouser
	 */
	public static UserRealm.ShiroUser getCurrentShiroUser(){
		UserRealm.ShiroUser user = (UserRealm.ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return user;
	}
	
	/**
	 * 获取当前用户session
	 * @return session
	 */
	public static Session getSession(){
		Session session = SecurityUtils.getSubject().getSession();
		return session;
	}
	
	/**
	 * 获取当前用户httpsession
	 * @return httpsession
	 */
	public static Session getHttpSession(){
		Session session = SecurityUtils.getSubject().getSession();
		return session;
	}
	
	/**
	 * 获取当前用户对象
	 * @return user
	 */
	public static SysUserAdmin getCurrentUser(){
		Session session = null;
		try {
			session = SecurityUtils.getSubject().getSession();
		} catch (Exception e) {
			return null;
		}
		return (SysUserAdmin) session.getAttribute(Constants.SYS_USER);
	}

	/**
	 * 获取随机用户名
	 * @return user
	 */
	public static String getRandomString(int length) { //length表示生成字符串的长度
		String base = "abcdefghijklmnopqrstuvwxyz0123456789";
		Random random = new Random();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			int number = random.nextInt(base.length());
			sb.append(base.charAt(number));
		}
		return sb.toString();
	}
}
 