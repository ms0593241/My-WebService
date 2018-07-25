/**
 * 
 */

function doGetData() {
	var json2;
	$.ajax({
        type: 'GET',
        url: 'http://ptx.transportdata.tw/MOTC/v2/Rail/TRA/Station?$top=10&$format=JSON', //欲呼叫之API網址(此範例為台鐵車站資料)
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
