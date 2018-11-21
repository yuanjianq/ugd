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
			<a href="javascript:;" class="collapse"></a>
		</div>
	</div>
	<div class="portlet-body flip-scroll" align="center">
		<div style="text-align: right;">
			 <a href="#" onclick="skipDetail()"  style="margin: 0px;" >返回上一级</a> 
		</div>

		<div class="chart_cont" style="height:120px;position: relative;">
			核减概率：<input type="text" id="checkPer"><br/><br/>
			<input type="button" onclick="isNull()" value="修改" style="height:auto;width:100px;"><br/>
		</div>
	</div>
</div>

<script>
var nowTime = '<%=DateUtil.getStringDate(0)%>';
var channelID="${param.channelID}";
var orderID="${param.orderID}";
var checkPer="";
//查询列表
function selectLy(){
	//构造列表默认参数
	RptManager.lyQueryData(orderID,channelID, function(content){
	    if(content[10]>0){
	     //查询成功
	    $('#checkPer').val(content[6]*100);
		}else{
		  alert(content[9]+"查询出错！请重试或联系管理员！");
		}
	});	
}

function isNull() {
    checkPer = ($('#checkPer').val())/100;
	if(checkPer==null){
	alert("请填写扣量百分比！");
	return false;
	}else{
	  if(checkPer>100 || checkPer<0){
	    alert("扣量百分比不得低于0%,不得高于100%！");
	    return false;
	  }
	}
	updataLy();
}

//修改操作
function updataLy() {
	     RptManager.genReportUpdataDataToHtml(orderID,channelID,checkPer, function(msg){
	          if(msg[1]>0){
	             alert("修改成功！");
	             skipDetail();
		      }else{
		         alert(msg[0]+"请重试或联系管理员！");
		      }
	 });
}

//局部刷新
function skipDetail(){
	var loadURL = '/frame/business/ly_updata_info.jsp';
	jQuery.ajax({
		type : "POST",
		url : "${base}" + loadURL,
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
    selectLy();
});
</script>
