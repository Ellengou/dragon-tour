<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>后台管理系统</title>
    <%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
</head>
<style>
    li { list-style: none}
</style>
<body>
<shiro:hasPermission name="subCompany:edit">
    <input id="p_edit" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="subCompany:common:view">
    <input id="p_common" style="display: none" value="1">
</shiro:hasPermission>
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
            <div class="panel-heading">
            	<a class="btn btn-primary" href="<%=request.getContextPath()%>/template/子公司.xls" target="_self">子公司模板下载</a> 
                <shiro:hasPermission name="subCompany:add">
                    <button type="button" class="btn btn-primary" onclick="add();">新增</button> &nbsp;&nbsp;
                </shiro:hasPermission>
                <shiro:hasPermission name="subCompany:import">
                    <button type="button" class="btn btn-primary" onclick="importExcel();">导入</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="subCompany:export">
                    <button type="button" class="btn btn-primary" onclick="exportAll();">导出</button>
                </shiro:hasPermission>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table id="myTable"
                           class="table table-striped table-bordered table-hover"
                           data-url="<%=request.getContextPath()%>/admin/company/querySubCompanys"
                           data-pageSize="10,50,100" data-method="POST">
                        <thead>
                        <tr>
                            <th width="5%" data-type="checkbox" data-field="id"></th>
                            <%--<th width="10%" data-field="id">ID</th>--%>
                            <th width="15%" data-field="compno">公司编号</th>
                            <th width="15%" data-field="compName">公司名称</th>
                            <th width="10%" data-field="compEmail">公司邮箱</th>
                            <th width="10%" data-field="contPerson">联系人</th>
                            <th width="10%" data-field="contPhone">联系人手机</th>
                            <th width="10%" data-field="contTel">联系人座机</th>
                            <th width="10%" data-field="enabled" data-call="true">状态</th>
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
            if($('#p_edit').val() == 1){
                str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> ';
            }

            if($('#p_common').val() == 1){
                str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="companyInfo(\'' + data.id + '\');">详细</button> ';
            }

            if($('#p_status').val() == 1){
                if(data.enabled == '0'){
                    str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'1\');">禁用</button> ';
                }else{
                    str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'0\');">启用</button> ';
                }
            }
            return str;
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }

    function add(){
        layer.open({
            type: 2,
            area: ['900px', '600px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '添加子公司',
            content: ['<%=request.getContextPath()%>/admin/company/addSubCompanyPage','yes']
        });
    }

    function edit(id){
        layer.open({
            type: 2,
            area: ['900px', '600px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '修改子公司',
            content: ['<%=request.getContextPath()%>/admin/company/editSubCompanyPage?id=' + id,'yes']
        });
    }

    var _height = $(window).height();
    function companyInfo(id){
        var index = layer.tab({
            area: ['100%', '100%'],
            tab: [{
                title: '子公司部门',
                content: '<iframe id="iframe" name="iframe" src="<%=request.getContextPath()%>/admin/subCompany/org?companyId=' + id
                + '" scrolling="auto" frameborder="0" width="100%" height="' +  _height + 'px"></iframe>'
            }, {
                title: '子公司职位',
                content: '<iframe id="iframe" name="iframe" src="<%=request.getContextPath()%>/admin/subCompany/posit?companyId=' + id
                + '" scrolling="auto" frameborder="0" width="100%" height="' +  _height + 'px"></iframe>'
            }, {
                title: '子公司员工',
                content: '<iframe id="iframe" name="iframe" src="<%=request.getContextPath()%>/admin/subCompany/emp?companyId=' + id
                + '" scrolling="auto" frameborder="0" width="100%" height="' +  _height + 'px"></iframe>'
            }]
        });
        layer.full(index);
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

    function importExcel() {
        layer.open({
            type: 2,
            area: ['500px', '300px'],
            offset: [100,(($(window).width()-500)/2)],
            title: '导入子公司',
            content: ['<%=request.getContextPath()%>/admin/userFront/uploadFilePage?type=3','no']
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
            window.open("<%=request.getContextPath()%>/admin/subCompany/subCompanyExport");
            return;
        } else {
            window.open("<%=request.getContextPath()%>/admin/subCompany/subCompanyExport?ids=" + chk_value.join(","));
            return;
        }
    }
</script>
</body>
</html>