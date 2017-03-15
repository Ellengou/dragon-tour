package com.opengroup.lzy.sys.utils.security;

import org.apache.shiro.authc.UsernamePasswordToken;

/**
 * 扩展添加验证码-继承用户验证类
 * Created by violorch on 2016/4/11.
 */
public class UsernamePasswordCaptchaToken extends UsernamePasswordToken {

    private static final long serialVersionUID = 1L;

    private String captcha;

    public String getCaptcha() {
        return captcha;
    }

    public void setCaptcha(String captcha) {
        this.captcha = captcha;
    }

    public UsernamePasswordCaptchaToken() {
        super();
    }

    public UsernamePasswordCaptchaToken(String username, char[] password,boolean rememberMe, String host, String captcha) {
        super(username, password, rememberMe, host);
        this.captcha = captcha;
    }

}
