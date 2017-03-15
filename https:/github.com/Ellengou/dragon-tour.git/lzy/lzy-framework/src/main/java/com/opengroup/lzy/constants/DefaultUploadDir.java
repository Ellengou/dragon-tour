package com.opengroup.lzy.constants;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import com.opengroup.lzy.tools.OSinfo;

/**
 * 路径
 * 
 * @author lc
 *
 * @date 2017年1月15日 下午8:24:30
 */

public class DefaultUploadDir {
	private static String dir;// 默认路径
	public static final String ngServerPicDir = "pictures";
	private static Properties props = new Properties();
	private static final String systemPic = "sys/"; // 系统类型
	private static final String protocolPic = "protocol/"; // 协议类型

	static {

		try {
			props.load(Thread.currentThread().getContextClassLoader()
					.getResourceAsStream("default_upload_dir.properties"));
		} catch (FileNotFoundException e) {
			// TODO
			e.printStackTrace();
		} catch (IOException e) {
			// TODO
			e.printStackTrace();
		} catch (Exception e) {
			// TODO
			e.printStackTrace();
		}
		// 初始化值
		if (OSinfo.isWindows()) {
			dir = props.getProperty("dir_windows");
		} else if (OSinfo.isLinux()) {
			dir = props.getProperty("dir_linux");
		}
		File file = new File(dir);
		if (!file.exists() || !file.isDirectory()) {
			file.mkdirs();
			(new File(dir + systemPic)).mkdirs();
			(new File(dir + protocolPic)).mkdirs();
		}

	}

	public static String getProtocolPicUrl() {
		return dir + protocolPic;
	}

	// 获取系统图片路径
	public static String getSystemPicDir() {
		return dir + systemPic;
	}

	public static String getProtocolPicDir() {
		return dir + protocolPic;
	}

	public static final String sys_windows = "windows";
	public static final String sys_linux = "linux";
	public static final String web = "web";

	public static String getBaseUrl(String target, String place)
			throws Exception {
		if (sys_windows.equals(place)) {
			return target + "\\";
		} else if (sys_linux.equals(place)) {
			return target + "//";
		} else if (web.equals(place)) {
			return target + "//";
		} else {
			throw new Exception("没有此类目标");
		}
	}

	public static String getDir(String target) {
		return dir + ngServerPicDir + File.separator + target;
	}

	public static String getDir() {
		return dir;
	}

}
