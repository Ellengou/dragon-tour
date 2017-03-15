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
	<shiro:hasPermission name="bank:edit">
	    <input id="p_edit" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="	bank:delete">
	    <input id="p_delete" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="	bankLimit:query">
	    <input id="p_query" style="display: none" value="1">
	</shiro:hasPermission>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<shiro:hasPermission name="bank:add">
					<div class="panel-heading">
						<button type="button" class="btn btn-primary" onclick="add();">新增</button>
					</div>
				</shiro:hasPermission>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/bank/queryScfBanks"
							data-pageSize="10,50,100" data-method="post">
							<thead>
								<tr>
									<th width="20px" data-field="id">ID</th>
									<th width="50px" data-field="bankName">银行名称</th>
									<th width="50px" data-field="bankCode">银行编码</th>
									<th width="50px" data-field="imgName">图片名称</th>
									<th width="50px" data-field="type" data-call="true">类型</th>
									<th width="50px" data-field="payClass">本系统支付类型</th>
									<th width="50px" data-field="button" data-call="true">操作</th>
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
		if(id == 'type'){
    		if(data[id] == null || data[id] == ''){
    			return '';
    		}
    		var bankTypeList = ${bankTypeList};
    		for (var i = 0; i < bankTypeList.length; i++) {
    			if(data[id] == bankTypeList[i].dicDataValue){
    				return bankTypeList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'button'){
    		var str = '';
    		if($('#p_edit').val() == 1){
        		str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> ';
    		}
    		if($('#p_delete').val() == 1){
    			if(data.type == '0'){
    				str = str + '<button type="button" class="btn btn-danger btn-xs" onclick="deleteBank(\'' + data.id + '\');">删除</button>';
    			}
    		}
    		if($('#p_query').val() == 1){
    			str = str + ' <button type="button" class="btn btn-primary btn-xs" onclick="editBankLimit(\'' + data.id + '\');">编辑限额</button> ';
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
	
	function add(){
    	layer.open({
    	    type: 2,
    	    area: ['800px', '300px'],
    	    offset: [100,(($(window).width()-800)/2)],
    	    title: '增加银行',
    	    content: ['<%=request.getContextPath()%>/admin/bank/addBankPage','no']
    	});
    }
    
    function edit(id){
    	layer.open({
    	    type: 2,
    	    area: ['800px', '300px'],
    	    offset: [100,(($(window).width()-800)/2)],
    	    title: '修改银行',
    	    content: ['<%=request.getContextPath()%>/admin/bank/editBankPage?id=' + id,'no']
    	});
    }
    
    function editBankLimit(id){
    	var index = layer.open({
    	    type: 2,
    	    area: ['800px', '300px'],
    	    offset: [100,(($(window).width()-800)/2)],
    	    title: '修改银行限额',
    	    content: ['<%=request.getContextPath()%>/admin/bankLimit/bankLimitPage?id=' + id,'no']
    	});
    	layer.full(index);
    }
    
    function deleteBank(id){
    	//询问框
    	layer.confirm('是否确定此操作？', {
    	  btn: ['确定','取消'] //按钮
    	}, function(){
    		$.ajax({
  		      url: '<%=request.getContextPath()%>/admin/bank/deleteBank',
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