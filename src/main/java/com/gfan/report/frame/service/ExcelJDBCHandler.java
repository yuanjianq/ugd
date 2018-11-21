package com.gfan.report.frame.service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import com.gfan.report.frame.dao.ReportDAO;
import com.gfan.report.frame.module.RepQuery;

@Service("excelJDBCHandler")
public class ExcelJDBCHandler extends HtmlJDBCHandler<ByteArrayOutputStream>{

	@Resource
	private ReportDAOServcer reportDAOServcer;
	
	@Override
	public ByteArrayOutputStream runAndRender(String design, Map<String,String> params) {
		RepQuery repQuery = getRepQuery(design);
		ReportDAO reportDAO = reportDAOServcer.getDAOById(repQuery.getReportDb());
		String reportSql = getReportSql(repQuery.getReportSql(),repQuery.getReplaceField(), params);
		List<List<String>> list = reportDAO.getBirtPage(reportSql, getParamMap(repQuery.getQueryField(), params), getResultMap(repQuery));
		ByteArrayOutputStream out = new ByteArrayOutputStream(1024*20);
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("sheet1");
		Row row = sheet.createRow((short)0);
		String[] titles =repQuery.getReportTitle().split(",");
		for(int i=0;i< titles.length;i++){
			Cell cell = row.createCell(i);
			cell.setCellValue(titles[i]);
		}
		for(int i=0;i<list.size();i++){
			row = sheet.createRow((short)i+1);
			for(int j=0;j<list.get(i).size();j++){
				Cell cell = row.createCell(j);
				cell.setCellValue(list.get(i).get(j));
			}
		}
		try {
			wb.write(out);
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return out;
	}

}
