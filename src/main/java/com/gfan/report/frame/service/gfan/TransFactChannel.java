/**
 * TransRankProduct.java
 * com.gfan.trans
 * Function： 把gfan_cfg_banner和gfan_code_banner表的数据传输过来
 *
 *   ver     date    author    department              
 * ──────────────────────────────────────
 *   V1.0   2013-10-10  linger   TC
 *
 * Copyright (c) 2013, Gfan Company All Rights Reserved.
 */

package com.gfan.report.frame.service.gfan;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.gfan.report.frame.util.DataBaseCommend;
import com.gfan.report.frame.util.DateUtil;


/**
 * @ClassName TransRankProduct
 * @Description 把fact_channel表的数据传输过来。用来算推荐位转化。
 * @author yuanjianqiang@gfan.com
 * @date 2015-06-29
 */
public class TransFactChannel {

	public static final Log LOG = LogFactory.getLog(TransFactChannel.class);
	/** 连接数据库的URL */
	private static String url = "";
	/** 指定数据的用户名和密码 */
	private static String username = "";
	private static String password = "";
	// 关闭
	public static void free(ResultSet rs, Statement s1, Statement s2,
			Connection cn1, Connection cn2) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (s1 != null) {
				s1.close();
			}
			if (s2 != null) {
				s2.close();
			}
			if (cn1 != null) {
				cn1.close();
			}
			if (cn2 != null) {
				cn2.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

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
		}
	}

	/**
	 * @Title: main
	 * @Description: 把fact_channel表的数据传输过来。用来算推荐位转化。
	 * @param @param args 设定文件
	 * @return void 返回类型
	 * @throws
	 */
	@SuppressWarnings("resource")
	public static void main(String dataTime) {

//		String dataTime = args[0];
//		String dataTime = "2015-07-05";
		Date dataTimeData = DateUtil.str2Date(dataTime,"yyyy-MM-dd");
		Date dataBeforeTimeData = DateUtil.getBeforeDate(dataTimeData,8,TimeUnit.DAYS);
		String dataBeforeTime = DateUtil.date2Str(dataBeforeTimeData,"yyyy-MM-dd");
		
		deleteFactChannel(dataTime,dataBeforeTime);
		deleteTransLogData(dataTime);

		ResultSet rs = null;
		Statement s1 = null; // gfan_union_game库
		Statement s2 = null;// game_channel库
		Connection cn1 = null;// gfan_union_game库
		Connection cn2 = null;// game_channel库

		long startTime = 0;// 开始时间
		long endTime = 0;// 结束时间
		int count = 1; // 计数
		int onerun = 0;// 执行的最大数
		int datanum = 0; // 总条数
		int num = 0; // 取整最大数据
		StringBuffer sbf = new StringBuffer();

		try {
			System.out.println("先等待三秒");
			Thread.sleep(3000);

			startTime = System.currentTimeMillis();
			System.out.println("startTime：" + startTime);
			Class.forName("com.mysql.jdbc.Driver");

			while (cn1 == null) {
				url = DataBaseCommend.getGfanStatUrl();
				username = DataBaseCommend.getGfanStatUserName();
				password = DataBaseCommend.getGfanStatPassWord();
				cn1 = DriverManager.getConnection(url, username, password);
				cn1.setAutoCommit(false);
			}
			while (cn2 == null) {
				url = DataBaseCommend.getGameChannelUrl();
				username = DataBaseCommend.getGameChannelUserName();
				password = DataBaseCommend.getGameChannelPassWord();
				cn2 = DriverManager.getConnection(url, username, password);
				cn2.setAutoCommit(false);
			}
			System.out.println("数据库的链接：" + sbf.toString());
			// 导入玩家的数据
			if (cn1 != null) {
				String sourceSql = "select count(1) from fact_channel where DATA_TIME<='"+dataTime+"' AND DATA_TIME>='"+dataBeforeTime+"' order by id";

				System.out.println("查询fact_channel记录数的语句为："
						+ sourceSql);

				s2 = cn2.createStatement();
				s1 = cn1.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				rs = s1.executeQuery(sourceSql);
				if (rs.next()) {// 先查询数据源表，获取总数据条数
					datanum = rs.getInt(1);
				}

				System.out.println("fact_channel，总记录数：" + datanum
						+ "条");
				onerun = 1000;// 执行的最大数
				num = datanum / onerun;// 计算出总条数符合每批3000的数量是多少

				s1.setMaxRows(datanum);
				if (datanum > onerun) {
					s1.setFetchSize(onerun);// 每批执行的数据条数
				} else {
					s1.setFetchSize(datanum);// 每批执行的数据条数
				}
				
				StringBuffer sbf2 = new StringBuffer();

				sbf2.append("select USER_ID,DATA_TIME,CHANNEL_CODE,CHANNEL_NAME,DAY_ACTIVATE_COUNT,DAY_ACTIVATE_DIS,REMAIN2_RATE,REMAIN7_RATE,INSERT_TIME ");
				sbf2.append(" from fact_channel where DATA_TIME<='"+dataTime+"' AND DATA_TIME>='"+dataBeforeTime+"' order by id");
				rs = s1.executeQuery(sbf2.toString());

				String localTable = "fact_channel";

				String sql = "insert into "
						+ localTable
						+ "(USER_ID,DATA_TIME,CHANNEL_CODE,CHANNEL_NAME,DAY_ACTIVATE_COUNT,DAY_ACTIVATE_DIS,REMAIN2_RATE,REMAIN7_RATE,INSERT_TIME) values('";

				String sql3 = "";

				while (rs.next()) {
					sql3 = sql + rs.getString("USER_ID") + "','" + rs.getString("DATA_TIME")
							+ "','" + rs.getString("CHANNEL_CODE") + "','"
							+ rs.getString("CHANNEL_NAME") + "','"
							+ rs.getInt("DAY_ACTIVATE_COUNT") + "','"
							+ rs.getInt("DAY_ACTIVATE_DIS") + "','"
							+ rs.getString("REMAIN2_RATE") + "','"
							+ rs.getString("REMAIN7_RATE") + "','"
							+ rs.getString("INSERT_TIME") + "')";

					s2.addBatch(sql3);

					if (count > num) {// 3000取整后剩余的小数据量就顺序插入
						s2.executeBatch();
						cn2.commit();
						s2.clearBatch();
					} else {// 数据够批次的就按批量插入
						if (count % onerun == 0) {// 3000条一批插入
							s2.executeBatch();
							cn2.commit();
							s2.clearBatch();
						}
					}
					count++;
				}
				
				endTime = System.currentTimeMillis();
				System.out.println("成功导入日志数据：" + (count - 1) + "条，耗时"
						+ (endTime - startTime) / 1000 + "秒");
				// 导入日志数据
				s2.execute("insert into trans_log(data_time,table_name,flag,duration,insert_time) values('"
						+ dataTime
						+ "','fact_channel',0,"
						+ (endTime - startTime) / 1000 + ",now())");
				cn2.commit();
				Thread.sleep(2000);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			free(rs, s1, s2, cn1, cn2);
		}
	}

	private static void deleteTransLogData(String dataTime) { // 删除传输日志
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {

			// 加载MySql的驱动类
			Class.forName("com.mysql.jdbc.Driver");
			// 连接
			url = DataBaseCommend.getGameChannelUrl();
			username = DataBaseCommend.getGameChannelUserName();
			password = DataBaseCommend.getGameChannelPassWord();
			conn = DriverManager.getConnection(url, username, password);

			String sql = "delete from trans_log where data_time='" + dataTime
					+ "' and table_name='fact_channel'";

			System.out.println("删除本地的传输日志的记录,sql语句：" + sql);
			stmt = conn.createStatement();
			stmt.execute(sql);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("删除本地库中，dataTime:" + dataTime + ",的传输日志时，出错！");
		} finally {
			free(conn, stmt, rs);
		}
	}

	private static void deleteFactChannel(String dataTime,String dataBeforeTime) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {

			// 加载MySql的驱动类
			Class.forName("com.mysql.jdbc.Driver");
			// 连接
			while (conn == null) {
				url = DataBaseCommend.getGameChannelUrl();
				username = DataBaseCommend.getGameChannelUserName();
				password = DataBaseCommend.getGameChannelPassWord();
				conn = DriverManager.getConnection(url, username, password);
			}
			
			String sql = "delete from fact_channel where DATA_TIME<='"+dataTime+"' AND DATA_TIME>='"+dataBeforeTime+"'";
			System.out.println("删除本地的fact_channel数据,sql语句：" + sql);
			stmt = conn.createStatement();
			stmt.execute(sql);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("删除本地库中，fact_channel时，出错！");
		} finally {
			free(conn, stmt, rs);
		}

	}
}
