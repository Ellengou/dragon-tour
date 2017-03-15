package com.opengroup.lzy.sys.service.impl;

import com.opengroup.lzy.sys.dao.SysRoleResourceDao;
import com.opengroup.lzy.sys.domain.SysRoleResource;
import com.opengroup.lzy.sys.service.SysRoleResourceService;
import com.opengroup.lzy.sys.service.UserRealm;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.mgt.RealmSecurityManager;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by violorch on 2016/4/20.
 */
@Service
@Transactional(readOnly = true)
public class SysRoleResourceServiceImpl implements SysRoleResourceService {

    @Resource
    private SysRoleResourceDao sysRoleResourceDao;

    @Override
    public List<Integer> getResourceIds(Integer roleId) {
        return sysRoleResourceDao.selectByRoleId(roleId);
    }

    @Override
    @Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void updateRoleResource(Integer id, List<Integer> oldList, List<Integer> newList) {
        //是否删除
        for (int i = 0, j = oldList.size(); i < j; i ++) {
            if (!newList.contains(oldList.get(i))) {
                sysRoleResourceDao.delete(new SysRoleResource(id, oldList.get(i)));
            }
        }

        //是否添加
        for(int i = 0, j = newList.size(); i < j; i++){
            if(!oldList.contains(newList.get(i))){
                sysRoleResourceDao.insertSelective(new SysRoleResource(id, newList.get(i)));
            }
        }
    }

    @Override
    public void clearUserRecCache(PrincipalCollection pc) {
        RealmSecurityManager securityManager =  (RealmSecurityManager) SecurityUtils.getSecurityManager();
        UserRealm userRealm = (UserRealm) securityManager.getRealms().iterator().next();
        userRealm.clearCachedAuthorizationInfo(pc);
    }

}
