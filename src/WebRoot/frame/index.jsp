<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/taglibs.jsp"%>
<%@include file="/commons/jquerylibs.jsp"%>
<head>
	<meta charset="utf-8" />
	<title>游戏推广业务渠道门户系统</title>
	<meta content="width=device-width, height=device-height, initial-scale=1.0" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	<meta name="renderer" content="webkit">
	<link rel="stylesheet" href="${base}/frame/media/css/DT_bootstrap.css" />
	<link rel="icon" href="${base}/frame/media/image/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${base}/frame/media/image/favicon.ico" type="image/x-icon" />
	<script src="${base}/dwr/engine.js"></script>
	<script src="${base}/dwr/util.js"></script>
	<script src="${base}/frame/media/js/public.js"></script>
	<script src="${base}/dwr/interface/RptManager.js"></script>
</head>
<body class="page-header-fixed">
	<%@include file="/frame/header.jsp"%>
	<div class="page-container row-fluid">
		<%@include file="/frame/left.jsp"%>
		<%@include file="/frame/main.jsp"%>
	</div>
	<%@include file="/frame/footer.jsp"%>
	
	<script src="${base}/frame/media/js/app.js"></script>      
	<script>
		jQuery(document).ready(function() {       
		   App.init();
		});
	</script>
	<script type="text/javascript">  
		var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();
	</script>
</body>
</html>