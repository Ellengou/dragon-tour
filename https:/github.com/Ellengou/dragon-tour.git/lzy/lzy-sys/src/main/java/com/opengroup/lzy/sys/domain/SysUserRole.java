package com.opengroup.lzy.sys.domain;
/**
 * 角色
 * @author lc
 *
 * @date 2016年12月31日 下午4:16:22
 */

public class SysUserRole extends SysUserRoleKey {
    private static final long serialVersionUID = 1L;


    public SysUserRole() {}

    public SysUserRole(Integer userId, Integer roleId) {
        setUserId(userId);
        setRoleId(roleId);
    }


   
}