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
			<i class="icon-reorder">&nbsp;统计概括</i></span>
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
			<select style="height:20px;width: 70px;padding:0px;margin-bottom: 4px;margin-right: 10px;"
			id="version" name="version" onchange="query()">
				<option value="5020" >V1.3.3</option>
		        <option value="5030" selected="selected">V1.3.4</option>
			</select>
			<select style="height:20px;width: auto;padding:0px;margin-bottom: 4px;margin-right: 10px;"
			id="time" name="time" onchange="changedate()">
				<option value="1" selected="selected">日报</option>
		        <option value="3" >月报</option>
			</select>
			<input type="text" id="startTime1" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="tabledate Wdate" value="<%=DateUtil.getStringDate(-30)%>" class="Wdate" style="width:110px;height:18px;padding: 2px;margin-bottom:4px;line-height:normal;"/>  
			<input type="text" id="startTime3" onfocus="WdatePicker({dateFmt:'yyyy-MM'})" class="Wdate tabledate" value="<%=DateUtil.getStringMonth(-6)%>" style="display: none;" class="Wdate"/> 
			至
			<input type="text" id="endTime1" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate tabledate" value="<%=DateUtil.getStringDate(-1)%>" class="Wdate"/>  
			<input type="text" id="endTime3" onfocus="WdatePicker({dateFmt:'yyyy-MM'})" class="Wdate tabledate" value="<%=DateUtil.getStringMonth(-1)%>" style="display: none;" class="Wdate"/> 
			<button class="btn green mini" style="margin-bottom: 6px;margin-right:16px;" onclick="query()">
				查询 
				<i class="m-icon-swapright m-icon-white" style="margin: 0px;"></i>
			</button>
		</div>
		<div class="chart_cont">
			<jsp:include page="/frame/base/linechart02.jsp"/>
		</div>
		<div class="chart_cont" style="height:320px;position: relative;">
			<jsp:include page="/frame/base/girdbirt01.jsp"/>
		</div>
	</div>
</div>

<script>
var dateType = '1';
var startTime = '';
var endTime = '';
var version = '';

function refresh(){
	var type = $("#time").find("option:selected").val();
	startTime = $('#startTime'+type).val();
	endTime = $('#endTime'+type).val();
	version = $("#version").val();
	if(type=='3'){
		dateType = '2';
	}else{
		dateType = '1';
	}	
}

function changedate(){
	var type = $("#time").find("option:selected").val();
	for(var i=1;i<=3;i++){
		$('#startTime'+i).css({ display: "none"});
		$('#endTime'+i).css({ display: "none"});
	}
	$('#startTime'+type).css({ display: "inline"});
	$('#endTime'+type).css({ display: "inline"});
}

function query(){
	refresh();
	querygirdPartPage(1);
	queryline();
}

//查询并下载birt报表
function downExcelFile(){
	//构造ajax后台数据查询的参数
	refresh();
	var rtpparams = {};
	rtpparams.start_time=startTime;
	rtpparams.client_version=version;
	rtpparams.end_time=endTime;
	rtpparams.data_type = dateType;
	rtpparams.start_index = 0;
	rtpparams.end_index = 100
	RptManager.genReportFile(rtpparams,'client_detail_count.rptdisger',{
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
	rtpparams.start_time=startTime;
	rtpparams.client_version=version;
	rtpparams.end_time=endTime;
	rtpparams.data_type = dateType;
	rtpparams.start_index = parampage.length*(parampage.currentPage-1);
	rtpparams.end_index = parampage.length;
	rtpparams.DESC = 'DESC';
	//通过ajax查询后台数据
	RptManager.genReportDataToHtmlAndCount(rtpparams,'client_detail_count.rptdisger', function(content){
		parampage.count=parseInt(content[1]);
		//构造报表模板参数，并展示模板
		var param = new girdbirt01param(content[0],parampage);
		showgirdbirt01(param);
	});
}

//查询线图并展示
function queryline(){
	var rtpparams = {};
	rtpparams.start_time=startTime;
	rtpparams.client_version=version;
	rtpparams.end_time=endTime;
	rtpparams.data_type = dateType;
	rtpparams.start_index = 0;
	rtpparams.end_index = 100;
	rtpparams.DESC = 'ASC';
	//通过ajax查询后台数据
	RptManager.genReportData(rtpparams,'client_detail_count.rptdesign',function(content){
		//转换数据为指定的格式
		var array = JSON.parse(content);
		var xline = new Array();
		var yline = new Array();
		var legend = new Array();
		for(var temp in array){
			if(temp=='xline'){
				xline = array[temp];
			}else{
				for(var i=0;i<array[temp].length;i++){
					array[temp][i] = parseInt(array[temp][i]);
				}
				yline.push({name:temp,data:array[temp],type:'line'})
				legend.push(temp);
			}
		}
		//构造报表模板参数，并展示模板
		var param2 = new linechart02param(xline,yline,'趋势图',legend);
		showlinechart02(param2);
	});
}

$(document).ready(function() {
    parampage = new page();
    parampage.buttonfun=querygirdPartPage;
    query();
});
</script>
