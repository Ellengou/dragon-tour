<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<link
	href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
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
		<table class="table">
			<thead>
				<tr>
					<th>操作人</th>
					<th>操作时间</th>
					<th>还款本金(元)</th>
					<th>还款利息(元)</th>
					<th>还款贴息(元)</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>
<%@ include file="/WEB-INF/views/template/bootMainJs.jsp"%>
<script>
	var list = '${list }';
	if('' != list){
		list = $.parseJSON(list);
		var temp = '';
		for(var i=0;i<list.length;i++){
			var obj = list[i];
			temp+='<tr>';
			temp+='<td>'+obj.user_name+'</td>';
			temp+='<td>'+obj.operate_time+'</td>';
			temp+='<td>'+obj.corpus+'</td>';
			temp+='<td>'+obj.interest+'</td>';
			temp+='<td>'+obj.tx_interest+'</td>';
			temp+='</tr>';
		}
		$("tbody").html(temp);
	}
</script>
</body>
</html>