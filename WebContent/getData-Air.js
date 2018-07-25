/**
 * 
 */

function doGetData() {
	var xmlFile="getDataSetting.xml";
	//載入指定的xml檔案
	var xmlData=loadXMLFile(xmlFile);
	//取得DOM節點內的值

	var requsetAirUrl = xmlData.getElementsByTagName("Air-url")[0].firstChild.nodeValue;
	//var requsetTRAUrl = xmlData.getElementsByTagName("TRA-url")[0].firstChild.nodeValue;
	var json2;
	$.ajax({
        type: 'GET',
        url: requsetAirUrl, //欲呼叫之API網址(此範例為台鐵車站資料)
        dataType: 'json',
        async : false,
        headers: GetAuthorizationHeader(),
        success: function (Data) {
            //$('body').text(JSON.stringify(Data));
            //document.getElementById("dataID").innerHTML=JSON.stringify(Data);
            json2 = JSON.stringify(Data);
            //json2 = Data;
        }
    });
	return json2;
}

function GetAuthorizationHeader() {
    var AppID = 'FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF';
    var AppKey = 'FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF';

    var GMTString = new Date().toGMTString();
    var ShaObj = new jsSHA('SHA-1', 'TEXT');
    ShaObj.setHMACKey(AppKey, 'TEXT');
    ShaObj.update('x-date: ' + GMTString);
    var HMAC = ShaObj.getHMAC('B64');
    var Authorization = 'hmac username=\"' + AppID + '\", algorithm=\"hmac-sha1\", headers=\"x-date\", signature=\"' + HMAC + '\"';

    return { 'Authorization': Authorization, 'X-Date': GMTString /*,'Accept-Encoding': 'gzip'*/}; //如果要將js運行在伺服器，可額外加入 'Accept-Encoding': 'gzip'，要求壓縮以減少網路傳輸資料量
}


function test() {
	var temp = "Billy";
	return temp;
}
function myFunction(a,b)
{
	return a*b;
}

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
