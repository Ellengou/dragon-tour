package com.opengroup.lzy.core.ensure.extensions;


import com.opengroup.lzy.core.ensure.EnsureParam;
import com.opengroup.lzy.core.exceptions.XExceptionFactory;

/**
 * Created by ELLEN on 2015/6/9.
 */
public class EnsureParamBooleanExtension extends EnsureParam<Boolean> {
    private Boolean condition;

    public EnsureParamBooleanExtension(Boolean condition) {
        super(condition);
        this.condition = condition;
    }

    public EnsureParamBooleanExtension isFalse(String errorCode){
        if(condition){
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    public EnsureParamBooleanExtension isTrue(String errorCode){
        if(!condition){
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }
}
