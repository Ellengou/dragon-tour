//公共请求处理的方法
/**
 * 有界面的方法：比如新增、编辑
 * @param object
 */
function commons(object){
	//询问框
	layer.confirm('是否确定此操作？', {
	  btn: ['确定','取消'] //按钮
	}, function(){
		$.ajax({
		      url: object.url,
		      dataType: object.dataType || "json",
		      type: object.type || 'post',
		      data:object.data ,
		      success: function (data) {
		    	if(data.status == 'ok'){
		    		parent.layer.alert(data.msg, {icon : 6});
		    	
		    	}else{
		    		parent.layer.alert(data.msg, {icon : 5});
		    	}
		    	parent.search(parseInt(parent.$('.active').attr('jp-data')));
	    		parent.layer.close(parent.layer.getFrameIndex(window.name));
		      },
		      error: function(){
		    	  layer.alert('系统错误', {icon : 5});
		    	  parent.search(parseInt(parent.$('.active').attr('jp-data')));
		    		parent.layer.close(parent.layer.getFrameIndex(window.name));
		      }
		  });
	}, function(){
		
	});
}
/**
 * 列表的方法
 * @param object
 */
function commonsRequest(object){
	//询问框
	layer.confirm('是否确定此操作？', {
	  btn: ['确定','取消'] //按钮
	}, function(){
		$.ajax({
		      url: object.url,
		      dataType: object.dataType || "json",
		      type: object.type || 'post',
		      data:object.data ,
		      success: function (data) {
		    	if(data.status == 'ok'){
		    		layer.alert(data.msg, {icon : 6});
		    		
		    	}else{
		    		layer.alert(data.msg, {icon : 5});
		    	}
		    	search(parseInt($('.active').attr('jp-data')));
		      },
		      error: function(){
		    	  layer.alert('系统错误', {icon : 5});
		    	  search(parseInt($('.active').attr('jp-data')));
		      }
		  });
	}, function(){
		
	});
}