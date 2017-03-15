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
        <h1 class="page-header">${cname}: 部门列表</h1>
        <shiro:hasPermission name="subCompang:org:edit">
            <input id="p_edit" style="display: none" value="1">
        </shiro:hasPermission>
        <shiro:hasPermission name="subCompany:org:delete">
            <input id="p_delete" style="display: none" value="1">
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
                                <div class="col-xs-2">
                                    <div class="input-group">
                                        <span class="input-group-addon">部门名称</span>
                                        <input type="text" class="form-control" id="name">
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
                <shiro:hasPermission name="subCompany:org:add">
                    <button type="button" class="btn btn-primary" onclick="add();">新增</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="subCompany:org:import">
                    <button type="button" class="btn btn-primary" onclick="importExcel();">导入</button>
                </shiro:hasPermission>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table id="myTable"
                           class="table table-striped table-bordered table-hover"
                           data-url="<%=request.getContextPath()%>/admin/subCompany/org/json?pid=${cid}"
                           data-pageSize="10,50,100" data-method="POST">
                        <thead>
                        <tr>
                            <th width="10%" data-field="id">ID</th>
                            <%--<th width="50px" data-field="pidName">上级公司</th>--%>
                            <th width="20%" data-field="name">部门名称</th>
                            <th width="20%" data-field="tel">部门电话</th>
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

<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>

<script type="text/javascript">

    function tableCallBack(data,id){
        if(id == 'button'){
            var str = '';
            if($('#p_edit').val() == 1){
                str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> ';
            }

            if($('#p_delete').val() == 1){
                str = str + '<button type="button" class="btn btn-danger btn-xs" onclick="deleteCompOrg(\'' + data.id + '\');">删除</button>';
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
            area: ['900px', '300px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '添加子公司部门',
            content: ['<%=request.getContextPath()%>/admin/subCompany/addCompOrgPage?companyId=${cid}','no']
        });
    }

    function edit(id){
        layer.open({
            type: 2,
            area: ['900px', '300px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '修改子公司部门',
            content: ['<%=request.getContextPath()%>/admin/subCompany/editCompOrgPage?companyId=' + id,'no']
        });
    }

    function deleteCompOrg(id){
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/subCompany/deleteCompOrg',
                dataType: 'json',
                type: 'POST',
                data: {
                    id:id
                },
                success: function (data) {
                    if(data.status == 'ok'){
                        layer.alert('删除成功', {icon : 6});
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
            title: '导入 ${cname} 公司部门',
            content: ['<%=request.getContextPath()%>/admin/userFront/uploadFilePage?companyId=${cid}&type=8','no']
        });
    }
</script>
</body>
</html>