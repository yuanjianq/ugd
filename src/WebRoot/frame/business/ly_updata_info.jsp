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
			<i class="icon-reorder"></i>联运核验维护
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
		             产品名称：
		     <input type="text" id="product_name" style="margin-right: 15px">
		            渠道名称：
		     <input type="text" id="channel_name" style="margin-right: 15px">
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
var product_name="";
var channel_name="";
var strProduct_name;
var strChannel_name;
function query(){
    isValueNull();
	querygirdPartPage(1);
}

function isValueNull() {
	product_name = $("#product_name").val();
	channel_name = $("#channel_name").val();
	if(product_name!=null && product_name!=""){
	strProduct_name = "%"+product_name+"%";
	strChannel_name="";
	}else if(channel_name!=null && channel_name!=""){
	strChannel_name = "%"+channel_name+"%";
	strProduct_name="";
	}else{
	strProduct_name = "";
	strChannel_name = "";
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
// 	rtpparams.user_id =userID;
    rtpparams.product_name = strProduct_name;
	rtpparams.channel_name = strChannel_name;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	//通过ajax查询后台数据
	if(strProduct_name!=null && strProduct_name!=""){
	RptManager.genReportDataToHtmlAndCount(rtpparams,'m_product_name_ly_updata_info.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		param.showLink={6:{name:'skipDetail',arg:[1,5]}};
		showgirdbirt01(param);
	});
	}else if(strChannel_name!=null && strChannel_name!=""){
	RptManager.genReportDataToHtmlAndCount(rtpparams,'m_channel_name_ly_updata_info.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		param.showLink={6:{name:'skipDetail',arg:[1,5]}};
		showgirdbirt01(param);
	});
	}else{
	RptManager.genReportDataToHtmlAndCount(rtpparams,'ly_updata_info.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		param.showLink={6:{name:'skipDetail',arg:[1,5]}};
		showgirdbirt01(param);
	});
	}
}

//局部刷新修改操作
function skipDetail(channelID,orderID){
	var loadURL = '/frame/business/ly_updata_info_run.jsp?';
	var channelIDParam = "channelID="+channelID;
	var orderIDParam = "orderID="+orderID;
	jQuery.ajax({
		type : "POST",
		url : "${base}" + loadURL+"&" + channelIDParam+"&" + orderIDParam,
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
