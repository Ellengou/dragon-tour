package com.opengroup.lzy.sys.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.component.ResultVO;
import com.opengroup.lzy.constants.AdminAjaxConstants;
import com.opengroup.lzy.exception.BaseException;
import com.opengroup.lzy.tools.Exceptions;
import com.opengroup.lzy.sys.constants.Constants;
import com.opengroup.lzy.sys.domain.SysRole;
import com.opengroup.lzy.sys.service.SysRoleResourceService;
import com.opengroup.lzy.sys.service.SysRoleService;


/**
 * 角色
 * @author lc
 *
 * @date 2017年1月1日 下午6:20:38
 */
@Controller
@RequestMapping("admin/role")
public class SysRoleController extends ControllerBase {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(SysRoleController.class);

	@Resource
	private SysRoleService sysRoleService;
	@Resource
	private SysRoleResourceService sysRoleResourceService;

	/**
	 * 默认页面
	 * **/
	@RequestMapping(method = RequestMethod.GET)
	public String list() {
		return "admin/roleList";
	}

	/**
	 * 角色集合 JSON
	 * **/
	@RequiresPermissions("sys:role:view")
	@RequestMapping(value = "json", method = RequestMethod.GET)
	@ResponseBody
	public PageBean getData(HttpServletRequest request) {
		try {
			return sysRoleService.selectRole(getParams(request));
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return null;
	}

	/**
	 * 获取角色拥有的权限ID集合
	 * 
	 * @param roleId
	 * @return
	 * **/
	@RequiresPermissions("sys:role:resView")
	@RequestMapping(value = "res/json", method = RequestMethod.GET)
	@ResponseBody
	public List<Integer> getRoleResoueces(@RequestParam("roleId") Integer roleId) {
		return sysRoleResourceService.getResourceIds(roleId);
	}

	/**
	 * 修改角色权限
	 * 
	 * @param id
	 * @param newResourceIds
	 * @return
	 **/
	@RequiresPermissions("sys:role:resUpdate")
	@RequestMapping(value = "{id}/updateRoleRes", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogUpdateRolePermission(@PathVariable("id") Integer id,
			@RequestBody List<Integer> newResourceIds) {
		ResultVO resultVO = new ResultVO();
		try {
			SysRole sysRole = sysRoleService.selectById(id);
			if (sysRole.getStatus() == Constants.SYS_PERMISSION_ADMIN) {
				resultVO.setFail("超级管理员账号权限不可变更！");
				return resultVO;
			}
			List<Integer> oldResourceIds = sysRoleResourceService
					.getResourceIds(id);
			sysRoleResourceService.updateRoleResource(id, oldResourceIds,
					newResourceIds);
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
			resultVO.setFail();
		}
		return resultVO;
	}

	/**
	 * 添加角色跳转
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) {
		model.addAttribute("role", new SysRole());
		model.addAttribute("action", "create");
		return "admin/roleForm";
	}

	/**
	 * 添加角色
	 * 
	 * @param role
	 * **/
	@RequiresPermissions("sys:role:add")
	@RequestMapping(value = "create", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogCreate(@Valid SysRole role, BindingResult bindingResult) {
		ResultVO resultVO = new ResultVO();
		try {
			if (bindingResult.hasErrors()) {
				resultVO.setFail(getErrorMsg(bindingResult));
				return resultVO;
			}
			sysRoleService.insert(role);
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
			resultVO.setFail();
		}
		return resultVO;
	}

	/**
	 * 修改角色跳转
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(@RequestParam("id") Integer id, Model model) {
		model.addAttribute("role", sysRoleService.selectById(id));
		model.addAttribute("action", "update");
		return "admin/roleForm";
	}

	/**
	 * 修改角色
	 * 
	 * @param sysRole
	 * @return
	 */
	@RequiresPermissions("sys:role:update")
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogUpdateRole(
			@Valid @ModelAttribute("role") SysRole sysRole,
			BindingResult bindingResult) {
		ResultVO resultVO = new ResultVO();
		try {
			SysRole sysRoleAll = sysRoleService.selectById(sysRole.getId());
			if (bindingResult.hasErrors()) {
				resultVO.setFail(getErrorMsg(bindingResult));
				return resultVO;
			}
			if (sysRoleAll.getStatus() == Constants.SYS_PERMISSION_ADMIN) {
				resultVO.setError(AdminAjaxConstants.MSG_USER_NOCHANGE);
				return resultVO;
			}
			sysRoleService.update(sysRole);
		} catch (BaseException e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
			resultVO.setError(e);
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
			resultVO.setFail();
		}
		return resultVO;
	}

	/**
	 * 删除角色
	 *
	 * @return
	 */
	@RequiresPermissions("sys:role:delete")
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogDeleteRole(SysRole sysRole) {
		ResultVO resultVO = new ResultVO();
		try {
			sysRoleService.delete(sysRole.getId());
		} catch (BaseException e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
			resultVO.setError(e);
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
			resultVO.setFail();
		}
		return resultVO;
	}

}
