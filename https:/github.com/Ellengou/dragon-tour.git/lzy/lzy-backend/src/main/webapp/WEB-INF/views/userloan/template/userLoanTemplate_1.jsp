<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">借款基础信息(经销商)</h3>
	</div>
	<div class="panel-body">
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款人姓名</span> <input type="text"
						class="form-control" id="surplusMoney" value="${loan.loanerName }"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款额度</span> <input type="text"
						class="form-control" id="" value="${loan.loanMoney }"
						disabled="disabled"> <span class="input-group-addon">元</span>
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款人手机</span> <input type="text"
						class="form-control"
						value="${loan.loanerPhone }" disabled="disabled">
				</div>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款产品</span> <input type="text"
						class="form-control" id="borrowProduct" value="${borrowProduct}"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款期限</span> <input type="text"
						class="form-control" id="" value="${loan.deadLine }"
						disabled="disabled"> <span class="input-group-addon">天</span>
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款年利率</span> <input type="text"
						class="form-control" id="surplusMoney" value="${loan.investRate }"
						disabled="disabled"> <span class="input-group-addon">%</span>
				</div>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">贴息利率</span> <input type="text"
						class="form-control"
						value="${loan.serviceRate }" disabled="disabled">
						<span class="input-group-addon">%</span>
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">还款日</span> <input type="text"
						class="form-control" value="${loan.repayDate }"
						disabled="disabled"><span class="input-group-addon">号</span>
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">还款方式</span> <input type="text"
						class="form-control" id="" value="${loanType }"
						disabled="disabled">
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款编号</span> <input type="text"
						class="form-control" id="serialNum" value="${loan.serialNum }"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款用途</span> <input type="text"
						class="form-control" id="surplusMoney"
						value="${loan.loanMoneyDes }" disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">申请时间</span> <input type="text"
						class="form-control" id="createDate" value="${createTime}"
						disabled="disabled">
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">经销商名称</span> <input type="text"
						class="form-control" id="frontUserName"
						value="${loan.frontUserName}" disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">资金来源</span> <input type="text"
						class="form-control" id="" value="${moneySourceName }" disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">合同号</span> <input type="text"
						class="form-control" value="${loan.contractNumber }"
						disabled="disabled">
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">经办人姓名</span> <input type="text"
						class="form-control" id="" value="${loan.operatorName }"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">经办人手机</span> <input type="text"
						class="form-control" id="" value="${loan.operatorPhone }"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">数据来源</span> <input type="text"
						class="form-control"
						value="${loan.dataSource }" disabled="disabled">
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">授信额度</span> <input type="text"
						class="form-control" id="" value="${sysUserSupp.creditLimit }"
						disabled="disabled"> <span class="input-group-addon">元</span>
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">已使用额度</span> <input type="text"
						class="form-control" id="" value="${sysUserSupp.receivableMoney }"
						disabled="disabled"> <span class="input-group-addon">元</span>
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">剩余可借</span> <input type="text"
						class="form-control" id="surplusMoney"
						value="${sysUserSupp.balanceCredit }" disabled="disabled">
					<span class="input-group-addon">元</span>
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">借款人对象</span> <input type="text"
						class="form-control" id="businessType" value="${businessType}"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">状态</span> <input type="text"
						class="form-control" value="${loanStatuName }"
						disabled="disabled">
				</div>
			</div>
		</div>
	</div>
</div>