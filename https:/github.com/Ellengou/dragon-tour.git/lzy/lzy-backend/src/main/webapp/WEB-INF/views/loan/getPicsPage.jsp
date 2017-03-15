<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-body" id="pics">
		
	</div>
</div>


<script>
	var jsonData = $.parseJSON('${jsonData}');
	var template = "";
	for (var i = 0; i < jsonData.length; i++) {
		var obj = jsonData[i];
		template += '<img onclick="showPic('+obj.id+')" src="<%=request.getContextPath()%>/admin/project/loan/getPic?id='+obj.id+'" class="img-thumbnail">';
	}
	$("#pics").append(template);
	//大图展示单张图片
	function showPic(id){
		var url = '<%=request.getContextPath()%>/admin/project/loan/getPic?id='+id;
		layer.photos({
		    photos: {"data": [{"src": url}]}
		  });
	}
</script>