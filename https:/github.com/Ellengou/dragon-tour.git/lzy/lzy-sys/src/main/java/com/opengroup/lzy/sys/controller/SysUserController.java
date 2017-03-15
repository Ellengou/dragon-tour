package com.opengroup.lzy.sys.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
import com.opengroup.lzy.constants.CommonConstants;
import com.opengroup.lzy.exception.BaseException;
import com.opengroup.lzy.tools.Exceptions;
import com.opengroup.lzy.sys.constants.Constants;
import com.opengroup.lzy.sys.domain.SysRole;
import com.opengroup.lzy.sys.domain.SysUserAdmin;
import com.opengroup.lzy.sys.service.SysRoleService;
import com.opengroup.lzy.sys.service.SysUserAdminService;
import com.opengroup.lzy.sys.service.SysUserRoleService;
import com.opengroup.lzy.sys.utils.UserUtil;

/**
 * 
 * @author lc
 *
 * @date 2017年1月1日 下午6:21:52
 */
@Controller
@RequestMapping("admin/manager")
public class SysUserController extends ControllerBase {
	private static final Logger LOGGER = LoggerFactory
			.getLogger(SysUserController.class);

	@Resource
	private SysUserAdminService sysUserAdminService;
	@Resource
	private SysRoleService sysRoleService;
	@Resource
	private SysUserRoleService sysUserRoleService;

	/**
	 * 默认页面
	 * **/
	@RequestMapping(method = RequestMethod.GET)
	public String list() {
		return "admin/userList";
	}

	// 核心企业
	@RequestMapping(value = "comp", method = RequestMethod.GET)
	public String compList() {
		return "admin/userCompList";
	}

	/**
	 * 获取用户JSON
	 * **/
	@RequiresPermissions("sys:manager:view")
	@RequestMapping(value = "json", method = RequestMethod.GET)
	@ResponseBody
	public PageBean getData(HttpServletRequest request) {
		try {
			PageBean result = sysUserAdminService
					.selectUser(getParams(request));
			return result;
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return null;
	}

	/**
	 * 获取核心企业 admin JSON
	 * **/
	@RequiresPermissions("sys:manager:comp:view")
	@RequestMapping(value = "comp/json", method = RequestMethod.GET)
	@ResponseBody
	public PageBean getCompData(HttpServletRequest request) {
		try {
			Map<String, Object> params = getParams(request);
			SysUserAdmin sysUserAdmin = UserUtil.getCurrentUser();
			Integer compCoreId = sysUserAdmin.getCompCoreId();
			Integer companyId = sysUserAdmin.getCompanyId();
			if (compCoreId != null) {
				params.put("compCoreId", compCoreId);
//				if (companyId.intValue() != compCoreId.intValue()) {
//					String children = (String) companyRedisDao.get(
//							PrefixConstants.COMPANY_ALL_LEVEL_INFO + companyId)
//							.getObject();
//					children = "'" + children.replace(",", "','") + "'";
//					params.put("companyChildIds", children);
//				}
			}
			PageBean result = sysUserAdminService.selectUserInComp(params);
			return result;
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return null;
	}

	/**
	 * 添加用户跳转
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String createForm(Model model) {
		model.addAttribute("adminUser", new SysUserAdmin());
		model.addAttribute("action", "create");
		return "admin/userForm";
	}

	/**
	 * 添加用户
	 * 
	 * @param sysUserAdmin
	 * **/
	@RequiresPermissions("sys:manager:add")
	@RequestMapping(value = "create", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogCreate(@Valid SysUserAdmin sysUserAdmin,
			BindingResult bindingResult) {
		ResultVO resultVO = new ResultVO();
		try {
			if (!sysUserAdmin.getLoginName().matches(
					CommonConstants.REGULAR.LOGIN_NAME)) {
				resultVO.setError(AdminAjaxConstants.MSG_LOGIN_ERROR);
				return resultVO;
			}
			if (bindingResult.hasErrors()) {
				resultVO.setFail(getErrorMsg(bindingResult));
				return resultVO;
			}
			sysUserAdmin.setDataType(UserUtil.getCurrentUser().getDataType());
			sysUserAdminService.insert(sysUserAdmin);
		} catch (BaseException e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
			resultVO.setError(e);
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
			resultVO.setFail();
		}
		return resultVO;
	}

//	/**
//	 * 修改用户跳转
//	 * 
//	 * @param id
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "update", method = RequestMethod.GET)
//	public String updateForm(@RequestParam("id") Integer id, Model model) {
//		SysUserAdmin sysUserAdmin = sysUserAdminService.selectByPrimaryKey(id);
//		IpccAdmin ipccAdmin = ipccAdminService.selectByAdminId(id);
//		if (ipccAdmin != null) {
//			sysUserAdmin.setIpccUname(ipccAdmin.getIpccUname());
//		}
//		model.addAttribute("adminUser", sysUserAdmin);
//		model.addAttribute("action", "update");
//		return "admin/userForm";
//	}

	/**
	 * 修改用户
	 * 
	 * @param sysUserAdmin
	 * @return
	 */
	@RequiresPermissions("sys:manager:update")
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogUpdateRole(
			@Valid @ModelAttribute("adminUser") SysUserAdmin sysUserAdmin) {
		ResultVO resultVO = new ResultVO();
		try {
			sysUserAdminService.updateInfo(sysUserAdmin);
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
	 * 修改平台用户状态
	 * 
	 * @param id
	 * @param state
	 * @return
	 */
	@RequiresPermissions("sys:manager:comp:updateStatus")
	@RequestMapping(value = "updateStatus", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogUpdateStatus(@RequestParam("id") int id,
			@RequestParam("state") int state) {
		ResultVO resultVO = new ResultVO();
		try {
			SysUserAdmin sysUserAdmin = sysUserAdminService
					.selectByPrimaryKey(id);
			if (sysUserAdmin.getSex().equals(Constants.SYS_USER_ADMIN)) {
				resultVO.setFail("超级管理员不可被手动锁定");
				return resultVO;
			}
			sysUserAdmin.setState(state);
			sysUserAdminService.updateByPrimaryKeySelective(sysUserAdmin);
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
	 * 修改企业用户状态
	 * 
	 * @param id
	 * @param state
	 * @return
	 */
	@RequiresPermissions("sys:manager:comp:updateStatus")
	@RequestMapping(value = "updateCompStatus", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogUpdateCompStatus(@RequestParam("id") int id,
			@RequestParam("state") int state) {
		ResultVO resultVO = new ResultVO();
		try {
			SysUserAdmin sysUserAdmin = sysUserAdminService
					.selectByPrimaryKey(id);
			List<SysUserAdmin> sysUserAdmins = sysUserAdminService
					.selectByCompCoreId(sysUserAdmin.getCompanyId());
			for (int i = 0; i < sysUserAdmins.size(); i++) {
				sysUserAdmins.get(i).setState(state);
				sysUserAdminService.updateByPrimaryKeySelective(sysUserAdmins
						.get(i));
			}
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
	@RequiresPermissions("sys:manager:delete")
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogDeleteRole(SysUserAdmin sysUserAdmin) {
		ResultVO resultVO = new ResultVO();
		try {
			sysUserAdminService.delete(sysUserAdmin.getId());
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
	 * 分配角色跳转
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "roleUpdate", method = RequestMethod.GET)
	public String roleUpdate(@RequestParam("id") Integer id, Model model) {
		model.addAttribute("userId", id);
		return "admin/roleSelect";
	}

	/**
	 * 获取角色列表
	 * 
	 * @return
	 */
	@RequiresPermissions("sys:manager:roleView")
	@RequestMapping(value = "role/json", method = RequestMethod.GET)
	@ResponseBody
	public List<SysRole> getRoles(@RequestParam("userId") Integer userId) {
		try {
			List<SysRole> result = sysRoleService.selectAllByCompany(UserUtil
					.getCurrentUser().getCompanyId());
			List<Integer> roleIds = sysUserRoleService.getRoleIdList(userId);
			if (UserUtil.getCurrentUser().getCompanyId() == null) {
				result.remove(result.get(0));
			}

			if (roleIds == null || roleIds.size() == 0)
				return result;
			for (int i = 0; i < result.size(); i++) {
				int roleId = result.get(i).getId();
				if (roleIds.contains(roleId)) {
					result.get(i).setChecked(1);
				}
			}
			return result;
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return null;
	}

	/**
	 * 更改角色分配
	 * **/
	@RequiresPermissions("sys:manager:roleUpdate")
	@RequestMapping(value = "{userId}/updateUserRole")
	@ResponseBody
	public ResultVO oplogUpdateUserRole(@PathVariable("userId") Integer userId,
			@RequestBody List<Integer> newRoleIds) {
		ResultVO resultVO = new ResultVO();
		try {
			SysUserAdmin sysUserAdmin = sysUserAdminService
					.selectByPrimaryKey(userId);
			if (sysUserAdmin.getSex().equals(Constants.SYS_USER_ADMIN)
					&& sysUserAdmin.getCompanyId() == null) {
				resultVO.setFail("超级管理员账号权限不可变更！");
				return resultVO;
			}
			List<Integer> oldRoleIds = sysUserRoleService.getRoleIdList(userId);
			sysUserRoleService.updateUserRole(userId, oldRoleIds, newRoleIds);
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
	 * 修改密码跳转
	 * **/
	@RequestMapping(value = "changePwd", method = RequestMethod.GET)
	public String updatePwd(Model model) {
		model.addAttribute("userId", UserUtil.getCurrentUser().getId());
		model.addAttribute("action", "update");
		return "admin/changePwd";
	}

	/**
	 * 更改密码
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "changePwd", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO logpwdUpdatePwd(HttpServletRequest request,
			HttpSession session) {
		ResultVO resultVO = new ResultVO();
		try {
			String oldPassword = request.getParameter("oldPassword").replace(
					" ", "");
			String newPassword = request.getParameter("newPassword").replace(
					" ", "");
			String plainPassword = request.getParameter("plainPassword")
					.replace(" ", "");
			SysUserAdmin sysUserAdmin = sysUserAdminService
					.selectByPrimaryKey(UserUtil.getCurrentUser().getId());
			if (!sysUserAdminService.checkPassword(sysUserAdmin, oldPassword)) {
				resultVO.setFail("原密码不正确，请重新输入");
				return resultVO;
			}

			if (!newPassword.equals(plainPassword)) {
				resultVO.setFail("两次输入的密码不一致，请重新输入");
				return resultVO;
			}

			sysUserAdmin.setPassword(newPassword);
			sysUserAdminService.updatePassword(sysUserAdmin);
			session.setAttribute(Constants.SYS_USER, sysUserAdmin);
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
	 * 重置密码
	 *
	 * @param id
	 * @param session
	 * @return
	 * **/
	@RequiresPermissions("sys:manager:resetPwd")
	@RequestMapping(value = "resetPwd", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO logpwdResetPwd(@RequestParam("id") Integer id,
			HttpSession session) {
		ResultVO resultVO = new ResultVO();
		try {
			SysUserAdmin sysUserAdmin = sysUserAdminService
					.selectByPrimaryKey(id);
			if (sysUserAdmin == null) {
				resultVO.setFail("当前用户不存在");
				return resultVO;
			}
			sysUserAdmin.setPassword("123456");
			sysUserAdminService.updatePassword(sysUserAdmin);
			session.setAttribute(Constants.SYS_USER, sysUserAdmin);
		} catch (BaseException e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
			resultVO.setError(e);
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
			resultVO.setFail();
		}
		return resultVO;
	}

	@RequestMapping(value = "checkLoginName", method = RequestMethod.GET)
	@ResponseBody
	public boolean checkLoginName(@RequestParam("loginName") String loginName) {
		SysUserAdmin sysUserAdmin = sysUserAdminService
				.selectByLoginName(loginName);
		if (sysUserAdmin != null) {
			return false;
		} else {
			return true;
		}
	}

	@RequestMapping(value = "checkCompLoginName", method = RequestMethod.GET)
	@ResponseBody
	public boolean checkCompLoginName(
			@RequestParam("registerName") String loginName) {
		SysUserAdmin sysUserAdmin = sysUserAdminService
				.selectByLoginName(loginName);
		if (sysUserAdmin != null) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 修改密码跳转
	 * **/
	@RequestMapping(value = "changeLoginName", method = RequestMethod.GET)
	public String changeLoginName(Model model) {
		model.addAttribute("action", "update");
		return "admin/changeLoginName";
	}

	/**
	 * 更改登录名跳转
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "changeLoginName", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO logChangeLoginName(HttpServletRequest request,
			HttpSession session) {
		ResultVO resultVO = new ResultVO();
		try {
			if (UserUtil.getCurrentUser().getId() == 1) {
				resultVO.setFail("平台超级管理员的登录名不能修改");
				return resultVO;
			}
			String newLoginName = request.getParameter("loginName").trim();
			if (newLoginName.isEmpty()) {
				resultVO.setFail("登录名不能为空，请重新输入");
				return resultVO;
			}
			SysUserAdmin sysFindUser = sysUserAdminService
					.selectByLoginName(newLoginName);
			if (sysFindUser != null
					&& sysFindUser.getId() != UserUtil.getCurrentUser().getId()) {
				resultVO.setFail("当前登录名已存在，请重新输入");
				return resultVO;
			}
			SysUserAdmin sysUserAdmin = sysUserAdminService
					.selectByPrimaryKey(UserUtil.getCurrentUser().getId());
			sysUserAdmin.setLoginName(newLoginName);
			sysUserAdminService.updateByPrimaryKeySelective(sysUserAdmin);
			session.setAttribute(Constants.SYS_USER, sysUserAdmin);
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
