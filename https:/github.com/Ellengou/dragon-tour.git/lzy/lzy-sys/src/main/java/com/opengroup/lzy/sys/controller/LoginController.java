package com.opengroup.lzy.sys.controller;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.opengroup.lzy.sys.domain.SysDic;
import com.opengroup.lzy.tools.kv.KvClient;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 
 * @author lc
 *
 * @date 2017年1月1日 下午6:04:40
 */
@Controller
@RequestMapping(value = "admin")
public class LoginController {

	@Resource
	private KvClient kvClient;

	/**
	 * 默认页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login() {
		Subject subject = SecurityUtils.getSubject();
		if (subject.isAuthenticated() || subject.isRemembered()) {
			return "admin/index";
		}
		return "admin/login";
	}

	/**
	 * 登录失败
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String fail(HttpServletRequest request, Model model) {
		String message = ((String) request.getAttribute("shiroLoginFailure"))
				.replace("org.apache.shiro.authc.", "");
		switch (message) {
		case "IncorrectCredentialsException":
			model.addAttribute("msg", "密码错误");
			break;
		case "UnknownAccountException":
			model.addAttribute("msg", "账号不存在");
			break;
		case "LockedAccountException":
			model.addAttribute("msg", "账号被锁定，请15分钟后重试");
			break;
		case "com.runlion.hssys.exception.LockedAccountBySysException":
			model.addAttribute("msg", "账号被锁定，请联系管理员");
			break;
		case "com.runlion.hssys.exception.CaptchaException":
			model.addAttribute("msg", "验证码错误");
			break;
		case "com.runlion.hssys.exception.PermissionException":
			model.addAttribute("msg", "密码不能为空");
			break;
		}

		return "admin/login";
	}

	/**
	 * 登出
	 * 
	 * @return
	 */
	@RequestMapping(value = "logout")
	public String logout() {
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		return "admin/login";
	}
}
