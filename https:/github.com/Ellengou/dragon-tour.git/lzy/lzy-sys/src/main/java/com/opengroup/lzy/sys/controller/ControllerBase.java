package com.opengroup.lzy.sys.controller;

import org.apache.commons.lang3.StringUtils;
import org.springframework.validation.BindingResult;

import com.opengroup.lzy.sys.constants.Constants;
import com.opengroup.lzy.sys.utils.UserUtil;

import javax.servlet.http.HttpServletRequest;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * 
 * @author lc
 *
 * @date 2017年1月1日 下午5:37:14
 */
public class ControllerBase {

	/**
	 * 解析参数
	 * 
	 * @param request
	 * **/
	public Map<String, Object> getParamsForString(HttpServletRequest request) {
		int begin = 0; // 开始行数
		int rows = 10; // 每页行数
		String orderBy = "id"; // 排序字段
		String order = "asc"; // 排序顺序

		Map<String, Object> params = new HashMap<>();
		if (StringUtils.isEmpty(request.getParameter(Constants.WEB_PAGE_NO)))
			params.put("begin", begin);
		if (StringUtils.isEmpty(request.getParameter(Constants.WEB_PAGE_SIZE)))
			params.put("rows", rows);
		if (StringUtils.isEmpty(request.getParameter(Constants.WEB_ORDER)))
			params.put("order", order);
		if (StringUtils.isEmpty(request.getParameter(Constants.WEB_ORDER_BY)))
			params.put("orderBy", orderBy);

		Map<String, String[]> oldParams = request.getParameterMap();
		Iterator<Map.Entry<String, String[]>> entries = oldParams.entrySet()
				.iterator();

		StringBuilder condition = new StringBuilder(""); // 条件拼接字符串
		int count = 1;
		while (entries.hasNext()) {
			Map.Entry<String, String[]> entry = entries.next();
			String keyName = entry.getKey();

			// 将所有参数放入map中
			if (entry.getValue()[0] != null && !entry.getValue()[0].equals("")
					&& !keyName.equals("begin") && !keyName.equals("rows")
					&& !keyName.equals("order") && !keyName.equals("orderBy")) {
				params.put(keyName, entry.getValue()[0]);
			}

			if (keyName.equals(Constants.WEB_PAGE_NO)) {
				params.put("begin", Integer.parseInt(request
						.getParameter(Constants.WEB_PAGE_NO)));
			} else if (keyName.equals(Constants.WEB_PAGE_SIZE)) {
				params.put("rows", Integer.parseInt(request
						.getParameter(Constants.WEB_PAGE_SIZE)));
			} else if (keyName.equals(Constants.WEB_ORDER)) {
				params.put("order", entry.getValue()[0].replace(" ", ""));
			} else if (keyName.equals(Constants.WEB_ORDER_BY)) {
				params.put("orderBy", entry.getValue()[0].replace(" ", ""));
			} else {
				if (keyName.split("-").length < 2)
					continue;
				String keyValue = entry.getValue()[0].trim();
				if (keyValue.isEmpty())
					continue;
				if (count == 1)
					condition.append(" where 1 = 1 ");
				if (keyName.startsWith("LIKE-")) { // like
					condition.append(" and " + getKeyName(keyName) + " like '%"
							+ keyValue + "%'");
				} else if (keyName.startsWith("EQ-")) { // ==
					condition.append(" and " + getKeyName(keyName) + " = "
							+ keyValue);
				} else if (keyName.startsWith("NE-")) { // <>
					condition.append(" and " + getKeyName(keyName) + " <> "
							+ keyValue);
				} else if (keyName.startsWith("LE-")) { // <=
					condition.append(" and " + getKeyName(keyName) + " <= "
							+ keyValue);
				} else if (keyName.startsWith("LT-")) { // <
					condition.append(" and " + getKeyName(keyName) + " < "
							+ keyValue);
				} else if (keyName.startsWith("GE-")) { // >=
					condition.append(" and " + getKeyName(keyName) + " >= "
							+ keyValue);
				} else if (keyName.startsWith("GT-")) { // >
					condition.append(" and " + getKeyName(keyName) + " > "
							+ keyValue);
				} else if (keyName.startsWith("IN-")) { // in
					condition.append(" and " + getKeyName(keyName) + " in ("
							+ keyValue + ")");
				}
				count++;
			}
		}
		params.put("cond", condition);
		return params;
	}

	/**
	 * 解析参数:
	 * 
	 * @param request
	 * **/
	public Map<String, Object> getParams(HttpServletRequest request) {
		Map<String, Object> params = new HashMap<>();
		Map<String, String[]> oldParams = request.getParameterMap();
		Iterator<Map.Entry<String, String[]>> entries = oldParams.entrySet()
				.iterator();
		while (entries.hasNext()) {
			Map.Entry<String, String[]> entry = entries.next();
			String keyName = entry.getKey();
			// 将所有参数放入map中
			if (entry.getValue()[0] != null && !entry.getValue()[0].equals("")) {
				if ("begin".equals(keyName) || "rows".equals(keyName)) {
					params.put(keyName, Integer.valueOf(entry.getValue()[0]));
				} else {
					params.put(keyName, entry.getValue()[0]);
				}
			}
		}
		params.put("orgId", UserUtil.getCurrentUser().getOrgId());
		params.put("companyId", UserUtil.getCurrentUser().getCompanyId());
		params.put("dataType", UserUtil.getCurrentUser().getDataType());
		return params;
	}

	/**
	 * 解析参数
	 * 
	 * @param request
	 * **/
	public Map<String, Object> getParamss(HttpServletRequest request) {
		Map<String, Object> params = new HashMap<>();
		Map<String, String[]> oldParams = request.getParameterMap();
		Iterator<Map.Entry<String, String[]>> entries = oldParams.entrySet()
				.iterator();
		while (entries.hasNext()) {
			Map.Entry<String, String[]> entry = entries.next();
			String keyName = entry.getKey();
			// 将所有参数放入map中
			if (entry.getValue()[0] != null && !entry.getValue()[0].equals("")) {
				if ("begin".equals(keyName) || "rows".equals(keyName)) {
					params.put(keyName, Integer.valueOf(entry.getValue()[0]));
				} else {
					params.put(keyName, entry.getValue()[0]);
				}
			}
		}

		return params;
	}

	private String getKeyName(String oldKeyName) {
		String[] oldKeyNames = oldKeyName.split("-");
		return oldKeyName.replace(oldKeyNames[0] + "-", "").trim();
	}

	protected String getErrorMsg(BindingResult bindingResult) {
		return bindingResult.getAllErrors().get(0).getDefaultMessage();
	}
}
