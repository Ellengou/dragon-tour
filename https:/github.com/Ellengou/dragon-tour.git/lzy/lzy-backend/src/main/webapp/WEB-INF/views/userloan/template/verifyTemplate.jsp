<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<table class="table">
		<thead>
			<tr>
				<th>审核时间</th>
				<th>审核状态</th>
				<th>审核人员</th>
				<th>审核原因</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${verifyTime}</td>
				<td>${verifyStatus}</td>
				<td>${verifyUserName}</td>
				<td>${loan.verifyReason}</td>
			</tr>
		</tbody>
	</table>
</div>