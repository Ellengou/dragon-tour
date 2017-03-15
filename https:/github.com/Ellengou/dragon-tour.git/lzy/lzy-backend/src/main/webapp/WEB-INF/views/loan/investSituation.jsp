<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-body">
		<div>
			投资人数:<label>${investPersonCount }</label> 已投额度:<label>${investAmount }</label>
			剩余可投:<label>${surplusAmount }</label> 投标进度:<label>${investProgress }</label>
		</div>
		<hr>
		<table class="table" id="investTable">
			<thead>
				<tr>
					<th>角色</th>
					<th>名称</th>
					<th>手机</th>
					<th>投资金额</th>
					<th>投资时间</th>
					<th>所属核心企业</th>
					<th>所属子公司</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>


<script>
	var jsonData = eval('${jsonData}');
	var template = "";
	for (var i = 0; i < jsonData.length; i++) {
		var obj = jsonData[i];
		template += "<tr><td>";
		template += obj.type
		template += "</td><td>";
		template += obj.name
		template += "</td><td>";
		template += obj.phone
		template += "</td><td>";
		template += obj.invest_money
		template += "</td><td>";
		template += obj.operate_time
		template += "</td><td>";
		template += obj.comp_core_name
		template += "</td><td>";
		template += obj.company_name
		template += "</td></tr>";
	}
	$("#investTable tbody").append(template);
</script>