<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">${borrowTypeName }</h3>
	</div>
	<div class="panel-body">
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">质押公司</span> <input type="text"
						class="form-control" id="pledgeCompanyName" value="${sub.pledgeCompanyName }"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">止付公司</span> <input type="text"
						class="form-control" id="payCompanyName"
						value="${sub.payCompanyName}" disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">质押金额</span> <input type="text"
						class="form-control" id="pledgeAmount"
						value="${sub.pledgeAmount}" disabled="disabled">
						<span class="input-group-addon">元</span>
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">统一社会信用代码</span> <input type="text"
						class="form-control" id="creditCode" value="${sub.creditCode }"
						disabled="disabled">
				</div>
			</div>
		</div>
	</div>
</div>