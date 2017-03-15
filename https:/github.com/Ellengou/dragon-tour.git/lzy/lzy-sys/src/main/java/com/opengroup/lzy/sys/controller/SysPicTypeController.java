package com.opengroup.lzy.sys.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.component.ResultVO;
import com.opengroup.lzy.constants.AdminAjaxConstants;
import com.opengroup.lzy.constants.CommonConstants;
import com.opengroup.lzy.constants.DicConstants;
import com.opengroup.lzy.constants.PrefixConstants;
import com.opengroup.lzy.sys.domain.SysDic;
import com.opengroup.lzy.sys.domain.SysPicType;
import com.opengroup.lzy.sys.service.SysPicTypeService;
import com.opengroup.lzy.sys.service.SysPicUrlService;
import com.opengroup.lzy.tools.Exceptions;
import com.opengroup.lzy.tools.kv.KvClient;

/**
 * 图片类型
 * 
 * @author lc
 *
 * @date 2017年1月15日 下午4:18:09
 */
@Controller
@RequestMapping("admin/system/picType")
public class SysPicTypeController extends ControllerBase {
	private static final Logger LOGGER = LoggerFactory
			.getLogger(SysPicTypeController.class);
	@Resource
	private SysPicTypeService sysPicTypeService;
	@Resource
	private SysPicUrlService sysPicUrlService;
	@Resource
	private KvClient kvClient;

	/**
	 * 默认页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "picTypeListPage", method = RequestMethod.GET)
	public String picTypePage(HttpServletRequest request) {
		List<SysDic> platformList = kvClient.readList(PrefixConstants.DIC + "_"
				+ DicConstants.PLATFORM, SysDic.class);
		request.setAttribute("platformList", JSON.toJSON(platformList));
		List<SysDic> isUseList = kvClient.readList(PrefixConstants.DIC + "_"
				+ DicConstants.IS_USE, SysDic.class);
		request.setAttribute("isUseList", JSON.toJSON(isUseList));

		return "system/picTypeListPage";
	}

	/**
	 * 查询图片类型列表
	 * 
	 * @param request
	 * @return
	 */
	@RequiresPermissions("picType:view")
	@RequestMapping(value = "queryPicTypes", method = RequestMethod.GET)
	@ResponseBody
	public PageBean queryPicTypes(HttpServletRequest request) {
		try {
			return sysPicTypeService.queryPicTypes(getParams(request));
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return null;
	}

	/**
	 * 添加页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "addPicTypePage", method = RequestMethod.GET)
	public String addPicTypePage(HttpServletRequest request) {
		List<SysDic> platformList = kvClient.readList(PrefixConstants.DIC + "_"
				+ DicConstants.PLATFORM, SysDic.class);
		request.setAttribute("platformList", JSON.toJSON(platformList));

		return "system/addPicTypePage";
	}

	/**
	 * 增加图片类型
	 * 
	 * @param record
	 * @return
	 */
	@RequiresPermissions("picType:add")
	@RequestMapping(value = "addPicType", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO addPicType(SysPicType record) {
		ResultVO result = new ResultVO();
		try {
			record.setStatus(CommonConstants.ZERO);
			sysPicTypeService.insertSelective(record);
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
			result.setFail();
		}
		return result;
	}

	/**
	 * 修改图片状态
	 * 
	 * @param record
	 * @return
	 */
	@RequiresPermissions("picType:status")
	@RequestMapping(value = "editPicTypeStatus", method = RequestMethod.GET)
	@ResponseBody
	public ResultVO editPicTypeStatus(@RequestParam("id") Integer id,
			@RequestParam("status") String status) {
		ResultVO result = new ResultVO();
		try {
			SysPicType spt = new SysPicType();
			spt.setId(id);
			
			if (CommonConstants.ONE.equals(status)) {// 禁用
				if (sysPicUrlService.countByPicTypeId(id) > 0) {
					result.setError(AdminAjaxConstants.MSG_PIC_STATUS);
					return result;
				} else {
					spt.setStatus(CommonConstants.ONE);
				}
			} else {//启用
				spt.setStatus(CommonConstants.ZERO);
			}

			sysPicTypeService.updateByPrimaryKeySelective(spt);
		} catch (Exception e) {
			result.setFail();
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return result;
	}

	/**
	 * 修改页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "editPicTypePage", method = RequestMethod.GET)
	public String editPicTypePage(HttpServletRequest request, int id) {

		List<SysDic> platformList = kvClient.readList(PrefixConstants.DIC + "_"
				+ DicConstants.PLATFORM, SysDic.class);
		request.setAttribute("platformList", JSON.toJSON(platformList));
		SysPicType sysPicType = sysPicTypeService.selectByPrimaryKey(id);
		request.setAttribute("scfPicType", sysPicType);
		return "system/editPicTypePage";
	}

	/**
	 * 修改图片类型
	 * 
	 * @param record
	 * @return
	 */
	@RequiresPermissions("picType:update")
	@RequestMapping(value = "editPicType", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO editPicType(SysPicType spt) {
		ResultVO result = new ResultVO();
		try {
			sysPicTypeService.updateByPrimaryKeySelective(spt);
		} catch (Exception e) {
			result.setFail();
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return result;
	}

	//
	// /**
	// * 删除图片类型
	// * @param id
	// * @return
	// */
	// @RequiresPermissions("picType:delete")
	// @RequestMapping(value = "deletePicType", method = RequestMethod.GET)
	// @ResponseBody
	// public ResultVO oplogDeletePicType(int id) {
	// ResultVO result = new ResultVO();
	// try {
	// if(scfPicUrlService.countPicByPicType(id) > 0){
	// result.setMsg("请先解除与该类型关联的图片,再删除");
	// result.setStatus(Constants.FAILURE);
	// }else{
	// scfPicTypeService.deleteByPrimaryKey(id);
	// }
	// } catch (Exception e) {
	// result.setMsg("系统异常");
	// result.setStatus(Constants.FAILURE);
	// LOGGER.error(Exceptions.getStackTraceAsString(e));
	// }
	// return result;
	// }
	//

}
