<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>后台管理系统</title>
	<!-- Bootstrap Core CSS -->
	<%@ include file="/WEB-INF/views/template/validator.jsp"%>
	<style>
		.placeholder {
			font-size: 11px;
			color: #aeaeae;
		}
		html,body {
			padding:0 15px;
			overflow-x:hidden;
		}
	</style>
</head>
<body>
<form id="myForm" class="form-horizontal" role="form">
	<input type="text" value="${dic.id }" id="id" name="id" hidden="true">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">添加</h3>
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
				<div  class="form-group">
					<label class="col-xs-2 control-label">平台</label>
					<div class="input-group col-xs-9" id = "mobilePlatformList">
					</div>
				</div>
				<div  class="form-group">
					<label class="col-xs-2 control-label">版本</label>
					<div class="input-group col-xs-9">
						<input type="text" class="form-control" name="version" id="version">
					</div>
				</div>
				<div  class="form-group">
					<label class="col-xs-2 control-label">描述</label>
					<div class="input-group col-xs-9">
						<input type="text" class="form-control" name="des" id="des">
					</div>
				</div>
				<div  class="form-group">
					<label class="col-xs-2 control-label">强制更新</label>
					<div class="input-group col-xs-9" id="statusList">
						<label class="checkbox-inline" >
							<input type="radio" name="status"
								   value="0"> 否
						</label>
						<label class="checkbox-inline">
							<input type="radio" name="status"
								   value="1"> 是
						</label>
					</div>
				</div>
				<%--<div  class="form-group">--%>
				<%--<label class="col-xs-2 control-label">下载地址</label>--%>
				<%--<div class="input-group col-xs-9">--%>
				<%--<input type="text" class="form-control" name="url" id="url">--%>
				<%--</div>--%>
				<%--</div>--%>
				<div  class="form-group">
					<label class="col-xs-2 control-label">选择文件</label>
					<div class="input-group col-xs-9">
						<input type="file" class="form-control" id="file_name" name="file_name">
					</div>
				</div>
			</div>
		</div>
		<div  class="form-group">
			<div class="col-xs-offset-2 col-xs-9" id = "div_buttons">
				<button type="button" class="btn btn-primary"  onclick="save()">保存</button>
				<button type="button" class="btn btn-danger" onclick="closePage()">取消</button>
			</div>
		</div>
	</div>
</form>
<%--<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jquery.form.js"></script>--%>
<script src="<%=request.getContextPath()%>/bootstrap/plugin/ajaxfileupload/ajaxfileupload.js" type="text/javascript"></script>
<script>
	$(document).ready(function(){
		var mobilePlatformList = '${mobilePlatformList}';
		if('' != mobilePlatformList){
			mobilePlatformList = $.parseJSON(mobilePlatformList)
			var template = "";
			for(var i=0;i<mobilePlatformList.length;i++){
				var obj = mobilePlatformList[i];
				template += '<label class="checkbox-inline">';
				template += '<input type="radio" name="platform" value="'+obj.value+'">'+obj.name+'</label>';
			}
			$("#mobilePlatformList").append(template);
		}
	});
	function save(){
		layer.confirm('确认保存?', {icon: 3, title:'提示',offset: 100}, function(index) {
			$.ajaxFileUpload({
				url:'<%=request.getContextPath()%>/pv/save',
				secureuri:false,
				method : 'POST',
				fileElementId:'file_name',
				dataType: 'json',
				data: {
					platform:$('#mobilePlatformList input[name="platform"]:checked ').val(),
					version:$('#version').val(),
					des:$('#des').val(),
					status:$('#statusList input[name="status"]:checked ').val()
				},
				beforeSend: function() {
					loading = layer.load(2);
				},
				error: function (data, status, e) {
					layer.close(loading);
					layer.alert("远程读取数据失败", {icon: 6});
				},
				success: function (data, status) {
					layer.close(loading);

					if(data.status == 'ok'){
						parent.layer.close(index);
						parent.location.reload();
					}else{
						layer.alert(data.msg, {icon : 5});
					}
				}
			});

			<%--var options = {--%>
			<%--target:'#myForm',--%>
			<%--url:'<%=request.getContextPath()%>/pv/save',--%>
			<%--type:'post',--%>
			<%--success:function(data){--%>
			<%--data = $.parseJSON(data);--%>
			<%--if (data.status == 'fail') {--%>
			<%--parent.layer.confirm(data.msg, {--%>
			<%--btn: ['确定'], //按钮--%>
			<%--}, function(){--%>
			<%--parent.layer.close(index);--%>
			<%--parent.location.reload();--%>
			<%--});--%>
			<%--} else {--%>
			<%--parent.layer.close(index);--%>
			<%--parent.location.reload();--%>
			<%--}--%>
			<%--},--%>
			<%--error:function(data){--%>
			<%--layer.alert('系统异常', {icon : 5});--%>
			<%--}--%>
			<%--};--%>
			<%--$("#myForm").ajaxSubmit(options);--%>

		});
	}
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
</script>
</body>
</html>