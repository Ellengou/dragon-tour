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
									<input type="text" name="id" value="${id }" hidden="true">
									<input type="text" name="type" value="${type }" hidden="true">
									<div  class="form-group">
										<label class="col-xs-2 control-label">状态</label>
										<div class="input-group col-xs-9" id = "div_verifyStatus">
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-2 control-label">备注</label>
										<div class="input-group col-xs-9">
											<textarea class="form-control" rows="3" id = "verifyReason" name="verifyReason"></textarea>
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-2 control-label">资料上传</label>
										<div class="input-group col-xs-9">
											<input id="dataFile" type="file" class="file" multiple>
										</div>
									</div>
								</form>
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
									<shiro:hasPermission name="userloan:org:verify:save">
										<button type="button" class="btn btn-primary" onclick="save();">保存</button>
									</shiro:hasPermission>
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
	<%@ include file="/WEB-INF/views/template/bootstrap-fileinput-master.jsp"%>
	<script src="<%=request.getContextPath()%>/bootstrap/js/util.js" type="text/javascript"></script>
	<!-- layer JavaScript -->
	<script>
	var uploadedFile = 0;
	var hasFile = false;
	var idx;
	$('#dataFile').fileinput({
        language: 'zh',
        showCancel:false,
        showClose:false,
        showUpload:false,
        uploadUrl: '<%=request.getContextPath()%>/pics/userLoanOrgSh?id=${id }',
        showPreview:false,
        allowedFileExtensions : ['jpg', 'png','gif']
    }).on("filebatchselected", function(event, files) {
    	hasFile = true;
    }).on("fileuploaded", function(event, data, previewId, index) {
    	uploadedFile++;
    	if(uploadedFile == data.filescount){
    		var data = {status:'ok'};
    		dealResult(data);
    	}
    });
	
	$("#div_verifyStatus").showList('radio',{infoList:'${scf_user_loan_verify_status}',name:'verifyStatus',column_name:'dicDataName',column_value:'dicDataValue'})
	
	function getJsonData(){
		var jsonData = {};
		$("#myForm").find("input").each(function() {
			jsonData[$(this).attr('name')] = $(this).val();
		});
		
		$("#myForm").find("select").each(function() {
			jsonData[$(this).attr('name')] = $(this).val();
		});
		$("#myForm").find("textarea").each(function() {
			jsonData[$(this).attr('name')] = $(this).val();
		});
		return jsonData;
	}
	function save(){
		idx = layer.load();
		var url = '<%=request.getContextPath()%>/admin/userloan/saveOrgVerify';
		$.ajax({
		      url: url,
		      dataType: 'json',
		      type: 'POST',
		      async:false,
		      data:$("form").serialize(),
		      success: function (data) {
			    	if(hasFile && data.status == 'ok'){
			    		$("#dataFile").fileinput('upload');
			  		}else{
			    	  dealResult(data);
			  		}
		      },
		      error: function(){
		    	  layer.alert('系统错误', {
						icon : 5
					});
		      }
		  });
	}
	function redirect(target){
		$(top.window.parent.document).find(".active").attr('class','');
		var t = $(top.window.parent.document).find(target);
		t.attr('class','active');
		window.parent.location = t.attr('href')
	}
	function dealResult(data){
		layer.close(idx);
		if(data.status == 'ok'){
   		 layer.alert('审核数据保存成功', {
                   icon: 1,
                   offset:50
             },function(index){
            	 var val = $("input[name='verifyStatus']:checked").val();
	           	  if('1' == val){
	               	  redirect("#menu257");
	           	  }else{
	           		  redirect("#menu259");
	           	  }
             });
	   	}else{
	   		layer.alert(data.msg, {
				icon : 5
			});
	   	}
	}
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
	</script>
</body>
</html>