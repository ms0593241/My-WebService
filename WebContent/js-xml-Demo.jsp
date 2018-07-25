<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>


<div id="content"></div>


	<script type="text/javascript">
	// 首先會先寫ㄧ個函式來判斷瀏覽器是否支援 javascript 讀取 XML的功能
		function loadXMLFile(file){
			var xmlDoc;
			// 這ㄧ個判斷式是針對IE，判斷是不是支援ActiveXObject 這個物件
			if(window.ActiveXObject){
				//如果支援這個物件，就建立ㄧ個讀取XML的物件
				xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
				//判斷是否進行異步處理，true代表在瀏覽器送出訊息後即立即更新(就是底下send方法)，false代表在任何情況下，會直接向伺服器提取資料做更新
				xmlDoc.async = false;
				//載入xml檔案
				xmlDoc.load(file);
				//載入後回傳
				return xmlDoc;
			}else if(document.implementation && document.implementation.createDocument){
				// 這個判斷針對飛IE瀏覽器設置，判斷是不是能夠處理DOM模型物件
				//建立ㄧ個讀取XML的物件
				var xmlInfo = new XMLHttpRequest();
				//用GET的方式取回XML資料，第三個參數是判斷是否異步處理，true代表在瀏覽器送出訊息後即立即更新(就是底下send方法)，false代表在任何情況下，會直接向伺服器提取資料做更新
				
				xmlInfo.open("GET", file, false);
				//是否傳回資料，因為這裡不傳送資料給伺服器，因此填上null
				xmlInfo.send(null);
				//把取得的XML回傳
				xmlDoc = xmlInfo.responseXML;
				return xmlDoc;
			}else{
				alert("您的瀏覽器不支援Javascript!! ");
			}
		}
	//瀏覽器載入後執行
	window.onload=function(){
		var xmlFile="getDataSetting.xml";
		//載入指定的xml檔案
		var xmlData=loadXMLFile(xmlFile);
		//取得DOM節點內的值
		var userid = xmlData.getElementsByTagName("userid")[0].firstChild.nodeValue;
     	var userid2 = xmlData.getElementsByTagName("userid")[1].firstChild.nodeValue;
    	var username = xmlData.getElementsByTagName("username")[0].firstChild.nodeValue;
    	var email = xmlData.getElementsByTagName("email")[0].firstChild.nodeValue;
		//下面則是使用innerHTML方法把值放入div內，但是要預先在html檔內先寫入<div id="content"></div> ，javascript才找得到這個div的位置
        document.getElementById('content').innerHTML +='userid = '+userid+'<br>';
        document.getElementById('content').innerHTML +='userid2 = '+userid2+'<br>';
        document.getElementById('content').innerHTML +='username = '+username+'<br>';
        document.getElementById('content').innerHTML +='email = '+email+'<br>';

	}
	</script>
</body>
</html>