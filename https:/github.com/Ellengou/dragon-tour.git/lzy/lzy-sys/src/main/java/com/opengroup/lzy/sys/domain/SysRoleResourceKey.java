package com.opengroup.lzy.sys.domain;

import java.io.Serializable;
/**
 * 角色资源
 * @author lc
 *
 * @date 2016年12月31日 下午4:14:41
 */

public class SysRoleResourceKey implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer roleId;

    private Integer resourceId;

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Integer getResourceId() {
        return resourceId;
    }

    public void setResourceId(Integer resourceId) {
        this.resourceId = resourceId;
    }
}