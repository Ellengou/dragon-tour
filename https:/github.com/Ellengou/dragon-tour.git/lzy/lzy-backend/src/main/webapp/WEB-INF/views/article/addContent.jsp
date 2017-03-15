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
	<style>
		.placeholder {
			font-size: 11px;
			color: #aeaeae;
		}
	</style>
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
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">编号</span>
											<input type="text" class="form-control" id="serialNum" name="serialNum" onchange="checkSerialNum();">
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">标题</span>
											<input type="text" class="form-control" id="title" name="title">
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">作者</span>
											<input type="text" class="form-control" id="author" name="author">
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">内容类型</span>
											<select class="form-control" id="programaId" name="programaId">
											</select>
										</div>
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">顺序</span>
											<input type="text" class="form-control" id="seqNum" name="seqNum">
										</div>
									</div>
									<div class="col-xs-6">
										<div class="input-group">
											<span class="input-group-addon">关键词</span>
											<input type="text" class="form-control" id="keyWord" name="keyWord">
										</div>
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-12">
										<div class="input-group">
											<span class="input-group-addon">摘要</span>
											<input type="text" class="form-control" id="summary" name="summary" maxlength="200">
										</div>
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-6">
										<div class="input-group">
											<span class="input-group-addon">标题图片</span>
											<input type="file" class="form-control" id="file_name" name="file_name">
										</div>
									</div>
								</div>
								<hr>
								<div class="row" id="summernote"></div>
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
<!-- ajaxfileupload -->
<script src="<%=request.getContextPath()%>/bootstrap/plugin/ajaxfileupload/ajaxfileupload.js" type="text/javascript"></script>
<%@ include file="/WEB-INF/views/template/summernote.jsp"%>

<script>
	$(document).ready(function() {
		$('#summernote').summernote({
			lang: 'zh-CN',
			height: 360,
			callbacks: {
				onInit: function() {
					$('#summernote').summernote('code','<div class="placeholder">请输入...</div>');
				},
				onFocus: function() {
					if($('#summernote').summernote('code') == '<div class="placeholder">请输入...</div>'){
						$('#summernote').summernote('code','');
					}
				},
				onBlur: function() {
					if($('#summernote').summernote('code') == null || $('#summernote').summernote('code') == ''){
						$('#summernote').summernote('code','<div class="placeholder">请输入...</div>');
					}
				}
			}
		});

		var programaData = $.parseJSON('${programaList}');
		for (var i = 0; i < programaData.length; i++) {
			$(new Option(programaData[i].name,programaData[i].id)).appendTo('#programaId');
		}

		$.validator.addMethod("myNumber",function(value,element,params){
			if(value != null && value != ''){
				if(!(/^\d{1,3}$/.test(value))){
					return false;
				}else{
					return true;
				}
			}else{
				return true;
			}
		},"请输入1-3位的数字");

		$.validator.addMethod("pic",function(value,element,params){
			if(value != null && value != ''){
				if(!(/\.png$|\.jpg$|\.jpeg$|\.gif$/i.test(value))){
					return false;
				}else{
					return true;
				}
			}else{
				return true;
			}
		},"请选择正确的图片格式");

		$('#myForm').validate_popover({
			onsubmit:true,
			rules: {
				serialNum: {
					required: true
				},
				title: {
					required: true
				},
				author: {
					required: true
				},
				programaId: {
					required: true
				},
				seqNum: {
					myNumber: true
				},
				file_name: {
					pic: true
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
		//将form表单参数组成json
		var jsonData = {};
		$("#myForm").find("input").each(function() {
			jsonData[$(this).attr('id')] = $(this).val();
		});
		$("#myForm").find("select").each(function(){
			jsonData[$(this).attr('id')] = $(this).val();
		});
		var markupStr = $('#summernote').summernote('code');
		jsonData.content = markupStr;

		if($('#file_name').val() != null && $('#file_name').val() != ''){
			$.ajaxFileUpload({
				url : '<%=request.getContextPath()%>/admin/content/uploadPic',
				secureuri:false,
				method : 'POST',
				fileElementId:'file_name',
				dataType: 'json',
				error: function (data, status, e) {
					layer.alert("远程读取数据失败", {icon: 6});
				},
				success: function (data, status) {
					if(data.status == 'ok'){
						jsonData.picUrl=data.msg;
						$.ajax({
							url: '<%=request.getContextPath()%>/admin/content/addContent',
							dataType: 'json',
							type: 'POST',
							data: jsonData,
							success: function (data) {
								if(data.status == 'ok'){
									parent.search(parseInt(parent.$('.active').attr('jp-data')));
									closePage();
								}else{
									layer.alert(data.msg, {
										icon : 5
									});
								}
							},
							error: function(){
								layer.alert('系统错误', {
									icon : 5
								});
							}
						});
					}else{
						layer.alert(data.msg, {icon : 5});
					}
				}
			});
		}else{
			$.ajax({
				url: '<%=request.getContextPath()%>/admin/content/addContent',
				dataType: 'json',
				type: 'POST',
				data: jsonData,
				success: function (data) {
					if(data.status == 'ok'){
						parent.search(parseInt(parent.$('.active').attr('jp-data')));
						closePage();
					}else{
						layer.alert(data.msg, {
							icon : 5
						});
					}
				},
				error: function(){
					layer.alert('系统错误', {
						icon : 5
					});
				}
			});
		}
	}

	//校验序号是否已存在
	function checkSerialNum(){
		if($('#serialNum').val() == '' || $('#serialNum').val() ==null){
			return;
		}
		$.ajax({
			url: '<%=request.getContextPath()%>/admin/content/getContentBySerialNum',
			dataType: 'json',
			type: 'POST',
			data: {
				serialNum:$('#serialNum').val()
			},
			success: function (data) {
				if(data.status != 'ok'){
					$('#serialNum').val('');
					layer.alert(data.msg, {
						icon : 5
					});
				}
			},
			error: function(){
				layer.alert('系统错误', {
					icon : 5
				});
			}
		});
	}
</script>
</body>