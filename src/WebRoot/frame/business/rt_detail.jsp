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
			<i class="icon-reorder"></i>盒子${param.boxId} 详细信息
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
				刷新
				<i class="m-icon-swapright m-icon-white" style="margin: 0px;"></i>
		</button>
				<!-- <a href="javascript:window.history.back(-1);"   style="margin: 0px;" >返回上一级</a> -->
		</div>

		<div class="chart_cont" style="height:320px;position: relative;">
			<jsp:include page="/frame/base/girdbirt01.jsp"/>
		</div>
	</div>
</div>

<script>
var nowTime = '<%=DateUtil.getStringDate(0)%>';
var startTime = nowTime+' 00:00:00';
var endTime = nowTime+' 23:59:59';
var device_id='';

function query(){
	querygirdPartPage(1);
	//queryline();
}
//查询并下载birt报表
function downExcelFile(){
	//构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.device_id = device_id;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;	
	rtpparams.start_index = 0;
	rtpparams.end_index = 10000;
	//通过ajax查询后台数据
	RptManager.genReportFile(rtpparams,'query_pc_rt_detail.rptdisger',{
        callback:function(data){
            dwr.engine.openInDownload(data);
        },
        async : false
    })
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
	rtpparams.device_id = device_id;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;	
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	//通过ajax查询后台数据
	RptManager.genReportDataToHtmlAndCount(rtpparams,'query_pc_rt_detail.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		RptManager.genReportDataToHtml(rtpparams,'query_pc_rt_detail_total.rptdisger', function(content){
			//构造报表模板参数，并展示模板
			showgirdbirt01(param,JSON.parse(content).list[0]);
			param = null;
		});
	});
	
}

$(document).ready(function() {
	if('${param.boxId}'!=''){
		device_id = '${param.boxId}';
	}
    parampage = new page();
    parampage.buttonfun=querygirdPartPage;
    query();
});
</script>
