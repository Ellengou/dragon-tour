package com.opengroup.lzy.core.exceptions;


/**
 * Created by ELLEN on 2016/12/4.
 */
public class XRuntimeException extends RuntimeException {

    private static final long serialVersionUID = -5225742058523401756L;

    public XRuntimeException() {
    }

    public XRuntimeException(String message, Throwable cause) {

        super(message, cause);
    }
}
