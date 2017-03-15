package com.opengroup.lzy.sys.domain;

import java.io.Serializable;
/**
 * 角色资源
 * @author lc
 *
 * @date 2016年12月31日 下午4:14:03
 */
public class SysRoleResource extends SysRoleResourceKey implements Serializable {
    private static final long serialVersionUID = 1L;

    public SysRoleResource() {}

    public SysRoleResource(Integer roleId, Integer resourceId) {
        setResourceId(resourceId);
        setRoleId(roleId);
    }
}