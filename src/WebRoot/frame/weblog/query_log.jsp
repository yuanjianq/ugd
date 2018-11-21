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
			<i class="icon-reorder"></i>用户登录统计
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
			<input type="text" id="startTime1" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="tabledate Wdate" value="<%=DateUtil.getStringDate(0)%>" class="Wdate" style="width:110px;height:18px;padding: 2px;margin-bottom:4px;line-height:normal;"/> 
			<button class="btn green mini" style="margin-bottom: 6px;margin-right:16px;" onclick="query()">
				查询 
				<i class="m-icon-swapright m-icon-white" style="margin: 0px;"></i>
			</button>
		</div>
		<div class="chart_cont" style="height:510px;position: relative;">
			<jsp:include page="/frame/base/girdbirt01.jsp"/>
		</div>
	</div>
</div>

<script>
function query(){
	querygirdPartPage(1);
}
//查询并下载birt报表
function downExcelFile(){
	//构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.start_time=$('#startTime1').val()+' 00:00:00';
	rtpparams.end_time=$('#startTime1').val()+' 23:59:59';
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	RptManager.genReportFile(rtpparams,'querylog.rptdisger',{
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
// 	构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.start_time=$('#startTime1').val()+' 00:00:00';
	rtpparams.end_time=$('#startTime1').val()+' 23:59:59';
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
// 	通过ajax查询后台数据
	RptManager.genReportDataToHtmlAndCount(rtpparams,'querylog.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
// 		构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
// 		构造报表模板参数，并展示模板
		showgirdbirt01(param);
	});
}
$(document).ready(function() {
     parampage = new page();
     parampage.length = 20;
     parampage.buttonfun=querygirdPartPage;
     query();
});
</script>
