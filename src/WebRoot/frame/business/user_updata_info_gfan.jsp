<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.gfan.report.frame.util.DateUtil"%>
<%@ page import="com.gfan.report.frame.service.gfan.FactChannelRecommendStat"%>
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
		
                          渠道名称：
		     <input type="text" id="user_displayname" style="margin-right: 15px;margin-top: 3px">
		           登录邮箱：
		     <input type="text" id="user_name" style="margin-right: 15px;margin-top: 3px">
		     <br>
		       数据所属日期：
		    <input type="text" id="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="tabledate Wdate" value="<%=DateUtil.getStringDate(-1)%>" class="Wdate" style="width:110px;height:18px;padding: 2px;margin-bottom:4px;line-height:normal;margin-right:15px;margin-top: 8px；"/> 
		    <button class="btn red mini" style="margin-bottom: 6px;margin-right:15px;margin-top: 8px" onclick="runFackMySQl()">
				生成数据
				<i class="m-icon-swapright m-icon-white" style="margin: 0px;"></i>
			</button>
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
<div id="pop1" style="z-index:1;background-color:#00000000;filter:alpha(opacity=80);width:100%;height:100%;position:absolute;left:0px;top:0px;display:none"> 
</div> 
<div id="pop2" style="z-index:2;background-image:url('./media/image/duang.gif');background-size:auto;filter:alpha(opacity=80);left:41%;top:28%;width:265px;height:110px;display:none;position:absolute;text-align: center;"  >
</div> 
<script>
var userID = "${sessionScope.userInfo.id}";
var user_displayname="";
var user_name="";
var strUser_displayname;
var strUser_name;
var startTime = "";

function runFackMySQl() {
    show();
	startTime = $("#startTime").val();
	RptManager.runMySqlFact(startTime, function(a){
    close();
	alert("数据生成成功！");
	});
}

function show(){ 
$("#pop1").show();
$("#pop2").show();
}  
function close(){ 
$("#pop1").hide();
$("#pop2").hide();
}

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
	var loadURL = '/frame/business/user_insert_info_gfan.jsp';
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
