<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>后台管理系统</title>
    <!-- Bootstrap Core CSS -->
    <link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .col-lg-3 {padding: 0px !important;}
        textarea {resize:none;}
        p {margin-bottom: 10px!important;}
        p .col-lg-9 {text-align: left;}
    </style>
    <script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- layer JavaScript -->
    <script src="<%=request.getContextPath()%>/bootstrap/plugin/layer/layer.js" type="text/javascript"></script>
</head>
<body style="overflow-x:hidden;">
<ul id="myTab" class="nav nav-tabs">
    <li class="active">
        <a href="#empinfo" data-toggle="tab">
            &nbsp;&nbsp;&nbsp;员工信息&nbsp;&nbsp;&nbsp;
        </a>
    </li>
    <li>
        <a href="#recordDetial" data-toggle="tab">
            &nbsp;&nbsp;&nbsp;咨询记录&nbsp;&nbsp;&nbsp;
        </a>
    </li>
</ul>
<div id="myTabContent" class="tab-content">
    <div class="tab-pane fade in active" id="empinfo">
        <div id="page-wrapper">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            当前已经接入：<span class="glyphicon glyphicon-phone"></span> ${phone} &nbsp;&nbsp;&nbsp;&nbsp;
                            <span class="glyphicon glyphicon-user"></span> ${name} &nbsp;&nbsp;&nbsp;&nbsp;
                            <span class="glyphicon glyphicon-tag"></span> 员工
                        </div>
                        <div class="panel-body">
                            <!-- /.col-lg-4 -->
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        基础信息
                                    </div>
                                    <div class="panel-body">
                                        <p class="text-muted">姓名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${name}</p>
                                        <p class="text-muted">性别：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${sex}</p>
                                        <p class="text-muted">手机号码：&nbsp;&nbsp;&nbsp;&nbsp;${phone}</p>
                                        <p class="text-muted">所在公司：&nbsp;&nbsp;&nbsp;&nbsp;${companyName}</p>
                                        <p class="text-muted">员工工号：&nbsp;&nbsp;&nbsp;&nbsp;${empno}</p>
                                        <p class="text-muted">在职岗位：&nbsp;&nbsp;&nbsp;&nbsp;${posit}</p>
                                    </div>
                                </div>
                            </div>
                            <!-- /.col-lg-4 -->
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        资金账户信息
                                    </div>
                                    <div class="panel-body">
                                        <p class="text-muted">提现中：&nbsp;&nbsp;&nbsp;&nbsp;${withdrawIng}</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                    </div>
                                </div>
                            </div>
                            <!-- /.col-lg-4 -->
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        理财信息
                                    </div>
                                    <div class="panel-body">
                                        <p class="text-muted">持有产品数：&nbsp;&nbsp;&nbsp;${holdProCount} 个</p>
                                        <p class="text-muted">最近一次购买：</p>
                                        <p class="text-muted">${livePro}</p>
                                        <p class="text-muted">${regularPro}</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">查看其它信息</p>
                                    </div>
                                </div>
                            </div>
                            <!-- /.col-lg-4 -->
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        贷款信息
                                    </div>
                                    <div class="panel-body">
                                        <p class="text-muted">暂无</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="/WEB-INF/views/ipcc/addDetailTemp.jsp"%>
        </div>
    </div>
    <div class="tab-pane fade in active" id="recordDetial">
        <iframe src="<%=request.getContextPath()%>/admin/ipcc/detail/listPage?phone=${phone}" scrolling="auto" frameborder="0" width="100%" height="600px"></iframe>
    </div>
</div>
</body>
</html>