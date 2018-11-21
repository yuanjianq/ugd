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
			<i class="icon-reorder"></i>机锋市场核验维护
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
			默认扣量：<input type="text" id="allDis"><br/><br/>
			渠道扣量：<input type="text" id="channelDis"><br/><br/>
			<input type="button" onclick="isNull()" value="修改" style="height:auto;width:100px;"><br/>
		</div>
	</div>
</div>

<script>
var nowTime = '<%=DateUtil.getStringDate(0)%>';
var channelID="${param.channelID}";
 //查询列表
function selectGfan(){
	//构造列表默认参数
	RptManager.gfanQueryData(channelID, function(content){
	    if(content[7]>0){
	     //查询成功
	    $('#allDis').val(content[3]*100);
	    $('#channelDis').val(content[4]*100);
		}else{
		  alert(content[6]+"查询出错！请重试或联系管理员！");
		}
	});	
}
 
function isNull() {

	allDis = ($('#allDis').val())/100;
	channelDis = ($('#channelDis').val())/100;
	if(allDis==null){
	alert("请填写默认扣量百分比！");
	return false;
	}else{
	  if(allDis>100 || allDis<0){
	    alert("默认扣量百分比不得低于0%,不得高于100%！");
	    return false;
	  }
	}
	if(channelDis==null){
	        alert("请填写渠道扣量百分比！");
	        return false;
	     }else{
	       if(channelDis>100 || channelDis<0){
	        alert("渠道扣量百分比不得低于0%,不得高于100%！");
	        return false;
	       }
	 }
	 updatagfan();
}

//修改操作
function updatagfan() {
	RptManager.gfanUpdataData(channelID,allDis,channelDis, function(msg){
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
	var loadURL = '/frame/business/gfan_updata_info.jsp';
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
    selectGfan();
});
</script>
