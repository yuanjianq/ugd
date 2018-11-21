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
			<i class="icon-reorder"></i>联运游戏渠道添加
		</div>
		<div class="tools">
			<a href="javascript:;" class="collapse"></a>
		</div>
	</div>
	<div class="portlet-body flip-scroll" align="center">
		<div class="chart_cont" style="height:auto!important;height:310px;position: relative;">
                                渠&nbsp;道&nbsp;ID：<input type="text" id="channelID" />&nbsp;&nbsp;&nbsp;&nbsp;
				渠道名称：<input type="text" id="channelName" /><br/><br/>
				产&nbsp;品&nbsp;ID：<input type="text" id="productID" />&nbsp;&nbsp;&nbsp;&nbsp;
				产品名称：<input type="text" id="productName" /><br/><br/>
				交易类型：<select id="dealMode" style="height:25px;padding:0px;margin-bottom: 4px;width:118px" >
							<option value="1">CPS</option>
							<option value="2">CPA</option>
			             </select>&nbsp;&nbsp;&nbsp;&nbsp;
				订单编号：<input type="text" id="orderID" onpropertychange="javascript:CheckInputInt(this);" /><br/><br/>
			        用&nbsp;户&nbsp;ID：<input type="text" id="userID" style="margin-right: 208px;" /><br/><br/>
			    <input type="button" onclick="refresh()" value="保存" id="SUBMIT" style="height:auto;width:50px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" onclick="setValueNull()" value="重置" id="RESET" style="height:auto;width:50px;"><br/>
		</div>
	</div>
</div>

<script>
var nowTime = '<%=DateUtil.getStringDate(0)%>';
var channelName="";
var channelID="";
var productID="";
var productName="";
var orderID="";
var dealMode="";
var userID = "";
// var userID = "${sessionScope.userInfo.id}";
function refresh(){
	channelID = $('#channelID').val();
	channelName = $('#channelName').val();
	productID = $('#productID').val();
	productName = $('#productName').val();
	dealMode = $('#dealMode').val();
	orderID = $('#orderID').val();
	userID = $('#userID').val();
	isNULL();
	insertRun();
}

//强制只能输入整形
function CheckInputInt(oInput)
{
    if  ('' != oInput.value.replace(/\d/g,''))
    {
        oInput.value = oInput.value.replace(/\D/g,'');
    }
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
	if(productID==""){
	alert("请填写产品ID！");
	return false;
	}
	if(productName==""){
	alert("请填写产品名称！");
	return false;
	}
	if(dealMode==""){
	alert("请填写交易类型！");
	return false;
	}
	if(orderID==""){
	alert("请填写订单ID！");
	return false;
	}
}

//后台添加
function insertRun(){
	var rtpparams = {};
	rtpparams.userID =userID;
	rtpparams.channelID =channelID;
	rtpparams.channelName =channelName;
	rtpparams.productID =productID;
	rtpparams.productName =productName;
	rtpparams.dealMode =dealMode;
	rtpparams.orderID =orderID;	
	RptManager.lyInsertData(rtpparams, function(content){
		if(content[1]>0){
		alert("添加成功!");
	    setValueNull();
		}else{
		alert(content[0]+"出错！请重试或联系管理员！");
		}
	});
}

//初始化input
function setValueNull() {
	$('#channelID').val("");
	    $('#channelName').val("");
	    $('#productID').val("");
    	$('#productName').val("");
	    $('#checkPer').val("");
	    $('#orderID').val("");
}

</script>
