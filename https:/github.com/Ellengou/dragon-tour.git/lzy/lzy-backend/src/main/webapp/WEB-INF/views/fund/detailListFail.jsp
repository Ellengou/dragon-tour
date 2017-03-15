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
<shiro:hasPermission name="message:send:send">
    <input id="p_send" style="display: none" value="1">
</shiro:hasPermission>
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
                                        <span class="input-group-addon">姓名</span>
                                        <input type="text" class="form-control" id="name">
                                        <input type="hidden" id="userId" value="${userId}">
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">手机号</span>
                                        <input type="text" class="form-control" id="phone">
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">费用名称</span>
                                        <select class="form-control" id="typeInfo">
                                            <option value="">全部</option>
                                        </select>
                                    </div>
                                </div>
                                <%--</div>--%>
                                <%--<br />--%>
                                <%--<div class="row">--%>
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
                           data-url="<%=request.getContextPath()%>/admin/fund/detailFail/json"
                           data-pageSize="10,50,100" data-method="GET">
                        <thead>
                        <tr>
                            <th width="5%" data-field="id">单据号</th>
                            <th width="10%" data-field="name">姓名</th>
                            <th width="9%" data-field="phone">手机号</th>
                            <th width="9%" data-field="money" >费用金额</th>
                            <th width="15%" data-field="typeInfo" data-call="true">费用名称</th>
                            <th width="9%" data-field="total" >总资产</th>
                            <th width="9%" data-field="balance" >可用总额</th>
                            <th width="9%" data-field="frozenMoney" >冻结总额</th>
                            <th width="5%" data-field="type">账号类型</th>
                            <th width="12%" data-field="operateTime" data-call="true">操作时间</th>
                            <th width="8%" data-field="remark" >备注</th>
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
    var operateInfos;

    $(function(){
        operateInfos = $.parseJSON('${operateInfos}');
        for (var i = 0; i < operateInfos.length; i++) {
            $(new Option(operateInfos[i].dicDataName,operateInfos[i].dicDataValue)).appendTo('#typeInfo');
        }
    });

    function tableCallBack(data, id){
        if (id == 'typeInfo'){
            for (var i = 0; i < operateInfos.length; i++) {
                if(operateInfos[i].dicDataValue == data.typeInfo) {
                    return operateInfos[i].dicDataName;
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

</script>
</body>
</html>