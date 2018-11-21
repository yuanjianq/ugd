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
			<i class="icon-reorder"></i>单机游戏数据录入&添加
		</div>
		<div class="tools">
	        <a class="btn blue mini" style="margin-bottom:6px;">Excel批量导入
               <div style="filter:alpha(opacity=0);cursor: pointer; opacity: 0; position: absolute;  width: 75px;margin: -18px 0 0 -6px ;margin: -16px 0 0 -6px\9;height:20px\9;overflow: hidden; ">
                  <input type="file" id="txtFile" onchange="uploadFile()" name="upload" style="font-size: 200px;cursor: pointer;direction: rtl ！important; float: right\9; "/>
               </div>
            </a>
			<a href="javascript:;" class="collapse"></a>
		</div>
	</div>
	<div class="portlet-body flip-scroll" align="center">
		<div class="chart_cont" style="height:auto!important;height:310px;position: relative;">
				日&nbsp;&nbsp;&nbsp;&nbsp;期：<input type="text" id="startTime1" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="tabledate Wdate" value="<%=DateUtil.getStringDate(-1)%>" class="Wdate" style="width:110px;height:18px;padding: 2px;margin-bottom:4px;line-height:normal;"/> &nbsp;&nbsp;&nbsp;&nbsp;
				渠道名称：<input type="text" id="channelName"><br/><br/>
				产&nbsp;品&nbsp;ID：<input type="text" id="productID">&nbsp;&nbsp;&nbsp;&nbsp;
				产品名称：<input type="text" id="productName"><br/><br/>
				新增人数：<input type="text" id="registerUser" >&nbsp;&nbsp;&nbsp;&nbsp;
				用&nbsp;户&nbsp;ID：<input type="text" id="userID" /><br/><br/>
			    <input type="button" onclick="refresh()" value="保存" id="SUBMIT" style="height:auto;width:50px;"> &nbsp;&nbsp;&nbsp;&nbsp; <input type="button" value="重置" id="RESET" style="height:auto;width:50px;" onclick="init()"><br/>
		</div>
	</div>
</div>

<script>
var nowTime = '<%=DateUtil.getStringDate(0)%>';
var channelName="";
var startTime="";
var productID="";
var productName="";
var registerUser="";
// var userID = "${sessionScope.userInfo.id}";
var userID = "";

function refresh(){
	startTime = $('#startTime1').val();
	channelName = $('#channelName').val();
	productID = $('#productID').val();
	productName = $('#productName').val();
	registerUser = $('#registerUser').val();
	userID = $('#userID').val();
	isNULL();
	insertRun();
}

//检测是否为空值
function isNULL() {
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
	if(registerUser==""){
	alert("请填写新增用户数！");
	return false;
	}
}

//上传excel
function uploadFile() {
	if (getV("txtFile") != "") {
		RptManager.uploadReportFile(dwr.util.getValue("txtFile"),userID, function(data) {
          if(data[0]>0){
          alert("导入成功！成功导入"+data[1]+"条数据！");
          }else{
          alert("导入失败，请查看文档格式是否合法或联系管理员！");
          }
		}); 
	} else {
		errorPormt("txtFile", "请选择一个文件");
	}
}

//执行添加
function insertRun(){
	RptManager.genReportInsertDataToHtml(startTime,userID,channelName,productID,productName,registerUser, function(content){
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
//    $('#channelName').val("");
//    $('#productID').val("");
//    $('#productName').val("");
   $('#registerUser').val("");
//    $('#userID').val("");
}
</script>
