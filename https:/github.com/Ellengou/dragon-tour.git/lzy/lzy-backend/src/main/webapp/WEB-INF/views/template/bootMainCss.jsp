<%@ page import="com.opengroup.lzy.constants.DefaultUploadDir" %><%--
  Created by IntelliJ IDEA.
  User: violorch
  Date: 2016/4/28
  Time: 16:06
  To change this template use File | Settings | File Templates.
--%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
    a {
        cursor:pointer;
    }
</style>
<script>
    localStorage.adminUrlS = '${pageContext.request.contextPath}';
</script>
<!-- Bootstrap Core CSS -->
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="<%=request.getContextPath()%>/bootstrap/css/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="<%=request.getContextPath()%>/bootstrap/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="<%=request.getContextPath()%>/bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- Bootstrap Reset -->
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-reset.css" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/jquery-ui.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/common.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="<%=request.getContextPath()%>/bootstrap/js/html5shiv.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/js/respond.min.js"></script>
<![endif]-->
