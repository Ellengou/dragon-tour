<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统设置-图片设置-列表</title>
<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
</head>
<body>
	<shiro:hasPermission name="picUrl:update">
	    <input id="p_update" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="picUrl:delete">
	    <input id="p_delete" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="picUrl:isUse">
	    <input id="p_isUse" style="display: none" value="1">
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
											<span class="input-group-addon">名称</span>
											<input type="text" class="form-control" id="name">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">类型</span>
											<select class="form-control" id="picTypeId">
												<option value="">全部</option>
                                            </select>
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
				<shiro:hasPermission name="picUrl:add">
					<div class="panel-heading">
						<button type="button" class="btn btn-primary" onclick="add();">新增</button>
					</div>
				</shiro:hasPermission>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/system/picUrl/queryPicUrls"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="5%" data-field="id">ID</th>
									<th width="10%" data-field="name">名称</th>
									<th width="40%" data-field="url">地址</th>
									<th width="10%" data-field="picTypeId" data-call="true">类型</th>
									<th width="15%" data-field="remark">备注</th>
							        <th width="10%" data-field="status" data-call="true">状态</th> 
									<th width="10%" data-field="button" data-call="true">操作</th>
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/commons.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/layer/extend/layer.ext.js"></script>
    
	<script type="text/javascript">
	
	$(function(){
		var programaData = $.parseJSON('${picTypeList}');
		for (var i = 0; i < programaData.length; i++) {
			$(new Option(programaData[i].name,programaData[i].id)).appendTo('#picTypeId');
		}
	});
	
	function tableCallBack(data,id){
    	if(id == 'picTypeId'){
    		var picTypeData = $.parseJSON('${picTypeList}');
    		for (var i = 0; i < picTypeData.length; i++) {
    			if(picTypeData[i].id == data.picTypeId){
    				return picTypeData[i].name;
    				break;
    			}
    		}
    	}else if(id=='status'){
    		if(data.status==0){
        		return "启用";
        	}else{
        		return '<font color="#FF0000">禁用</font>';
        	}
    	}else if(id == 'button'){
    		var str = '';
    		if($('#p_update').val() == 1){
        		str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> ';
    		}
    		 if($('#p_delete').val() == 1){
    			str = str + '<button type="button" class="btn btn-danger btn-xs" onclick="deletePicUrl(\'' + data.id + '\');">删除</button> ';
    		} 
    		 if($('#p_isUse').val() == 1){
    			 if(data.status == '1'){
         			str = str + ' <button type="button" class="btn btn-warning btn-xs" onclick="isUsePicUrl(\'' + data.id + '\',\'0\',\''+data.picTypeId+'\');">启用</button>';
         		}else{
         			str = str + ' <button type="button" class="btn btn-warning btn-xs" onclick="isUsePicUrl(\'' + data.id + '\',\'1\',\''+data.picTypeId+'\');">禁用</button>';
         		}
     		} 
    		 
    		str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="showPic(\'' + data.url + '\');">查看</button>';
    		return str;
    	}else{
    		if(data[id] == null || data[id] == ''){
    			return '';
    		}else{
    			return data[id];
    		}
    	}

	}
	
	function add(){
    	layer.open({
    	    type: 2,
    	    area: ['800px', '300px'],
    	    offset: [100,(($(window).width()-800)/2)],
    	    title: '增加图片',
    	    content: ['<%=request.getContextPath()%>/admin/system/picUrl/addPicUrlPage','no']
    	});
    }
    
    function edit(id){
    	layer.open({
    	    type: 2,
    	    area: ['800px', '400px'],
    	    offset: [100,(($(window).width()-800)/2)],
    	    title: '修改图片',
    	    content: ['<%=request.getContextPath()%>/admin/system/picUrl/editPicUrlPage?id=' + id,'no']
    	});
    }
    
    function deletePicUrl(id){
    	var object={'url':'<%=request.getContextPath()%>/admin/system/picUrl/deletePicUrl',
    			'data':{'id':id}};
    	commonsRequest(object);
    }
    
    function isUsePicUrl(id,status,picTypeId){
    	var object={'url':'<%=request.getContextPath()%>/admin/system/picUrl/isUsePicTypeStatus',
    			'data':{'id':id,'status':status,'picTypeId':picTypeId}
    			};
    	commonsRequest(object);
    }
    function showPic(url){
    	layer.photos({
    	    photos: {"data": [{"src": url}]}
    	  });
    }
	</script>
</body>
</html>