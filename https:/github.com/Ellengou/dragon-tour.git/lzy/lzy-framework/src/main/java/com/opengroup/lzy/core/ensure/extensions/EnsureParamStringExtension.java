package com.opengroup.lzy.core.ensure.extensions;


import com.opengroup.lzy.core.ensure.EnsureParam;
import com.opengroup.lzy.core.exceptions.XExceptionFactory;
import com.opengroup.lzy.core.utils.StringUtil;

/**
 * Created by ELLEN on 2015/10/15.
 */
public class EnsureParamStringExtension extends EnsureParam<Object> {
    private String string;

    public EnsureParamStringExtension(String string) {
        super(string);
        this.string = string;
    }

    public EnsureParamStringExtension isNotNull(String errorCode) {
        if (string == null) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    public EnsureParamStringExtension isNotEmpty(String errorCode) {
        if (StringUtil.isEmpty(string)) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    public EnsureParamStringExtension isNotBlank(String errorCode) {
        if (StringUtil.isBlank(string)) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    public EnsureParamStringExtension isEqualTo(String comparedString, String errorCode) {
        if (!StringUtil.equals(string, comparedString)) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    public EnsureParamStringExtension isNotEqualTo(String comparedString, String errorCode) {
        if (StringUtil.equals(string, comparedString)) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

}
