<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	<div id="page-wrapper" style="padding: 0 15px;">
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3>${borrowName }</h3><button type="button" class="btn btn-primary" onclick="add()">新增</button>
					</div>
					<div class="panel-body">
						<table class="table">
							<thead>
								<tr>
									<th>序号</th>
									<th>协议名称</th>
									<th>状态</th>
									<th>具体内容</th>
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
				html+='<td>'+(i+1)+'</td>';
				html+='<td>'+obj.name+'</td>';
				html+='<td>'+getStatus(obj.status)+'</td>';
				html+='<td>'+getDetail(obj.detail)+'</td>';
				html+='</tr>';
				$('.table tbody').append(html);
			}
		}
	
		function getDetail(detail){
			if('0' == detail){
				return '无';
			}else if('1' == detail){
				return '有';
			}
		}
		
		function getStatus(status){
			if('0' == status)
				return '启用';
			else
				return '停用';
		}
		
		function add(){
			layer.open({
	    	    type: 2,
	    	    area: ['500px', '400px'],
	    	    title: false,
	    	    content: '<%=request.getContextPath()%>/admin/protocolType/addBorrowTypeProPage?borrowTypeId=${borrowTypeId}'
	    	});
		}
	</script>
</body>
</html>