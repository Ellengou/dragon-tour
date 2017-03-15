<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>后台管理系统</title>
    <%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
</head>
<body>
<shiro:hasPermission name="subCompany:status">
    <input id="p_status" style="display: none" value="1">
</shiro:hasPermission>
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
                                        <span class="input-group-addon">公司名称</span>
                                        <input type="text" class="form-control" id="compName">
                                    </div>
                                </div>
                                <div class="col-xs-2">
                                    <div class="input-group">
                                        <span class="input-group-addon">公司编号</span>
                                        <input type="text" class="form-control" id="compno">
                                    </div>
                                </div>
                                <div class="col-xs-3">
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
                           data-url="<%=request.getContextPath()%>/admin/company/querySubCompanys"
                           data-pageSize="10,50,100" data-method="POST">
                        <thead>
                        <tr>
                            <th width="5%" data-field="id">ID</th>
                            <th width="10%" data-field="compno">公司编号</th>
                            <th width="15%" data-field="compCoreName">核心企业</th>
                            <th width="15%" data-field="compName">公司名称</th>
                            <th width="10%" data-field="compEmail">公司邮箱</th>
                            <th width="10%" data-field="contPerson">联系人</th>
                            <th width="10%" data-field="contPhone">联系人手机</th>
                            <th width="10%" data-field="contTel">联系人座机</th>
                            <th width="5%" data-field="enabled" data-call="true">状态</th>
                            <th width="10%" data-field="button" data-call="true">操作</th>
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

<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>

<script type="text/javascript">
    function tableCallBack(data,id){
        if(id == 'enabled'){
            var enabledStatusList = ${enabledStatusList};
            for (var i = 0; i < enabledStatusList.length; i++) {
                if(data[id] == enabledStatusList[i].dicDataValue){
                    return enabledStatusList[i].dicDataName;
                    break;
                }
            }
            return data[id];
        }else if(id == 'button'){
            var str = '';
            if($('#p_status').val() == 1){
                if(data.enabled == '0'){
                    str = ' <button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'1\');">禁用</button>';
                }else{
                    str = ' <button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'0\');">启用</button>';
                }
            }
            str += '&nbsp<button type="button" class="btn btn-primary btn-xs" onclick="view(\'' + data.id + '\');">详情</button> ';
            return str;
        }else{
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
            area: ['900px', '480px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '子公司详情',
            content: ['<%=request.getContextPath()%>/admin/company/viewSubCompanyPage?id=' + id,'yes']
        });
    }
    function editStatus(id,enabled){
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/company/editSubCompanyStatus',
                dataType: 'json',
                type: 'POST',
                data: {
                    id:id,
                    enabled:enabled
                },
                success: function (data) {
                    if(data.status == 'ok'){
                        layer.closeAll('dialog');
                        search(parseInt($('.active').attr('jp-data')));
                    }else{
                        layer.alert(data.msg, {icon : 5});
                    }
                },
                error: function(){
                    layer.alert('系统错误', {icon : 5});
                }
            });
        }, function(){

        });
    }
</script>
</body>
</html>