package com.opengroup.lzy.exception;

/**
 * 基类异常
 * 
 * @author lc
 *
 * @date 2017年1月9日 下午7:21:16
 */
public class BaseException extends RuntimeException {

	@SuppressWarnings("unused")
	private Enum<?> en;

	private static final long serialVersionUID = 1L;

	public BaseException() {

	}

	public BaseException(String msg, Throwable e) {
		super(msg, e);
	}

	public BaseException(String msg) {
		super(msg);
	}
	public BaseException(Throwable e) {
		super(e);
	}

	public BaseException(Enum en) {
		this.en = en;
	}

	public Enum<?> getEn() {
		return en;
	}

	public void setEn(Enum<?> en) {
		this.en = en;
	}
	
	
}
