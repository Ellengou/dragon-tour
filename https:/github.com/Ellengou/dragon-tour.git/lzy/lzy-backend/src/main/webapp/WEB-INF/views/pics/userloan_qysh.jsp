<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<style>
    .placeholder {
        font-size: 11px;
        color: #aeaeae;
    }
</style>
</head>
<body>
	<input id="file" type="file" class="file" multiple>
	<input type = "hidden" name="id" value="${userLoanId }">
	<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- layer JavaScript -->
	<%@ include file="/WEB-INF/views/template/bootstrap-fileinput-master.jsp"%>
	<script>
	var list = '${list}';
	var baseUrl = '${baseUrl}';
	var template = [];
	if('' != list){
		list = $.parseJSON(list);
		for(var i=0;i<list.length;i++){
			var obj = list[i];
			template[i] = '<img alt="" src="'+baseUrl+obj['web_url']+'">';
		}
	}
	$('#file').fileinput({
        language: 'zh',
        initialPreview:template,
        uploadUrl: '<%=request.getContextPath()%>/pics/userLoanQySh?id=${userLoanId}',
        allowedFileExtensions : ['jpg', 'png','gif'],
    });
	$("#file").on("fileuploaded", function(event, data, previewId, index) {
	});
	$(function(){
		var initHeight = $(window.document).height();
		$(window.parent.document).find('#dataIframe').attr('height',initHeight+50);
	});
	</script>
</body>
</html>