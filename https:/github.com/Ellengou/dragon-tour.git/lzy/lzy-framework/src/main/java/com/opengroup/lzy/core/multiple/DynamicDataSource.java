package com.opengroup.lzy.core.multiple;

/**
 * 获取数据源
 * Created by ELLEN on 16/8/23.
 */

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

public class DynamicDataSource extends AbstractRoutingDataSource {
    @Override
    protected Object determineCurrentLookupKey() {
        return DataSourceHolder.getDataSource();
    }
}