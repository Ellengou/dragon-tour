package com.opengroup.lzy.sys.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.sys.service.SysDicService;
import com.opengroup.lzy.tools.Exceptions;

/**
 * 字典
 * 
 * @author lc
 *
 * @date 2017年1月11日 下午5:21:46
 */
@Controller
@RequestMapping("admin/system/dic")
public class DicController extends ControllerBase {
	private static final Logger LOGGER = LoggerFactory
			.getLogger(DicController.class);
	@Resource
	private SysDicService sysDicService;

	/**、、
	 * 初始页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "dicListPage", method = RequestMethod.GET)
	public String dicPage(HttpServletRequest request) {
		try {
			// TODO
			
			
			
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return "system/DicListPage";

	}

	@RequestMapping(value = "dicList", method = RequestMethod.POST)
	@ResponseBody
	public PageBean dicList(HttpServletRequest request) {
		try {
			Map<String, Object> params = getParams(request);
			PageBean pb = sysDicService.querySysDicsPage(params);
			return pb;
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return null;

	}
}
