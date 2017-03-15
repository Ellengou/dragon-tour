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
                        <!-- 经销商信息 -->
                        <div class="panel-body" id="dea">
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">基础信息</div>
                                    <div class="panel-body">
                                        <p class="text-muted">单位名称：${ipccDealerDto.custname}</p>
                                        <p class="text-muted">客户性质：${ipccDealerDto.custtype}</p>
                                        <p class="text-muted">法人代表：${ipccDealerDto.legalbody}</p>
                                        <p class="text-muted">手机号码：${ipccDealerDto.mobilephone}</p>
                                        <p class="text-muted">单位地址：${ipccDealerDto.saleaddr}</p>
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
                                        <p class="text-muted">可用总余额：<font id="kyzye"></font></p>
                                        <p class="text-muted">保证金余额：<font id="bzjye"></font></p>
                                        <p class="text-muted">贷款余额：<font id="dkye"></font></p>
                                        <p class="text-muted">临时信用：<font id="lsxy"></font></p>
                                        <p class="text-muted">折扣未退：<font id="zkwt"></font></p>
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
                                        <p class="text-muted">预收款总额：<font id="yskze"></font></p>
                                        <p class="text-muted">临时预收款：<font id="lsysk"></font></p>
                                        <p class="text-muted">固定预收款：<font id="gdysk"></font></p>
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
    	getDealerPositionInfo();
    	getDealerFinancialInfo();
    })
    
    //查询经销商资金账户信息
    function getDealerPositionInfo(){
        $.ajax({
            type : 'POST',
            url : '<%=request.getContextPath()%>/admin/market/getDealerPositionInfo',
            data : {
            	custcode : '${custcode}',
            	pk_corp : '${pk_corp}'
            },
            dataType : 'json',
            success : function(data){
                if(data.status == 'ok'){
                    var msg = data.msg;
                    $("#kyzye").html(msg.xy);
                    $("#bzjye").html(msg.bzj);
                    $("#dkye").html(msg.ysye);
                    $("#lsxy").html(msg.lscredit);
                    $("#zkwt").html(msg.zkwt);
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
    
  	//查询经销商理财信息
    function getDealerFinancialInfo(){
        $.ajax({
            type : 'POST',
            url : '<%=request.getContextPath()%>/admin/market/getDealerFinancialInfo',
            data : {
            	custcode : '${custcode}',
            	pk_corp : '${pk_corp}'
            },
            dataType : 'json',
            success : function(data){
                if(data.status == 'ok'){
                    var msg = data.msg;
                    $("#lsysk").html(msg.ysk_lsmoney);
                    $("#gdysk").html(msg.ysk_gdmoney);
                    $("#yskze").html(msg.ysk_money);
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