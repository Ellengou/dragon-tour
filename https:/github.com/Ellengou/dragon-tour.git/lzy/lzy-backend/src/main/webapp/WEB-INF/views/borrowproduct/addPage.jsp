<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<%@ include file="/WEB-INF/views/template/validator.jsp"%>
<style>
.placeholder {
	font-size: 11px;
	color: #aeaeae;
}
</style>
</head>
<body>
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="myForm">
									<div  class="form-group">
										<label class="col-xs-2 control-label">产品名称</label>
										<div class="input-group col-xs-10">
											<input type="text" class="form-control" name="name" id="name">
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-2 control-label">借款类型</label>
										<div class="input-group col-xs-10" id = "div_borrow_types">
											<table class="table table-bordered" id = "tb_borrow_type">
												<thead>
													<tr>
														<td>抵押</td>
														<td>信用</td>
														<td>担保</td>
														<td>质押</td>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td></td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-2 control-label">用途</label>
										<div class="input-group col-xs-10 checkbox">
											<label>
											  <input type="checkbox" name="useType" value="0" disabled="disabled"> 经营性
											</label>
											<label>
											  <input type="checkbox" name="useType" value="1" disabled="disabled"> 固定资产
											</label>
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-2 control-label">借款人对象</label>
										<div class="input-group col-xs-10 checkbox" id = "div_jkrdx">
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-2 control-label">状态</label>
										<div class="input-group col-xs-10 radio">
											<label>
											  <input type="radio" name="status" value="0"> 启用
											</label>
											<label>
											  <input type="radio" name="status" value="1"> 停用
											</label>
										</div>
									</div>
									<div  class="form-group">
										<div class="col-xs-12" style="text-align: center;">
											<button type="submit" class="btn btn-primary">保存</button>
											<button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
										</div>
									</div>
								</form>
								<hr>
							</div>
						</div>
					</div>
				</div>

<script src="<%=request.getContextPath()%>/bootstrap/js/util.js" type="text/javascript"></script>
<script>
	//$("#div_borrow_types").showList('checkbox',{infoList:'${borrowTypes}',column_value:'id',column_name:'name'});
	var borrowTypes = $.parseJSON('${borrowTypes}');
	for(var i = 0;i<borrowTypes.length;i++){
		var obj = borrowTypes[i];
		var tmp = '<input type="radio" onclick="changeUseType('+obj.has_use_type+');" name="borrowTypes" value="'+obj.id+'"';
		if(obj.status == 1){
			tmp += 'disabled="disabled"';
		}
		tmp += '>'+obj.name+'<br />';
		$("#div_borrow_types tbody td:eq("+obj.type+")").append(tmp);
	}
	var jkrdxs = $.parseJSON('${jkrdxs}');
	for(var i = 0;i<jkrdxs.length;i++){
		var obj = jkrdxs[i];
		var tmp = '<label><input type="checkbox" name="jkrdxs" value="'+obj.value+'">'+obj.name+'</label>&nbsp&nbsp&nbsp&nbsp';
		$("#div_jkrdx").append(tmp);
	}
	function save(){
		layer.msg('数据开始保存....',{offset:50});
		var jsonData = $("form").serialize();
		$.ajax({
		      url: '<%=request.getContextPath()%>/admin/borrowProduct/save',
		      dataType: 'json',
		      type: 'POST',
		      data: jsonData,
		      success: function (data) {
		    	 if(data.status == 'ok'){
		    		 layer.alert('保存成功', {
	                        icon: 1,
	                        offset:50
	                  },function(index){
	                	  var parIndex = parent.layer.getFrameIndex(window.name);
	                	  layer.close(index);
	                	  parent.location.reload();
	                	  parent.layer.close(parIndex);
	                  });

		    	}else{
		    		layer.alert(data.msg, {
						icon : 5
					});
		    	}
		      },
		      error: function(){
		    	  layer.alert('数据保存出错', {
						icon : 5
					});
		      }
		  });
	}
	
	function changeUseType(target){
		if('0' == target){
			$("input[name='useType']").attr('disabled',false);
		}else if('1' == target){
			$("input[name='useType']").attr('checked',false).attr('disabled',true);
		}
	}
	
	$(document).ready(function(){
		
			$('#myForm').validate_popover({
	            onsubmit:true,
	            popoverPosition: 'right',
	            rules: {
	            	name:"required"
	            },
	            submitHandler: function (form) {
	                save();
	            }
	        });
			
		});
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
</script>
</body>
</html>