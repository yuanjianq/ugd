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
			<i class="icon-reorder"></i>盒子实时数据
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
			<select id="channels" style="height:20px;padding:0px;margin-bottom: 4px;width:210px" >
			</select>&nbsp;&nbsp;&nbsp;&nbsp;
			<select id="storages" style="height:20px;padding:0px;margin-bottom: 4px;width:210px">
			</select>
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
var nowTime = '<%=DateUtil.getStringDate(0)%>';
var startTime = nowTime+' 00:00:00';
var endTime = nowTime+' 23:59:59';
var boxids="";

//查询并下载birt报表
function downExcelFile(){
	//构造ajax后台数据查询的参数
	if(boxids==""||boxids=="'0'"){
		return;
	}
	parampage.currentPage=parampage.getNewPage();
	//构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.boxids = " AND client_uid IN ("+boxids+") ";
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.start_index = 0;
	rtpparams.end_index = 100;
	RptManager.genReportFile(rtpparams,'query_device_rt.rptdisger',{
        callback:function(data){
            dwr.engine.openInDownload(data);
        },
        async : false
    });
}		
function query(){
	querygirdPartPage(1);
}
//跳转到渠道详细
function skipDetail(tagName){
	var loadURL = '/frame/business/rt_detail.jsp?';
	var urlParam = "boxId="+tagName;
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
	if(currentPage==null){
		parampage.currentPage=parampage.getNewPage();
	}else{
		parampage.currentPage = currentPage;
	}
	if(boxids==""){
		boxids="'"+0+"'";
	}
	//构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.boxids = " AND client_uid IN ("+boxids+") ";
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	//通过ajax查询后台数据
	RptManager.genReportDataToHtmlAndCount(rtpparams,'query_device_rt.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		param.showLink={0:{name:'skipDetail',arg:[0]}};
		showgirdbirt01(param);
	});
}

function initChannels(){
	var rtpparams = {};
	RptManager.genReportDataToHtml(rtpparams,'select_channel_all.rptdisger', function(content){
		var content = JSON.parse(content);
		var channels = content.list;
		if(channels.length==0){
			$("#channels").append("<option value=0>无渠道</option>");		
		}else{
			for(var index in channels){
				var td = channels[index];
				$("#channels").append("<option value='"+td[0]+"'>"+td[1]+"</option>");
			}
		}
		initStorage();
	});
}
function initStorage(){
	var selectValue = $("#channels").val();
	var rtpparams = {};
	rtpparams.channel_id= selectValue;
	RptManager.genReportDataToHtml(rtpparams,'select_storage_channel.rptdisger', function(content){
		var content = JSON.parse(content);
		var storages = content.list;
		$("#storages").empty();
		if(storages.length==0){
			$("#storages").append("<option value=0>无仓库</option>");			
		}else{
			for(var index in storages){
				var td = storages[index];
				$("#storages").append("<option value='"+td[0]+"'>"+td[1]+"</option>");
			}
		}
		getBoxIds();
	});
}

function getBoxIds(){
	var selectValue = $("#storages").val();
	var rtpparams = {};
	rtpparams.storage_id= selectValue;
	RptManager.genReportDataToHtml(rtpparams,'select_box_storage.rptdisger', function(content){
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
	parampage = new page();
    parampage.buttonfun=querygirdPartPage;
    $("#channels").change(function() { initStorage(); }); 
    $("#storages").change(function() { getBoxIds(); }); 
	initChannels();
});
</script>
