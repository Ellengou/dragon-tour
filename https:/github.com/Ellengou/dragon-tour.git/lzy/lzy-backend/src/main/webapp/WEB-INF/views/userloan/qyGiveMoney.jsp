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
								<form id="myForm">
									<%@ include file="/WEB-INF/views/userloan/template/userLoanTemplate_0.jsp"%>
									<%@ include file="/WEB-INF/views/userloan/template/userSuppInfoTemplate.jsp"%>
									
									<ul id="myTab" class="nav nav-tabs">
										<li class="active"><a href="#verifySituation">审核情况</a></li>
										<li><a href="#dataProve">资料证明</a></li>
									</ul>
									<div id="myTabContent" class="tab-content">
										<div class="tab-pane fade in active" id="verifySituation">
											<%@ include file="/WEB-INF/views/userloan/template/verifyTemplate.jsp"%>
   										</div>
									   <div class="tab-pane fade" id="dataProve">
									   		<div class="panel panel-default">
											  <div class="panel-heading">
											    <h3 class="panel-title">企业审核上传资料</h3>
											  </div>
											  <div class="panel-body" id = "qyverify">
											  	<input id="dataFile" type="file" disabled="disabled" class="file" multiple>
											  </div>
											</div>
									   </div>
									   <div class="tab-pane fade" id="loanRecord">
									   </div>
									   <div class="tab-pane fade" id="repayment">
									   </div>
									   <div class="tab-pane fade" id="investment">
									   </div>
									</div>
								</form>
								<div class="row" align="center">
									<div class="col-xs-12">
										<button type="button" class="btn btn-primary" onclick="GiveMoney();">放款</button>
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
	<!-- layer JavaScript -->
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/layer/layer.js" type="text/javascript"></script>
	<%@ include file="/WEB-INF/views/template/bootstrap-fileinput-master.jsp"%>
	<script>
	var baseUrl = '${baseUrl}';
	function showPic(target){
		var $this = $(target);
		var src = $this.attr('src');
		var name = $this.attr('alt');
		layer.photos({
			photos:{
				  "title": name, //相册标题
				  "data": [   //相册包含的图片，数组格式
				    {
				      "alt": name,
				      "src": src, //原图地址
				    }
				  ]
				}
		})
	}
    function getInitialPreview(list){
		var tmp = [];
		list = $.parseJSON(list);
		for(var i=0;i<list.length;i++){
			var obj = list[i];
			tmp.push('<img onclick="showPic(this)" alt="'+obj['name']+'" title="'+obj['name']+'" src="'+baseUrl+obj['web_url']+'" class="file-preview-image" style="width: 120px;height: 80px;">')
		}
		return tmp;
	}
    function getInitialPreviewConfig(list){
    	var tmp = [];
    	list = $.parseJSON(list);
    	for(var i=0;i<list.length;i++){
			var obj = list[i];
			var initObj = {
		        caption: obj['name'], 
		        filetype:'image',
		        width:'100%'
			};
			tmp.push(initObj);
		}
    	return tmp;
    }
	$('#dataFile').fileinput({
        language: 'zh',
        initialPreview:getInitialPreview('${qyList}'),
        initialPreviewConfig:getInitialPreviewConfig('${qyList}'),
        initialPreviewFileType:'image',
        showRemove:false,
        showUpload:false,
        showCancel:false,
        showClose:false,
        showBrowse:false,
        initialPreviewShowDelete:false,
        allowedFileExtensions : ['jpg', 'png','gif']
    })
	$(document).ready(function(){
	//单独激活每个标签
		$('#myTab a').click(function (e) {
		  e.preventDefault()
		  var $this = $(this);
		  if($this.attr('href') == "#verifySituation"){
		  }else if($this.attr('href') == "#dataProve"){
		  }else if($this.attr('href') == "#loanRecord"){
		  }else if($this.attr('href')  == "#repayment"){
		  }else if($this.attr('href') == "#investment"){
		  }
		  $this.tab('show')
		});
	
	});
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
	
	function GiveMoney(){
		layer.open({
    	    type: 2,
    	    area: ['600px', '450px'],
    	    offset: [100,(($(window).width()-600)/2)],
    	    title: '放款',
    	    content: '<%=request.getContextPath()%>/admin/userloan/qyGiveMoneyPage?id=' + '${loan.id}'
    	});
    }
	</script>
</body>
</html>