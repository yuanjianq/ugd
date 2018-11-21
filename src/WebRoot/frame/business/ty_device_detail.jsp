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
			<i class="icon-reorder"></i>设备安装详细数据(<font id='showTitle'></font>)
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
		<div class="chart_cont" style="height:auto!important;height:310px;position: relative;">
			<jsp:include page="/frame/base/girdbirt01.jsp"/>
		</div>
	</div>
</div>

<script>
var startTime = '';
var endTime = '';
var queryValue='';
var dateType = '1';
var tableName = 'install_ty_device_base_log_';
//查询并下载birt报表
function downExcelFile(){
	//构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.query_value = queryValue;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.table_name=tableName;
	rtpparams.start_index = 0;
	rtpparams.end_index = 10000;
	RptManager.genReportFile(rtpparams,'ty_query_device_detail.rptdisger',{
        callback:function(data){
            dwr.engine.openInDownload(data);
        },
        async : false
    });
}		
function query(){
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
	rtpparams.client_uid = queryValue;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.table_name=tableName;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	//通过ajax查询后台数据
	RptManager.genReportDataToHtmlAndCount(rtpparams,'ty_query_device_detail.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		showgirdbirt01(param);
	});
}

$(document).ready(function() {
	var showTitle = '';
	var year = '${param.dataTime}'.substr(0,4);
	var month = '${param.dataTime}'.substr(5,2);
	tableName = tableName+year+month; 
	startTime='${param.dataTime}';
	endTime='${param.dataTime}';
	showTitle = startTime;
	if('${param.boxId}'!=''){
		queryValue = "AND client_uid = '"+'${param.boxId}'+"' ";
		showTitle=showTitle+'盒子'+'${param.boxId}';
	}
	if('${param.brand}'!=''){
		queryValue = queryValue+"AND brand = '"+'${param.brand}'+"' ";
		showTitle=showTitle+'品牌'+'${param.brand}';
	}
	if('${param.model}'!=''){
		queryValue = queryValue+"AND model = '"+'${param.model}'+"' ";
		showTitle=showTitle+'型号'+'${param.model}';
	}
	showTitle=showTitle+'数据';
	$('#showTitle').html(showTitle);
	parampage = new page();
    parampage.buttonfun=querygirdPartPage;
    query();
});
</script>
