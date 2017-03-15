/**
 * 初始化列表参数
 */
$(function(){
	
	//初始化下拉框
	$("#pageSize").empty();
	var data = $('#myTable').attr('data-pageSize').split(',');
	for(var i=0;i<data.length;i++) {
		var option = $("<option>").text(data[i]).val(data[i])
		$("#pageSize").append(option);
	}

	//定义查询选择框
	$.jqPaginator('#pagination', {
		totalPages: 1,
		currentPage: 1,
		first:'首页',
		first: '<li class="first"><a href="javascript:void(0);">首页<\/a><\/li>',
		prev: '<li class="prev"><a href="javascript:void(0);">上一页<\/a><\/li>',
		next: '<li class="next"><a href="javascript:void(0);">下一页<\/a><\/li>',
		last: '<li class="last"><a href="javascript:void(0);">末页<\/a><\/li>',
		page: '<li class="page"><a href="javascript:void(0);">{{page}}<\/a><\/li>',
		onPageChange: function (num, type) {
			search(num);
		}
	});

})

/**
 * 查询 刷新当前页数pageNum
 */
function search(pageNum){
	//加载层
	layer.load(2);
	//获取form表单传入参数
	var jsonData ={};
	jsonData.begin = (pageNum-1) * $('#pageSize').val();
	jsonData.rows = $('#pageSize').val();
	$("#myForm").find("input").each(function(){
		jsonData[$(this).attr('id')] = $(this).val();
	});
	$("#myForm").find("select").each(function(){
		jsonData[$(this).attr('id')] = $(this).val();
	});

	$.ajax({
		url: $('#myTable').attr('data-url'),
		dataType: 'json',
		type: $('#myTable').attr('data-method'),
		data: jsonData,
		success: function (data) {
			//关闭加载层
			layer.closeAll('loading');
			$('#pageCount').html('当前总记录数:' + data.total);//显示记录数
			if(data.total > 0){
				//计算页数
				if(data.total%$('#pageSize').val() > 0){
					var pageCount = (data.total - data.total%$('#pageSize').val())/$('#pageSize').val() + 1;
				}else{
					var pageCount = data.total/$('#pageSize').val();
				}

				$('#pagination').jqPaginator('option', {
					currentPage: pageNum, //当前页数
					totalPages: pageCount //总页数
				});

				//拼接显示数据
				var str = '';
				for (var i = 0; i < data.rows.length; i++) {
					str = str + '<tr>';
					$("#myTable").find("th").each(function(){
						if($(this).attr('data-type') == 'checkbox'){
							$(this).html("<input type=\"checkbox\" id=\"selectAll\" onclick=\"selectAll();\">");
							str = str + '<td><input type=\'checkbox\' onclick=\'selectValue();\' selectValue=\'' + JSON.stringify(data.rows[i]) + '\' id=\'' + $(this).attr('data-field') + data.rows[i][$(this).attr('data-field')] + '\' value=\'' + data.rows[i][$(this).attr('data-field')] + '\'></td>'
						}else{
							if($(this).attr('data-call') == 'true'){
								str = str + '<td>' + tableCallBack(data.rows[i],$(this).attr('data-field')) + '</td>';
							}else{
								if(data.rows[i][$(this).attr('data-field')] == null){
									str = str + '<td></td>';
								}else{
									str = str + '<td>' + data.rows[i][$(this).attr('data-field')] + '</td>';
								}
							}
						}
					});
					str = str + '</tr>';
				}
				$("#tbodyId").html(str);
				
			}else{
				$('#pageCount').html('当前总记录数:0');//显示记录数
				$("#tbodyId").html('<tr align="center"><td colspan="' + $("#myTable").find("th").length + '">未查询到匹配的数据</td><tr>');
			}

            //设置统计结果
            if(typeof data.curPage != 'undefined'){
                var cur = data.curPage;
                for(var o in cur){
                    $("#"+o+"_cur").text(cur[o]);
                }
            }
            //设置统计结果
            if(typeof data.allPage != 'undefined'){
                var cur = data.allPage;
                for(var o in cur){
                    $("#"+o+"_all").text(cur[o]);
                }
            }
		},
		error: function(){
			//关闭加载层
			layer.closeAll('loading');
			$('#pageCount').html('当前总记录数:0');//显示记录数
			$("#tbodyId").html('<tr align="center"><td colspan="' + $("#myTable").find("th").length + '">未查询到匹配的数据</td><tr>');
		}
	});
}

/**
 * 默认回调函数
 * @param data
 * @param id
 * @returns
 */
function tableCallBack(data,id){
	if(data[id] == null || data[id] == ''){
		return '';
	}else{
		return data[id];
	}
}

/**
 * 多选方法
 */
function selectAll(){
	if($('#selectAll').is(':checked')){
		$("#tbodyId").find("input").each(function() {
    		if($(this).attr('type') == 'checkbox'){
    			$(this).prop('checked',true);
    		}
		});
	}else{
		$("#tbodyId").find("input").each(function() {
    		if($(this).attr('type') == 'checkbox'){
    			$(this).prop('checked',false);
    		}
		});
	}
	//除法此类方法
	selectValue();
}


function selectValue(){
	
}

