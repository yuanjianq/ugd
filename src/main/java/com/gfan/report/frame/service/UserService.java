package com.gfan.report.frame.service;

import java.util.List;

import com.gfan.report.frame.module.CorpPartnerUser;
import com.gfan.report.frame.module.RepDict;
import com.gfan.report.frame.module.UiFwFunctionWidget;
import com.gfan.report.frame.module.UiFwModule;
import com.gfan.report.frame.module.User;

public interface UserService {
	
	User getUser(String loginId);
	
	boolean validateUser(int userId, String password);
	public CorpPartnerUser getPartnerUser(int id);
	
	List<UiFwModule> getUserModule(Integer userId);
	
	UiFwFunctionWidget getWidget(Integer functionId);
	
	List<RepDict> getDicts(String dictName);
	
	String getPeriods(String dataTime);
	
	void logLoginInfo(User user, String ip);
	
	void logFunctionInfo(User user, UiFwFunctionWidget widget, String ip);
	
	void logQueryInfo(User user, String reportname, String ip, String type);
}
