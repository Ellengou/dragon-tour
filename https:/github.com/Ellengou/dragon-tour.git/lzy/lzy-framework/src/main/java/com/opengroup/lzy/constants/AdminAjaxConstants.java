package com.opengroup.lzy.constants;

/**
 * 管理端提示
 * 
 * @author lc
 *
 * @date 2017年1月1日 下午6:03:38
 */
public enum AdminAjaxConstants {
	// 常规
	MSG_DEFAULT_SUC("0000", "操作成功"),
	MSG_DEFAULT_ERROR("1000", "系统异常"),

	//后台用户类
	MSG_LOGIN_ERROR("0010", "系登录名只能为字母，数字，下划线， 字母区分大小写异常"),
	MSG_USER_EXIST("0011","当前登录名已存在"),
	MSG_USER_STATUS("0012","请选择用户状态"),
	MSG_USER_NOTDELETE("0013","超级管理员用户不可删除"),
	MSG_USER_NOTNULL("0014","登录名不能为空"),
	MSG_USER_NOCHANGE("0015","超级管理员权限不可变更"),
	MSG_ROLE_EXIST("0016","当前角色名已经存在"),
	//资源类
	MSG_RESOURCE_STATUS("0020","请选择资源状态"),
	MSG_RESOURCE_CODE_NOTNULL("0021","资源编码不能为空"),
	MSG_RESOURCE_NAME_NOTNULL("0022","资源名称不能为空"),
	//菜单类
	MSG_MENU_STATUS("0030","请选择菜单状态"),
	MSG_MENU_ULR_NOTNULL("0031","菜单URL不能为空"),
	MSG_MENU_NAME_NOTNULL("0032","菜单名称不能为空"),
	MSG_MENU_SON_USE("0033","仍有启用中的子菜单，当前菜单不能停用"),
	MSG_MENU_FATHER_STOP("0033","当前菜单的父级菜单停用中，请先启用父菜单"),
	//图片
	MSG_PIC_STATUS("0040","请先解除与该类型关联的图片,再操作");
	
	
	
	
	
	
	
	
	

	//
	private String code;

	private String des;

	private AdminAjaxConstants(String code, String des) {
		this.code = code;
		this.des = des;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}
}
