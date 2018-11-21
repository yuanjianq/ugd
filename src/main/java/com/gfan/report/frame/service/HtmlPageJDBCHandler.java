package com.gfan.report.frame.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gfan.report.frame.dao.ReportDAO;
import com.gfan.report.frame.module.RepQuery;

@Service("htmlPageJDBCHandler")
public class HtmlPageJDBCHandler extends HtmlJDBCHandler<String[]>{

	@Resource
	private ReportDAOServcer reportDAOServcer;
	
	@Override
	public String[] runAndRender(String design, Map<String,String> params){
		RepQuery repQuery = getRepQuery(design);
		ReportDAO reportDAO = reportDAOServcer.getDAOById(repQuery.getReportDb());
		String reportSql = getReportSql(repQuery.getReportSql(),repQuery.getReplaceField(), params);
		String countSql = getReportSql(repQuery.getCountSql(),repQuery.getReplaceField(), params);
		List<List<String>> list = reportDAO.getBirtPage(reportSql, getParamMap(repQuery.getQueryField(), params), getResultMap(repQuery));
		Integer count = reportDAO.getBirtCount(countSql, getParamMap(repQuery.getCountField(), params));
		String content = getHtmlString(list, repQuery.getReportTitle());
		return new String[]{content,Integer.toString(count)};
	}

}
