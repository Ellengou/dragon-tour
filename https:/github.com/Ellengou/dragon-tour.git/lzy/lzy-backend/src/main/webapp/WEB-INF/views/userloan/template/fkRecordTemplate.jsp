<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">标的放款记录</h3>
	</div>
	<div class="panel-body">
		<table class="table">
			<thead>
				<tr>
					<th>产品编号</th>
					<th>名称</th>
					<th>放款人</th>
					<th>放款时间</th>
					<th>状态</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>
<script>
	var list = '${list }';
	if('' != list){
		list = $.parseJSON(list);
		var temp = '';
		for(var i=0;i<list.length;i++){
			var obj = list[i];
			temp+='<tr>';
			temp+='<td>'+obj.serial_num+'</td>';
			temp+='<td>'+obj.show_name+'</td>';
			temp+='<td>'+obj.advance_money_name+'</td>';
			temp+='<td>'+obj.give_money_time+'</td>';
			temp+='<td>'+obj.loan_status_name+'</td>';
			temp+='</tr>';
		}
		$("tbody").html(temp);
	}
</script>