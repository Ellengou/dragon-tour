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
								<%@ include file="/WEB-INF/views/userloan/template/userLoanTemplate_3.jsp"%>
								<div id = "subPage">
									</div>
									<ul id="myTab" class="nav nav-tabs">
										<li class="active"><a href="#verifySituation">审核情况</a></li>
										<li><a href="#dataProve">资料证明</a></li>
									</ul>
									<div id="myTabContent" class="tab-content">
										<div class="tab-pane fade in active" id="verifySituation">
											<%@ include file="/WEB-INF/views/userloan/template/verifyTemplate.jsp"%>
   										</div>
									   <div class="tab-pane fade" id="dataProve">
									   </div>
									</div>
								</form>
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
	<!-- layer JavaScript -->
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/layer/layer.js" type="text/javascript"></script>
	<%@ include file="/WEB-INF/views/template/bootstrap-fileinput-master.jsp"%>
	<script>
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
	
	var baseUrl = '${baseUrl}';
	
	var qyList = '${qyList}';
	if('' != qyList){
		var temp = '';
		temp += '<div class="panel panel-default">';
		temp +=  '<div class="panel-heading">';
		temp +=    '<h3 class="panel-title">企业审核上传资料</h3>';
		temp +=  '</div>';
		temp +=  '<div class="panel-body">';
		temp +=  '<input id="dataFile_qy" type="file" disabled="disabled" class="file" multiple>';
		temp +=  '</div>';
		temp += '</div>';
		$("#dataProve").append(temp);
		
		$('#dataFile_qy').fileinput({
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
	}
	var orgList = '${orgList}';
	if(''!=orgList){
		var temp = '';
		temp += '<div class="panel panel-default">'
		temp +=  '<div class="panel-heading">'
		temp +=    '<h3 class="panel-title">第三方机构上传资料</h3>'
		temp +=  '</div>'
		temp +=  '<div class="panel-body">'
		temp +=  '<input id="dataFile_org" type="file" disabled="disabled" class="file" multiple>';
		temp +=  '</div>'
		temp += '</div>'
		$("#dataProve").append(temp);
		
		$('#dataFile_org').fileinput({
	        language: 'zh',
	        initialPreview:getInitialPreview('${orgList}'),
	        initialPreviewConfig:getInitialPreviewConfig('${orgList}'),
	        initialPreviewFileType:'image',
	        showRemove:false,
	        showUpload:false,
	        showCancel:false,
	        showClose:false,
	        showBrowse:false,
	        initialPreviewShowDelete:false,
	        allowedFileExtensions : ['jpg', 'png','gif']
	    })
	}
	//请求子页面
	$.ajax({
		url : '<%=request.getContextPath()%>/admin/userloan/viewSub?userLoanId=${loan.id}',
		type : 'get',
		dataType : 'html',
		success : function(data){
			$("#subPage").html(data);
		}
	})
	$(document).ready(function(){
	//单独激活每个标签
		$('#myTab a').click(function (e) {
		  e.preventDefault()
		  var $this = $(this);
		  if($this.attr('href') == "#verifySituation"){
		  }else if($this.attr('href') == "#dataProve"){
		  }else if($this.attr('href') == "#loanRecord"){
		  }
		  $this.tab('show')
		});
	
	});
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
	</script>
</body>
</html>