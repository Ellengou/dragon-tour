package com.opengroup.lzy.constants;

/**
 * 用户端提示
 * 
 * @author lc
 *
 * @date 2017年1月1日 下午6:03:38
 */
public enum UserAjaxConstants {
	            // 常规
	           MSG_DEFAULT_SUC("0000","操作成功"),
	           MSG_DEFAULT_ERROR("1000","系统异常"),
	           //验证码类
	          MSG_CODE_NOT("0010","验证码不存在"),
	          MSG_CODE_ERROR("0020","验证码错误"),
	          MSG_CODE_USE("0030","验证码已激活"),
	          MSG_CODE_NOTDATE("0040","验证码已过期"),
	          MSG_NODE_NOT("0050","该类型的节点不存在")
	          ;
	    private String code;

		private String des;
		
		private UserAjaxConstants(String code, String des) {
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
