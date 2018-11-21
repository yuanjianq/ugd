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
			用户昵称：<input type="text" id="userName" placeholder="渠道名称">&nbsp;&nbsp;&nbsp;&nbsp;
			渠&nbsp;道&nbsp;ID：<input type="text" id="channelID" /><br /> <br />
			登录帐号：<input type="text" id="userLogin" placeholder="邮 箱">&nbsp;&nbsp;&nbsp;&nbsp;
			登录密码：<input type="text" id="userPwd"><br /> <br /> 确认密码：<input
				type="text" id="userPwd2" style="margin-right: 207px"><br />
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
	var userLogin = "";
	var userName = "";
	var userPwd = "";
	var userID = "${sessionScope.userInfo.id}";
	var channelID = "";
	//局部刷新
	function skipDetail() {
		var loadURL = '/frame/business/user_updata_info_gfan.jsp';
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
		userLogin = $('#userLogin').val();
		userName = $('#userName').val();
		userPwd = $('#userPwd').val();
		userPwd2 = $('#userPwd2').val();
		channelID = $('#channelID').val();
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
		if (userName == "") {
			alert("请填写渠道用户名称！");
			return false;
		} else {

			if (userPwd == "") {
				alert("请填写渠道用户登录密码！");
				return false;
			} else {

				if (userPwd2 == "") {
					alert("请输入渠道用户登录确认密码！");
					return false;
				} else {
					if (ischeckemail()) {
						// 						insertRun();
						checkChannel();
					}

				}

			}

		}
	}

	//判断帐号是否为邮箱
	function ischeckemail() {
		var email = document.getElementById("userLogin").value;
		if (email != "") {
			var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
			isok = reg.test(email);
			if (!isok) {
				alert("邮箱格式不正确，请重新输入！");
				document.getElementById("userLogin").focus();
				return false;
			}
			return true;
		}
		;
	}

	function checkEmail() {
		RptManager.userIDSQueryData(userLogin, function(content) {
			if (content[2] > 0) {
				if (content[0] != "0") {
					alert("对不起！邮箱名已存在请重新输入！");
					$('#userLogin').val("");
				} else {
					insertRun();
				}
			} else {
				alert(content[1] + "出错！请重试或联系管理员！");
			}
		});
	}

	function checkChannel() {
		RptManager.channelIDSQueryData(channelID, function(msg) {
			if (msg[0] == 0) {
				checkEmail();
			} else {
				alert("对不起,渠道ID已存在,请核对ID是否正确或更换！");
			}
		});
	}

	//后台添加
	function insertRun() {
		RptManager.userInsertData(userName, userLogin, function(content) {
			if (content[1] > 0) {
				RptManager.userPwdInsertData(userLogin, userPwd, function(
						content) {
					if (content[1] > 0) {
// 						alert("添加成功!");
// 						skipDetail();
      					gfanInsertRun();
					} else {
						alert(content[0] + "出错！请重试或联系管理员！");
					}
				});
			} else {
				alert(content[0] + "出错！请重试或联系管理员！");
			}
		});
	}

	function gfanInsertRun() {
		RptManager.fanInsertUserIdData(userLogin,channelID,userName, function(content) {
			if (content[1] > 0) {
				alert("添加成功!");
				skipDetail();
			} else {
				alert(content[0] + "出错！请重试或联系管理员！");
			}
		});
	}

	//初始化input
	function setValueNull() {
		$('#userName').val("");
		$('#userLogin').val("");
		$('#userPwd').val("");
		$('#userPwd2').val("");
	}
</script>
