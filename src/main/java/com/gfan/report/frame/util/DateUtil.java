package com.gfan.report.frame.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import org.apache.commons.lang.StringUtils;

public class DateUtil {

	public static String getStringDate(int lastday) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, lastday);
		return dateFormat.format(c.getTime());
	}

	public static String getStringWeek(int lastweek) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		c.add(Calendar.WEEK_OF_YEAR, lastweek);
		c.add(Calendar.DATE, 2 - c.get(Calendar.DAY_OF_WEEK));
		return dateFormat.format(c.getTime());
	}

	public static String getStringMonth(int lastmonth) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
		Calendar c = Calendar.getInstance();
		c.add(Calendar.MONTH, lastmonth);
		return dateFormat.format(c.getTime());
	}

	public static Date str2Date(String dateStr, String formatStr) {
		SimpleDateFormat sdformat = new SimpleDateFormat(formatStr);
		try {
			return sdformat.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 得到当前日期时间的字符串，格式是YYYY-MM-DD HH:MM:SS
	 * 
	 * @return 当前日期时间的字符串，格式是YYYY-MM-DD HH:MM:SS
	 */
	public static String DateTime() {
		Calendar calendar = Calendar.getInstance();
		StringBuffer date = new StringBuffer();
		date.append(calendar.get(Calendar.YEAR));
		date.append('-');
		date.append(calendar.get(Calendar.MONTH) + 1);
		date.append('-');
		date.append(calendar.get(Calendar.DAY_OF_MONTH));
		date.append(' ');
		date.append(calendar.get(Calendar.HOUR_OF_DAY));
		date.append(':');
		date.append(calendar.get(Calendar.MINUTE));
		date.append(':');
		date.append(calendar.get(Calendar.SECOND));
		return date.toString();
	}
	
	public static String getPeriods(String dataTime) {
		Date time = str2Date(dataTime, "yyyy-MM-dd");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 设置时间格式
		Calendar cal = Calendar.getInstance();
		cal.setTime(time);
		// 判断要计算的日期是否是周日，如果是则减一天计算周六的，否则会出问题，计算到下一周去了
		int dayWeek = cal.get(Calendar.DAY_OF_WEEK);// 获得当前日期是一个星期的第几天

		if (1 == dayWeek) {

			cal.add(Calendar.DAY_OF_MONTH, -1);

		}
		cal.setFirstDayOfWeek(Calendar.MONDAY);// 设置一个星期的第一天，按中国的习惯一个星期的第一天是星期一

		int day = cal.get(Calendar.DAY_OF_WEEK);// 获得当前日期是一个星期的第几天

		cal.add(Calendar.DATE, cal.getFirstDayOfWeek() - day);// 根据日历的规则，给当前日期减去星期几与一个星期第一天的差值

		String imptimeBegin = sdf.format(cal.getTime());

		cal.add(Calendar.DATE, 6);

		String imptimeEnd = sdf.format(cal.getTime());

		return imptimeBegin + "~" + imptimeEnd;
	}
	
	/**
	 * 把字符串转换为时间
	 * 
	 * @param dateStr
	 * @return
	 */
	public static Date str2Date(String dateStr) {
		return str2Date(dateStr, "yyyyMMddHHmmss");
	}
	
	/**
	 * 获取给定时间的，指定单位的数量之前的时间。
	 * 
	 * @param when
	 *            给定时间
	 * @param count
	 *            数量
	 * @param u
	 *            单位
	 * @return
	 */
	public static Date getBeforeDate(Date when, int count, TimeUnit u) {
		long l = when.getTime() - TimeUnit.MILLISECONDS.convert(count, u);
		return new Date(l);
	}
	/**
	 * 将Date转换为字符串,默认格式 {@value #DEFAULT_DATETIME_HYPHEN_FORMAT}
	 * 
	 * @param aDate
	 * @return
	 */
	public static String date2Str(Date aDate) {
		return date2Str(aDate, null);
	}
	
	/**
	 * 将Date转换为字符串
	 * 
	 * @param aDate
	 * @param pattern
	 *            格式
	 * @return
	 */
	public static String date2Str(Date aDate, String pattern) {
		if (aDate == null)
			return null;
		if (StringUtils.isEmpty(pattern))
			pattern = "yyyy-MM-dd HH:mm:ss";
		SimpleDateFormat df = new SimpleDateFormat(pattern);
		return df.format(aDate);
	}
	public static void main(String[] args) {
		System.out.println(DateTime());
	}

}