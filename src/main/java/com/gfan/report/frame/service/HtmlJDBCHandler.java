package com.gfan.report.frame.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

public abstract class HtmlJDBCHandler<T> extends JDBCEngineDesignHandler<T>{

	/**
	 * 格式化成要返回的gson格式的字符串
	 * @param list
	 * @param reportTitle
	 * @return
	 */
	protected String getHtmlString(List<List<String>> list,String  reportTitle){
		String[] titles = reportTitle.split(",");
		Gson gson = new Gson();
		Map<String,Object> map = new LinkedHashMap<String,Object>();
		map.put("titles", titles);
		map.put("list", list);
		return gson.toJson(map);
	}

}
