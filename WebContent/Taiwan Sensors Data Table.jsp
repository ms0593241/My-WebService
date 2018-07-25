<!DOCTYPE html>
<!-- saved from url=(0069)https://joeggyy.000webhostapp.com/WEB/environmentSensorWidget_v3.html -->
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:widget="http://www.netvibes.com/ns/"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">



  <title>Taiwan Sensors Data Table</title>

  <meta name="author" content="CCT3">
  <meta name="description" content="Taiwan sensors data - acquire and display data from a CSV file">
  <meta name="debugMode" content="true">
  <meta name="strictMode" content="false">

  </head><body><widget:preferences>
    <widget:preference type="text" name="filesFolderUrl" label="Files folder URL" defaultvalue="https://joeggyy.000webhostapp.com/WEB/">
    <widget:preference type="hidden" name="allData" label="Table data" defaultvalue="">
    <widget:preference type="hidden" name="savedCSVData" label="Saved CSV Data" defaultvalue="">
  </widget:preference></widget:preference></widget:preference></widget:preferences>
	
  <style media="screen">
    table, td, th, span, select, #dataOption {
      font-family: "Calibri", Calibri, sans-serif;
      font-size: 14px;
    }

    table, td, th {
      border: 4px solid white;
    }

    th {
      text-align: center;
      color: #FEFEFE;
      padding: 8px;
    }

    td {
      text-align: center;
      padding-top: 8px;
      padding-bottom: 8px;
    }

    table {
      border-collapse: collapse;
      width: 70%;
      margin-bottom: 20px;
      margin-right: 1%;
      float: left;
    }

    span {
      color: #1C6693;
      font-weight: bold;
    }

    select {
      margin-bottom: 10px;
      font-weight: bold;
    }

    #dataScaleImage {
      max-width:18%;
      max-height: 350px;
      margin-right: 0%;
      float: left;
    }

    #sensorImage {
      width: 10%;
    }

    #dataOption {
      color: #6D140E;
      margin-bottom: 10px;
    }

    #headerOrange {
      background-color: #FF7F0E;
    }

    #headerGreen {
      background-color: #96BC0D;
    }

    #headerPink {
      background-color: #EA66AF;
    }

    #headerPurple {
      background-color: #796ACF;
    }

    #headerBlue {
      background-color: #00C6DD;
    }

    #headerGrey {
      background-color: #888580;
    }

    .pastelGrey {
      background-color: #D8D8D8;
    }

    .pastelOrange {
      background-color: #FFE5CF;
    }

    .pastelGreen {
      background-color: #EAF2CF;
    }

    .pastelPink {
      background-color: #FBE0EF;
    }

    .pastelPurple {
      background-color: #E7E3F4;
    }

    .pastelBlue {
      background-color: #CEF4F8;
    }

    .pastelWhite {
      background-color: #DCD9D5;
    }

    .circle {
      width: 25px;
      height: 25px;
      -webkit-border-radius: 25px;
      -moz-border-radius: 25px;
      border-radius: 25px;
      margin: auto;
    }

    #circleRed {
      background: #FF0000;
    }

    #circleGreen {
      background: #4ffc00;
    }

    #circleYellow {
      background: #f4c700;
    }

    #circleOrange {
      background: #ff752a;
    }

    #circleBlue {
      background: #4286f4;
    }

    #circlePurple {
      background: #9b41f4;
    }

    #circlePink {
      background: #ff54d9;
    }

    #circleBrown {
      background: #894d4d;
    }

    #circleBlack {
      background: #000000;
    }

    #circleGrey {
      background: #a3a3a3;
    }

    #circleWhite {
      background: #ffffff;
    }

    .chartIcon {
      margin-left: 10px;
      height: 30px;
      width: 30px;
    }

    .topic:hover {
      background-color: #005686;
      color: #FEFEFE;
    }

    #container {
      margin-top: 15px;
      width: 100%;
    }
  </style>

  <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>

  <script>
  var url = widget.getValue("filesFolderUrl");
  console.log("url: " + url);
  require([
    "UWA/Drivers/jQuery",
    "DS/PlatformAPI/PlatformAPI", //In 16x for communication between widgets
		//"UWA/Utils/InterCom", //In 15x for communication between widgets
    "DS/WAFData/WAFData",
    "DS/PlatformAPI/PlatformAPI"
  ], function(
    $,
    PlatformAPI, //In 16x for communication between widgets
		//InterCom, //In 15x for communication between widgets
    WAFData,
    PlatformAPI
  ){
    var myWidget = {
      currentPOIContentId: "",
      humidityData: [],
      o3Data: [],
      pm25Data: [],
      coData: [],
      co2Data: [],
      temperatureData: [],
      humidityIndex: -1,
      o3Index: -1,
      pm25Index: -1,
      coIndex: -1,
      co2Index: -1,
      temperatureIndex: -1,
      darkRedColor: "rgb(132,0,42)",
      redColor: 	"rgb(252,0,0)",
      orangeColor: 	"rgb(253,104,0)",
      yellowColor: 	"rgb(255,255,0)",
      greenColor: 	"rgb(0,255,1)",
	  cyanColor: 	"rgb(0,252,226)",	  
	  blueColor: 	"rgb(0,96,254)",	  
      purpleColor: 	"rgb(86,0,204)",
	  violetColor:  "rgb(126,2,38)",
      poiColorsArray: [],
      poiCreated: false,
      poiCreationIncrement: 0,  // 5 and not 0 because otherwise, the API bugs and doesn't create the 3DPOIs according to the specified colors and parameters

      /*
      * Function that allows to get a file using a WAFDATA.proxifiedRequest in order to avoid security issues
      */
      getFile: function(urlWAF) {

        if(!urlWAF || urlWAF===""){
          widget.log("Please specify a correct file path");
          return;
        } else {
		  urlWAF += "?" + Date.now();
		}

        var dataWAF = {};
        var methodWAF= "GET";
        var typeWAF = "text";

        WAFData.proxifiedRequest(urlWAF, {
          method: methodWAF,
          data: dataWAF,
          type: typeWAF,
          onComplete: function (dataResp, headerResp) {
            //widget.log("CSV request completed : " + dataResp);
            widget.deleteValue("allData");
            widget.setValue("allData", dataResp);
            myWidget.generateTable(dataResp);
          },
          onFailure: function(error, responseDOMString, headerResp) {
            widget.log("CSV request failed : " + error);
          }
        });
      },

      /*
      * Function that generate the sensors data table from CSV file's raw text data
      */
      generateTable: function(allText) {
        allTextLines = allText.split(/\r\n|\n/);  // split the file content string by line (return to line...)
        headers = allTextLines[0].split(';'); // split the first line by element (separated with ';')
        var numberOfColumns = headers.length; // number of columns = number of elements in the first row
        var numberOfElements = allTextLines.length;
        var regexColor = /^(red|green|yellow|orange|blue|purple|pink|brown|black|grey|gray|white)$/i;
        var colorObj = {currentColor:"",colorCounter:0};

        $('thead').empty();
        $('tbody').empty();

        var $row = $('<tr/>');
        $('<th/>').appendTo($row);
        for(var i=1 ; i<numberOfColumns ; i++) {
          colorObj = myWidget.colorPicker(colorObj);
          myWidget.headerIndexDetector(headers[i].trim(), i);
          $('<th/>').text(headers[i]).attr('id', 'header' + colorObj.currentColor).appendTo($row);  // put column name in the element, add id for style (background color) and append to the header row
        }
        $('thead').append($row);
        myWidget.arraysCleaner();
        for (var i=1; i<numberOfElements ; i++) {
          colorObj = {currentColor:"",colorCounter:-1};
          var textData = allTextLines[i].split(';');
          if (textData.length == headers.length) {
            var $row = $('<tr/>');
            for(var j=0 ; j<numberOfColumns ; j++) {
              myWidget.dataStoreManager(j, textData[j].trim());
              colorObj = myWidget.colorPicker(colorObj);
              //check if value is a color to apply style and make it appear as a color circle
              if(regexColor.test(textData[j].trim())) {
                textData[j]=textData[j].toLowerCase();
                switch (textData[j]) {
                  case "red":
                  var td = $('<td/>').addClass("pastel" + colorObj.currentColor);
                  var circleDiv = $('<div/>').addClass("circle").attr("id", "circleRed");
                  td.append(circleDiv).appendTo($row);
                  break;
                  case "green":
                  var td = $('<td/>').addClass("pastel" + colorObj.currentColor);
                  var circleDiv = $('<div/>').addClass("circle").attr("id", "circleGreen");
                  td.append(circleDiv).appendTo($row);
                  break;
                  case "yellow":
                  var td = $('<td/>').addClass("pastel" + colorObj.currentColor);
                  var circleDiv = $('<div/>').addClass("circle").attr("id", "circleYellow");
                  td.append(circleDiv).appendTo($row);
                  break;
                  case "orange":
                  var td = $('<td/>').addClass("pastel" + colorObj.currentColor);
                  var circleDiv = $('<div/>').addClass("circle").attr("id", "circleOrange");
                  td.append(circleDiv).appendTo($row);
                  break;
                  case "blue":
                  var td = $('<td/>').addClass("pastel" + colorObj.currentColor);
                  var circleDiv = $('<div/>').addClass("circle").attr("id", "circleBlue");
                  td.append(circleDiv).appendTo($row);
                  break;
                  case "purple":
                  var td = $('<td/>').addClass("pastel" + colorObj.currentColor);
                  var circleDiv = $('<div/>').addClass("circle").attr("id", "circlePurple");
                  td.append(circleDiv).appendTo($row);
                  break;
                  case "pink":
                  var td = $('<td/>').addClass("pastel" + colorObj.currentColor);
                  var circleDiv = $('<div/>').addClass("circle").attr("id", "circlePink");
                  td.append(circleDiv).appendTo($row);
                  break;
                  case "brown":
                  var td = $('<td/>').addClass("pastel" + colorObj.currentColor);
                  var circleDiv = $('<div/>').addClass("circle").attr("id", "circleBrown");
                  td.append(circleDiv).appendTo($row);
                  break;
                  case "black":
                  var td = $('<td/>').addClass("pastel" + colorObj.currentColor);
                  var circleDiv = $('<div/>').addClass("circle").attr("id", "circleBlack");
                  td.append(circleDiv).appendTo($row);
                  break;
                  case "grey":  // UK english
                  case "gray":  // US english
                  var td = $('<td/>').addClass("pastel" + colorObj.currentColor);
                  var circleDiv = $('<div/>').addClass("circle").attr("id", "circleGrey");
                  td.append(circleDiv).appendTo($row);
                  break;
                  case "white":
                  var td = $('<td/>').addClass("pastel" + colorObj.currentColor);
                  var circleDiv = $('<div/>').addClass("circle").attr("id", "circleWhite");
                  td.append(circleDiv).appendTo($row);
                  break;
                  default: $('<td/>').addClass("pastel" + colorObj.currentColor).appendTo($row);
                }
              }
              else {
                $('<td/>').text(textData[j].substring(0,6)).addClass("pastel" + colorObj.currentColor).appendTo($row);
              }
              $('tbody').append($row);
            }
          }
        }
      },

      /*
      * Function that is used to check the column headers in the CSV file for the air sensors data (O3, CO, Humidity...)
      * It then gets the corresponding index (column number) to later be used to get the needed data (need humidity data --> check index --> get corresponding column data)
      */
      headerIndexDetector: function(headerText, currentIndex) {
        switch (headerText.toLowerCase()) {
          case "濕度":
            myWidget.humidityIndex = currentIndex;
            break;
          case "o3":
            myWidget.o3Index = currentIndex;
            break;
          case "pm2.5":
            myWidget.pm25Index = currentIndex;
            break;
          case "co":
            myWidget.coIndex = currentIndex;
            break;
          case "co2":
            myWidget.co2Index = currentIndex;
            break;
          case "溫度":
            myWidget.temperatureIndex = currentIndex;
            break;
          default:
            widget.log("WARNING: No match has been detected on this header: " + headerText);
        }
      },

      /*
      * Function to empty arrays containing the air sensors data from the CSV file
      */
      arraysCleaner: function() {
        myWidget.humidityData = [];
        myWidget.o3Data = [];
        myWidget.pm25Data = [];
        myWidget.coData = [];
        myWidget.co2Data = [];
        myWidget.temperatureData = [];
      },

      /*
      * Function to store air sensor data in the corresponding array according to the provided index
      */
      dataStoreManager: function(dataIndex, data) {
        switch (dataIndex) {
          case myWidget.humidityIndex:
            myWidget.humidityData.push(data);
			widget.log("humidity " + data.substring(0,4));
            break;
          case myWidget.o3Index:
            myWidget.o3Data.push(data);
            break;
          case myWidget.pm25Index:
            myWidget.pm25Data.push(data);
            break;
          case myWidget.coIndex:
            myWidget.coData.push(data);
            break;
          case myWidget.co2Index:
            myWidget.co2Data.push(data);
            break;
          case myWidget.temperatureIndex:
            myWidget.temperatureData.push(data);
            break;
          default:
            widget.log("WARNING: No matching index has been detected for this index: " + dataIndex);
        }
      },

      /*
      * Function that returns a different color each time it is called (7 different colors)
      * These colors are used to render the widget's table with different color for each columns
      */
      colorPicker: function(colorObj) {
        switch (colorObj.colorCounter) {
          case 0 :
          colorObj.currentColor = "Orange";
          colorObj.colorCounter++;
          break;
          case 1 :
          colorObj.currentColor = "Green";
          colorObj.colorCounter++;
          break;
          case 2 :
          colorObj.currentColor = "Pink";
          colorObj.colorCounter++;
          break;
          case 3 :
          colorObj.currentColor = "Purple";
          colorObj.colorCounter++;
          break;
          case 4 :
          colorObj.currentColor = "Blue";
          colorObj.colorCounter++;
          break;
          case 5 :
          colorObj.currentColor = "Grey";
          colorObj.colorCounter = 0;
          break;
          default :
          colorObj.currentColor = "White";
          colorObj.colorCounter = 0;
          break;
        }
        return colorObj;
      },

      optionChecker: function(selectedOption) {
        switch (selectedOption) {
          case "airSensor":
            if(widget.getValue("savedCSVData") != "airSensor" || myWidget.poiCreated == false) {
              widget.deleteValue("savedCSVData");
              widget.setValue("savedCSVData", "airSensor");
              myWidget.getFile(widget.getValue("filesFolderUrl") + "AIRPOLLUTIONDATA.CSV");
            }
            break;
          case "waterSensor":
            if(widget.getValue("savedCSVData") != "waterSensor") {
              widget.deleteValue("savedCSVData");
              widget.setValue("savedCSVData", "waterSensor");
              myWidget.getFile(widget.getValue("filesFolderUrl") + "WATERPOLLUTIONDATA.CSV");
            }
            break;
          case "securityCam":
            if(widget.getValue("savedCSVData") != "airSensor") {
              widget.deleteValue("savedCSVData");
              widget.setValue("savedCSVData", "airSensor");
              myWidget.getFile(widget.getValue("filesFolderUrl") + "AIRPOLLUTIONDATA.CSV");
            }
          default:
            widget.log("ERROR: The selected option has not been recognized!");
        }
      },

      dataOptionChecker: function(selectedSensorType) {
        if(selectedSensorType == "airSensor") {
          var selectedDataOption = $("#dataOption :radio:checked").attr("value");
          var topicName="topic.selectedDataOption";
  				//Send message in 16x
  				PlatformAPI.publish(topicName, {"data":selectedDataOption});
          widget.log("topic.selectedDataOption published with data: " + selectedDataOption);
          myWidget.manageScaleImage(selectedDataOption);
        }
      },
	  
	  sensorTypeChecker: function(selectedSensorType) {
		var topicName="topic.selectedSensorType";
  				//Send message in 16x
  				PlatformAPI.publish(topicName, {"data":selectedSensorType});
          widget.log("topic.selectedSensorType published with data: " + selectedSensorType);
	  },

      manageDisplayedElements: function(selectedSensorType) {
        if(selectedSensorType == "airSensor") {
          $('#dataOption').show();
          $('#dataScaleImage').show();
        }
        else {
          $('#dataOption').hide();
          $('#dataScaleImage').hide();
        }
      },

      checkHumidityValue: function(humidityValue) {
	    console.log("humidityValue: "+humidityValue);	  
        if(humidityValue<20) {
          return myWidget.blueColor;
        }
        else if (humidityValue<40) {
          return myWidget.cyanColor;
        }
        else if (humidityValue<75) {
          return myWidget.greenColor;
        }
        else if (humidityValue<80) {
          return myWidget.yellowColor;
        }
        else if (humidityValue<85) {
          return myWidget.orangeColor;
        }
        else if (humidityValue<90) {
          return myWidget.redColor;
        }
        else if (humidityValue<95) {
          return myWidget.purpleColor;
        }		
        else {
          return myWidget.violetColor;
        }		
      },

      checkO3Value: function(o3Value) {
	    console.log("o3Value: "+o3Value);
        if(o3Value<0.025) {
          return myWidget.cyanColor;
        }
        else if (o3Value<0.055) {
          return myWidget.greenColor;
        }		
        else if (o3Value<0.125) {
          return myWidget.yellowColor;
        }
		else if (o3Value<0.165) {
          return myWidget.orangeColor;
        }
		else if (o3Value<0.205) {
          return myWidget.redColor;
        }
		else if (o3Value<0.405) {
          return myWidget.purpleColor;
        }			
        else {
          return myWidget.violetColor;
        }
      },

      checkPm25Value: function(pm25Value) {
	    console.log("pm25Value: "+pm25Value);
        if(pm25Value<7) {
          return myWidget.cyanColor;
        }
        else if (pm25Value<15.5) {
          return myWidget.greenColor;
        }		
        else if (pm25Value<35.5) {
          return myWidget.yellowColor;
        }
        else if (pm25Value<54.5) {
          return myWidget.orangeColor;
        }
        else if (pm25Value<150.5) {
          return myWidget.redColor;
        }
        else if (pm25Value<250.5) {
          return myWidget.purpleColor;
        }		
        else {
          return myWidget.violetColor;
        }
      },

      checkCoValue: function(coValue) {
	    console.log("coValue: "+coValue);
        if(coValue<2.2) {
          return myWidget.cyanColor;
        }
        else if (coValue<4.5) {
          return myWidget.greenColor;
        }
        else if (coValue<9.5) {
          return myWidget.yellowColor;
        }
        else if (coValue<12.5) {
          return myWidget.orangeColor;
        }
		else if (coValue<15.5) {
          return myWidget.redColor;
        }
		else if (coValue<30.5) {
          return myWidget.purpleColor;
        }		
        else {
          return myWidget.violetColor;
        }
      },

      checkco2Value: function(co2Value) {
        if(co2Value<150) {
          return myWidget.cyanColor;
        }
        else if (co2Value<450) {
          return myWidget.greenColor;
        }
        else if (co2Value<700) {
          return myWidget.yellowColor;
        }
        else if (co2Value<1000) {
          return myWidget.orangeColor;
        }
        else if (co2Value<2500) {
          return myWidget.redColor;
        }	
        else if (co2Value<5000) {
          return myWidget.purpleColor;
        }			
        else {
          return myWidget.violetColor;
        }
      },

      checkTemperatureValue: function(temperatureValue) {
	  console.log("temperatureValue: "+temperatureValue);
        if(temperatureValue<10) {
          return myWidget.blueColor;
        }
        else if (temperatureValue<18) {
          return myWidget.cyanColor;
        }
        else if (temperatureValue<28) {
		  console.log("greenColor");
		  return myWidget.greenColor;
        }
        else if (temperatureValue<33) {
          return myWidget.yellowColor;
        }
        else if (temperatureValue<37) {
          return myWidget.orangeColor;
        }		
        else if (temperatureValue<39) {
          return myWidget.redColor;
        }
        else if (temperatureValue<42) {
          return myWidget.purpleColor;
        }		
        else {
          return myWidget.violetColor;
        }
      },
	  

      manageScaleImage: function(selectedDataOption) {
        switch (selectedDataOption) {
          case "humidity":
            $('#dataScaleImage').attr('src', widget.getValue("filesFolderUrl") + 'img/humidityScale.png');
            //widget.log("CORRESPONDING DATA: " + myWidget.humidityData);
            myWidget.poiColorsArray = [];
            for(var i=0 ; i<myWidget.humidityData.length ; i++) {
              myWidget.poiColorsArray.push(myWidget.checkHumidityValue(myWidget.humidityData[i]));
            }
            //widget.log("CORRESPONDING COLORS: " + myWidget.poiColorsArray);
            break;
          case "o3":
            $('#dataScaleImage').attr('src', widget.getValue("filesFolderUrl") + 'img/o3Scale.PNG');
            //widget.log("CORRESPONDING DATA: " + myWidget.o3Data);
            myWidget.poiColorsArray = [];
            for(var i=0 ; i<myWidget.o3Data.length ; i++) {
              myWidget.poiColorsArray.push(myWidget.checkO3Value(myWidget.o3Data[i]));
            }
            //widget.log("CORRESPONDING COLORS: " + myWidget.poiColorsArray);
            break;
          case "pm2.5":
            $('#dataScaleImage').attr('src', widget.getValue("filesFolderUrl") + 'img/PM2_5Scale.png');
            //widget.log("CORRESPONDING DATA: " + myWidget.pm25Data);
            myWidget.poiColorsArray = [];
            for(var i=0 ; i<myWidget.pm25Data.length ; i++) {
              myWidget.poiColorsArray.push(myWidget.checkPm25Value(myWidget.pm25Data[i]));
            }
            //widget.log("CORRESPONDING COLORS: " + myWidget.poiColorsArray);
            break;
          case "co":
            $('#dataScaleImage').attr('src', widget.getValue("filesFolderUrl") + 'img/COScale.png');
            //widget.log("CORRESPONDING DATA: " + myWidget.coData);
            myWidget.poiColorsArray = [];
            for(var i=0 ; i<myWidget.coData.length ; i++) {
              myWidget.poiColorsArray.push(myWidget.checkCoValue(myWidget.coData[i]));
            }
            //widget.log("CORRESPONDING COLORS: " + myWidget.poiColorsArray);
            break;
          case "co2":
            $('#dataScaleImage').attr('src', widget.getValue("filesFolderUrl") + 'img/co2Scale.png');
            //widget.log("CORRESPONDING DATA: " + myWidget.co2Data);
            myWidget.poiColorsArray = [];
            for(var i=0 ; i<myWidget.co2Data.length ; i++) {
              myWidget.poiColorsArray.push(myWidget.checkco2Value(myWidget.co2Data[i]));
            }
            //widget.log("CORRESPONDING COLORS: " + myWidget.poiColorsArray);
            break;
          case "temp":
            $('#dataScaleImage').attr('src', widget.getValue("filesFolderUrl") + 'img/tempScale.png');
            //widget.log("CORRESPONDING DATA: " + myWidget.temperatureData);
            myWidget.poiColorsArray = [];
            for(var i=0 ; i<myWidget.temperatureData.length ; i++) {
              myWidget.poiColorsArray.push(myWidget.checkTemperatureValue(myWidget.temperatureData[i]));
            }
            //widget.log("CORRESPONDING COLORS: " + myWidget.poiColorsArray);
            break;
          default:
            $('#dataScaleImage').attr('src', '');
        }
        widget.log("THIS IS A TEST poiColorsArray!!!! --> " + myWidget.poiColorsArray);
      },

      manageSensorImage: function(selectedSensorType) {
        switch (selectedSensorType) {
          case "airSensor":
            $('#sensorImage').attr('src', widget.getValue("filesFolderUrl") + 'img/airSensor.png');
            break;
          case "waterSensor":
            $('#sensorImage').attr('src', widget.getValue("filesFolderUrl") + 'img/waterSensor.jpg');
            break;
          case "securityCam":
            $('#sensorImage').attr('src', widget.getValue("filesFolderUrl") + 'img/securityCam.jpg');
            break;
          default:
            $('#sensorImage').attr('src', '');
        }
      },

      UIManager: function(selectedSensorType) {
        myWidget.optionChecker(selectedSensorType);
        myWidget.manageDisplayedElements(selectedSensorType);
        myWidget.dataOptionChecker(selectedSensorType);
        myWidget.manageSensorImage(selectedSensorType);
        //$('#dataScaleImage').css("max-height", $("#measuredDataTable").height()); CREATES IMG DIPSLAY ISSUE (DOESNT SHOW UNTIL CHANGE IN DDLIST)
      },

      setListeners: function() {
        // listens to dropdown list
        $("#sensorType").change(function() {
          var selectedSensorType = $("#sensorType option:selected").attr("value");
		  console.log("setListeners selectedSensorType");
		  myWidget.sensorTypeChecker(selectedSensorType);
          myWidget.UIManager(selectedSensorType);
          myWidget.POIDetector(selectedSensorType);
        });

        // listens to radio buttons
        $("#dataOption").change(function() {
		  console.log("setListeners selectedSensorData");
          var selectedSensorData = $("#sensorType option:selected").attr("value");
          myWidget.dataOptionChecker(selectedSensorData);
          myWidget.POIManager();
        });
        //widget.log("SET LISTENERS COMPLETED!");
      },

      /*
      * START MANAGING CITY INTERACTIONS
      */
      POIDetector: function(selectedSensorType) {
        //widget.log("POIDetector() CALLED!");
        switch (selectedSensorType) {
          case "airSensor":
            myWidget.moveToTarget(209375.22284961873, 2670862.2756412155, -0.05621987131777928);
            myWidget.selectPOI("a852085d-505b-412c-b49d-504d97785d0f", "IN_AIR_", ["01","02","03","04"]);
            myWidget.selectPOI("7446479d-275e-47b1-97cf-22f0f89aa357", "OUT_AIR_", ["01","02"]);
            myWidget.POIManager();
            break;
          case "waterSensor":
            myWidget.moveToTarget(217570.85347748123, 2670113.7100973674, -0.06361741021817124);
            myWidget.selectPOI("3c32bb69-8e27-41f7-b3fc-43fa6a743d95", "WATER_", ["01","02", "03"]); // TODO change layerID to actual waterSensor one
            myWidget.removeContent(myWidget.currentPOIContentId);
            break;
          case "securityCam":
            myWidget.moveToTarget(217570.85347748123, 2670113.7100973674, -0.06361741021817124);
            myWidget.selectPOI("c82415c6-38aa-4967-aa0d-526c91c2af15", "SECURITY_CAM_", ["01", "02", "03"]);
            myWidget.removeContent(myWidget.currentPOIContentId);
            break;
          default:
            widget.log("ERROR: selected sensor type doesn't have a layerID or position");
        }
      },

      POIManager: function() {
        //widget.log("POIManager() called!");
        var poiId = "airSensorPollutionLevel";
        var poiName = "Air Sensor Pollution Level"; //str or array
        var folderId = "airSensorPollutionLevelFolder";
        var folderName = "Air Sensor Pollution Level Folder";
        var positionsArray = [
          {x:209488.9, y:2670860.7, z:2.6},
          {x:209489.1, y:2670855.1, z:2.2},
          {x:209490.1, y:2670827.4, z:3.5},
          {x:209474.9, y:2670850.5, z:3.2},
          {x:209515.4, y:2670880.3, z:4},
          {x:209471.5, y:2670901.2, z:4}	  
        ];
        myWidget.currentPOIContentId = poiId;

        myWidget.poiCreationIncrement++;
        myWidget.removeContent(folderId); // remove former POIs first (via folder deletion), in case they exist, because no color update of formerly created POI available for now
        for(var i=0 ; i<positionsArray.length ; i++) {
          var poiPosition = []; // new array each time to put the current poi position as the createPoi() function expects an array for the position value
          poiPosition.push(positionsArray[i]);
          myWidget.createPOI(poiId + myWidget.poiCreationIncrement + i, poiName + " " + i, folderId, folderName, poiPosition, myWidget.poiColorsArray[i]);
        }
      },

      /*
      * This function checks if the primitiveId variable is an array (eg several items) or not (one item) before calling selectObject as many times as needed
      * This is a workaround as in the current API state, it cannot perform a selectObject on several items at once (need to perform one for each item for multiselection)
      */
      selectPOI: function(layerId, primitivePrefix, primitiveSuffix) {
        //widget.log("selectPOI() CALLED!");
        if(Array.isArray(primitiveSuffix)) {
          for(var i=0 ; i<primitiveSuffix.length ; i++) {
            myWidget.selectObject(layerId, primitivePrefix + primitiveSuffix[i]);
          }
        }
        else {
          myWidget.selectObject(layerId, primitivePrefix + primitiveSuffix);
        }
      },

      selectObject: function(layerId, primitiveId) {
        widget.log("selectObject() CALLED WITH DATA: " + primitiveId);
        PlatformAPI.publish('3DEXPERIENCity.SelectObject', {
          widget_id: widget.id,
          layer_id: layerId,
          primitive_id: primitiveId,
        });
      },

      moveToTarget: function(xValue, yValue, zValue) {
        //widget.log("moveToTarget() CALLED!");
        PlatformAPI.publish('3DEXPERIENCity.MoveToTarget', [{x: xValue, y: yValue, z: zValue}, 5, [209485.75454980353, 2670899.430560495, 10.070964102107006], 250]);
      },

      processSelectedItems: function(rs) {
        for(var i=0; i<rs.data.length; i++) {
          var dataArray = [];
          dataArray.push('ids', rs.data[i]);
          //widget.log("getSelectedItems return: " + rs.data[i]);
        }
      },

      // TODO manage the color attribute issues + pass the different color value for each POI
      createPOI: function(poiId, poiName, folderId, folderName, poiPosition, poiColor) {
        widget.log("createPOI() CALLED! with color: " + poiColor);
        var poi = {
          "widget_id": widget.id,
          "id": poiId,
          "name": poiName, //str or array
          "folder": {
            "id": folderId,
            "name": folderName,
            "parent_id": 'root'
          },
          "positions": poiPosition,
          "userData": [
            {lat: poiPosition.x, lon: poiPosition.y, altitude: poiPosition.z, color: poiColor},
          ],
          "options": {
            // "useUserDataId": true,
            "color": poiColor,
            //"color": ["rgba(252,21,0,100)","rgba(58,29,0,100)","rgba(0,21,168,100)","rgba(252,21,0,100)","rgba(252,21,0,100)","rgba(252,21,0,100)"],
            // "disableHwInstancing": true,
            "shapeType": 'sphere',
            "renderMode": 'overlay',  //occluded
            "opacity": 0.5,
            "switchDistance": 500,
            "levelMin": 0,
            "levelMax": 10,
            "scale": {"x":3,"y":3,"z":5},
            "height": 30,
            "heightAttribute": 30,
            "nbVertices": 50,
            "renderAnchor": true,
            "anchorLineWidth": 1,
            "priority": 3,
            "priorityOffset": 1,
            "className": 'RdbLink',
            "shadingMode": 'smooth',
            "useRenderProfile": true,
            "colorGradient": {
              "attribute": "COLORG",
              "start": {"value": 1.0, "color": ["0", "255", "73", "100"]},
              "mid": {"value": 4.0, "color": ["255", "156", "0", "100"]},
              "end": {"value": 18.0, "color": ["232", "14", "0", "100"]}
            },
            "styleClass": 'sensor3D',
            "externalCSS": {
            "id": 'poi',
              "url": 'https://sgp-server2015x.uwglobe.com/widget/assets/css/poi.css?v=6'
            },
            "proxy": {
              "url": 'https://sgp-server2015x.uwglobe.com/widget/assets/php/urlProxy.php',
              "queryString": {
                "action": 'get',
                "id": '',
                "sid": ''
              }
            }
            // "not_visible": true,
            // "not_selectable": true
          }
        };
        PlatformAPI.publish('3DEXPERIENCity.Add3DPOI', poi);
        //widget.log("ADD3DPOI published! " + poi);
      },

      update3DPOIContent: function(poiId, poiName, poiPosition, poiColor) {
        //widget.log("update3DPOIContent() called!  " + poiId + " " + poiName + " " + poiPosition + " " + poiColor);
        PlatformAPI.publish('3DEXPERIENCity.Update3DPOIContent', {
          widget_id: widget.id,
          positions: poiPosition,
          id: poiId,
          name: poiName,
          userData: [
            {content: "test"}
          ],
          options: {
            "color": poiColor
          }
        });
      },

      removeContent: function(objectID) {
        PlatformAPI.publish('3DEXPERIENCity.RemoveContent', objectID);
      },

      manageSubscriptions: function() {
        // Unsubscribe previous subscriptions if any
        //PlatformAPI.unsubscribe('3DEXPERIENCity.OnItemSelect');
        //PlatformAPI.unsubscribe('3DEXPERIENCity.OnWorldClick');

        // Subscribe / Re-subscribe

        PlatformAPI.subscribe('3DEXPERIENCity.OnItemSelect',function(data){
          PlatformAPI.publish('3DEXPERIENCity.GetSelectedItems', {
             widget_id: widget.id
          });
        });

        PlatformAPI.subscribe('3DEXPERIENCity.Update3DPOIContentReturn', function(rs) {
            //widget.log("RES", rs);
        });

        PlatformAPI.subscribe('3DEXPERIENCity.BufferQueryReturn', function(data) {
          //widget.log('BufferQueryReturn', data);
        });

        PlatformAPI.subscribe('3DEXPERIENCity.SelectObjectReturn', function(data) {
          //widget.log('SelectObjectReturn', data);
        });

        PlatformAPI.subscribe('3DEXPERIENCity.GetSelectedItemsReturn', myWidget.processSelectedItems(data));

      },

      /*
      * END MANAGING CITY INTERACTIONS
      */

      onLoadWidget: function() {
        var selectedSensorType = $("#sensorType option:selected").attr("value");
        widget.log("ON LOAD WIDGET: I AM ENVIRONMENT SENSOR & selectedSensorType: " + selectedSensorType);
        myWidget.UIManager(selectedSensorType);
        myWidget.setListeners();
        myWidget.manageSubscriptions();
      },

      onRefreshWidget: function() {
        widget.log("--------------ON REFRESH WIDGET---------------");
        /** Check if data already stored in the browser localStorage. If that's the case, generate chart using stored data. **/
        if(widget.getValue("allData") != "") {
          myWidget.generateTable(widget.getValue("allData"));
        }
        myWidget.manageSubscriptions();
      },

      endEdit: function() {
        widget.log("--------------END EDIT WIDGET PREFERENCES---------------");
      }
  };
  widget.myWidget=myWidget;
  //PlatformAPI = PlatformAPI;
  widget.addEvent("onLoad", myWidget.onLoadWidget);
  widget.addEvent("onRefresh", myWidget.onRefreshWidget);
  // ***** this onRefreshWidget.bind(that) actually refresh the widget
  // widget.addEvent("onRefresh", that.onRefreshWidget.bind(that));  
  widget.addEvent("endEdit", myWidget.endEdit);
  widget.log("ADD EVENT COMPLETED!");
});
</script>





  <span>Sensor types: </span><select id="sensorType">
    <option value="airSensor">Air Sensor</option>
    <option value="waterSensor">Water Sensor</option>
    <option value="securityCam">Security Cam</option>
  </select>
  
  <div class="form-inline" id="dataOption">
    <label class="radio inline">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" value="humidity" checked="checked" name="group">Humidity&nbsp;&nbsp;&nbsp;&nbsp;</label>
    <label class="radio inline"><input type="radio" value="o3" name="group">O3&nbsp;&nbsp;&nbsp;&nbsp;</label>
    <label class="radio inline"><input type="radio" value="pm2.5" name="group">PM2.5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
    <label class="radio inline"><input type="radio" value="co" name="group">CO&nbsp;&nbsp;&nbsp;&nbsp;</label>
    <label class="radio inline"><input type="radio" value="co2" name="group">CO2&nbsp;&nbsp;&nbsp;&nbsp;</label>
    <label class="radio inline"><input type="radio" value="temp" name="group">Temp&nbsp;&nbsp;&nbsp;&nbsp;</label>
  </div>

  <div class="" id="mainData">
    <table id="measuredDataTable">
      <thead>

      </thead>
      <tbody>

      </tbody>
    </table>
	
	<img id="dataScaleImage" src="./COScale.png" alt="Data Scale Image">
    <img id="sensorImage" src="https://joeggyy.000webhostapp.com/WEB/environmentSensorWidget_v3.html" alt="Sensor Image">
  </div>
 

<div style="text-align: right;position: fixed;z-index:9999999;bottom: 0; width: 100%;cursor: pointer;line-height: 0;display:block !important;"><a title="000webhost logo" rel="nofollow" target="_blank" href="https://www.000webhost.com/?utm_source=000webhostapp&amp;utm_campaign=000_logo&amp;utm_campaign=ss-footer_logo&amp;utm_medium=000_logo&amp;utm_content=website"><img src="./Taiwan Sensors Data Table_files/footer-powered-by-000webhost-white2.png" alt="000webhost logo"></a></div>


</body></html>