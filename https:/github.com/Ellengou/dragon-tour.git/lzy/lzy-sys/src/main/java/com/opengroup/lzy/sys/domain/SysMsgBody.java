package com.opengroup.lzy.sys.domain;

import java.util.Date;

/**
 * 消息体(目前只支持系统级别的消息)
 * 
 * @author lc
 *
 * @date 2017年1月18日 下午5:23:16
 */
public class SysMsgBody {
	private Integer id;

	private Integer templateId;

	private String deleted;

	private Date gmtSend;

	private Date gmtModified;

	private Integer oppUid;

	private String oppUser;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getTemplateId() {
		return templateId;
	}

	public void setTemplateId(Integer templateId) {
		this.templateId = templateId;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted == null ? null : deleted.trim();
	}

	public Date getGmtSend() {
		return gmtSend;
	}

	public void setGmtSend(Date gmtSend) {
		this.gmtSend = gmtSend;
	}

	public Date getGmtModified() {
		return gmtModified;
	}

	public void setGmtModified(Date gmtModified) {
		this.gmtModified = gmtModified;
	}

	public Integer getOppUid() {
		return oppUid;
	}

	public void setOppUid(Integer oppUid) {
		this.oppUid = oppUid;
	}

	public String getOppUser() {
		return oppUser;
	}

	public void setOppUser(String oppUser) {
		this.oppUser = oppUser == null ? null : oppUser.trim();
	}
}