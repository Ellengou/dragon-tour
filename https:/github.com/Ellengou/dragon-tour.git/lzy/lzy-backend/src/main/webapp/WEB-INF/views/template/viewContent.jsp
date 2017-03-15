<%--
  Created by IntelliJ IDEA.
  User: violorch
  Date: 2016/7/4
  Time: 16:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>预览</title>
</head>
<body>
    <div id="viewContent"></div>
</body>
<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js" type="text/javascript"></script>
<script>
    $(function () {
        $.ajax({
            url: '<%=request.getContextPath()%>/admin/${url}/viewContent',
            dataType: 'json',
            type: 'GET',
            data: {
                id:${id}
            },
            success: function (data) {
                $('#viewContent').html(data.msg.content);
            },
            error: function(){
                layer.alert('系统错误', {icon : 5});
            }
        });
    })
</script>
</html>
