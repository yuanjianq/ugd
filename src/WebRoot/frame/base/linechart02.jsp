<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/taglibs.jsp"%>
<%-- <%@include file="/commons/jquerylibs.jsp"%> --%>

<html>
<title></title>
<head>
<%-- <script type="text/javascript" src="${base}/report/js/highcharts/highcharts.js"></script> --%>
<script type="text/javascript" src="${base}/frame/table/echarts/echarts-plain.js"></script>
<%-- <script src="${base}/dwr/engine.js"></script> --%>
<%-- <script src="${base}/dwr/util.js"></script> --%>
<%-- <script src="${base}/dwr/interface/RptManager.js"></script> --%>
</head>
<!-- 
这是一个折线图的展示模板
-->
<body>
    <div class="navbar navbar-default navbar-fixed-top" role="navigation" id="head"></div>
	<div class="datacont mt10" style="border:1px solid #ccc;">
		<div id="containerLinechart02${param.chartname}" style="min-width:700px;height:300px"></div>
	</div>
</body>
<script>
//linechart02模板的参数
function linechart02param(xline,yline,title,legendname){
	//x轴数据
	this.xline=xline;
	//y轴数据
	this.yline=yline;
	//图表的标题
	this.title=title;
	//图表的图例
	this.legendname=legendname;
}
//linechart02模板的展示函数
function showlinechart02(param,chartname){
	
	var ss = {};
	for(var i=0; i<param.legendname.length;i++){
		ss[param.legendname[i]]=false;
	};
		
	var containerLinechart02 = document.getElementById('containerLinechart02');
	if(chartname!=null){
		containerLinechart02 = document.getElementById('containerLinechart02'+chartname);
	}
	var myChart = echarts.init(containerLinechart02); 
	option = {
	    title : {
	        text: param.title,
	        x:'center',
	        y:20
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        orient: 'horizontal',
	        x: 'center',
	        y: '275',
	        padding: 10, 
	        itemGap: 10,
	        data:param.legendname,
	        selected:ss
	    },
	    toolbox: {
	        show : true,
	        feature : {
	            mark : {show: true},
	            dataView : {show: true, readOnly: false},
	            magicType : {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,	    
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : false,
	            data : param.xline
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            axisLabel : {
	                formatter: '{value}'
	            },
	            splitArea : {show : true}
	        }
	    ],
	    series : param.yline
	};
	


	
	myChart.setOption(option);
}
</script>
</html>