package com.gfan.report.frame.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gfan.report.frame.module.UiFwFunction;
import com.gfan.report.frame.module.UiFwFunctionWidget;
import com.gfan.report.frame.module.UiFwModule;
import com.gfan.report.frame.module.User;
import com.gfan.report.frame.service.UserService;
@Controller
@RequestMapping("/frame")
public class IndexController {

	@Resource
	private UserService userService;
	
	/** 功能跳转 */
	@RequestMapping(value="/index")
	public String index(Integer fid,Integer mid,String urlParam,HttpServletRequest request) {
		request.setAttribute("fid", fid);
		request.setAttribute("mid", mid);
		request.setAttribute("urlParam", urlParam);
		return "frame/index";
	}
	
	/** 跳转到页面 */
	@RequestMapping(value="/main")
	public String main(Integer fid,String urlParam,HttpServletRequest request,HttpSession session) {
		if(!checkAuth(session,fid)){
			return "frame/noauth";
		}
		UiFwFunctionWidget widget = userService.getWidget(fid);
		String[] params = urlParam.split("&");
		for(String param:params){
			if(!param.equals("")){
				request.setAttribute(param.split("=")[0], param.split("=")[1]);
			}
		}
		userService.logFunctionInfo((User) session.getAttribute("userInfo"), widget, request.getRemoteAddr());
		return widget.getActionUrl();
	}

	private boolean checkAuth(HttpSession session, Integer fid) {
		User user = (User) session.getAttribute("userInfo");
		List<UiFwModule> modules = userService.getUserModule(user.getId());
		for(UiFwModule module :modules){
			for(UiFwFunction function:module.getFunctions()){
				if(function.getId().equals(fid)){
					return true;
				}
			}
		}
		return false;
	}
}
