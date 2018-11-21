package com.gfan.report.frame.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gfan.report.frame.dao.ReportDAO;
import com.gfan.report.frame.module.RepQuery;
import com.google.gson.Gson;

@Service("chartPieJDBCHandler")
public class ChartPieJDBCHandler extends JDBCEngineDesignHandler<String>{

	@Resource
	private ReportDAOServcer reportDAOServcer;
	
	@Override
	public String runAndRender(String design, Map<String, String> params) {
		RepQuery repQuery = getRepQuery(design);
		ReportDAO reportDAO = reportDAOServcer.getDAOById(repQuery.getReportDb());
		String reportSql = getReportSql(repQuery.getReportSql(),repQuery.getReplaceField(), params);
		List<Map<String,Object>> list = reportDAO.getPieChart(reportSql, getParamMap(repQuery.getQueryField(), params), getResultMap(repQuery));
		Gson gson = new Gson();
		return gson.toJson(list);
	}

}
