package com.gfan.report.frame.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gfan.report.frame.dao.ReportDAO;
import com.gfan.report.frame.module.RepQuery;

@Service("htmlNoPageJDBCHandler")
public class HtmlNoPageJDBCHandler extends HtmlJDBCHandler<String>{

	@Resource
	private ReportDAOServcer reportDAOServcer;
	
	@Override
	public String runAndRender(String design, Map<String,String> params) {
		RepQuery repQuery = getRepQuery(design);
		ReportDAO reportDAO = reportDAOServcer.getDAOById(repQuery.getReportDb());
		String reportSql = getReportSql(repQuery.getReportSql(),repQuery.getReplaceField(), params);
		List<List<String>> list = reportDAO.getBirtPage(reportSql, getParamMap(repQuery.getQueryField(), params), getResultMap(repQuery));
		return getHtmlString(list, repQuery.getReportTitle());
	}

}
