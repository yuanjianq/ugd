package com.gfan.report.frame.service;

import java.util.Map;
/**
 * @author wangli
 * 项目：联运游戏数据统�?
 * 详细介绍：是birt引擎解释birt设计的处理器，并返回泛型指定的结果�?
 * 2014-6-11 下午5:45:11
 */
public interface EngineDesignHandler<T> {

	/**
	 * 处理birt的设计并返回结果
	 * @param design birt设计的名�?
	 * @param params birt设计的参�?
	 * @return 返回的可能是字符串�?字符串数据�?流�?
	 */
	T runAndRender(String design, Map<String, String> params);
	
}
