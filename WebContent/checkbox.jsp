<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>checkbox</title>
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
	<script type="text/javascript" src="getData-test.js"></script>
	<script src="/WebService/dwr/engine.js" type="text/javascript" charset="utf-8"></script>
	<script type='text/javascript' src='/WebService/dwr/interface/API.js'></script>
	<script type='text/javascript' src='/WebService/dwr/util.js'></script>
	<script type="text/javascript" src="sha1.js"></script>
	<p>Choose your favorite colors .</p>
	
	

<form action="show-Demo2.jsp" method="post" id="checkboxForm">


</form>


	<script type="text/javascript">
	
	function subform(){
		//window.opener.test("fuck");
		
	    var form = document.getElementById('checkboxForm');//获取表单dom
	  	var valueList = "";
	    for(var i=0;i<form.length;i++){
	    	if(form[i].checked){
	        	var value = form[i].value;
	        	valueList += value+",";
	         	//alert(form[i].value+","+form[i].nextSibling.nodeValue);
	       }
	    }
	    valueList = valueList.substring(0, valueList.length-1);
	    //alert("valueList: "  + valueList);
	    //form.action="show-Demo2.jsp";//重新设置提交url
	    //form.submit();//提交表单
	    //window.opener.reload();
	    //window.parent.reload();
	    window.opener.getCheckboxValue(valueList);
	    window.close();//关闭窗口
	   
	}
		var url=window.location.search;
		console.log("url: " + url);
		var urlValue = oneValues(url);
		console.log("urlValue: " + urlValue);
		var checkbox = document.querySelector("#checkboxForm");
		var checkboxStr = "";
		var urlValueList = urlValue.split(",");
		for(var value in urlValueList){
			checkboxStr += "  <input type='checkbox' value='" + urlValueList[value] + "'><h class='i18n' name='" + urlValueList[value] + "'></h><br />";
		}
		checkboxStr += "<input type='button' value='送出表單' onclick='subform();'/>";
		checkbox.innerHTML = checkboxStr;
	</script>

    <!-- 加载语言包文件 -->
    <script src="jquery.i18n.properties.js"></script>
    <script src="language.js"></script>
    
</body>
</html>