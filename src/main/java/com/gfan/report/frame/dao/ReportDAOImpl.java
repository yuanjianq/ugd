package com.gfan.report.frame.dao;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;


public class ReportDAOImpl implements ReportDAO{

	private NamedParameterJdbcTemplate jdbcTemplate;

	public List<List<String>> getBirtPage(String sql, Map<String, ?> paramMap,final String[][] resultMap) {
		final List<List<String>> result = new ArrayList<List<String>>();
		jdbcTemplate.query(sql, paramMap, new RowCallbackHandler() {
			@Override
			public void processRow(ResultSet rs) throws SQLException {
				List<String> row = new ArrayList<String>();
				for (String[] ss : resultMap) {
					if (ss[1].equals("String")) {
						row.add(rs.getString(ss[0]));
					} else if (ss[1].equals("Integer")) {
						row.add(Integer.toString(rs.getInt(ss[0])));
					} else if (ss[1].equals("Double")) {
						double fieldValue = rs.getDouble(ss[0]);
						int fieldInt = (int) fieldValue;
						if(fieldInt==fieldValue){
							row.add(Integer.toString(fieldInt));
						}else{
							row.add(Double.toString(new BigDecimal(Double.toString(fieldValue)).multiply(new BigDecimal(100)).intValue()/100.0));
						}
					}
				}
				result.add(row);
			}
		});
		return result;
	}
	
	public Integer getBirtCount(String sql, Map<String, ?> paramMap) {
		final List<Integer> result = new ArrayList<Integer>();
		jdbcTemplate.query(sql, paramMap, new RowCallbackHandler() {
			@Override
			public void processRow(ResultSet rs) throws SQLException {
				result.add(rs.getInt("COUNT"));
			}
		});
		return result.get(0);
	}
	
	public List<List<String>> getLineChart(String sql, Map<String, ?> paramMap,final String[][] resultMap) {
		final List<List<String>> result = new ArrayList<List<String>>();
		for(int i=0;i<resultMap.length;i++){
				
			result.add(new ArrayList<String>());
		}
				
		jdbcTemplate.query(sql, paramMap, new RowCallbackHandler() {
			@Override
			public void processRow(ResultSet rs) throws SQLException {
				for(int i=0;i<resultMap.length;i++){
					List<String> list = result.get(i);
					if (resultMap[i][1].equals("String")) {
						list.add(rs.getString(resultMap[i][0]));
					} else if (resultMap[i][1].equals("Integer")) {
						list.add(Integer.toString(rs.getInt(resultMap[i][0])));
					} else if (resultMap[i][1].equals("Double")) {
						list.add(Double.toString(rs.getDouble(resultMap[i][0])));
					}
				}
			}
		});
		
		
		return result;
	}
	
	public List<Map<String,Object>> getPieChart(String sql, Map<String, ?> paramMap,final String[][] resultMap) {
		final List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		jdbcTemplate.query(sql, paramMap, new RowCallbackHandler() {
			@Override
			public void processRow(ResultSet rs) throws SQLException {
				Map<String,Object> map = new LinkedHashMap<String,Object>();
				for(int i=0;i<resultMap.length;i++){
					if (resultMap[i][1].equals("String")) {
						map.put(resultMap[i][0],rs.getString(resultMap[i][0]));
					} else if (resultMap[i][1].equals("Integer")) {
						map.put(resultMap[i][0],Integer.toString(rs.getInt(resultMap[i][0])));
					} else if (resultMap[i][1].equals("Double")) {
						map.put(resultMap[i][0],Double.toString(rs.getDouble(resultMap[i][0])));
					}
				}
				result.add(map);
			}
		});
		return result;
	}

	public NamedParameterJdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(NamedParameterJdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public String getBirtInsert(String sql, Map<String, ?> paramMap) {
		jdbcTemplate.update(sql, paramMap);
		return "1";
	}

}
