<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
</head>
<body>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-12">
							<form id="myForm">
								<div class="row">
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">职位名称</span>
											<input type="text" class="form-control" id="name">
										</div>
									</div>
									<div class="col-xs-3">
										<button type="button" class="btn btn-primary btn-sm" onclick="search(1)">查询</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>

				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/compPosit/queryCompPosits"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="10%" data-field="id">ID</th>
									<th width="30%" data-field="compCoreName">核心企业</th>
									<th width="30%" data-field="compName">所属公司</th>
									<th width="30%" data-field="name">职位</th>
									<th width="30%" data-field="button" data-call="true">操作</th>
								</tr>
							</thead>
							<tbody id="tbodyId">

							</tbody>
						</table>
					</div>
					<div class="row">
						<div align="left" class="col-xs-6">
							<div class="input-group">
								<span class="input-group-addon" id="pageCount"></span> <select
									id="pageSize" onchange="search(1)" class="form-control"
									style="width: 100px"></select>
							</div>
						</div>
						<div align="right" class="col-xs-6">
							<ul class="pagination" id="pagination"></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/template/bootMainJs.jsp"%>
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>
    
	<script type="text/javascript">
	
	function tableCallBack(data,id){
        if(id == 'button'){
        	var str = "";
        	str += '<bu	tton type="button" class="btn btn-primary btn-xs" onclick="view(\'' + data.id + '\');">详情</button>';;
        	return str;
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }
	
	function view(id){
		layer.open({
    	    type: 2,
    	    area: ['400px', '300px'],
    	    offset: [100,(($(window).width()-400)/2)],
    	    title: '查看公司职位',
    	    content: ['<%=request.getContextPath()%>/admin/compPosit/viewCompPositPage?id='+id,'no']
    	});
	}
	
	function add(){
    	layer.open({
    	    type: 2,
    	    area: ['400px', '300px'],
    	    offset: [100,(($(window).width()-400)/2)],
    	    title: '增加公司职位',
    	    content: ['<%=request.getContextPath()%>/admin/compPosit/addCompPositPage','no']
    	});
    }
    
    function edit(id){
    	layer.open({
    	    type: 2,
    	    area: ['400px', '300px'],
    	    offset: [100,(($(window).width()-400)/2)],
    	    title: '修改公司职位',
    	    content: ['<%=request.getContextPath()%>/admin/compPosit/editCompPositPage?id=' + id,'no']
    	});
    }
    
    function deletePrograma(id){
    	//询问框
    	layer.confirm('是否确定此操作？', {
    	  btn: ['确定','取消'] //按钮
    	}, function(){
    		$.ajax({
  		      url: '<%=request.getContextPath()%>/admin/compPosit/deleteCompPosit',
  		      dataType: 'json',
  		      type: 'POST',
  		      data: {
  		    	  id:id
  		      },
  		      success: function (data) {
  		    	if(data.status == 'ok'){
  		    		layer.alert('删除成功', {icon : 6});
  		    		search(parseInt($('.active').attr('jp-data')));
  		    	}else{
  		    		layer.alert(data.msg, {icon : 5});
  		    	}
  		      },
  		      error: function(){
  		    	  layer.alert('系统错误', {icon : 5});
  		      }
  		  });
    	}, function(){
    		
    	});
    }
	</script>
</body>
</html>