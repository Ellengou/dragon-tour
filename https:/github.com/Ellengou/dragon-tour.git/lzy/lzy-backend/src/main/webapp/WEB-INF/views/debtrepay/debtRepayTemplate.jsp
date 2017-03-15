<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">借款还款情况</h3>
	</div>
	<div class="panel-body">
		<table class="table">
			<thead>
				<tr>
					<th>期数</th>
					<th>应还本金(元)</th>
					<th>实还本金(元)</th>
					<th>应还利息(元)</th>
					<th>实还利息(元)</th>
					<th>应还贴息(元)</th>
					<th>实还贴息(元)</th>
					<th>还款日</th>
					<th>本期天数</th>
					<th>实际还款时间</th>
					<th>状态</th>
				</tr>
			</thead>
			<tbody id = "tbody_repaydetail">
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
			temp+='<td>'+obj.period+'</td>';
			temp+='<td>'+obj.corpus+'</td>';
			temp+='<td>'+obj.actual_money+'</td>';
			temp+='<td>'+obj.interest+'</td>';
			temp+='<td>'+obj.actual_interest+'</td>';
			temp+='<td>'+obj.txInterest+'</td>';
			temp+='<td>'+obj.actual_txInterest+'</td>';
			temp+='<td>'+obj.repay_date+'</td>';
			temp+='<td>'+obj.lengths+'</td>';
			temp+='<td>'+obj.repay_time+'</td>';
			temp+='<td>'+obj.status_name+'</td>';
			temp+='</tr>';
		}
		$("#tbody_repaydetail").html(temp);
	}
</script>