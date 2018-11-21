<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String base = pageContext.getRequest().getScheme()+"://"+pageContext.getRequest().getServerName()
	+":"+pageContext.getRequest().getServerPort()+request.getContextPath();
request.setAttribute("base", base);
%>
