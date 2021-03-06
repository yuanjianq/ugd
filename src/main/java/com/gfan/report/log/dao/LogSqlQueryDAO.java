package com.gfan.report.log.dao;

import com.gfan.report.log.module.LogSqlQuery;
import com.gfan.report.log.module.LogSqlQueryExample;
import java.util.List;

public interface LogSqlQueryDAO {

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table LOG_SQL_QUERY
	 * @ibatorgenerated  Mon Dec 08 17:42:40 CST 2014
	 */
	int countByExample(LogSqlQueryExample example);

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table LOG_SQL_QUERY
	 * @ibatorgenerated  Mon Dec 08 17:42:40 CST 2014
	 */
	int deleteByExample(LogSqlQueryExample example);

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table LOG_SQL_QUERY
	 * @ibatorgenerated  Mon Dec 08 17:42:40 CST 2014
	 */
	int deleteByPrimaryKey(Integer id);

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table LOG_SQL_QUERY
	 * @ibatorgenerated  Mon Dec 08 17:42:40 CST 2014
	 */
	void insert(LogSqlQuery record);

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table LOG_SQL_QUERY
	 * @ibatorgenerated  Mon Dec 08 17:42:40 CST 2014
	 */
	void insertSelective(LogSqlQuery record);

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table LOG_SQL_QUERY
	 * @ibatorgenerated  Mon Dec 08 17:42:40 CST 2014
	 */
	List selectByExample(LogSqlQueryExample example);

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table LOG_SQL_QUERY
	 * @ibatorgenerated  Mon Dec 08 17:42:40 CST 2014
	 */
	LogSqlQuery selectByPrimaryKey(Integer id);

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table LOG_SQL_QUERY
	 * @ibatorgenerated  Mon Dec 08 17:42:40 CST 2014
	 */
	int updateByExampleSelective(LogSqlQuery record, LogSqlQueryExample example);

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table LOG_SQL_QUERY
	 * @ibatorgenerated  Mon Dec 08 17:42:40 CST 2014
	 */
	int updateByExample(LogSqlQuery record, LogSqlQueryExample example);

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table LOG_SQL_QUERY
	 * @ibatorgenerated  Mon Dec 08 17:42:40 CST 2014
	 */
	int updateByPrimaryKeySelective(LogSqlQuery record);

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table LOG_SQL_QUERY
	 * @ibatorgenerated  Mon Dec 08 17:42:40 CST 2014
	 */
	int updateByPrimaryKey(LogSqlQuery record);
}