package com.opengroup.lzy.sys.utils.security;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opengroup.lzy.tools.Exceptions;
import com.opengroup.lzy.sys.constants.Constants;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 扩展认证默认过滤
 * 
 * @author lc
 *
 * @date 2016年12月31日 下午11:23:54
 */
public class FormAuthenticationCaptchaFilter extends FormAuthenticationFilter {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(FormAuthenticationCaptchaFilter.class);

	public static final String DEFAULT_CAPTCHA_PARAM = "captcha";
	private String captchaParam = DEFAULT_CAPTCHA_PARAM;

	public String getCaptchaParam() {
		return captchaParam;
	}

	protected String getCaptcha(ServletRequest request) {
		return WebUtils.getCleanParam(request, getCaptchaParam());
	}

	protected AuthenticationToken createToken(ServletRequest request,
			ServletResponse response) {
		String username = getUsername(request);
		String password = getPassword(request);
		if (password == null) {
			password = "";
		}
		String captcha = getCaptcha(request);
		boolean rememberMe = isRememberMe(request);
		String host = getHost(request);
		return new UsernamePasswordCaptchaToken(username,
				password.toCharArray(), rememberMe, host, captcha);
	}

	// 登录成功
	protected boolean onLoginSuccess(AuthenticationToken token,
			Subject subject, ServletRequest request, ServletResponse response)
			throws Exception {

		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;

		if (!"XMLHttpRequest".equalsIgnoreCase(httpServletRequest
				.getHeader("X-Requested-With"))) { // 不是ajax请求
			issueSuccessRedirect(request, response);
		} else {
			httpServletResponse.setCharacterEncoding("UTF-8");
			PrintWriter out = httpServletResponse.getWriter();
			out.println("{status:ok,msg:'登入成功'}");
			out.flush();
			out.close();
		}
		return false;
	}

	// 登录失败
	protected boolean onLoginFailure(AuthenticationToken token,
			AuthenticationException e, ServletRequest request,
			ServletResponse response) {
		// 失败时移除session中的存储
		SecurityUtils.getSubject().getSession()
				.removeAttribute(Constants.SYS_USER);

		if (!"XMLHttpRequest".equalsIgnoreCase(((HttpServletRequest) request)
				.getHeader("X-Requested-With"))) { // 不是ajax请求
			LOGGER.error(Exceptions.getStackTraceAsString(e));
			setFailureAttribute(request, e);
			return true;
		}
		try {
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			String message = e.getClass().getSimpleName();
			if ("IncorrectCredentialsException".equals(message)) {
				out.println("{status:fail,msg:'密码错误'}");
			} else if ("UnknownAccountException".equals(message)) {
				out.println("{status:fail,msg:'账号不存在'}");
			} else if ("LockedAccountException".equals(message)) {
				out.println("{status:fail,msg:'账号被锁定'}");
			} else if ("LockedAccountByCompanyException".equals(message)) {
				out.println("{status:fail,msg:'核心企业被禁用'}");
			} else if ("CaptchaException".equals(message)) {
				out.println("{status:fail,msg:'验证码错误'}");
			} else if ("PermissionException".equals(message)) {
				out.println("{status:fail,msg:'密码不能为空'}");
			} else {
				out.println("{status:fail,msg:'未知错误'}");
			}
			out.flush();
			out.close();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		return false;
	}
}
