package com.opengroup.lzy.core.ensure.extensions;


import com.opengroup.lzy.core.ensure.EnsureParam;
import com.opengroup.lzy.core.exceptions.XExceptionFactory;

/**
 * Created by ELLEN on 2015/6/8.
 */
public class EnsureParamObjectExtension extends EnsureParam<Object> {
    private boolean isSatisfied;

    public EnsureParamObjectExtension(Object o) {
        super(o);
    }

    public EnsureParamObjectExtension isNotNull(String errorCode){
        if(tObjct == null){
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    public <TObject extends Object> EnsureParamObjectExtension isEqualTo(TObject obj, String errorCode){
        isSatisfied = (obj == tObjct) || (obj != null && tObjct != null && tObjct.equals(obj));

        if(!isSatisfied){
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }

    public <TObject extends Object> EnsureParamObjectExtension isNotEqualTo(TObject obj, String errorCode){
        if(obj != tObjct){
            if(obj != null){
                isSatisfied = !obj.equals(tObjct);
            }else if(tObjct != null){
                isSatisfied = !tObjct.equals(obj);
            } else {
                isSatisfied = false;
            }
        }else {
            isSatisfied = false;
        }

        if(!isSatisfied){
            throw XExceptionFactory.create(errorCode);
        }
        return this;
    }
}
