


$(document).ready(function(){
    //左侧导航栏鼠标左右拉动
   /* var temp  = '<div class="showHideBar"></div>';
     if($('.sidebar')[0]){
         $('.sidebar').resizable({ handles: 'e',minWidth:10,maxWidth :235,resize: function(event, ui) { resizableCallBack(event,ui); } });
         $('html,body').on("mouseenter",'iframe',function(){
             $('.ui-resizable-handle').trigger('mouseup');
         });

     }

    var resizableCallBack = function(event,ui){
        var containerW = ui.size.width;
        var orginW = 235;
        var wLen = 250-(orginW - containerW);
        $("#page-wrapper").css('marginLeft',wLen+'px');

    }*/
    //左侧导航栏鼠标点击展开收起

    if($('.sidebar')[0]){
        var temp  = '<div class="showHideBar hideBar"><span></span></div>';
        $($('.sidebar')).append(temp);
       $('.sidebar').on('click','.showHideBar',function (){
           var orginW = 235;
           var minW = 20;
           var wLenOrigin = 250;
           var wLen = 250-(orginW - minW);
           var self = $(this);
           if(self.hasClass('hideBar')) {
               self.removeClass('hideBar').addClass('showBar');
               $('.sidebar').width(minW);
               $("#page-wrapper").css('marginLeft',wLen+'px');
           }
           else if(self.hasClass('showBar')) {
               self.removeClass('showBar').addClass('hideBar');
               $('.sidebar').width(orginW);
               $("#page-wrapper").css('marginLeft',wLenOrigin+'px');
           }

       });

    };
});