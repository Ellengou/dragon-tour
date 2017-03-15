<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">供应商账户信息</h3>
	</div>
	<div class="panel-body">
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">账户类型</span> <input type="text"
						class="form-control" id="businessType" value=""
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">银行名称</span> <input type="text"
						class="form-control" id="userFrontName"
						value="${bankName}" disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">开户行所在地</span> <input type="text"
						class="form-control" id="pledgeCompanyName"
						value="${bankCard.open_areacode}" disabled="disabled">
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">开户名</span> <input type="text"
						class="form-control" id="businessType" value="${bankCard.name }"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">银行卡号</span> <input type="text"
						class="form-control" id="userFrontName"
						value="${bankCard.bank_no}" disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">开户支行</span> <input type="text"
						class="form-control" id="pledgeCompanyName" value="${bankCard.open_name }"
						disabled="disabled">
				</div>
			</div>
		</div>
	</div>
</div>