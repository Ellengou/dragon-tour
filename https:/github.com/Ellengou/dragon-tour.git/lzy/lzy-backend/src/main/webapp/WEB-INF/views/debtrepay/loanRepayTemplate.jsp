<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-body" id = "loans">
		
	</div>
</div>
<script>
	var list = '${list }';
	if('' != list){
		list = $.parseJSON(list);
		var temp = '';
		for(var i=0;i<list.length;i++){
			var obj = list[i];
			temp += '<div class="panel panel-default">';
			temp += '<div class="panel-heading text-center">';
			temp += '	<h1 class="panel-title">'+obj.show_name+'</h1>';
			temp += '</div>';
			temp += '<div class="panel-body">';
			temp += '	<div class="embed-responsive embed-responsive-16by9">';
			temp += '	  <iframe class="embed-responsive-item" src="<%=request.getContextPath()%>/admin/project/loan/queryRepayInfoPage?id='+obj.loan_id+'"></iframe>';
			temp += '	</div>';
			temp += '</div>';
			temp += '</div>';
		}
		$("#loans").html(temp);
	}
</script>