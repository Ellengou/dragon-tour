package com.opengroup.lzy.exception;

/**
 * 
 * @author lc
 *
 * @date 2017年1月12日 下午3:57:23
 */
public class WaitTimeoutException extends BaseException {
	
	private static final long serialVersionUID = 2571609199859576305L;


	public WaitTimeoutException() {
	}


	public WaitTimeoutException(String message) {
		super(message);
	}

	
	public WaitTimeoutException(String message, Throwable cause) {
		super(message, cause);
	}


	public WaitTimeoutException(Throwable cause) {
		super(cause);
	}
}
