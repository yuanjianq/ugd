package com.gfan.report.frame.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class SessionIntercepter implements HandlerInterceptor {

	private static String loginUrl = "/login.gfan";
	private static String loginEnterUrl = "/login/enter.gfan";
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
	    if(request.getServletPath().startsWith(loginUrl)) {  
	        return true;  
	    }  
	    if(request.getServletPath().startsWith(loginEnterUrl)) {  
	        return true;  
	    }
	    if(request.getSession().getAttribute("userInfo") != null) {  
	        return true;  
	    }  
	    response.sendRedirect(request.getContextPath() + loginUrl);  
	    return false;  
	}

}
