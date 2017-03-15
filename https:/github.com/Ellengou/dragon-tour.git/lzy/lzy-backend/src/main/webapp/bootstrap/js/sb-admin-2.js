$(function () {
    var template = "";
    var count = 0;
    $.ajax({
        url: localStorage.adminUrlS + '/admin/headerMenu',
        dataType: 'JSON',
        type: 'get',
        success: function(data) {
            for(var i = 0; i < data.length; i++){
                if (count == 0) {
                    template += '<li><a onclick="leftMenu(' + data[i].id + ')">' + data[i].name + '</a></li>';
                    count ++;
                    //leftMenu(data[i].id);
                } else {
                    template += '<li><a onclick="leftMenu(' + data[i].id + ')">' + data[i].name + '</a></li>';                    
                }
            }            
            $("#header-nav").append(template);
            $("#header-nav li").click(function(){
            	$(this).addClass("active").siblings().removeClass("active");
                var selInd = $(this).index();
                if(selInd == 0){
                    $("#indexPage").hide();
                    $("#homeHtml").show();
                }
                else{
                    $("#indexPage").show();
                    $("#homeHtml").hide();
                }
            });
        }
    });
});
function leftMenu(pid) {
    //显示左侧列表元素
    var template = "";
    var count = 0;
    $.ajax({
        url:localStorage.adminUrlS + '/admin/menu?id=' + pid,
        dataType: 'JSON',
        type: 'get',
        success: function(data) {
            console.log(data);
            for(var i = 0; i < data.length; i++){
                if (data[i].children.length > 0) {
                    if (count == 0) {
                        template += '<li><a id="menu' + data[i].id + '" href="' + localStorage.adminUrlS + data[i].url + '" data-title="ok"><span class="leftBorder"></span>'
                            + data[i].name + '<span class="fa arrow"></span></a>' + arrLi(data[i].children) + '</li>';
                        count ++;

                    } else {
                        template += '<li><a id="menu' + data[i].id + '" href="' + localStorage.adminUrlS + data[i].url + '" data-title="ok"><span class="leftBorder"></span>'
                            + data[i].name + '<span class="fa arrow"></span></a>' + arrLi(data[i].children) + '</li>';
                    }
                } else {
                    template += '<li><a id="menu' + data[i].id + '" href="' + localStorage.adminUrlS + data[i].url + '"  target="iframe'+data[i].id+'" data-txt="'+ data[i].name +'"><span class="leftBorder"></span>'
                        + data[i].name + '<span class="fa arrow"></span></a></li>';
                }
            }
            $("#side-menu").html(template);
            $('#side-menu').metisMenu();


            rightTabFun.initLeftMenuClick();

            // $("#side-menu li").eq(0).find('a').trigger('click');

        }
    });
}


var arrLi = function(arr){
    var temp ='';
    var rank;
    for(var i=0; i <arr.length; i++){
        rank = arr[i].rank;
        if (arr[i].children.length > 0 ) {
            temp += '<li><a href="' + localStorage.adminUrlS + arr[i].url + '" data-title="ok" data-txt="'+ arr[i].name +'">' + arr[i].name
                + '<span class="fa arrow"></span></a>' + arrLi(arr[i].children) + '</li>';
        } else {
            temp += '<li><a href="' + localStorage.adminUrlS + arr[i].url + '" target="iframe'+arr[i].id+'" data-txt="'+ arr[i].name +'">' + arr[i].name + '</a></li>';
        }
    }
    var temUl = '<ul class="nav nav-second-level">' + temp + '</ul>';
    if (rank == 3) {
        temUl = '<ul class="nav nav-third-level">' + temp + '</ul>';
    }

    return temUl;
}

var rightTabFun = function () {
    var tabCont =  $("#page-wrapper .page-tab");
    var iframeCont =  $("#page-wrapper .page-cont");
    var showRightTab = function(iframeId,txt,iframeSrc){
        var isExitTab =tabCont.find('a[data-iframe='+iframeId+']');
        var isExitIframe = iframeCont.find('iframe[name='+iframeId+']');
        if(isExitIframe.length == 0){
            var tempIframe = '<iframe id="'+iframeId +'" name="'+iframeId +'" src="'+iframeSrc+'" class="show-iframe" scrolling="auto" frameborder="0" width="100%" height="100%"></iframe>';
            iframeCont.append(tempIframe);
            var youIFrame = iframeCont.find('iframe[name='+iframeId+']');
            youIFrame.load(function(){
                //alert(iframeId);
                var isExitTab =tabCont.find('a[data-iframe='+iframeId+']');
                if(isExitTab.length == 0){
                    var temp = '<a data-iframe="'+iframeId+'">'+txt+'<span class="closebtn"></span></a>';
                    tabCont.append(temp);
                }
                tabCont.find('a[data-iframe='+iframeId+']').addClass('active').siblings('a').removeClass('active');
                youIFrame.addClass('show-iframe').siblings('iframe').removeClass('show-iframe');
            });
        }
        else{
            tabCont.find('a[data-iframe='+iframeId+']').addClass('active').siblings('a').removeClass('active');
            iframeCont.find('iframe[name='+iframeId+']').addClass('show-iframe').siblings('iframe').removeClass('show-iframe');
        }


    }
    //点击iframe的tab切换
    var iframeTab = function(){
        $("#page-wrapper .page-tab").on('click','a',function(){
            var iframeId = $.trim($(this).data('iframe'));
            if(iframeId != ''){
                $(this).addClass('active').siblings('a').removeClass('active');
                iframeCont.find('iframe[name='+iframeId+']').addClass('show-iframe').siblings('iframe').removeClass('show-iframe');
            }
        });
    }
    //点击iframe的tab关闭
    var iframeTabClose = function(){
        $("#page-wrapper .page-tab").on('click','span.closebtn',function(event){
            var selfA = $(this).parent('a');
            var iframeId = $.trim(selfA.data('iframe'));
            var selfPrev = selfA.prev('a');
            var selfNext = selfA.next('a');
            if(selfPrev.length>0 ){
                if(selfA.hasClass('active')){
                    var iframeIdPrev = $.trim(selfPrev.data('iframe'));
                    selfPrev.addClass('active').siblings('a').removeClass('active');
                    iframeCont.find('iframe[name='+iframeIdPrev+']').addClass('show-iframe').siblings('iframe').removeClass('show-iframe');
                }
            }
            else if(selfPrev.length==0 && selfNext.length>0){
                if(selfA.hasClass('active')){
                    var iframeIdNext = $.trim(selfNext.data('iframe'));
                    selfNext.addClass('active').siblings('a').removeClass('active');
                    iframeCont.find('iframe[name='+iframeIdNext+']').addClass('show-iframe').siblings('iframe').removeClass('show-iframe');
                }
            }
            else if(selfPrev.length==0 && selfNext.length==0){
                $("#indexPage").find('iframe').remove();
                $("#header-nav li").eq(0).find('a').trigger('click');
            }
            iframeCont.find('iframe[name='+iframeId+']').remove();
            selfA.remove();
            event.stopPropagation();
        });
        $("#page-wrapper .page-tab").on('click','span.homeTab',function(){
            $("#indexPage").hide();
            $("#indexPage").find('iframe').remove();
            $("#homeHtml").show();
        });
    }
    //初始化左侧列表第一个点击
    var initLeftMenu = function () {
        var firstA = $("#side-menu a").eq(0);
        var firstATitle = $.trim(firstA.data('title'));
        //alert(firstATitle);
        if(firstATitle == ''){
            firstA.trigger('click');
        }
        else{
            firstA.trigger('click');
            firstA.next().find('a').eq(0).trigger('click');

        }
    };
    var leftMenuClickEvent = function () {
        var iframeSrc = '';
        var iframeId = '';
        $("#side-menu").on('click','a',function(){
            $("#side-menu li a").removeClass("active");
            $(this).addClass("active");
            iframeSrc = $(this).attr('href');
            iframeId = $(this).attr("target");
            var selTxt = $(this).data('txt');
            var isTitle = $.trim($(this).data('title'));
            if(isTitle == ''){
                showRightTab(iframeId,selTxt,iframeSrc);
            }
        });
    }
    return{
        rightTabClick:function () {
            iframeTab();
            iframeTabClose();
        },
        initLeftMenuClick:function () {
            leftMenuClickEvent();
            initLeftMenu();
        }
    }
}();

 rightTabFun.rightTabClick();



//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size
//这个是sd-admin里面的代码，目前这边的代码用不到
/*$(function() {
    $(window).bind("load resize", function() {
        var topOffset = 50;
        var width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            $('div.navbar-collapse').addClass('collapse');
            topOffset = 100; // 2-row-menu
        } else {
            $('div.navbar-collapse').removeClass('collapse');
        }      
    });

    var url = window.location;
    var element = $('ul.nav a').filter(function() {
        return this.href == url;
    }).addClass('active').parent().parent().addClass('in').parent();
    if (element.is('li')) {
        element.addClass('active');
    }
});*/
