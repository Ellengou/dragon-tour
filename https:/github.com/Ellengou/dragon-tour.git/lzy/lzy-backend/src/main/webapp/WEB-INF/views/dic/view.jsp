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
	      <h3 class="panel-title">修改</h3>
	   </div>
	<div class="panel panel-default">
		<div class="panel-body">
			<div  class="form-group">
				<label class="col-xs-2 control-label">字典值</label>
				<div class="input-group col-xs-9">
					<input type="text" class="form-control" name="dicDataValue" id="dicDataValue"  value="${dic.dicDataValue }" disabled="disabled">
				</div>
			</div>
			<div  class="form-group">
				<label class="col-xs-2 control-label">字典名称</label>
				<div class="input-group col-xs-9">
					<input type="text" class="form-control" name="dicDataName" id="dicDataName"  value="${dic.dicDataName }"  disabled="disabled">
				</div>
			</div>
			<div  class="form-group">
				<label class="col-xs-2 control-label">字典描述</label>
				<div class="input-group col-xs-9">
					<input type="text" class="form-control" name="dicDataDes" id="dicDataDes"  value="${dic.dicDataDes }"  disabled="disabled">
				</div>
			</div>
			<div  class="form-group">
				<label class="col-xs-2 control-label">字典状态</label>
				<div class="input-group col-xs-9">
				   <label class="checkbox-inline">
				      <input type="radio" name="dicDataActive" 
				         value="0"  disabled="disabled"> 使用
				   </label>
				   <label class="checkbox-inline">
				      <input type="radio" name="dicDataActive"
				         value="1" disabled="disabled"> 禁用
				   </label>
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
			<button type="button" class="btn btn-danger" onclick="closePage()">关闭</button>
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
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
	</script>
</body>
</html>