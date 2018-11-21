<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.gfan.report.frame.util.DateUtil"%>
<%@include file="/commons/taglibs.jsp"%>
<%@ taglib uri="http://www.waally.com" prefix="wl" %>
<link href="${base}/frame/table/css/style.css" rel="stylesheet" type="text/css"/>
<style type="text/css" >
input[type="text"]{width:110px;height:18px;padding: 2px;margin-bottom:4px;line-height:normal;}
</style>
<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption" style="height: 20px;">
			<i class="icon-reorder"></i>用户管理
		</div>
		<div class="tools">
			<!-- <button class="btn blue mini" style="margin-bottom:6px;" onclick="downExcelFile()">
				导出数据
				<i class="m-icon-swapright m-icon-white" style="margin: 0px;"></i>
			</button> -->
			<a href="javascript:;" class="collapse"></a>
		</div>
	</div>
	<div class="portlet-body flip-scroll">
		<div style="text-align: right;">
		
<!-- 		查询日期： -->
<!-- 		<input type="text" id="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="tabledate Wdate" value="<%=DateUtil.getStringDate(-1)%>" class="Wdate" style="width:110px;height:18px;padding: 2px;margin-bottom:4px;line-height:normal;"/>  -->
                          渠道名称：
		     <input type="text" id="user_displayname" style="margin-right: 15px;margin-top: 3px">
		           登录邮箱：
		     <input type="text" id="user_name" style="margin-right: 15px;margin-top: 3px">
		     <br>
            <button class="btn orange mini" style="margin-bottom: 6px;margin-right:15px;margin-top: 8px" onclick="goUserInsert()">
				添加用户
				<i class="m-icon-swapright m-icon-white" style="margin: 0px;"></i>
			</button>
			<button class="btn green mini" style="margin-bottom: 6px;margin-right:16px;margin-top: 8px" onclick="query()">
				查询 
				<i class="m-icon-swapright m-icon-white" style="margin: 0px;"></i>
			</button>
			
		</div>
		<div class="chart_cont" style="height:auto!important;height:310px;position: relative;">
			<jsp:include page="/frame/base/girdbirt01.jsp"/>
		</div>
	</div>
</div>

<script>
var userID = "${sessionScope.userInfo.id}";
var user_displayname="";
var user_name="";
var strUser_displayname;
var strUser_name;
var startTime = '';
var endTime = '';
function query(){
    isValueNull();
	querygirdPartPage(1);
}

function isValueNull() {
	user_displayname = $("#user_displayname").val();
	user_name = $("#user_name").val();
	if(user_displayname!=null && user_displayname!=""){
	strUser_displayname = "%"+user_displayname+"%";
	strUser_name = "";
	}else if(user_name!=null && user_name!=""){
	strUser_name = "%"+user_name+"%";
	strUser_displayname = "";
	}else{
	strUser_displayname = "";
	strUser_name = "";
	}
}

//查询birt数据并展示报表
function querygirdPartPage(currentPage){
	if(currentPage==null){
		parampage.currentPage=parampage.getNewPage();
	}else{
		parampage.currentPage = currentPage;
	}
	//构造ajax后台数据查询的参数
	var rtpparams = {};
// 	rtpparams.user_id =userID;
    rtpparams.user_displayname = strUser_displayname;
	rtpparams.user_name = strUser_name;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	//通过ajax查询后台数据
	if(strUser_displayname!=null && strUser_displayname!=""){
	RptManager.genReportDataToHtmlAndCount(rtpparams,'m_user_displayname_user_updata_info.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		param.showLink={5:{name:'skipDetail',arg:[0]}};
		showgirdbirt01(param);
	});
	}else if(strUser_name!=null && strUser_name!=""){
	RptManager.genReportDataToHtmlAndCount(rtpparams,'m_user_name_user_updata_info.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		param.showLink={5:{name:'skipDetail',arg:[0]}};
		showgirdbirt01(param);
	});
	}else{
	RptManager.genReportDataToHtmlAndCount(rtpparams,'user_updata_info.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		param.showLink={5:{name:'skipDetail',arg:[0]}};
		showgirdbirt01(param);
	});
	}
	
}

//局部刷新修改操作
function skipDetail(userID){
	var loadURL = '/frame/business/user_updata_info_run.jsp?';
	var userIDParam = "userID="+userID;
	jQuery.ajax({
		type : "POST",
		url : "${base}" + loadURL+"&" + userIDParam,
		dataType : 'text',
		data : {
		},
		success : function(response) {
			$("#vf_content").empty();
			$("#vf_content").append(response);
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}
	});
}

//局部刷新
function goUserInsert(){
	var loadURL = '/frame/business/user_insert_info.jsp';
	jQuery.ajax({
		type : "POST",
		url : "${base}" + loadURL,
		dataType : 'text',
		data : {
		},
		success : function(response) {
			$("#vf_content").empty();
			$("#vf_content").append(response);
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}
	});
}

$(document).ready(function() {
	parampage = new page();
    parampage.buttonfun=querygirdPartPage;
//     query();
    querygirdPartPage(1);
});
</script>
