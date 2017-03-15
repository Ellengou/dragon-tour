<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel panel-default">
	<div class="panel-body" id = "panel_deals">
		
	</div>
</div>


<script>
	var deals = ${list};
	for (var i = 0; i < deals.length; i++) {
		var template = "";
		var obj = deals[i];
		template+='<div class="panel panel-info">';
		template+='<div class="panel-heading">';
		template+='<h2 class="text-center">'+obj.title+'</h2>';
		template+='</div>';
		template+='<div class="panel-body">';
		template+='<div>'+obj.content+'</div>';
		template+='</div>';
		template+='</div>';
		$("#panel_deals").append(template);
	}
</script>