package com.opengroup.lzy.sys.domain;

import java.util.Date;

/**
 * 消息模板
 * 
 * @author lc
 *
 * @date 2017年1月18日 下午5:23:29
 */
public class SysMsgTemplate {
	private Integer id;

	private String type;

	private String title;

	private String content;

	private String userType;

	private String groupId;

	private String mediaType;

	private Date gmtCreate;

	private Date gmtModified;

	private Integer oppUid;

	private String oppUser;

	private String channel;

	private String status;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type == null ? null : type.trim();
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title == null ? null : title.trim();
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content == null ? null : content.trim();
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType == null ? null : userType.trim();
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId == null ? null : groupId.trim();
	}

	public String getMediaType() {
		return mediaType;
	}

	public void setMediaType(String mediaType) {
		this.mediaType = mediaType == null ? null : mediaType.trim();
	}

	public Date getGmtCreate() {
		return gmtCreate;
	}

	public void setGmtCreate(Date gmtCreate) {
		this.gmtCreate = gmtCreate;
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

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel == null ? null : channel.trim();
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status == null ? null : status.trim();
	}
}