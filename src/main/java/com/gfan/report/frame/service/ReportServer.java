package com.gfan.report.frame.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.io.FileTransfer;
import org.springframework.stereotype.Service;

import com.gfan.report.frame.module.User;
import com.gfan.report.frame.service.gfan.FactChannelRecommendStat;
import com.gfan.report.frame.util.DataBase;
import com.gfan.report.frame.util.DateUtil;

@Service("reportServer")
public class ReportServer {
	@Resource
	private HtmlInsertJDBCHandler htmlInsertJDBCHandler;
	@Resource
	private ExcelJDBCHandler excelJDBCHandler;
	@Resource
	private HtmlPageJDBCHandler htmlPageJDBCHandler;
	@Resource
	private HtmlNoPageJDBCHandler htmlNoPageJDBCHandler;
	@Resource
	private ChartLineJDBCHandler chartLineJDBCHandler;
	@Resource
	private ChartPieJDBCHandler chartPieJDBCHandler;
	@Resource
	private UserService userService;

	
	public String genReportDataToHtml(Map<String, String> params,String designName) {
		logQueryInfo(designName,"简单查询");
		return htmlNoPageJDBCHandler.runAndRender(designName, params);
	}

	public String[] genReportDataToHtmlAndCount(Map<String, String> params,String designName) {
		logQueryInfo(designName,"分页查询");
		return htmlPageJDBCHandler.runAndRender(designName, params);
	}

	public String genReportData(Map<String, String> params, String designName) {
		logQueryInfo(designName,"线图查询");
		return chartLineJDBCHandler.runAndRender(designName, params);
	}

	public String genReportData2(Map<String, String> params, String designName) {
		logQueryInfo(designName,"饼图查询");
		return chartPieJDBCHandler.runAndRender(designName, params);
	}

	public FileTransfer genReportFile(Map<String, String> params,String designName) throws Exception {
		logQueryInfo(designName,"下载文件");
		return new FileTransfer(designName.split("\\.")[0] + ".xlsx","application/msexcel", excelJDBCHandler.runAndRender(designName, params).toByteArray());
	}
	
	public List<Integer> uploadReportFile(InputStream is,String userid) throws Exception {
		logQueryInfo(null,"上传excel");
    	return new JDBCComplyHandler().excelInsert(is, userid);
	}  
	
	public List<String> genReportInsertDataToHtml(String startTime,String userID,String channelName,String productID,String productName,String registerUser) {
		logQueryInfo(null,"新增单机数据记录");
		return new JDBCComplyHandler().djInsert(startTime,userID,channelName,productID,productName,registerUser);
	}
	
	public List<String> lyInsertData(Map<String, String> params) {
		logQueryInfo(null,"新增联运渠道");
		return new JDBCComplyHandler().lyInsert(params);
	}
	
	public List<String> gengfanInsertDataToHtml(Map<String, String> params) {
		logQueryInfo(null,"新增机锋市场渠道");
		return new JDBCComplyHandler().gfanInsert(params);
	}
	public List<String> fanInsertUserIdData(String user_name,String channel_id,String channel_name) throws SQLException {
		logQueryInfo(null,"新增机锋市场渠道 user 页面");
		return new JDBCComplyHandler().gfanInsertUserId(user_name,channel_id,channel_name);
	}
	
	public List<String> roleInsertData(String roleName,String roleZy,String roleMs) throws SQLException {
		logQueryInfo(null,"新增记录");
		return new JDBCComplyHandler().roleInsert(roleName, roleZy,roleMs);
	}
	
	public List<String> userInsertData(String display_name,String user_name) throws SQLException {
		logQueryInfo(null,"新增记录");
		return new JDBCComplyHandler().userInsert(display_name, user_name);
	}
	
	public List<String> pmRoleInsertData(String userID,String roleID) throws SQLException {
		logQueryInfo(null,"新增记录");
		return new JDBCComplyHandler().pmRoleInsert(userID, roleID);
	}
	
	public List<String> userPwdInsertData(String user_name,String passWord) throws SQLException {
		logQueryInfo(null,"新增记录");
		return new JDBCComplyHandler().userPwdInsert(user_name, passWord);
	}
	
	public List<String> lyQueryData(String orderID,String channelID) throws SQLException {
		logQueryInfo(null,"查询记录");
		return new JDBCComplyHandler().lyQuery(orderID,channelID);
	}
	
	public List<String> pmRoleQueryData(String userID) throws SQLException {
		logQueryInfo(null,"查询记录");
		return new JDBCComplyHandler().pmRoleQuery(userID);
	}
	
	public List<String> gfanQueryData(String channelID) throws SQLException {
		logQueryInfo(null,"查询记录");
		return new JDBCComplyHandler().gfanQuery(channelID);
	}
	
	public List<String> userQueryData(String userID) throws SQLException {
		logQueryInfo(null,"查询记录");
		return new JDBCComplyHandler().userQuery(userID);
	}
	
	public List<String> roleQueryData(String roleID) throws SQLException {
		logQueryInfo(null,"查询记录");
		return new JDBCComplyHandler().roleQuery(roleID);
	}
	public List<String> userIDSQueryData(String username) throws SQLException {
		logQueryInfo(null,"查询记录");
		return new JDBCComplyHandler().userIDQuery(username);
	}
	
	public List<String> channelIDSQueryData(String channel_id) throws SQLException {
		logQueryInfo(null,"查询记录");
		return new JDBCComplyHandler().channelIDQuery(channel_id);
	}
	
	public List<String> genReportUpdataDataToHtml(String orderID,String channelID,String checkPer) throws SQLException {
		logQueryInfo(null,"修改记录");
		return new JDBCComplyHandler().lyUpdata(orderID, channelID, checkPer);
	}
	
	public List<String> roleUpdataData(String roleID,String roleName,String roleZy,String roleMs) throws SQLException {
		logQueryInfo(null,"修改记录");
		return new JDBCComplyHandler().roleUpdata(roleID, roleName, roleZy,roleMs);
	}
	
	public List<String> pwdUpdataData(String userID,String passWord) throws SQLException {
		logQueryInfo(null,"修改记录");
		return new JDBCComplyHandler().pwdUpdata(userID, passWord);
	}
	
	public List<String> userUpdataData(String userID,String display_name,String user_name,String register_time,String state) throws SQLException {
		logQueryInfo(null,"修改记录");
		return new JDBCComplyHandler().userUpdata(userID, display_name, user_name,register_time,state);
	}
	
	public List<String> userDeleteData(String userID,String display_name,String user_name,String register_time,String state) throws SQLException {
		logQueryInfo(null,"删除记录");
		return new JDBCComplyHandler().userDelete(userID, display_name, user_name,register_time,state);
	}
	
	public List<String> roleDeleteData(String roleID) throws SQLException {
		logQueryInfo(null,"删除记录");
		return new JDBCComplyHandler().roleDelete(roleID);
	}
	
	public List<String> gfanUpdataData(String channelID,String allDis,String channelDis) throws SQLException {
		logQueryInfo(null,"机锋市场修改记录");
		return new JDBCComplyHandler().gfanUpdata(channelID, allDis, channelDis);
	}
	
	public int runMySqlFact(String dataTime) throws SQLException {
		logQueryInfo(null,"运行存储过程");
		FactChannelRecommendStat.main(dataTime);
		return 1; 
	}
	
	private void logQueryInfo(String designName,String logType){
		WebContext webc = WebContextFactory.get();
		HttpServletRequest request = webc.getHttpServletRequest();
		userService.logQueryInfo((User) request.getSession().getAttribute("userInfo"), designName, request.getRemoteAddr(), logType);
	}

	public String getPeriods(String dataTime) {
		return DateUtil.getPeriods(dataTime);
	}

}
