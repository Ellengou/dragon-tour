package com.opengroup.lzy.sys.domain;


import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;


public class SysRole implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer id;

    private Integer compCoreId;

    private Integer companyId;

    private Long orgId;

    @NotEmpty(message = "角色名称不能为空")
    private String rlname;

    private Integer userId;

    private Date operateTime;

    @NotNull(message = "请选择当前角色状态")
    private Integer status;

    @NotEmpty(message = "角色描述不能为空")
    private String memo;

    private Integer checked ;

    public SysRole() {
        this.status = 1;    // 启用
        this.checked = 0;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCompCoreId() {
        return compCoreId;
    }

    public void setCompCoreId(Integer compCoreId) {
        this.compCoreId = compCoreId;
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public Long getOrgId() {
        return orgId;
    }

    public void setOrgId(Long orgId) {
        this.orgId = orgId;
    }

    public String getRlname() {
        return rlname;
    }

    public void setRlname(String rlname) {
        this.rlname = rlname;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public Integer getChecked() {
        return checked;
    }

    public void setChecked(Integer checked) {
        this.checked = checked;
    }
}