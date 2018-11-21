package com.gfan.report.frame.tag;

import java.io.IOException;
import java.util.List;

import org.springframework.web.servlet.tags.RequestContextAwareTag;

import com.gfan.report.frame.module.RepDict;
import com.gfan.report.frame.service.UserService;

public class DictTag extends RequestContextAwareTag{
	
	/** 
	* @Fields serialVersionUID
	*/
	private static final long serialVersionUID = 4287584103783211416L;

	private String dictType;
	
	private String id;
	
	private String style;
	
	private String nullStr;
	
	public void setDictType(String dictType) {
		this.dictType = dictType;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setStyle(String style) {
		this.style = style;
	}
	public void setNullStr(String nullStr) {
		this.nullStr = nullStr;
	}
	@Override
	protected int doStartTagInternal() throws Exception {
		UserService userService = (UserService)this.getRequestContext().getWebApplicationContext().getBean("userService");
		List<RepDict> entrys = userService.getDicts(dictType);
		try {
			StringBuilder sb = new StringBuilder("<select id='"+id+"' style='"+style+"'>");
			if(nullStr!=null&&!nullStr.equals("")){
				sb.append("<option value=''>"+nullStr+"</option>");
			}
			for(RepDict entry:entrys){
				sb.append("<option value='"+entry.getDictKey()+"'>"+entry.getDictValue()+"</option>");
			}
			sb.append("</select>");
			pageContext.getOut().write(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}
}
