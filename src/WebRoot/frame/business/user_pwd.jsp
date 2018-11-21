<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.gfan.report.frame.util.DateUtil"%>
<%@include file="/commons/taglibs.jsp"%>
<%@ taglib uri="http://www.waally.com" prefix="wl"%>
<link href="${base}/frame/table/css/style.css" rel="stylesheet"
	type="text/css" />
<style type="text/css">
input[type="text"] {
	width: 110px;
	height: 18px;
	padding: 2px;
	margin-bottom: 4px;
	line-height: normal;
}
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
		<div class="chart_cont"
			style="height:auto!important;height:310px;position: relative;">
			登录密码：<input type="text" id="userPwd">&nbsp;&nbsp;&nbsp;&nbsp;
			确认密码：<input type="text" id="userPwd2"><br />
			<br /> <input type="button" onclick="refresh()" value="保存"
				id="SUBMIT" style="height:auto;width:50px;">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button"
				onclick="setValueNull()" value="重置" id="RESET"
				style="height:auto;width:50px;"><br />
		</div>
	</div>
</div>

<script>
var nowTime = '<%=DateUtil.getStringDate(0)%>';
var userPwd = "";
var userPwd2 = "";
var userID="${param.userID}";
alert(userID);

	//局部刷新
	function skipDetail() {
		var loadURL = '/frame/business/user_updata_info.jsp';
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

	function refresh() {
		userPwd = $('#userPwd').val();
		userPwd2 = $('#userPwd2').val();
		if (userPwd != userPwd2) {
			alert("对不起，两次输入密码不一致！请重新输入！");
			$('#userPwd').val("");
			$('#userPwd2').val("");
			return false;
		}
		isNULL();
	}

	//判断是否为空
	function isNULL() {
		
			if (userPwd == "") {
				alert("请填写渠道用户登录密码！");
				return false;
			} else {

				if (userPwd2 == "") {
					alert("请输入渠道用户登录确认密码！");
					return false;
				} else {
					if (ischeckemail()) {
						insertRun();
					}

				}

			}

		
	}

	

	//后台添加
	function insertRun() {
		RptManager.pwdUpdataData(userID, pwd, function(content) {
			if (content[1] > 0) {
						alert("修改成功!"); 
						skipDetail();
			} else {
				alert(content[0] + "出错！请重试或联系管理员！");
			}
		});
	}

	//初始化input
	function setValueNull() {
		$('#userPwd').val("");
		$('#userPwd2').val("");
	}
</script>
