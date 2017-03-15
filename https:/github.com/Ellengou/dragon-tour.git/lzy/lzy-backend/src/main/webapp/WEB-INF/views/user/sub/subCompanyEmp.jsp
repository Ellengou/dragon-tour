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
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">${cname}：员工列表</h1>
        <shiro:hasPermission name="subCompany:emp:edit">
            <input id="p_edit" style="display: none" value="1">
        </shiro:hasPermission>
        <shiro:hasPermission name="subCompany:emp:status">
            <input id="p_status" style="display: none" value="1">
        </shiro:hasPermission>
        <shiro:hasPermission name="subCompany:employee:import:start">
            <input id="p_start" style="display: none" value="1">
        </shiro:hasPermission>
        <shiro:hasPermission name="subCompany:employee:import:restart">
            <input id="p_restart" style="display: none" value="1">
        </shiro:hasPermission>
        <shiro:hasPermission name="subCompany:employee:import:delete">
            <input id="p_delete" style="display: none" value="1">
        </shiro:hasPermission>
        <shiro:hasPermission name="subCompany:employee:import:stop">
            <input id="p_stop" style="display: none" value="1">
        </shiro:hasPermission>
        <shiro:hasPermission name="subCompany:employee:import:edit">
            <input id="p_import_edit" style="display: none" value="1">
        </shiro:hasPermission>
        <shiro:hasPermission name="subCompany:reset:password">
            <input id="p_reset" style="display: none" value="1">
        </shiro:hasPermission>
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
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">员工编号</span>
                                        <input type="text" class="form-control" id="empno">
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">姓名</span>
                                        <input type="text" class="form-control" id="name">
                                    </div>
                                </div>
                                <div class="col-xs-3" hidden>
                                    <div class="input-group">
                                        <span class="input-group-addon">员工数据类型</span>
                                        <select class="form-control" id="tableType">
                                            <option value="">全部</option>
                                            <option value="0" selected>已启用</option>
                                            <option value="1">未启用</option>
                                        </select>
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
            <div class="panel-heading">
                <shiro:hasPermission name="subCompany:emp:add">
                    <button type="button" class="btn btn-primary" onclick="add();">新增</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="subCompany:employee:import:start">
                <button type="button" class="btn btn-primary" id="enableEmp" onclick="enableImportEmployee(-1, 1);">启用</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="subCompany:emp:import">
                    <button type="button" class="btn btn-primary" id="importExcel" onclick="importExcel();">导入</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="subCompany:emp:export">
                    <button type="button" class="btn btn-primary" id="exportAll" onclick="exportAll();">导出</button>
                </shiro:hasPermission>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table id="myTable"
                           class="table table-striped table-bordered table-hover"
                           data-url="<%=request.getContextPath()%>/admin/subCompany/queryEmployees?companyId=${cid}"
                           data-pageSize="10,50,100" data-method="POST">
                        <thead>
                        <tr>
                            <th width="5%" data-type="checkbox" data-field="id"></th>
                            <%--<th width="20px" data-field="id">ID</th>--%>
                            <th width="15%" data-field="empno">员工编号</th>
                            <th width="15%" data-field="name">姓名</th>
                            <th width="15%" data-field="phone">手机</th>
                            <th width="15%" data-field="email">邮箱</th>
                            <th width="15%" data-field="operateTime" data-call="true">注册时间</th>
                            <th width="5%" data-field="status" data-call="true">状态</th>
                            <th width="15%" data-field="button" data-call="true">操作</th>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/utils.js"></script>

<script type="text/javascript">
    function tableCallBack(data,id){
        if(id == 'status'){
            if (data[id] == 'A') {
                return "未启用";
            } else if (data[id] == 'C') {
                return "该账号异常，同一手机号不同身份证";
            } else if (data[id] == 'D') {
                return "该账号已被删除";
            }

            var userStatusList = ${userStatusList};
            for (var i = 0; i < userStatusList.length; i++) {
                if(data[id] == userStatusList[i].dicDataValue){
                    return userStatusList[i].dicDataName;
                    break;
                }
            }
            return data[id];
        }else if(id == 'button'){
            if (data.operateTime != null) {
                $('#enableEmp').attr("disabled",true);
                var str = '';
                if ($('#p_edit').val() == 1) {
                    str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> '
                }

                if ($('#p_status').val() == 1) {
                    str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'' + data.status + '\',\'0\');">修改状态</button> ';
                }
                if ($('#p_stop').val() == 1) {
                    str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="unableImportEmployee(\'' + data.id + '\');">取消关联</button> '
                }
                if ($('#p_reset').val() == 1) {
                    str = str + '<button type="button" class="btn btn-danger btn-xs" onclick="resetPassword(\'' + data.id + '\');">重置密码</button> '
                }
                return str;
            } else {
                $('#enableEmp').attr("disabled",false);
                var str = '';
                if ($('#p_edit').val() == 1) {
                    str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="editImportEmployee(\'' + data.id + '\');">编辑</button> '
                }
                if (data.status == 'D') {
                    if ($('#p_restart').val() == 1) {
                        str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="reenableImportEmployee(\'' + data.id + '\', 0);">激活</button> '
                    }
                } else {
                    if ($('#p_start').val() == 1) {
                        str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="enableImportEmployee(\'' + data.id + '\', 0);">启用</button> '
                    }
                    if ($('#p_delete').val() == 1) {
                        str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="deleteImportEmployee(\'' + data.id + '\');">删除</button> '
                    }
                }
                return str;
            }
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }


        if ($('#tableType').val() == '0') {
            $('#enableEmp').attr("disabled",true);
            $('#importExcel').attr("disabled",true);
            $('#exportAll').attr("disabled",false);
        } else if ($('#tableType').val() == '1') {
            $('#enableEmp').attr("disabled",false);
            $('#importExcel').attr("disabled",false);
            $('#exportAll').attr("disabled",true);
        } else {
            $('#enableEmp').attr("disabled",false);
            $('#importExcel').attr("disabled",true);
            $('#exportAll').attr("disabled",true);
        }
    }

    function resetPassword(id){
        $.ajax({
            url: '<%=request.getContextPath()%>/admin/subCompany/resetPassword',
            dataType: 'json',
            type: 'POST',
            data: {
                id:id
            },
            success: function (data) {
                if(data.status == 'ok'){
                    layer.alert('重置成功', {icon : 6});
                }else{
                    layer.alert(data.msg, {icon : 5});
                }
            },
            error: function(){
                layer.alert('系统错误', {icon : 5});
            }
        });
    }

    function unableImportEmployee(id) {
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/subCompany/unableImportEmployee',
                dataType: 'json',
                type: 'POST',
                data: {
                    id:id
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

    function deleteImportEmployee(id) {
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/subCompany/deleteImportEmployee',
                dataType: 'json',
                type: 'POST',
                data: {
                    id:id
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

    function reenableImportEmployee(id) {
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/subCompany/reenableImportEmployee',
                dataType: 'json',
                type: 'POST',
                data: {
                    id:id
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

    function enableImportEmployee(id, type) {
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            var ids;
            if (type == 0) {
                ids = id;
            } else {
                var chk_value =[];
                $("#tbodyId").find("input").each(function() {
                    if($(this).attr('type') == 'checkbox' && $(this).is(':checked')){
                        chk_value.push($(this).val());
                    }
                });
                if (chk_value.length < 1) {
                    layer.alert('请至少选择一条数据', {icon : 5});
                    return;
                }
                ids = chk_value.join(",");
            }
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/subCompany/enableImportEmployee',
                dataType: 'json',
                type: 'POST',
                data: {
                    id:ids
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

    function editImportEmployee(id){
        layer.open({
            type: 2,
            area: ['900px', '450px'],
            offset: [50,(($(window).width()-900)/2)],
            title: '修改 ${cname} 导入员工信息',
            content: ['<%=request.getContextPath()%>/admin/subCompany/addEmployeePage/update?companyId=${cid}&id=' + id,'yes']
        });
    }

    function add(){
        layer.open({
            type: 2,
            area: ['900px', '450px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '添加 ${cname} 员工',
            content: ['<%=request.getContextPath()%>/admin/subCompany/addEmployeePage/create?companyId=${cid}','yes']
        });
    }

    function edit(id){
        layer.open({
            type: 2,
            area: ['900px', '750px'],
            offset: [50,(($(window).width()-900)/2)],
            title: '修改 ${cname} 员工信息',
            content: ['<%=request.getContextPath()%>/admin/subCompany/editEmployeePage?id=' + id,'yes']
        });
    }

    function editStatus(id,status,type){
        layer.open({
            type: 2,
            area: ['500px', '300px'],
            offset: [100,(($(window).width()-500)/2)],
            title: '修改 ${cname} 员工状态',
            content: ['<%=request.getContextPath()%>/admin/subCompany/editUserFrontStatusPage?id=' + id + '&status=' + status + '&type=' + type,'no']
        });
    }

    function importExcel() {
        layer.open({
            type: 2,
            area: ['500px', '300px'],
            offset: [100,(($(window).width()-500)/2)],
            title: '导入 ${cname} 公司员工',
            content: ['<%=request.getContextPath()%>/admin/userFront/uploadFilePage?companyId=${cid}&type=7','no']
        });
    }

    function exportAll(){
        var chk_value =[];
        $("#tbodyId").find("input").each(function() {
            if($(this).attr('type') == 'checkbox' && $(this).is(':checked')){
                chk_value.push($(this).val());
            }
        });

        if(chk_value.join(",") == null || chk_value.join(",") == ''){
            window.open("<%=request.getContextPath()%>/admin/userFront/employeeExport");
            return;
        } else {
            window.open("<%=request.getContextPath()%>/admin/userFront/employeeExport?companyId=${cid}&ids=" + chk_value.join(","));
            return;
        }
    }

</script>
</body>
</html>