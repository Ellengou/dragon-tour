package com.opengroup.lzy.sys.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.opengroup.lzy.sys.domain.SysCompany;
import org.springframework.stereotype.Repository;

/**
 * 公司
 * 
 * @author lc
 *
 * @date 2017年1月2日 上午11:38:18
 */
public interface SysCompanyDao {
	int deleteByPrimaryKey(Integer id);

	int insert(SysCompany record);

	int insertSelective(SysCompany record);

	SysCompany selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(SysCompany record);

	int updateByPrimaryKey(SysCompany record);

	List<Integer> queryCompanysForId(Map<String, Object> params);

	/**
	 * 查询公司列表
	 * 
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> queryCompanys(Map<String, Object> params);

	/**
	 * 统计公司列表数
	 * 
	 * @param params
	 * @return
	 */
	int countCompanys(Map<String, Object> params);

	/**
	 * 查询子公司列表
	 * 
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> querySubCompanys(Map<String, Object> params);

	/**
	 * 查询子公司列表数
	 * 
	 * @param params
	 * @return
	 */
	int countSubCompanys(Map<String, Object> params);

	/**
	 * 查询关联子公司列表
	 * 
	 * @param params
	 * @return
	 */
	/*
	 * List<Map<String, Object>> queryRelationSubCompanys(Map<String, Object>
	 * params);
	 */
	List<Map<String, Object>> queryRelationCompanys(Map<String, Object> params);

	/**
	 * 查询关联子公司列表数
	 * 
	 * @param params
	 * @return
	 */
	/* int countRelationSubCompanys(Map<String, Object> params); */
	int countRelationCompanys(Map<String, Object> params);

	/**
	 * 查询所有公司信息
	 * 
	 * @return
	 */
	List<SysCompany> queryAllCompanys();

	List<Map<String, Object>> querySubCompanysByGys(Map<String, Object> params);

	List<Map<String, Object>> querySimpleCompany(Map<String, Object> params);

	/**
	 * 根据账号获取公司信息
	 * 
	 * @param registerName
	 * @return
	 */
	SysCompany getCompanyByRegisterName(String registerName);

	/**
	 * 根据公司名称
	 * 
	 * @param compName
	 * @return
	 */
	SysCompany getCompanyByCompName(String compName);

	/**
	 * 校验公司编号唯一
	 * 
	 * @param params
	 * @return
	 */
	int checkCompno(Map<String, Object> params);

	/**
	 * 导出数据查询
	 * 
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> querySubCompanysExport(Map<String, Object> params);

	/**
	 * 根据PK 获取企业
	 * 
	 * @param compPk
	 * @return
	 */
	SysCompany selectByCompPk(String compPk);

	/**
	 * 查询公司社会信用代码是否唯一
	 * 
	 * @param creditCode
	 * @return
	 */
	int checkCreditCode(String creditCode);

	/**
	 * 查询其他系统中用户与公司的关联关系
	 * 
	 * @param params
	 *            (companyId、compCoreId、isSupp、isCustomer、merchantName)
	 * @return
	 */
	List<Map> queryOtherSysCompanyAndUserInfo(Map params);

	/**
	 * 查询其他系统中用户与公司的关联关系
	 * 
	 * @param params
	 *            (companyId、compCoreId、isSupp、isCustomer、merchantName)
	 * @return
	 */
	int countOtherSysCompanyAndUserInfo(Map params);

	/**
	 * 根据compCode 获取企业信息
	 * 
	 * @param compPk
	 * @return
	 */
	SysCompany selectByCompCode(@Param("compCoreId") Integer compCoreId,
			@Param("compCode") String compCode);

	List<Map<String, Object>> selectCompanysByLevel1();

	/**
	 * 根据核心企业标识查询核心企业
	 * 
	 * @param compPk
	 * @return
	 */
	SysCompany selectByCompSianName(String compSianName);

	List<Integer> selectIsCore();

}
