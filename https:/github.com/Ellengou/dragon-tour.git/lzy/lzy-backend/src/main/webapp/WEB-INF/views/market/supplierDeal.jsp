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
                        <!-- 供应商信息 -->
                        <div class="panel-body" id="supp">
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">基础信息</div>
                                    <div class="panel-body">
                                        <p class="text-muted">单位名称：${IpccSupplierDto.custname}</p>
                                        <p class="text-muted">客户性质：${IpccSupplierDto.custtype}</p>
                                        <p class="text-muted">法人代表：${IpccSupplierDto.legalbody}</p>
                                        <p class="text-muted">手机号码：${IpccSupplierDto.mobilephone}</p>
                                        <p class="text-muted">单位地址：${IpccSupplierDto.saleaddr}</p>
                                        <p class="text-muted">经营状况：</p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">资金账户信息</div>
                                    <div class="panel-body">
                                        <p class="text-muted">信用额度：<font id="xyed"></font></p>
                                        <p class="text-muted">未开发票：<font id="wkfp"></font></p>
                                        <p class="text-muted">票到未入账：<font id="pdwrz"></font></p>
                                        <p class="text-muted">账面余额：<font id="zmye"></font></p>
                                        <p class="text-muted">可贷额度：<font id="kded"></font></p>
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
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">贷款信息</div>
                                    <div class="panel-body">
                                        <p class="text-muted">贷款类型:<font id="dklx"></font></p>
                                        <p class="text-muted">申请中:<font id="sqz"></font></p>
                                        <p class="text-muted">还款中:<font id="hkz"></font></p>
                                        <p class="text-muted">未还总额:<font id="whze"></font></p>
                                        <p class="text-muted">本月应还总额:<font id="byyhze"></font></p>
                                        <p class="text-muted">本月已还总额:<font id="byiyhze"></font></p>
                                        <p class="text-muted">本月未还总额:<font id="bywhze"></font></p>
                                        <p class="text-muted">最近一次贷款:<font id="zjycdk"></font></p>
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
    	getSupplierPositionInfo();
    	var frontUserId = '${frontUserId}';
    	var companyId = '${companyId}'
    	if(frontUserId == null || frontUserId == ''){
    		layer.alert('未获取到该供应商在本系统的信息', {
                icon: 5
            });
    		return;
    	}else{
    		getUserBorrowInfo(frontUserId);
    	}
    })

    //查询贷款信息
    function getUserBorrowInfo(frontUserId,companyId){
        $.ajax({
            type : 'POST',
            url : '<%=request.getContextPath()%>/admin/ipcc/merchants/getUserBorrowInfo',
            data : {frontUserId : frontUserId,companyId: companyId},
            dataType : 'json',
            success : function(data){
                if(data.status == 'ok'){
                    var msg = data.msg;
                    $("#dklx").html(msg.borrowTypes);
                    $("#sqz").html(msg.applying);
                    $("#hkz").html(msg.repaying);
                    $("#whze").html(msg.amount_all);
                    $("#byyhze").html(msg.cur_month_amount_all);
                    $("#byiyhze").html(msg.cur_month_amount_repayed);
                    $("#bywhze").html(msg.cur_month_amount_repaying);
                    if(msg.lastLoan.loanMoney != null && msg.lastLoan.loanMoney != ''){
                    	$("#zjycdk").html("申请额度:"+msg.lastLoan.loanMoney+"元,   借款期限:"+msg.lastLoan.deadLine+"天,  申请时间:"+msg.lastLoan.createTime);
                    }
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

    //查询供应商资金账户信息
    function getSupplierPositionInfo(){
        $.ajax({
            type : 'POST',
            url : '<%=request.getContextPath()%>/admin/market/getSupplierPositionInfo',
            data : {
            	custcode : '${custcode}',
            	pk_corp : '${pk_corp}'
            },
            dataType : 'json',
            success : function(data){
                if(data.status == 'ok'){
                    var msg = data.msg;
                    $("#xyed").html(msg.xyed);
                    $("#wkfp").html(msg.wkfp);
                    $("#pdwrz").html(msg.pdwrz);
                    $("#zmye").html(msg.zmye);
                    $("#kded").html(msg.kded);
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