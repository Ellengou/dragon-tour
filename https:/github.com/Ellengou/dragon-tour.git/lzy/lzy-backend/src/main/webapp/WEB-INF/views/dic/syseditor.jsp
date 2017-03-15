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
	      <h3 class="panel-title">${dic.dicDataName }</h3>
	   </div>
	<div class="panel panel-default">
		<div class="panel-body">
			<div  class="form-group">
				<label class="col-xs-2 control-label">数值</label>
				<div class="input-group col-xs-9">
					<input type="text" class="form-control" name="dicDataValue" id="dicDataValue"  value="${dic.dicDataValue }">
				</div>
			</div>
			<div  class="form-group">
				<label class="col-xs-2 control-label">描述</label>
				<div class="input-group col-xs-9">
					<input type="text" class="form-control" name="dicDataDes" id="dicDataDes"  value="${dic.dicDataDes }" disabled="disabled">
				</div>
			</div>
			<div  class="form-group">
				<label class="col-xs-2 control-label">备注</label>
				<div class="input-group col-xs-9">
					<input type="text" class="form-control" name="remark" id="remark"  value="${dic.remark }" disabled="disabled">
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
		var dicDataActive = '${dic.dicDataActive}';
		if('' != dicDataActive){
			$("input[name='dicDataActive']").each(function(){
				var $this = $(this);
				if(dicDataActive == $this.val()){
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
		        url:'<%=request.getContextPath()%>/dic/save',
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