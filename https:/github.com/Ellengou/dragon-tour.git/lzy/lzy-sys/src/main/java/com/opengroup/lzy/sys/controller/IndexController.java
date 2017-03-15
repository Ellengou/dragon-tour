package com.opengroup.lzy.sys.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.opengroup.lzy.sys.constants.Constants;
import com.opengroup.lzy.sys.domain.SysResource;
import com.opengroup.lzy.sys.service.SysResourceService;
import com.opengroup.lzy.sys.utils.UserUtil;
import com.opengroup.lzy.tools.Exceptions;

import javax.annotation.Resource;

import java.util.List;

/**
 * 
 * @author lc
 *
 * @date 2017年1月1日 下午6:03:38
 */
@Controller
public class IndexController extends ControllerBase {
	private static final Logger LOGGER = LoggerFactory
			.getLogger(IndexController.class);
	@Resource
	private SysResourceService sysResourceService;

	// 登录后进入首页
	@RequestMapping(value = "admin/index", method = RequestMethod.GET)
	public String initIndex(Model model) {
		try {
			List<SysResource> menuRootList = sysResourceService.selectResource(
					UserUtil.getCurrentUser().getId(),
					Constants.RESOURCE_ADMIN_MENU, 0,
					Constants.RESOURCE_STATUS_ABLE, null);
			model.addAttribute("menuRoot", menuRootList);
			return "admin/index";
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return null;
	}

	// 头部菜单栏获取
	@RequestMapping("admin/headerMenu")
	@ResponseBody
	public List<SysResource> headerMenuAjax() {
		List<SysResource> sysMenus = sysResourceService.selectResource(UserUtil
				.getCurrentUser().getId(), Constants.RESOURCE_ADMIN_MENU, 0,
				Constants.RESOURCE_STATUS_ABLE, null);
		return sysMenus;
	}

	// 左侧菜单栏获取
	@RequestMapping("admin/menu")
	@ResponseBody
	public List<SysResource> menuAjax(@RequestParam("id") Integer id) {
		List<SysResource> sysMenus = sysResourceService.selectAllResource(
				UserUtil.getCurrentUser().getId(),
				Constants.RESOURCE_ADMIN_MENU, id,
				Constants.RESOURCE_STATUS_ABLE, null);
		return sysMenus;
	}

	// 登录后进入首页内容页面
	@RequestMapping(value = "admin/home", method = RequestMethod.GET)
	public String initIndexContent() {
		return "admin/index";
	}

}
