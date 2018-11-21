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
			<i class="icon-reorder"></i>机锋市场调控管理
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
			<select id="products" style="height:20px;padding:0px;margin-bottom: 4px;width:210px" >
			</select>&nbsp;&nbsp;&nbsp;&nbsp;
			渠道ID：
			<input type="text" id="channel_id" style="margin-right: 15px">
			查询日期： 
			<input type="text" id="startTime1" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="tabledate Wdate" value="<%=DateUtil.getStringDate(-21)%>" class="Wdate" style="width:110px;height:18px;padding: 2px;margin-bottom:4px;line-height:normal;"/> 
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
		<div id="div" class="chart_cont" style="text-align:center;height:200px;position: relative;display: none;">
		    <strong id="click1" style="margin-right: 15px;"></strong>
			<jsp:include page="/frame/base/girdbirt02.jsp"/>
		    <strong id="click2" style="margin-right: 15px;"></strong>
			<jsp:include page="/frame/base/girdbirt03.jsp"/>
		</div>
	</div>
</div>

<script>
var startTime = "";
var endTime = "";
var channel_id="";
var strChannel_id;
var channel_id_click="";
var channel_name_click="";
var data_time_click="";
var flag=true;
var userID = "${sessionScope.userInfo.id}";
function refresh(){
	startTime = $('#startTime1').val();
	endTime = $('#endTime1').val();
}

//查询
function query(){
	refresh();
	isValueNull();
	querygirdPartPage(1);
	if(flag){
	$("#div").hide();
	flag = false;
	}
}

//判断搜索框是否为空值
function isValueNull() {
	channel_id = $("#channel_id").val();
	if(channel_id!=null && channel_id!=""){
	strChannel_id = channel_id;
	}else{
	strChannel_id = "";
	}
	$("#products").val(strChannel_id);
}

//超链接，点击进入渠道详细
function goDetail(channelid){
	refresh();
	strChannel_id = channelid;
	$("#products").val(strChannel_id);
	$("#back").show(); 
	querygirdPartPage(1);
	if(flag){
	$("#div").hide();
	flag = false;
	}
}

//超链接返回查询全部
function back() {
	refresh();
	strChannel_id = "";
	$("#products").val(strChannel_id); 
	$("#back").hide();
	querygirdPartPage(1);
	if(flag){
	$("#div").hide();
	flag = false;
	}
}
//查询并下载birt报表
function downExcelFile(){
	//构造ajax后台数据查询的参数
	parampage.currentPage=parampage.getNewPage();
	//构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.channel_id=strChannel_id;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);;
	rtpparams.end_index = parampage.length;
	if(strChannel_id!=null && strChannel_id!=""){
	RptManager.genReportFile(rtpparams,'m_channel_id_gfan_query_channel_count.rptdisger',{
        callback:function(data){
            dwr.engine.openInDownload(data);
        },
        async : false
    });
    }else{
    RptManager.genReportFile(rtpparams,'gfan_query_channel_count.rptdisger',{
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
	rtpparams.channel_id =strChannel_id;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	
	//通过ajax查询后台数据
	if(strChannel_id!=null && strChannel_id!=""){
	RptManager.genReportDataToHtmlAndCount(rtpparams,'m_channel_id_gfan_query_channel_count.rptdisger', function(content){   
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		param.showLink={12:{name:'skipDetail',arg:[0,1,2]}};
		showgirdbirt01(param);
	});
	}else{
	RptManager.genReportDataToHtmlAndCount(rtpparams,'gfan_query_channel_count.rptdisger', function(content){   
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		param.showLink={12:{name:'skipDetail',arg:[0,1,2]},2:{name:'goDetail',arg:[1]}};
		showgirdbirt01(param);
	});
	}
	
}

//查询birt数据并展示报表（分数段数据）
function hoursCount() {
	var rtpparams = {};
	rtpparams.channel_id =channel_id_click;
	rtpparams.data_time =data_time_click;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	RptManager.genReportDataToHtmlAndCount(rtpparams,'device_query_creat_count.rptdisger', function(content){
	  parampage.count=parseInt(content[1]);
	  var param = new girdbirt02param(content[0],parampage);
	  showgirdbirt02(param);
	});
	RptManager.genReportDataToHtmlAndCount(rtpparams,'device_query_down_count.rptdisger', function(content){
	  parampage.count=parseInt(content[1]);
	  var param = new girdbirt03param(content[0],parampage);
	  showgirdbirt03(param);
	});
}

//显示分时段数据
function skipDetail(dataTime,channelID,channelName){
	if(channel_id_click==channelID && data_time_click==dataTime){
	   if(flag){
	   flag = false;
	   }else{
	   flag = true;
	   }
    }else{
    channel_id_click = channelID;
    data_time_click = dataTime;
    channel_name_click = channelName;
    flag = true;
    }
    document.getElementById("click1").innerHTML=data_time_click+"\t\t\t"+channel_id_click+"\t\t\t"+channel_name_click+"\t\t\t新增设备分时段数据";
    document.getElementById("click2").innerHTML=data_time_click+"\t\t\t"+channel_id_click+"\t\t\t"+channel_name_click+"\t\t\t下载设备分时段数据";
	if(channel_id_click!=null && channel_id_click!="" && data_time_click!=null && data_time_click!=""){
	    if(flag){
	    hoursCount();
	    setTimeout($("#div").show(),2000);
	    }else{
	    $("#div").hide();
	    }
	}else{
// 	    alert("channel_id_click的值为空");
 		$("#div").hide();
	}
}

//产品下拉框
function initProducts(){
	var rtpparams = {};
	RptManager.genReportDataToHtml(rtpparams,'select_gfan_channel_count.rptdisger', function(content){
		var content = JSON.parse(content);
		var products = content.list;
		if(products.length==0){
			$("#products").append("<option value=0>无渠道</option>");		
		}else{
		    $("#products").append("<option value=''>全部</option>");
			for(var index in products){
				var td = products[index];
				$("#products").append("<option value='"+td[0]+"'>"+td[1]+"</option>");
			}
		}
// 		initStorage();
	});
}

function initStorage(){
	var selectValue = $("#products").val();
	strChannel_id = selectValue;
	refresh();
	querygirdPartPage(1);
	if(flag){
	$("#div").hide();
	flag = false;
	}
	if($("#back").hide()){
	$("#back").show();
	}
}

//预加载
$("#products").change(function() { initStorage(); }); 
$(document).ready(function() {
	parampage = new page();
    parampage.buttonfun=querygirdPartPage;
	initProducts();
	refresh();
	querygirdPartPage(1);
});
</script>
