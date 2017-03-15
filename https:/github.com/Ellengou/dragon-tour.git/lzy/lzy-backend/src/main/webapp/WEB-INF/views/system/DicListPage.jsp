<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统设置-字典列表</title>
<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
<link
	href="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"
	rel="stylesheet">
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
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">父类</span> <select
												class="form-control" id="pid" name="pid">
												<option value="">全部</option>
											</select>
										</div>
									</div>
									<div class="col-xs-3">
										<div class="btn-group">
											
												<button type="button" class="btn btn-primary btn-sm"
													onclick="search(1)">查询</button>
											
											<shiro:hasPermission name="sys:dic:add">
												<button type="button" class="btn btn-primary btn-sm"
													onclick="add()">添加</button>
											</shiro:hasPermission>
										</div>
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
							data-url="<%=request.getContextPath()%>/admin/system/dic/dicList"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th data-field="id">主键</th>
									<th data-field="pidName">父类的名称</th>
									<th data-field="name">名称</th>
									<th data-field="val">数值</th>
									<th data-field="status">状态</th>
									<th data-field="disOrder">排序</th>
									<th data-field="des">描述</th>
									<th data-field="button" data-call="true">操作</th>
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

	<script type="text/javascript"
		src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>

	<script type="text/javascript">
	
	function tableCallBack(data,id){
        if(id == 'button'){
	        return '<button type="button" class="btn btn-primary btn-xs" onclick="queryLoan(\'' + data.id + '\');">编辑</button>';;
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }
	
	function queryLoan(id){
		var index = layer.open({
            type: 2,
            offset: [100,(($(window).width()-900)/2)],
            title: false,
            content: '<%=request.getContextPath()%>/dic/editor?id=' + id
        });
		layer.full(index);
	}
	function view(id){
		var index = layer.open({
            type: 2,
            offset: [100,(($(window).width()-900)/2)],
            title: false,
            content: '<%=request.getContextPath()%>/dic/view?id=' + id
        });
		layer.full(index);
	}
	
	function add(){
		var index = layer.open({
            type: 2,
            offset: [100,(($(window).width()-900)/2)],
            title: false,
            content: '<%=request.getContextPath()%>/dic/add'
		
			});
			layer.full(index);
		}
		$(document).ready(function() {

		});
	</script>
</body>
</html>