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
									<div  class="form-group">
										<label class="col-xs-2 control-label">状态</label>
										<div class="input-group col-xs-9" id = "div_verifyStatus">
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-2 control-label">备注</label>
										<div class="input-group col-xs-9">
											<textarea class="form-control" rows="3" id = "reasonUser" name="reasonUser"></textarea>
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-2 control-label">附件</label>
										<div class="input-group col-xs-9" id = "files">
											<input id="dataFile" type="file" class="file" multiple>
										</div>
									</div>
								</form>
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
									<shiro:hasPermission name="loan:qy:verify:save">
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
	<!-- layer JavaScript -->
	<%@ include file="/WEB-INF/views/template/bootstrap-fileinput-master.jsp"%>
	<script>
	var uploadedFile = 0;
	var hasFile = false;
	var idx;
	$('#dataFile').fileinput({
	    language: 'zh',
	    showUpload:false,
	    showPreview:false,
	    uploadUrl: '<%=request.getContextPath()%>/pics/loanQySh?id=${id}',
	    allowedFileExtensions : ['jpg', 'png','gif']
	}).on("filebatchselected", function(event, files) {
    	hasFile = true;
    }).on("filecleared", function(event, files) {
    	hasFile = false;
    }).on("fileuploaded", function(event, data, previewId, index) {
    	uploadedFile++;
    	if(uploadedFile == data.filescount){
    		var data = {status:'ok'};
    		dealResult(data);
    	}
    });
	function save(){
		layer.msg('数据开始保存....',{offset:50});
		var jsonData = $("form").serializeArray();
		$.ajax({
		      url: '<%=request.getContextPath()%>/admin/project/loan/saveUserVerify',
		      dataType: 'json',
		      type: 'POST',
		      data: jsonData,
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
	function dealResult(data){
		layer.close(idx);
		if(data.status == 'ok'){
   		 layer.alert('审核数据保存成功', {
                   icon: 1,
                   offset:50
             },function(index){
            	 var val = $("input[name='userStatus']:checked").val();
	           	  if('verify_pass' == val){
	               	  redirect("#menu124");
	           	  }else{
	           		  redirect("#menu146");
	           	  }
             });
	   	}else{
	   		layer.alert(data.msg, {
				icon : 5
			});
	   	}
	}
	function redirect(target){
		$(top.window.parent.document).find(".active").attr('class','');
		var t = $(top.window.parent.document).find(target);
		t.attr('class','active');
		window.parent.location = t.attr('href')
	}
	$(document).ready(function(){
		  var template = "";
		  //设置借款人对象
		  var verifyStatus = ${scf_loan_verify_status};
		  for(var i = 0;i<verifyStatus.length;i++){
			  var obj = verifyStatus[i];
			  if(i==0){
			  	template += "<label class=\"checkbox-inline\">"+obj.dicDataName+"<input  type=\"radio\" name=\"userStatus\" value=\""+obj.dicDataValue+"\" checked=\"checked\"></label>";
			  }else{
			  	template += "<label class=\"checkbox-inline\">"+obj.dicDataName+"<input  type=\"radio\" name=\"userStatus\" value=\""+obj.dicDataValue+"\"></label>";
			  }
		  }
		  $("#div_verifyStatus").append(template);
		  
		});
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
	</script>
</body>
</html>