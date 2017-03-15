<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	<%-- function view(id){
		var index = layer.open({
	        type: 2,
	        offset: [100,(($(window).width()-900)/2)],
	        title: false,
	        content: '<%=request.getContextPath()%>/admin/userloan/view?id=' + id
	    });
		layer.full(index);
	} --%>
	$("#pledgeCompCoreId").showList('option', {
		infoList : '${pledgeCompCoreIdList}'
	});
	
	//绑定时间
	$('.form_time').datetimepicker({
		format : 'yyyy-mm-dd',
		language : 'zh-CN',
		minView: "month",
		weekStart : 1,
		todayHighlight : true,
		autoclose : true,
		pickerPosition : "bottom-left"
	});
</script>