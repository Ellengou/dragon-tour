package com.opengroup.lzy.tools;

/**
 * 操作系统类： 获取 
 * System.getProperty("os.name")对应的操作系统
 * 
 * @author lc
 *
 * @date 2017年1月2日 下午2:19:04
 */
public class OSinfo {

	private static String OS = System.getProperty("os.name").toLowerCase();

	private OSinfo() {
	}

	public static boolean isLinux() {
		return OS.indexOf("linux") >= 0;
	}

	public static boolean isMacOS() {
		return OS.indexOf("mac") >= 0 && OS.indexOf("os") > 0
				&& OS.indexOf("x") < 0;
	}

	public static boolean isMacOSX() {
		return OS.indexOf("mac") >= 0 && OS.indexOf("os") > 0
				&& OS.indexOf("x") > 0;
	}

	public static boolean isWindows() {
		return OS.indexOf("windows") >= 0;
	}

	public static boolean isOS2() {
		return OS.indexOf("os/2") >= 0;
	}

	public static boolean isSolaris() {
		return OS.indexOf("solaris") >= 0;
	}

	public static boolean isSunOS() {
		return OS.indexOf("sunos") >= 0;
	}

	public static boolean isMPEiX() {
		return OS.indexOf("mpe/ix") >= 0;
	}

	public static boolean isHPUX() {
		return OS.indexOf("hp-ux") >= 0;
	}

	public static boolean isAix() {
		return OS.indexOf("aix") >= 0;
	}

	public static boolean isOS390() {
		return OS.indexOf("os/390") >= 0;
	}

	public static boolean isFreeBSD() {
		return OS.indexOf("freebsd") >= 0;
	}

	public static boolean isIrix() {
		return OS.indexOf("irix") >= 0;
	}

	public static boolean isDigitalUnix() {
		return OS.indexOf("digital") >= 0 && OS.indexOf("unix") > 0;
	}

	public static boolean isNetWare() {
		return OS.indexOf("netware") >= 0;
	}

	public static boolean isOSF1() {
		return OS.indexOf("osf1") >= 0;
	}

	public static boolean isOpenVMS() {
		return OS.indexOf("openvms") >= 0;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println(OSinfo.isLinux());
	}

}