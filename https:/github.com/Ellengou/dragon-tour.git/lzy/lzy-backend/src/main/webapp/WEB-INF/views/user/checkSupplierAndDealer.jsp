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
					<div class="panel-heading">
                           	 基本信息
                           <label class="checkbox-inline">
						      <input type="radio" name="verifyInformation" id="verifyInformation1" value="1" checked>通过
						   </label>
						   <label class="checkbox-inline">
						      <input type="radio" name="verifyInformation" id="verifyInformation2" value="2">不通过
						   </label>
                    </div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
									<div class="row">
										<div class="col-xs-12">
											<div class="input-group">
												<span class="input-group-addon">企业类型</span> 
												<label class="checkbox-inline">
											      <input type="radio" name="compType" id="compType3" value="2" disabled="disabled"> 个人
											   </label>
												<label class="checkbox-inline">
											      <input type="radio" name="compType" id="compType1" value="0" disabled="disabled"> 个体户
											   </label>
											   <label class="checkbox-inline">
											      <input type="radio" name="compType" id="compType2" value="1" disabled="disabled"> 公司
											   </label>
											</div>
										</div>
									</div>
									<div id="gerenShow" style="display: none">
										<br>
										<div class="row">
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">姓名</span> 
													<input type="text" class="form-control" id="grLealPerson" name="grLealPerson" value="${supplierInfo.lealPerson}" disabled="disabled">
												</div>
											</div>
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">身份证</span> 
													<input type="text" class="form-control" id="grLealIdCard" name="grLealIdCard" value="${supplierInfo.lealIdCard}" disabled="disabled">
												</div>
											</div>
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">手机</span> 
													<input type="text" class="form-control" id="grLealPhone" name="grLealPhone" value="${supplierInfo.lealPhone}" disabled="disabled">
												</div>
											</div>
										</div>
									</div>
									<div id="gerenHide">
										<br>
										<div class="row">
											<div class="col-xs-6">
												<div class="input-group">
													<span class="input-group-addon">统一社会信用代码</span> 
													<input type="text" class="form-control" id="creditCode" value="${supplierInfo.creditCode}" disabled="disabled">
												</div>
											</div>
											<div class="col-xs-6">
												<div class="input-group">
													<span class="input-group-addon">公司名称</span> 
													<input type="text" class="form-control" id="compName" value="${supplierInfo.compName}" disabled="disabled">
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">法人代表</span> 
													<input type="text" class="form-control" id="lealPerson" value="${supplierInfo.lealPerson}" disabled="disabled">
												</div>
											</div>
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">法人手机</span> 
													<input type="text" class="form-control" id="lealPhone" value="${supplierInfo.lealPhone}" disabled="disabled">
												</div>
											</div>
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">法人身份证</span> 
													<input type="text" class="form-control" id="lealIdCard" value="${supplierInfo.lealIdCard}" disabled="disabled">
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-xs-4">
												<div id="lealIdCardValidId" class="input-group date form_datetime col-md-12">
								                	<span class="input-group-addon">身份证有效期</span>
								                    <input id="lealIdCardValidDate" name="lealIdCardValidDate" class="form-control" size="16" type="text" value="${lealIdCardValid}" disabled="disabled">
								                </div>
											</div>
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">代理人</span> 
													<input type="text" class="form-control" id="agentPerson" value="${supplierInfo.agentPerson}" disabled="disabled">
												</div>
											</div>
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">代理人手机</span> 
													<input type="text" class="form-control" id="agentPhone" value="${supplierInfo.agentPhone}" disabled="disabled">
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">省市区</span> 
													<input type="text" class="form-control" id="areaCode" value="${supplierInfo.areaCode}" disabled="disabled">
												</div>
											</div>
											<div class="col-xs-8">
												<div class="input-group">
													<span class="input-group-addon">详细地址</span> 
													<input type="text" class="form-control" id="address" value="${supplierInfo.address}" disabled="disabled">
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-xs-4">
												<div id="businessTermId" class="input-group date form_datetime col-md-12">
								                	<span class="input-group-addon">营业期限</span>
								                    <input id="businessTermDate" name="businessTermDate" class="form-control" size="16" type="text" value="${businessTerm}" disabled="disabled">
								                </div>
											</div>
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">公司行业</span> 
													<select class="form-control" id="compTrade" disabled="disabled">
													</select>
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-xs-12">
												<div class="input-group">
													<span class="input-group-addon">经营范围</span> 
													<input type="text" class="form-control" id="businessScope" value="${supplierInfo.businessScope}" disabled="disabled">
												</div>
											</div>
										</div>
									</div>
							</div>
						</div>
					</div>
					<div class="panel-heading">企业上传图片</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
									<div class="row">
										<div class="col-xs-3">
											<img src="${baseUrl }${supplierInfo.lealFrontPicUrl}" class="img-rounded" style="width: 100px;height: 100px" onclick="showPic('${supplierInfo.lealFrontPicUrl}');">
											<label class="checkbox-inline">
										      <input type="radio" name="verifyLealFrontPic" id="verifyLealFrontPic1" value="1" checked>通过
										   </label>
										   <label class="checkbox-inline">
										      <input type="radio" name="verifyLealFrontPic" id="verifyLealFrontPic2" value="2">不通过
										   </label>
										</div>
										<div class="col-xs-3">
											<img src="${baseUrl }${supplierInfo.lealBackPicUrl}" class="img-rounded" style="width: 100px;height: 100px" onclick="showPic('${supplierInfo.lealBackPicUrl}');">
											<label class="checkbox-inline">
										      <input type="radio" name="verifyLealBackPic" id="verifyLealBackPic1" value="1" checked>通过
										   </label>
										   <label class="checkbox-inline">
										      <input type="radio" name="verifyLealBackPic" id="verifyLealBackPic2" value="2">不通过
										   </label>
										</div>
										<div class="col-xs-3" id="orgId">
											<img src="${baseUrl }${supplierInfo.organizationPicUrl}" class="img-rounded" style="width: 100px;height: 100px" onclick="showPic('${supplierInfo.organizationPicUrl}');">
											<label class="checkbox-inline">
										      <input type="radio" name="verifyOrganizationPic" id="verifyOrganizationPic1" value="1" checked>通过
										   </label>
										   <label class="checkbox-inline">
										      <input type="radio" name="verifyOrganizationPic" id="verifyOrganizationPic2" value="2">不通过
										   </label>
										</div>
										<div class="col-xs-3" id="busId">
											<img src="${baseUrl }${supplierInfo.businessLicensePicUrl}" class="img-rounded" style="width: 100px;height: 100px" onclick="showPic('${supplierInfo.businessLicensePicUrl}');">
											<label class="checkbox-inline">
										      <input type="radio" name="verifyBusinessLicensePic" id="verifyBusinessLicensePic1" value="1" checked>通过
										   </label>
										   <label class="checkbox-inline">
										      <input type="radio" name="verifyBusinessLicensePic" id="verifyBusinessLicensePic2" value="2">不通过
										   </label>
										</div>
									</div>
									<br>
									<div class="row" id="dlxx">
										<div class="col-xs-3">
											<img src="${baseUrl }${supplierInfo.agentFrontPicUrl}" class="img-rounded" style="width: 100px;height: 100px" onclick="showPic('${supplierInfo.agentFrontPicUrl}');">
											<label class="checkbox-inline">
										      <input type="radio" name="verifyAgentFrontPic" id="verifyAgentFrontPic1" value="1" checked>通过
										   </label>
										   <label class="checkbox-inline">
										      <input type="radio" name="verifyAgentFrontPic" id="verifyAgentFrontPic2" value="2">不通过
										   </label>
										</div>
										<div class="col-xs-3">
											<img src="${baseUrl }${supplierInfo.agentBackPicUrl}" class="img-rounded" style="width: 100px;height: 100px" onclick="showPic('${supplierInfo.agentBackPicUrl}');">
											<label class="checkbox-inline">
										      <input type="radio" name="verifyAgentBackPic" id="verifyAgentBackPic1" value="1" checked>通过
										   </label>
										   <label class="checkbox-inline">
										      <input type="radio" name="verifyAgentBackPic" id="verifyAgentBackPic2" value="2">不通过
										   </label>
										</div>
										<div class="col-xs-3">
											<img src="${baseUrl }${supplierInfo.proxyPicUrl}" class="img-rounded" style="width: 100px;height: 100px" onclick="showPic('${supplierInfo.proxyPicUrl}');">
											<label class="checkbox-inline">
										      <input type="radio" name="verifyProxyPic" id="verifyProxyPic1" value="1" checked>通过
										   </label>
										   <label class="checkbox-inline">
										      <input type="radio" name="verifyProxyPic" id="verifyProxyPic2" value="2">不通过
										   </label>
										</div>
									</div>
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
										<input type="hidden" id="supplierInfoId" value="${supplierInfo.id}">
										<input type="hidden" id="frontUserId" value="${frontUserId}">
										<button type="button" class="btn btn-primary" onclick="submit();">确定</button>
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
	        var businessData = $.parseJSON('${businessList}');
			for (var i = 0; i < businessData.length; i++) {
				$(new Option(businessData[i].name,businessData[i].id)).appendTo('#compTrade');
			}
			$('#compTrade').val('${supplierInfo.compTrade}');
			
			if('${supplierInfo.compType}' == '0'){
				$("#compType1").attr("checked",'checked');
			}else if('${supplierInfo.compType}' == '1'){
				$("#compType2").attr("checked",'checked');
			}else if('${supplierInfo.compType}' == '2'){
				onclickCompType('2');
				$("#compType3").attr("checked",'checked');
			}
			
			//隐藏代理人信息
			if('${supplierInfo.agentPerson}' == '' || '${supplierInfo.agentPerson}' == null){
				$('#dlxx').hide();
			}
			
			if('${supplierInfo.compType}' == '2'){
				$('#dlxx').hide();
				$('#orgId').hide();
				$('#busId').hide();
			}
	    });
		
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage() {
			parent.layer.close(index);
		}
		
		function submit() {
			var jsonData = {};
			
			$('input[name="verifyInformation"]:checked').each(function(){
				jsonData.verifyInformation = $(this).val();
			});
			
			$('input[name="verifyBusinessLicensePic"]:checked').each(function(){
				jsonData.verifyBusinessLicensePic = $(this).val();
			});
			
			$('input[name="verifyOrganizationPic"]:checked').each(function(){
				jsonData.verifyOrganizationPic = $(this).val();
			});
			
			$('input[name="verifyLealFrontPic"]:checked').each(function(){
				jsonData.verifyLealFrontPic = $(this).val();
			});
			
			$('input[name="verifyLealBackPic"]:checked').each(function(){
				jsonData.verifyLealBackPic = $(this).val();
			});
			
			$('input[name="verifyAgentFrontPic"]:checked').each(function(){
				jsonData.verifyAgentFrontPic = $(this).val();
			});
			
			$('input[name="verifyAgentBackPic"]:checked').each(function(){
				jsonData.verifyAgentBackPic = $(this).val();
			});
			
			$('input[name="verifyProxyPic"]:checked').each(function(){
				jsonData.verifyProxyPic = $(this).val();
			});
			
			jsonData.id = $('#supplierInfoId').val();
			jsonData.frontUserId = $('#frontUserId').val();
			layer.load(2);
			$.ajax({
  			      url: '<%=request.getContextPath()%>/admin/userFront/checkSupplierAndDealer',
  			      dataType: 'json',
  			      type: 'POST',
  			      data: jsonData,
  			      success: function (data) {
  			    	layer.closeAll('loading');
  			    	if(data.status == 'ok'){
  			    	//询问框
    			    	layer.confirm('保存成功', {
    			    	  btn: ['确定'] //按钮
    			    	}, function(){
    			    		parent.search(parseInt(parent.$('.active').attr('jp-data')));
    			    		closePage();
    			    	});
  			    	}else{
  			    		layer.alert(data.msg, {
  							icon : 5
  						});
  			    	}
  			      },
  			      error: function(){
  			    	  layer.closeAll('loading');
  			    	  layer.alert('系统错误', {icon : 5});
  			      }
  			  });
		}
		
		
		function showPic(url){
	    	layer.photos({
	    	    photos: {"data": [{"src": url}]}
	    	  });
	    }
		
		//个人信息显示隐藏
		function onclickCompType(type){
			if(type == '2'){
				$("#gerenHide").hide();
				$("#gerenShow").show();
			}else{
				$("#gerenHide").show();
				$("#gerenShow").hide();
			}
		}
	</script>
</body>
</html>