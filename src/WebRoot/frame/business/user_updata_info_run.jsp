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
			 <a href="#" onclick="skipDetail()"  style="margin: 0px;" >返回上一级</a> 
		</div>

		<div class="chart_cont" style="height:auto;position: relative;">
			用户&nbsp;I&nbsp;D：<strong id="userID" style="margin-right: 20px;"></strong>&nbsp;&nbsp;&nbsp;&nbsp;
			注册时间：<strong id="registerTime" readonly></strong><br/><br/>
			登录帐号：<input type="text" id="userLogin">&nbsp;&nbsp;&nbsp;&nbsp;
			渠道名称：<input type="text" id="userName"><br/><br/>
			选择角色：
			<select id="roles" style="height:20px;padding:0px;margin-bottom: 4px;width:210px;margin-right: 82px" >
			</select>&nbsp;&nbsp;&nbsp;&nbsp;<br/><br/>
			用户状态：
			<select id="userCheck" style="height:25px;padding:0px;margin-bottom: 4px;width:118px;margin-right: 171px" >
							<option value="0">正常</option>
							<option value="1">禁用</option>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;<br/><br/>
			<input type="button" onclick="isNull()" value="修改" style="height:auto;width:100px;">&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" onclick="IsSure()" value="删除本用户" style="height:auto;width:100px;">&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" onclick="go()" value="用户密码修改" style="height:auto;width:100px;"><br/><br/>
		</div>
	</div>
</div>

<script>
var nowTime = '<%=DateUtil.DateTime()%>';
var userID="${param.userID}";
var roleID="";
function IsSure(){
       var mes=confirm("您确定要删除该用户吗？");
       if(mes==true){ 
       deleteUser();
       }else{
        
       }
    }

function initRoles(){
	var rtpparams = {};
	RptManager.genReportDataToHtml(rtpparams,'role_select_user.rptdisger', function(content){
		var content = JSON.parse(content);
		var products = content.list;
		if(products.length==0){
			$("#roles").append("<option value=0>尚未配置角色</option>");		
		}else{
				$("#roles").append("<option value=0>尚未配置角色</option>");
			for(var index in products){
				var td = products[index];
				$("#roles").append("<option value='"+td[0]+"'>"+td[1]+"</option>");
			}
		}
// 		initStorage();
	});
}

//查询列表
function selectLy(){
	//构造列表默认参数
	RptManager.userQueryData(userID, function(content){
	    if(content[6]>0){
	     //查询成功
	    document.getElementById("userID").innerHTML=content[0];
	    $('#userName').val(content[1]);
	    $('#userLogin').val(content[2]);
	    document.getElementById("registerTime").innerHTML=content[3];
	    if(content[4]==0){
	    $('#userCheck').val("0");
	    }else{
	    $('#userCheck').val("1");
	    }
	    
	    RptManager.pmRoleQueryData(userID, function(content){
	    if(content[2]>0){
	     //查询成功
	    if(content[0]==0){
	    $('#roles').val(0);
	    }else{
	    $('#roles').val(content[0]);
	    }
		}else{
		  alert(content[1]+"出错！请重试或联系管理员！");
		}
	    });	
	    
		}else{
		  alert(content[5]+"出错！请重试或联系管理员！");
		}
	});	
}

function isNull() {
    userID = document.getElementById("userID").innerHTML;
    userName = $('#userName').val();
    userLogin = $('#userLogin').val();
    registerTime = nowTime;
    userCheck = $('#userCheck').val();
    roleID = $('#roles').val();
	if(userName==null){
	alert("请填写渠道用户名称！");
	return false;
	}else{
	  if(userLogin==null){
	alert("请填写渠道用户登录名！");
	return false;
	}else{
    updataLy();
	}
	}
}
 
//修改操作
function updataLy() {
	 RptManager.userUpdataData(userID,userName,userLogin,registerTime,userCheck, function(msg){
	          if(msg[1]>0){
	           RptManager.pmRoleInsertData(userID,roleID, function(msg){
	                 if(msg[1]>0){
	                   alert("修改成功！");
	                   skipDetail();
		              }else{
		                 alert(msg[0]+"请重试或联系管理员！");
		              }
	           });
		      }else{
		         alert(msg[0]+"请重试或联系管理员！");
		      }
	 });
	
}

//修改操作
function deleteUser() {
	     RptManager.userDeleteData(userID,userName,userLogin,registerTime,userCheck, function(msg){
	          if(msg[1]>0){
	             alert("用户删除成功！");
	             skipDetail();
		      }else{
		         alert(msg[0]+"请重试或联系管理员！");
		      }
	 });
}

//局部刷新
function skipDetail(){
	var loadURL = '/frame/business/user_updata_info.jsp';
// 	var loadURL = '/frame/business/user_insert_info_pwd.jsp';
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

function go() {
 var name=prompt("请输入新密码","");
    if (name!=null && name!="")
    {
    RptManager.pwdUpdataData(userID, name, function(content) {
			      if (content[1] > 0) {
						alert("修改成功!"); 
// 						skipDetail();
			       } else {
				        alert(content[0] + "出错！请重试或联系管理员！");
			       }
		   });
    }else{
    
    }

}


$(document).ready(function() {
    selectLy();
    initRoles();
});
</script>
