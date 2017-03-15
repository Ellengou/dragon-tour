package com.opengroup.lzy.sys.utils;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * @author lc
 *
 * @date 2017年1月2日 下午12:31:48
 */
public class AjaxFilter implements Filter {

	public void init(FilterConfig filterConfig) throws ServletException {

	}

	public void doFilter(ServletRequest servletRequestt,
			ServletResponse servletResponse, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequestt;
		HttpServletResponse response = (HttpServletResponse) servletResponse;

		// String currentURL = request.getRequestURI();//取得根目录所对应的绝对路径:
		// String targetURL = currentURL.substring(currentURL.indexOf("/", 1),
		// currentURL.length()); //截取到当前文件名用于比较

		String ajaxSubmit = request.getHeader("X-Requested-With");
		// response.setHeader("Access-Control-Allow-Origin", "*");

		if (ajaxSubmit != null && ajaxSubmit.equals("XMLHttpRequest")) {
			if (request.getSession(false) == null) {
				response.setHeader("sessionStatus", "timeout");
				response.getWriter().print("sessionStatus");
				return;
			}
		}

		chain.doFilter(servletRequestt, servletResponse);
	}

	public void destroy() {

	}
}
