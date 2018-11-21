<%@ page language="java" pageEncoding="UTF-8"%>
<div class="page-sidebar nav-collapse collapse">
	<!-- BEGIN SIDEBAR MENU -->        
	<ul class="page-sidebar-menu" id="ui-tree">&nbsp;
		<c:forEach items="${sessionScope.userModules}" var="module">
			<li class='<c:if test="${module.id==mid}">active</c:if>' id="${module.id}_m_dl">
				<a href="javascript:;">
				<i class="icon-bar-chart"></i>
				<c:if test="${module.id==mid}"><span class="selected"></span></c:if>
				<span class="title">${module.name}</span>
				<span class='arrow <c:if test="${module.id==mid}">open</c:if>'></span>
				</a>
				<ul class="sub-menu">
					<c:forEach items="${module.functions}" var="function">
						<li id="${function.id}_f_li" url="${function.actionUrl}" class='<c:if test="${function.id==fid}">active</c:if>'>
							<form id="${function.id}_lk_fm" action="${base}/frame/index.gfan" method="POST" style="display: none;">
								<input type="hidden" name="fid" id="fid" value="${function.id}">
								<input type="hidden" name="mid" value="${module.id}">
								<input name="urlParam" type="hidden" > 
							</form>
							<a href="javascript:void(0)">${function.name}</a>
						</li>
					</c:forEach>
				</ul>
			</li>
		</c:forEach>
	</ul>
	<!-- END SIDEBAR MENU -->
</div>
<script language="JavaScript">
$("#ui-tree").children().find("li").bind("click",function(){
	var linkForm = $(this).find("form");
	linkForm.submit();
});
</script>
