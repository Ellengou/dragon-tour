<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
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
								<div class="panel panel-primary" id = "div_qy">
								   <div class="panel-heading">
								      <h3 class="panel-title">企业审核信息</h3>
								   </div>
								   <div class="panel-body">
								   <form>
									<div  class="form-group">
										<label class="col-xs-2 control-label">状态</label>
										<div class="input-group col-xs-9">
										<span>${scfLoan.userStatus }</span>
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-2 control-label">备注</label>
										<div class="input-group col-xs-9">
											<textarea class="form-control" rows="3" id = "reasonUser" name="reasonUser" disabled="disabled">${scfLoan.reasonUser }</textarea>
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-2 control-label">附件</label>
										<div class="input-group col-xs-9" id="div_qy_img">
										</div>
									</div>
									</form>
								   </div>
								</div>
								<div class="panel panel-primary" id = "div_pt">
								   <div class="panel-heading">
								      <h3 class="panel-title">平台审核信息</h3>
								   </div>
								   <div class="panel-body">
									   <div  class="form-group">
											<label class="col-xs-2 control-label">状态</label>
											<div class="input-group col-xs-9">
											<span>${scfLoan.sysStatus }</span>
											</div>
										</div>
										<div  class="form-group">
											<label class="col-xs-2 control-label">备注</label>
											<div class="input-group col-xs-9">
												<textarea class="form-control" rows="3" id = "reasonSys" name="reasonSys" disabled="disabled">${scfLoan.reasonSys }</textarea>
											</div>
										</div>
										<div  class="form-group">
											<label class="col-xs-2 control-label">附件</label>
											<div class="input-group col-xs-9" id="div_pt_img">
											</div>
										</div>
								   </div>
								</div>
								<div class="panel panel-primary" id = "div_mb">
									<div class="panel-heading">
										<h3 class="panel-title">满标审核信息</h3>
									</div>
									<div class="panel-body">
										<div class="form-group">
											<label class="col-xs-2 control-label">状态</label>
											<div class="input-group col-xs-9">
												<span>${scfLoan.userStatus1 }</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-xs-2 control-label">备注</label>
											<div class="input-group col-xs-9">
												<textarea class="form-control" rows="3" id="reasonUser1"
													name="reasonUser1" disabled="disabled">${scfLoan.reasonUser1 }</textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-xs-2 control-label">附件</label>
											<div class="input-group col-xs-9" id="div_mb_img">
											</div>
										</div>
									</div>
								</div>
								<div class="row" align="center">
									<div class="col-xs-12">
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
	
	<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script>
	var loanId = '${scfLoan.id}';
	$(document).ready(function(){
		var loanPics = '${loanPics}';
		var baseUrl = '${baseUrl}';
		if('[]' != loanPics){
			loanPics = $.parseJSON(loanPics);
			for(var i = 0;i<loanPics.length;i++){
				var obj = loanPics[i];
				var type = obj['type'];
				var web_url = obj['web_url'];
				var tp = '<img src="'+baseUrl+web_url+'" class="img-responsive">';
				if(type == 'loan_qysh'){
					$("#div_qy_img").append(tp);
				}else if(type == 'loan_ptsh'){
					$("#div_pt_img").append(tp);
				}else if(type ==  'loan_mbsh'){
					$("#div_mb_img").append(tp);
				}
			}
		}
		var verifyFrontId = '${scfLoan.verifyFrontId}';
		if('' == verifyFrontId){
			$("#div_qy").hide();
		}
		var verifyAdminId  = '${scfLoan.verifyAdminId}';
		if('' == verifyAdminId){
			$("#div_pt").hide();
		}
		var verifyMoneyId = '${scfLoan.verifyMoneyId}';
		if('' == verifyMoneyId){
			$("#div_mb").hide();
		}
	});
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
	</script>
</body>
</html>