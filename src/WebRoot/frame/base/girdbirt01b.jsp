<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/taglibs.jsp"%>
<html>
<title></title>
<style type="text/css">
.tabcont .datainfo .style_1 .table2{width:100%;}
.tabcont .datainfo .style_1 td{text-align:center;height:22px;line-height:22px;text-align:center;border:1px solid #DADADA;width:5%;}
.tabcont .datainfo .style_1 tr th{border:1px solid #A1A1AF;height:22px;line-height:22px;font-weight:normal;}
.tabcont .datainfo .style_1 tr td a{color:#0000FF;text-decoration:underline;}
.tabcont .datainfo .style_1 tr td a:hover{color:#725e82;text-decoration:none;}
.tabcont .datainfo .style_1 tr th img{margin-right:5px;}
.tabcont .datainfo .style_1 td.txt{font-family:Tahoma;text-align:right;padding-right:4px;}
.tabcont .datainfo .style_1 span{cursor:pointer;}
</style> 
<head>
<link href="${base}/frame/table/pagebar/pagebar.css" rel="stylesheet" type="text/css" />
</head>
<!--
这是一个报表展示模板，附带分页效果。
-->
<body>
	<div style="overflow: auto;height: 300px;">
		<div class="tabcont">
			<div class="chart_cont p10">
				<div class="datacont clearfix">
					<div id='containerGirdbirt01${param.chartname}' class="datainfo clearfix" style="min-width:700px;">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="girdbirt01page" class="paging clearfix" style="border-right-width: 0px;border-bottom-width: 0px;border-left-width: 0px;position:absolute;right:0px;bottom: 0px;padding-bottom: 10px;">
		<div class="yahoo2" id="girdbirt01pagebar${param.chartname}"></div>
	</div>
	
</body>
<script>
//分页page类，用于保存分页数据。
function page(chartname){
	//对应的表格的id后缀
	this.chartname=(chartname==null?'':chartname);
	//对应的当前页
	this.currentPage = 1;
	//对应的最后页
	this.lastPage=1;
	//每页的长度
	this.length=10;
	//查询总条数
	this.count=0;
	//按钮单机事件
	this.buttonfun=function(){};
}
//分页page类的分页展示。
page.prototype.show=function(){
	this.lastPage=Math.ceil(this.count/this.length);
	if(this.lastPage == 0){
		this.lastPage = 1;
	}
	if(this.lastPage!=1){
		var s = '<span class="c_or">当前第'+this.currentPage+'页</span><span>共'+this.lastPage+'页</span>&nbsp;|&nbsp;';
		var functionName = this.buttonfun.name;
		var prevIndex = parseInt(this.currentPage)-1;
		if(prevIndex==0){
			prevIndex = 1;
		}
		var nextIndex = parseInt(this.currentPage)+1;
		if(nextIndex == this.lastPage+1){
			nextIndex = this.lastPage;
		}
		s+='<a href="javascript:void(0)" onclick="'+functionName+'(1)">&lt;&lt;</a><a href="javascript:void(0)" onclick="'+functionName+'('+prevIndex+')">&lt;</a>';
		s+='<a href="javascript:void(0)" onclick="'+functionName+'('+nextIndex+')">&gt;</a><a href="javascript:void(0)" onclick="'+functionName+'('+this.lastPage+')">&gt;&gt;</a>';
		s+='&nbsp;|&nbsp;';
		s+='<span class="paging" style="border:none;"><em><input id="girdbirt01newpage${param.chartname}" type="text" style="margin:0px;height:14px;" value="'+this.currentPage+'"></em><input type="button" onclick="'+functionName+'()" value="" class="b_ent" style="padding-bottom: 3px;"></span>';
		$('#girdbirt01pagebar'+this.chartname).html(s);
	}else{
		$('#girdbirt01pagebar'+this.chartname).html('');
	}
};
//分页page类的获取值方法，从页面的输入框获取值。
page.prototype.getNewPage=function(){
	var nowpage = $('#girdbirt01newpage'+this.chartname).val();
	if(nowpage==undefined||nowpage==''||nowpage<1){
		nowpage=1;
	}
	if(nowpage>this.lastPage){
		nowpage = this.lastPage;
	}
	return nowpage;
};
//girdbirt01模板的参数
function girdbirt01param(content,page){
	//展示的内容
	this.content=content;
	//使用的分页对象
	this.page=page;
	//使用的超链接
	this.showLink;
	//定义单元格的宽度
	this.tdw;
}
//girbirt01模板的展示函数
function showgirdbirt01(param){
	//拼接要展示的报表
	var content = JSON.parse(param.content);
	var birtContent = '<div id="__BIRT_ROOT" class="style_0">';
	birtContent += '<table cellpadding="0" style="empty-cells: show; border-collapse:collapse; width:100%;">';
	birtContent += '<tr><td valign="top"><table class="style_1" style="border-collapse: collapse; empty-cells: show; width: 100%;" id="__bookmark_1"><tbody>';
	birtContent += '<tr valign="top" align="center" class="bg">';
	//给表头添加固定宽度
	if(param.tdw!=null){
		for(var index in content.titles){
			birtContent += '<th style="font-weight: normal;"><div style="width:'+param.tdw[index]+';">'+content.titles[index]+'</div></th>';
		}
	}else{
		for(var index in content.titles){
			birtContent += '<th style="font-weight: normal;"><div>'+content.titles[index]+'</div></th>';
		}
	}
	birtContent += '</tr>';
	//如果字段有跳转链接的话，会根据定义的girdbirt01param的showLink属性生成链接。
	for(var index in content.list){
		var trdata = content.list[index];
		birtContent += '<tr valign="top" align="left">';
		for(var index2 in trdata){
			if(param.showLink!=undefined){
				var alinkstr = '<td><div>'+trdata[index2]+'</div></td>'
				for(var alink in param.showLink){
					if(index2==alink){
						alinkstr = '<td><div><a href="javascript:void(0);" onclick="'+param.showLink[alink].name+'(\'';
						if(param.showLink[alink].arg instanceof Array){
							for(var argi in param.showLink[alink].arg){
								if(argi==0){
									alinkstr +=trdata[param.showLink[alink].arg[argi]];
								}else{
									alinkstr +="\',\'"+trdata[param.showLink[alink].arg[argi]];
								}
							}							
						}else{
							alinkstr +=trdata[param.showLink[alink].arg];
						}
						alinkstr +='\')'+'">'+trdata[index2]+'</a></div></td>';
					}
				}
				birtContent += alinkstr;
			}else{
				birtContent += '<td><div>'+trdata[index2]+'</div></td>';
			}
		}
		birtContent += '</tr>';
	}
	birtContent += '</tbody></table></td></tr>';
	birtContent += '</table>';
	birtContent += '</div>';
	
	$('#containerGirdbirt01'+param.page.chartname).empty();
	$('#containerGirdbirt01'+param.page.chartname).append(birtContent);
	//为奇偶行添加上不同的样式
	$(".style_1").find("tr").each(function(i){
		if(i%2==0){
			this.className="bg";
		}
	});
	param.page.show();
}
</script>

</html>