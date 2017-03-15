<%--
  Created by IntelliJ IDEA.
  Detail: violorch
  Date: 2016/5/16
  Time: 9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工查询</title>
    <%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
    <!-- bootstrap-datetimepicker -->
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
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">经销商名称</span>
                                        <input type="text" class="form-control" id="custname">
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">最小信用额度</span>
                                        <input type="text" class="form-control" id="mincredit">
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">最大信用额度</span>
                                        <input type="text" class="form-control" id="maxcredit">
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="search(1)">查询</button>
                                    <button type="button" class="btn btn-primary btn-sm" onclick="$('#myForm')[0].reset();">重置</button>
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
                           data-url="<%=request.getContextPath()%>/admin/market/queryDealers"
                           data-pageSize="10,50,100" data-method="GET">
                        <thead>
                        <tr>
                            <th width="20%" data-field="custname">经销商名称</th>
                            <th width="20%" data-field="unitshortname">关联单位</th>
                            <th width="25%" data-field="mobilephone">联系电话</th>
                            <th width="20%" data-field="credit">信用额度</th>
                            <th width="20%" data-field="button" data-call="true">操作</th>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/utils.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>
<!-- bootstrap-datetimepicker -->
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
<script>
	function tableCallBack(data, id){
	    if(id == 'button') {
	    	return '<button type="button" class="btn btn-primary btn-xs" onclick="viewDetail(\'' + data.custcode + '\',\'' + data.pk_corp + '\');">查看</button> ';
	    }
	}

    function viewDetail(custcode, pk_corp) {
    	var index = layer.open({
    	    type: 2,
    	    area: ['900px', '500px'],
    	    offset: [100,(($(window).width()-900)/2)],
    	    title: '经销商详情',
    	    content: ['<%=request.getContextPath()%>/admin/market/dealerDealPage?custcode=' + custcode + '&pk_corp=' + pk_corp,'yes']
    	});
    	layer.full(index);
    }
</script>
</body>
</html>