<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">借款人信息（供应商）</h3>
	</div>
	<div class="panel-body">
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款人对象</span> <input type="text"
						class="form-control" id="businessType"
						value="${scfLoan.businessType}" disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">供应商名称</span> <input type="text"
						class="form-control" id="userFrontName"
						value="${scfLoan.userFrontName}" disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">质押公司</span> <input type="text"
						class="form-control" id="pledgeCompanyName"
						value="${scfLoan.pledgeCompanyName}" disabled="disabled">
				</div>
			</div>

		</div>
		<br>
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">申请时间</span> <input type="text"
						class="form-control" id="createDate" value="${createDate}"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款产品</span> <input type="text"
						class="form-control" id="prodType" value="${borrowProduct}"
						disabled="disabled">
				</div>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">授信额度</span> <input type="text"
						class="form-control" id="" value="${creditLimit }"
						disabled="disabled">
					<span class="input-group-addon">元</span>
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">已使用额度</span> <input type="text"
						class="form-control" id="" value="${receivableMoney }"
						disabled="disabled">
					<span class="input-group-addon">元</span>
				</div>
			</div>

			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">剩余可借</span> <input type="text"
						class="form-control" id="surplusMoney" value="${balanceCredit }"
						disabled="disabled">
					<span class="input-group-addon">元</span>
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款额度</span> <input type="text"
						class="form-control" id="" value="${productScale }"
						disabled="disabled">
					<span class="input-group-addon">元</span>
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款期限</span> <input type="text"
						class="form-control" id="" value="${scfLoan.productLine }"
						disabled="disabled">
					<span class="input-group-addon">天</span>
				</div>
			</div>

			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款年利率</span> <input type="text"
						class="form-control" id="surplusMoney" value="${scfLoan.borrowRate }"
						disabled="disabled">
					<span class="input-group-addon">%</span>
				</div>
			</div>
		</div>
	</div>
</div>