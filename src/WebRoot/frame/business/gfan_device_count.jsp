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
			<i class="icon-reorder"></i>机锋市场渠道数据统计
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
		        渠道编号：<strong id="channelCode"></strong>&nbsp;&nbsp;  
		        渠道名称：<strong id="channelName"></strong>&nbsp;&nbsp;&nbsp;&nbsp; 
			查询日期：
			<input type="text" id="startTime1" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="tabledate Wdate" value="<%=DateUtil.getStringDate(-11)%>" class="Wdate" style="width:110px;height:18px;padding: 2px;margin-bottom:4px;line-height:normal;"/> 
			至
			<input type="text" id="endTime1" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate tabledate" value="<%=DateUtil.getStringDate(-1)%>" class="Wdate"/> 
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
var startTime = "";
var endTime = "";
var channelCode="";
var userID = "${sessionScope.userInfo.id}";
function refresh(){
	startTime = $('#startTime1').val();
	endTime = $('#endTime1').val();
}

//查询并下载birt报表
function downExcelFile(){
	//构造ajax后台数据查询的参数
	if(channelCode==""){
		return;
	}
	parampage.currentPage=parampage.getNewPage();
	//构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.channel_code =channelCode;
	rtpparams.user_id =userID;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.start_index = 0;
	rtpparams.end_index = 100;
	RptManager.genReportFile(rtpparams,'gfan_query_detail_count.rptdisger',{
        callback:function(data){
            dwr.engine.openInDownload(data);
        },
        async : false
    });
}	
	
function query(){
	refresh();
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
	rtpparams.channel_code =channelCode;
	rtpparams.user_id =userID;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	//通过ajax查询后台数据
	RptManager.genReportDataToHtmlAndCount(rtpparams,'gfan_query_detail_count.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		RptManager.genReportDataToHtml(rtpparams,'gfan_query_detail_count_total.rptdisger', function(content){
			//构造报表模板参数，并展示模板
			showgirdbirt01(param,JSON.parse(content).list[0]);
			param = null;
		});
	});
}

function initProducts(){
	var rtpparams = {};
	rtpparams.user_id =userID;
	RptManager.genReportDataToHtml(rtpparams,'select_product_gfan.rptdisger', function(content){
		var content = JSON.parse(content);
		var products = content.list;
		if(products.length==0){
			document.getElementById("channelCode").innerHTML="无渠道信息";
			document.getElementById("channelName").innerHTML="无渠道信息";
		}else{		
			var td = products[0];
			document.getElementById("channelCode").innerHTML=td[0];
			document.getElementById("channelName").innerHTML=td[1];
		    channelCode = td[0];
		}
	    query();
	});
}

$(document).ready(function() {
	parampage = new page();
    parampage.buttonfun=querygirdPartPage;
	initProducts();
});
</script>
