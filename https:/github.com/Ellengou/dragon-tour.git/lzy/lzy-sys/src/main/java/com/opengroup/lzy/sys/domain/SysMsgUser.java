package com.opengroup.lzy.sys.domain;

/**
 * 用户消息表
 * 
 * @author lc
 *
 * @date 2017年1月18日 下午5:24:02
 */
public class SysMsgUser {
	private Integer id;

	private Integer frontUserId;

	private Integer msgBodyId;

	private String content;

	private String isRead;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getFrontUserId() {
		return frontUserId;
	}

	public void setFrontUserId(Integer frontUserId) {
		this.frontUserId = frontUserId;
	}

	public Integer getMsgBodyId() {
		return msgBodyId;
	}

	public void setMsgBodyId(Integer msgBodyId) {
		this.msgBodyId = msgBodyId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content == null ? null : content.trim();
	}

	public String getIsRead() {
		return isRead;
	}

	public void setIsRead(String isRead) {
		this.isRead = isRead == null ? null : isRead.trim();
	}
}