package com.gfan.report.frame.service;

import java.util.HashMap;
import java.util.Map;

import com.gfan.report.frame.dao.ReportDAO;

public class ReportDAOServcer {

	private Map<String,ReportDAO> reportDaos = new HashMap<String,ReportDAO>();
	
	public ReportDAO getDAOById(String id){
		if(id==null||id.equals("")){
			return reportDaos.get("default");
		}
		return reportDaos.get(id);
	}

	public Map<String, ReportDAO> getReportDaos() {
		return reportDaos;
	}

	public void setReportDaos(Map<String, ReportDAO> reportDaos) {
		this.reportDaos = reportDaos;
	}
	
}
