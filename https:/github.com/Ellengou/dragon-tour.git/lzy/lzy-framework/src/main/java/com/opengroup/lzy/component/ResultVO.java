package com.opengroup.lzy.component;

import com.opengroup.lzy.constants.AdminAjaxConstants;
import com.opengroup.lzy.exception.BaseException;


/**
 * 后台返回
 * 
 * @author lc
 *
 * @date 2017年1月1日 下午6:16:28
 */
public class ResultVO {
	private String status = JsonConstants.SUCCESS;
	private String code=AdminAjaxConstants.MSG_DEFAULT_SUC.getCode();
	private String msg = AdminAjaxConstants.MSG_DEFAULT_SUC.getDes();

	public ResultVO() {
	}

	public ResultVO(String status, String code,String msg) {
		this.status = status;
		this.msg = msg;
		this.code = code;
	}

	public void setError() {

	}

	
	public void setError(BaseException e) {
		Enum en=e.getEn();
		if(en instanceof AdminAjaxConstants){
			
			AdminAjaxConstants ac=(AdminAjaxConstants)en;
			this.setStatus(JsonConstants.FAILURE);
			this.setCode(ac.getCode());
			this.setMsg(ac.getDes());
		}else{
			setFail();
		}
		
		
	}
	/**
	 * 目前支持 AdminAjaxConstants
	 * 
	 * @param emun
	 */
	public void setError(Enum emun) {
		if (emun instanceof AdminAjaxConstants) {
			AdminAjaxConstants aac = (AdminAjaxConstants) emun;
			this.setMsg(aac.getDes());
			this.setStatus(JsonConstants.FAILURE);
			this.setCode(aac.getCode());
			
		}else{
			setFail();
		}

	}

	public void setFail() {
		this.setMsg(AdminAjaxConstants.MSG_DEFAULT_ERROR.getDes());
		this.setStatus(JsonConstants.FAILURE);
		this.setCode(AdminAjaxConstants.MSG_DEFAULT_ERROR.getCode());
	}
	public void setFail(String msg) {
		this.setMsg(msg);
		this.setStatus(JsonConstants.FAILURE);
		this.setCode(AdminAjaxConstants.MSG_DEFAULT_ERROR.getCode());
		
	}

	// ====================================setter and getter==============================================
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

}
