package com.opengroup.lzy.sys.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSON;
import com.opengroup.lzy.component.PageBean;
import com.opengroup.lzy.component.ResultVO;
import com.opengroup.lzy.constants.CommonConstants;
import com.opengroup.lzy.constants.DefaultUploadDir;
import com.opengroup.lzy.sys.domain.SysPicType;
import com.opengroup.lzy.sys.domain.SysPicUrl;
import com.opengroup.lzy.sys.service.SysPicTypeService;
import com.opengroup.lzy.sys.service.SysPicUrlService;
import com.opengroup.lzy.tools.Exceptions;
import com.opengroup.lzy.tools.kv.KvClient;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * 图片设置
 * 
 * @author lc
 *
 * @date 2017年1月15日 下午7:45:31
 */
@Controller
@RequestMapping("admin/system/picUrl")
public class SysPicUrlController extends ControllerBase {
	private static final Logger LOGGER = LoggerFactory
			.getLogger(SysPicUrlController.class);
	@Resource
	private SysPicUrlService sysPicUrlService;
	@Resource
	private SysPicTypeService sysPicTypeService;
	@Resource
	private KvClient kvClient;

	/**
	 * 默认页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "picUrlListPage", method = RequestMethod.GET)
	public String picUrlPage(HttpServletRequest request) {
		// 查询所有栏目
		List<SysPicType> picTypeList = sysPicTypeService.queryByStatus();
		request.setAttribute("picTypeList", JSON.toJSON(picTypeList));

		return "system/picUrlListPage";
	}

	/**
	 * 查询图片列表
	 *
	 * @param request
	 * @return
	 */
	@RequiresPermissions("picUrl:view")
	@RequestMapping(value = "queryPicUrls", method = RequestMethod.POST)
	@ResponseBody
	public PageBean queryPicUrls(HttpServletRequest request) {
		try {
			return sysPicUrlService.queryPicUrls(getParams(request));
		} catch (Exception e) {
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return null;
	}

	/**
	 * 增加页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "addPicUrlPage", method = RequestMethod.GET)
	public String addPicUrlPage(HttpServletRequest request) {
		// 查询所有栏目
		List<SysPicType> picTypeList = sysPicTypeService.queryByStatus();
		request.setAttribute("picTypeList", JSON.toJSON(picTypeList));
		return "system/addPicUrlPage";
	}

	/**
	 * 增加图片
	 *
	 * @param record
	 * @return
	 */
	@RequiresPermissions("picUrl:add")
	@RequestMapping(value = "addPicUrl", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO addPicUrl(SysPicUrl spu) {
		ResultVO result = new ResultVO();
		int count = 0;
		try {
			sysPicUrlService.insertSelective(spu);
			// redis
			kvClient.add2List(CommonConstants.SYS_PIC + spu.getPicTypeId(), spu);
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
	@RequestMapping(value = "editPicUrlPage", method = RequestMethod.GET)
	public String editPicUrlPage(HttpServletRequest request, int id) {
		// 查询图片详情
		SysPicUrl sysPicUrl = sysPicUrlService.selectByPrimaryKey(id);
		request.setAttribute("sysPicUrl", sysPicUrl);
		// 查询所有栏目
		List<SysPicType> picTypeList = sysPicTypeService.queryByStatus();

		request.setAttribute("picTypeList", JSON.toJSON(picTypeList));
		return "system/editPicUrlPage";
	}

	/**
	 * 修改图片
	 *
	 * @param record
	 * @return
	 */
	@RequiresPermissions("picUrl:update")
	@RequestMapping(value = "editPicUrl", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO editPicUrl(SysPicUrl spu) {
		ResultVO result = new ResultVO();
		try {
			SysPicUrl spu1 = sysPicUrlService.selectByPrimaryKey(spu.getId());
			/**
			 * 判断原来的图片类型是否变化
			 */
			if (spu1.getPicTypeId().intValue() == spu.getPicTypeId().intValue()) {// 说明没有改变类型
				// redis
				List<SysPicUrl> spuRedis = kvClient.readAndDelList(
						CommonConstants.SYS_PIC + spu.getPicTypeId(),
						SysPicUrl.class);
				Iterator<SysPicUrl> it = spuRedis.iterator();
				while (it.hasNext()) {
					SysPicUrl x = it.next();
					if (x.getId().intValue() == spu.getId().intValue()) {
						it.remove();
					}
				}
				spuRedis.add(spu);
				kvClient.add2List(CommonConstants.SYS_PIC + spu.getPicTypeId(),
						spuRedis);

			} else {// 说明改变类型
				// redis：原来的数据
				List<SysPicUrl> spuRedis1 = kvClient.readAndDelList(
						CommonConstants.SYS_PIC + spu1.getPicTypeId(),
						SysPicUrl.class);
				if(spuRedis1.size()==1){
					result.setFail("该图片不能更换类型，至少保留一个");
					return result;
				}
		
					Iterator<SysPicUrl> it = spuRedis1.iterator();
					while (it.hasNext()) {
						SysPicUrl x = it.next();
						if (x.getId().intValue() == spu.getId().intValue()) {
							it.remove();
						}
					}
					
				//老数据
				kvClient.add2List(CommonConstants.SYS_PIC + spu1.getPicTypeId(),
						spuRedis1);
				//新数据
				kvClient.add2List(CommonConstants.SYS_PIC + spu.getPicTypeId(),
						spu);
			}
			// TODO 判断原来的图片内容是否修改，如果修改，那么就要删除原来的图片

			sysPicUrlService.updateByPrimaryKeySelective(spu);
		} catch (Exception e) {
			result.setFail();
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return result;
	}

	/**
	 * 删除图片
	 *
	 * @param id
	 * @return
	 */
	@RequiresPermissions("picUrl:delete")
	@RequestMapping(value = "deletePicUrl", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO deletePicUrl(int id) {
		ResultVO result = new ResultVO();
		try {
			SysPicUrl spu = sysPicUrlService.selectByPrimaryKey(id);
			if (null == spu || CommonConstants.ZERO.equals(spu.getStatus())) {// 禁用的情况下可以删除
				result.setFail("该图片状态：'启用'，不能删除");
				return result;
			}
			sysPicUrlService.deleteByPrimaryKey(id);
		} catch (Exception e) {
			result.setFail();
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return result;
	}

	/**
	 * 启用、禁用
	 * 
	 * @param id
	 * @param status
	 * @param picTypeId
	 * @return
	 */
	@RequiresPermissions("picUrl:isUse")
	@RequestMapping(value = "isUsePicTypeStatus", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO isUsePicTypeStatus(@RequestParam("id") Integer id,
			@RequestParam("status") String status,
			@RequestParam("picTypeId") Integer picTypeId) {
		ResultVO result = new ResultVO();
		try {

			if (CommonConstants.ONE.equals(status)) {// 禁用
				List<SysPicUrl> spuList = sysPicUrlService
						.selectByPicTypeId(picTypeId);
				if (null != spuList && spuList.size() == 1) {
					result.setFail("该图片不能禁用，至少保留一个");
					return result;
				}
				
				SysPicUrl spu = null;
				for (SysPicUrl o : spuList) {
					if (id.intValue() == o.getId().intValue()) {
						spu = o;
					}
				}
				spu.setStatus(status);
				sysPicUrlService.updateByPrimaryKeySelective(spu);
				// redis
				List<SysPicUrl> spuRedis = kvClient.readAndDelList(
						CommonConstants.SYS_PIC + picTypeId, SysPicUrl.class);
				Iterator<SysPicUrl> it = spuRedis.iterator();
				while (it.hasNext()) {
					SysPicUrl x = it.next();
					if (x.getId().intValue() == spu.getId().intValue()) {
						it.remove();
					}
				}
				kvClient.add2List(CommonConstants.SYS_PIC + spu.getPicTypeId(),
						spuRedis);

			} else {// 启用
				SysPicUrl spu = sysPicUrlService.selectByPrimaryKey(id);
				spu.setStatus(status);
				sysPicUrlService.updateByPrimaryKeySelective(spu);
				// redis
				kvClient.add2List(CommonConstants.SYS_PIC + picTypeId, spu);
			}

		} catch (Exception e) {
			result.setFail();
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return result;
	}

	/**
	 * 上传图片
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "uploadPic", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO oplogUploadPic(HttpServletRequest request) {
		ResultVO result = new ResultVO();
		try {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			MultipartFile loadfile = multiRequest.getFile("file_name");
			if (null != loadfile && !loadfile.isEmpty()) {
				String fname = loadfile.getOriginalFilename();
				String dir = DefaultUploadDir.getSystemPicDir();
				fname = new Date().getTime() + "_" + fname;
				String localfilename = dir + fname;
				File file = new File(localfilename);
				file.createNewFile();
				OutputStream fileout = new FileOutputStream(file);
				BufferedInputStream filein = new BufferedInputStream(
						loadfile.getInputStream());
				byte[] b = new byte[1024];
				int len = 0;
				while ((len = filein.read(b)) != -1) {
					fileout.write(b, 0, len);
				}
				fileout.flush();
				fileout.close();
				filein.close();
				String url = dir + fname;
				result.setMsg(url);
			} else {
				result.setFail("未获取到图片信息");
			}
		} catch (Exception e) {
			result.setFail();
			LOGGER.error(Exceptions.getStackTraceAsString(e));
		}
		return result;
	}
}
