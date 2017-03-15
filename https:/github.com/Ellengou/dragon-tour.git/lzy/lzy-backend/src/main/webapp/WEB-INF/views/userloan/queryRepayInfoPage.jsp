<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<title>后台管理系统</title>
<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
<link
	href="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"
	rel="stylesheet">
</head>
<body>
	<shiro:hasPermission name="userloan:hk:save">
		<input id="p_hksave" style="display: none" value="1">
	</shiro:hasPermission>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-12">
							<form id="myForm"></form>
						</div>
					</div>
				</div>

				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/userloan/queryRepayInfo?id=${id}"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th data-field="period">期数</th>
									<th data-field="serial_num">编号</th>
									<th data-field="frontUserName">供应商名称</th>
									<th data-field="lengths">本期天数</th>
									<th data-field="repay_time">还款时间</th>
									<th data-field="repay_date">还款日</th>
									<th data-field="corpus">应还本金(元)</th>
									<th data-field="actual_money">实还本金(元)</th>
									<th data-field="interest">应还利息(元)</th>
									<th data-field="actual_interest">实还利息(元)</th>
									<th data-field="txInterest">应还贴息(元)</th>
									<th data-field="actual_txInterest">实还贴息(元)</th>
									<th data-field="qianqian" data-call="true">欠钱(元)</th>
									<th data-field="statusName">状态</th>
									<th data-field="button" data-call="true">操作</th>
								</tr>
							</thead>
							<tbody id="tbodyId">

							</tbody>
						</table>
					</div>
					<div class="row">
						<table class="table table-bordered text-center">
							<tr>
								<!-- <td colspan="3">本页</td> -->
								<td colspan="4">全部还款记录统计</td>
							</tr>
							<tr>
								<!-- <td>应还金额:<span id = "corpus_cur"></span></td>
								<td>应还利息:<span id = "interest_cur"></span></td>
								<td>应还贴息:<span id = "txInterest_cur"></span></td> -->
								<td>应还金额:<span id = "count_all_all"></span></td>
								<td>应还本金:<span id = "corpus_all"></span></td>
								<td>应还利息:<span id = "interest_all"></span></td>
								<td>应还贴息:<span id = "txInterest_all"></span></td>
							</tr>
							<tr>
								<!-- <td>实还金额:<span id = "actual_money_cur"></span></td>
								<td>实还利息:<span id = "actual_interest_cur"></span></td>
								<td>实还贴息:<span id = "acual_txInterest_cur"></span></td> -->
								<td>实还金额:<span id = "count_actual_all_all"></span></td>
								<td>实还本金:<span id = "actual_money_all"></span></td>
								<td>实还利息:<span id = "actual_interest_all"></span></td>
								<td>实还贴息:<span id = "actual_txInterest_all"></span></td>
							</tr>
							<tr>
								<td>剩余金额:<span id = "sy_count_all_all"></span></td>
								<td>剩余本金:<span id = "sy_corpus_all_all"></span></td>
								<td>剩余利息:<span id = "sy_interest_all_all"></span></td>
								<td>剩余贴息:<span id = "sy_txInterest_all_all"></span></td>
							</tr>
						</table>
					</div>
					<div class="row">
						<div align="left" class="col-xs-6">
							<div class="input-group">
								<span class="input-group-addon" id="pageCount"></span> <select
									id="pageSize" onchange="search(1)" class="form-control"
									style="width: 100px"></select>
							</div>
						</div>
						<div align="right" class="col-xs-6">
							<ul class="pagination" id="pagination"></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/template/bootMainJs.jsp"%>
	<script src="<%=request.getContextPath()%>/bootstrap/js/util.js"
		type="text/javascript"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>
	<script
		src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"
		type="text/javascript"></script>
	<script
		src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js"
		type="text/javascript"></script>

	<%@ include file="/WEB-INF/views/userloan/template/template_script.jsp"%>
	<script type="text/javascript">
	function tableCallBack(data,id){
		if(id=='qianqian'){
			var count=((data['corpus']+data['interest']+data['txInterest'])-(data['actual_money']+data['actual_interest']+data['actual_txInterest'])).toFixed(2);
			if(count>0){
				return '<font color="#FF0000">'+count+'</font>';
			}else{
				return count;
			}
			//return ((data['corpus']+data['interest']+data['txInterest'])-(data['actual_money']+data['actual_interest']+data['acual_txInterest'])).toFixed(2);
		
		}else  if(id == 'button'){
        	var str = '';
        	if($("#p_hksave").val() == 1){
        		if(data.status != 'complete'){
		        	str += '<button type="button" class="btn btn-primary btn-xs" onclick="repayPage(\'' + data.id + '\');">还款</button>';;
        		}
        	}
        	str += '<button type="button" class="btn btn-primary btn-xs" onclick="repayDetail(\'' + data.id + '\','+data['period']+');">明细</button>';;
        	return str;
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }
	
	function repayDetail(id,period){
		layer.open({
    	    type: 2,
    	    area: ['600px', '450px'],
    	    offset: [100,(($(window).width()-600)/2)],
    	    title: '第 '+period+' 期还款明细',
    	    content: '<%=request.getContextPath()%>/debtRepay/repayDetail?id='+ id
		});
	}
	
	function repayPage(id){
		layer.open({
    	    type: 2,
    	    area: ['600px', '450px'],
    	    offset: [100,(($(window).width()-600)/2)],
    	    title: '还款',
    	    content: '<%=request.getContextPath()%>/debtRepay/repayPage?id='+ id
		});
	}
	</script>
</body>
</html>