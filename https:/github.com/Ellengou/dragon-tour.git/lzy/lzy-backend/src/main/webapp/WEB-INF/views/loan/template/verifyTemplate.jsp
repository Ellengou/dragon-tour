<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<table class="table">
		<thead>
			<tr>
				<th>审核类型</th>
				<th>审核时间</th>
				<th>审核结果</th>
				<th>审核人员</th>
				<th>审核备注</th>
			</tr>
		</thead>
		<tbody onclick="showVerify()" style="cursor: pointer;">
			<tr>
				<td>发标-核心企业审核</td>
				<td>${userVerifyTime}</td>
				<td>${scfLoan.userStatus}</td>
				<td>${verifyFrontName}</td>
				<td>${scfLoan.reasonUser}</td>
			</tr>
			<tr>
				<td>发标-平台审核</td>
				<td>${sysVerifyTime}</td>
				<td>${scfLoan.sysStatus}</td>
				<td>${verifyAdminName}</td>
				<td>${scfLoan.reasonSys}</td>
			</tr>
			<tr>
				<td>满标审核</td>
				<td>${userVerifyTime1}</td>
				<td>${scfLoan.userStatus1}</td>
				<td>${verifyMoneyName}</td>
				<td>${scfLoan.reasonUser1}</td>
			</tr>
		</tbody>
	</table>
</div>
<script>
function showVerify(){
	var index = layer.open({
        type: 2,
        title: false,
        content: '<%=request.getContextPath()%>/admin/project/loan/viewVerify?id=${scfLoan.id}'
    });
	layer.full(index);
}
</script>