package com.opengroup.lzy.sys.domain;

import java.io.Serializable;

public class SysDic implements Serializable{
    private Integer id;

    private Integer pid;

    private String pidName;

    private String name;
    
    private String shortName;

    private String val;

    private String status;

    private Integer disorder;

    private String des;

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

    public String getPidName() {
        return pidName;
    }

    public void setPidName(String pidName) {
        this.pidName = pidName == null ? null : pidName.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val == null ? null : val.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public Integer getDisorder() {
        return disorder;
    }

    public void setDisorder(Integer disorder) {
        this.disorder = disorder;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des == null ? null : des.trim();
    }

	public String getShortName() {
		return shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
    
}