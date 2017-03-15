<%@ page import="com.opengroup.lzy.sys.utils.UserUtil" %>
<%--
  Created by IntelliJ IDEA.
  User:violorch
  Date: 2016/4/15
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String wsPath = "ws://" + request.getServerName() + ":"+request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>后台管理系统</title>
    <%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
    <link href="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <style>
      .showHideBar{position: absolute;right: 0;top:0; height: 100%; width: 12px;}
      .showBar{background: #fff url("<%=request.getContextPath()%>/images/show.png") no-repeat center center;width: 20px}
      .hideBar:hover{background: #bbd4e5 url("<%=request.getContextPath()%>/images/hide.png") no-repeat center center;}
      .sidebar #side-menu li a{padding-right: 20px;}
      #page-wrapper{margin-top: 30px;position: relative;padding-top: 10px;}
      #page-wrapper .page-tab{position: absolute;top:-30px; left: 0; z-index: 10;}
      #page-wrapper .page-tab a{display:inline-block;padding:0 10px; text-decoration: none; color:#000;margin-right: 5px; font-size:14px;line-height: 30px;background: #f9f9f9;border-top-right-radius: 4px;border-top-left-radius: 4px;}
      #page-wrapper .page-tab a.active{background: #337ab7;color:#fff;}
      #page-wrapper .page-tab .homeTab{display:inline-block;padding:0 10px; color:#000;margin-right: 5px; font-size:14px;line-height: 30px;background: #f9f9f9;border-top-right-radius: 4px;border-top-left-radius: 4px; cursor: pointer;}
      #page-wrapper .page-tab .active{background: #337ab7;color:#fff;}
      #page-wrapper .page-tab a span.closebtn{background:url("<%=request.getContextPath()%>/images/error.png") no-repeat 0 0;display: inline-block;width: 20px; height: 20px;float:right;margin-top: -8px;margin-right: -20px;cursor: pointer;}
      #page-wrapper .page-cont iframe{display: none;}
      #page-wrapper .page-cont .show-iframe{display: block;}
    </style>
</head>
<body class="noy">
<!-- IPCC -->
<shiro:hasPermission name="ipcc:top">
<%@ include file="/WEB-INF/views/ipcc/ipcc.jsp"%>

</shiro:hasPermission>
<div id="wrapper">
    <!-- 头部导航 -->
    <nav class="navbar navbar-default navbar-static-top" role="navigation">
        <div class="navbar-outer">
            <div class="navbar-inner cf">
                <div class="log-wrap">投融汇</div>
                <div class="nav-collapse collapse navbar-responsive-collapse">
                    <ul class="nav" id="header-nav">
                        <li class="active"><a >首页</a></li>
                    </ul>
                </div>
                <div class="navbar-right cf">
                    <%--<img src="" class="advarImg">--%>
                    <div class="dropdown userLogin">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <span><%=UserUtil.getCurrentUser().getLoginName() %></span> , 你好！
                            <i class="fa">
                                <span class="top_round" style="font-size: 12px"></span>
                            </i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li onclick="changePwd();"><a><i class="fa fa-user fa-fw"></i> 修改密码</a></li>
                            <li onclick="changeLoginName();"><a><i class="fa fa-user fa-fw"></i> 修改登录名</a></li>
                            <li><a href="<%=request.getContextPath()%>/admin/messageSend/message" target="iframe" scrolling="auto" onclick="showMessage();">
                                <i class="fa fa-gear fa-fw"></i> 站内信 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="top_round" style="font-size: 12px"></span></a></li>
                            <%--<li class="divider"></li>--%>
                        </ul>
                    </div>
                    <a class="logout" href="<%=request.getContextPath()%>/admin/logout"> 退出</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Page Content -->
    <div class="row-fluid" id="indexPage" style="display: none;">
        <div class="navbar-default sidebar" role="navigation" >
            <div class="sidebar-nav navbar-collapse">
                <!-- 左侧菜单栏 -->
                <ul class="nav" id="side-menu">
                </ul>
            </div>
        </div>
        <div id="page-wrapper">
            <div class="page-tab">
              <span class="homeTab">首页</span>
            </div>
            <div class="page-cont">
            </div>
        </div>
    </div>
    <div class="row-fluid" id="homeHtml" align="center">
        <h1 style="margin-top: 240px">欢迎来到投融汇平台管理中心</h1>
        <%--<div id="homePage">--%>
            <%--<div class="sec cf">--%>
                <%--<div class="col-7 fl">--%>
                    <%--<h1><span class="icon1"></span>今日待办事项<span class="txt">亲爱的，喝杯咖啡提提神！~</span></h1>--%>
                    <%--<ul>--%>
                        <%--<li>核心企业待审核 <span>5个</span></li>--%>
                        <%--<li>供应商新增 <span>5个</span></li>--%>
                        <%--<li>理财产品待审核 <span>5个</span></li>--%>
                        <%--<li>满标待审<span>5个</span></li>--%>
                        <%--<li>标的投资中<span>5个</span></li>--%>
                        <%--<li>到期返款<span>5个</span></li>--%>
                        <%--<li>到期还款<span>5个</span></li>--%>
                    <%--</ul>--%>
                <%--</div>--%>
                <%--<div class="col-3 fr">--%>
                    <%--<h1><span class="icon2"></span>用户操作记录</h1>--%>
                    <%--<ul>--%>
                        <%--<li>2016-05-09  14:20:34  admin  <span>登录系统</span></li>--%>
                        <%--<li>2016-05-09  14:20:34  admin  <span>编辑借款产品5 旅行贷</span></li>--%>
                        <%--<li>2016-05-09  14:20:34  admin  <span>编辑内容11 不用iphone   GG15003216</span></li>--%>
                        <%--<li>2016-05-09  14:20:34  admin  <span>登录系统</span></li>--%>
                        <%--<li>2016-05-09  14:20:34  admin  <span>编辑借款产品5 旅行贷  GG15003216</span></li>--%>
                        <%--<li>2016-05-09  14:20:34  admin  <span>编辑内容11</span></li>--%>
                        <%--<li>2016-05-09  14:20:34  admin  <span>编辑借款产品5 旅行贷</span></li>--%>
                    <%--</ul>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="sec">--%>
                <%--<div class="title filter">--%>
                    <%--<a>昨日</a>--%>
                    <%--<a>本周</a>--%>
                    <%--<a>本月</a>--%>
                    <%--<a>历史累计</a>--%>
                    <%--<div class="time-wrap">--%>
                        <%--<label>时间：</label>--%>
                        <%--<div id="start_visit_time" class="input-group date form_time">--%>
                            <%--<input id="minCreateTime" class="form-control " type="text" name="startDate">--%>
                            <%--<span class="input-group-addon">--%>
                                <%--<span class="glyphicon glyphicon-remove"></span>--%>
                            <%--</span>--%>
                            <%--<span class="input-group-addon time-icon">--%>
                                <%--<span class="glyphicon glyphicon-calendar"></span>--%>
                            <%--</span>--%>
                        <%--</div>--%>
                        <%-----%>
                        <%--<div id="end_visit_time" class="input-group date form_time">--%>
                            <%--<input id="endDate" name="endDate" class="form-control"  type="text" >--%>
                            <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                            <%--<span class="input-group-addon time-icon"><span class="glyphicon glyphicon-calendar"></span></span>--%>
                        <%--</div>--%>

                        <%--&lt;%&ndash;<input type="text" class="dataTime"/>--%>
                        <%--<span>-</span>--%>
                        <%--<input type="text" class="dataTime"/>&ndash;%&gt;--%>
                    <%--</div>--%>
                    <%--<a class="filterBtn">查询</a>--%>
                <%--</div>--%>
                <%--<div class="filterCont">--%>
                    <%--<ul class="cf">--%>
                        <%--<li>--%>
                            <%--<p class="row-t">10000</p>--%>
                            <%--<p>新增用户</p>--%>
                            <%--<span class="icon01"></span>--%>
                        <%--</li>--%>
                        <%--<li>--%>
                            <%--<p class="row-t">12345668</p>--%>
                            <%--<p>充值</p>--%>
                            <%--<span class="icon02"></span>--%>
                        <%--</li>--%>
                        <%--<li>--%>
                            <%--<p class="row-t">1564812</p>--%>
                            <%--<p>提现</p>--%>
                            <%--<span class="icon03"></span>--%>
                        <%--</li>--%>
                        <%--<li>--%>
                            <%--<p class="row-t">26</p>--%>
                            <%--<p>在售</p>--%>
                            <%--<span class="icon04"></span>--%>
                        <%--</li>--%>
                        <%--<li>--%>
                            <%--<p class="row-t">12487</p>--%>
                            <%--<p>理财购买</p>--%>
                            <%--<span class="icon05"></span>--%>
                        <%--</li>--%>
                        <%--<li>--%>
                            <%--<p class="row-t">1234715</p>--%>
                            <%--<p>贷款申请</p>--%>
                            <%--<span class="icon06"></span>--%>
                        <%--</li>--%>
                        <%--<li>--%>
                            <%--<p class="row-t">124881</p>--%>
                            <%--<p>返款本息</p>--%>
                            <%--<span class="icon07"></span>--%>
                        <%--</li>--%>
                        <%--<li>--%>
                            <%--<p class="row-t">124746</p>--%>
                            <%--<p>还款本息</p>--%>
                            <%--<span class="icon08"></span>--%>
                        <%--</li>--%>
                    <%--</ul>--%>

                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="sec">--%>
                <%--<h1>--%>
                    <%--<span class="icon3"></span>--%>
                    <%--历史累计--%>
                <%--</h1>--%>
                <%--<div class="historyM">--%>
                    <%--<ul class="cf">--%>
                        <%--<li class="cf">--%>
                            <%--<div class="col-l">--%>
                                <%--<span>平台账户</span>--%>
                                <%--<span>可用余额</span>--%>
                                <%--<span>累计充值</span>--%>
                                <%--<span>累计提现</span>--%>
                            <%--</div>--%>
                            <%--<div class="col-r">--%>
                                <%--<span>156321.03</span>--%>
                                <%--<span>100000</span>--%>
                                <%--<span>10000</span>--%>
                                <%--<span>200</span>--%>
                            <%--</div>--%>
                        <%--</li>--%>
                        <%--<li>--%>
                            <%--<div class="col-l">--%>
                                <%--<span>用户总数</span>--%>
                                <%--<span>核心企业</span>--%>
                                <%--<span>供应商</span>--%>
                                <%--<span>经销商</span>--%>
                                <%--<span>员工</span>--%>
                                <%--<span>社会投资</span>--%>
                            <%--</div>--%>
                            <%--<div class="col-r">--%>
                                <%--<span>4036个</span>--%>
                                <%--<span>152</span>--%>
                                <%--<span>1589</span>--%>
                                <%--<span>1200</span>--%>
                                <%--<span>100002</span>--%>
                                <%--<span>158</span>--%>
                            <%--</div>--%>
                        <%--</li>--%>
                        <%--<li>--%>
                            <%--<div class="col-l">--%>
                                <%--<span>理财产品</span>--%>
                                <%--<span>理财总额</span>--%>
                                <%--<span>待还本金</span>--%>
                                <%--<span>待还利息</span>--%>
                                <%--<span>已返本金</span>--%>
                                <%--<span>已返利息</span>--%>
                                <%--<span>投资总人数</span>--%>
                                <%--<span>人均投资额</span>--%>
                            <%--</div>--%>
                            <%--<div class="col-r">--%>
                                <%--<span>40个</span>--%>
                                <%--<span>12456796万元</span>--%>
                                <%--<span>123564万元</span>--%>
                                <%--<span>100万元</span>--%>
                                <%--<span>100万元</span>--%>
                                <%--<span>100万元</span>--%>
                                <%--<span>1000人</span>--%>
                                <%--<span>20000元</span>--%>
                            <%--</div>--%>
                        <%--</li>--%>
                        <%--<li>--%>
                            <%--<div class="col-l">--%>
                                <%--<span>贷款总额</span>--%>
                                <%--<span>待还本金</span>--%>
                                <%--<span>待还利息</span>--%>
                                <%--<span>已返本金</span>--%>
                                <%--<span>已还利息</span>--%>
                                <%--<span>贷款总人数</span>--%>
                                <%--<span>人均贷款额</span>--%>
                            <%--</div>--%>
                            <%--<div class="col-r">--%>
                                <%--<span>12456796万元</span>--%>
                                <%--<span>123564万元</span>--%>
                                <%--<span>100万元</span>--%>
                                <%--<span>15462万元</span>--%>
                                <%--<span>100万元</span>--%>
                                <%--<span>1000人</span>--%>
                                <%--<span>20000元</span>--%>
                            <%--</div>--%>
                        <%--</li>--%>
                    <%--</ul>--%>

                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    </div>


</div>
<%@ include file="/WEB-INF/views/template/bootMainJs.jsp"%>
<script src="<%=request.getContextPath()%>/bootstrap/js/sb-admin-2.js" type="text/javascript"></script>

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

        var countInit = '${sessionScope.sys_user_message_count}';
        if (countInit > 0) {
            $('.top_round').show();
            $('.top_round').html(countInit);
        } else {
            $('.top_round').hide();
        }
    });
</script>

<script type="text/javascript">
    $(function(){
        //建立socket连接
        var sock;
        if ('WebSocket' in window) {
            sock = new WebSocket("<%=wsPath%>socketServer");
        } else if ('MozWebSocket' in window) {
            sock = new MozWebSocket("<%=wsPath%>socketServer");
        } else {
            sock = new SockJS("<%=basePath%>socket/socketServer");
        }
        sock.onopen = function (e) {
            console.log(e);
        };
        sock.onmessage = function (e) {
            console.log(e)
            if (e.data > 0) {
                $('.top_round').show();
                $('.top_round').html(e.data);
            } else {
                $('.top_round').hide();
            }
        };
        sock.onerror = function (e) {
            console.log(e);
        };
        sock.onclose = function (e) {
            console.log(e);
        }
    });

    //全局的AJAX访问，处理AJAX清求时SESSION超时
    $.ajaxSetup({
        contentType:"application/x-www-form-urlencoded;charset=utf-8",
        complete:function(XMLHttpRequest,textStatus){
            //通过XMLHttpRequest取得响应头，sessionStatus
            var sessionStatus = XMLHttpRequest.getResponseHeader("sessionStatus");
            if(sessionStatus == "timeout"){
                //跳转的登录页面
                layer.confirm('您登陆的时间超时，请重新登陆', {
                    btn: ['确定', '取消'], //按钮
                    icon: 6
                }, function(){
                    top.location.replace('<%=request.getContextPath()%>/admin/login');
                }, function(){
                });
            }
        }
    });

    function changePwd() {
        //iframe层-父子操作
        var index = layer.open({
            type: 2,
            area: ['900px', '350px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '修改密码',
            content: ['<%=request.getContextPath()%>/admin/manager/changePwd', 'no']
        });
    }

    function changeLoginName() {
        //iframe层-父子操作
        var index = layer.open({
            type: 2,
            area: ['700px', '300px'],
            offset: [100,(($(window).width()-700)/2)],
            title: '修改密码',
            content: ['<%=request.getContextPath()%>/admin/manager/changeLoginName', 'no']
        });
    }

    function showMessage() {
        $('#indexPage').show();
        $('#homeHtml').hide();
    }

    /**
     * page-wrapper 自适应高度
     */
    function frameresize(){
        var winheight = $(window).height();
        var iframeheight = winheight;
        $('#page-wrapper').css('height', iframeheight - 102 + 'px');
    };

    if(window.attachEvent){
        document.getElementById("page-wrapper").attachEvent('onload', frameresize);
    }
    else{
        document.getElementById("page-wrapper").addEventListener('load', frameresize, false);
    }

    $(window).resize(frameresize);


    frameresize();

</script>
</body>
</html>