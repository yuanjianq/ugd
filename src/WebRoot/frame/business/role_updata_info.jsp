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
			<i class="icon-reorder"></i>角色管理
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
            <button class="btn orange mini" style="margin-bottom: 6px;margin-right:16px;text-align: left" onclick="goRoleInsert()">
				添加角色 
				<i class="m-icon-swapright m-icon-white" style="margin: 0px;"></i>
			</button>

			<button class="btn green mini" style="margin-bottom: 6px;margin-right:16px;" onclick="query()">
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
var startTime = '';
var endTime = '';
function query(){
// startTime = $('#startTime'+type).val()+"00:00:00"; 
// endTime = $('#startTime'+type).val()+"23:59:59";
	querygirdPartPage(1);
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
// 	rtpparams.start_time=startTime;
// 	rtpparams.end_time=endTime;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	//通过ajax查询后台数据
	RptManager.genReportDataToHtmlAndCount(rtpparams,'role_updata_info.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		param.showLink={4:{name:'skipDetail',arg:[0]}};
		showgirdbirt01(param);
	});
}

//局部刷新修改操作
function skipDetail(roleID){
	var loadURL = '/frame/business/role_updata_info_run.jsp?';
	var roleIDParam = "roleID="+roleID;
	jQuery.ajax({
		type : "POST",
		url : "${base}" + loadURL+"&" + roleIDParam,
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

//添加操作
	function goRoleInsert() {
		var loadURL = '/frame/business/role_insert_info.jsp';
		jQuery.ajax({
			type : "POST",
			url : "${base}" + loadURL,
			dataType : 'text',
			data : {},
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
    query();
});
</script>
