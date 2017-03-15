<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">产品信息</h3>
	</div>
	<div class="panel-body">
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">产品申请名称</span> <input type="text"
						class="form-control" id="applyName" value="${scfLoan.applyName}"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">产品发布名称</span> <input type="text"
						class="form-control" id="showName" value="${scfLoan.showName}"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">产品规模</span> <input type="text"
						class="form-control" id="productScale"
						value="${loanMoney }" disabled="disabled">
					<span class="input-group-addon">元</span>
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">最小投资额度</span> <input type="text"
						class="form-control" id="minInvestMoney"
						value="${minInvestMoney}" disabled="disabled">
					<span class="input-group-addon">元</span>
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">最大投资额度</span> <input type="text"
						class="form-control" id="maxInvestMoney"
						value="${maxInvestMoney}" disabled="disabled">
					<span class="input-group-addon">元</span>
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">标的状态</span> <input type="text"
						class="form-control" id="loanStatus" value="${scfLoan.loanStatus}"
						disabled="disabled">
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">产品期限</span> <input type="text"
						class="form-control" id="productLine"
						value="${scfLoan.productLine}" disabled="disabled">
					<span class="input-group-addon">天</span>
				</div>
			</div>
			<div class="col-xs-8">
				<div class="input-group">
					<span class="input-group-addon">产品适用对象</span> <input type="text"
						class="form-control" id="investType" value="${scfLoan.investType}"
						disabled="disabled">
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">产品所属系列</span> <input type="text"
						class="form-control" id="type" value="${prodType}"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">产品年利率</span> <input type="text"
						class="form-control" id="borrowRate" value="${scfLoan.investRate}"
						disabled="disabled">
					<span class="input-group-addon">%</span>
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">筹标期限</span> <input type="text"
						class="form-control" id="deadLine" value="${scfLoan.deadLine}"
						disabled="disabled">
					<span class="input-group-addon">天</span>
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">奖励类型</span> <input type="text"
						class="form-control" id="loanPrizeType"
						value="${scfLoan.loanPrizeType}" disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">还款方式</span> <input type="text"
						class="form-control" id="loanType" value="${scfLoan.loanType}"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">还款日</span> <input type="text"
						class="form-control" id="repayDate" value="${scfLoan.repayDate}"
						disabled="disabled">
					<span class="input-group-addon">日</span>
				</div>
			</div>
			
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">计息方式</span> <input type="text"
						class="form-control" id="loanType" value="${scfLoan.rateCalculateType}"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">产品发布人</span> <input type="text"
						class="form-control" id="createUserName" value="${createUserName}"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">发布公司</span> <input type="text"
						class="form-control" id="companyName" value="${companyName}"
						disabled="disabled">
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">发布时间</span> <input type="text"
						class="form-control" id="" value="${upInvestTime }" disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">开售时间</span> <input type="text"
						class="form-control" id="createUserName" value="${startInvestTime}"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">筹标进度</span> <input type="text"
						class="form-control" id="" value="${percent }" disabled="disabled">
					<span class="input-group-addon">%</span>
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">标的性质</span> <input type="text"
						class="form-control" id="scfElemId" value="${scfElemId}"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">点击次数</span> <input type="text"
						class="form-control" id="" value="${scfLoan.clickTimes }"
						disabled="disabled">
				</div>
			</div>
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">递增额度</span> <input type="text"
						class="form-control" id="" value="${scfLoan.increaselMoney }"
						disabled="disabled">
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-4">
				<div class="input-group">
					<span class="input-group-addon">展示序号</span> <input type="text"
						class="form-control" id="showOrder" value="${scfLoan.showOrder}"
						disabled="disabled">
				</div>
			</div>
		</div>
	</div>
</div>