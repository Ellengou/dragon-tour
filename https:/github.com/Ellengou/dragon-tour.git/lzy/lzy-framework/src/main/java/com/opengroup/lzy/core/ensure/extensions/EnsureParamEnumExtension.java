package com.opengroup.lzy.core.ensure.extensions;


import com.opengroup.lzy.core.ensure.EnsureParam;
import com.opengroup.lzy.core.exceptions.XExceptionFactory;

/**
 * Created by ELLEN on 2015/6/9.
 */
public class EnsureParamEnumExtension extends EnsureParam<Enum> {
    private Enum anEnum;

    public EnsureParamEnumExtension(Enum anEnum) {
        super(anEnum);
        this.anEnum = anEnum;
    }

    /**
     * Enum 相等
     * @param comparedEnum
     * @param errorCode
     * @return
     */
    public EnsureParamEnumExtension isEqual(Enum comparedEnum, String errorCode) {
        if (anEnum != comparedEnum) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    /**
     * Enum 不相等
     * @param comparedEnum
     * @param errorCode
     * @return
     */
    public EnsureParamEnumExtension isNotEqual(Enum comparedEnum, String errorCode){
        if(anEnum == comparedEnum){
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    public EnsureParamEnumExtension isNotNull(String errorCode) {
        if (anEnum == null) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }
}
