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
			<i class="icon-reorder"></i>应用下载总览
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
			<!-- 产品ID：
			<input type="text" id="product_id" style="margin-right: 10px"> -->
			产品名称：
			<input type="text" id="product_name" style="margin-right: 10px">
			渠道名称：
			<input type="text" id="channel_name" style="margin-right: 10px">
			查询日期：
			<input type="text" id="startTime1" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="tabledate Wdate" value="<%=DateUtil.getStringDate(-11)%>" class="Wdate" style="width:110px;height:18px;padding: 2px;margin-bottom:4px;line-height:normal;"/> 
			
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
//var product_id = "";
var product_name="";
var channel_name="";

function refresh(){
	chanl_name = $('#channel_name').val();
	pro_name = $('#product_name').val();
	if(chanl_name == null || chanl_name == ""){
		channel_name = "%%";
	}else{
		channel_name = chanl_name;
	}
	if(pro_name == null || pro_name == ""){
		product_name = "%%";
	}else{
		product_name = pro_name;
	}
	startTime1 = $('#startTime1').val();
	//endTime1 = $('#endTime1').val();
	
	//正则 去掉日期的"-"
	var test = new RegExp(/-/g);
	startTime = startTime1.replace(test,"");
	//endTime = endTime1.replace(test,"");
	//alert(startTime+"---"+endTime);
	
}

//查询并下载birt报表
function downExcelFile(){
	parampage.currentPage=parampage.getNewPage();
	//构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.channel_name=channel_name;
	rtpparams.product_name=product_name;
	rtpparams.start_time=startTime;
	//rtpparams.end_time=endTime;
	rtpparams.start_index = 0;
	rtpparams.end_index = 100;
	RptManager.genReportFile(rtpparams,'upload_data_count.rptdisger',{
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
	rtpparams.channel_name=channel_name;
	rtpparams.product_name=product_name;
	rtpparams.start_time=startTime;
	//rtpparams.end_time=endTime;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	//alert(startTime+"     "+endTime+"      "+parampage.length*(parampage.currentPage-1)+"      "+parampage.length+"   "+channel_name+"   "+product_name);
	//通过ajax查询后台数据
	RptManager.genReportDataToHtmlAndCount(rtpparams,'upload_data_count.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		showgirdbirt01(param);
	});
}

function initStorage(){
	
	query();
}

$(document).ready(function() {
	parampage = new page();
    parampage.buttonfun=querygirdPartPage;
    //$("#products").change(function() { initStorage(); }); 
	//initProducts();
	initStorage();
});
</script>
