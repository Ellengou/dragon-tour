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
    <title>后台管理系统</title>
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
                                <div class="col-xs-4">
                                    <div class="input-group">
                                        <span class="input-group-addon">姓名|编号</span>
                                        <input type="text" class="form-control" id="name">
                                        <input type="hidden" id="userId" value="${userId}">
                                    </div>
                                </div>
                                <%--<div class="col-xs-2">--%>
                                <%--<div class="input-group">--%>
                                <%--<span class="input-group-addon">员工编号</span>--%>
                                <%--<input type="text" class="form-control" id="empno">--%>
                                <%--</div>--%>
                                <%--</div>--%>
                                <%--<div class="col-xs-2">--%>
                                <%--<div class="input-group">--%>
                                <%--<span class="input-group-addon">手机号</span>--%>
                                <%--<input type="text" class="form-control" id="phone">--%>
                                <%--</div>--%>
                                <%--</div>--%>
                                <div class="col-xs-4">
                                    <div class="input-group">
                                        <span class="input-group-addon">费用类型</span>
                                        <select class="form-control" id="typeType" onchange="changeTypeInfo()">
                                            <option value="-1">全部</option>
                                            <option value="0">收入</option>
                                            <option value="1">支出</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xs-4">
                                    <div class="input-group">
                                        <span class="input-group-addon">费用名称</span>
                                        <select class="form-control" id="typeInfo">
                                            <option value="">全部</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">公司名称</span>
                                        <input type="text" class="form-control" id="compName">
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div id="dstart" class="input-group date form_datetime col-md-12">
                                        <span class="input-group-addon">开始日期</span>
                                        <input id="startDate" name="startDate" class="form-control" size="16" type="text" value="" readonly>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div id="dend" class="input-group date form_datetime col-md-12">
                                        <span class="input-group-addon">结束日期</span>
                                        <input id="endDate" name="endDate" class="form-control" size="16" type="text" value="" readonly>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="search(1)">查询</button>
                                    <button type="button" class="btn btn-primary btn-sm" onclick="$('#myForm')[0].reset();">重置</button>
                                    <shiro:hasPermission name="fund:detailSuccess:export">
                                        <button type="button" class="btn btn-primary btn-sm" onclick="exportFund();">导出</button>
                                    </shiro:hasPermission>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <font size="4">&nbsp;&nbsp;收入合计：<span id="inCome_all">0.00</span>&nbsp;&nbsp;</font>
                    <font size="4">&nbsp;&nbsp;支出合计：<span id="outCome_all">0.00</span>&nbsp;&nbsp;</font>
                    <font size="4">&nbsp;&nbsp;总资产合计：<span id="total_all">0.00</span>&nbsp;&nbsp;</font>
                    <font size="4">&nbsp;&nbsp;可用总额合计：<span id="balance_all">0.00</span>&nbsp;&nbsp;</font>
                    <font size="4">&nbsp;&nbsp;冻结总额合计：<span id="frozenMoney_all">0.00</span>&nbsp;&nbsp;</font>
                </div>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table id="myTable"
                           class="table table-striped table-bordered table-hover"
                           data-url="<%=request.getContextPath()%>/admin/fund/detailSuccess/json?type=0"
                           data-pageSize="10,50,100" data-method="GET">
                        <thead>
                        <tr>
                            <th width="5%" data-field="id">ID</th>
                            <th width="7%" data-field="name">姓名</th>
                            <th width="8%" data-field="empno">员工编号</th>
                            <th width="10%" data-field="compName">所属公司</th>
                            <%--<th width="10%" data-field="phone">手机号</th>--%>
                            <th width="6%" data-field="inCome">收入</th>
                            <th width="6%" data-field="outCome">支出</th>
                            <%--<th width="9%" data-field="money" >费用金额</th>--%>
                            <th width="13%" data-field="typeInfo" data-call="true">费用名称</th>
                            <th width="8%" data-field="total" >总资产</th>
                            <th width="8%" data-field="balance" >可用总额</th>
                            <th width="8%" data-field="frozenMoney" >冻结总额</th>
                            <th width="5%" data-field="type">类型</th>
                            <th width="14%" data-field="operateTime" data-call="true">操作时间</th>
                            <%--<th width="8%" data-field="remark" >备注</th>--%>
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
<script type="text/javascript">
    var operateInfoSR;
    var operateInfoZC;
    var operateInfo;
    $(function(){
        operateInfoSR = $.parseJSON('${operateInfoSR}');
        operateInfoZC = $.parseJSON('${operateInfoZC}');
        operateInfo = $.parseJSON('${operateInfo}');

        addTypeInfo();

        $('#dstart').datetimepicker({
            minView: "month", //选择日期后，不会再跳转去选择时分秒
            format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式
            language: 'zh-CN', //汉化
            autoclose:true //选择日期后自动关闭
        });
        $('#dend').datetimepicker({
            minView: "month", //选择日期后，不会再跳转去选择时分秒
            format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式
            language: 'zh-CN', //汉化
            autoclose:true //选择日期后自动关闭
        });
    });

    function tableCallBack(data, id){
        if (id == 'typeInfo'){
            for (var i = 0; i < operateInfo.length; i++) {
                if(operateInfo[i].dicDataValue == data.typeInfo) {
                    return operateInfo[i].dicDataName;
                    break;
                }
            }
        } else {
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }

    function changeTypeInfo() {
        var type = '' + $('#typeType').val();
        $('#typeInfo').html('<option value="">全部</option>');
        if (type == '-1') {
            addTypeInfo();
        }
        if (type == '0') {
            addTypeInfo1();
        } else {
            addTypeInfo2();
        }
    }

    function addTypeInfo() {
        for (var i = 0; i < operateInfo.length; i++) {
            $(new Option(operateInfo[i].dicDataName,operateInfo[i].dicDataValue)).appendTo('#typeInfo');
        }
    }

    function addTypeInfo1() {
        for (var i = 0; i < operateInfoSR.length; i++) {
            $(new Option(operateInfoSR[i].dicDataName,operateInfoSR[i].dicDataValue)).appendTo('#typeInfo');
        }
    }

    function addTypeInfo2() {
        for (var i = 0; i < operateInfoZC.length; i++) {
            $(new Option(operateInfoZC[i].dicDataName,operateInfoZC[i].dicDataValue)).appendTo('#typeInfo');
        }
    }

    function exportFund() {
        window.open("<%=request.getContextPath()%>/admin/fund/detailSuccess/export?empno=" + $('#empno').val() + "&phone="
                + $('#phone').val() + "&typeType=" + $('#typeType').val() + "&typeInfo=" + $('#typeInfo').val() + "&compName="
                + $('#compName').val() + "&startDate=" + $('#startDate').val() + "&endDate=" + $('#endDate').val());
        return;
    }
</script>
</body>
</html>