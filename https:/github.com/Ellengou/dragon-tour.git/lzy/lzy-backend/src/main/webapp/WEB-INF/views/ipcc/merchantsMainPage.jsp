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
<ul id="myTab" class="nav nav-tabs">
    <li class="active">
        <a href="#merchatinfo" data-toggle="tab">
            &nbsp;&nbsp;&nbsp;客商信息&nbsp;&nbsp;&nbsp;
        </a>
    </li>
    <li>
        <a href="#recordDetial" data-toggle="tab">
            &nbsp;&nbsp;&nbsp;咨询记录&nbsp;&nbsp;&nbsp;
        </a>
    </li>
</ul>
<div id="myTabContent" class="tab-content">
    <div class="tab-pane fade in active" id="merchatinfo">
        <div id="page-wrapper">
            <br/>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-info">
                        <div class="panel-heading"> 当前已经接入：<span class="glyphicon glyphicon-phone"></span> ${phone} &nbsp;&nbsp;&nbsp;&nbsp;</div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <label class="checkbox-inline">
                                            <input type="radio" name="compType" id="compType0" value="2" onclick="getSuppNames('2');" checked="checked"> 员工
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="radio" name="compType" id="compType1" value="0" onclick="getSuppNames('0');"> 供应商
                                        </label>
                                        <label class="checkbox-inline">
                                            <input type="radio" name="compType" id="compType2" value="1" onclick="getSuppNames('1');"> 经销商
                                        </label>
                                    </div>
                                </div>
                                <div class="col-xs-2">
                                    <input type="hidden" id="type" value = "2">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="search()">查询</button>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" id="compSearch">
                            <div class="row">
                                <div class="col-xs-5">
                                    <div class="input-group">
                                        <span class="input-group-addon">单位名称</span>
                                        <select class="form-control" id="suppName" onchange="getCompNames();">
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xs-5">
                                    <div class="input-group">
                                        <span class="input-group-addon">所属公司</span>
                                        <select class="form-control" id="compName">
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 员工信息 -->
                        <div class="panel-body" id="emp">
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">基础信息</div>
                                    <div class="panel-body">
                                        <p class="text-muted">姓名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font id="name"></font></p>
                                        <p class="text-muted">性别：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font id="sex"></font></p>
                                        <p class="text-muted">手机号码：&nbsp;&nbsp;&nbsp;&nbsp;<font id="phone"></font></p>
                                        <p class="text-muted">所在公司：&nbsp;&nbsp;&nbsp;&nbsp;<font id="companyName"></font></p>
                                        <p class="text-muted">员工工号：&nbsp;&nbsp;&nbsp;&nbsp;<font id="empno"></font></p>
                                        <p class="text-muted">在职岗位：&nbsp;&nbsp;&nbsp;&nbsp;<font id="posit"></font></p>
                                        <p class="text-muted">&nbsp;</p>
                                        <p class="text-muted">&nbsp;</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">资金账户信息</div>
                                    <div class="panel-body">
                                        <p class="text-muted">提现中：&nbsp;&nbsp;&nbsp;&nbsp;<font id="withdrawIng">0.00</font></p>
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
                        
                        <!-- 供应商信息 -->
                        <div class="panel-body" id="supp" style="display: none">
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">基础信息</div>
                                    <div class="panel-body">
                                        <p class="text-muted">单位名称：<font id="supplier_dwmc"></font></p>
                                        <p class="text-muted">客户性质：<font id="supplier_khxz"></font></p>
                                        <p class="text-muted">法人代表：<font id="supplier_frdb"></font></p>
                                        <p class="text-muted">手机号码：<font id="supplier_sjhm"></font></p>
                                        <p class="text-muted">单位地址：<font id="supplier_dwdz"></font></p>
                                        <p class="text-muted">经营状况：<font id="supplier_jyzk"></font></p>
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
                        
                        <!-- 经销商信息 -->
                        <div class="panel-body" id="dea" style="display: none">
                            <div class="col-lg-3">
                                <div class="panel panel-default">
                                    <div class="panel-heading">基础信息</div>
                                    <div class="panel-body">
                                        <p class="text-muted">单位名称：<font id="dealer_dwmc"></font></p>
                                        <p class="text-muted">客户性质：<font id="dealer_khxz"></font></p>
                                        <p class="text-muted">法人代表：<font id="dealer_frdb"></font></p>
                                        <p class="text-muted">手机号码：<font id="dealer_sjhm"></font></p>
                                        <p class="text-muted">单位地址：<font id="dealer_dwdz"></font></p>
                                        <p class="text-muted">经营状况：<font id="dealer_jyzk"></font></p>
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
            <%@ include file="/WEB-INF/views/ipcc/addDetailTemp.jsp"%>
        </div>
    </div>
    <div class="tab-pane fade in " id="recordDetial">
        <iframe id="listFrame" src="<%=request.getContextPath()%>/admin/ipcc/detail/listPage?phone=${phone}" scrolling="auto" frameborder="0" width="100%" height="100%"></iframe>
        <script>
            var ifm= document.getElementById("listFrame");
            ifm.height=document.documentElement.clientHeight - 100;
        </script>
    </div>
</div>

<script>
    $(function () {
        getSuppNames('2');

        $(document).on('click','#myTab li a',function(){
           var self = $(this);
            if (self.attr('href') == '#recordDetial') {
                $('#listFrame').attr('src', $('#listFrame').attr('src'));
            }
        });
    })

    function search(){
        if($("#type").val() != '2'){
            if($("#suppName").val() == null || $("#suppName").val() == ''){
                layer.alert('请选择单位名称', {
                    icon: 6
                });
                return;
            }
            if($("#compName").val() == null || $("#compName").val() == ''){
                layer.alert('请选择所属公司', {
                    icon: 6
                });
                return;
            }

            //供应商或经销商信息
            if($("#type").val() == '0'){
                getSupplierInfo();
            }else if($("#type").val() == '1'){
                getDealerInfo();
            }
        }else{
            getEmployeeInfo()//员工信息
        }
    }

    //查询手机号码对应的企业信息
    function getSuppNames(type){
        $("#type").val(type);
        if(type == '2'){
            $('#compSearch').hide();//隐藏查询条件
            $('#emp').show();//显示员工信息
            $('#dea').hide();//隐藏经销商信息
            $('#supp').hide();//隐藏供应商信息
        }else if(type == '0'){
            $('#emp').hide();//隐藏员工信息
            $('#dea').hide();//隐藏经销商信息
            $('#supp').show();//显示供应商信息
            $('#compSearch').show();//展现查询条件

            $("#suppName").empty();
            $("#compName").empty();
            $.ajax({
                type : 'POST',
                url : '<%=request.getContextPath()%>/admin/ipcc/merchants/getSuppNames',
                data : {
                    phone : '${phone}',
                    type: type
                },
                dataType : 'json',
                success : function(data){
                    if(data.status == 'ok'){
                        for (var i = 0; i < data.msg.length; i++) {
                            $(new Option(data.msg[i].suppName,data.msg[i].id)).appendTo('#suppName');
                            if(i == 0){
                                getCompNames();
                            }
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
        }else{
        	$('#emp').hide();//隐藏员工信息
            $('#dea').show();//显示经销商信息
            $('#supp').hide();//显示供应商信息
            $('#compSearch').show();//展现查询条件

            $("#suppName").empty();
            $("#compName").empty();
            $.ajax({
                type : 'POST',
                url : '<%=request.getContextPath()%>/admin/ipcc/merchants/getSuppNames',
                data : {
                    phone : '${phone}',
                    type: type
                },
                dataType : 'json',
                success : function(data){
                    if(data.status == 'ok'){
                        for (var i = 0; i < data.msg.length; i++) {
                            $(new Option(data.msg[i].suppName,data.msg[i].id)).appendTo('#suppName');
                            if(i == 0){
                                getCompNames();
                            }
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
    }

    //查询对应的信息
    function getCompNames(){
        $.ajax({
            type : 'POST',
            url : '<%=request.getContextPath()%>/admin/ipcc/merchants/getCompNames',
            data : {
                frontUserId : $("#suppName").val(),
                type: $("#type").val()
            },
            dataType : 'json',
            success : function(data){
                if(data.status == 'ok'){
                    $("#compName").empty();
                    for (var i = 0; i < data.msg.length; i++) {
                        $(new Option(data.msg[i].compName,data.msg[i].id)).appendTo('#compName');
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
    
  //查询经销商信息
    function getDealerInfo(){
        $.ajax({
            type : 'POST',
            url : '<%=request.getContextPath()%>/admin/ipcc/merchants/getDealerInfo',
            data : {
                frontUserId : $("#suppName").val(),
                companyId : $("#compName").val()
            },
            dataType : 'json',
            success : function(data){
                if(data.status == 'ok'){
                    var msg = data.msg;
                    $("#dealer_dwmc").html(msg.custname);
                    $("#dealer_khxz").html(msg.custtype);
                    $("#dealer_frdb").html(msg.legalbody);
                    $("#dealer_sjhm").html(msg.mobilephone );
                    $("#dealer_dwdz").html(msg.saleaddr );

                    getDealerPositionInfo();//资金账户信息
                    getDealerFinancialInfo();//理财信息
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

    //查询供应商信息
    function getSupplierInfo(){
        $.ajax({
            type : 'POST',
            url : '<%=request.getContextPath()%>/admin/ipcc/merchants/getSupplierInfo',
            data : {
                frontUserId : $("#suppName").val(),
                companyId : $("#compName").val()
            },
            dataType : 'json',
            success : function(data){
                if(data.status == 'ok'){
                    var msg = data.msg;
                    $("#supplier_dwmc").html(msg.custname);
                    $("#supplier_khxz").html(msg.custtype);
                    $("#supplier_frdb").html(msg.legalbody);
                    $("#supplier_sjhm").html(msg.mobilephone );
                    $("#supplier_dwdz").html(msg.saleaddr );

                    getUserBorrowInfo();//贷款信息
                    getSupplierPositionInfo();//账户信息
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

    //查询员工信息
    function getEmployeeInfo(){
        $.ajax({
            type : 'POST',
            url : '<%=request.getContextPath()%>/admin/ipcc/merchants/getEmployeeInfo',
            data : {
                phone : '${phone}'
            },
            dataType : 'json',
            success : function(data){
                if(data.status == 'ok'){
                    var msg = data.msg;
                    $("#posit").html(msg.posit);
                    $("#phone").html(msg.phone);
                    $("#name").html(msg.name);
                    $("#sex").html(msg.sex);
                    $("#companyName").html(msg.companyName);
                    $("#empno").html(msg.empno);

                    getUserWithdraw(msg.frontUserId);
                    getUserFinancial(msg.frontUserId);
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

    //查询贷款信息
    function getUserBorrowInfo(){
        $.ajax({
            type : 'POST',
            url : '<%=request.getContextPath()%>/admin/ipcc/merchants/getUserBorrowInfo',
            data : {frontUserId : $("#suppName").val(),companyId: $("#compName").val()},
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
            url : '<%=request.getContextPath()%>/admin/ipcc/merchants/getSupplierPositionInfo',
            data : {
                frontUserId : $("#suppName").val(),
                companyId : $("#compName").val()
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
    
    //查询经销商资金账户信息
    function getDealerPositionInfo(){
        $.ajax({
            type : 'POST',
            url : '<%=request.getContextPath()%>/admin/ipcc/merchants/getDealerPositionInfo',
            data : {
                frontUserId : $("#suppName").val(),
                companyId : $("#compName").val()
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
            url : '<%=request.getContextPath()%>/admin/ipcc/merchants/getDealerFinancialInfo',
            data : {
                frontUserId : $("#suppName").val(),
                companyId : $("#compName").val()
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