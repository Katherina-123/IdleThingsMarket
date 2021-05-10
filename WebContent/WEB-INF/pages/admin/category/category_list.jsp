<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<body>
<jsp:include page="../main_top.jsp"></jsp:include>
<jsp:include page="../main_left.jsp"></jsp:include>
<!--=============================================================================================================================================================================-->
<!--main-container-part-->

<div id="content" style="margin-right: 100px;margin-top: 40px;">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb">
            <a href="<%=basePath%>admin/indexs" title="主页"
               class="tip-bottom"><i class="icon-home"></i>主页</a> <a title="商品可视化"
               class="tip-bottom">商品可视化</a>
        </div>
    </div>
    <!--End-breadcrumbs-->
    <div class="container" style="width: 900px;">
        <div id="my_chart" style="width: 850px;height: 500px"></div>
    </div>
    <!-- Page table -->

</div>



<!--==================================================================================================================-->
<jsp:include page="../main_bottom.jsp"></jsp:include>




</body>


<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
<!-- datetimepicker -->
<script type="text/javascript" src="<%=basePath%>js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src='<%=basePath%>js/bootstrap-datetimepicker.zh-CN.js'></script>
<!-- 全选 base.js -->
<script type="text/javascript"src="<%=basePath%>js/custom/base.js"></script>
<script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>
<script>
    var goodsEcharts = echarts.init(document.getElementById('my_chart'));
    var option = {
        title: {
            text: '商品分类数据图',
            left: 'center'
        },
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
            left: 'center',
            top: 'bottom',
            data: ['闲置数码', '出行代步', '日用电器', '图书教材', '美妆衣物', '运动棋牌', '票券小物']
        },
        toolbox: {
            show: true,
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        series: [
            {
                name: '半径模式',
                type: 'pie',
                radius: [20, 140],
                center: ['25%', '50%'],
                roseType: 'radius',
                itemStyle: {
                    borderRadius: 5
                },
                label: {
                    show: false
                },
                emphasis: {
                    label: {
                        show: true
                    }
                },
                data: [
                    {value: 40, name: '闲置数码'},
                    {value: 33, name: '出行代步'},
                    {value: 28, name: '日用电器'},
                    {value: 22, name: '图书教材'},
                    {value: 20, name: '美妆衣物'},
                    {value: 15, name: '运动棋牌'},
                    {value: 12, name: '票券小物'},
                ]
            },
            {
                name: '面积模式',
                type: 'pie',
                radius: [20, 140],
                center: ['75%', '50%'],
                roseType: 'area',
                itemStyle: {
                    borderRadius: 5
                },
                data: [
                    {value: 30, name: '出行代步'},
                    {value: 28, name: '出行代步'},
                    {value: 26, name: '日用电器'},
                    {value: 24, name: '图书教材'},
                    {value: 22, name: '美妆衣物'},
                    {value: 20, name: '运动棋牌'},
                    {value: 18, name: '票圈小屋'},
                ]
            }
        ]
    };
    goodsEcharts.setOption(option);
</script>

<script type="text/javascript">
    /* 查看 */
    function doView(id){
        $.ajax({
            url:'<%=basePath%>admin/getGoods',
            type:'GET',
            data:{id:id},
            dataType:'json',
            success:function(json){
                if(json){
                    $('#myviewform').find("input[name='id']").val(json.id);
                    $('#myviewform').find("input[name='name']").val(json.name);
                    $('#myviewform').find("input[name='catelogId']").val(json.catelogId);
                    $('#myviewform').find("input[name='price']").val(json.price);
                    $('#myviewform').find("input[name='realPrice']").val(json.realPrice);
                    $('#myviewform').find("input[name='startTime']").val(json.startTime);
                    $('#myviewform').find("textarea[name='describle']").val(json.describle);
                    if(json.status==1){
                        $('#myviewform').find("input[name='status']").val('在售');
                    }else{
                        $('#myviewform').find("input[name='status']").val('下架');
                    }
                    $('#viewModal').modal('toggle');
                }
            },
            error:function(){
                alert('请求超时或系统出错!');
                $('#viewModal').modal('hide');
            }
        });
    }



    //根据值 动态选中
    $("#myselected option[value='${searchgoods.status}']").attr("selected","selected");

</script>

</html>
