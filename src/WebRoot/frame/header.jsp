<%@ page language="java" pageEncoding="UTF-8"%>
<div class="header navbar navbar-inverse navbar-fixed-top">
	<!-- BEGIN TOP NAVIGATION BAR -->
	<div class="navbar-inner">
		<div class="container-fluid">
			<a class="brand" href="javascript:void(0);" style="padding: 0px;">
				<img src="${base}/frame/media/image/logo.png" alt="logo" />
			</a>
			<a href="javascript:;" class="btn-navbar collapsed" data-toggle="collapse" data-target=".nav-collapse">
			<img src="${base}/frame/media/image/menu-toggler.png" alt="" />
			</a>          
			<ul class="nav pull-right">
				<li class="dropdown user">
					<a href="javascript:void(0)" style="margin-top:0px;color:#fff;">
						<span class="username">${sessionScope.userInfo.displayName}</span>
					</a>
					<li><a href="${base}/login/out.gfan" onclick="logout()" ><i class="icon-key"></i> 注销</a></li>
				</li>
			</ul>
		</div>
	</div>
</div>
<script>
	function logout(){
// 		delCookie('lm_auth','lianmeng168.com','/');
	}
	function delCookie(name,domain,path) { 
	    var exp = new Date(); 
	    exp.setTime(exp.getTime() - 1); 
	    var cval=getCookie(name); 
	    var cookiestr = '';
	    if(cval!=null){
	    	cookiestr= name + "="+cval+";expires="+exp.toGMTString(); 
	    }
	    if(domain!=null){
	    	cookiestr+=";domain="+domain;
	    }
	    if(path!=null){
	    	cookiestr+=";path="+path;
	    }
	    document.cookie= cookiestr; 
	} 
	function getCookie(name){ 
	    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
	    if(arr=document.cookie.match(reg))
	        return unescape(arr[2]); 
	    else 
	        return null; 
	} 
</script>