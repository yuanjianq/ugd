package com.gfan.report.frame.util;


import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class GetPropertyUtil {

	// 方法一：通过java.util.ResourceBundle读取资源属性文件
	public static String getPropertyByName(String path, String name) {
		String result = "";

		try {
			// 方法一：通过java.util.ResourceBundle读取资源属性文件
			result = java.util.ResourceBundle.getBundle(path).getString(name);
//			System.out.println("name:" + result);
		} catch (Exception e) {
			System.out.println("getPropertyByName2 error:" + name);
		}
		return result;
	}

	// 方法二：通过类加载目录getClassLoader()加载属性文件
	public static String getPropertyByName2(String path, String name) {
		String result = "";

		// 方法二：通过类加载目录getClassLoader()加载属性文件
		InputStream in = GetPropertyUtil.class.getClassLoader()
				.getResourceAsStream(path);
		Properties prop = new Properties();
		try {
			prop.load(in);
			result = prop.getProperty(name).trim();
			System.out.println("name:" + result);
		} catch (IOException e) {
			System.out.println("读取配置文件出错");
			e.printStackTrace();
		}
		return result;
	}

}
