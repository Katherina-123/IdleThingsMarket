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
               class="tip-bottom">商品分类可视化</a>
        </div>
    </div>
    <!--End-breadcrumbs-->
    <div class="container" style="width: 900px;">
        <div id="my_chart" style="width: 900px;height: 500px"></div>
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
                name: '面积模式',
                type: 'pie',
                radius: [20, 140],
                center: ['75%', '50%'],
                roseType: 'area',
                itemStyle: {
                    borderRadius: 5
                },
                data: [
                    {value: 19, name: '闲置数码'},
                    {value: 6, name: '出行代步'},
                    {value: 9, name: '日用电器'},
                    {value: 9, name: '图书教材'},
                    {value: 17, name: '美妆衣物'},
                    {value: 6, name: '运动棋牌'},
                    {value: 7, name: '票券小物'},
                ]
            },
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
                    {value: 19, name: '闲置数码'},
                    {value: 6, name: '出行代步'},
                    {value: 9, name: '日用电器'},
                    {value: 9, name: '图书教材'},
                    {value: 17, name: '美妆衣物'},
                    {value: 6, name: '运动棋牌'},
                    {value: 7, name: '票券小物'},
                ]
            },
        ]
    };
    goodsEcharts.setOption(option);
</script>
</html>
