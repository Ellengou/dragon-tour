package com.opengroup.lzy.tools.date;

import org.apache.commons.lang3.time.DateFormatUtils;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

/**
 * 日期工具类
 * 
 * @author lc
 *
 * @date 2017年1月1日 下午5:42:54
 */
public class DateUtils extends org.apache.commons.lang3.time.DateUtils {
	private static String[] parsePatterns = { "yyyy-MM-dd",
			"yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", "yyyy/MM/dd",
			"yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd HH:mm" };

	/**
	 * 得到日期字符串
	 * 
	 * @param style
	 *            :日期格式
	 * @return
	 */
	public static String getDate(Date date, DateStyle style) {
		return getDate(date, style.getValue());
	}

	public static String getNow(DateStyle style) {
		return getDate(new Date(), style.getValue());
	}

	private static String getDate(Date date, String pattern) {

		if (null == date)
			return DateFormatUtils.format(new Date(), pattern);
		return DateFormatUtils.format(date, pattern);

	}

	/**
	 * 得到当前时间戳
	 */
	public static String getMillis() {
		return String.valueOf(System.currentTimeMillis());
	}

	/**
	 * 得到当前年份字符串 格式（yyyy）
	 */
	public static String getYear(DateStyle style) {
		return DateToString(new Date(), DateStyle.YYYY);
	}

	/**
	 * 得到当前月份字符串 格式（MM）
	 */
	public static String getMonth() {
		return DateToString(new Date(), DateStyle.MM);
	}

	/**
	 * 得到当天字符串 格式（dd）
	 */
	public static String getDay() {
		return DateToString(new Date(), DateStyle.DD);
	}

	/**
	 * 得到日期字符串 默认格式（yyyy-MM-dd）
	 */
	private static String DateToString(Date date, DateStyle style) {
		String formatDate = null;
		if (null != style) {
			formatDate = DateFormatUtils.format(date, style.getValue());
		} else {
			formatDate = DateFormatUtils.format(date,
					DateStyle.YYYY_MM_DD.getValue());
		}
		return formatDate;
	}

	/**
	 * 日期型字符串转化为日期
	 */
	public static Date StringToDate(Object str) {
		if (str == null)
			return null;

		try {
			return parseDate(str.toString(), parsePatterns);
		} catch (ParseException e) {
			return null;
		}

	}

	/**
	 * 获取过去的天数 :算头不算尾巴 头:2017-01-01 尾:2017-01-03 那么得到天数：2
	 * 
	 * @param date
	 * @return
	 */
	public static long pastDays(Date date) {
		long t = new Date().getTime() - date.getTime();
		return t / (24 * 60 * 60 * 1000);
	}

	public static Date getDateStart(Date date) {
		if (date == null) {
			return null;
		}
		SimpleDateFormat sdf = new SimpleDateFormat(
				DateStyle.YYYY_MM_DD_HH_MM_SS.getValue());
		try {
			date = sdf.parse(DateToString(date, DateStyle.YY_MM_DD)
					+ " 00:00:00");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	public static Date getDateEnd(Date date) {
		if (date == null) {
			return null;
		}
		SimpleDateFormat sdf = new SimpleDateFormat(
				DateStyle.YYYY_MM_DD_HH_MM_SS.getValue());
		try {
			date = sdf.parse(DateToString(date, DateStyle.YY_MM_DD)
					+ " 23:59:59");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	/**
	 * 判断字符串是否是日期
	 * 
	 * @param timeString
	 * @return
	 */
	public static boolean isDate(String timeString) {
		SimpleDateFormat format = new SimpleDateFormat(
				DateStyle.YY_MM_DD.getValue());
		format.setLenient(false);
		try {
			format.parse(timeString);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	/**
	 * 获取系统时间Timestamp:可以精确到小数秒 例如：2017-01-20 04:33:38.531 
	 * Timestamp：sql jar
	 * @return
	 */
	public static Timestamp getSysTimestamp() {
		return new Timestamp(new Date().getTime());
	}

	// ============================================下面需要梳理========================================
	/**
	 * 生成时间随机数
	 * 
	 * @return
	 */
	public static String getDateRandom() {
		String s = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date());
		return s;
	}

	/**
	 * 获取昨天日期
	 * **/
	public static int getYestodayDate() {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String yesterday = new SimpleDateFormat("yyyyMMdd ").format(cal
				.getTime());
		return Integer.parseInt(yesterday.substring(5, 8));
	}

	public static String getCurrentDate() {
		TimeZone timeZoneChina = TimeZone.getTimeZone("Asia/Shanghai");// 获取时区
																		// 这句加上，很关键。
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		formatter.setTimeZone(timeZoneChina);
		String curDate = formatter.format(date);
		return curDate;
	}

	public static String getToDay() {
		TimeZone timeZoneChina = TimeZone.getTimeZone("Asia/Shanghai");// 获取时区
																		// 这句加上，很关键。
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("MMdd");
		formatter.setTimeZone(timeZoneChina);
		String curDate = formatter.format(date);
		return curDate;
	}

	public static String getCurrentTime() {
		TimeZone timeZoneChina = TimeZone.getTimeZone("Asia/Shanghai");// 获取时区
																		// 这句加上，很关键。
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("HHmmss");
		formatter.setTimeZone(timeZoneChina);
		String curDate = formatter.format(date);
		return curDate;
	}

	public static String getCurrentHour() {
		TimeZone timeZoneChina = TimeZone.getTimeZone("Asia/Shanghai");// 获取时区
																		// 这句加上，很关键。
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("HH");
		formatter.setTimeZone(timeZoneChina);
		String curDate = formatter.format(date);
		return curDate;
	}

	/**
	 * @param args
	 * @throws ParseException
	 */
	public static void main(String[] args) throws ParseException {
		// System.out.println(DateUtils.addSeconds(new Date(), 180));
	}
}
