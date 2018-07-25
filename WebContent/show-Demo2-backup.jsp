<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/emxUIStructureBrowser.css">
<link rel="stylesheet" href="css/emxUIDefault.css">
<link rel="stylesheet" href="css/UIKIT.css">
<meta charset="UTF-8">
<title class="i18n" name='title'></title>
<meta id="i18n_pagename" content="index-common">
<meta name="viewport" content="width=device-width">
<meta name="keywords" content="" />
<meta name="description" content=""/>
</head>
<body>
	
	<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
	<script src="/WebService/dwr/engine.js" type="text/javascript" charset="utf-8"></script>
	<script type='text/javascript' src='/WebService/dwr/interface/API.js'></script>
	<script type='text/javascript' src='/WebService/dwr/util.js'></script>
	<script type="text/javascript" src="sha1.js"></script>
	<script type="text/javascript" src="getData-test.js"></script>
	<script src="jquery.i18n.properties-min.js"></script>
	<!-- 加载语言包文件 -->
    <script src="jquery.i18n.properties.js"></script>
    <script src="language.js"></script>
	<div id ="postToCheckbox" >
	
	</div>
	<form name="emxTableForm">
		<div id="mx_divBody" style="display: block; top: 37px; bottom: 31px;" class="">
			<div id="mx_divTable" style="left: 50px;">
				<div id="mx_divTableHead">
					<table xmlns="http://www.w3.org/1999/xhtml" id="headTable" width="90%">
						<tbody>
							<tr id="table_headTable">

							</tr>
						</tbody>
					</table>
				</div>
				<div id="mx_divTableBody" style="top: 46px;">
					<table xmlns="http://www.w3.org/1999/xhtml" id="bodyTable" width="90%">

						<tbody id="table_dataTable">

						</tbody>
					</table>
				</div>
			</div>
		</div>
	</form>

	<script type="text/javascript">
	function getCheckboxValue(value) {
    	console.log("value: " + value);
        var highestTimeoutId = setTimeout(";");
        for (var i = 0 ; i < highestTimeoutId ; i++) {
        	clearTimeout(i); 
        }    
        dataKeys = value;
		dataKeyList = dataKeys.split(",");
		
		doDemo();
    }
		//var forTable = document.querySelector("#tableID");
		
		var jsonStr = doGetData();
		var jsonObj = JSON.parse(jsonStr);
		//console.log("jsonStr: " + jsonStr);
		var howMuchObjAtOnePage = 7;
		var split = jsonObj.length / howMuchObjAtOnePage;
		var upSplit = Math.ceil(split);
		var reflashTime = 5000;
		var countObj = 0;
		//var reflashTime2 = 0;
		var objStart = 0;
		var objEnd = objStart + howMuchObjAtOnePage - 1;
		var isNeedReflashData = true;

		//var forTable = document.querySelector("#tableID2");

		var headTable = document.querySelector("#table_headTable");
		var dataTable = document.querySelector("#table_dataTable");
		var postToCheckbox = document.querySelector("#postToCheckbox");
		
		

		var jsonlength = jsonObj.length;
		var minus = jsonlength - howMuchObjAtOnePage;

		function isChinese(str) {
			var isChi = true;
			for (var j = 0; j < str.length; j++) {
				if (str.charCodeAt(j) < 0x4E00 || str.charCodeAt(j) > 0x9FA5) {
					isChi = false;
				}
			}
			return isChi;
		}
		var xmlFile = "getDataSetting.xml";
		//載入指定的xml檔案
		var xmlData = loadXMLFile(xmlFile);
		//取得DOM節點內的值
		var dataKeys = xmlData.getElementsByTagName("keyWord")[0].firstChild.nodeValue;
		var dataKeyList = dataKeys.split(",");
		//AirportName.Zh_tw
		var getkeyWord = xmlData.getElementsByTagName("keyid")[0].firstChild.nodeValue;
		//var keyWord = "";
		var keyWord2 = "";
		if (getkeyWord.indexOf(".") > -1) {
			var keyWordArray = getkeyWord.split(".");
			keyWord = keyWordArray[0];
			keyWord2 = keyWordArray[1];
			//console.log("keyWord: " + keyWord + " keyWord2: " + keyWord2);
		} else {
			keyWord = getkeyWord;
			//console.log("keyWord: " + keyWord);
		}
		var buttonURL = "checkbox.jsp?value=" + dataKeys;
		console.log("buttonURL: " + buttonURL);
		var postToCheckboxStr = "<button type='button' class='btn-primary' style='position:relative; left:500px; top: 5px; ' onclick=\"window.open ('"+ buttonURL +"','new window','height=300,width=400,top=250,left=550, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no')\">勾選屬性!</button>";
		console.log("postToCheckboxStr: " + postToCheckboxStr);
		//<button type="button" class="btn-primary" style="position:relative; left:460px; top: 5px; " onclick="window.open ('checkbox.jsp?value=ObservationTime,MetarTime,WindDirection,WindSpeed,Temperature,WeatherDescription.Zh_tw', 'new window', 'height=300, width=400,top=250,left=550, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no')">勾選屬性!</button>
		//<button type="button" class="btn-default" style="position:relative; left:600px; top: 5px; " onclick="location.reload()">還原</button>
		//<button type="button" class="btn-primary" id ="postToCheckbox" style="position:relative; left:460px; top: 5px; " onclick="window.open ('checkbox.jsp?value=ObservationTime,MetarTime,WindDirection,WindSpeed,Temperature,WeatherDescription.Zh_tw', 'new window', 'height=300, width=400,top=250,left=550, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no')">勾選屬性!</button>
		
		postToCheckboxStr += "<button type='button' class='btn-default' style='position:relative; left:600px; top: 5px; ' onclick='location.reload()'>還原</button>";
		postToCheckboxStr += "<label class='i18n' name='lan'></label><select id='language'><option value='zh-CN'>中文简体</option><option value='zh-TW'>中文繁體</option><option value='en'>English</option></select>";
		postToCheckbox.innerHTML = postToCheckboxStr;
		
		
		var xmlFile = "getDataSetting.xml";
		//載入指定的xml檔案
		var xmlData = loadXMLFile(xmlFile);
		//取得DOM節點內的值
		var dataKeys = xmlData.getElementsByTagName("keyWord")[0].firstChild.nodeValue;
		var dataKeyList = dataKeys.split(",");
		
		function doDemo() {
			for (var k = 0; k <= dataKeyList.length; k++) {
				if (k == 0) {
					headtableStr = "<th id='" + keyWord + "'><table><tbody><tr><td id='" + keyWord + "' class='mx_sort-column ' width=''><a href='javascript:sortTable("
					+ k
					+ ")'>"
					+ keyWord
					+ "</a></td></tr></tbody></table></th>";
					
				}else{
					headtableStr += "<th id='" + dataKeyList[k-1] + "'><table><tbody><tr><td id='" + dataKeyList[k-1] + "' class='mx_sort-column ' width=''><a href='javascript:sortTable("
						+ k
						+ ")'>"
						+ dataKeyList[k - 1]
						+ "</a></td></tr></tbody></table></th>";
					console.log("DDDD  k: " + k + " dataKeyList.length: " + dataKeyList.length);	
				}
				if (k != dataKeyList.length) {
					headtableStr += "<th class='mx_sizer'></th>";
				}
			}
			console.log("headtableStr: " + headtableStr);
			headTable.innerHTML = headtableStr;
			
			
			
			
			
			console.log("isNeedReflashData: " + isNeedReflashData);
			if (isNeedReflashData == true) {
				jsonStr = doGetData();
				jsonObj = JSON.parse(jsonStr);

				isNeedReflashData = false;
				objStart = 0;
				objEnd = objStart + howMuchObjAtOnePage - 1;
			}
			console.log("objEnd: " + objEnd + " howMuchObjAtOnePage: " + howMuchObjAtOnePage);
			console.log("jsonlength: " + jsonlength + " countObj: " + countObj);
			if ((objEnd + howMuchObjAtOnePage - 1) < jsonlength
					&& countObj != 0) {
				console.log("AAAAA");
				objStart = objEnd + 1; //7
				objEnd = objStart + howMuchObjAtOnePage - 1; //13
				console.log("objStart: " + objStart + " objEnd: " + objEnd);
			} else if ((objEnd + howMuchObjAtOnePage - 1) >= jsonlength   //
					&& countObj != 0) {
				console.log("BBBB");
				objStart = objEnd + 1; //0 2+3=5
				objEnd = jsonlength - 1; //2 5+3-1=7
				isNeedReflashData = true;
				console.log("isNeedReflashData: " + isNeedReflashData);
			}
			console.log("CCCC");
			dataTable.innerHTML = "";
			//dataStr = "";
			var resultStr = "";
			var key = objStart;
			for (var key; key <= objEnd; key++) {
				countObj++;
				var arrayObj = jsonObj[key];
				var headFiledStr = "";
				if ((countObj % 2 == 0)) {
					headFiledStr = "<tr class='root-node even' height='35'>";
				} else {
					headFiledStr = "<tr class='root-node mx_altRow' height='35'>";
				}
				var isFirst = true;
				var dataStr = "";
				var keyStr = "";

				if (getkeyWord.indexOf(".") > -1) {
					var keyValue = jsonObj[key][keyWord][keyWord2];
					keyStr = "<td title='" + keyWord + "'>" + countObj + "."
							+ keyValue + "</td>";
				} else {
					var keyValue = jsonObj[key][keyWord];
					keyStr = "<td title='" + keyWord + "'>" + keyValue
							+ "</td>";
				}

				for (var j = 0; j < dataKeyList.length; j++) {
					var dataKey = dataKeyList[j];
					if (dataKey.indexOf(".") > -1) {
						var splitObj = dataKey.split(".");
						var LevelOneKey = splitObj[0];
						var LevelTwoKey = splitObj[1];
						var dataValue = jsonObj[key][LevelOneKey][LevelTwoKey];
						var value3 = "";
						dataStr = "<td title='" + LevelOneKey + "'>"
								+ dataValue + "</td>";

					} else {
						var dataValue = jsonObj[key][dataKey];
						dataStr = "<td title='" + dataKey + "'>" + dataValue
								+ "</td>";
					}
					if (isFirst) {
						resultStr = headFiledStr + keyStr + dataStr;
						isFirst = false;
					} else {
						resultStr += dataStr;
					}
				}
				//dataTable.innerHTML += "";
				resultStr += "</tr>";
				dataTable.innerHTML += resultStr;
				if (key == (jsonlength - 1)) {
					//forTable.innerHTML = "";
					countObj = 0;
					objStart = 0;
					objEnd = objStart + howMuchObjAtOnePage - 1;
					isNeedReflashData = true;
				}
			}
			setTimeout(doDemo, reflashTime);
		}

		doDemo();
	</script>

</body>
</html>