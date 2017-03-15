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
<shiro:hasPermission name="protocol:content:update">
	<input id="p_update" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="protocol:content:viewInfo">
	<input id="p_viewInfo" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="	protocol:content:status">
	<input id="p_update_status" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="	protocol:content:statusInsee">
	<input id="p_update_status_insee" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="	protocol:content:delete">
	<input id="p_delete" style="display: none" value="1">
</shiro:hasPermission>
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
										<span class="input-group-addon">作者</span>
										<input type="text" class="form-control" id="author">
									</div>
								</div>
								<div class="col-xs-2">
									<div class="input-group">
										<span class="input-group-addon">协议名</span>
										<input type="text" class="form-control" id="title">
									</div>
								</div>
								<div class="col-xs-2">
									<div class="input-group">
										<span class="input-group-addon">协议类型</span>
										<select class="form-control" id="programaId">
											<option value="">全部</option>
										</select>
									</div>
								</div>
								<div class="col-xs-3">
									<button type="button" class="btn btn-primary btn-sm" onclick="search(1)">查询</button>
									<button type="button" class="btn btn-primary btn-sm" onclick="$('#myForm')[0].reset();">重置</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>

			<shiro:hasPermission name="	protocol:content:add">
				<div class="panel-heading">
					<button type="button" class="btn btn-primary" onclick="add();">新增</button>
				</div>
			</shiro:hasPermission>
			<div class="panel-body">
				<div class="table-responsive">
					<table id="myTable"
						   class="table table-striped table-bordered table-hover"
						   data-url="<%=request.getContextPath()%>/admin/protocolContent/queryContents"
						   data-pageSize="10,50,100" data-method="get">
						<thead>
						<tr>
							<th width="5%" data-field="id">ID</th>
							<%--<th width="5%" data-field="serialNum">序号</th>--%>
							<th width="5%" data-field="seqNum">排序</th>
							<th width="15%" data-field="programaId" data-call="true">类型</th>
							<th width="30%" data-field="title">协议名</th>
							<th width="10%" data-field="author">作者</th>
							<%--<th width="5%" data-field="status" data-call="true">状态</th>--%>
							<th width="10%" data-field="shelf" data-call="true">是否使用</th>
							<th width="10%" data-field="createTime" data-call="true">创建时间</th>
							<th width="15%" data-field="button" data-call="true">操作</th>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/utils.js"></script>

<script type="text/javascript">

	$(function(){
		var programaData = $.parseJSON('${programaList}');
		for (var i = 0; i < programaData.length; i++) {
			$(new Option(programaData[i].name,programaData[i].id)).appendTo('#programaId');
		}
	});

	function tableCallBack(data,id){
		if(id == 'status'){
			var contentStatusList = ${contentStatusList};
			for (var i = 0; i < contentStatusList.length; i++) {
				if(data[id] == contentStatusList[i].dicDataValue){
					return contentStatusList[i].dicDataName;
					break;
				}
			}
			return data[id];
		}else if(id == 'shelf'){
			var shelfStatusList = ${shelfStatusList};
			for (var i = 0; i < shelfStatusList.length; i++) {
				if(data[id] == shelfStatusList[i].dicDataValue){
					return shelfStatusList[i].dicDataName;
					break;
				}
			}
			return data[id];
		}else if(id == 'programaId'){
			var programaData = $.parseJSON('${programaList}');
			for (var i = 0; i < programaData.length; i++) {
				if(programaData[i].id == data.programaId){
					return programaData[i].name;
					break;
				}
			}
		}else if(id == 'button'){
			var str = '';
            var _shelf;
            if (data.shelf == 0) {
                _shelf = '下架';
            } else {
                _shelf = '上	架';
            }
			if (data.status == 1) {
				if($('#p_viewInfo').val() == 1){
					str = str +  '<button type="button" class="btn btn-primary btn-xs" onclick="viewInfo(\'' + data.id + '\');">预览</button> ';
				}
				if($('#p_update').val() == 1){
					str = str +  '<button type="button" class="btn btn-primary btn-xs disabled" onclick="edit(\'' + data.id + '\');">编辑</button> ';
				}
				if($('#p_update_status').val() == 1){
					str = str + '<button type="button" class="btn btn-warning btn-xs disabled"onclick="editStatus(\'' + data.id + '\');">发布</button> ';
				}
                if($('#p_update_status_insee').val() == 1){
                    str = str + '<button type="button" class="btn btn-warning btn-xs"  onclick="editStatusInsee(\'' + data.id + '\', \'' + data.shelf + '\');">' + _shelf + '</button> ';
                }
				if($('#p_delete').val() == 1){
					str = str + '<button type="button" class="btn btn-danger btn-xs disabled" onclick="deleteContent(\'' + data.id + '\');">删除</button>';
				}
			} else {
				if($('#p_viewInfo').val() == 1){
					str = str +  '<button type="button" class="btn btn-primary btn-xs" onclick="viewInfo(\'' + data.id + '\');">预览</button> ';
				}
				if($('#p_update').val() == 1){
					str = str +  '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> ';
				}
				if($('#p_update_status').val() == 1){
					str = str + '<button type="button" class="btn btn-warning btn-xs"  onclick="editStatus(\'' + data.id + '\');">发布</button> ';
				}
                if($('#p_update_status_insee').val() == 1){
                    str = str + '<button type="button" class="btn btn-warning btn-xs"  onclick="editStatusInsee(\'' + data.id + '\', \'' + data.shelf + '\');">' + _shelf + '</button> ';
                }
				if($('#p_delete').val() == 1){
					str = str + '<button type="button" class="btn btn-danger btn-xs" onclick="deleteContent(\'' + data.id + '\');">删除</button>';
				}
			}
			return str;
		}else{
			if(data[id] == null || data[id] == ''){
				return '';
			}else{
				return data[id];
			}
		}
	}

	function viewInfo(id) {
		var index = layer.open({
			type: 2,
			title: '协议预览',
			area: ['900px', '600px'],
			offset: [100,(($(window).width()-900)/2)],
			content:'<%=request.getContextPath()%>/admin/content/viewContentTz?url=protocolContent&id=' + id
		});
		layer.full(index);
	}

	function add(){
		var index = layer.open({
			type: 2,
			area: ['900px', '700px'],
			offset: [100,(($(window).width()-900)/2)],
			title: '添加协议',
			content: '<%=request.getContextPath()%>/admin/protocolContent/addContentPage'
		});
		layer.full(index);
	}

	function edit(id){
		var index = layer.open({
			type: 2,
			area: ['900px', '300px'],
			offset: [100,(($(window).width()-900)/2)],
			title: '修改协议',
			content: '<%=request.getContextPath()%>/admin/protocolContent/editContentPage?id=' + id
		});
		layer.full(index);
	}

	function editStatus(id) {
        var msg = '发布后，不能再修改协议内容。是否确定此操作？';
        //询问框
        layer.confirm(msg, {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/protocolContent/editContentStatus',
                dataType: 'json',
                type: 'get',
                data: {
                    id:id
                },
                success: function (data) {
                    if(data.status == 'ok'){
                        layer.alert('修改成功', {icon : 6});
                        search(parseInt($('.active').attr('jp-data')));
                    }else{
                        layer.alert(data.msg, {
                            icon : 5
                        });
                    }
                },
                error: function(){
                    layer.alert('系统错误', {
                        icon : 5
                    });
                }
            });
        });
	}

    function editStatusInsee(id,shelf) {
        var msg = '是否确定此操作？';
        //询问框
        layer.confirm(msg, {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/protocolContent/editContentStatusInsee',
                dataType: 'json',
                type: 'get',
                data: {
                    id:id,
                    shelf:shelf
                },
                success: function (data) {
                    if(data.status == 'ok'){
                        layer.alert('修改成功', {icon : 6});
                        search(parseInt($('.active').attr('jp-data')));
                    }else{
                        layer.alert(data.msg, {
                            icon : 5
                        });
                    }
                },
                error: function(){
                    layer.alert('系统错误', {
                        icon : 5
                    });
                }
            });
        });
    }

	function deleteContent(id){
		//询问框
		layer.confirm('是否确定此操作？', {
			btn: ['确定','取消'] //按钮
		}, function(){
			$.ajax({
				url: '<%=request.getContextPath()%>/admin/protocolContent/deleteContent',
				dataType: 'json',
				type: 'GET',
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