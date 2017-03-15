<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
									<div  class="form-group">
										<label class="col-xs-2 control-label">状态</label>
										<div class="input-group col-xs-9" id = "div_verifyStatus">
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-2 control-label">备注</label>
										<div class="input-group col-xs-9">
											<textarea class="form-control" rows="3" id = "reason" name="reason">${reason }</textarea>
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-2 control-label">附件</label>
										<div class="input-group col-xs-9" id = "files">
											<input type="file"  id="file0" name="file0" accept="image/gif,image/jpeg,image/png" onchange="addFile(this)">
										</div>
									</div>
								</form>
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
										<button type="button" class="btn btn-success">已审核</button>
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
	<!-- layer JavaScript -->
	<script
		src="<%=request.getContextPath()%>/bootstrap/plugin/ajaxfileupload/ajaxfileupload.js"
		type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/util.js" type="text/javascript"></script>
	<script>
	function addFile(el){
		if(el.value != null){
			var files = $("#files [type='file']");
			if(files.length < 10){
				var hasEpt = false;
				for(var i = 0;i<files.length;i++){
					var obj = files[i];
					if(obj.value == null || obj.value == ''){
						hasEpt = true;
						break;
					}
				}
				if(!hasEpt){
					var name = "file"+Math.round(Math.random()*1000);
					var addfile = '<input type="file" id="file'+name+'" name="file'+name+'" accept="image/gif,image/jpeg,image/png" onchange="addFile(this)">';
					$("#files").append(addfile);
				}
			}
		}
	}
	function ajaxFileUpload(id,data)  
	 {  
	
	     $.ajaxFileUpload({  
	             url:'<%=request.getContextPath()%>/admin/project/loan/uploadfile?type=mb&loanId=${id }',  
	             //secureuri:false,  
	             fileElementId:id,
	             dataType: 'json'  
	         }  
	     )  
	     return false;  
	 }
	$("#div_verifyStatus").showList('radio',{infoList:'${scf_loan_verify_status}',column_name:'dicDataName',column_value:'dicDataValue',selectValue:'${status}'})
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