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
		    <a id="back" href="#" onclick="back()" style="margin-right:110px ;color: blue;text-decoration:underline;display: none"  title="点击返回查询全部">返回</a>
			选择渠道：
			<select id="channels" style="height:20px;padding:0px;margin-bottom: 4px;width:210px" >
			</select>&nbsp;&nbsp;&nbsp;&nbsp;
			渠道ID：
			<input type="text" id="channel_id" style="margin-right: 15px">
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
var startTime ="";
var endTime = "";
var strChannel_id="";
var channel_id="";
var userID = "${sessionScope.userInfo.id}";
function refresh(){
	startTime = $('#startTime1').val();
	endTime = $('#endTime1').val();
}

function query(){
	refresh();
	isValueNull();
	querygirdPartPage(1);
}

//判断搜索框是否为空值
function isValueNull() {
	channel_id = $("#channel_id").val();
	if(channel_id!=null && channel_id!=""){
	strChannel_id = channel_id;
	}else{
	strChannel_id = "";
	}
	$("#channels").val(strChannel_id);
}

//超链接，点击进入渠道详细
function goDetail(channelid){
	refresh();
	strChannel_id = channelid;
	$("#channels").val(strChannel_id);
	$("#back").show(); 
	querygirdPartPage(1);
}

//超链接返回查询全部
function back() {
	refresh();
	strChannel_id = "";
	$("#channels").val(strChannel_id); 
	$("#back").hide();
	querygirdPartPage(1);
}

//查询并下载birt报表
function downExcelFile(){
	//构造ajax后台数据查询的参数
	parampage.currentPage=parampage.getNewPage();
	//构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.channel_code=strChannel_id;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.start_index = 0;
	rtpparams.end_index = 100;
	if(strChannel_id!=null && strChannel_id!=""){
	RptManager.genReportFile(rtpparams,'m_channel_id_gfan_query_detail_count_admin.rptdisger',{
        callback:function(data){
            dwr.engine.openInDownload(data);
        },
        async : false
    });
    }else{
    RptManager.genReportFile(rtpparams,'gfan_query_detail_count_admin.rptdisger',{
        callback:function(data){
            dwr.engine.openInDownload(data);
        },
        async : false
    });
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
	rtpparams.channel_code=strChannel_id;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	//通过ajax查询后台数据
	if(strChannel_id!=null && strChannel_id!=""){
	RptManager.genReportDataToHtmlAndCount(rtpparams,'m_channel_id_gfan_query_detail_count_admin.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		RptManager.genReportDataToHtml(rtpparams,'m_channel_id_gfan_query_detail_count_total_admin.rptdisger', function(content){
			//构造报表模板参数，并展示模板
			showgirdbirt01(param,JSON.parse(content).list[0]);
			param = null;
		});
	});
	}else{
	RptManager.genReportDataToHtmlAndCount(rtpparams,'gfan_query_detail_count_admin.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		RptManager.genReportDataToHtml(rtpparams,'gfan_query_detail_count_total_admin.rptdisger', function(content){
			//构造报表模板参数，并展示模板
			param.showLink={2:{name:'goDetail',arg:[1]}};
			showgirdbirt01(param,JSON.parse(content).list[0]);
			param = null;
		});
	});
	}
}

function initProducts(){
	var rtpparams = {};
	RptManager.genReportDataToHtml(rtpparams,'select_product_gfan_admin.rptdisger', function(content){
		var content = JSON.parse(content);
		var products = content.list;
		if(products.length==0){
			$("#channels").append("<option value=0>无应用</option>");		
		}else{
				$("#channels").append("<option value=''>全部</option>");
			for(var index in products){
				var td = products[index];
				$("#channels").append("<option value='"+td[0]+"'>"+td[1]+"</option>");
			}
		}
// 		initStorage();
	});
}

function initStorage(){
	var selectValue = $("#channels").val();
	strChannel_id = selectValue;
	refresh();
	querygirdPartPage(1);
	if($("#back").hide()){
	$("#back").show();
	}
}

$("#channels").change(function() { initStorage(); }); 
$(document).ready(function() {
	parampage = new page();
    parampage.buttonfun=querygirdPartPage;
	initProducts();
	refresh();
	querygirdPartPage(1);
});
</script>
