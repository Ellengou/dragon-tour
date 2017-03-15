<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="<%=request.getContextPath()%>/bootstrap/plugin/ajaxfileupload/ajaxfileupload.js" type="text/javascript"></script>
<div class="panel panel-default">
	<div class="panel-body" id="pics">
		<div class="container" id="pic_container">
		</div>
	</div>
</div>
<div class="panel panel-default">
	<div class="panel-body" id="pics">
		<form id="myForm" class="form-horizontal" role="form"
			enctype="multipart/form-data">
			<div class="form-group" id="files">
				<div class="input-group col-xs-12">
					<input type="file" id="file0" name="file0" class="form-control"
						accept="image/gif,image/jpeg,image/png" onchange="addFile(this)">
					<span class="input-group-addon"><span
						class="glyphicon glyphicon-remove" onclick="removefile(this)"
						style="cursor: pointer"></span></span>
				</div>
			</div>
			<div class="input-group col-xs-2">
				<button type="button" class="btn btn-primary" onclick="ajaxFileUpload()">上传</button>
			</div>
		</form>
	</div>
</div>

<script>
	var jsonData = eval('${jsonData}');
	var template = "";
	for (var i = 0; i < jsonData.length; i++) {
		var obj = jsonData[i];
		template += '<div class="row" id="row_'+obj.id+'">';
		template += '<div class="col-xs-11">';
		template += '<img onclick="showPic('+obj.id+')" src="<%=request.getContextPath()%>/admin/project/loan/getPic?id='+obj.id+'" class="img-responsive">';
		template += '</div>';
		template += '<div class="col-xs-1">';
		template += '<button type="button" class="btn btn-primary" onclick="deletePic('+obj.id+')">删除</button>';
		template += '</div>';
		template += '</div><hr>';
	}
	$("#pic_container").append(template);
	//大图展示单张图片
	function showPic(id){
		var url = '<%=request.getContextPath()%>/admin/project/loan/getPic?id='+id;
		layer.photos({
		    photos: {"data": [{"src": url}]}
		  });
	}
	function deletePic(id){
		layer.confirm('确定删除?', {icon: 3, title:'提示'}, function(index){
			$.ajax({
				url:'<%=request.getContextPath()%>/admin/project/loan/deletePic?loanId='+'${loanId}'+'&id='+id,
				type:'GET',
				dataType: 'json',
				success:function(data){
					if(data.status == 'ok'){
						$("#row_"+id).remove();
					}else{
						layer.alert(data.msg);
					}
				}
			})
			layer.close(index);
		});
		
	}
	function removefile(e){
		$div = $(e).parent().parent();
		if($div.children("[type='file']").val() != ''){
			$div.remove();
		}
	}
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
					var addfile = '<div class="input-group  col-xs-12"><input type="file"  class="form-control" id="file'+name+'" name="file'+name+'" accept="image/gif,image/jpeg,image/png" onchange="addFile(this)"><span class="input-group-addon"><span class="glyphicon glyphicon-remove" onclick="removefile(this)" style="cursor:pointer"></span></span></div>';
					$("#files").append(addfile);
				}
			}
		}
	}
	function ajaxFileUpload()  
	 {  
		 var iptfile  = $("#files [type='file']");
		  var ids = [];
		  for(var i=0;i<iptfile.length;i++){
			  if(iptfile[i].value){
				 ids.push(iptfile[i].id) 
			  }
		  }
		  if(ids.length>0){
			var loanid = '${loanId}';
		     $.ajaxFileUpload({  
		             url:'<%=request.getContextPath()%>/admin/project/loan/uploadfile?type=base&loanId='+loanid,  
		             //secureuri:false,  
		             fileElementId:ids,
		             dataType: 'json',
		            success:function(data,status){
		            	if(data.status == 'ok'){
		            		showProve();
		            		showMsg('保存成功',1);
		            	}else{
		            		showMsg(data.msg,5);
		            	}
		            },
		            error: function (data, status, e){
		            	showMsg('文件上传失败',5)
		            }
		         }
		     )  
	     }
	     return false;  
	 }  
</script>