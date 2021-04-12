$(function(){
        // 图片绝对定位
        // 通过下标，显示当前，隐藏其他兄弟图片
        var index = 0;
        function move(){
        index++;
        if(index >= $("#sli_img img").length){
        index = 0;
    }
        $("#sli_img img").eq(index).show().siblings().hide();
        $("#page li").eq(index).addClass("active").siblings().removeClass("active");
    }
        // 每隔两秒轮播
        var t = setInterval(move,2000);
        // 鼠标滑入停止播放（移除定时器）
        // 鼠标滑出继续播放（开启定时器）
        $("#sli_img").hover(function(){
        clearInterval(t);
    },function(){
        t = setInterval(move,2000);
    })
        // 点击圆点时显示对应的图片
        $("#page li").click(function(){
        index = $(this).index();
        $("#sli_img img").eq(index).show().siblings().hide();
        $("#page li").eq(index).addClass("active").siblings().removeClass("active");
    })
        // 上一张
        $("#prev").click(function(){
        index--;
        if(index<0){
        index = $("#sli_img img").length-1;
    }
        $("#sli_img img").eq(index).show().siblings().hide();
        $("#page li").eq(index).addClass("active").siblings().removeClass("active");
    })
        // 下一张
        $("#next").click(function(){
        move();
    })
});