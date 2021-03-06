package com.opengroup.lzy.core.ensure.extensions;


import com.opengroup.lzy.core.ensure.EnsureParam;
import com.opengroup.lzy.core.exceptions.XBusinessException;
import com.opengroup.lzy.core.exceptions.XExceptionFactory;

/**
 * Created by ELLEN on 2015/6/9.
 */
public class EnsureParamNumberExtension extends EnsureParam<Number> {
    private Double number;

    public EnsureParamNumberExtension(Number number) {
        super(number);
        this.number = number.doubleValue();
    }

    /**
     * 大于
     *
     * @param comparedNumber
     * @param errorCode
     * @return
     */
    public EnsureParamNumberExtension isGt(Number comparedNumber, String errorCode) throws XBusinessException {
        if (number <= comparedNumber.doubleValue()) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    /**
     * 不大于（小于等于）
     *
     * @param comparedNumber
     * @param errorCode
     * @return
     */
    public EnsureParamNumberExtension isNotGt(Number comparedNumber, String errorCode) throws XBusinessException {
        if (number > comparedNumber.doubleValue()) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    /**
     * 小于
     *
     * @param comparedNumber
     * @param errorCode
     * @return
     */
    public EnsureParamNumberExtension isLt(Number comparedNumber, String errorCode) throws XBusinessException {
        if (number >= comparedNumber.doubleValue()) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    /**
     * 不小于
     *
     * @param comparedNumber
     * @param errorCode
     * @return
     */
    public EnsureParamNumberExtension isNotLt(Number comparedNumber, String errorCode) throws XBusinessException {
        if (number < comparedNumber.doubleValue()) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    /**
     * 等于
     *
     * @param comparedNumber
     * @param errorCode
     * @return
     */
    public EnsureParamNumberExtension isEqual(Number comparedNumber, String errorCode) throws XBusinessException {
        if (number != comparedNumber.doubleValue()) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    /**
     * 不等于
     *
     * @param comparedNumber
     * @param errorCode
     * @return
     */
    public EnsureParamNumberExtension isNotEqual(Number comparedNumber, String errorCode) throws XBusinessException {
        if (number == comparedNumber.doubleValue()) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    public EnsureParamNumberExtension isNotNull(String errorCode) throws XBusinessException {
        if (number == null) {
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    public EnsureParamNumberExtension isEqualTo(Number obj, String errorCode) throws XBusinessException {
        return isEqual(obj, errorCode);
    }

    public EnsureParamNumberExtension isNotEqualTo(Number obj, String errorCode) throws XBusinessException {
        return isNotEqual(obj, errorCode);
    }
}
