<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<link
	href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
<style>
.placeholder {
	font-size: 11px;
	color: #aeaeae;
}
</style>
</head>
<body>
<div id="page-wrapper" style="padding: 0 15px;">
		<div class="row">
			<div class="col-lg-12">
				<br>
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="myForm">
									<input type="text" name="compCoreId" id="compCoreId" value="${compCoreId }" hidden="true">
									<table class="table">
									   <caption>核心企业关联贷款资金来源</caption>
									   <thead>
									      <tr>
									         <th>资金来源</th>
									         <th>属性</th>
									      </tr>
									   </thead>
									   <tbody>
									   </tbody>
									</table>
								</form>
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
										<button type="button" class="btn btn-primary" onclick="save();">保存</button>
										<button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/template/bootMainJs.jsp"%>

<script src="<%=request.getContextPath()%>/bootstrap/js/util.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
	<script>
	var list = $.parseJSON('${list}');
	var source = {};
	var s = '${source}';
	if('' != s){
	  source = $.parseJSON(s);
	}
	var tmp = "";
	for(var i = 0;i<list.length;i++){
		var obj = list[i];
		tmp+='<tr>';
		tmp+='<td>'+obj.name+'</td>';
		if(exist(obj.value)){
			tmp+='<td><input type="checkbox" name="money_source_id" value="'+obj.value+'" checked="checked"></td>';
		}else{
			tmp+='<td><input type="checkbox" name="money_source_id" value="'+obj.value+'"></td>';
		}
		tmp+='</tr>';
	}
	$(".table tbody").append(tmp);
	
	function exist(value){
		if(null != source){
			for(var j=0;j<source.length;j++){
				var s = source[j];
				if(s.value == obj.value){
					return true
				}
			}
		}
		return false;
	}
	
	function save(){
		layer.msg('数据开始保存....',{offset:50});
		var jsonData = $("form").serialize();
		$.ajax({
		      url: '<%=request.getContextPath()%>/moneysource/save',
		      dataType: 'json',
		      type: 'POST',
		      data: jsonData,
		      success: function (data) {
		    	 if(data.status == 'ok'){
		    		 layer.alert('保存成功', {
	                        icon: 1,
	                        offset:50
	                  },function(index){
	                	  var parIndex = parent.layer.getFrameIndex(window.name);
	                	  layer.close(index);
	                	  parent.location.reload();
	                	  parent.layer.close(parIndex);
	                  });

		    	}else{
		    		layer.alert(data.msg, {
						icon : 5
					});
		    	}
		      },
		      error: function(){
		    	  layer.alert('数据保存出错', {
						icon : 5
					});
		      }
		  });
	}
	
	
	$(document).ready(function(){
		  
		});
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
	</script>
</body>
</html>