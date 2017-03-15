<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div id="page-wrapper" style="padding: 0 15px;">
		<div class="row">
			<div class="col-lg-12">
				<br>
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称</span> 
												<input type="text" class="form-control" id="nickName" name="nickName" value="${userFront.nickName}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">真实姓名</span> 
												<input type="text" class="form-control" id="name" name="name" value="${userInfo.name}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">身份证号</span> 
												<input type="text" class="form-control" id="idCard" name="idCard" value="${userFront.idCard}" disabled="disabled">
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</span>
												<select class="form-control" id="sex" name="sex" disabled="disabled">
													
												</select>
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱</span> 
												<input type="text" class="form-control" id="email" name="email" value="${userFront.email}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机</span> 
												<input type="text" class="form-control" id="phone" name="phone" value="${userFront.phone}" disabled="disabled">
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">住宅电话</span> 
												<input type="text" class="form-control" id="homeTel" name="homeTel" value="${userInfo.homeTel}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编</span> 
												<input type="text" class="form-control" id="postCode" name="postCode" value="${userInfo.postCode}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">QQ号码</span>
												<input type="text" class="form-control" id="qq" name="qq" value="${userInfo.qq}" disabled="disabled">
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;历</span>
												<select class="form-control" id="education" name="education" disabled="disabled">
													
												</select>
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">婚姻状况</span> 
												<select class="form-control" id="marriageStatus" name="marriageStatus" disabled="disabled">
													
												</select>
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">有无子女</span>
												<select class="form-control" id="childStatus" name="childStatus" disabled="disabled">
													
												</select>
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">就业状况</span> 
												<select class="form-control" id="employmentSituation" name="employmentSituation" disabled="disabled">
													
												</select>
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">公司名称</span> 
												<input type="text" class="form-control" id="compName" name="compName" value="${userInfo.compName}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">公司职位</span>
												<select class="form-control" id="positId" name="positId" disabled="disabled">
												
												</select>
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">收入/月</span> 
												<input type="text" class="form-control" id="income" name="income" value="${userInfo.income}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">社保/公积金</span>
												<select class="form-control" id="socialSecurity" name="socialSecurity" disabled="disabled">
													
												</select>
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-12">
											<div class="input-group" id="financialSituationData">
												
										   </div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">居住地区</span> 
												<input type="text" class="form-control" id="liveAreaCode" value="${liveAreaCodeName}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-8">
											<div class="input-group">
												<span class="input-group-addon">居住街道地址</span> 
												<input type="text" class="form-control" id="liveAddress" value="${userInfo.liveAddress}" disabled="disabled">
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">户籍地区</span> 
												<input type="text" class="form-control" id="houseAreaCode" value="${houseAreaCodeName}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-8">
											<div class="input-group">
												<span class="input-group-addon">户籍街道地址</span> 
												<input type="text" class="form-control" id="houseAddress" value="${userInfo.houseAddress}" disabled="disabled">
											</div>
										</div>
									</div>
									<hr>
									<div class="row" align="center">
										<div class="col-xs-12">
											<button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
										</div>
									</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- layer JavaScript -->
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/layer/layer.js" type="text/javascript"></script>
	<script>
	
	$(document).ready(function() {
		var sexData = $.parseJSON('${sexList}');
		for (var i = 0; i < sexData.length; i++) {
			$(new Option(sexData[i].dicDataName,sexData[i].dicDataValue)).appendTo('#sex');
		}
		$('#sex').val('${userInfo.sex}');
		
		var educationData = $.parseJSON('${educationList}');
		for (var i = 0; i < educationData.length; i++) {
			$(new Option(educationData[i].dicDataName,educationData[i].dicDataValue)).appendTo('#education');
		}
		$('#education').val('${userInfo.education}');
		
		var marriageStatusData = $.parseJSON('${marriageStatusList}');
		for (var i = 0; i < marriageStatusData.length; i++) {
			$(new Option(marriageStatusData[i].dicDataName,marriageStatusData[i].dicDataValue)).appendTo('#marriageStatus');
		}
		$('#marriageStatus').val('${userInfo.marriageStatus}');
		
		var childStatusData = $.parseJSON('${childStatusList}');
		for (var i = 0; i < sexData.length; i++) {
			$(new Option(childStatusData[i].dicDataName,childStatusData[i].dicDataValue)).appendTo('#childStatus');
		}
		$('#childStatus').val('${userInfo.childStatus}');
		
		var employmentSituationData = $.parseJSON('${employmentSituationList}');
		for (var i = 0; i < employmentSituationData.length; i++) {
			$(new Option(employmentSituationData[i].dicDataName,employmentSituationData[i].dicDataValue)).appendTo('#employmentSituation');
		}
		$('#employmentSituation').val('${userInfo.employmentSituation}');
		
		var defaultPositData = $.parseJSON('${defaultPositList}');
		for (var i = 0; i < defaultPositData.length; i++) {
			$(new Option(defaultPositData[i].dicDataName,defaultPositData[i].dicDataValue)).appendTo('#positId');
		}
		$('#positId').val('${userInfo.positId}');
		
		var socialSecurityData = $.parseJSON('${socialSecurityList}');
		for (var i = 0; i < socialSecurityData.length; i++) {
			$(new Option(socialSecurityData[i].dicDataName,socialSecurityData[i].dicDataValue)).appendTo('#socialSecurity');
		}
		$('#socialSecurity').val('${userInfo.socialSecurity}');
		
		var financialSituationData = $.parseJSON('${financialSituationList}');
		var financialSituation = [];
		if('${userInfo.financialSituation}' != null && '${userInfo.financialSituation}' != ''){
			financialSituation = $.parseJSON('${userInfo.financialSituation}');
		}
		var str = '<span class="input-group-addon" >财力状况</span>&nbsp;&nbsp;&nbsp;&nbsp;';
		for (var i = 0; i < financialSituationData.length; i++) {
			str = str + '<label class="checkbox-inline"><input type="checkbox" name="financialSituation" id="financialSituation' + i + '" value="'+ financialSituationData[i].dicDataValue + '" disabled="disabled"';
			for (var j = 0; j < financialSituation.length; j++) {
				if(financialSituationData[i].dicDataValue == financialSituation[j]){
					str = str + 'checked="checked"';
				}
			}
			str = str + '>' + financialSituationData[i].dicDataName + ' </label>';
		}
		$("#financialSituationData").html(str);
		
    });
	
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage() {
			parent.layer.close(index);
		}
	</script>
</body>
</html>