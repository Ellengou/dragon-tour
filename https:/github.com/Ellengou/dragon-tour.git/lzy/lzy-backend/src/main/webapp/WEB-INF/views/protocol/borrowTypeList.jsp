<%--
  Created by IntelliJ IDEA.
  User: violorch
  Date: 2016/6/6
  Time: 10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>后台管理系统</title>
    <%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/jquery.treegrid.css">
</head>
<body>
<shiro:hasPermission name="borrow:type:edit">
    <input id="p_edit" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="borrow:type:delete">
    <input id="p_delete" style="display: none" value="1">
</shiro:hasPermission>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
            <shiro:hasPermission name="borrow:type:add">
                <button type="button" class="btn btn-primary" onclick="add();">新增</button>
            </shiro:hasPermission>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table id="myTable"
                           class="table table-striped table-bordered table-hover"
                           data-url="<%=request.getContextPath()%>/admin/borrowType/queryList"
                           data-pageSize="10,50,100" data-method="get">
                        <thead>
                        <tr>
                            <th data-field="name">名称</th>
                            <th data-field="procotol_count">启用的协议系列数量</th>
                            <th data-field="pro_button" data-call="true">协议操作</th>
                            <th data-field="button" data-call="true">基本操作</th>
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
        	var str = '';
        	if($("#p_edit").val() == 1){
            	str += '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button>';
        	}
        	if($("#p_delete").val() == 1){
	            str += '<button type="button" class="btn btn-danger btn-xs" onclick="deleteType(\'' + data.id + '\');">删除</button> ';
        	}
            return str;
        }else if(id == 'pro_button'){
        	var str = '<button type="button" class="btn btn-primary btn-xs" onclick="viewBorrowTypePro(\'' + data.id + '\');">查看</button>';
        	return str;
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }

    function viewBorrowTypePro(borrowTypeId){
    	var index = layer.open({
            type: 2,
            area: ['500px', '400px'],
            offset: [100,(($(window).width()-500)/2)],
            title: false,
            content: ['<%=request.getContextPath()%>/admin/borrowType/viewBorrowTypePro?borrowTypeId='+borrowTypeId,'yes']
        });
    	layer.full(index)
    }
    
    function add(){
        layer.open({
            type: 2,
            area: ['500px', '400px'],
            offset: [100,(($(window).width()-500)/2)],
            title: '增加产品类型',
            content: ['<%=request.getContextPath()%>/admin/borrowType/add','no']
        });
    }

    function deleteType(id){
		layer.confirm('确认删除?', {icon: 3, title:'提示'}, function(index){
		  $.post('<%=request.getContextPath()%>/admin/borrowType/deleteType',{id:id},function(data){
			  data = $.parseJSON(data)
			  if(data.status == 'ok'){
				  location.reload();
			  }else{
				  layer.alert(data.msg)
			  }
		  })
		  layer.close(index);
		});
	}

    function edit(id){
        layer.open({
            type: 2,
            area: ['500px', '400px'],
            offset: [100,(($(window).width()-500)/2)],
            title: '修改借款类型',
            content: ['<%=request.getContextPath()%>/admin/borrowType/edit?id=' + id,'no']
        });
    }
</script>
</body>
</html>