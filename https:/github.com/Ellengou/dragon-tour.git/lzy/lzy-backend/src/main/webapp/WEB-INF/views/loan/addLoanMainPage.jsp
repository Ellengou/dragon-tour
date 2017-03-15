<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<style>
    .placeholder {
        font-size: 11px;
        color: #aeaeae;
    }
    html,body {
    	padding:0;
    	overflow-x:hidden;
    }
		#myTab{margin-bottom: 20px;}
		#myTab li a{border-color:#ddd;border-radius:0;border-top-left-radius: 4px; border-top-right-radius: 4px;outline: none;}
		#myTab li.active a{background-color:#eee; }
		#div_dq p{height:20px;}
		#div_dq p a.btn-primary{float: right;}
		#div_hq p{height:20px;}
		#div_hq p a.btn-primary{float: right;}
</style>
</head>
<body>
<div class="panel panel-info">
  <div class="panel-heading">请选择产品类型</div>
  <div class="panel-body">
	<ul id="myTab" class="nav nav-tabs nav-justified" role="tablist">
	  <li role="presentation" class="active"><a href="#div_dq">定期</a></li>
	  <li role="presentation"><a href="#div_hq">活期</a></li>
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id = "div_dq">
			<div class="panel panel-default panel-wrap">
				<div class="panel panel-default">
					<div class="panel-heading">定期产品</div>
					<div class="panel-body" id = "dq">
					
					</div>
				</div>
			</div>
		</div>
		<div class="tab-pane fade" id = "div_hq">
			<div class="panel panel-default panel-wrap">
				<div class="panel panel-default">
					<div class="panel-heading">活期产品</div>
					<div class="panel-body" id = "hq">
					
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	<!-- layer JavaScript -->
	<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script>
	
		function getHtml(prodTypeId,name){
			var html = '';
			html+= '<div class="col-xs-6 col-md-3">';
			html+= '<a href="<%=request.getContextPath()%>/admin/project/loan/addLoanPage?prodTypeId='+prodTypeId+'" class="thumbnail">'
			html+= '<img data-src="" style="width: 100px;height: 100px" alt="'+name+'">'
			html+= '</a>'
			html+= '</div>'
			return html;
		}
		
		function getHtml1(prodTypeId,name){
			var html = '';
			html+= '<div class="col-xs-6 col-md-4">';
			html+= '<div class="thumbnail">'
			html+= '<div class="caption">'
			html+= '<h3>'+name+'</h3>'
			html+= '<p><a href="<%=request.getContextPath()%>/admin/project/loan/addLoanPage?prodTypeId='+prodTypeId+'" class="btn btn-primary" role="button">新增</a></p>'
			html+= '</div>'
			html+= '</div>'
			html+= '</div>'
			return html;
		}
		
		
		$(document).ready(function(){
			var list = '${list}';
			if('' != list){
				list = $.parseJSON(list);
				for(var i = 0;i<list.length;i++){
					var obj = list[i];
					var html = getHtml1(obj.id,obj.name);
					if('1' == obj.pid){
						$('#dq').append(html);
					}else if('2' == obj.pid){
						$('#hq').append(html);
					}
				}
			}
			//单独激活每个标签
			$('#myTab a').click(function (e) {
				  e.preventDefault()
				  var $this = $(this);
				  $this.tab('show')
				})
		});
	</script>
</body>
</html>