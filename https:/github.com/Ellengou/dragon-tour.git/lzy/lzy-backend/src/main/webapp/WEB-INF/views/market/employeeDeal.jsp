<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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
<div id="myTabContent" class="tab-content">
    <div class="tab-pane fade in active" id="merchatinfo">
        <div id="page-wrapper">
            <br/>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-info">
                        <!-- 员工信息 -->
                        <div class="panel-body" id="emp">
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">基础信息</div>
                                    <div class="panel-body">
                                        <p class="text-muted">姓名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${psnname}</p>
                                        <p class="text-muted">性别：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${sex}</p>
                                        <p class="text-muted">手机号码：&nbsp;&nbsp;&nbsp;&nbsp;${sjhm}</p>
                                        <p class="text-muted">所在公司：&nbsp;&nbsp;&nbsp;&nbsp;${unitshortname}</p>
                                        <p class="text-muted">员工工号：&nbsp;&nbsp;&nbsp;&nbsp;${psncode}</p>
                                        <p class="text-muted">在职岗位：&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                        <p class="text-muted">薪资级档：&nbsp;&nbsp;&nbsp;&nbsp;${xzjd}</p>
                                        <p class="text-muted">风险金：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${fxjye}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">资金账户信息</div>
                                    <div class="panel-body">
                                        <p class="text-muted">提现中：&nbsp;&nbsp;&nbsp;&nbsp;<font id="withdrawIng"></font></p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">理财信息</div>
                                    <div class="panel-body">
                                        <p class="text-muted">持有产品数：&nbsp;&nbsp;&nbsp;<font id="holdProCount">0</font>个</p>
                                        <p class="text-muted">最近一次购买：</p>
                                        <p class="text-muted" id="livePro">&nbsp;</p>
                                        <p class="text-muted" id="regularPro">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">贷款信息</div>
                                    <div class="panel-body">
                                        <p class="text-muted">暂无</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
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
        </div>
    </div>
</div>

<script>
	$(function () {
		var frontUserId = '${frontUserId}';
		if(frontUserId == null || frontUserId == ''){
			layer.alert('未获取到该员工在本系统的信息', {
                icon: 5
            });
		}else{
			getUserFinancial(frontUserId);
			getUserWithdraw(frontUserId);
		}
	});


    //查询员工理财信息
    function getUserFinancial(frontUserId){
        $.ajax({
            type : 'POST',
            url : '<%=request.getContextPath()%>/admin/ipcc/merchants/getUserFinancial',
            data : {
                frontUserId : frontUserId
            },
            dataType : 'json',
            success : function(data){
                if(data.status == 'ok'){
                    var msg = data.msg;
                    $("#holdProCount").html(msg.holdProCount);
                    $("#regularPro").html(msg.regularPro);
                    $("#livePro").html(msg.livePro);
                }else{
                    layer.alert(data.msg, {
                        icon: 5
                    });
                }
            },
            error : function(e){
                layer.alert('系统错误', {
                    icon: 5
                });
            }
        });
    }

    //查询员工提现信息
    function getUserWithdraw(frontUserId){
        $.ajax({
            type : 'POST',
            url : '<%=request.getContextPath()%>/admin/ipcc/merchants/getUserWithdraw',
            data : {
                frontUserId : frontUserId
            },
            dataType : 'json',
            success : function(data){
                if(data.status == 'ok'){
                    var msg = data.msg;
                    $("#withdrawIng").html(msg.withdrawIng);
                }else{
                    layer.alert(data.msg, {
                        icon: 5
                    });
                }
            },
            error : function(e){
                layer.alert('系统错误', {
                    icon: 5
                });
            }
        });
    }
</script>
</body>
</html>