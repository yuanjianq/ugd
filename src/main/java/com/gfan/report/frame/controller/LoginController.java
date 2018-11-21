package com.gfan.report.frame.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gfan.report.frame.module.CorpPartnerUser;
import com.gfan.report.frame.module.UiFwModule;
import com.gfan.report.frame.module.User;
import com.gfan.report.frame.service.UserService;

@Controller
@RequestMapping(value="/login")
public class LoginController {
	
	@Resource
	private UserService userService;
	/** 登录页面 */
	@RequestMapping()
	public String login(){
		return "login";
	}
	/** 登入 */
	@RequestMapping(value="/enter")
	public String enter(HttpSession session,HttpServletRequest request,String userName,String password){
		if(session.getAttribute("userInfo")!=null&&session.getAttribute("userModules")!=null){
			return "frame/index";
		}
		//selectByPrimaryKey
		User user = userService.getUser(userName);
		
		if(user==null){
			request.setAttribute("msg", "用户不存在");
			return "login";
		}
		CorpPartnerUser partnerUser=userService.getPartnerUser(user.getId());
		
		if(partnerUser!=null&&partnerUser.getStatus()==2){
			request.setAttribute("msg", "该用户已被禁用");
			return "login";
		}
		boolean valiflat = userService.validateUser(user.getId(), password);
		if(!valiflat){
			request.setAttribute("msg", "用户名密码不正确");
			return "login";
		}
		List<UiFwModule> modules = userService.getUserModule(user.getId());
		if(modules==null){
			request.setAttribute("msg", "用户没有任何菜单");
			return "login";
		}
		session.setAttribute("userInfo", user);
		session.setAttribute("userModules", modules);
		userService.logLoginInfo(user, request.getRemoteAddr());
		return "frame/index";
	}
	/** 登出 */
	@RequestMapping(value="/out")
	public String out(HttpSession session){
		session.removeAttribute("userInfo");
		session.removeAttribute("userModules");
		session.invalidate();
		return "login";
	}
}
