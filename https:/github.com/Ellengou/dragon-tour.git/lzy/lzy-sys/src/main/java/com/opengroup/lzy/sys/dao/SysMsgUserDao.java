package com.opengroup.lzy.sys.dao;

import com.opengroup.lzy.sys.domain.SysMsgUser;

public interface SysMsgUserDao {
    int deleteByPrimaryKey(Integer id);

    int insert(SysMsgUser record);

    int insertSelective(SysMsgUser record);

    SysMsgUser selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysMsgUser record);

    int updateByPrimaryKey(SysMsgUser record);
}