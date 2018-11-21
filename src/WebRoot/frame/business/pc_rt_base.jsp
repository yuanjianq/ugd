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
			<i class="icon-reorder"></i>PC用户盒子实时数据
		</div>
		<div class="tools">
			<button class="btn blue mini" style="margin-bottom:6px;" onclick="downExcelFile()">
				导出数据
				<i class="m-icon-swapright m-icon-white" style="margin: 0px;"></i>
			</button>
			<a href="javascript:;" class="collapse"></a>
		</div>
	</div>
	<div class="portlet-body flip-scroll">
		<div style="text-align: right;">
			<button class="btn green mini" style="margin-bottom: 6px;margin-right:16px;" onclick="query()">
				查询 
				<i class="m-icon-swapright m-icon-white" style="margin: 0px;"></i>
			</button>
		</div>
		<div class="chart_cont" style="height:auto!important;height:310px;position: relative;">
			<jsp:include page="/frame/base/girdbirt02.jsp"/>
		</div>
	</div>
</div>

<script>
var nowTime = '<%=DateUtil.getStringDate(0)%>';
var startTime = nowTime+' 00:00:00';
var endTime = nowTime+' 23:59:59';
var boxids="";

//查询并下载birt报表
function downExcelFile(){
	if(boxids==""||boxids=="'0'"){
		return;
	}
	//构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.boxids = " AND  client_uid IN ("+boxids+") ";
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	RptManager.genReportFile(rtpparams,'query_pc_rt_base.rptdisger',{
        callback:function(data){
            dwr.engine.openInDownload(data);
        },
        async : false
    })
	
}		
function query(){
	querygirdPartPage(1);
}
//跳转到渠道详细
function skipDetail(boxId){
	var loadURL = '/frame/business/rt_base_detail.jsp?';
	var urlParam = "boxId="+boxId;
	jQuery.ajax({
		type : "POST",
		url : "${base}" + loadURL+"&" + urlParam,
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
//查询birt数据并展示报表
function querygirdPartPage(currentPage){
	if(boxids==""){
		boxids="'"+0+"'";
	}
	//构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.boxids = " AND  client_uid IN ("+boxids+") ";
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	//通过ajax查询后台数据
	RptManager.genReportDataToHtml(rtpparams,'query_pc_rt_base.rptdisger', function(content){
		//构造报表模板参数，并展示模板
		var param = new girdbirt02param(content);
		param.showLink={0:{name:'skipDetail',arg:[0]}};
		showgirdbirt02(param);
	});
}



function getBoxIds(){
	var rtpparams = {};
	rtpparams.user_id="${sessionScope.userInfo.id}";
	RptManager.genReportDataToHtml(rtpparams,'select_pc_box.rptdisger', function(content){
		var content = JSON.parse(content);
		var boxs = content.list;
		boxids="";
		for(var index in boxs){
			var td = boxs[index];
			if(index==0){
				boxids="'"+td[1]+"'";
			}else{
				boxids=boxids+",'"+td[1]+"'";
			}
		}
		query();
	});
}


$(document).ready(function() {
	getBoxIds();
});
</script>
