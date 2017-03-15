package com.opengroup.lzy.sys.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 菜单资源
 * 
 * @author lc
 *
 * @date 2016年12月31日 下午4:03:04
 */

public class SysResource implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id;

	private Integer pid;

	private String name;

	private String url;

	private Date operateTime;

	private Integer disorder = 0;

	private String remark;

	private String code;

	private Integer status = 0; // 停用

	private Integer type = 2; // 按钮

	private String dataType;

	private Integer rank;

	private List<SysResource> children;

	public SysResource() {
	}

	public SysResource(Integer pid, String name, Date operateTime, String code,
			Integer status, Integer type) {
		this.pid = pid;
		this.name = name;
		this.operateTime = operateTime;
		this.code = code;
		this.status = status;
		this.type = type;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url == null ? null : url.trim();
	}

	public Date getOperateTime() {
		return operateTime;
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}

	public Integer getDisorder() {
		return disorder;
	}

	public void setDisorder(Integer disorder) {
		this.disorder = disorder;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark == null ? null : remark.trim();
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public List<SysResource> getChildren() {
		return children;
	}

	public void setChildren(List<SysResource> children) {
		this.children = children;
	}

	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	public Integer getRank() {
		return rank;
	}

	public void setRank(Integer rank) {
		this.rank = rank;
	}
}