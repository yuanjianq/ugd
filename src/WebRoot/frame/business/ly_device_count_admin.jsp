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
			<i class="icon-reorder"></i>联运游戏统计数据
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
			选择渠道：
			<select id="channels" style="height:20px;padding:0px;margin-bottom: 18px;width:210px;margin-top: 8px;" >
			</select>&nbsp;&nbsp;&nbsp;&nbsp;
			选择游戏：
			<select id="products" style="height:20px;padding:0px;margin-bottom: 18px;width:210px;margin-right: 16px;margin-top: 8px;" >
			</select><br/>
		   <a id="backProduct" href="#" onclick="backProduct()" style="margin-right:200px ;color: blue;text-decoration:underline;display: none"  title="点击返回查询渠道全部">返回</a>
		   <a id="backChannel" href="#" onclick="backChannel()" style="margin-right:200px ;color: blue;text-decoration:underline;display: none"  title="点击返回查询全部">返回</a>
			渠道名称：
			<input type="text" id="channel_name" style="margin-right: 15px">
			游戏名称：
			<input type="text" id="product_name" style="margin-right: 15px">
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
var product_name="";
var channel_name="";
var strProduct_name="";
var strChannel_name="";
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
	channel_name = $("#channel_name").val();
	product_name = $("#product_name").val();
	if(channel_name!=null && channel_name!=""){
		strChannel_name = "%"+channel_name+"%";
		if(product_name!=null && product_name!=""){
			strProduct_name="%"+product_name+"%";
		}else{
			strProduct_name="";
		}
	}else{
		if(product_name!=null && product_name!=""){
			alert("产品名称不支持单独查询，请填写渠道名称！");
		}else{
			strChannel_name = "";
		}
	}
	$("#channels").val("");
	$("#products").empty();
	$("#products").append("<option value=''>请先选择渠道</option>");
}

//超链接，点击进入渠道详细
function goDetailProduct(productname){
	refresh();
	strProduct_name = productname;
	$("#products").val(strProduct_name);
	if($("#backChannel").show()){
		$("#backChannel").hide();
	}
	$("#backProduct").show(); 
	querygirdPartPage(1);
}

//超链接返回查询全部
function backProduct() {
	refresh();
	strProduct_name = "";
	$("#products").val(strProduct_name); 
	if($("#backChannel").hide()){
		$("#backChannel").show();
	}
	$("#backProduct").hide();
	querygirdPartPage(1);
}

//超链接，点击进入渠道详细
function goDetailChannel(channelname){
	refresh();
	strChannel_name = channelname;
	$("#channels").val(strChannel_name);
	$("#backChannel").show(); 
	querygirdPartPage(1);
}

//超链接返回查询全部
function backChannel() {
	refresh();
	strChannel_name = "";
	$("#channels").val(strChannel_name); 
	$("#backChannel").hide();
	querygirdPartPage(1);
}

//查询并下载birt报表
function downExcelFile(){
	//构造ajax后台数据查询的参数
	parampage.currentPage=parampage.getNewPage();
	//构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.product_name =strProduct_name;
	rtpparams.channel_name =strChannel_name;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.start_index = 0;
	rtpparams.end_index = 100;
	if(strChannel_name!=null && strChannel_name!=""){
		if(strProduct_name!=null && strProduct_name!=""){
			RptManager.genReportFile(rtpparams,'m_channel_product_name_ly_detail_count_admin.rptdisger',{
       			callback:function(data){
          		 	 dwr.engine.openInDownload(data);
      			 },
       			async : false
   			 });
    	}else{
    		RptManager.genReportFile(rtpparams,'m_channel_name_ly_query_detail_count_admin.rptdisger',{
        		callback:function(data){
            		dwr.engine.openInDownload(data);
       			},
        		async : false
    		});
    	}
    }else{
    RptManager.genReportFile(rtpparams,'ly_query_detail_count_admin.rptdisger',{
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
	rtpparams.product_name =strProduct_name;
	rtpparams.channel_name =strChannel_name;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	//通过ajax查询后台数据
	if(strChannel_name!=null && strChannel_name!=""){
		if(strProduct_name!=null && strProduct_name!=""){
		RptManager.genReportDataToHtmlAndCount(rtpparams,'m_channel_product_name_ly_detail_count_admin.rptdisger', function(content){
			parampage.count=parseInt(content[1]);
			//构造报表模板参数，并展示模板
			var param = new girdbirt01param(content[0],parampage);
			RptManager.genReportDataToHtml(rtpparams,'m_channel_product_name_ly_detail_count_total_admin.rptdisger', function(content){
				//构造报表模板参数，并展示模板
				showgirdbirt01(param,JSON.parse(content).list[0]);
				param = null;
			});
		});
		}else{
		RptManager.genReportDataToHtmlAndCount(rtpparams,'m_channel_name_ly_query_detail_count_admin.rptdisger', function(content){
			parampage.count=parseInt(content[1]);
			//构造报表模板参数，并展示模板
			var param = new girdbirt01param(content[0],parampage);
			RptManager.genReportDataToHtml(rtpparams,'m_channel_name_ly_query_detail_count_total_admin.rptdisger', function(content){
				//构造报表模板参数，并展示模板
				param.showLink={2:{name:'goDetailProduct',arg:[2]}};
				showgirdbirt01(param,JSON.parse(content).list[0]);
				param = null;
			});
		});
		} 
	}else{
	RptManager.genReportDataToHtmlAndCount(rtpparams,'ly_query_detail_count_admin.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		RptManager.genReportDataToHtml(rtpparams,'ly_query_detail_count_total_admin.rptdisger', function(content){
			//构造报表模板参数，并展示模板
			param.showLink={1:{name:'goDetailChannel',arg:[1]}};
			showgirdbirt01(param,JSON.parse(content).list[0]);
			param = null;
		});
	});
	}
}

//初始化渠道查询条件
function initChannels(){
	var rtpparams = {};
	RptManager.genReportDataToHtml(rtpparams,'select_channel_ly_admin.rptdisger', function(content){
		var content = JSON.parse(content);
		var channels = content.list;
		if(channels.length==0){
			$("#channels").append("<option value=0>无渠道</option>");		
		}else{
		    $("#channels").append("<option value=''>全部</option>");
			for(var index in channels){
				var td = channels[index];
				$("#channels").append("<option value='"+td[1]+"'>"+td[1]+"</option>");
			}
		}
// 		initProducts();
	});
	
}
function initProducts(){
    var selectValue = $("#channels").val();
    if(selectValue!="" && selectValue!=null){
	var rtpparams = {};
	rtpparams.channel_name = selectValue;
	RptManager.genReportDataToHtml(rtpparams,'select_product_ly_admin.rptdisger', function(content){
		var content = JSON.parse(content);
		var products = content.list;
		if(products.length==0){
			$("#products").append("<option value=0>无应用</option>");		
		}else{
				$("#products").empty();
				$("#products").append("<option value=''>全部</option>");
			for(var index in products){
				var td = products[index];
				$("#products").append("<option value='"+td[1]+"'>"+td[1]+"</option>");
			}
		}
		initStorage();
	});
	}else{
	$("#products").empty();
	$("#products").append("<option value=''>请先选择渠道</option>");
	initStorage();
	}
}

function initStorage(){
	var selectValue = $("#products").val();
	var selectValue2 = $("#channels").val();
	strProduct_name = selectValue;
	strChannel_name = selectValue2;
	refresh();
	querygirdPartPage(1);
	if(strProduct_name!=null && strProduct_name!=""){
		$("#backProduct").show();
		$("#backChannel").hide();
	}else{
		if(strChannel_name!=null && strChannel_name!=""){
		$("#backChannel").show();
		}
	}
}

$("#channels").change(function() { initProducts(); }); 
$("#products").change(function() { initStorage(); }); 
$(document).ready(function() {
	parampage = new page();
    parampage.buttonfun=querygirdPartPage;
	initChannels();
	initProducts();
	refresh();
	querygirdPartPage(1);
});
</script>
