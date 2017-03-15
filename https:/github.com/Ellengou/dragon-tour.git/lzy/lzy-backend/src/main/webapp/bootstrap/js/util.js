/**
 * @author huting
 * @params $("#div_sex").showList('radio',{infoList:${sexList},name:"sex",selectValue:"${userinfo.sex}"});
 *         "#div_sex" 需要添加html片段的父元素 radio处可选
 *         radio,checkbox,radioInTable,checkboxInTable ${sexList}
 *         需要列出的信息,是json对象[{name:'',value:''},{name:'',value:''}] "sex"
 *         生成input的name属性 ${userinfo.sex} 默认选中的值
 */
;
(function($) {
	function getTemplate($this, type) {
		return $this.each(function() {
			var infoList = $.parseJSON(opts.infoList);
			var template = "";
			for (var i = 0; i < infoList.length; i++) {
				var obj = infoList[i];
				var checked = isChecked(opts.selectValue, obj[opts.column_value]);
				template += '<label class="'
					+ opts.lableClass + '">';
				template += obj[opts.column_name];
				if(opts.blank != null){
					template += opts.blank;
				}
				template += '  <input type="' + type + '" name="' + opts.name
				+ '" value="' + obj[opts.column_value]+'"';
				if(null != opts.inputClass){
					template += ' class="'+opts.inputClass+'"';
				}
				if (checked) {
					template += ' checked="checked"';
				}
				if(opts.disabledAll){
					template += ' disabled="disabled" ';
				}
				template += '></label>';
			}
			$this.append(template);
			if(null == opts.selectValue && opts.selectFirst){
				$this.find("input:eq(0)").attr('checked',true);
			}
		});
	}
	function isChecked(selectValue, currValue) {
		var checked = false;
		if(null != selectValue){
			if(selectValue.length > 2){
				if(selectValue.charAt(0) == '[' && selectValue.charAt(selectValue.length - 1) == ']'){
					selectValue = eval('('+selectValue+')');
				}
			}
			if (typeof (selectValue) === "string") {
				if (currValue == selectValue)
					checked = true;
			} else if (typeof (selectValue) === "object") {
				for (var j = 0; j < selectValue.length; j++) {
					if (currValue == selectValue[j])
						checked = true;
				}
			}
		}
		return checked;
	}
	function getTemplateForTable($this, type) {

		return $this.each(function() {
			var br = opts.br;
			var infoList = $.parseJSON(opts.infoList);
			var template = '';
			var part = '';
			var count = 0;// 用于
			for (var i = 0; i < infoList.length; i++) {
				var obj = infoList[i];
				var checked = isChecked(opts.selectValue, obj[opts.column_value]);
				part += "<td>";
				part += '<input type="' + type + '" name="' + opts.name
				+ '" value="' + obj[opts.column_value]+'"';
				if(null != opts.inputClass){
					part += ' class="'+opts.inputClass+'"';
				}
				if (checked) {
					if(opts.defaultcheckedDisable){
						part += ' disabled="disabled"';
					}
					part += ' checked="checked"';
				}
				part += '><label class="'
					+ opts.lableClass + '">' + obj[opts.column_name] + '</label>';
				part += "</td>";
				if (i % (br - 1) == 0 && i != 0) {
					template += '<tr>' + part + '</tr>';
					part = '';
					br = 2 * br;
				}
			}
			if (part.length > 0) {
				template += '<tr>' + part + '</tr>';
			}
			$this.append(template);
		});

	}
	function getOptionTemplate(){
		
	}
	var methods = {
		radio : function() {
			return getTemplate(this, 'radio');
		},
		checkbox : function(opts) {
			return getTemplate(this, 'checkbox');
		},
		radioInTable : function() {
			return getTemplateForTable(this, 'radio');
		},
		checkboxInTable : function() {
			return getTemplateForTable(this, 'checkbox');
		},
		option :function(){
			var template = "";
			var infoList;
			if(typeof opts.infoList !== 'object'){
				infoList = $.parseJSON(opts.infoList);
			}else{
				infoList = opts.infoList;
			}
			if(opts.emptySelect){
				template += '<option value = "">请选择</option>'
			}
			for(var i=0;i<infoList.length;i++){
				var obj = infoList[i];
				template += '<option value="'+obj[opts.column_value]+'"';
				if(null != opts.selectValue && opts.selectValue == obj[opts.column_value]){
					template += ' selected="selected"';
				}
				template += '>'+obj[opts.column_name]+'</option>'
			}
			this.append(template);
		}
	}
	
	var opts = null;
	$.fn.showList = function(options) {
		var defaults = {
			infoList : null,// 要展示的信息
			name : null,// input的name属性
			selectValue : null,// 默认选中的值,支持string类型与object
			lableClass : 'checkbox-inline',// input里面label的class属性
			inputClass:null,//input框的css
			br : 3,// 默认换行的数量
			column_name:'name',
			column_value:'value',
			defaultcheckedDisable : false,
			emptySelect:true,
			selectFirst:true,
			blank : null,
			disabledAll : false
		};
		var method = arguments[0];
		if (methods[method]) {
			opts = $.extend(defaults, arguments[1]);
			return methods[method].call(this);
		} else {
			$.error('插件中没有该方法:' + method);
			return this;
		}
	}
})(jQuery);
/**
 * disable有值的框
 * @param $
 */
(function($) {
	$.fn.disableInput = function() {
		return this.each(function(){
			$this = $(this);
			var val = $this.val();
			if(null != val && val.length > 0){
				$this.attr("readonly","readonly");
			}
		})
	}
})(jQuery);


(function($) {
	var opts = null;
	var methods = {
		li:function(){
			var template = "";
			var infoList = $.parseJSON(opts.infoList);
			for(var i=0;i<infoList.length;i++){
				var obj = infoList[i];
				template += '<li ';
				if(null != opts.column_style){
					template += 'style="'+opts.column_style+'"';
				}
				template +=' data-value="'+obj[opts.column_value]+'"';
				template += '>'+obj[opts.column_name]+'</li>'
			}
			this.append(template);
		}
	}
	$.fn.showList_ul = function(options) {
		var defaults = {
				infoList : null,// 要展示的信息
				//column_class : 'selected',// 每一列的class属性
				column_style:null,
				column_name:'name',
				column_value:'value'
		};
		var method = arguments[0];
		if (methods[method]) {
			opts = $.extend(defaults, arguments[1]);
			return methods[method].call(this);
		} else {
			$.error('插件中没有该方法:' + method);
			return this;
		}
	}
})(jQuery);
