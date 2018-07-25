<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/emxUIStructureBrowser.css">
<link rel="stylesheet" href="css/emxUIDefault.css">
<link rel="stylesheet" href="css/UIKIT.css">
</head>
<body>
	<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
	<script src="/WebService/dwr/engine.js" type="text/javascript" charset="utf-8"></script>
	<script type='text/javascript' src='/WebService/dwr/interface/API.js'></script>
	<script type='text/javascript' src='/WebService/dwr/util.js'></script>
	<script type="text/javascript" src="sha1.js"></script>
	<script type="text/javascript" src="getData-Air.js"></script>
	
	<form name="emxTableForm">
		<div id="mx_divBody" style="display: block; top: 37px; bottom: 31px;" class="">
			<div id="mx_divTable" style="left: 50px;">
				<div id="mx_divTableHead">
					<table xmlns="http://www.w3.org/1999/xhtml" id="headTable"  width="90%">
						<tbody>
							
							<tr>
								<th id="AirportName">
									<table>
										<tbody>
											<tr>
												<td id="AirportName" class="mx_sort-column " width="">
													<a href="javascript:sortTable(1)">機場名</a>
												</td>
												
											</tr>
										</tbody>
									</table>
								</th>
								<th class="mx_sizer"></th>
								<th id="ObservationTime" class="mx_editable ">
									<table>
										<tbody>
											<tr>
												<td id="ObservationTime" class="mx_sort-column " width="">
													<a href="javascript:sortTable(2)">觀測時間</a>
												</td>
											</tr>
										</tbody>
									</table>
								</th>
							
								<th class="mx_sizer"></th>
								<th id="MetarTime" class="mx_editable ">
									<table>
										<tbody>
											<tr>
												<td id="MetarTime" class="mx_sort-column " width="">
													<a href="javascript:sortTable(3)">航空例行天氣報告時間</a>
												</td>
											</tr>
										</tbody>
									</table>
								</th>
								<th class="mx_sizer"></th>
								<th id="WindDirection">
									<table>
										<tbody>
											<tr>
												<td id="WindDirection" class="mx_sort-column " width="">
													<a href="javascript:sortTable(4)">風向</a>
												</td>
												
											</tr>
										</tbody>
									</table>
								</th>
								<th class="mx_sizer"></th>
								<th id="WindSpeed">
									<table>
										<tbody>
											<tr>
												<td id="WindSpeed" class="mx_sort-column " width="">
													<a href="javascript:sortTable(5)">風速</a>
												</td>
												
											</tr>
										</tbody>
									</table>
								</th>
								<th class="mx_sizer"></th>
								<th id="Temperature">
									<table>
										<tbody>
											<tr>
												<td id="Temperature" class="mx_sort-column " width="">
													<a href="javascript:sortTable(6)">溫度</a>
												</td>
												
											</tr>
										</tbody>
									</table>
								</th>
								<th class="mx_sizer"></th>
								<th id="WeatherDescription">
									<table>
										<tbody>
											<tr>
												<td id="WeatherDescription" class="mx_sort-column " width="">
													<a href="javascript:sortTable(7)">天氣描述</a>
												</td>
												
											</tr>
										</tbody>
									</table>
								</th>
								
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
		//var forTable = document.querySelector("#tableID");
		
		var jsonStr = doGetData();
		var jsonObj = JSON.parse(jsonStr);
		var howMuchObjAtOnePage = 7;
		var split = jsonObj.length / howMuchObjAtOnePage;
		var upSplit = Math.ceil(split);
		var reflashTime = 5000;
		var countObj = 0;
		//var reflashTime2 = 0;
		var objStart = 0;
		var objEnd = objStart + howMuchObjAtOnePage - 1;
		var isNeedReflashData = false;
		
		//var forTable = document.querySelector("#tableID2");
		
		//var keyTable = document.querySelector("#table_keyTable");
		var dataTable = document.querySelector("#table_dataTable");
		//var forTable = document.querySelector("#tableID");

		var jsonlength = jsonObj.length;
		var minus = jsonlength - howMuchObjAtOnePage;
		var dataKeys = "ObservationTime,MetarTime,WindDirection,WindSpeed,Temperature,WeatherDescription.Zh_tw";
		var dataKeyList = dataKeys.split(",");
		
		function isChinese(str){
			var isChi = true;
			for(var j = 0; j < str.length; j++) {
				if(str.charCodeAt(j) < 0x4E00 || str.charCodeAt(j) > 0x9FA5) {
					isChi = false;
				}
			}
			return isChi;
		}
		function doDemo() {
			
			if (isNeedReflashData == true) {
				console.log("zzzzz");
				jsonStr = doGetData();
				jsonObj = JSON.parse(jsonStr);
				
				isNeedReflashData = false;
				objStart = 0;
				objEnd = objStart + howMuchObjAtOnePage - 1;
			}
			if ((objEnd + howMuchObjAtOnePage - 1) < jsonlength && countObj!=0) {
				objStart = objEnd + 1; //0 2+3=5
				objEnd = objStart + howMuchObjAtOnePage - 1; //2 5+3-1=7
			} else if ((objEnd + howMuchObjAtOnePage - 1) >= jsonlength && countObj!=0) {
				objStart = objEnd + 1; //0 2+3=5
				
				objEnd = jsonlength - 1; //2 5+3-1=7
				isNeedReflashData = true;
				
			}
			dataTable.innerHTML = "";
			//dataStr = "";
			var resultStr = "";
			var key = objStart;
			for (var key; key <= objEnd; key++) {
				countObj++;
				var arrayObj = jsonObj[key];
				var headFiledStr = "";
				if((countObj%2 ==0)){
					headFiledStr = "<tr class='root-node even' height='35'>";
				}else{
						headFiledStr = "<tr class='root-node mx_altRow' height='35'>";
				}
				var isFirst = true;
				
				var dataStr = "";
				var keyStr = "";
				var keyWord = "AirportName";
				var keyWord2 = "Zh_tw";
				var keyValue = jsonObj[key][keyWord][keyWord2];
				keyStr = "<td title='" + keyWord + "'>"+ countObj + "." + keyValue + "</td>";
				
				for(var j=0;j<dataKeyList.length;j++){
					var dataKey = dataKeyList[j];
					if(dataKey.indexOf(".") > -1){
						var splitObj = dataKey.split(".");
						var LevelOneKey = splitObj[0];
						var LevelTwoKey = splitObj[1];
						var dataValue = jsonObj[key][LevelOneKey][LevelTwoKey];
						var value3 = "";
						dataStr = "<td title='" + LevelOneKey + "'>" + dataValue + "</td>";

					}else{
						console.log("BBBBB  key: " + " dataKey : " + dataKey);
						var dataValue = jsonObj[key][dataKey];
						dataStr = "<td title='" + dataKey + "'>"+ dataValue + "</td>";	
					}
					
				
				

					if(isFirst){
						resultStr = headFiledStr + keyStr + dataStr;
						isFirst = false;
					}else{
						resultStr += dataStr;
					}
				}
				//dataTable.innerHTML += "";
				
				resultStr += "</tr>";
				console.log("CCCC resultStr: " + resultStr);
				dataTable.innerHTML += resultStr;
				
				

				if (key == (jsonlength-1)) {
					//forTable.innerHTML = "";
					countObj = 0;
					objStart = 0;
					objEnd = objStart + howMuchObjAtOnePage - 1;
				}
				
			}
			
			setTimeout(doDemo, reflashTime);
			//forTable.innerHTML += "<tr>" + "<td>"
			//+ "&nbsp--------分隔線----------" + "</td>" + "<td>"
			//+ "&nbsp---------分隔線-----------" + "</td>" + "</tr>";
			//keyTitle.innerHTML += "<tr class='root-node even' height='35'><td class='' position='-1'></td><td position='1'><div><table><tbody><tr><td><a href='javascript:;'></a>&nbsp;</td><td title='RC Workspace' position='1' valign='middle'>Billy</td></tr></tbody></table></div></td></tr>";
			//keyTitle.innerHTML += "<tr class='root-node mx_altRow' height='35'><td class='' position='-1'></td><td position='1'><div><table><tbody><tr><td><a href='javascript:;'></a>&nbsp;</td><td title='SIMULIA Samples' position='1' valign='middle'>Billy2</td></tr></tbody></table></div></td></tr>";
			//setTimeout(doDemo, reflashTime);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		function doDemo2() {
			//forTable.innerHTML = "";
			if (isNeedReflashData == true) {
				jsonStr = doGetData();
				jsonObj = JSON.parse(jsonStr);
				isNeedReflashData = false;
				objStart = 0;
				objEnd = objStart + howMuchObjAtOnePage - 1;
			}
			if ((objEnd + howMuchObjAtOnePage - 1) < jsonlength
					&& count!=0) {
				objStart = objEnd + 1; //0 2+3=5
				objEnd = objStart + howMuchObjAtOnePage - 1; //2 5+3-1=7
			} else if ((objEnd + howMuchObjAtOnePage - 1) >= jsonlength && count!=0) {
				if ((objEnd + howMuchObjAtOnePage) < jsonlength) {
					objStart = objEnd + 1; //0 2+3=5
				} else {
					objStart = jsonlength - 1;
				}
				objEnd = jsonlength - 1; //2 5+3-1=7
				isNeedReflashData == true;
				
			}
			forTable.innerHTML = "";
			keyTitle.innerHTML = "";
			var key = objStart;
			for (var key; key <= objEnd; key++) {
				count++;
				//forTable.innerHTML = "";
				console.log("1.objStart: " + objStart);
				console.log("1.objEnd: " + objEnd);
				console.log("1.key: " + key);
				var value = jsonObj[key];
				//forTable.innerHTML += "<tr>" + "<td>" + count
				//		+ "&nbsp--------分隔線----------" + "</td>" + "<td>"
				//		+ "&nbsp---------分隔線-----------" + "</td>" + "</tr>";
				for ( var key2 in value) {
					var value2 = jsonObj[key][key2];
					//console.log("key2: " + key2 + " value2: " + value2);
					//console.log("value2 typeof: " + typeof (value2));
					if (typeof (value2) == "object") {
						for ( var key3 in value2) {
							var value3 = jsonObj[key][key2][key3];
							if(key2.equals("StationName")){
								keyTitle.innerHTML += "<tr class='root-node mx_altRow' height='35'><td class='' position='-1'></td><td position='1'><div><table><tbody><tr><td><a href='javascript:;'></a>&nbsp;</td><td title='SIMULIA Samples' position='1' valign='middle'>";
								+value3+"</td></tr></tbody></table></div></td></tr>";
							}else{
								
								
							}
							
							dataTable.innerHTML += "<tr>" + "<td>" + key2
									+ "</td>" + "<td></td>" + "</tr>";
									dataTable.innerHTML += "<tr>" + "<td>" + " ---> "
									+ key3 + "</td>" + "<td>" + value3
									+ "</td>" + "</tr>";
							//console.log("key3: " + key3 + " value3: " + value3);
						}
					} else {
						dataTable.innerHTML += "<tr>" + "<td>" + key2 + "</td>"
							+ "<td>" + value2 + "</td>" + "</tr>";
					}
				}

				if (key == (jsonlength-1)) {
					//forTable.innerHTML = "";
					count = 0;
					objStart = 0;
					objEnd = objStart + howMuchObjAtOnePage - 1;
				}
			}
			setTimeout(doDemo2, reflashTime);
		}
		
		doDemo();
	</script>
</body>
</html>