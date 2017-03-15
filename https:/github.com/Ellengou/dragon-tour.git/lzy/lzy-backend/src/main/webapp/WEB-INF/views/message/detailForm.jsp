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
				<span id="sumContent" hidden>${detail.content}</span>
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="myForm">
									<br>
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">消息标题</span>
                                                <input type="hidden" id="id" value="${detail.id}">
												<input type="text" class="form-control" id="name" name="name" value="${detail.name}">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">发送形式</span>
												<select class="form-control" id="sendType" name="sendType">
												</select>
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">消息类型</span>
												<select class="form-control" id="typeId" name="typeId">
                                            	</select>
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">消息对象类型</span>
												<select class="form-control required" id="userType">
													<option value="sys_user_front">前台用户</option>
													<option value="sys_user_admin">后台用户</option>
												</select>
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">是否群发</span>
												<select class="form-control required" id="isGroup">
													<option value="0">是</option>
													<option value="1">否</option>
												</select>
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">消息状态</span>
												<select class="form-control required" id="status">
													<option value="0">启用</option>
													<option value="1">停用</option>
												</select>
											</div>
										</div>
									</div>
									<hr>
									<div class="row" id="summernote"></div>
									<hr>
									<div class="row" align="center">
										<div class="col-xs-12">
											<input type="button" class="btn btn-primary" onclick="submitDetail()" value="确定" />
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
		var action="${action}";

		$(document).ready(function() {
			var sendType = $.parseJSON('${sendType}');
			for (var i = 0; i < sendType.length; i++) {
				$(new Option(sendType[i].dicDataName,sendType[i].dicDataValue)).appendTo('#sendType');
			}

	        var sysMessageTypes = $.parseJSON('${sysMessageTypes}');
			for (var i = 0; i < sysMessageTypes.length; i++) {
				$(new Option(sysMessageTypes[i].name,sysMessageTypes[i].id)).appendTo('#typeId');
			}

			$("#sendType").val('${detail.sendType}');
			$("#isGroup").val('${detail.isGroup}');
            $('#userType').val('${detail.userType}');
            $('#status').val('${detail.status}');
			if ('${detail.typeId}' != '') {
				$("#typeId").val('${detail.typeId}');
			}

			$('#summernote').summernote({
				lang: 'zh-CN',
				height: 360,
//				codemirror: { // codemirror options
//					theme: 'monokai'
//				},
//				toolbar: [
//					// [groupName, [list of button]]
//					['style', ['bold', 'italic', 'underline', 'clear']],
//					['font', ['strikethrough', 'superscript', 'subscript']],
//					['fontsize', ['fontsize']],
//					['color', ['color']],
//					['para', ['ul', 'ol', 'paragraph']],
//					['height', ['height']]
//				],
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
			$('#summernote').summernote('code', $('#sumContent').html());

	    });
		
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage() {
			parent.layer.close(index);
		}

		function submitDetail() {
            layer.confirm('是否确定此操作？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                console.log($('#summernote').summernote('code'));
                $.ajax({
                    type:'POST',
                    url:  '<%=request.getContextPath()%>/admin/messageDetail/' + action,
                    data:{
                        id:$('#id').val(),
                        name:$('#name').val(),
						sendType:$('#sendType').val(),
						typeId:$('#typeId').val(),
                        userType:$('#userType').val(),
                        status:$('#status').val(),
						isGroup:$('#isGroup').val(),
                        content:$('#summernote').summernote('code')
                    },
                    dataType:'json',
                    beforeSend:function() {
                        // TODO FORM ...
                    },
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
            }, function(){

            });

		}

	</script>
</body>
</html>