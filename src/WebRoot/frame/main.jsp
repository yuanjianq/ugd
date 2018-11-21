<%@ page language="java" pageEncoding="UTF-8"%>
<div class="page-content">
	<div class="container-fluid">
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="span12" id="vf_nav">
			</div>
		</div>
		<div class="row-fluid">
			<div class="span12" id="vf_content">
			</div>
		</div>
	</div>
</div>
<script language="JavaScript">
$(document).ready(function() {
	var mid = "${mid}";
	var fid = "${fid}";
	var fNode,mNode;
	if (!$.trim(mid) || !$.trim(fid) || mid == "null" || fid == "null") {
		var mtree = $("#ui-tree").children()[0];
		mid = parseInt($(mtree).attr("id"));
		var ftree = $(mtree).find("li")[0];
		$(ftree).find("form").submit();
	}else{
		fNode = $("#" + fid + "_f_li");
		mNode = $("#" + mid + "_m_dl");
		var navContent = "<ul class='breadcrumb'>";
		navContent += '<li><i class="icon-home"></i><a href="index.gfan">首页</a><i class="icon-angle-right"></i></li>';
		navContent += '<li><a href="#">'+mNode.find("span.title").text()+'</a><i class="icon-angle-right"></i></li>';
		navContent += '<li><a href="#">'+fNode.find("a").text()+'</a></li>';
		navContent += "</ul>";
		$("#vf_nav").empty();
		$("#vf_nav").append(navContent);
		
		$("#vf_content").append("数据加载中!");
		var loadURL = fNode.attr("url");
		var urlParam = "${urlParam}";
		jQuery.ajax({
			type : "GET",
			url : "${base}" + loadURL ,
			dataType : 'text',
			data : {
				"fid" : fid,
				"mid" : mid,
				"urlParam" : urlParam
			},
			success : function(response) {
				$("#vf_content").empty();
				$("#vf_content").append(response);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				var content = "";
				if (XMLHttpRequest.status == "404") {
					content = "<div>地址错误!</div>";
				} else if (XMLHttpRequest.status == "500") {
					content = "<div>服务器错误!</div>";
				} else {
					content = textStatus + ":" + errorThrown
				}
				$("#vf_content").empty();
				$("#vf_content").append(content);
			}
		});
	}
	
});
</script>