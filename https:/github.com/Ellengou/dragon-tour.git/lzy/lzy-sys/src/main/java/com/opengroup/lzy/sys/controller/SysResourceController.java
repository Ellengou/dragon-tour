package com.opengroup.lzy.sys.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.component.ResultVO;
import com.opengroup.lzy.exception.BaseException;
import com.opengroup.lzy.tools.Exceptions;
import com.opengroup.lzy.sys.constants.Constants;
import com.opengroup.lzy.sys.domain.SysResource;
import com.opengroup.lzy.sys.service.SysResourceService;
import com.opengroup.lzy.sys.utils.UserUtil;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 * @author lc
 *
 * @date 2017年1月1日 下午6:05:19
 */
@Controller
@RequestMapping("admin/resource")
public class SysResourceController extends ControllerBase {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(SysResourceController.class);

	@Resource
	private SysResourceService sysResourceService;

	/**
	 * 默认页面
	 * **/
	@RequestMapping(method = RequestMethod.GET)
	public String resourceList() {
		return "admin/resourceList";
	}

	/**
	 * 菜单页面
	 * **/
	@RequestMapping(value = "menu", method = RequestMethod.GET)
	public String menuList() {
		return "admin/menuList";
	}

	/**
	 * 菜单集合 JSON
	 * **/
	@RequiresPermissions("sys:res:menu:view")
	@RequestMapping(value = "menu/json", method = RequestMethod.GET)
	@ResponseBody
	public List<SysResource> menuData(@RequestParam("id") Integer pid) {
		List<SysResource> sysMenus = sysResourceService.selectAllResource(null,
				Constants.RESOURCE_ADMIN_MENU, pid, null, null); // UserUtil.getCurrentUser().getDataType());
		return sysMenus;
	}

	/**
	 * 添加菜单跳转
	 * **/
	@RequestMapping(value = "menu/create", method = RequestMethod.GET)
	public String menuCreateForm(@RequestParam("pid") Integer pid, Model model) {
		SysResource sysResource = new SysResource();
		sysResource.setPid(pid);
		model.addAttribute("menu", sysResource);
		model.addAttribute("action", "create");
		return "admin/menuForm";
	}

	/**
	 * 添加菜单
	 * **/
	@RequiresPermissions("sys:res:menu:add")
	@RequestMapping(value = "menu/create", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogCreateMenu(@Valid SysResource sysResource) {
		ResultVO resultVO = new ResultVO();
		try {
			sysResource.setType(0);
			sysResource.setOperateTime(new Date());
			sysResourceService.insert(sysResource,
					Constants.RESOURCE_ADMIN_MENU);
			// TODO - LOGOUT
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
	 * 修改菜单跳转
	 * **/
	@RequestMapping(value = "menu/update", method = RequestMethod.GET)
	public String menuUpdateForm(@RequestParam("id") Integer id, Model model) {
		model.addAttribute("menu", sysResourceService.selectByPrimaryKey(id));
		model.addAttribute("action", "update");
		return "admin/menuForm";
	}

	/**
	 * 修改菜单
	 */
	@RequiresPermissions("sys:res:menu:update")
	@RequestMapping(value = "menu/update", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogUpdateMenu(
			@Valid @ModelAttribute("resource") SysResource sysResource) {
		ResultVO resultVO = new ResultVO();
		try {
			sysResource.setType(0);
			sysResource.setOperateTime(new Date());
			sysResourceService.update(sysResource,
					Constants.RESOURCE_ADMIN_MENU);
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
	 * 修改菜单状态
	 */
	@RequiresPermissions("sys:res:menu:updateStatus")
	@RequestMapping(value = "menu/updateStatus", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogUpdateMenuStatus(@RequestParam("id") int id,
			@RequestParam("status") int status) {
		ResultVO resultVO = new ResultVO();
		try {
			SysResource sysResource = sysResourceService.selectByPrimaryKey(id);
			sysResource.setStatus(status);
			sysResourceService.update(sysResource,
					Constants.RESOURCE_ADMIN_MENU);
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
	 * 删除菜单
	 */
	@RequiresPermissions("sys:res:menu:delete")
	@RequestMapping(value = "menu/delete")
	@ResponseBody
	public ResultVO oplogDeleteMenu(@RequestParam("id") Integer id) {
		ResultVO resultVO = new ResultVO();
		try {
			sysResourceService.delete(id);
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
	 * 权限集合 JSON
	 * **/
	@RequiresPermissions("sys:res:view")
	@RequestMapping(value = "json", method = RequestMethod.GET)
	@ResponseBody
	public List<SysResource> resourceData(@RequestParam("pid") Integer pid) {
		List<SysResource> sysResources = sysResourceService.selectAllResource(
				null, null, pid, Constants.RESOURCE_STATUS_ABLE, null); // UserUtil.getCurrentUser().getDataType());
		return sysResources;
	}

	/**
	 * 权限集合 JSON
	 * **/
	@RequiresPermissions("sys:role:resView")
	@RequestMapping(value = "jsonInRole", method = RequestMethod.GET)
	@ResponseBody
	public List<SysResource> jsonInRole(@RequestParam("pid") Integer pid) {
		List<SysResource> sysResources = sysResourceService.selectAllResource(
				null, null, pid, Constants.RESOURCE_STATUS_ABLE, UserUtil
						.getCurrentUser().getDataType());
		return sysResources;
	}

	/**
	 * 添加权限跳转
	 * **/
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(@RequestParam("pid") Integer pid, Model model) {
		SysResource sysResource = new SysResource();
		sysResource.setPid(pid);
		model.addAttribute("resource", sysResource);
		model.addAttribute("action", "create");
		return "admin/resourceForm";
	}

	/**
	 * 添加权限
	 * **/
	@RequiresPermissions("sys:res:add")
	@RequestMapping(value = "create", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogCreate(@Valid SysResource sysResource) {
		ResultVO resultVO = new ResultVO();
		try {
			sysResource.setDisorder(null);
			sysResource.setType(2);
			sysResource.setOperateTime(new Date());
			sysResourceService.insert(sysResource, Constants.RESOURCE_BUTTON);
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
	 * 修改权限跳转
	 */
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(@RequestParam("id") Integer id, Model model) {
		model.addAttribute("resource",
				sysResourceService.selectByPrimaryKey(id));
		model.addAttribute("action", "update");
		return "admin/resourceForm";
	}

	/**
	 * 修改权限
	 */
	@RequiresPermissions("sys:res:update")
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogUpdate(
			@Valid @ModelAttribute("resource") SysResource sysResource) {
		ResultVO resultVO = new ResultVO();
		try {
			sysResource.setDisorder(null);
			sysResource.setType(2);
			sysResource.setOperateTime(new Date());
			sysResourceService.update(sysResource, Constants.RESOURCE_BUTTON);
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
	 * 修改权限状态
	 */
	@RequiresPermissions("sys:res:updateStatus")
	@RequestMapping(value = "updateStatus", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogUpdateResStatus(@RequestParam("id") int id,
			@RequestParam("status") int status) {
		ResultVO resultVO = new ResultVO();
		try {
			SysResource sysResource = sysResourceService.selectByPrimaryKey(id);
			sysResource.setStatus(status);
			sysResourceService.update(sysResource, Constants.RESOURCE_BUTTON);
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
	 * 删除权限
	 */
	@RequiresPermissions("sys:res:delete")
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogDelete(@RequestParam("id") Integer id) {
		ResultVO resultVO = new ResultVO();
		try {
			sysResourceService.delete(id);
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
	 * 获取菜单下的操作
	 * **/
	@RequiresPermissions("sys:res:view")
	@RequestMapping("opera/json")
	@ResponseBody
	public PageBean menuOperationDate(HttpServletRequest request) {
		try {
			Map<String, Object> params = getParams(request);
			return new PageBean(sysResourceService.countByPid(params),
					sysResourceService.selectByPid(params));
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}

		return null;
	}
}
