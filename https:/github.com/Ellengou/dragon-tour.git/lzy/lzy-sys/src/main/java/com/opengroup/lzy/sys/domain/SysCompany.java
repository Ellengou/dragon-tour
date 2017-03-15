package com.opengroup.lzy.sys.domain;

import java.io.Serializable;
import java.util.Date;

public class SysCompany implements Serializable{
    private static final long serialVersionUID = 1L;
    private Integer id;

    private Integer pid;

    private Integer level;

    private String compPk;

    private String compCode;

    private String compSignName;

    private String compShortName;

    private String compName;

    private String contPerson;

    private String contPhone;

    private String contTel;

    private String contPosition;

    private String compTel;

    private String compAddress;

    private String lealPerson;

    private Date registerTime;

    private String compEmail;

    private String registerName;

    private String compPwd;

    private String compTrade;

    private String compFax;

    private String enabled;

    private String ischeck;

    private String contPerson1;

    private String contPhone1;

    private String contTel1;

    private String position1;

    private Date createTime;

    private String remark;

    private String salt;

    private Integer compCoreId;

    private String type;
    
    private String compno;
    
    private String creditCode;
    
    private String source;

    private Boolean checkByRegion;
    
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

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getCompPk() {
        return compPk;
    }

    public void setCompPk(String compPk) {
        this.compPk = compPk;
    }

    public String getCompCode() {
        return compCode;
    }

    public void setCompCode(String compCode) {
        this.compCode = compCode;
    }

    public String getCompSignName() {
        return compSignName;
    }

    public void setCompSignName(String compSignName) {
        this.compSignName = compSignName;
    }

    public String getCompShortName() {
        return compShortName;
    }

    public void setCompShortName(String compShortName) {
        this.compShortName = compShortName;
    }

    public String getCompName() {
        return compName;
    }

    public void setCompName(String compName) {
        this.compName = compName == null ? null : compName.trim();
    }

    public String getContPerson() {
        return contPerson;
    }

    public void setContPerson(String contPerson) {
        this.contPerson = contPerson == null ? null : contPerson.trim();
    }

    public String getContPhone() {
        return contPhone;
    }

    public void setContPhone(String contPhone) {
        this.contPhone = contPhone == null ? null : contPhone.trim();
    }

    public String getContTel() {
        return contTel;
    }

    public void setContTel(String contTel) {
        this.contTel = contTel == null ? null : contTel.trim();
    }

    public String getContPosition() {
        return contPosition;
    }

    public void setContPosition(String contPosition) {
        this.contPosition = contPosition == null ? null : contPosition.trim();
    }

    public String getCompTel() {
        return compTel;
    }

    public void setCompTel(String compTel) {
        this.compTel = compTel == null ? null : compTel.trim();
    }

    public String getCompAddress() {
        return compAddress;
    }

    public void setCompAddress(String compAddress) {
        this.compAddress = compAddress == null ? null : compAddress.trim();
    }

    public String getLealPerson() {
        return lealPerson;
    }

    public void setLealPerson(String lealPerson) {
        this.lealPerson = lealPerson == null ? null : lealPerson.trim();
    }

    public Date getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }

    public String getCompEmail() {
        return compEmail;
    }

    public void setCompEmail(String compEmail) {
        this.compEmail = compEmail == null ? null : compEmail.trim();
    }

    public String getRegisterName() {
        return registerName;
    }

    public void setRegisterName(String registerName) {
        this.registerName = registerName == null ? null : registerName.trim();
    }

    public String getCompPwd() {
        return compPwd;
    }

    public void setCompPwd(String compPwd) {
        this.compPwd = compPwd == null ? null : compPwd.trim();
    }

    public String getCompTrade() {
        return compTrade;
    }

    public void setCompTrade(String compTrade) {
        this.compTrade = compTrade;
    }

    public String getCompFax() {
        return compFax;
    }

    public void setCompFax(String compFax) {
        this.compFax = compFax == null ? null : compFax.trim();
    }

    public String getEnabled() {
        return enabled;
    }

    public void setEnabled(String enabled) {
        this.enabled = enabled == null ? null : enabled.trim();
    }

    public String getIscheck() {
        return ischeck;
    }

    public void setIscheck(String ischeck) {
        this.ischeck = ischeck == null ? null : ischeck.trim();
    }

    public String getContPerson1() {
        return contPerson1;
    }

    public void setContPerson1(String contPerson1) {
        this.contPerson1 = contPerson1 == null ? null : contPerson1.trim();
    }

    public String getContPhone1() {
        return contPhone1;
    }

    public void setContPhone1(String contPhone1) {
        this.contPhone1 = contPhone1 == null ? null : contPhone1.trim();
    }

    public String getContTel1() {
        return contTel1;
    }

    public void setContTel1(String contTel1) {
        this.contTel1 = contTel1 == null ? null : contTel1.trim();
    }

    public String getPosition1() {
        return position1;
    }

    public void setPosition1(String position1) {
        this.position1 = position1 == null ? null : position1.trim();
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

	public Integer getCompCoreId() {
		return compCoreId;
	}

	public void setCompCoreId(Integer compCoreId) {
		this.compCoreId = compCoreId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCompno() {
		return compno;
	}

	public void setCompno(String compno) {
		this.compno = compno;
	}

	public String getCreditCode() {
		return creditCode;
	}

	public void setCreditCode(String creditCode) {
		this.creditCode = creditCode;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

    public Boolean getCheckByRegion() {
        return checkByRegion;
    }

    public void setCheckByRegion(Boolean checkByRegion) {
        this.checkByRegion = checkByRegion;
    }
}