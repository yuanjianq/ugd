package com.gfan.report.frame.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.stereotype.Service;

import com.gfan.report.frame.dao.CorpPartnerUserDAO;
import com.gfan.report.frame.dao.PMemberRoleDAO;
import com.gfan.report.frame.dao.RepDictDAO;
import com.gfan.report.frame.dao.UiFwFunctionDAO;
import com.gfan.report.frame.dao.UiFwFunctionWidgetDAO;
import com.gfan.report.frame.dao.UiFwModuleDAO;
import com.gfan.report.frame.dao.UiFwRoleFunctionLinkDAO;
import com.gfan.report.frame.dao.UiFwRoleModuleLinkDAO;
import com.gfan.report.frame.dao.UserDAO;
import com.gfan.report.frame.dao.UserPwdDAO;
import com.gfan.report.frame.module.CorpPartnerUser;
import com.gfan.report.frame.module.PMemberRole;
import com.gfan.report.frame.module.PMemberRoleExample;
import com.gfan.report.frame.module.RepDict;
import com.gfan.report.frame.module.RepDictExample;
import com.gfan.report.frame.module.UiFwFunction;
import com.gfan.report.frame.module.UiFwFunctionExample;
import com.gfan.report.frame.module.UiFwFunctionWidget;
import com.gfan.report.frame.module.UiFwFunctionWidgetExample;
import com.gfan.report.frame.module.UiFwModule;
import com.gfan.report.frame.module.UiFwModuleExample;
import com.gfan.report.frame.module.UiFwRoleFunctionLinkExample;
import com.gfan.report.frame.module.UiFwRoleFunctionLinkKey;
import com.gfan.report.frame.module.UiFwRoleModuleLinkExample;
import com.gfan.report.frame.module.UiFwRoleModuleLinkKey;
import com.gfan.report.frame.module.User;
import com.gfan.report.frame.module.UserExample;
import com.gfan.report.frame.module.UserPwd;
import com.gfan.report.frame.module.UserPwdExample;
import com.gfan.report.log.dao.LogFunctionClickDAO;
import com.gfan.report.log.dao.LogSqlQueryDAO;
import com.gfan.report.log.dao.LogUserLoginDAO;
import com.gfan.report.log.module.LogFunctionClick;
import com.gfan.report.log.module.LogSqlQuery;
import com.gfan.report.log.module.LogUserLogin;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Resource
	private UiFwModuleDAO uiFwModuleDAO;
	
	@Resource
	private UiFwFunctionDAO uiFwFunctionDAO;
	
	@Resource
	private UiFwFunctionWidgetDAO uiFwFunctionWidgetDAO;
	
	@Resource
	private UiFwRoleModuleLinkDAO roleModuleDAO;
	
	@Resource
	private UiFwRoleFunctionLinkDAO roleFunctionDAO;
	
	@Resource
	private LogUserLoginDAO logUserLoginDAO;
	
	@Resource
	private LogFunctionClickDAO logFunctionClickDAO;
	
	@Resource
	private LogSqlQueryDAO logSqlQueryDAO;
	
	@Resource
	private RepDictDAO repDictDAO;
	
	@Resource
	private UserPwdDAO userPwdDAO;
	
	@Resource
	private UserDAO loginUserDAO;
	
	@Resource
	private CorpPartnerUserDAO partnerUserDAO;
	
	@Resource
	private PMemberRoleDAO userRoleDAO;
	
	@Override
	public User getUser(String loginId) {
		UserExample example = new UserExample();
		example.createCriteria().andUserNameEqualTo(loginId);
		List<User> list = loginUserDAO.selectByExample(example);
		if(list.size()!=1){
			return null;
		}
		return list.get(0);
	}
	
	@Override
	public CorpPartnerUser getPartnerUser(int id) {
		//UserExample example = new UserExample();
		//example.createCriteria().andUserNameEqualTo(id
		return partnerUserDAO.selectByPrimaryKey(id);
	}
	
	

	@Override
	public List<UiFwModule> getUserModule(Integer userId) {
		List<UiFwModule> modules = new ArrayList<UiFwModule>();
		List<UiFwFunction> functions = new ArrayList<UiFwFunction>();
		PMemberRoleExample example = new PMemberRoleExample();
		example.createCriteria().andUserIdEqualTo(userId);
		List<PMemberRole> roles = userRoleDAO.selectByExample(example);
		for(PMemberRole role:roles){
			UiFwRoleModuleLinkExample moduleExample = new UiFwRoleModuleLinkExample();
			moduleExample.createCriteria().andRoleIdEqualTo(role.getRoleId());
			List<UiFwRoleModuleLinkKey> modulelist = roleModuleDAO.selectByExample(moduleExample);
			for(UiFwRoleModuleLinkKey moduleLink : modulelist){
				UiFwModule module = uiFwModuleDAO.selectByPrimaryKey(moduleLink.getModuleId());
				boolean moduleflag = true;
				for(int i = 0;i<modules.size();i++){
					if(modules.get(i).getId()==module.getId()){
						moduleflag = false;
					}
				}
				if(moduleflag){
					modules.add(module);
				}
			}
			UiFwRoleFunctionLinkExample functionExample = new UiFwRoleFunctionLinkExample();
			functionExample.createCriteria().andRoleIdEqualTo(role.getRoleId());
			List<UiFwRoleFunctionLinkKey> functionlist = roleFunctionDAO.selectByExample(functionExample);
			for(UiFwRoleFunctionLinkKey functionLink : functionlist){
				UiFwFunction finction = uiFwFunctionDAO.selectByPrimaryKey(functionLink.getFunctionId());
				boolean functionflag = true;
				for(int i = 0;i<functions.size();i++){
					if(functions.get(i).getId()==finction.getId()){
						functionflag = false;
					}
				}
				if(functionflag){
					functions.add(finction);
				}
			}
		}
		if(modules.size()==0||functions.size()==0){
			return null;
		}
		Collections.sort(functions, new FunctionComparator());
		Collections.sort(modules, new ModuleComparator());
		for(UiFwFunction function : functions){
			for(UiFwModule module : modules){
				if(function.getModuleId().equals(module.getId())){
					List<UiFwFunction> list = module.getFunctions();
					if(list==null){
						list = new ArrayList<UiFwFunction>();
						module.setFunctions(list);
					}
					list.add(function);
				}
			}
		}
		return modules;
	}

	@Override
	public UiFwFunctionWidget getWidget(Integer functionId) {
		UiFwFunctionWidgetExample example = new UiFwFunctionWidgetExample();
		example.createCriteria().andFunctionIdEqualTo(functionId);
		List<UiFwFunctionWidget> list = uiFwFunctionWidgetDAO.selectByExample(example);
		return list.get(0);
	}

	@Override
	public List<RepDict> getDicts(String dictName) {
		RepDictExample example = new RepDictExample();
		example.createCriteria().andDictTypeEqualTo(dictName);
		example.setOrderByClause("DICT_ORDER");
		return repDictDAO.selectByExample(example);
	}

	@Override
	public String getPeriods(String dataTime) {
		return null;
	}

	@Override
	public void logLoginInfo(User user, String ip) {
		LogUserLogin log = new LogUserLogin();
		log.setUserId(user.getUserName());
		log.setUserName(user.getDisplayName());
		log.setLogTime(new Date());
		log.setUserIp(ip);
		log.setInsertTime(new Date());
		logUserLoginDAO.insert(log);
	}

	@Override
	public void logFunctionInfo(User user, UiFwFunctionWidget widget,String ip) {
		LogFunctionClick log = new LogFunctionClick();
		log.setUserId(user.getUserName());
		log.setUserName(user.getDisplayName());
		log.setLogTime(new Date());
		log.setUserIp(ip);
		log.setInsertTime(new Date());
		log.setFunctionId(widget.getId());
		log.setFunctionName(widget.getName());
		logFunctionClickDAO.insert(log);
	}

	@Override
	public void logQueryInfo(User user, String reportname, String ip,String type) {
		LogSqlQuery log = new LogSqlQuery();
		log.setUserId(user.getUserName());
		log.setUserName(user.getDisplayName());
		log.setLogTime(new Date());
		log.setUserIp(ip);
		log.setInsertTime(new Date());
		log.setReportId(reportname);
		log.setQueryType(type);
		logSqlQueryDAO.insert(log);
	}

	@Override
	public boolean validateUser(int userId, String password) {
		UserPwdExample example = new UserPwdExample();
		example.createCriteria().andUserIdEqualTo(userId);
		List<UserPwd> list =  userPwdDAO.selectByExample(example);
		if(list.size()!=1){
			return false;
		}
		UserPwd pwd = list.get(0);
	    String md5Hex = DigestUtils.md5Hex(password+pwd.getPwdSalt());
		if(pwd.getPwdHash().endsWith(md5Hex)){
			return true;
		}
		return false;
	}
	
	public static class ModuleComparator implements Comparator<UiFwModule> {

		@Override
		public int compare(UiFwModule o1, UiFwModule o2) {
			return o1.getSort()-o2.getSort();
		}
		
	}
	
	public static class FunctionComparator implements Comparator<UiFwFunction> {

		@Override
		public int compare(UiFwFunction o1, UiFwFunction o2) {
			return o1.getSort()-o2.getSort();
		}
		
	}

}
