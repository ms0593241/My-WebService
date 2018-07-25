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

	<form name="emxTableForm">
		<div id="mx_divBody" style="display: block; top: 37px; bottom: 31px;" class="">
			<div id="spinner_div" class="spinner-mask">
				<div class="spinner spinning fade in">
					<span class="spinner-bar"></span>
					<span class="spinner-bar spinner-bar1"></span>
					<span class="spinner-bar spinner-bar2"></span>
					<span class="spinner-bar spinner-bar3"></span>
				</div>
			</div>
			<div id="mx_divTree" style="width: 219px;">
				<div id="mx_divTreeHead" style="width: 235px;">
					<table xmlns="http://www.w3.org/1999/xhtml" id="treeHeadTable" colorize="" style="position: relative; left: 0px;" width="238">
						<tbody>
							<tr class="mx_hidden-row">
								<td position="-1" width="1"></td>
								<td class="mx_hidden-row" width="1"></td>
								<td id="ROW_1" class="mx_hidden-row" width="234"></td>
								<td class="mx_hidden-row" width="2"></td>
							</tr>
							<tr style="height: 40px;">
								<th position="-1" width="1"></th>
								<th width="1"></th>
								<th id="Name">
									<table>
										<tbody>
											<tr>

												<td id="Name" class="mx_sort-column " width="">
													<a href="javascript:sortTable(1)">Name</a>
												</td>
												<td id="Name_sort" class="sort-ascend status" width=""></td>
												<td id="Name_filter" width=""></td>
											</tr>
										</tbody>
									</table>
								</th>
								<th class="mx_sizer"></th>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="mx_divTreeBody" width="237" style="width: 235px; top: 46px;">
					<table xmlns="http://www.w3.org/1999/xhtml" id="treeBodyTable" data-drag="Name" width="235">
						<tbody>
							<tr class="mx_hidden-row">
								<td position="-1" width="1"></td>
								<td id="ROW_1" width="234"></td>
							</tr>
							<tr id="0,0" o="23408.56090.17304.58049" r="" class="root-node even" height="35">
								<td class="" position="-1"></td>
								<td position="1" rownumber="1" rmbid="23408.56090.17304.58049" rmbrow="0,0" draggable="true">
									<div id="0,0" o="23408.56090.17304.58049" r="" t="" draggable="false">
										<table draggable="false">
											<tbody draggable="false">
												<tr id="0,0" o="23408.56090.17304.58049" r="" draggable="false">

													<td id="icon_0,0" draggable="false">
														<a href="javascript:;" draggable="false"></a>
														&nbsp;
													</td>
													<td title="RC Workspace" position="1" rmbid="23408.56090.17304.58049" rmbrow="0,0" draggable="false" valign="middle">
														<a href="javascript:link(&quot;1&quot;,&quot;23408.56090.17304.58049&quot;,&quot;&quot;,&quot;&quot;,&quot;RC Workspace&quot;)" data-oid="23408.56090.17304.58049" data-icon="images/iconSmallTeamWorkspace.png" class="object" draggable="false">RC Workspace</a>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr id="0,1" o="23408.56090.51872.5580" r="" class="root-node mx_altRow" height="35">
								<td class="" position="-1"></td>
								<td position="1" rownumber="1" rmbid="23408.56090.51872.5580" rmbrow="0,1" draggable="true">
									<div id="0,1" o="23408.56090.51872.5580" r="" t="" draggable="false">
										<table draggable="false">
											<tbody draggable="false">
												<tr id="0,1" o="23408.56090.51872.5580" r="" draggable="false">

													<td id="icon_0,1" draggable="false">
														<a href="javascript:;" draggable="false"></a>
														&nbsp;
													</td>
													<td title="SIMULIA Samples" position="1" rmbid="23408.56090.51872.5580" rmbrow="0,1" draggable="false" valign="middle">
														<a href="javascript:link(&quot;1&quot;,&quot;23408.56090.51872.5580&quot;,&quot;&quot;,&quot;&quot;,&quot;SIMULIA Samples&quot;)" data-oid="23408.56090.51872.5580" data-icon="images/iconSmallTeamWorkspace.png" class="object" draggable="false">SIMULIA Samples</a>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div id="spinner_div" class="spinner-mask">
				<div class="spinner spinning fade in">
					<span class="spinner-bar"></span>
					<span class="spinner-bar spinner-bar1"></span>
					<span class="spinner-bar spinner-bar2"></span>
					<span class="spinner-bar spinner-bar3"></span>
				</div>
			</div>
			<div id="mx_divGrabber" onmousedown="javascript:setDragging(this)" onmouseup="javascript:stopResizeDivs(this)" style="left: 219px;">
				<div id="mx_divGrabberHead"></div>
				<div id="mx_divGrabberBody" style="top: 6px;"></div>
			</div>
			<div id="mx_divTable" style="left: 222px;">
				<div id="mx_divTableHead">
					<table xmlns="http://www.w3.org/1999/xhtml" id="headTable" style="position: relative; left: 0px;" width="1094" border="0">
						<tbody>
							<tr class="mx_hidden-row">
								<td id="ROW_2" width="346"></td>
								<td width="2"></td>
								<td id="ROW_3" width="346"></td>
								<td width="2"></td>
								<td id="ROW_4" width="346"></td>
								<td width="2"></td>
								<td id="ROW_5" width="48"></td>
								<td width="2"></td>
							</tr>
							<tr>
								<th id="description" class="mx_editable ">
									<table>
										<tbody>
											<tr>
												<td id="description" class="mx_sort-column " width="">
													<a href="javascript:sortTable(2)">Description</a>
												</td>
												<td id="description_sort" class="" width=""></td>
											</tr>
										</tbody>
									</table>
								</th>
								<th class="mx_sizer"></th>
								<th id="state">
									<table>
										<tbody>
											<tr>
												<td id="state" class="mx_sort-column " width="">
													<a href="javascript:sortTable(3)">State</a>
												</td>
												<td id="state_sort" class="" width=""></td>
												<td id="state_filter" width=""></td>
											</tr>
										</tbody>
									</table>
								</th>
								<th class="mx_sizer"></th>
								<th id="Owner">
									<table>
										<tbody>
											<tr>
												<td id="Owner" class="mx_sort-column " width="">
													<a href="javascript:sortTable(4)">Owner</a>
												</td>
												<td id="Owner_sort" class="" width=""></td>
												<td id="Owner_filter" width=""></td>
											</tr>
										</tbody>
									</table>
								</th>

							</tr>
						</tbody>
					</table>
				</div>
				<div id="mx_divTableBody" style="top: 46px;">
					<table xmlns="http://www.w3.org/1999/xhtml" id="bodyTable" width="1092">
						<tbody>
							<tr class="mx_hidden-row">
								<td id="ROW_2" width="348"></td>
								<td id="ROW_3" width="348"></td>
								<td id="ROW_4" width="348"></td>
								<td id="ROW_5" width="48"></td>
							</tr>
							<tr id="0,0" o="23408.56090.17304.58049" r="" class="root-node 
					even
				" height="35">
								<td position="2" rmbid="23408.56090.17304.58049" rmbrow="0,0" rownumber="1" title="RC Workspace">RC Workspace</td>
								<td position="3" rmbid="23408.56090.17304.58049" rmbrow="0,0" rownumber="1" title="Active">Active</td>
								<td position="4" rmbid="23408.56090.17304.58049" rmbrow="0,0" rownumber="1" title="Leader RC">Leader RC</td>
							</tr>
							<tr id="0,1" o="23408.56090.51872.5580" r="" class="root-node 
					mx_altRow
				" height="35">
								<td position="2" rmbid="23408.56090.51872.5580" rmbrow="0,1" rownumber="1" title="Workspace created by SIMULIA for samples objects">Workspace created by SIMULIA for samples objects</td>
								<td position="3" rmbid="23408.56090.51872.5580" rmbrow="0,1" rownumber="1" title="Active">Active</td>
								<td position="4" rmbid="23408.56090.51872.5580" rmbrow="0,1" rownumber="1" title="SLM Installer">SLM Installer</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>




		<div></div>
	</form>

</body>
</html>