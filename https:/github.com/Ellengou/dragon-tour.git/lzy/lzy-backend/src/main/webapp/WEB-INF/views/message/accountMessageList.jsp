<%@ page import="com.runlion.hssys.constants.Constants" %><%--
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
        <h1 class="page-header">站内信</h1>
    </div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-12">
                        <form id="myForm">
                            <div class="row">
                                <div class="col-xs-2">
                                    <div class="input-group">
                                        <span class="input-group-addon">消息标题</span>
                                        <input type="text" class="form-control" id="detailName">
                                    </div>
                                </div>
                                <div class="col-xs-2">
                                    <div class="input-group">
                                        <span class="input-group-addon">消息状态</span>
                                        <select class="form-control" id="readTime">
                                            <option value="">全部</option>
                                            <option value="0">未读</option>
                                            <option value="1">已读</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xs-2">
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
                           data-url="<%=request.getContextPath()%>/admin/messageSend/messageJson"
                           data-pageSize="10,50,100" data-method="GET">
                        <thead>
                        <tr>
                            <%--<th width="20px" data-field="id">序号</th>--%>
                            <th width="50px" data-field="detailsTitle">消息名称</th>
                            <th width="50px" data-field="sendTime">接收时间</th>
                            <th width="50px" data-field="readTime" data-call="true">是否已读</th>
                            <th width="50px" data-field="button" data-call="true">操作</th>
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

    function tableCallBack(data, id){
        if (id == 'readTime'){
            if(data[id] == null){
                return '未读';
            }else {
                return '已读';
            }
        } else if(id == 'button') {
            return '<button type="button" class="btn btn-primary btn-xs" onclick="viewDetail(\'' + data.id + '\');">查看</button> ';
        }
    }

    function viewDetail(id, detailId){
        $.ajax({
            type: 'GET',
            url: '<%=request.getContextPath()%>/admin/messageSend/messageDetail',
            dataType: 'json',
            data : {
                id: id
            },
            success: function (data) {
                if (data.status == 'ok') {
                    var json = data.msg;
                    layer.open({
                        type: 1,
                        title: json.detailsTitle,
                        shadeClose: true,
                        area: ['900px', '350px'],
                        offset: [100,(($(window).width()-900)/2)],
                        content: '<div style="margin: 20px;">' + json.detailsContent + '</div>'
                    });
                    if (data.code != null && data.code != "") {
                        $(".top_round",window.top.document).show();
                        $(".top_round",window.top.document).html(data.code);
                        search(parseInt($('.active').attr('jp-data')));
                    } else {
                        $(".top_round",window.top.document).hide();
                    }
                } else {
                    layer.alert(data.msg, {
                        icon: 56
                    });
                }
            }
        });
    }

</script>
</body>
</html>