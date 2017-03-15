<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
<link href="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
</head>
<body>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-12">
							<form id="myForm">
							<div class="row">
								<div class="col-xs-4">
		                            <div class="input-group">
		                                <span class="input-group-addon">咨询方式</span>
		                                <select class="form-control" id="consultingApproach" >
											<option value="">全部</option>
		                                </select>
		                            </div>
		                        </div>
		                        <div class="col-xs-4">
		                            <div class="form-group input-group">
		                                <span class="input-group-addon">咨询类型</span>
		                                <select class="form-control" id="consultingBusiness">
											<option value="">全部</option>
		                                </select>
		                            </div>
		                        </div>
		                        <div class="col-xs-4">
		                            <div class="form-group input-group">
		                                <span class="input-group-addon">处理状态</span>
		                                <select class="form-control" id="status" >
		                                    <option value="">全部</option>
		                                </select>
		                            </div>
		                        </div>
							</div>
							<div class="row">
								<div class="col-xs-2">
									<button type="button" class="btn btn-primary btn-sm" onclick="search(1)">查询</button>
								</div>
							</div>
							</form>
						</div>
					</div>
				</div>
				
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/ipcc/detail/list?phone=${phone}"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th data-field="phone">呼入电话</th>
									<th data-field="consulting_approach" data-call="true">咨询途径</th>
									<th data-field="status" data-call="true">咨询状态</th>
									<th data-field="consulting_business" data-call="true">咨询类型</th>
									<th data-field="operate_time">操作时间</th>
									<th data-field="button" data-call="true">操作</th>
								</tr>
							</thead>
							<tbody id="tbodyId">

							</tbody>
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
	<script src="<%=request.getContextPath()%>/bootstrap/js/util.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>
    <script src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	var approachList = $.parseJSON('${approachList}');
	var statusList = $.parseJSON('${statusList}');
	var businessList = $.parseJSON('${businessList}');
	function tableCallBack(data,id){
        if (id == 'status') {
            for(var i=0;i<statusList.length;i++){
            	var obj = statusList[i];
            	if(data[id] == obj.dicDataValue){
            		return obj.dicDataName;
            	}
            }
        }else if(id == 'consulting_approach'){
        	for(var i=0;i<approachList.length;i++){
            	var obj = approachList[i];
            	if(data[id] == obj.dicDataValue){
            		return obj.dicDataName;
            	}
            }
        }else if(id == 'consulting_business'){
        	for(var i=0;i<businessList.length;i++){
            	var obj = businessList[i];
            	if(data[id] == obj.id){
            		return obj.name;
            	}
            }
        }else if (id == 'button') {
            var _button = '';
            _button += '<button type="button" class="btn btn-primary btn-xs" onclick="view(' + data.id + ');">查看</button> ';

            return _button;
        } else {
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }
	
	function view(id){
		layer.open({
			type: 2,
			area: ['100%', '100%'],
			content: ['<%=request.getContextPath()%>/admin/ipcc/detail/edit?detailId=' + id, 'no']
		});
	}
	
	
	$(document).ready(function(){
		
        for (var i = 0; i < approachList.length; i++) {
            $(new Option(approachList[i].dicDataName, approachList[i].dicDataValue)).appendTo('#consultingApproach');
        }

        for (var i = 0; i < statusList.length; i++) {
            $(new Option(statusList[i].dicDataName, statusList[i].dicDataValue)).appendTo('#status');
        }

        for (var i = 0; i < businessList.length; i++) {
            $(new Option(businessList[i].name, businessList[i].id)).appendTo('#consultingBusiness');
        }		
	});
	</script>
</body>
</html>