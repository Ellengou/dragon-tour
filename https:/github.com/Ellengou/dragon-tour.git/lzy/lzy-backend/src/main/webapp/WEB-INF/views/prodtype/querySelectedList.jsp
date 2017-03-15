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
					<div class="panel-body">
						<table class="table">
							<thead>
								<tr>
									<th>产品适用对象</th>
									<th>状态</th>
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
		var scf_loan_cpsydx = '${scf_loan_cpsydx}';
		var prodTypeId = '${prodTypeId}';
		if('' != scf_loan_cpsydx){
			scf_loan_cpsydx = $.parseJSON(scf_loan_cpsydx);
			for(var i=0;i<scf_loan_cpsydx.length;i++){
				var obj = scf_loan_cpsydx[i];
				var html = '';
				html+='<tr>';
				html+='<td>'+obj.dicDataName+'</td>';
				html+='<td>'+getState(obj.dicDataValue)+'</td>';
				html+='</tr>';
				$('.table tbody').append(html);
			}
		}
	
		function getState(userTypeId){
			var list = '${list}';
			if('' != list){
				list = $.parseJSON(list);
				for(var i = 0;i<list.length;i++){
					var obj = list[i];
					var type = obj.userTypeId;
					if(type == userTypeId){
						return '<input type="checkbox" value="'+userTypeId+'" checked="checked" onclick="opStatus(this)">';
					}
				}
			}
			return '<input type="checkbox" value="'+userTypeId+'" onclick="opStatus(this)">';
		}
		function opStatus(target){
			var $this = $(target);
			var val = $this.val();
			var checked = $this.prop('checked');
			var status;
			if(true == checked){
				status = '0';
			}else{
				status = '1';
			}
			layer.confirm('确认操作？', {
			  btn: ['确认', '取消']
			}, function(index, layero){
			  $.ajax({
				  url : '<%=request.getContextPath()%>/produserconn/save',
				  data : {prodTypeId : prodTypeId,userTypeId:val,status:status},
				  dataType : 'json',
				  success : function(data){
					  if(data.status == 'ok'){
						  window.location.reload();
					  }
				  }
			  })
			}, function(index){
				$this.prop('checked',!checked);
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