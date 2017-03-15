package com.opengroup.lzy.sys.dao;

import com.opengroup.lzy.sys.domain.SysMsgBody;

public interface SysMsgBodyDao {
    int deleteByPrimaryKey(Integer id);

    int insert(SysMsgBody record);

    int insertSelective(SysMsgBody record);

    SysMsgBody selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysMsgBody record);

    int updateByPrimaryKey(SysMsgBody record);
}