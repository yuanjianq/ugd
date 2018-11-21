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
			<i class="icon-reorder"></i>盒子统计数据
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
			<select id="channels" style="height:20px;padding:0px;margin-bottom: 4px;width:210px" >
			</select>&nbsp;&nbsp;&nbsp;&nbsp;
			<select id="storages" style="height:20px;padding:0px;margin-bottom: 4px;width:210px">
			</select>
					<select style="height:20px;width: auto;padding:0px;margin-bottom: 4px;"
			id="time" name="time" onchange="changedate()">
				<option value="1" selected="selected">日报</option>
		        <option value="2" >周报</option>
		        <option value="3" >月报</option>
			</select>
			查询日期：
			<input type="text" id="startTime1" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="tabledate Wdate" value="<%=DateUtil.getStringDate(-1)%>" class="Wdate" style="width:110px;height:18px;padding: 2px;margin-bottom:4px;line-height:normal;"/> 
			<input type="text" id="startTime2" onfocus="WdatePicker({isShowWeek:true,disabledDays:[0,2,3,4,5,6]})" class="Wdate tabledate" value="<%=DateUtil.getStringWeek(-1)%>" style="display: none;" class="Wdate" style="width:110px;height:18px;padding: 2px;margin-bottom:4px;line-height:normal;"/> 
			<input type="text" id="startTime3" onfocus="WdatePicker({dateFmt:'yyyy-MM'})" class="Wdate tabledate" value="<%=DateUtil.getStringMonth(-1)%>" style="display: none;" class="Wdate"/> 
			
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
var startTime = '';
var endTime = '';
var storageId_sel="";
var dateType = '1';
//报表周期改变
function refresh(){
	var type = $("#time").find("option:selected").val();
	startTime = $('#startTime'+type).val();
	endTime =startTime;
	
	if(type=='2'){
		dateType = '4';
	}else if(type=='3'){
		dateType = '2';
		startTime+="-01";
		endTime+="-01";
	}else{
		dateType = '1';
	}

}
//时间改变
function changedate(){
	var type = $("#time").find("option:selected").val();
	for(var i=1;i<=3;i++){
		$('#startTime'+i).css({ display: "none"});
		$('#endTime'+i).css({ display: "none"});
	}
	$('#startTime'+type).css({ display: ""});
	$('#endTime'+type).css({ display: ""});
}
//查询并下载birt报表
function downExcelFile(){
	//构造ajax后台数据查询的参数
	if(storageId_sel==0){
		return;
	}
	parampage.currentPage=parampage.getNewPage();
	//构造ajax后台数据查询的参数
	var rtpparams = {};
	rtpparams.data_type = dateType;
	rtpparams.boxids = " AND storage_id ="+storageId_sel;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.start_index = 0;
	rtpparams.end_index = 100;
	RptManager.genReportFile(rtpparams,'query_device_box.rptdisger',{
        callback:function(data){
            dwr.engine.openInDownload(data);
        },
        async : false
    })
}		
//查询数据
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
	rtpparams.data_type = dateType;
	rtpparams.boxids = " AND storage_id ="+storageId_sel;
	rtpparams.start_time=startTime;
	rtpparams.end_time=endTime;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	//通过ajax查询后台数据
	RptManager.genReportDataToHtmlAndCount(rtpparams,'query_device_box.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		//查询类型不为周的时候  
		if(dateType!=4){
			param.showLink={1:{name:'skipDetail',arg:[0,1]}};
		}
		showgirdbirt01(param);
	});
}
//跳转到详情页面
function skipDetail(dataTime,client_uid){
	var loadURL = '/frame/business/device_detail.jsp?';
	var urlParam = "dataTime="+dataTime+"&dataType="+dateType+"&boxName="+client_uid;
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


//初始化渠道查询条件
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
//初始化仓库查询条件
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
		checkStorage();
	});
}
//校验渠道是否为空  不为空再进行查询
function checkStorage(){
	storageId_sel = $("#storages").val();
	query();
}

//页面加载完毕事件
$(document).ready(function() {
	parampage = new page();
    parampage.buttonfun=querygirdPartPage;
    $("#channels").change(function() { initStorage(); }); 
    $("#storages").change(function() { checkStorage(); }); 
	initChannels();
});
</script>
