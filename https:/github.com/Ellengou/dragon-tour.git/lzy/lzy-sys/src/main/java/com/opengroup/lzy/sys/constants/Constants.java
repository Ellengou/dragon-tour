package com.opengroup.lzy.sys.constants;

/**
 * 常规字符串d
 * 
 * @author lc
 *
 * @date 2016年12月31日 下午4:55:521
 */

public class Constants {
	public static final Integer RESOURCE_ADMIN_MENU = 0; // 后台菜单
	public static final Integer RESOURCE_FRONT_MENU = 1; // 前台菜单
	public static final Integer RESOURCE_BUTTON = 2; // 后台按钮

	public static final Integer RANDOM_LOGIN_NAME_LENGTH = 8; // 随机数字

	public static final Integer USER_ACCOUNT_COMMON = 0; // 正常
	public static final Integer USER_ACCOUNT_LOGIN_LOCKED = 1; // 登陆锁定
	public static final Integer USER_ACCOUNT_SYSTEM_LOCKED = 2; // 系统锁定

	public static final String USER_ACCOUNT_COMPANY_UNLOCKED = "0"; // 核心企业不锁定
	public static final String USER_ACCOUNT_COMPANY_LOCKED = "1"; // 核心企业锁定

	public static final Integer RESOURCE_STATUS_DISABLE = 0; // 停用
	public static final Integer RESOURCE_STATUS_ABLE = 1; // 启用

	public static final String SUCCESS = "ok";
	public static final String FAILURE = "fail";

	public static final String SYS_USER = "sys_user";
	public static final String SYS_USER_MESSAGE_COUNT = "sys_user_message_count";
	public static final String WEBSOCKET_ADMIN = "websocket_account";
	public static final String SYS_USER_ADMIN = "2"; // 超管用户 : sex:2
	public static final int SYS_PERMISSION_ADMIN = 3; // 超管权限 : status:3

	public static final String WEB_PAGE_NO = "begin";
	public static final String WEB_PAGE_SIZE = "rows";
	public static final String WEB_ORDER = "order";
	public static final String WEB_ORDER_BY = "orderBy";
	/**
	 * 资源级别
	 */

	public static final String USER_DATA_TYPE_PLAT = "0"; // 平台级别
	public static final String USER_DATA_TYPE_CORE = "1"; // 核心企业
	public static final String USER_DATA_TYPE_THIRD = "2"; // 第三方机构
	public static final String USER_DATA_TYPE_SUBCOM = "3"; // 子公司
	public static final String USER_DATA_TYPE_POSIT = "4"; // 部门
	public static final String USER_DATA_TYPE_OTHER = "5"; // 其他

}
