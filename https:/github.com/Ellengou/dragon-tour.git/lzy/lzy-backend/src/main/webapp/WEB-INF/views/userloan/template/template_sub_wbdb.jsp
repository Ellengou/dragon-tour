<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">${borrowTypeName }</h3>
	</div>
	<div class="panel-body">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">担保人</h3>
			</div>
			<div class="panel-body">
				<table class = "table">
					<thead>
						<tr>
							<th>姓名</th>
							<th>电话</th>
							<th>身份证</th>
						</tr>
					</thead>
					<tbody id = "tbody_person">
					</tbody>
				</table>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">担保公司</h3>
			</div>
			<div class="panel-body">
				<table class = "table">
					<thead>
						<tr>
							<th>名称</th>
							<th>统一社会信用代码</th>
						</tr>
					</thead>
					<tbody id = "tbody_comp">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<script>
	var personList = $.parseJSON('${personList}');
	var compList = $.parseJSON('${compList}');
	var personTmp = "";
	for(var i=0;i<personList.length;i++){
		var obj = personList[i];
		personTmp+='<tr>';
		personTmp+='<td>'+obj.name+'</td>';
		personTmp+='<td>'+(obj.phone == null ? "-" : obj.phone)+'</td>';
		personTmp+='<td>'+(obj.idCard == null ? "-" : obj.idCard)+'</td>';
		personTmp+='</tr>';
	}
	$("#tbody_person").html(personTmp);
	var compTmp = "";
	for(var i=0;i<compList.length;i++){
		var obj = compList[i];
		compTmp+='<tr>';
		compTmp+='<td>'+obj.compName+'</td>';
		compTmp+='<td>'+(obj.creditCode == null ? "-" : obj.creditCode)+'</td>';
		compTmp+='</tr>';
	}
	$("#tbody_comp").html(compTmp);
</script>