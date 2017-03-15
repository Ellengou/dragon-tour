<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统设置-图片设置-编辑</title>
<!-- Bootstrap Core CSS -->
<link
	href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<!-- validator -->
<link
	href="<%=request.getContextPath()%>/bootstrap/plugin/validator/popover.css"
	rel="stylesheet">
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
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">名称</span> <input type="text"
													class="form-control" id="name" name="name"
													value="${sysPicUrl.name}"> <input type="hidden"
													id="id" value="${sysPicUrl.id}">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">类型</span> <select
													class="form-control" id="picTypeId" name="picTypeId">

												</select>
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">排序</span> <input type="text"
													class="form-control" id="seqNum" name="seqNum"
													value="${sysPicUrl.seqNum}">
											</div>
										</div>
									</div>
									<br>

									<div class="row">
										<div class="col-xs-6">
											<div class="input-group">
												<span class="input-group-addon">备注</span> <input type="text"
													class="form-control" id="remark" name="remark"
													value="${sysPicUrl.remark}">
											</div>
										</div>
								
									</div>
									<br>
									<div class="row">
										<div class="col-xs-12" style="display: block" id="showPicUrl">
											<img src="${sysPicUrl.url}" class="img-rounded"
												style="width: 100px; height: 100px">
											<button type="button" class="btn btn-primary"
												onclick="editPic('1');">修改</button>
										</div>
										<div class="col-xs-12" style="display: none" id="editPicUrl">
											<div class="input-group">
												<span class="input-group-addon">选择图片</span> <input
													type="file" class="form-control" id="file_name"
													name="file_name"> <span class="input-group-addon"
													onclick="editPic('2');">返回</span>
											</div>
										</div>
									</div>
									<hr>
									<div class="row" align="center">
										<div class="col-xs-12">
											<input type="submit" class="btn btn-primary" value="确定" />
											<button type="button" class="btn btn-primary"
												onclick="closePage();">关闭</button>
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
	<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js"
		type="text/javascript"></script>
	<script
		src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"
		type="text/javascript"></script>
	<!-- layer JavaScript -->
	<script
		src="<%=request.getContextPath()%>/bootstrap/plugin/layer/layer.js"
		type="text/javascript"></script>
	<!-- validate -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/bootstrap/plugin/validator/ga.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/bootstrap/plugin/validator/jquery.validate.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/bootstrap/plugin/validator/jquery.validate.bootstrap.popover.js"></script>
	<!-- ajaxfileupload -->
	<script
		src="<%=request.getContextPath()%>/bootstrap/plugin/ajaxfileupload/ajaxfileupload.js"
		type="text/javascript"></script>
	<script>
	
		$(function(){
			var programaData = $.parseJSON('${picTypeList}');
			console.log(programaData);
			for (var i = 0; i < programaData.length; i++) {
				$(new Option(programaData[i].name,programaData[i].id)).appendTo('#picTypeId');
				
			}
			// $('#picTypeId').selectpicker('val', arr);
			$("#picTypeId").val('${sysPicUrl.picTypeId}');
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
	            	name: {
	                    required: true
	                },
	            	picTypeId: {
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
			
			if($('#file_name').val() != null && $('#file_name').val() != ''){
				$.ajaxFileUpload({
					url : '<%=request.getContextPath()%>/admin/system/picUrl/uploadPic',
					secureuri:false,
			        method : 'POST',  
			        fileElementId:'file_name',
			        dataType: 'json',
					error: function (data, status, e) {
						layer.alert("远程读取数据失败", {icon: 6});
					},
					success: function (data, status) {
						if(data.status == 'ok'){
							jsonData.url=data.msg;
							$.ajax({
							      url: '<%=request.getContextPath()%>/admin/system/picUrl/editPicUrl',
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
							    	  layer.alert('系统错误', {icon : 5});
							      }
							  });
				    	}else{
				    		layer.alert(data.msg, {icon : 5});
				    	}
			         }
				});
			}else{
				$.ajax({
				      url: '<%=request.getContextPath()%>/admin/system/picUrl/editPicUrl',
	
							dataType : 'json',
							type : 'POST',
							data : jsonData,
							success : function(data) {
								if (data.status == 'ok') {
									parent.search(parseInt(parent.$('.active')
											.attr('jp-data')));
									closePage();
								} else {
									layer.alert(data.msg, {
										icon : 5
									});
								}
							},
							error : function() {
								layer.alert('系统错误', {
									icon : 5
								});
							}
						});
			}
		}

		function editPic(type) {
			if (type == '1') {
				$("#showPicUrl").hide();
				$("#editPicUrl").show();
			} else {
				$("#showPicUrl").show();
				$("#editPicUrl").hide();
				$('#file_name').val('');
			}
		}
	</script>
</body>
</html>