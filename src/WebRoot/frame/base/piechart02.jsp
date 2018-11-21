<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%-- <%@include file="/commons/taglibs.jsp"%> --%>
<%-- <%@include file="/commons/jquerylibs.jsp"%> --%>

<html>
<title></title>
<head>
<%-- <script type="text/javascript" src="${base}/report/js/highcharts/highcharts.js"></script> --%>
<%-- <script type="text/javascript" src="${base}/report/js/echarts/echarts-plain.js"></script> --%>
<%-- <script src="${base}/dwr/engine.js"></script> --%>
<%-- <script src="${base}/dwr/util.js"></script> --%>
<%-- <script src="${base}/dwr/interface/RptManager.js"></script> --%>
</head>
<!--
这是一个饼图展示模板
-->
<body>
	<div class="datacont mt10" style="border:1px solid #ccc;">
		<div>
			<div id="containerPiechart02${param.chartname}" style="min-width:500px;height:300px;border-left:200"></div>
		</div>
	</div>
</body>
<script>
//piechart02模板的参数
function piechart02param(yline,title,dname,legendname){
	//y轴数据
	this.yline=yline;
	//图表的图例
	this.legendname=legendname;
	//图表的标题
	this.title=title;
	//数据名称
	this.dname=dname;
}
//piechart02模板的展示函数
function showpiechart02(param,chartname){
	var containerPiechart02 = document.getElementById('containerPiechart02');
	if(chartname!=null){
		containerPiechart02 = document.getElementById('containerPiechart02'+chartname);
	}
	var myChart = echarts.init(containerPiechart02); 
	option = {
		    title : {
		        text: param.title,
		        x:700
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient : 'vertical',
		        x : '800',
		        y : 'center',
		        borderColor: '#C4C4C4',
		        borderWidth: 1,
		        data:param.legendname
		    },
		    series : [
		        {
		            name:param.dname,
		            type:'pie',
		            data:param.yline
		        }
		    ]
		};
	myChart.setOption(option);
}
</script>
</html>