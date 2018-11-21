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
			<i class="icon-reorder"></i>机锋市场渠道添加
		</div>
		<div class="tools">
			<a href="javascript:;" class="collapse"></a>
		</div>
	</div>
	<div class="portlet-body flip-scroll" align="center">
		<div class="chart_cont" style="height:120px;position: relative;">
                                渠&nbsp;道&nbsp;ID：<input type="text" id="channelID" />&nbsp;&nbsp;&nbsp;&nbsp;
				渠道名称：<input type="text" id="channelName" /><br/><br/>
				用&nbsp;户&nbsp;ID：<input type="text" id="userID" style="margin-right: 208px;" /><br/><br/>
			    <input type="button" onclick="refresh()" value="保存" id="SUBMIT" style="height:auto;width:50px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" onclick="setValueNull()" value="重置" id="RESET" style="height:auto;width:50px;"><br/>
		</div>
	</div>
</div>

<script>
var nowTime = '<%=DateUtil.getStringDate(0)%>';
var channelName="";
var channelID="";
// var userID = "${sessionScope.userInfo.id}";
var userID = "";
function refresh(){
	channelID = $('#channelID').val();
	channelName = $('#channelName').val();
	userID = $('#userID').val();
	isNULL();
	insertRun();
}

//判断是否为空
function isNULL() {
	if(channelID==""){
	alert("请填写渠道ID！");
	return false;
	}
	if(channelName==""){
	alert("请填写渠道名称！");
	return false;
	}
}

//后台添加
function insertRun(){
	var rtpparams = {};
	rtpparams.userID =userID;
	rtpparams.channelID =channelID;
	rtpparams.channelName =channelName;
	RptManager.channelIDSQueryData(channelID, function(msg){
	if(msg[0]==0){
	    RptManager.gengfanInsertDataToHtml(rtpparams, function(content){
		if(content[1]>0){
		alert("添加成功!");
	    setValueNull();
		}else{
		alert(content[0]+"出错！请重试或联系管理员！");
		}
	    });
	}else{
	 alert("对不起,渠道ID已存在,请核对ID是否正确或更换！");
	}
	});
}

//初始化input
function setValueNull() {
	$('#channelID').val("");
	$('#channelName').val("");
}

</script>
