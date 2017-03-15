<%--
  Created by IntelliJ IDEA.
  User: violorch
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
<shiro:hasPermission name="sys:manager:comp:updateStatus">
    <input id="p_update" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="sys:manager:comp:roleUpdate">
    <input id="p_role_update" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="sys:manager:comp:resetPwd">
    <input id="p_resetPwd" style="display: none" value="1">
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
                                        <input type="text" class="form-control" id="realName">
                                    </div>
                                </div>
                                <div class="col-xs-2">
                                    <div class="input-group">
                                        <span class="input-group-addon">登陆名</span>
                                        <input type="text" class="form-control" id="loginName">
                                    </div>
                                </div>
                                <div class="col-xs-2">
                                    <div class="input-group">
                                        <span class="input-group-addon">电话</span>
                                        <input type="text" class="form-control" id="phone">
                                    </div>
                                </div>
                                <div class="col-xs-2">
                                    <div class="input-group">
                                        <span class="input-group-addon">邮箱</span>
                                        <input type="text" class="form-control" id="email">
                                    </div>
                                </div>
                                <div class="col-xs-2">
                                    <div class="input-group">
                                        <span class="input-group-addon">账号状态</span>
                                        <select class="form-control" id="state">
                                            <option value="">全部</option>
                                            <option value="0">正常</option>
                                            <option value="1">登陆锁定</option>
                                            <option value="2">系统锁定</option>
                                            <option value="3">核心企业禁用</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-xs-3">
                                    <div id="start_visit_time" class="input-group date form_datetime col-md-12">
                                        <span class="input-group-addon">开始日期</span>
                                        <input id="startDate" name="startDate" class="form-control" size="16" type="text" value="" readonly>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div id="end_visit_time" class="input-group date form_datetime col-md-12">
                                        <span class="input-group-addon">结束日期</span>
                                        <input id="endDate" name="endDate" class="form-control" size="16" type="text" value="" readonly>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
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
                           data-url="<%=request.getContextPath()%>/admin/manager/comp/json"
                           data-pageSize="10,50,100" data-method="GET">
                        <thead>
                        <tr>
                            <th width="5%" data-field="id">ID</th>
                            <th width="8%" data-field="loginName">登录名</th>
                            <th width="17%" data-field="realName">姓名</th>
                            <%--<th width="5%" data-field="sex" data-call="true">性别</th>--%>
                            <th width="10%" data-field="email">邮箱</th>
                            <th width="10%" data-field="phone">手机号码</th>
                            <th width="10%" data-field="loginCount">登陆次数</th>
                            <th width="15%" data-field="lastVisit" data-call="true">最后一次访问时间</th>
                            <th width="10%" data-field="state" data-call="true">状态</th>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/utils.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>
<!-- bootstrap-datetimepicker -->
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript">
    $(function () {
        $('#start_visit_time').datetimepicker({
            minView: "month", //选择日期后，不会再跳转去选择时分秒
            format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式
            language: 'zh-CN', //汉化
            autoclose:true //选择日期后自动关闭
        });
        $('#end_visit_time').datetimepicker({
            minView: "month", //选择日期后，不会再跳转去选择时分秒
            format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式
            language: 'zh-CN', //汉化
            autoclose:true //选择日期后自动关闭
        });
    });

    function tableCallBack(data, id){
        if (id == 'sex') {
            if (data[id] == 0) {
                return '女';
            } else if (data[id] == 1) {
                return '男';
            } else if (data[id] == 2) {
                return '超级管理员';
            }
        } if (id == 'state'){
            if(data[id] == '0'){
                return '正常';
            }else if(data[id] == '1'){
                return '登录锁定';
            }else if(data[id] == '2'){
                return '系统锁定';
            }else if(data[id] == '3'){
                return '核心企业禁用';
            } else{
                return data[id];
            }
        } else if(id == 'button') {
            var _button = '';
            var count = 0;
            if ($('#p_update').val() == 1) {
                if(data.state == '0'){
                    _button += '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'2\');">禁用</button> ';
                }else{
                    _button += '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'0\');">启用</button> ';
                }
                count ++;
            }

            if ($('#p_role_update').val() == 1) {
                _button += '<button type="button" class="btn btn-danger btn-xs" onclick="editUserRole(' + data.id + ');"> 修改权限 </button> ';
                count ++
            }

            if ($('#p_resetPwd').val() == 1) {
                _button += '<button type="button" class="btn btn-danger btn-xs" onclick="resetPwd(' + data.id + ');"> 重置密码 </button> ';
                count ++
            }

            return _button;
        } else {
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }

    function editStatus(id, state){
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/manager/updateCompStatus',
                dataType: 'json',
                type: 'POST',
                data: {
                    id:id,
                    state:state
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

    function resetPwd(id) {
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function() {
            $.ajax({
                type: 'POST',
                url: '<%=request.getContextPath()%>/admin/manager/resetPwd?id=' + id,
                dataType: 'json',
                success: function (data) {
                    if (data.status == 'ok') {
                        layer.alert('重置成功!', {
                            icon: 6
                        }, function(index){
                            layer.closeAll('dialog');
                            search(1);
                        });
                    } else {
                        layer.alert(data.msg, {
                            icon: 56
                        });
                    }
                }
            });
        });
    }

    function editUserRole(id){
        layer.open({
            type: 2,
            area: ['900px', '600px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '分配后台用户角色权限',
            content: ['<%=request.getContextPath()%>/admin/manager/roleUpdate?id=' + id,'no']
        });
    }
</script>
</body>
</html>