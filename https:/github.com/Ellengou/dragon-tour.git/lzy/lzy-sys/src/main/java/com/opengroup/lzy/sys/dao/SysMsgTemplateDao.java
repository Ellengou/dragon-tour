package com.opengroup.lzy.sys.dao;

import com.opengroup.lzy.sys.domain.SysMsgTemplate;

public interface SysMsgTemplateDao {
    int deleteByPrimaryKey(Integer id);

    int insert(SysMsgTemplate record);

    int insertSelective(SysMsgTemplate record);

    SysMsgTemplate selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysMsgTemplate record);

    int updateByPrimaryKey(SysMsgTemplate record);
}