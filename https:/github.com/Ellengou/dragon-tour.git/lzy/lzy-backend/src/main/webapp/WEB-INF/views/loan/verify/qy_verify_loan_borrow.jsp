<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
									<%@ include file="/WEB-INF/views/loan/template/borrowerTemplate.jsp"%>
									<%@ include file="/WEB-INF/views/loan/template/productTemplate.jsp"%>
									
									<ul id="myTab" class="nav nav-tabs">
										<li class="active"><a href="#verifySituation">审核情况</a></li>
										<li><a href="#dataProve">资料证明</a></li>
										<li><a href="#productSituation">产品详情</a></li>
										<li><a href="#deals">合同</a></li>
									</ul>
									<div id="myTabContent" class="tab-content">
										<div class="tab-pane fade in active" id="verifySituation">
										<%@ include file="/WEB-INF/views/loan/template/verifyTemplate.jsp"%>
   										</div>
									   <div class="tab-pane fade" id="dataProve">
									   		<div class="panel panel-default">
											  <div class="panel-heading">
											    <h3 class="panel-title">基本资料</h3>
											  </div>
											  <div class="panel-body" id = "qyverify">
										   		<input id="dataFile" type="file" class="file" multiple disabled="disabled">
											  </div>
											</div>
									   </div>
									   <div class="tab-pane fade" id="productSituation">
									      <p>${scfLoan.introductions }</p>
									   </div>
									   <div class="tab-pane fade" id="deals">
									   </div>
									</div>
								</form>
								
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
									<shiro:hasPermission name="loan:qy:verify">
										<button type="button" class="btn btn-primary" onclick="verify('${scfLoan.id}');">审核</button>
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
	<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- layer JavaScript -->
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/layer/layer.js" type="text/javascript"></script>
	<%@ include file="/WEB-INF/views/template/bootstrap-fileinput-master.jsp"%>
	
	<script>
	var loanId = '${scfLoan.id}';
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
        initialPreview:getInitialPreview('${list}'),
        initialPreviewConfig:getInitialPreviewConfig('${list}'),
        initialPreviewFileType:'image',
        showRemove:false,
        showUpload:false,
        showCancel:false,
        showClose:false,
        showBrowse:false,
        initialPreviewShowDelete:false,
        allowedFileExtensions : ['jpg', 'png','gif']
    })
	
	function verify(id){
		layer.open({
    	    type: 2,
    	    area: ['600px', '400px'],
    	    offset: [100,(($(window).width()-600)/2)],
    	    title: '输入审核内容',
    	    content: '<%=request.getContextPath()%>/admin/project/loan/qyVerifyPage?id=' + id
    	});
    }
	
	$(document).ready(function(){
		//单独激活每个标签
		$('#myTab a').click(function (e) {
			  e.preventDefault()
			  var $this = $(this);
			  if($this.attr('href') == "#verifySituation"){
				  
			  }else if($this.attr('href') == "#investSituation"){
				  //var url = "<%=request.getContextPath()%>/admin/project/loan/invest/investSituation?id="+loanId;
				  //$.get(url, function(result){
					//    $("#investSituation").html(result);
					//  });
			  }else if($this.attr('href') == "#repaySituation"){
				  
			  }else if($this.attr('href')  == "#dataProve"){
			  }else if($this.attr('href') == "#productSituation"){
				  
			  }else if($this.attr('href') == "#deals"){
				  var url = "<%=request.getContextPath()%>/admin/project/loan/getLoanDeal?loanId="+loanId;
				  $.get(url, function(result){
					    $("#deals").html(result);
					  });
			  }
			  $this.tab('show')
			})
	});
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage() {
			parent.layer.close(index);
		}
	</script>
</body>
</html>