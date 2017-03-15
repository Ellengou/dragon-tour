<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: violorch
  Date: 2016/4/18
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>后台管理系统</title>
    <%@ include file="/WEB-INF/views/template/mainCss.jsp"%>
    <style>
        body, ul, li, h1, h2, h3, h4, p, input, strong, dl, dt, dd { font-size:14px; font-family:"微软雅黑"; margin: 0;padding: 0;}
        a, a:hover {text-decoration: none;}
        ul, li {list-style:none;}
        input {outline:none;vertical-align: middle;}
        input:-webkit-autofill {background-color: #fff;  background-image: none;  }
        input:-webkit-autofill,textarea:-webkit-autofill, select:-webkit-autofill {-webkit-box-shadow: 0 0 0px 1000px white inset;}
        img {border:none;vertical-align: middle;}
        .cf:after {clear: both;content: ".";display: block;font-size: 0;height: 0;line-height: 0;visibility: hidden;}
        .cf {*zoom:1;}
        a,span{display:inline-block;}
        .loginBg{height:100%; width:100%; background:url("${ctx}/bootstrap/images/login_bg.jpg") no-repeat center top/cover; position: relative;}
        .w1200{width:1200px; margin:0 auto;}
        .header{width:100%;height:120px; background:#f6f7fb;}
        .logPic{height:120px;background:url("${ctx}/bootstrap/images/login_log.png") no-repeat center center; }
        .section{padding-top:87px;}
        .section .wrap-login{width:560px; height:430px; border:1px solid #fff;border-radius:3px; margin:0 auto; position:relative;}
        .wrap-login .border-blue{border:10px solid #9ebadf;border-radius:3px; }
        .wrap-login .border-circle1{border:5px solid #9ebadf;width:540px; height:446px;border-radius:10px; position:absolute; top:4px;left:5px;z-index:1;}
        .wrap-login .wrap-title{height:60px; background:#3c9bf1;font-size:20px; color:#f6f7fb; font-family:"宋体";line-height:60px;padding-left:20px;}
        .wrap-login .wrap-cont{background:#e7eff9; padding:40px 70px 20px;}
        .form-row{margin-bottom:20px; }
        .form-row label{width: 70px;padding-right:15px;display: inline-block;line-height:48px;text-align:right;}
        .form-row input[type="text"],.form-row input[type="password"]{width:257px;height:48px;padding-left:10px; border:1px solid #ccc; color:#333;font-size:16px; line-height:48px;vertical-align:top; padding-right:40px; display: inline-block;}
        .form-row input:focus{border-color:#6a96df}
        .form-row input.userName{background:url("${ctx}/bootstrap/images/input_bg.jpg") no-repeat right -2px;}
        .form-row input.loginPw{background:url("${ctx}/bootstrap/images/input_bg.jpg") no-repeat right -48px;}
        .form-row input.captcha{width:140px;background:url("${ctx}/bootstrap/images/input_bg.jpg") no-repeat 0 0;}
        .form-row span.varityCode{width:100px; height:48px; margin-left:5px;margin-right:2px;vertical-align:top;float:right;}
        .form-row span.varityCode img{width:100%;height:100%;border:0;vertical-align:top; }
        .remember{color:#666;font-size:14px; line-height:20px;}
        .remember .checkBox-login{margin-right:10px;}
        .remember .blue-font{color:#3c9bf1;float:right; cursor:pointer;}
        .form-btn{padding-top:10px;}
        .form-btn input.loginBtn{width:400px; height:50px; border-radius:6px; line-height:46px; text-align:center; color:#fff;font-size:22px; font-family:"宋体"; border:0; background:#3c9bf1; cursor:pointer;}
        .footer{width:100%;height:100px; background:#f6f7fb; margin-top: 218px;}
        .footer p{color:#666;font-size:14px; line-height:30px;padding:35px 0; text-align:center;}
        .footer p span{margin-left:25px;}
    </style>
</head>
    <script>
        var captcha;
        function refreshCaptcha(){
            document.getElementById("img_captcha").src="${ctx}/bootstrap/images/kaptcha?t=" + Math.random();
        }
    </script>
</head>

<body class="loginBg">
<div class="header">
    <div class="w1200">
        <div class="logPic"></div>
    </div>
</div>
<div class="section">
    <div class="wrap-login">
        <div class="border-circle"></div>
        <div class="border-blue">
            <div class="wrap-title">用户登录</div>
            <div class="wrap-cont">
                <form:form class="sign-in-form" id="signUp" action="${ctx}/admin/login" method="post" commandName="user">
                    <div class="form-row">
                        <label>用户名：</label>
                        <input type="text"  id="siUser" name="username"/>
                    </div>
                    <div class="form-row">
                        <label>密码：</label>
                        <input type="password"  id="userpassword" name="password"/>
                    </div>
                    <div class="form-row">
                        <label>验证码：</label>
                        <input type="text" class="captcha" name="captcha"/><span class="varityCode">
                        <img alt="验证码" src="${ctx}/bootstrap/images/kaptcha" title="点击更换" id="img_captcha"
                             onclick="javascript:refreshCaptcha();" /></span>
                    </div>
                    <div class="form-row form-btn">
                        <input type="submit" value="登陆" class="loginBtn"/>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
<div class="footer">
    <p class="w1200"><span>Copyright：xxx      </span><span>公司地址：xxx      </span><span>电话：0571-xxxxxxxx</span></p>
</div>
<script src="${ctx}/bootstrap/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/plugin/layer/layer.js" type="text/javascript"></script>
<script>
    $(function () {
        var msg = '${msg}';
        if (msg != '') {
            layer.alert(msg, {
                icon: 5
            });
        }
    })
</script>
</body>
</html>
