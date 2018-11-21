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
			<i class="icon-reorder"></i>角色管理
		</div>
		<div class="tools">
			<a href="javascript:;" class="collapse"></a>
		</div>
	</div>
	<div class="portlet-body flip-scroll" align="center">
		<div style="text-align: right;">
			<a href="#" onclick="skipDetail()" style="margin: 0px;">返回上一级</a>
		</div>

		<div class="chart_cont" style="height:auto;position: relative;">
			角色ID：<strong id="roleID" style="margin-right: 328px"></strong><br /><br />
			角色名称：<input type="text" id="roleName">&nbsp;&nbsp;&nbsp;&nbsp;
			角色关键字：<input type="text" id="roleZy"><br /><br /> 
			角色描述：<textarea  type="text" id="roleBz" style="margin-right:auto;width: 330px;height: 80px"></textarea><br /><br /> 
			<input type="button" onclick="isNull()" value="修改" style="height:auto;width:100px;">&nbsp;&nbsp;&nbsp;&nbsp;
<!-- 			<input type="button" onclick="skipDetail()" value="取消" style="height:auto;width:100px;">&nbsp;&nbsp; -->
			<input type="button" onclick="IsSure()" value="删除本角色" style="height:auto;width:100px;"><br />
		</div>
	</div>
</div>

<script>
var nowTime = '<%=DateUtil.getStringDate(0)%>';
	var roleID = "${param.roleID}";
	var checkPer = "";
	
	function IsSure(){
       var mes=confirm("您确定要删除该用户吗？");
       if(mes==true){ 
       deleteRole();
       }else{
        
       }
    }
	
	//查询列表
	function selectLy() {
		//构造列表默认参数
		RptManager.roleQueryData(roleID, function(content) {
			if (content[5] > 0) {
				//查询成功
// 				$('#roleID').val(content[0]);
				document.getElementById("roleID").innerHTML=content[0];
				$('#roleName').val(content[1]);
				$('#roleZy').val(content[2]);
				$('#roleBz').val(content[3]);
			} else {
				alert(content[4] + "查询出错！请重试或联系管理员！");
			}
		});
	}

	function isNull() {
		roleID =  document.getElementById("roleID").innerHTML;
		roleName = $('#roleName').val();
		roleZy = $('#roleBz').val();
		roleBz = $('#roleBz').val();
		if (roleName == null) {
			alert("请填写角色名称！");
			return false;
		} else {
			if (roleZy == null) {
				alert("请填写角色关键字！");
				return false;
			} else {
				if (roleBz == null) {
					alert("请填写角色描述！");
					return false;
				} else {
					updataLy();
				}
			}
		}

	}
	//修改操作
	function updataLy() {
		RptManager.roleUpdataData(roleID, roleName, roleZy ,roleBz,
				function(msg) {
					if (msg[1] > 0) {
						alert("修改成功！");
						skipDetail();
					} else {
						alert(msg[0] + "请重试或联系管理员！");
					}
				});
	}
	
	//删除操作
	function deleteRole() {
		RptManager.roleDeleteData(roleID,
				function(msg) {
					if (msg[1] > 0) {
						alert("角色已删除！");
						skipDetail();
					} else {
						alert(msg[0] + "请重试或联系管理员！");
					}
				});
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

	$(document).ready(function() {
		selectLy();
	});
</script>
