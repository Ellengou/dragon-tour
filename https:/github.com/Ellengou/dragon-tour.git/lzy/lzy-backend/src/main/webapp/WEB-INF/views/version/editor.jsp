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
	<input type="text" value="${version.id }" id="id" name="id" hidden="true">
	<div class="panel panel-primary">
		<div class="panel-heading">
	      <h3 class="panel-title">修改</h3>
	   </div>
	<div class="panel panel-default">
		<div class="panel-body">
			<div  class="form-group">
				<label class="col-xs-2 control-label">平台</label>
				<div class="input-group col-xs-9">
					<input type="text" class="form-control" name="platform" id="platform"  value="${version.platform }" >
				</div>
			</div>
			<div  class="form-group">
				<label class="col-xs-2 control-label">版本</label>
				<div class="input-group col-xs-9">
					<input type="text" class="form-control" name="version" id="version"  value="${version.version }" >
				</div>
			</div>
			<%--<div  class="form-group">--%>
				<%--<label class="col-xs-2 control-label">下载地址</label>--%>
				<%--<div class="input-group col-xs-9">--%>
					<%--<input type="text" class="form-control" name="url" id="url"  value="${version.url }" >--%>
				<%--</div>--%>
			<%--</div>--%>
			<div  class="form-group">
				<label class="col-xs-2 control-label">描述</label>
				<div class="input-group col-xs-9">
					<input type="text" class="form-control" name="des" id="des"  value="${version.des }" >
				</div>
			</div>
			<div  class="form-group">
				<label class="col-xs-2 control-label">强制更新</label>
				<div class="input-group col-xs-9">
				   <label class="checkbox-inline">
				      <input type="radio" name="status" 
				         value="0"> 否
				   </label>
				   <label class="checkbox-inline">
				      <input type="radio" name="status"
				         value="1"> 是
				   </label>
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
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jquery.form.js"></script>
	<script>
	$(document).ready(function(){
		var status = '${version.status}';
		if('' != status){
			$("input[name='status']").each(function(){
				var $this = $(this);
				if(status == $this.val()){
					$this.attr('checked',true);
				}else{
				}
			});
		}
	});
	function save(){
	
		layer.confirm('确认保存?', {icon: 3, title:'提示',offset: 100}, function(index){
			var options = {
		        target:'#myForm',
		        success:function(data){
		        	parent.layer.close(index);
		        	parent.location.reload();
		        },
		        error:function(data){
		        	
		        },
		        url:'<%=request.getContextPath()%>/pv/update',
		        type:'post'
		    };
		  	$("#myForm").ajaxSubmit(options);
		  	
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