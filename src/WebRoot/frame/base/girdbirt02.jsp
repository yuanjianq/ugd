<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<title></title>
<style type="text/css">
.bg {background: #F6F7F7;}
.tabcont .datainfo .style_1 .table2{width:100%;}
.tabcont .datainfo .style_1 td{text-align:center;height:22px;line-height:22px;text-align:center;border:1px solid #DADADA;width:5%;}
.tabcont .datainfo .style_1 tr th{border:1px solid #A1A1AF;height:22px;line-height:22px;font-weight:normal;}
.tabcont .datainfo .style_1 tr td a{color:#0000FF;text-decoration:underline;}
.tabcont .datainfo .style_1 tr td a:hover{color:#725e82;text-decoration:none;}
.tabcont .datainfo .style_1 tr th img{margin-right:5px;}
.tabcont .datainfo .style_1 td.txt{font-family:Tahoma;text-align:right;padding-right:4px;}
.tabcont .datainfo .style_1 span{cursor:pointer;}
.style_0 { font-family: serif; font-style: normal; font-variant: normal; font-weight: normal; font-size: 10pt; color: black; text-indent: 0em; letter-spacing: normal; word-spacing: normal; text-transform: none; white-space: normal; line-height: normal;}
</style> 
<head>
</head>
<!--
这是一个报表展示模板
-->
<body>
	<div class="tabcont">
		<div class="chart_cont p10">
			<div class="datacont clearfix">
				<div id='containerGirdbirt02${param.chartname}' class="datainfo clearfix" style="min-width:700px;">
				</div>
			</div>
		</div>
	</div>
</body>
<script>
//girdbirt02模板的参数
function girdbirt02param(content){
	this.content=content;
	this.showSort='';
	this.showLink;
}
//girbirt02模板的展示函数
function showgirdbirt02(param,chartname){
	var containerGirdbirt02 = $('#containerGirdbirt02');
	if(chartname!=null){
		containerGirdbirt02 = $('#containerGirdbirt02'+chartname);
	}
	//拼接要展示的报表
	var content = JSON.parse(param.content);
	var birtContent = '<div id="__BIRT_ROOT" class="style_0">';
	birtContent += '<table cellpadding="0" style="empty-cells: show; border-collapse:collapse; width:100%;">';
	birtContent += '<tr><td valign="top"><table class="style_1" style="border-collapse: collapse; empty-cells: show; width: 100%;" id="__bookmark_1"><tbody>';
	birtContent += '<tr valign="top" align="center" class="bg">';
	if(param.showSort!=''){
		birtContent += '<th style="font-weight: normal;"><div>'+param.showSort+'</div></th>';
	}
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
	for(var index in content.list){
		var trdata = content.list[index];
		birtContent += '<tr valign="top" align="left">';
		if(param.showSort!=''){
			birtContent += '<td><div>'+(parseInt(index)+1)+'</div></td>';
		}
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
	
	containerGirdbirt02.empty();
	containerGirdbirt02.append(birtContent);
	$(".style_1").find("tr").each(function(i){
		if(i%2==0){
			this.className="bg";
		}
	});
}
</script>
</html>