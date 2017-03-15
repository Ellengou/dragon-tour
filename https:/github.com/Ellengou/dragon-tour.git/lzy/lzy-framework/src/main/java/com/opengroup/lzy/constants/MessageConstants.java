package com.opengroup.lzy.constants;

/**
 * 
 * @author lc
 *
 * @date 2017年1月3日 下午4:57:53
 */
public class MessageConstants {

	/**
	 * 验证码状态
	 * 
	 * @author lc
	 *
	 * @date 2017年1月3日 下午4:58:28
	 */
	public static final class SmsStatus {
		/**
		 * 未激活
		 */
		public static final String INACTIVE = "inactive";
		/**
		 * 已激活
		 */
		public static final String ACTIVATED = "activated";
	}

	/**
	 * 短信的类型
	 * 
	 * @author lc
	 *
	 * @date 2017年1月3日 下午4:58:57
	 */

	public static final class MessageNode {

		/**
		 * 注册成功
		 */
		public static final String REGISTER_SUCCESS = "redister_success";
		/**
		 * 通过手机号注册
		 */
		public static final String REGISTER_BY_MOBILE_NUMBER = "register_by_mobile_number";
		/**
		 * 绑定手机号
		 */
		public static final String BINDING_MOBILE_NUMBER = "binding_mobile_number";
		/**
		 * 修改绑定手机号
		 */
		public static final String CHANGE_BINDING_MOBILE_NUMBER = "change_binding_mobile_number";
		/**
		 * 通过手机找回登录密码
		 */
		public static final String FIND_LOGIN_PASSWORD_BY_MOBILE = "find_login_password_by_mobile";
		/**
		 * 通过邮箱找回登录密码
		 */
		public static final String FIND_LOGIN_PASSWORD_BY_EMAIL = "find_login_password_by_email";
		/**
		 * 绑定邮箱
		 */
		public static final String BINDING_EMAIL = "binding_email";
		/**
		 * 修改绑定邮箱
		 */
		public static final String CHANGE_BINDING_EMAIL = "change_binding_email";
		/**
		 * 绑定 银行卡
		 */
		public static final String BINDING_BANK = "binding_bank";
		/**
		 * 修改 解绑 银行卡
		 */
		public static final String CHANGE_BINDING_BANK = "change_binding_bank";
		/**
		 * 设置交易密码
		 */
		public static final String SET_CASH_PASSWORD_BY_MOBILE = "set_cash_password_by_mobile";

		/**
		 * 通过手机号找回交易密码
		 */
		public static final String FIND_CASH_PASSWORD_BY_MOBILE = "find_cash_password_by_mobile";

		/**
		 * 充值
		 */
		public static final String RECHARGE = "recharge";

		/**
		 * 贷款申请
		 */
		public static final String FRONT_USER_LOAN = "front_user_loan";

		/**
		 * 核心企业入住
		 */
		public static final String COMPANY_RESERVATION = "company_reservation";
		/**
		 * 提前几天还款提醒
		 * 
		 */
		public static final String REPAY_ALERT_DAYS_BEFORE = "repay_alert_days_before";
		/**
		 * 放款短信
		 * 
		 */
		public static final String ADVANCE_LOAN_MONEY = "advance_loan_money";
		/**
		 * 实名认证为员工
		 *
		 */
		public static final String AUTHENTIC_AS_YG = "authentic_as_yg";
		/**
		 * 激活 银行卡
		 */
		public static final String ACTIVATE_BANK_CARD = "activate_bank_card";
		/**
		 * 执行 定期钱包的按月付息到期还本的还款计划
		 */
		public static final String FULL_NEXT_TO_DAY = "full_next_to_day";	
		/**
		 * 满标发送短信
		 */
		public static final String FULL_LOAN_SMS = "full_loan_sms";

	}

	/**
	 * 短信类型
	 * 
	 * @author lc
	 *
	 * @date 2017年1月3日 下午4:59:29
	 */
	public final static class Messagetype {
		/**
		 * 邮件
		 */
		public final static String EMAIL = "email";
		/**
		 * 站内信
		 */
		public final static String LETTER = "letter";
		/**
		 * 短信
		 */
		public final static String SMS = "sms";
	}

}
