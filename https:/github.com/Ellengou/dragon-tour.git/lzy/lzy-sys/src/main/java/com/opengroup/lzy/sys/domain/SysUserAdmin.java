package com.opengroup.lzy.sys.domain;

import org.hibernate.validator.constraints.NotEmpty;
import java.io.Serializable;
import java.util.Date;

/**
 * 后台用户
 * @author lc
 *
 * @date 2016年12月31日 下午4:16:01
 */

public class SysUserAdmin  implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;

	private Integer compCoreId;

	private Integer companyId;

	private Long orgId;

	private Long employeeId;

	@NotEmpty(message = "登录名不能为空")
	// @LoginName(message = "登录名由字母，数字，下划线组成，字母区分大小写")
	private String loginName;

	private String aliasName;

	private String password;

	private String realName;

	private String sex;

	private String email;

	private String phone;

	private String dataType;

	private Integer userId;

	private Date createTime;

	private String remark;

	private String salt;

	private String companyLock;

	private Integer state;

	private Integer loginCount;

	private Date previousVisit;

	private Date lastVisit;

	private Integer errorcount;

	private String ipccUname;

	public SysUserAdmin() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public Long getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(Long employeeId) {
		this.employeeId = employeeId;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName == null ? null : loginName.trim();
	}

	public String getAliasName() {
		return aliasName;
	}

	public void setAliasName(String aliasName) {
		this.aliasName = aliasName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password == null ? null : password.trim();
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark == null ? null : remark.trim();
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt == null ? null : salt.trim();
	}

	public String getCompanyLock() {
		return companyLock;
	}

	public void setCompanyLock(String companyLock) {
		this.companyLock = companyLock;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getLoginCount() {
		return loginCount;
	}

	public void setLoginCount(Integer loginCount) {
		this.loginCount = loginCount;
	}

	public Integer getErrorcount() {
		return errorcount;
	}

	public void setErrorcount(Integer errorcount) {
		this.errorcount = errorcount;
	}

	public Date getPreviousVisit() {
		return previousVisit;
	}

	public void setPreviousVisit(Date previousVisit) {
		this.previousVisit = previousVisit;
	}

	public Date getLastVisit() {
		return lastVisit;
	}

	public void setLastVisit(Date lastVisit) {
		this.lastVisit = lastVisit;
	}

	public String getCredentialsSalt() {
		return loginName + salt;
	}

	public Integer getCompCoreId() {
		return compCoreId;
	}

	public void setCompCoreId(Integer compCoreId) {
		this.compCoreId = compCoreId;
	}

	public Long getOrgId() {
		return orgId;
	}

	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getIpccUname() {
		return ipccUname;
	}

	public void setIpccUname(String ipccUname) {
		this.ipccUname = ipccUname;
	}
}
