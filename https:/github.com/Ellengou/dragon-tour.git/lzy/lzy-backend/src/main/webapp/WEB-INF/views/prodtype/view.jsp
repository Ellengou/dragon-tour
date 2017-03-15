<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<style>
    .placeholder {
        font-size: 11px;
        color: #aeaeae;
    }
</style>
</head>
<body>
<shiro:hasPermission name="product:company:set">
    <input id="p_set" style="display: none" value="1">
</shiro:hasPermission>

	<div id="page-wrapper" style="padding: 0 15px;">
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3>${compName }理财产品</h3>
					</div>
					<div class="panel-body">
						<table class="table">
							<thead>
								<tr>
									<th>名称</th>
									<th>类别</th>
									<th>状态</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
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
		var list = '${list}';
		if('' != list){
			list = $.parseJSON(list);
			for(var i=0;i<list.length;i++){
				var obj = list[i];
				var html = '';
				html+='<tr>';
				html+='<td>'+obj.name+'</td>';
				html+='<td>'+getType(obj.pid)+'</td>';
				html+='<td>'+getState(obj.status)+'</td>';
				html+='<td>'+getButton(obj.comp_core_id,obj.prod_type_id,obj.status)+'</td>';
				html+='</tr>';
				$('.table tbody').append(html);
			}
		}
	
		function getState(state){
			if('0' == state){
				return '启用';
			}else{
				return '停用'
			}
		}
		function getButton(compCoreId,prodTypeId,state){
			var str = '';
			if('0' == state){
				if($("#p_set").val() == 1){
					str += '<button type="button" class="btn btn-danger" onclick="opStatus('+prodTypeId+')">停用</button>'
				}
			}else{
				if($("#p_set").val() == 1){
					str += '<button type="button" class="btn btn-success" onclick="opStatus('+prodTypeId+')">启用</button>'
				}
			}
			return str;
		}
		function opStatus(prodTypeId){
			layer.confirm('确认操作？', {
			  btn: ['确认', '取消']
			}, function(index, layero){
			  $.ajax({
				  url : '<%=request.getContextPath()%>/companyProdType/opStatus',
				  data : {compCoreId : '${companyId}',prodTypeId : prodTypeId},
				  dataType : 'json',
				  success : function(data){
					  if(data.status == 'ok'){
						  alert('保存成功');
						  window.location.reload();
					  }
				  }
			  })
			}, function(index){
			});
		}
		function getType(pid){
			if(pid == '1'){
				return '定期';
			}else if(pid == '2'){
				return '活期';
			}else{
				return '未知';
			}
		}
	</script>
</body>
</html>