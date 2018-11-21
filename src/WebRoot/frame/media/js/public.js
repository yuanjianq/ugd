/**
* @see 通用的js(该文件已经被N个文件引用了)
* @version 1.0
* @criterion 导入该文件时记得在页面加入代码：<input type="hidden" id="hdfPath" value="<%=request.getContextPath()%>"/>
* @criterion 所有回调函数(事件)必须带小括号,可以传入参数，比如:alert('ok')
*/

/**树形菜单图标存放的文件夹,可以根据实际情况更改*/
var tree_folder = "/res/images/tree/";

/**对话框图标存放的文件夹,可以根据实际情况更改*/
var icon_folder = "/res/images/check/";

/**
* @see 获得对象
* @param id 对象的id(表单元素和其他标签都可以)
* @return Object
*/
function getO(id) {
	return document.getElementById(id);
}

/**
 * @see 获得对象数组
 * @param name 表单元素的name
 * @return Array
 */
function getOA(name) {
	return document.getElementsByName(name);
}

/**
* @see 给表单元素赋值
* @param id 表单元素的id
* @param value 将要写入的值
*/
function setV(id, value) {
	if (getO(id) != null) {
		getO(id).value = value;
	} else {
		alert(id + "未定义");
	}
}

/**
* @see 获得表单元素里的值
* @param id 表单元素的id
* @return String
*/
function getV(id) {
  	if (getO(id) != null) {
		return getO(id).value;
	} else {
		alert(id + "未定义");
		return null;
	}
}

/**
 * @see 获得iframe的window对象
 * @param id iframe的id
 * @return Object
 */
function getIframe(id) {
	if (getO(id) != null) {
		return getO(id).contentWindow;
	} else {
		alert(id + "未定义");
		return null;
	}
}

/**
 * @see 表单提交
 * @param id 表单的id
 */
function formGo(id) {
	if (getO(id) != null) {
		getO(id).submit();
	} else {
		alert(id + "未定义");
	}
}

/**
* @see 设置div的显示或隐藏(其他元素也可以)
* @param id 层的id或其他元素的id
* @param type 1为显示0为隐藏
*/
function showDiv(id, type) {
	if (getO(id) != null) {
		var status = ("1" == type) ? "block" : "none";
  		getO(id).style.display = status;
	}
}

/**
* @see 隐藏或显示子元素
* @param id 元素的ID
* @param type 1表示显示,0表示隐藏
*/
function showChild(id, type) {
	if (getO(id) != null) {
		var status = (type == "1") ? "visible" : "hidden";
  		getO(id).style.visibility = status;
	} else {
		alert(id + "未定义");
	}
}

/**
* @see 给div设置普通内容(其他标签也可以)
* @param id 层的id或其他标签的id
* @param content 将要设置的内容
*/
function fullDiv(id, content) {
	if (getO(id) != null) {
		getO(id).innerHTML = content;
	} else {
		alert(id + "未定义");
	}
}

/**
* @see 改变样式(表单元素和其他标签都可以)
* @param id 表单元素和其他标签的id
* @param css 样式的名称
*/
function changeCss(id, css) {
	if (getO(id) != null) {
		getO(id).className = css;
	} else {
		alert(id + "未定义");
	}
}

/**
* @see 清空下拉框
* @param id 下拉框的ID
* @param count 表示要保留的选项数目
*/
function clearSelect(id, count) {
	getO(id).options.length = count;
}

/**
* @see 给下拉框设置选项
* @param id 下拉框的ID
* @param value 表示这个选项的value (内在值)
* @param text 表示这个选项的text (显示的文本)
*/
function setSelect(id, value, text) {
  	getO(id).options.add(new Option(text, value));
}

/**
 * @see 不允许在文件域输入(主要针对IE)
 * @param event
 */
function notFileInput(event) {
	if (event.keyCode != 8 && event.keyCode != 46) {
		event.returnValue = false;
	}
}

/**
 * @see 设置表单元素是否可用
 * @param id 设置表单的id
 * @param type 1表示可用,0表示不可用
 */
function setBad(id, type) {
	if (type == "1") {
		getO(id).disabled = false;
	} else {
		getO(id).disabled = "false";
	}
}

/**
 * @see 获得单选按钮的值
 * @param name 单选按钮的name属性
 * @return String
 */
function getRadio(name) {
	var value = "";
	var radio = getOA(name);
	for ( var i = 0; i < radio.length; i++) {
		if (radio[i].checked == true) {
			value = radio[i].value;
			break;
		}
	}
	return value;
}

/**
 * @see 获得复选框的值(多个值用分号隔开)
 * @param name 复选框的name属性
 * @return String
 */
function getBox(name) {
	var value = "";
	var box = getOA(name);
	for ( var i = 0; i < box.length; i++) {
		if (box[i].checked == true) {
			value += box[i].value + ";";
		}
	}
	if (value != "") {
		value = value.substring(0, value.length - 1);
	}
	return value;
}

/**
 * @see 隐藏或显示所有的下拉框
 * @param type 1表示显示,0表示隐藏
 */
function showSelects(type) {
	var status = (type == "1") ? "visible" : "hidden";
	var boxs = document.getElementsByTagName("SELECT");
	for ( var i = 0; i < boxs.length; i++) {
		boxs[i].style.visibility = status;
	}
}

/**
 * @see 根据一个复选框来控制N个复选框的选择
 * @param parentId 这一个复选框的ID
 * @param childName N个复选框的Name
 */
function selectAll(parentId, childName) {
	var childs = document.getElementsByName(childName);
	for ( var i = 0; i < childs.length; i++) {
		if (childs[i].disabled == false) {
			childs[i].checked = getO(parentId).checked;
		}
	}
}

/**
* @see 动态创建表单元素(如果该元素已经存在就只赋值)
* @param parentId 父元素ID,如果不存在就用body
* @param id 元素ID必须传入
* @param type 元素类型必须传入
* @param value 元素的值
* @return Object
*/
function createFormUnit(parentId, id, type, value) {
	var formUnit = getO(id);
	if (null == formUnit) {
		formUnit = document.createElement("input");
		formUnit.setAttribute("id", id);
		formUnit.setAttribute("type", type);
		if (getO(parentId) != null) {
			getO(parentId).appendChild(formUnit);
		} else {
			document.body.appendChild(formUnit);
		}
	}
	formUnit.setAttribute("value", value);
	return formUnit;
}

/**
* @see 获得字符串的字符个数(中文算两个)
* @param value 要操作的值
* @return int
*/
function getStrCount(value) {
  	var length = value.length;
  	var count = length;
  	for (var i = 0; i < length; i++) {
		if (value.charCodeAt(i) < 0 || value.charCodeAt(i) >255 ) {
      		count = count + 1;
    	}
  	}
  	return count
}

/**
* @see 截取字符串
* @param value 要操作的值
* @param count 要保留的长度
* @return String
*/ 
function cutStr(value, count) {
	if (value == null || value == "") {
		return "";
	}
	if (getStrCount(value) < parseInt(count)) {
		return value;
	}
	var result = "";
	var num = 0;
	for (var i = 0; i < value.length; i++) {	
		var word = value.substring(i, i + 1);
		if (num >= parseInt(count) - 1) {
			break;
		} else {
			num += getStrCount(word);
			result += word;
		}
	}
	return result;
}

/**
 * @see 格式化数字(保留两位小数)
 * @param value 操作的值
 * @return String
 */
function formatNum(value) {
	var result = "";
	if (!isNaN(value)) {
		var num = new String(value);
		if (num.indexOf(".") != -1) {
			var qian = num.split(".")[0];
			var hou = num.split(".")[1];
			if (hou.length <= 1) {
				result = qian + "." + hou + "0";
			} else if (hou.length > 2) {
				result = qian + "." + hou.substring(0, 2);
			} else {
				result = qian + "." + hou;
			}
		} else {
			result = num + ".00";
		}
	} else {
		result = "0.00";
	}
	return result;
}

/**
 * @see 将字符串转换成html,去掉一些特殊符号
 * @param value 简要操作的值
 * @return String
 */
function turnHtml(value) {
	if (value == null || value == "") {
		return value;
	}
	if (value.indexOf("<") != -1) {
		value = value.replace(/\</g, "&lt;");
	}
	if (value.indexOf(">") != -1) {
		value = value.replace(/\>/g, "&gt;");
	}
	if (value.indexOf("\"") != -1) {
		value = value.replace(/\"/g, "&quot;");
	}
	return value;
}

/**
 * @see 错误提示
 * @param id 表单元素的ID
 * @param text 将要设置的错误的文本信息
 * @return boolean
 */
function errorPormt(id, text) {
	if (getO("divErrorMsg") == null) {
		var newDiv = document.createElement("div");
		newDiv.setAttribute("id", "divErrorMsg");
		newDiv.style.paddingLeft = "2px";
		newDiv.style.paddingRight = "2px";
		newDiv.style.paddingTop = "2px";
		newDiv.style.paddingBottom = "2px";
		newDiv.style.border = "1px solid #FF0000";
		newDiv.style.position = "absolute";
		newDiv.style.backgroundColor = "#FFFFFF";
		newDiv.style.fontSize = "12px";
		newDiv.style.display = "none";
		newDiv.style.zIndex = 10;
		if (document.form1 != null) {
			document.form1.appendChild(newDiv);
		} else if (getO("form1") != null) {
			getO("form1").appendChild(newDiv);
		} else {
			document.body.appendChild(newDiv);
		}
	}
	var left = parseInt(getAbsPoint(id).split(";")[0]);
	var top = parseInt(getAbsPoint(id).split(";")[1]);
	var width = getO(id).offsetWidth;
	var height = getO(id).offsetHeight;
	var boxs = document.getElementsByTagName("SELECT");
	for ( var i = 0; i < boxs.length; i++) {
		if (boxs[i].id == null || boxs[i].id == "") {
			boxs[i].id = "selectDefine" + i;
		}
		var boxLeft = getAbsPoint(boxs[i].id).split(";")[0];
		var boxTop = getAbsPoint(boxs[i].id).split(";")[1];
		if ((parseInt(boxTop) <= (parseInt(top) + 50)) && (parseInt(boxTop) > parseInt(top))
				&& (parseInt(boxLeft) >= parseInt(left)) && (parseInt(boxLeft) <= parseInt(left + 30 + parseInt(width)))) {
			boxs[i].style.visibility = "hidden";
		}
	}
	getO("divErrorMsg").style.left = (left + 0) + "px";
	getO("divErrorMsg").style.top = (top + parseInt(height) + 4) + "px";
    fullDiv("divErrorMsg", "<img src='" + getV("hdfPath") + icon_folder + "no.gif'/> <font color='red'>" + text + "</font>");
  	showDiv("divErrorMsg", "1");
  	if (getO(id).onfocus == null || getO(id).onfocus == "") {
		getO(id).focus();
  	}
  	getO(id).onclick = function() {
  		clearErrorPormt1();
  	};
  	getO(id).onkeydown = function() {
  		clearErrorPormt1();
  	};
  	errorPormtMinute = 3;
  	clearErrorPormt();//3秒钟自动消失
  	return false;
}
var errorPormtMinute = 3;
var errorPormtTimer;
function clearErrorPormt() {
  	errorPormtMinute = errorPormtMinute - 1;
  	if (errorPormtMinute >= 0) {
	 	errorPormtTimer = setTimeout("clearErrorPormt()", 1000);
  	} else {
		clearErrorPormt1();
  	}
}
function clearErrorPormt1() {
  	showDiv("divErrorMsg", "0");
  	showSelects("1");
  	clearTimeout(errorPormtTimer);
}

/**
 * @see 信息提示框(可以代替alert弹框)
 * @param title 提示框的标题
 * @param winWidth 提示框的宽度
 * @param winHeight 提示框的高度
 * @param message 提示框的内容
 * @param iconType 图标类型(0表示错误,1表示正确,2表示普通的)
 * @param callback 回调函数
 */
function alertWin(title, winWidth, winHeight, message, iconType, callback) {
	createFormUnit("", "hdfAlertWinCallback", "hidden", callback);
	if (getO("divAlertWin") == null) {
		var newDiv = document.createElement("div");
		newDiv.setAttribute("id", "divAlertWin");
		newDiv.style.zIndex = 10;
		newDiv.style.border = "2px solid #33CCFF";
		newDiv.style.position = "absolute";
		newDiv.style.backgroundColor = "#FFFFFF";
		newDiv.style.fontSize = "12px";
		newDiv.style.display = "none";
		if (document.form1 != null) {
			document.form1.appendChild(newDiv);
		} else if (getO("form1") != null) {
			getO("form1").appendChild(newDiv);
		} else {
			document.body.appendChild(newDiv);
		}
		var info = '<div align="left" id="divAlertTitle" style="background-color:#33CCFF;height:20px;padding-top:2px;cursor:move;" onmousedown="mousePlead1(event,\'divAlertWin\')"></div>';
		info += '<div align="center" id="divAlertMsg" style="padding-top:8px;padding-left:10px;padding-right:10px;"></div>';
		info += '<div align="center" style="border-top:1px solid #33CCFF;height:30px;padding-top:6px;" id="divCloseAlert"></div>';
		fullDiv("divAlertWin", info);
	}
	var width = parseInt(document.documentElement.clientWidth);
	var height = parseInt(document.documentElement.clientHeight);
	getO("divAlertWin").style.left = ((width - 240) / 2) + "px";
	getO("divAlertWin").style.top = ((height - winHeight) / 2) + "px";
	getO("divAlertWin").style.width = winWidth + "px";
	fullDiv("divAlertTitle", '&nbsp;&nbsp;<strong><font color="#FFFFFF">' + title + '</font></strong>');
	getO("divAlertMsg").style.height = (winHeight - 48) + "px";
	var iconImg = icon_folder + 'info.gif';
	if (iconType == "0") {
		iconImg = icon_folder + 'err.gif';
	}else if (iconType == "1") {
		iconImg = icon_folder + 'right.gif';
	}
	fullDiv("divAlertMsg", '<img src="' + getV("hdfPath") + iconImg + '"/> ' + message);
	getO("divCloseAlert").innerHTML = '<a href="javascript:clearAlert1()"><img src="' + getV("hdfPath") + icon_folder + 'btnConfirm.jpg" border="0" title="关闭"/></a>';
	setEnvelopDiv();
	showSelects("0");
	showDiv("divAlertWin", "1");
	alertMinute = 8;
	clearAlert();//8秒钟自动消失
}
var alertMinute = 8;
var alertTimer;
function clearAlert() {
	alertMinute = alertMinute - 1;
	if (alertMinute >= 0) {
		alertTimer = setTimeout("clearAlert()", 1000);
	} else {
		clearAlert1();
	}
}
function clearAlert1() {
	clearTimeout(alertTimer);
	showDiv("divEnvelop", "0");
	showDiv("divAlertWin", "0");
	showSelects("1");
	if (getV("hdfAlertWinCallback") != "") {
		eval(getV("hdfAlertWinCallback"));
	}
}

/**
 * @see 询问提示框(可代替confirm弹框)
 * @param title 提示框的标题
 * @param winWidth 提示框的宽度
 * @param winHeight 提示框的高度
 * @param message 提示框的内容
 * @param callback 回调函数
 */
function confirmWin(title, winWidth, winHeight, message, callback) {
	if (getO("divConfirmWin") == null) {
		var newDiv = document.createElement("div");
		newDiv.setAttribute("id", "divConfirmWin");
		newDiv.style.zIndex = 10;
		newDiv.style.border = "2px solid #33CCFF";
		newDiv.style.position = "absolute";
		newDiv.style.backgroundColor = "#FFFFFF";
		newDiv.style.fontSize = "12px";
		newDiv.style.display = "none";
		if (document.form1 != null) {
			document.form1.appendChild(newDiv);
		} else if (getO("form1") != null) {
			getO("form1").appendChild(newDiv);
		} else {
			document.body.appendChild(newDiv);
		}
		var info = '<div align="left" id="divConfirmTitle" style="background-color:#33CCFF;height:20px;padding-top:2px;cursor:move;" onmousedown="mousePlead1(event,\'divConfirmWin\')"></div>';
		info += '<div align="center" id="divConfirmMsg" style="padding-top:8px;padding-left:10px;padding-right:10px;"></div>';
		info += '<div align="center" id="divCloseConfrim" style="border-top:1px solid #33CCFF;height:30px;padding-top:6px;"></div>';
		fullDiv("divConfirmWin", info);
	}
	var width = parseInt(document.documentElement.clientWidth);
	var height = parseInt(document.documentElement.clientHeight);
	getO("divConfirmWin").style.left = ((width - 240) / 2) + "px";
	getO("divConfirmWin").style.top = ((height - winHeight) / 2) + "px";
	getO("divConfirmWin").style.width = winWidth + "px";
	fullDiv("divConfirmTitle", '&nbsp;&nbsp;<strong><font color="#FFFFFF">' + title + '</font></strong>');
	var info = '<a href="javascript:clearConfirm();' + callback + '"><img src="'
			+ getV("hdfPath") + icon_folder + 'btnConfirm.jpg" border="0"/></a>&nbsp;&nbsp;<a id="btnCloseConfrim" href="javascript:clearConfirm()"><img src="'
			+ getV("hdfPath") + icon_folder + 'btnCancel.jpg" border="0"/></a>';
	fullDiv("divCloseConfrim", info);
	getO("divConfirmMsg").style.height = (winHeight - 52) + "px";
	fullDiv("divConfirmMsg", '<img src="' + getV("hdfPath") + icon_folder + 'ask.gif"/> ' + message);
	setEnvelopDiv();
	showSelects("0");
	showDiv("divConfirmWin", "1");
}
function clearConfirm() {
	showDiv("divEnvelop", "0");
	showDiv("divConfirmWin", "0");
	showSelects("1");
}

/**
* @see 本项目中的搜索引擎智能提示(dwr版)
* @param event 事件(自带的)
* @param id 文本框的ID
* @param fileds 要搜索的字段(属性),如果有拼音检索的,必须汉字字段在前,拼音字段在后，中间用★隔开
* @param entity 要搜索的实体类
* @param deptId 当前用户的组织机构ID(如果是系统管理，可以不传入)
* @param callback 按下回车键之后的回调事件
* @param 需要以下代码支持:
  <script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/role.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/dwr/util.js"></script>
*/
function getProjectSelf(event, id, fileds, entity, deptId, callback) {
	if (event.keyCode != 38 && event.keyCode != 40 && event.keyCode != 13) {
		if (getV(id) != "") {
			var filed1 = (fileds.indexOf("★") != -1) ? fileds.split("★")[0] : fileds;// 汉字字段
			var filed2 = (fileds.indexOf("★") != -1) ? fileds.split("★")[1] : "";// 拼音字段
			var keyWord = getV(id);// 关键字
			var filedHql = " where " + filed1 + " like '" + keyWord + "%'";
			if (filed2 != "") {
				filedHql = " where (" + filed1 + " like '" + keyWord + "%' or " + filed2 + " like '" + keyWord + "%')";
			}
			var deptHql = (deptId != "") ? " and createUserid in (select id from User where department.id=" + deptId + ")" : "";
			var hql = "select " + filed1 + " from " + entity + filedHql + deptHql + " group by " + filed1 + " order by " + (filed2 != "" ? filed2 : filed1);
	  		getSelfPrompt(id, hql, callback);
	  		document.onclick = function() {
		  		showDiv("divSelfPrompt", "0");
		  	};
		} else {
			showDiv("divSelfPrompt", "0");
		}
	}
}
function getSelfPrompt(id, hql, callback) {
	createFormUnit("", "hdfTextId", "hidden", id);
	createFormUnit("", "hdfTextValue", "hidden", getV(id));
	createFormUnit("", "hdfSelfNum", "hidden", "");
	createFormUnit("", "hdfSelfIndex", "hidden", "");
	createFormUnit("", "hdfSelfCallback", "hidden", callback);
	role.getNames(hql, function(result) {
  		if(result.length > 0) {
			if(getO("divSelfPrompt") == null){
      			var newDiv = document.createElement("div");
	  			newDiv.setAttribute("id", "divSelfPrompt");
	  			newDiv.style.position = "absolute";		  
	  			newDiv.style.border = "1px solid #9999FF";
	  			newDiv.style.display = "none";
	  			newDiv.style.zIndex = 10;
	  			newDiv.style.backgroundColor = "#FFFFFF";
	  			document.body.appendChild(newDiv);
    		}
    		var left = parseInt(getAbsPoint(getV("hdfTextId")).split(";")[0]) + 2;
    		var top = parseInt(getAbsPoint(getV("hdfTextId")).split(";")[1]) + 1;
    		var height = parseInt(getO(getV("hdfTextId")).offsetHeight) - 1;
    		var width = parseInt(getO(getV("hdfTextId")).offsetWidth) - 5;
    		getO("divSelfPrompt").style.left = left + "px";
    		getO("divSelfPrompt").style.top = (top + height) + "px";
    		getO("divSelfPrompt").style.width = width + "px";
    		var info = '';
    		var selfNum = 0;
    		for (var i = 0; i < result.length; i++) {
      			if(i < 15) {
      				var text = cutStr(result[i], parseInt(width / 6));
      				info += '<div id="divSelfIndex' + i + '" style="line-height:22px;padding-left:5px;width:' + (width - 5) + 
      					'px;cursor:pointer;background-color:#FFFFFF;" onmouseover="clearSelf();setV(\'hdfSelfIndex\',\'' + i + 
      					'\');this.style.backgroundColor=\'#E6EEFF\';" onmouseout="this.style.backgroundColor=\'#FFFFFF\'" onclick="setV(getV(\'hdfTextId\'),\'' + text + 
      					'\');showDiv(\'divSelfPrompt\',\'0\');">' + text + '</div>';
      				selfNum++;
      			}
    		}
    		fullDiv("divSelfPrompt", info);
    		showDiv("divSelfPrompt", "1");
    		setV("hdfSelfNum", selfNum);
    		getO(getV("hdfTextId")).onkeydown = function() {
    			if (getO("divSelfPrompt").style.display != "none") {
					clearSelf();
					var selfIndex = (getV("hdfSelfIndex") != "") ? parseInt(getV("hdfSelfIndex")) : -1;
					var event = arguments[0] || window.event; 
					var keyCode = event.charCode || event.keyCode;
					if (keyCode == 38) {
						selfIndex = selfIndex - 1;
						if (getO("divSelfIndex" + selfIndex) != null) {
							getO("divSelfIndex" + selfIndex).style.backgroundColor = "#E6EEFF";
							setV(getV("hdfTextId"),getO("divSelfIndex" + selfIndex).innerHTML);
							setV("hdfSelfIndex", selfIndex);
						} else {
							if (selfIndex == -1) {
								setV(getV("hdfTextId"), getV("hdfTextValue"));
								setV("hdfSelfIndex", selfIndex);
							} else {
								if (getO("divSelfIndex" + (parseInt(getV("hdfSelfNum")) - 1)) != null) {
									getO("divSelfIndex" + (parseInt(getV("hdfSelfNum")) - 1)).style.backgroundColor = "#E6EEFF";
									setV(getV("hdfTextId"),getO("divSelfIndex" + (parseInt(getV("hdfSelfNum")) - 1)).innerHTML);
									setV("hdfSelfIndex", (parseInt(getV("hdfSelfNum")) - 1));
								}
							}
						}
					}
					if (keyCode == 40) {
						selfIndex = selfIndex + 1;
						if (getO("divSelfIndex" + selfIndex) != null) {
							getO("divSelfIndex" + selfIndex).style.backgroundColor = "#E6EEFF";
							setV(getV("hdfTextId"),getO("divSelfIndex" + selfIndex).innerHTML);
							setV("hdfSelfIndex", selfIndex);
						} else {
							if (selfIndex == parseInt(getV("hdfSelfNum"))) {
								setV(getV("hdfTextId"), getV("hdfTextValue"));
								setV("hdfSelfIndex", selfIndex);
							} else {
								if (getO("divSelfIndex" + 0) != null) {
									getO("divSelfIndex" + 0).style.backgroundColor = "#E6EEFF";
									setV(getV("hdfTextId"),getO("divSelfIndex" + 0).innerHTML);
									setV("hdfSelfIndex", 0);
								}
							}
						}
					}
					if (keyCode == 13) {
						showDiv("divSelfPrompt", "0");
						if (getV("hdfSelfCallback") != "") {
							eval(getV("hdfSelfCallback"));
						}
					}
				}
    		};
  		} else {
    		showDiv("divSelfPrompt", "0");
  		}
	});
}
function clearSelf() {
	for(var i = 0; i < parseInt(getV("hdfSelfNum")); i++) {
		if (getO("divSelfIndex" + i) != null) {
			getO("divSelfIndex" + i).style.backgroundColor = "#FFFFFF";
		}
	}
}

/**
 * @see 设置一个遮盖的Div,它的z-index为3
 */
function setEnvelopDiv() {
	if (getO("divEnvelop") == null) {
		var newDiv = document.createElement("div");
		newDiv.setAttribute("id", "divEnvelop");
		newDiv.style.position = "absolute";
		newDiv.style.zIndex = 3;
		newDiv.style.backgroundColor = "#738E9D";
		newDiv.style.left = "0px";
		newDiv.style.top = "0px";
		newDiv.style.width = getWinSize().split(";")[0] + "px";
		newDiv.style.height = getWinSize().split(";")[1] + "px";
		newDiv.style.filter = "alpha(opacity=15)";
		newDiv.style.opacity = "0.1";
		newDiv.style.display = "none";
		document.body.appendChild(newDiv);
	}
	showDiv("divEnvelop", "1");
}

/**
 * @see 弹出模式窗体
 * @param title 窗体的标题
 * @param winWidth 窗体的宽度
 * @param winHeight 窗体的高度
 * @param url 窗体的链接
 */
function dialogWin(title, winWidth, winHeight, url) {
	if (getO("divDialogWin") == null) {
		var newDiv = document.createElement("div");
		newDiv.setAttribute("id", "divDialogWin");
		newDiv.style.border = "2px solid #5aa2ef";
		newDiv.style.position = "absolute";
		newDiv.style.zIndex = 10;
		newDiv.style.backgroundColor = "#FFFFFF";
		newDiv.style.fontSize = "12px";
		newDiv.style.display = "none";
		if (document.form1 != null) {
			document.form1.appendChild(newDiv);
		} else if (getO("form1") != null) {
			getO("form1").appendChild(newDiv);
		} else {
			document.body.appendChild(newDiv);
		}
		var newDiv1 = document.createElement("div");
		newDiv1.style.backgroundColor = "#5aa2ef";
		newDiv1.style.height = "22px";
		newDiv1.innerHTML = '<table cellpadding="0" cellspacing="0" border="0"><tr><td align="left" height="22" style="cursor:move" id="divDialogTitle" onmousedown="mousePlead1(event,\'divDialogWin\')"></td><td align="right" width="20"><a href="javascript:closeDialog()" id="linkCloseDialog" title="关闭"><img src="'
				+ getV("hdfPath") + icon_folder + 'dialogclose.gif" border="0"/></a></td></tr></table>';
		newDiv.appendChild(newDiv1);
		var newDiv2 = document.createElement("div");
		newDiv2.setAttribute("align", "center");
		newDiv2.style.paddingTop = "0px";
		newDiv2.style.paddingLeft = "0px";
		newDiv2.innerHTML='<iframe id="frmDialogWin" name="frmDialogWin" frameborder="0" scrolling="auto" align="top" marginheight="0" marginwidth="0"></iframe>';
		newDiv.appendChild(newDiv2);
	}
	dialogResize(winWidth, winHeight);
	getO("frmDialogWin").src = url;
	getO("divDialogTitle").style.width = (winWidth - 20) + "px";
	fullDiv("divDialogTitle", "&nbsp;&nbsp;<strong><font color='#FFFFFF'>" + title + "</font></strong>");
	setEnvelopDiv();
	showSelects("0");
	showDiv("divDialogWin", "1");
}

/**
 * @see 关闭模式窗体
 */
function closeDialog() {
	if (getO("divEnvelop") != null) {
		showDiv("divEnvelop", "0");
	}
	showSelects("1");
	if (getO("divDialogWin") != null) {
		showDiv("divDialogWin", "0");
	}
}

/**
 * @see 给模式窗体重新设置大小
 * @param winWidth 窗体的宽度
 * @param winHeight 窗体的高度
 */
function dialogResize(winWidth, winHeight) {
	if (getO("divDialogWin") != null) {
		var width = parseInt(getWinSize().split(";")[0]);
		var height = parseInt(getWinSize().split(";")[1]);
		getO("divDialogWin").style.left = ((width - winWidth) / 2) + "px";
		getO("divDialogWin").style.top = ((height - winHeight - 22) / 2) + "px";
		getO("divDialogWin").style.width = (winWidth + 2) + "px";
		getO("divDialogWin").style.height = (winHeight + 24) + "px";
		getO("frmDialogWin").width = winWidth + "px";
		getO("frmDialogWin").height = winHeight + "px";
	}
}

/**
* @see 设置一个没有百分比进度条
* @param title 进度条的标题
* @param content 进度条中的内容
*/
function setLoadGress(title, content) {
	if (getO("divLoadGress") == null) {
		var newDiv = document.createElement("div");
		newDiv.setAttribute("id", "divLoadGress");
		newDiv.style.position = "absolute";
		newDiv.style.zIndex = 10;
		newDiv.style.display = "none";
		newDiv.style.border = "2px solid #CCFFFF";
		if (getO("form1") != null) {
			getO("form1").appendChild(newDiv);
		} else if (document.form1 != null) {
			document.form1.appendChild(newDiv);
		} else {
			document.body.appendChild(newDiv);
		}
		var info = '<table width="360" border="0" align="center" cellpadding="3" cellspacing="1" style="background-color:#A9C0DC;">';
		info += '<tr>';
		info += '<td colspan="2" style="background-color:#E3F4FE;">';
		info += '<table border="0" cellpadding="0" cellspacing="0" width="100%">';
		info += '<tr>';
		info += '<td align="left" style="padding-left:5px;cursor:move;height:20px;" onmousedown="mousePlead1(event,\'divLoadGress\')">';
		info += '<strong><font color="#FF33FF" id="lblGressTitle"></font></strong>';
		info += '</td>';
		info += '</tr>';
		info += '</table>';
		info += '</td>';
		info += '</tr>';
		info += '<tr>';
		info += '<td align="center" bgcolor="#FFFFFF" valign="middle" height="60">';
		info += '<div style="color:#cc6633;font-weight:bold;font-size:14px;" id="lblGressContent"></div>';
		info += '</td>';
		info += '</tr>';
		info += '</table>';
		fullDiv("divLoadGress", info);
	}
	fullDiv("lblGressTitle", title);
	fullDiv("lblGressContent", content);
	setDivCenter("divLoadGress");
    setEnvelopDiv();
    showSelects("0");
}

/**
* @see 关闭没有百分比的进度条
*/
function closeLoadGress() {
	showDiv("divEnvelop", "0");
	showDiv("divLoadGress", "0");
	showSelects("1");
}

/**
* @see 设置一个有百分比进度条
* @param title 进度条的标题
* @param content 进度条中的内容
* @param pace 进度条的走动速度,必须是整数(数值越小，走动速度越快)
* @param percent 进度条百分比的显示类型(0不显示百分比,1显示所有数值,2逢五显示,3逢十显示)
* @param callback 进度条走完后的回调函数
*/
function setPlanGress(title, content, pace, percent, callback) {
	createFormUnit("", "hdfGressPace", "hidden", pace);
	createFormUnit("", "hdfGressPercent", "hidden", percent);
	createFormUnit("", "hdfGressCallback", "hidden", callback);
	if (getO("divPlanGress") == null) {
		var newDiv = document.createElement("div");
		newDiv.setAttribute("id", "divPlanGress");
		newDiv.style.position = "absolute";
		newDiv.style.zIndex = 10;
		newDiv.style.display = "none";
		newDiv.style.border = "2px solid #CCFFFF";
		if (getO("form1") != null) {
			getO("form1").appendChild(newDiv);
		} else if (document.form1 != null) {
			document.form1.appendChild(newDiv);
		} else {
			document.body.appendChild(newDiv);
		}
		var info = '<table width="360" border="0" align="center" cellpadding="3" cellspacing="1" style="background-color:#A9C0DC;">';
		info += '<tr>';
		info += '<td colspan="2" style="background-color:#E3F4FE;">';
		info += '<table border="0" cellpadding="0" cellspacing="0" width="100%">';
		info += '<tr>';
		info += '<td align="left" style="padding-left:5px;cursor:move;height:20px;" onmousedown="mousePlead1(event,\'divPlanGress\')">';
		info += '<strong><font color="#FF33FF" id="lblPlanGressTitle"></font></strong>';
		info += '</td>';
		info += '</tr>';
		info += '</table>';
		info += '</td>';
		info += '</tr>';
		info += '<tr>';
		info += '<td align="center" bgcolor="#FFFFFF" valign="middle" height="70">';
		info += '<div style="color:#cc6633;font-weight:bold;font-size:12px;">';
		info += '<label id="lblPlanGressContent"></label><span id="divPercentPlan" style="color:red;"></span>';
		info += '</div>';
		info += '<div style="border:black 1px solid;width:200px;height:12px;background-color:#ffffcc;">';
		for (var i = 1; i <= 100; i++) {
			info += '<div id="divChildPlan' + i + '" style="height:12px;width:2px;float:left;"></div>';
		}
		info += '</div>';
		info += '</td>';
		info += '</tr>';
		info += '</table>';
		fullDiv("divPlanGress", info);
	}
	for (var i = 1; i <= 100; i++) {
		getO("divChildPlan" + i).style.backgroundColor = "#FFFFFF";
	}
	fullDiv("lblPlanGressTitle", title);
	fullDiv("lblPlanGressContent", content);
	setDivCenter("divPlanGress");
    setEnvelopDiv();
    showSelects("0");
    indexPlan = 0;
    gressBeginPlan();
}
var indexPlan = 0;
var timerPlan;
function gressEndPlan() {
  	clearTimeout(timerPlan);
  	showDiv("divEnvelop", "0");
	showDiv("divPlanGress", "0");
	showSelects("1");
	if (getV("hdfGressCallback") != "") {
		eval(getV("hdfGressCallback"));
	}
}
function gressBeginPlan() {
  	indexPlan++;
  	if(indexPlan > 100){
    	gressEndPlan();
  	} else { 
  		if (getV("hdfGressPercent") != "0") {
  			var percent = 1;
  			if (getV("hdfGressPercent") == "2") {
  				percent = 5;
  			} else if (getV("hdfGressPercent") == "3") {
  				percent = 10;
  			}
  			if (indexPlan % percent == 0) {
	   	 		fullDiv("divPercentPlan", indexPlan + "%");
	   	 	}
  		}
    	getO("divChildPlan" + indexPlan).style.backgroundColor = "blue";
    	timerPlan = setTimeout("gressBeginPlan()", parseInt(getV("hdfGressPace")));
  	}
}

/**
 * @see 把一个div放在屏幕的最中央
 * @param id div的id
 */
function setDivCenter(id) {
	showDiv(id, "1");
	getO(id).style.left = (((parseInt(getWinSize().split(";")[0])) - parseInt(getO(id).offsetWidth)) / 2) + "px";
	getO(id).style.top = (((parseInt(getWinSize().split(";")[1])) - parseInt(getO(id).offsetHeight)) / 2) + "px";
}

/**
 * @see 只能输入字母数字下划线
 * @param id 文本框的id
 * @param text 错误提示的内容
 * @return boolean
 */
function letterAndNo(id, text) {
	var chars = "abcdefghijklmnopqrstuvwxyz_0123456789", result = true, value = getV(id);
	for ( var i = 0; i < value.length; i++) {
		if (chars.indexOf(value.substring(i, i + 1).toLowerCase()) == -1) {
			result = false;
			break;
		}
	}
	if (!result) {
		errorPormt(id, text + "必须是数字,字母,下划线!");
	}
	return result;
}

/**
 * @see 只能输入字母数字
 * @param id 文本框的id
 * @param text 错误提示的内容
 * @return boolean
 */
function edhAndNo(id, text) {
	var test = /^[A-Za-z0-9]*$/;
	if (!test.exec(getV(id))) {
		return errorPormt(id, text + "必须是字母,数字组成!");
	}
	return true;
}

/**
 * @see 不能只是纯数字
 * @param id 文本框的id
 * @param text 错误提示的内容
 * @return boolean
 */
function notAllNo(id, text) {
	var chars = "0123456789", charsNum = 0, value = getV(id);
	for ( var i = 0; i < value.length; i++) {
		if (chars.indexOf(value.substring(i, i + 1)) != -1) {
			charsNum++;
		}
	}
	if (charsNum == value.length) {
		return errorPormt(id, text + "不能是纯数字组成!");
	}
	return true;
}

/**
 * @see 不能是单一连续的字符
 * @param id 文本框的id
 * @param text 错误提示的内容
 * @return boolean
 */
function notOnlyOne(id, text) {
	var value = getV(id), result = false, str = getV(id).substring(0, 1);
	for ( var i = 0; i < value.length; i++) {
		if (value.substring(i, i + 1) != str) {
			result = true;
			break;
		}
	}
	if (!result) {
		errorPormt(id, text + "不能是单一连续的字符!");
	}
	return result;
}

/**
 * @see 不能有空格
 * @param id 文本框的id
 * @param text 错误提示的内容
 * @return boolean
 */
function notBlank(id, text) {
	if (getV(id).indexOf(" ") != -1) {
		return errorPormt(id, text + "中不能有空格!");
	}
	return true;
}

/**
 * @see 检查文本框是否为空
 * @param id 文本框的ID
 * @param text 错误提示的内容
 * @return boolean
 */
function checkNull(id, text) {
	var value = getV(id);
	if (value.indexOf(" ") != -1) {
		value = value.replace(/\ /g, "");
	}
	if (value == "") {
		return errorPormt(id, text + "不能为空!");
	}
	return true;
}

/**
 * @see 不能包含特殊字符
 * @param id 文本框的ID
 * @param text 错误提示的内容
 * @return boolean
 */
function notHaveChar(id, text) {
	var chars = "`~!@#$%^&*[]{}\\'|\"/><", result = true, value = getV(id);
	for ( var i = 0; i < value.length; i++) {
		if (chars.indexOf(value.substring(i, i + 1)) != -1) {
			result = false;
			break;
		}
	}
	if (!result) {
		errorPormt(id, text + "中不能包含特殊字符!");
	}
	return result;
}

/**
 * @see 限制最少的字符长度
 * @param id 文本框的ID
 * @param text 错误提示的内容
 * @param minLength 字符的最小长度
 * @return boolean
 */
function checkMinLength(id, text, minLength) {
	if (getStrCount(getV(id)) < parseInt(minLength)) {
		return errorPormt(id, text + "太短,最少要" + minLength + "个字符!");
	}
	return true;
}

/**
 * @see 必须是固定的字符长度
 * @param id 文本框的ID
 * @param text 错误提示的内容
 * @param moorLenth 字符的固定长度
 * @return boolean
 */
function checkLength(id, text, moorLenth) {
	if (getStrCount(getV(id)) != parseInt(moorLenth)) {
		return errorPormt(id, text + "必须是" + moorLenth + "个字符!");
	}
	return true;
}

/**
 * @see 限制最多的字符长度
 * @param id 文本框的ID
 * @param text 错误提示的内容
 * @param maxLength 字符的最大长度
 * @return boolean
 */
function checkMaxLength(id, text, maxLength) {
	if (getStrCount(getV(id)) > parseInt(maxLength)) {
		return errorPormt(id, text + "太长,最多" + maxLength + "个字符!");
	}
	return true;
}

/**
 * @see 限制最少的浮点类型数据
 * @param id 文本框的ID
 * @param text 错误提示的内容
 * @param minFloat 最小数据
 * @param unit 单位
 * @return boolean
 */
function isMinFloat(id, text, minFloat, unit) {
	if (isNaN(getV(id)) || getV(id).indexOf(" ") != -1) {
		return errorPormt(id, text + "必须是数字!");
	}
	if (parseFloat(getV(id)) < parseFloat(minFloat)) {
		return errorPormt(id, text + "不能低于" + minFloat + unit + "!");
	}
	return true;
}

/**
 * @see 限制最多的浮点类型数据
 * @param id 文本框的ID
 * @param text 错误提示的内容
 * @param maxFloat 最大数据
 * @param unit 单位
 * @return boolean
 */
function isMaxFloat(id, text, maxFloat, unit) {
	if (isNaN(getV(id)) || getV(id).indexOf(" ") != -1) {
		return errorPormt(id, text + "必须是数字!");
	}
	if (parseFloat(getV(id)) > parseFloat(maxFloat)) {
		return errorPormt(id, text + "不能超过" + maxFloat + unit + "!");
	}
	return true;
}

/**
 * @see 下拉框里必须要选择一项
 * @param id 下拉框的ID
 * @param text 错误提示的内容
 * @return boolean
 */
function checkSelect(id, text) {
	if (getV(id) == "" || getV(id) == "0" || getV(id) == "-1") {
		return errorPormt(id, "请选择一个" + text + "!");
	}
	return true;
}

/**
 * @see 判断是不是邮政编码
 * @param id 文本框的ID
 * @param isMustPut 是否为必填项(1表示必填,0表示不是必填) 
 * @return boolean
 */
function isPost(id, isMustPut) {
	if (isMustPut == "1" || (isMustPut == "0" && getV(id) != "")) {
		if (!isNaN(getV(id)) && getStrCount(getV(id)) != 6) {
			return errorPormt(id, "邮政编码必须是6位数字!");
		}
	} 
	return true;
}

/**
 * @see 判断是不是email地址
 * @param id 文本框的ID
 * @param isMustPut 是否为必填项(1表示必填,0表示不是必填) 
 * @return boolean
 */
function isEmail(id, isMustPut) {
	if (isMustPut == "1" || (isMustPut == "0" && getV(id) != "")) {
		var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		if (!reg.test(getV(id))) {
			return errorPormt(id, "正确的邮箱格式：***@**.***");
		}
	}
	return true;
}

/**
* @see 判断是不是电话号码
* @param id 文本框的ID
* @param isMustPut 是否为必填项(1表示必填,0表示不是必填) 
* @return boolean
*/
function isTelephone(id, isMustPut) {
	if (isMustPut == "1" || (isMustPut == "0" && getV(id) != "")) {
		var strReg = /^((\d{7,8})|((\d{3,4})-(\d{7,8}))|((\d{3,4})-(\d{7,8})-(\d{3,7})))$/;
	  	if (!strReg.test(getV(id))) {
	  		return errorPormt(id, "电话的格式:区号-号码-分机号!");
	  	}
	}
  	return true;
}

/**
 * @see 判断是不是手机号码(必须13,15,18开头)
 * @param id 文本框的ID
 * @param isMustPut 是否为必填项(1表示必填,0表示不是必填) 
 * @return boolean
 */
function isMobile(id, isMustPut) {
	if (isMustPut == "1" || (isMustPut == "0" && getV(id) != "")) {
		if (getV(id).length != 11 || isNaN(getV(id))) {
			return errorPormt(id, "手机号码必须是11位数字!");
		}
		var chart = getV(id).substring(1, 2);
		if (!(chart == "3" || chart == "5" || chart == "8")) {
			return errorPormt(id, "手机号码必须是13,15,18开头!");
		}
	}
	return true;
}

/**
* @see 判断是不是身份证号码
* @param id 文本框的ID
* @param isMustPut 是否为必填项(1表示必填,0表示不是必填) 
* @return boolean
*/
function isShenCard(id, isMustPut) {
	if (isMustPut == "1" || (isMustPut == "0" && getV(id) != "")) {
		var strReg = /^\d{15}(\d{2}[\dx])?$/i;
	  	if (!strReg.test(getV(id))) {
	  		return errorPormt(id, "身份证号码格式不正确!");
	  	}
	}
  	return true;
}

/**
* @see 判断是不是身份证号码，同时获取生日
* @param id 身份证号码文本框的ID
* @param isMustPut 身份证号码是否为必填项(1表示必填,0表示不是必填) 
* @param birthId 生日文本框的ID
* @return boolean
*/
function isCardBirth(id, isMustPut, birthId) {
	if (isMustPut == "1" || (isMustPut == "0" && getV(id) != "")) {
		if (!isShenCard(id, isMustPut)) {
			return false;
		}
		var nowYear = parseInt(new Date().getFullYear());
		var year = (getStrCount(getV(id)) == 15) ? parseInt("19" + getV(id).substring(6, 8)) : parseInt(getV(id).substring(6, 10));
		var month = (getStrCount(getV(id)) == 15) ? getV(id).substring(8, 10) : getV(id).substring(10, 12);
		var day = (getStrCount(getV(id)) == 15) ? getV(id).substring(10, 12) : getV(id).substring(12, 14);
		setV(birthId, year + "-" + month + "-" + day);
		showDiv("divErrorMsg", "0");
		if ((nowYear - year) < 16) {
			return errorPormt(birthId, "该人员未年满16周岁!");
		} else if ((nowYear - year) > 70) {
			return errorPormt(birthId, "该人员已经退休(最大70周岁)!");
		} else if (parseInt(getDateNum(month)) > 12 || parseInt(getDateNum(month)) < 1) {
			return errorPormt(birthId, "生日的月份不正确(1-12之间)");
		} else if (parseInt(getDateNum(day)) > getDayNum(year, parseInt(getDateNum(month))) || parseInt(getDateNum(day)) < 1) {
			return errorPormt(birthId, "生日的日份不正确(1-" + getDayNum(year, parseInt(getDateNum(month))) + "之间)");
		}
	}
	return true;
}

/**
* @see 判断是不是真实姓名
* @param id 文本框的ID
* @param isMustPut 是否为必填项(1表示必填,0表示不是必填) 
* @return boolean
*/
function isRealName(id, isMustPut) {
	if (isMustPut == "1" || (isMustPut == "0" && getV(id) != "")) {
		var count = 0;
		for ( var i = 0; i < getV(id).length; i++) {
			var str = getV(id).substring(i, i + 1);
			if (getStrCount(str) == 2 || isEnglish(str)) {
				count++;
			}
		}
		if (count == 0 || count != getV(id).length) {
			return errorPormt(id, "姓名必须是中文或英文组成!");
		}
	}
	return true;
}

/**
 * @see 判断文件域中选择的是否为图片
 * @param id 文件域的ID
 * @param isMustPut 是否为必选项(1表示必选,0表示不是必选) 
 * @return boolean
 */
function isImgFile(id, isMustPut) {
	if (isMustPut == "1" || (isMustPut == "0" && getV(id) != "")) {
		var isImg = false;
		var array = new Array(".jpg", ".gif", ".png", ".bmp", ".jpeg");
		var ext = (getV(id) != "") ? getV(id).substring(getV(id).lastIndexOf(".")) : "";
		for (var i = 0; i < array.length; i++) {
			if (ext.toLowerCase() == array[i]) {
				isImg = true;
				break;
			}
		}
		if (!isImg) {
			errorPormt(id, "请选择一张图片");
		}
		return isImg;
	}
	return true;
}

/**
* @see 验证登录用户名是否通过
* @param id 用户名框的ID
* @return boolean
*/
function isUserName(id) {
	var text = "账号", minLength = 3;
	return checkNull(id, text) && checkMinLength(id, text, minLength) && notHaveChar(id, text);
}

/**
* @see 验证密码是否通过
* @param id 密码框的ID
* @return boolean
*/
function isPassword(id) {
	var text = "密码";
	return checkNull(id, text) && checkMinLength(id, text, 6) && notOnlyOne(id, text) && notAllNo(id, text) && notBlank(id, text);
}

/**
* @see 验证确认密码是否通过
* @param id 确认密码框的ID
* @param pwdId 密码框的ID
* @return boolean
*/
function isQuePwd(id, pwdId) {
	var text = "确认密码";
	if (!checkNull(id, text)) {
		return false;
	}
	if (getV(pwdId) != getV(id)) {
		return errorPormt(id, "两次输入的密码不一致!");
	}
	return true;
}

/**
* @see 判断是否为中文
* @param value 简要操作的值
* @return boolean
*/ 
function isChinese(value) {
  	var reg = /[^\u4E00-\u9FA5]/g; 
  	if (reg.test(value)) { 
    	return false;
  	} 
  	return true; 
}

/**
 * @see 判断是否为英文
 * @param value 简要操作的值
 * @return boolean
 */
function isEnglish(value) {
	var chars = "abcdefghijklmnopqrstuvwxyz";
	var result = true;
	for ( var i = 0; i < value.length; i++) {
		if (chars.indexOf(value.substring(i, i + 1).toLowerCase()) == -1) {
			result = false;
			break;
		}
	}
	return result;
}

/**
 * @see 建立一个xmlHttp(兼容的浏览器:IE6,IE7,IE8,火狐,谷歌,360)
 */
var xmlHttp = false;
function createXmlHttp() {
	if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
		if (xmlHttp.overrideMimeType) {
			xmlHttp.overrideMimeType("text/xml");
		}
	} else {
		if (window.ActiveXObject) {
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
	}
	if (!xmlHttp) {
		window.alert("请使用IE浏览器!");
	}
}

/**
 * @see 发送ajax请求
 * @param url 需要访问的url(需要清理缓存,比如："?random="+Math.random() )
 * @param method 回调的方法
 */
function sendRequest(url, method) {
	createXmlHttp();
	xmlHttp.onreadystatechange = eval(method);
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}

/**
 * @see 获得当前日期
 * @param type 1为所有内容,2为一串数字,3为日期部分,4为中文日期
 * @return String
 */
function getNowDate(type) {
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var day = date.getDate();
	var hour = date.getHours();
	var minute = date.getMinutes();
	var second = date.getSeconds();
	if (type == "1") {
		return year + "-" + disposeDate(month) + "-" + disposeDate(day) + " "
				+ disposeDate(hour) + ":" + disposeDate(minute) + ":" + disposeDate(second);
	} else if (type == "2") {
		return year + "" + month + "" + day + "" + hour + "" + minute + "" + second;
	} else if (type == "3") {
		return year + "-" + disposeDate(month) + "-" + disposeDate(day);
	} else {
		return year + "年" + month + "月" + day + "日";
	}
}

/**
 * @see 处理日期
 * @param monthOrDay 日期时间的一个数值(补齐两位数,不足加0)
 * @return String
 */
function disposeDate(monthOrDay) {
	if (parseInt(monthOrDay) < 10) {
		return "0" + monthOrDay;
	} else {
		return monthOrDay;
	}
}

/**
* @see js对日期中的月份和日份的处理(比如:01处理后得到1)
* @param monthOrDay 月份或日份
* @return int
*/
function getDateNum(monthOrDay) {
  	if(monthOrDay.substring(0, 1) == "0"){
    	return parseInt(monthOrDay.substring(1, 2));
  	}
	return parseInt(monthOrDay);
}

/**
* @see 根据年份和月份获得当月天数
* @param year 年份
* @param month 月份
* @return int
*/
function getDayNum(year, month) {
  	var days = 31;
  	if (month == 4 || month == 6 || month == 9 || month == 11) {
		days = 30;
  	}
  	if (month == 2) {
		if (year % 4 == 0) {
	  		days = 29;
		} else {
	  		days = 28;
		}
  	}
  	return days;
}

/**
 * @see 获得表单元素或其他元素的绝对坐标(xy用分号隔开)
 * @param id 表单元素或其他元素的id
 * @return String
 */
function getAbsPoint(id) {
	var object = getO(id);
	var x = object.offsetLeft, y = object.offsetTop;
	while (object = object.offsetParent) {
		x += object.offsetLeft;
		y += object.offsetTop;
	}
	return x + ";" + y;
}

/**
 * @see 鼠标点击拖拽的效果(页面可以同时拖动多个框)
 * @param boxId 整个对象(框)的id(一般为div或table)
 * @param event 内置对象(必须传入)
 */
function mousePlead1(event, boxId) {
	var o = getO(boxId);
	var isIE = document.all ? true : false;
	var e = event;
	var x = e.offsetX || e.layerX;
	var y = e.offsetY || e.layerY;
	document.onmousemove = function(e) {
		o.style.filter = 'Alpha(opacity=70)';
		o.style.opacity = '0.7';
		if (isIE) {
			o.setCapture();
		} else {
			window.captureEvents(Event.MOUSEMOVE);
		}
		var e = window.event || e;
		o.style.left = (e.clientX - x) + "px";
		o.style.top = (e.clientY - y) + "px";
		if (getO("divErrorMsg") != null) {
			showDiv("divErrorMsg", "0");
		}
	};
	document.onmouseup = function(e) {
		document.onmousemove = function() {
		};
		if (isIE) {
			o.releaseCapture();
		} else {
			window.releaseEvents(o.MOUSEMOVE);
		}
		o.style.filter = "";
		o.style.opacity = "";
	};
}

/**
 * @see 获得当前窗体的大小(用分号隔开)
 * @return String 
 */
function getWinSize() {
	var width = document.documentElement.clientWidth;
	var height = document.documentElement.clientHeight;
	return width + ";" + height;
}

/**
 * @see 产生一颗树形菜单(两个参数)
 * @param div div的ID(这棵树要放在哪个div中,你说了算)
 * @param treeData 树的数据源(必须是json格式,必须有一个根节点)
 * @param 树节点的属性如下：id和name是必须的要的,其它属性可以没有
 * @property id表示数的节点id,每个节点的id必须是唯一的
 * @property name表示树的节点名称
 * @property remark表示树的节点的描述
 * @property open表示该节点的子节点的显示状态,1展开子节点,0隐藏子节点
 * @property url表示节点的链接地址
 * @property target表示节点链接地址的框架,和url一起使用
 * @property click表示节点的点击事件(注意:click和url不要一起使用,如果一起使用了,该节点只会加载url)
 * @property box表示节点是否带有复选框,1为有(id为ckbTreeNode+id),0为无
 * @property pick表示复选框的选中状态,和box一起使用,1为选中,0为不选中
 * @property childs表示子节点集合 
 * @param 命名规范：hdf为前缀的表示隐藏域,img为前缀的表示图标,div为前缀的表示节点div
 * @criterion id为hdfTreeIds的隐藏域中存放了所有节点的ID,用';'隔开
 * @criterion id为hdfPickTreeId的隐藏域中存放了当前选择的节点ID
 * @criterion id为hdfParentIdAndIsLast+id的隐藏域中存放了该节点的父节点ID和父节点是否为末节点(1是,0不是),用':'隔开,多级父节点用';'隔开
 * @criterion id为hdfTreeChildIds+id的隐藏域中存放了该节点的子节点ID,多个子节点ID用';'隔开
 * @criterion id为hdfTreeDepth+id的隐藏域中存放了该节点的深度,根节点的深度为0,依次类推
 * @criterion id为imgTreeIcon+id的的图标表示该节点的状态(展开或隐藏)
 * @criterion id为imgTreeFolder+id的的图标表示该节点的文件夹状态(展开或隐藏)
 * @criterion id为divTreeText+id的的div展现该节点的name属性值
 * @criterion id为divTreeChilds+id的的div中包括了该节点的所有子节点
 */
function bringTree(div, treeData) {
	if (treeData != "" && getO(div) != null) {
		fullDiv(div, "");
		getO(div).style.fontSize="12px";
		var root = eval("(" + treeData + ")");
		createFormUnit("", "hdfPickTreeId", "hidden", "");// 用来存放当前选择的节点ID
		createFormUnit("", "hdfTreeIds", "hidden", root.id);// 用来存放所有节点的ID,用;隔开
		if (root != null && root.length == null) {// 单个根节点
			bringTree1(div, root);
		}
		if (root != null && root.length != null && root.length > 0) {// 多个根节点只取第一个
			bringTree1(div, root[0]);
		}
	}
}
function bringTree1(div, root) {
	/** ====开始加载根节点===== */
	var rootDiv = document.createElement("div");// 根节点div
	rootDiv.style.height = "18px";// 所有元素为统一高度18px
	getO(div).appendChild(rootDiv);// 根节点div被加入
	var rootIcon = plus_root, rootFolder = folder_close, rootTitle = "展开 ";// 根节点的加减图标，文件夹图标，图标提示标题
	if (root.open != null && root.open == "1") {
		rootIcon = minus_root;// 加减图标为减号状态
		rootFolder = folder_open;// 文件夹图标为打开状态
		rootTitle = "隐藏 ";// 图标提示标题为隐藏ss
	}
	var rootIconImg = '<img src="' + getV("hdfPath") + rootIcon + '" onclick="showTreeChild(this)" id="imgTreeIcon' + root.id + 
		'" style="cursor:pointer;vertical-align:middle;" title="' + rootTitle + root.name + '" />';
	var rootFolderImg = '<img src="' + getV("hdfPath") + rootFolder + '" id="imgTreeFolder' + root.id + '" style="vertical-align:middle;" />';
	setTreeNodeHtml(rootIconImg, rootFolderImg, root, rootDiv, "", 0);
	/** ====根节点加载完毕===== */	
	/** ====开始加载子节点===== */
	var childsDiv = document.createElement("div");// 所有子节点被包含在这个div中
	childsDiv.setAttribute("id", "divTreeChilds" + root.id);
	childsDiv.style.display = (root.open == "1") ? "block" : "none";
	childsDiv.style.paddingLeft = "18px";
	getO(div).appendChild(childsDiv);
	var childs = root.childs;// 根节点的子节点集合
	var parentId = "", childIds = "", depth = "0", isLast = "1";
	if (childs != null && childs.length > 0) {
		for ( var i = 0; i < childs.length; i++) {
			childIds += childs[i].id;// 根节点的子节点ID集合
			if (i != childs.length - 1) {
				childIds += ";";
			}
		}
		createFormUnit("", "hdfParentIdAndIsLast" + root.id, "hidden", parentId + ":" + isLast);// 存放根节点的父节点ID和父节点是否为末节点
		createFormUnit("", "hdfTreeChildIds" + root.id, "hidden", childIds);// 存放根节点的子节点ID
		createFormUnit("", "hdfTreeDepth" + root.id, "hidden", depth);// 存放根节点的节点深度
		for ( var i = 0; i < childs.length; i++) {
			var childIcon = plus_center, childIsLast = "0";// 子节点的加减图标, 子节点是否为末节点
			if (i == childs.length - 1) {
				childIcon = plus_bottom;
				childIsLast = "1";
			}
			bringTree2(childs[i], childsDiv, childIcon, childIsLast, root.id + ":" + isLast, depth, div);// 递归
		}
	}
}
function bringTree2(treeObject, childItemDiv, childIcon, isLastNode, parentIdAndIsLast, parentDepth, div) {
	setV("hdfTreeIds", getV("hdfTreeIds") + ";" + treeObject.id);// 继续存放所有节点的ID
	createFormUnit("", "hdfParentIdAndIsLast" + treeObject.id, "hidden", parentIdAndIsLast);// 存放当前节点父节点ID和父节点是否为末节点
	createFormUnit("", "hdfTreeDepth" + treeObject.id, "hidden", parseInt(parentDepth) + 1);// 存放当前节点的节点深度
	/** ====开始加载当前节点===== */
	var childDiv = document.createElement("div");// 当前节点div
	childDiv.style.height = "18px";
	childItemDiv.appendChild(childDiv);
	var lineHtml = "";// 当前节点左边该填充的空白图片和线形图片
	var parentIds = parentIdAndIsLast.split(";");// parentIds.length 表示当前节点的所有父节点的数组长度
	for ( var i = 1; i < parentIds.length; i++) {
		if (parentIds[i].split(":")[1] == "1") {
			lineHtml += '<img src="' + getV("hdfPath") + tree_blank + '" style="vertical-align:middle;"/>';
		} else {
			lineHtml += '<img src="' + getV("hdfPath") + line_conn + '" style="vertical-align:middle;"/>';
		}
	}
	var childs = treeObject.childs;// 当前节点子节点
	if (childs != null && childs.length > 0) {// 如果当前节点存在子节点
		var childFolder = folder_close, childTitle = "展开 ";// 当前节点的文件夹图标，图标提示标题
		if (treeObject.open != null && treeObject.open == "1") {
			childFolder = folder_open;
			childTitle = "隐藏 ";
		}
		if (treeObject.open != null && treeObject.open == "1") {
			if (childIcon == plus_center) {
				childIcon = minus_center;// 当前节点的加减图标
			} else {
				childIcon = minus_bottom;
			}
		}
		var iconImg = '<img src="' + getV("hdfPath") + childIcon + '" id="imgTreeIcon' + treeObject.id + 
			'" style="cursor:pointer;vertical-align:middle;" onclick="showTreeChild(this)" title="' + childTitle + treeObject.name + '" />';
		var folderImg = '<img src="' + getV("hdfPath") + childFolder + '" id="imgTreeFolder' + treeObject.id + '" style="vertical-align:middle;" />';
		setTreeNodeHtml(iconImg, folderImg, treeObject, childDiv, lineHtml, ((parentIds.length - 1) * 18));
		/** ====当前节点加载完毕===== */
		/** ====开始加载当前节点的子节点===== */
		var childsDiv = document.createElement("div");// 当前节点的所有子节点被包含在这个div中
		childsDiv.setAttribute("id", "divTreeChilds" + treeObject.id);
		childsDiv.style.display = (treeObject.open == "1") ? "block" : "none";
		childItemDiv.appendChild(childsDiv);
		var childIds = "";
		for ( var i = 0; i < childs.length; i++) {
			childIds += childs[i].id;
			if (i != childs.length - 1) {
				childIds += ";";
			}
		}
		createFormUnit("", "hdfTreeChildIds" + treeObject.id, "hidden", childIds);// 存放当前节点的子节点ID
		for ( var i = 0; i < childs.length; i++) {
			var childItemIcon = plus_center, childIsLast = "0";
			if (i == childs.length - 1) {
				childItemIcon = plus_bottom;
				childIsLast = "1";
			}
			bringTree2(childs[i], childsDiv, childItemIcon, childIsLast, parentIdAndIsLast + ";" + treeObject.id + ":" + isLastNode, parseInt(parentDepth) + 1, div);// 递归
		}
	} else {// 当前节点已经没有子节点
		childIcon = (isLastNode == "1") ? line_bottom : line_center;
		var iconImg = '<img src="' + getV("hdfPath") + childIcon + '" style="vertical-align:middle;" />';
		var folderImg = '<img src="' + getV("hdfPath") + tree_page + '" style="vertical-align:middle;" />';
		setTreeNodeHtml(iconImg, folderImg, treeObject, childDiv, lineHtml, ((parentIds.length - 1) * 18));
		createFormUnit("", "hdfTreeChildIds" + treeObject.id, "hidden", "");
	}
}

/**
 * @see 产生一颗树形菜单(支持异步加载)
 * @param div div的ID(这棵树要放在哪个div中,你说了算)
 * @param treeData 树的数据源(必须是json格式,必须有一个根节点)
 * @param callback 异步加载的回调事件, 示例：function getChildJson() {region.getJson(getV("hdfPickTreeId"), function(json) {createTree3(json);});}
 *        其中getV("hdfPickTreeId")是获得当前节点的ID，createTree3(json)是必须的，getChildJson()就是回调事件了。
 * @param 树节点的属性如下：id和name是必须的要的,其它属性可以没有
 * @property id表示数的节点id,每个节点的id必须是唯一的
 * @property name表示树的节点名称
 * @property remark表示树的节点的描述
 * @property url表示节点的链接地址
 * @property target表示节点链接地址的框架,和url一起使用
 * @property childs表示子节点集合 
 * @param 命名规范：hdf为前缀的表示隐藏域,img为前缀的表示图标,div为前缀的表示节点div
 * @criterion id为hdfPickTreeId的隐藏域中存放了当前选择的节点ID
 * @criterion id为hdfTreeCallback的隐藏域中存放了异步加载的回调时间名称
 * @criterion id为hdfParentIdAndIsLast+id的隐藏域中存放了该节点的父节点ID和父节点是否为末节点(1是,0不是),用':'隔开,多级父节点用';'隔开
 * @criterion id为hdfTreeChildIds+id的隐藏域中存放了该节点的子节点ID,多个子节点ID用';'隔开
 * @criterion id为hdfTreeDepth+id的隐藏域中存放了该节点的深度,根节点的深度为0,依次类推
 * @criterion id为imgTreeIcon+id的的图标表示该节点的状态(展开或隐藏)
 * @criterion id为imgTreeFolder+id的的图标表示该节点的文件夹状态(展开或隐藏)
 * @criterion id为divTreeText+id的的div展现该节点的name属性值
 * @criterion id为divTreeChilds+id的的div中包括了该节点的所有子节点
 */
function createTree(div, treeData, callback) {
	if (treeData != "" && getO(div) != null) {
		fullDiv(div, "");
		getO(div).style.fontSize="12px";
		createFormUnit("", "hdfPickTreeId", "hidden", "");// 用来存放当前选择的节点ID
		createFormUnit("", "hdfTreeCallback", "hidden", callback);// 用来存放异步加载的事件名称
		var root = eval("(" + treeData + ")");
		if (root != null && root.length == null) {// 单个根节点
			createTree1(div, root);
		}
		if (root != null && root.length != null && root.length > 0) {// 多个根节点只取第一个
			createTree1(div, root[0]);
		}
	}
}
function createTree1(div, root) {
	/** ====开始加载根节点===== */
	var rootDiv = document.createElement("div");// 根节点div
	rootDiv.style.height = "18px";// 所有元素为统一高度18px
	getO(div).appendChild(rootDiv);// 根节点div被加入
	var rootIcon = minus_root, rootFolder = folder_open, rootTitle = "隐藏 ";// 根节点的加减图标，文件夹图标，图标提示标题
	var rootIconImg = '<img src="' + getV("hdfPath") + rootIcon + '" onclick="showTreeChild(this)" id="imgTreeIcon' + root.id + 
		'" style="cursor:pointer;vertical-align:middle;" title="' + rootTitle + root.name + '" />';
	var rootFolderImg = '<img src="' + getV("hdfPath") + rootFolder + '" id="imgTreeFolder' + root.id + '" style="vertical-align:middle;" />';
	setTreeNodeHtml(rootIconImg, rootFolderImg, root, rootDiv, "", 0);
	/** ====根节点加载完毕===== */	
	/** ====开始加载子节点===== */
	createFormUnit("", "hdfParentIdAndIsLast" + root.id, "hidden", ":1");// 存放根节点的父节点ID和父节点是否为末节点
	createFormUnit("", "hdfTreeDepth" + root.id, "hidden", "0");// 存放根节点的节点深度
	var childsDiv = document.createElement("div");// 所有子节点被包含在这个div中
	childsDiv.setAttribute("id", "divTreeChilds" + root.id);
	childsDiv.style.display = "block";
	childsDiv.style.paddingLeft = "18px";
	getO(div).appendChild(childsDiv);
	var childs = root.childs;// 根节点的子节点集合
	if (childs != null && childs.length > 0) {
		var childIds = "";// 根节点的子节点ID集合
		for ( var i = 0; i < childs.length; i++) {
			childIds += childs[i].id;
			if (i != childs.length - 1) {
				childIds += ";";
			}
		}
		createFormUnit("", "hdfTreeChildIds" + root.id, "hidden", childIds);// 存放根节点的子节点ID
		for ( var i = 0; i < childs.length; i++) {
			var childIcon = plus_center, childIsLast = "0";// 子节点的加减图标, 子节点是否为末节点
			if (i == childs.length - 1) {
				childIcon = plus_bottom;
				childIsLast = "1";
			}
			createTree2(childs[i], childsDiv, childIcon, childIsLast, root.id + ":1", 0);// 递归
		}
	}
}
function createTree2(treeObject, childItemDiv, childIcon, isLastNode, parentIdAndIsLast, parentDepth) {
	/** ====开始加载当前节点===== */
	createFormUnit("", "hdfParentIdAndIsLast" + treeObject.id, "hidden", parentIdAndIsLast);// 存放当前节点父节点ID和父节点是否为末节点
	createFormUnit("", "hdfTreeDepth" + treeObject.id, "hidden", parseInt(parentDepth) + 1);// 存放当前节点的节点深度
	var childDiv = document.createElement("div");// 当前节点div
	childDiv.style.height = "18px";
	childItemDiv.appendChild(childDiv);
	var childsDiv = document.createElement("div");// 当前节点的所有子节点被包含在这个div中
	childsDiv.setAttribute("id", "divTreeChilds" + treeObject.id);
	childsDiv.style.display = "block";
	childItemDiv.appendChild(childsDiv);
	var lineHtml = "";// 当前节点左边该填充的空白图片和线形图片
	var parentIds = parentIdAndIsLast.split(";");// parentIds.length 表示当前节点的所有父节点的数组长度
	for ( var i = 1; i < parentIds.length; i++) {
		if (parentIds[i].split(":")[1] == "1") {
			lineHtml += '<img src="' + getV("hdfPath") + tree_blank + '" style="vertical-align:middle;"/>';
		} else {
			lineHtml += '<img src="' + getV("hdfPath") + line_conn + '" style="vertical-align:middle;"/>';
		}
	}
	var childs = treeObject.childs;// 当前节点子节点
	if (childs != null && childs.length > 0) {// 如果当前节点存在子节点
		var childFolder = folder_close, childTitle = "展开 ";// 当前节点的文件夹图标，图标提示标题
		if (childIcon == plus_center) {
			childIcon = minus_center;// 当前节点的加减图标
		} else {
			childIcon = minus_bottom;
			childFolder = folder_open;
			childTitle = "隐藏 ";
		}
		var iconImg = '<img src="' + getV("hdfPath") + childIcon + '" id="imgTreeIcon' + treeObject.id + 
			'" style="cursor:pointer;vertical-align:middle;" onclick="showTreeChild(this)" title="' + childTitle + treeObject.name + '" />';
		var folderImg = '<img src="' + getV("hdfPath") + childFolder + '" id="imgTreeFolder' + treeObject.id + '" style="vertical-align:middle;" />';
		setTreeNodeHtml(iconImg, folderImg, treeObject, childDiv, lineHtml, ((parentIds.length - 1) * 18));
		/** ====当前节点加载完毕===== */
		/** ====开始加载当前节点的子节点===== */
		var childIds = "";
		for ( var i = 0; i < childs.length; i++) {
			childIds += childs[i].id;
			if (i != childs.length - 1) {
				childIds += ";";
			}
		}
		createFormUnit("", "hdfTreeChildIds" + treeObject.id, "hidden", childIds);// 存放当前节点的子节点ID
		for ( var i = 0; i < childs.length; i++) {
			var childItemIcon = plus_center, childIsLast = "0";
			if (i == childs.length - 1) {
				childItemIcon = plus_bottom;
				childIsLast = "1";
			}
			createTree2(childs[i], childsDiv, childItemIcon, childIsLast, parentIdAndIsLast + ";" + treeObject.id + ":" + isLastNode, parseInt(parentDepth) + 1);// 递归
		}
	} else {// 当前节点已经没有子节点
		var iconImg = '<img src="' + getV("hdfPath") + childIcon + '" id="imgTreeIcon' + treeObject.id + '" title="展开 ' + treeObject.name + 
			'" style="cursor:pointer;vertical-align:middle;" onclick="pickTreeText(\'' + treeObject.id + '\');' + getV("hdfTreeCallback") + '" />';
		var folderImg = '<img src="' + getV("hdfPath") + folder_close + '" id="imgTreeFolder' + treeObject.id + '" style="vertical-align:middle;" />';
		setTreeNodeHtml(iconImg, folderImg, treeObject, childDiv, lineHtml, ((parentIds.length - 1) * 18));
	}
}
function createTree3(json) {
	var treeId = getV("hdfPickTreeId");
	if (getO("divTreeChilds" + treeId).innerHTML != "") {
		showTreeChild(getO("imgTreeIcon" + treeId));
	} else {
		if (json != null && json != "") {
			var childs = eval("(" + json + ")");
			var childIds = "";
			for ( var i = 0; i < childs.length; i++) {
				childIds += childs[i].id;
				if (i != childs.length - 1) {
					childIds += ";";
				}
			}
			createFormUnit("", "hdfTreeChildIds" + treeId, "hidden", childIds);// 存放当前节点的子节点ID
			var parentIdArray = getV("hdfParentIdAndIsLast" + treeId).split(";");
			var parentChildIdArray = getV("hdfTreeChildIds" + parentIdArray[parentIdArray.length - 1].split(":")[0]).split(";");
			var isLastNode = (parentChildIdArray[parentChildIdArray.length - 1] == treeId) ? "1" : "0";
			for ( var i = 0; i < childs.length; i++) {
				var childItemIcon = plus_center, childIsLast = "0";
				if (i == childs.length - 1) {
					childItemIcon = plus_bottom;
					childIsLast = "1";
				}
				createTree2(childs[i], getO("divTreeChilds" + treeId), childItemIcon, childIsLast, 
					getV("hdfParentIdAndIsLast" + treeId) + ";" + treeId + ":" + isLastNode, parseInt(getV("hdfTreeDepth" + treeId)) + 1);
			}
			if (getO("imgTreeIcon" + treeId).src.indexOf("plus_center") != -1) {
				getO("imgTreeIcon" + treeId).src = getV("hdfPath") + minus_center;
			}
			if (getO("imgTreeIcon" + treeId).src.indexOf("plus_bottom") != -1) {
				getO("imgTreeIcon" + treeId).src = getV("hdfPath") + minus_bottom;
			}
			var title = getO("imgTreeIcon" + treeId).title;
			title = title.substring(3, title.lenght);
			getO("imgTreeIcon" + treeId).title = "隐藏 " + title;
			getO("imgTreeFolder" + treeId).src = getV("hdfPath") + folder_open;
		} else {
			if (getO("imgTreeIcon" + treeId).src.indexOf("plus_center") != -1) {
				getO("imgTreeIcon" + treeId).src = getV("hdfPath") + line_center;
			}
			if (getO("imgTreeIcon" + treeId).src.indexOf("plus_bottom") != -1) {
				getO("imgTreeIcon" + treeId).src = getV("hdfPath") + line_bottom;
			}
			getO("imgTreeIcon" + treeId).style.cursor = "auto";
			getO("imgTreeIcon" + treeId).onclick = function() {};
			getO("imgTreeFolder" + treeId).src = getV("hdfPath") + tree_page;
		}
	}
}
var folder_close = tree_folder + "folder_close.gif";
var folder_open = tree_folder + "folder_open.gif";
var line_bottom = tree_folder + "line_bottom.gif";
var line_center = tree_folder + "line_center.gif";
var line_conn = tree_folder + "line_conn.gif";
var minus_bottom = tree_folder + "minus_bottom.gif";
var minus_center = tree_folder + "minus_center.gif";
var minus_root = tree_folder + "minus_root.gif";
var plus_bottom = tree_folder + "plus_bottom.gif";
var plus_center = tree_folder + "plus_center.gif";
var plus_root = tree_folder + "plus_root.gif";
var tree_page = tree_folder + "tree_page.gif";
var tree_blank = tree_folder + "tree_blank.gif";
function setTreeNodeHtml(iconImg, folderImg, treeObject, treeDiv, lineHtml, lineTdWidth) {
	var treeBox = '';// 当前节点所带的复选框
	if (treeObject.box != null && treeObject.box == "1") {
		var treeBoxChecked = (treeObject.pick != null && treeObject.pick == "1") ? 'checked="checked"' : '';// 判断当前节点复选框是否被选中
		var treeBoxStyle = document.all ? 'style="width:18px;height:18px;vertical-align:middle;"' : 'style="width:auto;height:auto;vertical-align:middle;"';
		treeBox = '<input type="checkbox" id="ckbTreeNode' + treeObject.id + '" ' + treeBoxChecked  + treeBoxStyle + ' onclick="pickTreeNode(this)" />';
	}
	var treeRemark = (treeObject.remark != null && treeObject.remark != "") ? treeObject.remark : '';// 当前节点提示标题
	var treeUrl = treeObject.name;// 当前节点的链接地址
	if (treeObject.url != null && treeObject.url != "") {
		var treeTarget = (treeObject.target != null && treeObject.target != "") ? 'target="' + treeObject.target + '"' : '';
		treeUrl = '<a href="' + treeObject.url + '" ' + treeTarget + '>' + treeObject.name + '</a>';// 加载链接
	} else if (treeObject.click != null && treeObject.click != "") {
		treeUrl = '<a href="javascript:' + treeObject.click + '">' + treeObject.name + '</a>';// 加载单击事件
	}
	var treeLabel = '<label id="divTreeText' + treeObject.id + '" title="' + treeRemark + 
		'" onclick="pickTreeText(\'' + treeObject.id + '\')" style="height:18px;padding-left:2px;padding-right:2px;background-color:#FFFFFF;cursor:pointer;">' + treeUrl + '</label>';
	if (lineHtml != "" && lineTdWidth > 0) {
		treeDiv.innerHTML = '<table ' + (treeBox != '' ? 'width="300"' : 'width="200"') + ' cellpadding="0" cellspacing="0" border="0" align="left"><tr><td height="18" width="' + 
			lineTdWidth + '">' + lineHtml + '</td><td width="18">' + iconImg +  '</td><td width="18">' + folderImg + 
			'</td>' + (treeBox != '' ? '<td width="18">' + treeBox + '</td>' : '') + '<td>' + treeLabel + '</td></tr></table>';
	} else {
		treeDiv.innerHTML = '<table ' + (treeBox != '' ? 'width="300"' : 'width="200"') + ' cellpadding="0" cellspacing="0" border="0" align="left"><tr><td height="18" width="18">' + iconImg + 
			'</td><td width="18">' + folderImg + '</td>' + (treeBox != '' ? '<td width="18">' + treeBox + '</td>' : '') + '<td>' + treeLabel + '</td></tr></table>';
	}
}
function pickTreeText(treeId) {
	if (getO("divTreeText" + getV("hdfPickTreeId")) != null) {
		getO("divTreeText" + getV("hdfPickTreeId")).style.backgroundColor = "#FFFFFF";
	}
	getO("divTreeText" + treeId).style.backgroundColor = "#FFCC99";
	setV("hdfPickTreeId", treeId);
}
function pickTreeNode(nodeCkb) {
	var treeId = nodeCkb.id.substring(11, nodeCkb.id.length);
	var parentIds = getV("hdfParentIdAndIsLast" + treeId).split(";");
	for ( var i = parentIds.length - 1; i >= 0; i--) {
		var parentId = parentIds[i].split(":")[0];
		if (getO("ckbTreeNode" + parentId) != null) {
			if (getO("ckbTreeNode" + treeId).checked) {
				getO("ckbTreeNode" + parentId).checked = true;
			} else {
				var paterChildIds = getV("hdfTreeChildIds" + parentId).split(";");
				var isPick = false;
				for ( var j = 0; j < paterChildIds.length; j++) {
					if (getO("ckbTreeNode" + paterChildIds[j]).checked) {
						isPick = true;
						break;
					}
				}
				getO("ckbTreeNode" + parentId).checked = isPick;
			}
		}
	}
	var childIds = getV("hdfTreeChildIds" + treeId).split(";");
	for ( var i = 0; i < childIds.length; i++) {
		if (getO("ckbTreeNode" + childIds[i]) != null) {
			getO("ckbTreeNode" + childIds[i]).checked = getO("ckbTreeNode" + treeId).checked;
			pickTreeNode1(childIds[i]);
		}
	}
}
function pickTreeNode1(treeId) {
	var childIds = getV("hdfTreeChildIds" + treeId).split(";");
	for ( var i = 0; i < childIds.length; i++) {
		if (getO("ckbTreeNode" + childIds[i]) != null) {
			getO("ckbTreeNode" + childIds[i]).checked = getO("ckbTreeNode" + treeId).checked;
			pickTreeNode1(childIds[i]);
		}
	}
}
function showTreeChild(iconImg) {
	var treeId = iconImg.id.substring(11, iconImg.id.length);
	var type = "";
	if (getO("divTreeChilds" + treeId).style.display == "none") {
		type = "1";
	} else {
		type = "0";
	}
	showTreeChildDiv(treeId, type);
}
function showTreeChildDiv(treeId, type) {
	var iconPath = getO("imgTreeIcon" + treeId).src;
	var iconName = iconPath.substring(iconPath.lastIndexOf("/"));
	var plusCenterName = plus_center.substring(plus_center.lastIndexOf("/"));
	var minusCenterName = minus_center.substring(minus_center.lastIndexOf("/"));
	if ((iconName == plusCenterName) || (iconName == minusCenterName)) {
		if (type == "1") {
			iconPath = minus_center;
		} else {
			iconPath = plus_center;
		}
	}
	var plusBottomName = plus_bottom.substring(plus_bottom.lastIndexOf("/"));
	var minusBottomName = minus_bottom.substring(minus_bottom.lastIndexOf("/"));
	if ((iconName == plusBottomName) || (iconName == minusBottomName)) {
		if (type == "1") {
			iconPath = minus_bottom;
		} else {
			iconPath = plus_bottom;
		}
	}
	var plusRootName = plus_root.substring(plus_root.lastIndexOf("/"));
	var minusRootName = minus_root.substring(minus_root.lastIndexOf("/"));
	if ((iconName == plusRootName) || (iconName == minusRootName)) {
		if (type == "1") {
			iconPath = minus_root;
		} else {
			iconPath = plus_root;
		}
	}
	getO("imgTreeIcon" + treeId).src = getV("hdfPath") + iconPath;
	var title = getO("imgTreeIcon" + treeId).title;
	title = title.substring(3, title.lenght);
	if (type == "1") {
		showDiv("divTreeChilds" + treeId, "1");
		getO("imgTreeIcon" + treeId).title = "隐藏 " + title;
		getO("imgTreeFolder" + treeId).src = getV("hdfPath") + folder_open;
	} else {
		showDiv("divTreeChilds" + treeId, "0");
		getO("imgTreeIcon" + treeId).title = "展开 " + title;
		getO("imgTreeFolder" + treeId).src = getV("hdfPath") + folder_close;
	}
}

/**
 * @see 展开或隐藏整棵树
 * @param type 1表示展开,0表示隐藏
 */
function showTree(type) {
	var treeIds = getV("hdfTreeIds").split(";");
	for ( var i = 0; i < treeIds.length; i++) {
		if (getO("divTreeChilds" + treeIds[i]) != null) {
			showTreeChildDiv(treeIds[i], type);
		}
	}
}

/**
 * @see 让树中的所有复选框被选中或不选
 * @param type 1表示选中,0表示不选
 */
function setTreeBox(type) {
	var treeIds = getV("hdfTreeIds").split(";");
	for ( var i = 0; i < treeIds.length; i++) {
		if (getO("ckbTreeNode" + treeIds[i]) != null) {
			getO("ckbTreeNode" + treeIds[i]).checked = (type == "1" ? true : false);
		}
	}
}

/**
 * @see 让树中的一部分复选框被选中
 * @param selectIds 树节点的ID(多个用分号隔开)
 */
function setPartTreeBox(selectIds) {
	setTreeBox("0");
	var selectId = selectIds.split(";");
	for (var i=0; i < selectId.length; i++) {
	  	if (getO("ckbTreeNode" + selectId[i]) != null) {
			getO("ckbTreeNode" + selectId[i]).checked = true;
	  	}
	}
}

/**
 * @see 获得树中选择复选框的节点id(如果有多个值,用分号隔开)
 * @return String 
 */
function getTreeBox() {
	var treeIds = getV("hdfTreeIds").split(";");
	var result = "";
	for ( var i = 0; i < treeIds.length; i++) {
		if (getO("ckbTreeNode" + treeIds[i]) != null && getO("ckbTreeNode" + treeIds[i]).checked) {
			result += treeIds[i] + ";";
		}
	}
	if (result.length > 0) {
		result = result.substring(0, result.length - 1);
	}
	return result;
}

/**
 * @see 获得当前菜单树节点的ID和所有父节点的ID(如果有多个值,用分号隔开)
 * @return String 
 */
function getTreeParentIds() {
	var nodeId = getV("hdfPickTreeId");
	if (getO("hdfParentIdAndIsLast" + nodeId) != null) {
		var parentMenuId = getV("hdfParentIdAndIsLast" + nodeId).split(";");
		var parentIds = "";
		for ( var i = 0; i < parentMenuId.length; i++) {
			parentIds += parentMenuId[i].split(":")[0] + ";";
		}
		if (parentIds.length > 0) {
			parentIds = parentIds + nodeId;
		} else {
			parentIds = nodeId;
		}
		if (parentIds.substring(0, 1) == ";") {
			parentIds = parentIds.substring(1, parentIds.length);
		}
		return parentIds;
	} else {
		return "";
	}
}

/**
* @see 获得cookie里的值
* @param key 键
* @return String
*/
function getCookie(key) {
	var cookieValue = "";
	var search = key + "=";
	if (document.cookie.length > 0) {
		offset = document.cookie.indexOf(search);
		if (offset != -1) {
			offset += search.length;
			end = document.cookie.indexOf(";", offset);
			if (end == -1) {
				end = document.cookie.length;
			}
			cookieValue = unescape(document.cookie.substring(offset, end));
		}
	}
	return cookieValue;
}

/**
* @see 把字符串保存在cookie里
* @param key 键
* @param value 值
*/
function setCookie(key, value) {
	var expire = new Date((new Date()).getTime() + Math.random() * 3600000);
	expire = ";   expires=" + expire.toGMTString();
	document.cookie = key + "=" + escape(value) + expire;
}

/**
* @see 删除cookie里的值
* @param key 键
*/
function delCookie(key) {
	document.cookie = key + "=" + "";
}

/**
* @see 无刷新分页时处理数字输入的函数(封装在后台，使用在前台)
* @param pageIndex 目标页数
*/
function pagination(pageIndex) {
	var radix = getV("txtRadix");
	if (radix == "" || isNaN(radix) || parseInt(radix) < 1 || parseInt(radix) > 30) {
		setV("txtRadix", "20");
	}
	if (pageIndex == "" || isNaN(pageIndex) || parseInt(pageIndex) < 1) {
		pageIndex = "1";
	}
	setV("txtPageIndex", pageIndex);
}