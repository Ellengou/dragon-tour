<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- validator -->
<link href="<%=request.getContextPath()%>/bootstrap/plugin/validator/popover.css" rel="stylesheet">
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
								<form id="myForm">
									<br>
									<div class="row">
										<div class="col-xs-12">
											<div class="input-group">
												<span class="input-group-addon">省份</span> 
												<select class="form-control" id="provinceArea" name="provinceArea" onchange="getArea('0','cityArea');">
													<option value="">请选择省份</option>
												</select>
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-12">
											<div class="input-group">
												<span class="input-group-addon">市级</span>
												<select class="form-control" id="cityArea" name="cityArea" onchange="getArea('1','countyArea');">
												</select>
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-12">
											<div class="input-group">
												<span class="input-group-addon">区/县级</span>
												<select class="form-control" id="countyArea" name="countyArea">
												</select>
											</div>
										</div>
									</div>
									<hr>
									<div class="row" align="center">
										<div class="col-xs-12">
											<input type="submit" class="btn btn-primary" value="确定" />
											<button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
										</div>
									</div>
								</form>
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
	<!-- validate -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/validator/ga.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/validator/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/validator/jquery.validate.bootstrap.popover.js"></script>
	<script>
		$(document).ready(function() {
			var provinceList = $.parseJSON('${provinceList}');
			for (var i = 0; i < provinceList.length; i++) {
				$(new Option(provinceList[i].areaname,provinceList[i].areaid)).appendTo('#provinceArea');
			}
			$('#myForm').validate_popover({
	            onsubmit:true,
	            rules: {
	            	provinceArea: {
	                    required: true
	                },
	                cityArea: {
	                    required: true
	                },
	                countyArea: {
	                    required: true
	                }
	            },
	            messages: {
	                
	            },
	            submitHandler: function (form) {
	            	submit();
	            }
	        });
		});
			
		
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage() {
			parent.layer.close(index);
		}
		
		function submit() {
			parent.setArea('${id}','${name}',$('#countyArea').val(),$('#provinceArea').find("option:selected").text() + '-' + $('#cityArea').find("option:selected").text() + '-' + $('#countyArea').find("option:selected").text());
			closePage();
		}
		
		function getArea(type,id){
			if(type == '0'){
				var areaCode = $('#provinceArea').val();
			}else{
				var areaCode = $('#cityArea').val();
			}
			
			$.ajax({
			      url: '<%=request.getContextPath()%>/admin/area/getLevelList',
			      dataType: 'json',
			      type: 'POST',
			      data: {
			    	  areaCode: areaCode
			      },
			      success: function (data) {
			    	if(data.status == 'ok'){
			    		$("#" + id).empty();
			    		if(type == '0'){
			    			$("#countyArea").empty();
			    			$(new Option('请选择市级','')).appendTo('#' + id);
			    		}else{
			    			$(new Option('请选择区/县级','')).appendTo('#' + id);
			    		}
			    		for (var i = 0; i < data.msg.length; i++) {
			    			$(new Option(data.msg[i].areaname,data.msg[i].areaid)).appendTo('#' + id);
						}
			    	}else{
			    		layer.alert(data.msg, {icon : 5});
			    	}
			      },
			      error: function(){
			    	  layer.alert('系统错误', {icon : 5});
			      }
			  });
		}
	</script>
</body>
</html>