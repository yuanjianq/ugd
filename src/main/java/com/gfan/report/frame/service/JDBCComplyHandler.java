package com.gfan.report.frame.service;

import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.gfan.report.frame.util.DataBase;
import com.gfan.report.frame.util.DataBaseCommend;
import com.gfan.report.frame.util.DateUtil;
import com.gfan.report.frame.util.ExcelReader;
import com.gfan.report.frame.util.hashMD5Util;

public class JDBCComplyHandler extends DataBase {
	
	/** 连接数据库的URL */
	private String url = "";
	/** 指定数据的用户名和密码 */
	private String username = "";
	private String password = "";
	private String sql = "";
	/**定义一个结果集 用于放回查询结果*/  
    private ResultSet resultSet=null;
	//保存状态
	private int isOK = 0;
	//保存数据条数
	private int count = 0;
	//错误信息
	private String msg="";
	//扣量初始值
	private int dis = 0;
	

	
	/**
	 * 角色管理
	 * 
	 * @param sql p_role 
	 *            更新sql语句
	 * @return
	 */
	public List<String> roleInsert(String name,String name2,String name3) {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		sql = "insert into p_role(`value`,`name`,`desc`)values('"
					+ name + "','"
					+ name2 + "','"
					+ name3 + "')";
		isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list= new ArrayList<String>();
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	
	
	/**
	 * 角色&user管理
	 * 
	 * @param sql  p_member_role
	 *            更新sql语句
	 * @return
	 * @throws SQLException 
	 */
	public List<String> pmRoleInsert(String user_id,String role_id) throws SQLException {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		List<String> list= new ArrayList<String>();
		list = pmRoleQuery(user_id);
		if(list.get(0) == "0"){
		sql = "replace into p_member_role(user_id,role_id)values('"
					+ user_id + "','"
					+ role_id + "')";
		}else{
		sql = "UPDATE p_member_role set role_id='"+ role_id + "' where user_id='"
					+ user_id + "'";	
		}
		isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list2= new ArrayList<String>();
		list2.add(msg);
		list2.add(String.valueOf(isOK));
		db.coles();
		return list2;
	}
	
	/**
	 * user管理
	 * 
	 * @param sql user
	 *            更新sql语句
	 * @return
	 */
	public List<String> userInsert(String display_name,String email) {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		sql = "insert into `user`(display_name,user_name,email,register_time)values('"
					+ display_name + "','"
					+ email + "','"
					+ email + "','"
					+ DateUtil.DateTime() + "')";
		isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list= new ArrayList<String>();
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * password管理  user_pwd
	 * 
	 * @param sql
	 *            更新sql语句
	 * @return
	 * @throws SQLException 
	 */
	public List<String> userPwdInsert(String user_name,String pwd_hash_before) throws SQLException {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		List<String> list= new ArrayList<String>();
		list = userIDQuery(user_name);
		//加密处理
		String pwd_salt = hashMD5Util.produceSalt();
		String pwd_hash = hashMD5Util.productNewPassword(pwd_hash_before, pwd_salt);
		db.connectionDB(url, username, password);
		sql = "insert into user_pwd(user_id,pwd_hash,pwd_salt)values('"
				+ list.get(0) + "','"
				+ pwd_hash + "','"
				+ pwd_salt + "')";
		List<String> list2= new ArrayList<String>();
		isOK = db.update(sql);
		msg = db.getMsg();
		list2.add(msg);
		list2.add(String.valueOf(isOK));
		db.coles();
		return list2;
	}
	
	
	/**
	 * 单机excel批量新增数据
	 * 
	 * @param sql
	 *            更新sql语句
	 * @return
	 */
	public List<Integer> excelInsert(InputStream is,String userid) {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		// String[] s = {"2014-07-06","广州七达信息技术有限公司","1033363","老K斗地主","12"};
		String[] s = new String[40];
		Map<Integer, String> map = ExcelReader.readExcelContent(is);
		System.out.println("获得Excel表格的内容:");
		for (int i = 1; i <= map.size(); i++) {
			System.out.println(map.get(i));
			s = map.get(i).split("_");
			sql = "insert into rep_dj_device_count(DATA_TIME,USER_ID,CHANNEL_NAME,PRODUCT_ID,PRODUCT_NAME,REGISTER_USER,INSERT_TIME)values('"
					+ s[0] + "','"
					+ s[1] + "','"
					+ s[2] + "','"
					+ s[3] + "','"
					+ s[4] + "','"
					+ s[5] + "','"
					+ DateUtil.DateTime() + "')";
			isOK = db.update(sql);
			count++;
		}
		List<Integer> list= new ArrayList<Integer>();
		list.add(isOK);
		list.add(count);
		db.coles();
		return list;
	}
	
	/**
	 * 单机单条新增数据
	 * 
	 * @param sql
	 *            更新sql语句
	 * @return
	 */
	public List<String> djInsert(String startTime,String userID,String channelName,String productID,String productName,String registerUser) {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		sql = "insert into rep_dj_device_count(DATA_TIME,USER_ID,CHANNEL_NAME,PRODUCT_ID,PRODUCT_NAME,REGISTER_USER,INSERT_TIME)values('"
					+ startTime + "','"
					+ userID + "','"
					+ channelName + "','"
					+ productID + "','"
					+ productName + "','"
					+ registerUser + "','"
					+ DateUtil.DateTime() + "')";
		isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list= new ArrayList<String>();
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	
	/**
	 * 联运新增渠道数据
	 * 
	 * @param sql
	 *            更新sql语句
	 * @return
	 */
	public List<String> lyInsert(Map<String, String> params) {
		url = DataBaseCommend.getGfanUnionGameUrl();
		username = DataBaseCommend.getGfanUnionGameUserName();
		password = DataBaseCommend.getGfanUnionGamePassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		sql = "insert into BASE_GAME_CHANNEL(USER_ID,CHANNEL_ID,CHANNEL_NAME,PRODUCT_ID,PRODUCT_NAME,DEAL_MODE,ORDER_ID,INSERT_TIME)values('"
					+ params.get("userID") + "','"
					+ params.get("channelID") + "','"
					+ params.get("channelName") + "','"
					+ params.get("productID") + "','"
					+ params.get("productName") + "','"
					+ params.get("dealMode") + "','"
					+ params.get("orderID") + "','"
					+ DateUtil.DateTime() + "')";
		isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list= new ArrayList<String>();
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * 机锋市场新增渠道数据 1 线上
	 * 
	 * @param sql
	 *            更新sql语句
	 * @return
	 */
	public List<String> gfanInsert(Map<String, String> params) {
		url = DataBaseCommend.getGfanStatUrl();
		username = DataBaseCommend.getGfanStatUserName();
		password = DataBaseCommend.getGfanStatPassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		sql = "insert into dis_channel(USER_ID,CHANNEL_CODE,CHANNEL_NAME,INSERT_TIME)values('"
					+ params.get("userID") + "','"
					+ params.get("channelID") + "','"
					+ params.get("channelName") + "','"
					+ DateUtil.DateTime() + "')";
		isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list= new ArrayList<String>();
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * 机锋市场新增渠道数据 1 线上
	 * 
	 * @param sql
	 *            更新sql语句
	 * @return
	 * @throws SQLException 
	 */
	public List<String> gfanInsertUserId(String user_name,String channel_id,String channel_name) throws SQLException {
		List<String> list= new ArrayList<String>();
		list = userIDQuery(user_name);
		url = DataBaseCommend.getGfanStatUrl();
		username = DataBaseCommend.getGfanStatUserName();
		password = DataBaseCommend.getGfanStatPassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		sql = "insert into dis_channel(USER_ID,CHANNEL_CODE,CHANNEL_NAME,INSERT_TIME)values('"
					+ list.get(0) + "','"
					+ channel_id + "','"
					+ channel_name + "','"
					+ DateUtil.DateTime() + "')";
		isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list2= new ArrayList<String>();
		list2.add(msg);
		list2.add(String.valueOf(isOK));
		db.coles();
		return list2;
	}
	
	/**
	 * 联运扣量渠道数据
	 * 
	 * @param sql
	 *            更新sql语句
	 * @return
	 */
	public List<String> lyUpdata(String orderID,String channelID,String checkPer) {
		url = DataBaseCommend.getGfanUnionGameUrl();
		username = DataBaseCommend.getGfanUnionGameUserName();
		password = DataBaseCommend.getGfanUnionGamePassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		sql = "UPDATE BASE_GAME_CHANNEL set CHECK_PER='"+ checkPer + "' where CHANNEL_ID='"+ channelID + "' and ORDER_ID='"+ orderID + "'";
		isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list= new ArrayList<String>();
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * 机锋市场扣量渠道数据
	 * 
	 * @param sql
	 *            更新sql语句
	 * @return
	 */
	public List<String> gfanUpdata(String channelID,String allDis,String channelDis) {
		url = DataBaseCommend.getGfanStatUrl();
		username = DataBaseCommend.getGfanStatUserName();
		password = DataBaseCommend.getGfanStatPassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		sql = "UPDATE dis_channel set ALL_DIS='"+ allDis + "',CHANNEL_DIS='"+ channelDis + "' where CHANNEL_CODE='"+ channelID + "'";
		isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list= new ArrayList<String>();
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * user数据
	 * 
	 * @param sql
	 *            更新sql语句
	 * @return
	 */
	public List<String> userUpdata(String userID,String display_name,String user_name,String register_time,String state) {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		sql = "UPDATE `user` set display_name='"+ display_name + "',user_name='"+ user_name + "',register_time='"+ register_time + "',state='"+ state + "' where id='"+ userID + "'";
		isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list= new ArrayList<String>();
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * role角色数据
	 * 
	 * @param sql
	 *            更新sql语句
	 * @return
	 */
	public List<String> roleUpdata(String roleID,String roleName,String roleZy,String roleMs) {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		sql = "UPDATE p_role set `value`='"+ roleName + "',`name`='"+ roleZy + "',`desc`='"+ roleMs + "' where id='"+ roleID + "'";
		isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list= new ArrayList<String>();
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * role角色数据
	 * 
	 * @param sql
	 *            更新sql语句
	 * @return
	 */
	public List<String> pwdUpdata(String userID,String passWord) {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		//加密处理
		String pwd_salt = hashMD5Util.produceSalt();
		String pwd_hash = hashMD5Util.productNewPassword(passWord, pwd_salt);
		db.connectionDB(url, username, password);
		sql = "UPDATE user_pwd set pwd_hash='"+ pwd_hash + "',pwd_salt='"+ pwd_salt + "' where user_id='"+ userID + "'";
        isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list= new ArrayList<String>();
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * user数据删除
	 * 
	 * @param sql
	 *            更新sql语句
	 * @return
	 */
	public List<String> userDelete(String userID,String display_name,String user_name,String register_time,String state) {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		sql = "DELETE from `user` where id='"+ userID + "'";
		isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list= new ArrayList<String>();
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * 角色数据删除
	 * 
	 * @param sql
	 *            更新sql语句
	 * @return
	 */
	public List<String> roleDelete(String roleID) {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		sql = "DELETE from p_role where id='"+ roleID + "'";
		isOK = db.update(sql);
		msg = db.getMsg();
		List<String> list= new ArrayList<String>();
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * 联运查询基础表base_game_channel
	 * 
	 * @param sql
	 *            查询sql语句
	 * @return
	 * @throws SQLException 
	 */
	public List<String> lyQuery(String orderID,String channelID) throws SQLException {
		url = DataBaseCommend.getGfanUnionGameUrl();
		username = DataBaseCommend.getGfanUnionGameUserName();
		password = DataBaseCommend.getGfanUnionGamePassWord();
		DataBase db = new DataBase();
		List<String> list= new ArrayList<String>();
		db.connectionDB(url, username, password);
		sql = "select USER_ID,PRODUCT_ID,PRODUCT_NAME,CHANNEL_ID,CHANNEL_NAME,DEAL_MODE,CHECK_PER,ORDER_ID,INSERT_TIME from BASE_GAME_CHANNEL where ORDER_ID='"
					+ orderID + "' and CHANNEL_ID='"+ channelID + "'";
		resultSet = db.query(sql);
		if(resultSet!=null){
			isOK = 1;
			if(resultSet.next()){  
	            list.add(resultSet.getString(1));
	            list.add(resultSet.getString(2));
	            list.add(resultSet.getString(3));
	            list.add(resultSet.getString(4));
	            list.add(resultSet.getString(5));
	            list.add(resultSet.getString(6));
	            list.add(resultSet.getString(7));
	            list.add(resultSet.getString(8));
	            list.add(resultSet.getString(9));
	         }  
		}else{
		  msg = db.getMsg();
		}
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * 机锋市场查询基础表dis_channel
	 * 
	 * @param sql
	 *            查询sql语句
	 * @return
	 * @throws SQLException 
	 */
	public List<String> gfanQuery(String channelID) throws SQLException {
		url = DataBaseCommend.getGfanStatUrl();
		username = DataBaseCommend.getGfanStatUserName();
		password = DataBaseCommend.getGfanStatPassWord();
		DataBase db = new DataBase();
		List<String> list= new ArrayList<String>();
		db.connectionDB(url, username, password);
		sql = "select USER_ID,CHANNEL_CODE,CHANNEL_NAME,ALL_DIS,CHANNEL_DIS,INSERT_TIME from dis_channel where CHANNEL_CODE='"+ channelID + "'";
		resultSet = db.query(sql);
		if(resultSet!=null){
			isOK = 1;
			if(resultSet.next()){  
	            list.add(resultSet.getString(1));
	            list.add(resultSet.getString(2));
	            list.add(resultSet.getString(3));
	            list.add(resultSet.getString(4));
	            list.add(resultSet.getString(5));
	            list.add(resultSet.getString(6));
	         }  
		}else{
		  msg = db.getMsg();
		}
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * 机锋市场查询基础表dis_channel
	 * 
	 * @param sql
	 *            查询sql语句
	 * @return
	 * @throws SQLException 
	 */
	public List<String> userQuery(String userID) throws SQLException {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		List<String> list= new ArrayList<String>();
		db.connectionDB(url, username, password);
		sql = "select id,display_name,user_name,register_time,state from `user` where id='"+ userID + "'";
		resultSet = db.query(sql);
		if(resultSet!=null){
			isOK = 1;
			if(resultSet.next()){  
	            list.add(String.valueOf(resultSet.getInt(1)));
	            list.add(resultSet.getString(2));
	            list.add(resultSet.getString(3));
	            list.add(resultSet.getString(4));
	            list.add(resultSet.getString(5));
	         }  
		}else{
		  msg = db.getMsg();
		}
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		System.out.println(list.get(4));
		return list;
	}
	
	/**
	 * 用户id表查询
	 * 
	 * @param sql
	 *            查询sql语句
	 * @return
	 * @throws SQLException 
	 */
	public List<String> userIDQuery(String user_name) throws SQLException {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		List<String> list= new ArrayList<String>();
		db.connectionDB(url, username, password);
		sql = "SELECT id FROM `user` where user_name='"+ user_name +"'";
		resultSet = db.query(sql);
		if(resultSet!=null){
			isOK = 1;
			if(resultSet.next()){  
	            list.add(resultSet.getString(1));
	        }else{
	        	list.add("0");
	        }
		}else{
		  msg = db.getMsg();
		}
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * 用户id表查询
	 * 
	 * @param sql
	 *            查询sql语句
	 * @return
	 * @throws SQLException 
	 */
	public List<String> channelIDQuery(String channelID) throws SQLException {
		url = DataBaseCommend.getGfanStatUrl();
		username = DataBaseCommend.getGfanStatUserName();
		password = DataBaseCommend.getGfanStatPassWord();
		DataBase db = new DataBase();
		List<String> list= new ArrayList<String>();
		db.connectionDB(url, username, password);
		sql = "SELECT id FROM dis_channel where CHANNEL_CODE='"+ channelID +"'";
		resultSet = db.query(sql);
		if(resultSet!=null){
			isOK = 1;
			if(resultSet.next()){  
	            list.add(resultSet.getString(1));
	        }else{
	        	list.add("0");
	        }
		}else{
		  msg = db.getMsg();
		}
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		System.out.println(list.get(0));
		System.out.println(list.get(1));
		System.out.println(list.get(2));
		return list;
	}
	
	/**
	 * 角色表查询基础表dis_channel
	 * 
	 * @param sql
	 *            查询sql语句
	 * @return
	 * @throws SQLException 
	 */
	public List<String> roleQuery(String roleID) throws SQLException {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		List<String> list= new ArrayList<String>();
		db.connectionDB(url, username, password);
		sql = "select id,`value`,`name`,`desc` from p_role where id='"+ roleID + "'";
		resultSet = db.query(sql);
		if(resultSet!=null){
			isOK = 1;
			if(resultSet.next()){  
	            list.add(String.valueOf(resultSet.getInt(1)));
	            list.add(resultSet.getString(2));
	            list.add(resultSet.getString(3));
	            list.add(resultSet.getString(4));
	         }  
		}else{
		  msg = db.getMsg();
		}
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	/**
	 * 角色表查询基础表dis_channel
	 * 
	 * @param sql
	 *            查询sql语句
	 * @return
	 * @throws SQLException 
	 */
	public List<String> pmRoleQuery(String userID) throws SQLException {
		url = DataBaseCommend.getGameChannelUrl();
		username = DataBaseCommend.getGameChannelUserName();
		password = DataBaseCommend.getGameChannelPassWord();
		DataBase db = new DataBase();
		db.connectionDB(url, username, password);
		List<String> list= new ArrayList<String>();
		sql = "select ifnull(role_id , 0) from p_member_role where user_id='"+ userID + "'";
		resultSet = db.query(sql);
		if(resultSet!=null){
			isOK = 1;
			if(resultSet.next()){  
				list.add(resultSet.getString(1));
	         }else{
	        	 list.add("0");
	         }
		}else{
		  msg = db.getMsg();
		}
		list.add(msg);
		list.add(String.valueOf(isOK));
		db.coles();
		return list;
	}
	
	
	
	public static void main(String[] args) throws SQLException {
		JDBCComplyHandler db=new JDBCComplyHandler(); 
		db.lyQuery( "123","123");
//		db.lyUpdata("123","123", "0.9");
//		db.gfanUpdata( "2014071001","123","123");
//		db.gfanQuery("2014071001");
//		dataBaseStatic = new DataBaseStatic();
//		System.out.println(DataBaseStatic.getGfanUnionGameUserName());
//		db.roleQuery("607");
//		db.roleDelete("15");
//		db.roleInsert("1111", "1111", "1111");
//		db.userPwdInsert("111@11.com", "123456");
//		db.userPwdQuery("111@11.com");
//		db.userPwdQuery("100000001");
//		db.pmRoleQuery("100000000");
//		db.pmRoleInsert("110000391", "123");
//		db.userIDQuery("458465931@qq.co");
		
//		db.excelInsert(is, null);
//		db.channelIDQuery("2015071001");
//		db.gfanInsertUserId("admin@gfan.com", "123", "123");
		System.out.println(DateUtil.date2Str(new Date(1351185789)));
		String icon = "sdg/asda/asdasd/fdhrfh/85495";
//		System.out.println(strs);
	}

}