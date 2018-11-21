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
			<i class="icon-reorder"></i>用户管理
		</div>
		<div class="tools">
		
			<a href="javascript:;" class="collapse"></a>
		</div>
	</div>
	<div class="portlet-body flip-scroll" align="center">
	    <div style="text-align: right;">
			<a href="#" onclick="skipDetail()" style="margin: 0px;">返回上一级</a>
		</div>
		<div class="chart_cont" style="height:auto!important;height:310px;position: relative;">
			     角色名称：<input type="text" id="roleName">&nbsp;&nbsp;&nbsp;&nbsp;
			    角色关键字：<input type="text" id="roleZy"><br /><br /> 
			    角色描述：<textarea  type="text" id="roleBz" style="margin-right:auto;width: 330px;height: 80px"></textarea><br /><br />  
			    <input type="button" onclick="refresh()" value="保存" id="SUBMIT" style="height:auto;width:50px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" onclick="setValueNull()" value="重置" id="RESET" style="height:auto;width:50px;"><br/>
		</div>
	</div>
</div>

<script>
var nowTime = '<%=DateUtil.getStringDate(0)%>';
var roleName="";
var roleZy="";
var roleBz="";
var userID = "${sessionScope.userInfo.id}";
function refresh(){
	roleBz = $('#roleBz').val();
	roleZy = $('#roleZy').val();
	roleName = $('#roleName').val();
	isNULL();
	
}

//局部刷新
	function skipDetail() {
		var loadURL = '/frame/business/role_updata_info.jsp';
		jQuery.ajax({
			type : "POST",
			url : "${base}" + loadURL,
			dataType : 'text',
			data : {},
			success : function(response) {
				$("#vf_content").empty();
				$("#vf_content").append(response);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
			}
		});
	}

//判断是否为空
function isNULL() {
	if(roleName==""){
	alert("请填写角色名称！");
	return false;
	}
	if(roleBz==""){
	alert("请填写角色关键字！");
	return false;
	}
	if(roleZy==""){
	alert("请填写角色描述！");
	return false;
	}
	insertRun();
}

//后台添加
function insertRun(){
	RptManager.roleInsertData(roleName,roleZy,roleBz, function(content){
		if(content[1]>0){
		alert("添加成功!");
	    skipDetail();
		}else{
		alert(content[0]+"出错！请重试或联系管理员！");
		}
	});
}

//初始化input
function setValueNull() {
	$('#roleName').val("");
	    $('#roleZy').val("");
	    $('#roleBz').val("");
}

</script>
