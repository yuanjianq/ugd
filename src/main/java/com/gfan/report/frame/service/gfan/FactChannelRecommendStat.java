/**
 * DataCalculate.java
 * com.gfan.calculate
 * Function： TODO 
 *
 *   ver     date    author    department              
 * ──────────────────────────────────────
 *   V1.0   2013-10-10  linger   TC
 *
 * Copyright (c) 2013, Gfan Company All Rights Reserved.
 */

package com.gfan.report.frame.service.gfan;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.LinkedList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.gfan.report.frame.util.DataBaseCommend;
import com.gfan.report.frame.util.DateUtil;

/**
 * @ClassName DataCalculate.java
 * @Description 调用存储过程计算的类，计算【机锋市场】的新增人数和次日留存和7日留存
 * @author yuanjianqiang@gfan.com
 * @date 2015-07-08
 */
public class FactChannelRecommendStat {

	public static final Log LOG = LogFactory.getLog(FactChannelRecommendStat.class);
	/** 连接数据库的URL */
	private static String url = "";
	/** 指定数据的用户名和密码 */
	private static String username = "";
	private static String password = "";
	/**
	 * @Title: main
	 * @Description: 调用存储过程计算的类
	 * @param @param args 设定文件
	 * @return void 返回类型
	 * @throws
	 */

	@SuppressWarnings("resource")
	public static void main(String dataTime) {

//		String dataTime = args[0];
//		String dataTime = "2015-07-26";
		
		LinkedList<FactChannel> proList = new LinkedList<FactChannel>();

		System.out.println("计算一些机锋市场内部的统计，开始时间：" + DateUtil.DateTime());

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {

			url = DataBaseCommend.getGfanStatUrl();
			username = DataBaseCommend.getGfanStatUserName();
			password = DataBaseCommend.getGfanStatPassWord();
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, username, password);
			while (true) {

				// 查询
				String productSQL = " SELECT ID,CHANNEL_CODE FROM dis_channel where ISVALID=1 ;";

				stmt = conn.prepareStatement(productSQL);
				rs = stmt.executeQuery();
				while (rs.next()) {
					FactChannel gp = new FactChannel();
					gp.setId(rs.getInt("ID"));
					gp.setChannelCode(rs.getString("CHANNEL_CODE"));
					proList.add(gp);
				}

				CallableStatement cst = null;

				for (FactChannel p : proList) {
					cst = conn.prepareCall("{call FactReportChannelDay(?,?)}");
					// 设置参数
					cst.setString(1, dataTime);
					cst.setString(2, p.getChannelCode());
					System.out.println("call FactReportChannelDay('"+dataTime+"','"+p.getChannelCode()+"');");
					cst.execute();
				}
				break;
			}

			System.out.println("计算一些机锋市场内部的统计，结束时间："
					+ DateUtil.DateTime());
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e);
		} finally {
			free(conn, stmt, rs);
		}
      TransFactChannel.main(dataTime);
	}
	
	// 关闭
	public static void free(Connection conn, Statement stmt, ResultSet rs) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e);
		}
	}
	
	

}
