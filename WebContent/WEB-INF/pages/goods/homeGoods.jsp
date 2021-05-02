<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//    得到项目的名字
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>【轻松闲置】交易市场</title>
    <style type="text/css">
        .slideshow{
            width: 900px;
            height: 400px;
            margin: 0 auto;
            overflow: hidden;
        }
        .slideshow #sli_img img{
            position: absolute;
            display: none;
        }
        .slideshow #sli_img :first-child{
            display: block;
        }
        .slideshow .page{
            list-style: none;
            display: flex;
            width: 160px;
            justify-content: space-around;
            position: absolute;
            margin-top: 360px;
            margin-left: 30%;
            /*float: left;*/
            /*border: 1px solid rebeccapurple;*/
        }
        .slideshow .page li{
            width: 20px;
            height: 20px;
            border-radius: 50%;
            text-align: center;
            line-height: 20px;
            color: lavenderblush;
            border: 1px solid white;
            cursor: pointer;
        }
        .slideshow .page .active{
            background-color: cadetblue;
        }
        .slideshow #control #prev{
            background: none;
            border: none;
            color: white;
            font-size: 18px;
            outline: none;
            width: 30px;
            height: 20px;
            margin-left: 20px;
            /* display:flex; */
            /* justify-content: space-between; */
            position: absolute;
            margin-top: 250px;
        }
        .slideshow #control #next{
            background: none;
            border: none;
            color: white;
            font-size: 20px;
            outline: none;
            width: 30px;
            height: 20px;
            margin-left: 860px;
            /* display:flex; */
            /* justify-content: space-between; */
            position: absolute;
            margin-top: 250px;
        }
    </style>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/index.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/index.bundle.js" ></script>
<%--    <script type="text/javascript" src="<%=basePath%>js/myjquery.js" ></script>--%>
    <link rel="stylesheet" href="<%=basePath%>css/materialize-icon.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
    <script>
        function showLogin() {
            if($("#signup-show").css("display")=='block'){
                $("#signup-show").css("display","none");
            }
            if($("#login-show").css("display")=='none'){
                $("#login-show").css("display","block");
            }else{
                $("#login-show").css("display","none");
            }
        }
        function NoshowLogin() {
            $("#login-show").css("display","none");
        }
        function showSignup() {
            if($("#login-show").css("display")=='block'){
                $("#login-show").css("display","none");
            }
            if($("#signup-show").css("display")=='none'){
                $("#signup-show").css("display","block");
            }else{
                $("#signup-show").css("display","none");
            }
        }
        function ChangeName() {
            if($("#changeName").css("display")=='none'){
                $("#changeName").css("display","block");
            }else{
                $("#changeName").css("display","none");
            }
        }
        function LoginSuc(){
            alert("denglu")
            // document.write("登录成功！")
        }
        function LoginFail(){
            document.write("账号或密码错误！")
        }
        
        $(document).ready(function(){
            //异步验证
            $("#phone").blur(function(){
              var phone=$(this).val();
              $.ajax({
    				url:'<%=basePath%>user/register',
    				type:'POST',
    				data:{phone:phone},
    				dataType:'json',
    				success:function(json){
    					if(json.flag){
    						 $("#errorPhone").html("账号已被注册，请重新输入!");
    						 $("#register").attr("disabled",true);
    					}else{
    						 $("#errorPhone").empty();
    						 $("#register").attr("disabled",false);
    					}
    				},
    				error:function(){
    					alert('请求超时或系统出错!');
    				}
    			});
               
            });
        });
        
        
    </script>

</head>
<body ng-view="ng-view">
<!--
    描述：顶部
-->
<div ng-controller="headerController" class="header stark-components navbar-fixed ng-scope">
    <nav class="white nav1">
        <div class="nav-wrapper">
            <a href="<%=basePath%>goods/homeGoods" class="logo">
                <img src="<%=basePath%>img/logo.png" style="width:50px;height:50px">
                <em class="em1" style="color: #e76831">轻松闲置</em>
                <em class="em2">二手交易市场</em>
                <em class="em3"></em>
            </a>
            <div class="nav-wrapper search-bar">
                <form class="ng-pristine ng-invalid ng-invalid-required" action="<%=basePath%>goods/search">
                    <div class="input-field">
                        <input type="submit" class="button button2"value="搜索" style="height: 45px;width:80px;background-color:#ef5350;margin-top: -20px;">
                        <input id="search" name="str" placeholder="搜索看看已有闲置吧..." style="height: 40px;width: 250px"
                               class="ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                      	</input>
<%--                        <label for="search" class="active">--%>
<%--                            <i ng-click="search()" class="iconfont"></i>--%>
<%--                        </label>--%>
                    </div>
                </form>
            </div>
            <ul class="right">
                <c:if test="${empty cur_user}">
                    <li class="publish-btn">
                       <button onclick="showLogin()" data-toggle="tooltip" class="red lighten-1 waves-effect waves-light btn" 	>
                            我要发布</button>
                    </li>
                </c:if>
                <c:if test="${!empty cur_user}">
                    <li class="publish-btn">
                        <button data-position="bottom" class="red lighten-1 waves-effect waves-light btn">
<%--                            首页点击我要发布按钮进入个人中心发布物品页面--%>
                            <a href="<%=basePath%>goods/publishGoods">我要发布</a>
                        </button>
                    </li>
                    <li>
                        <a href="<%=basePath%>user/allGoods">我发布的商品</a>
                    </li>
                    <li>
                        <a>${cur_user.username}</a>
                    </li>
                    <!-- <li class="notification">
                        <i ng-click="showNotificationBox()" class="iconfont"></i>
                    </li> -->
                    <li class="changemore">
                        <a class="changeMoreVertShow()">
                            <i class="iconfont"></i>
                        </a>
                        <div class="more-vert">
                            <ul class="dropdown-content">
                                <li><a href="<%=basePath%>user/home">个人中心</a></li>
                                <li><a href="<%=basePath%>user/allFocus">我的关注</a></li>
                                <li><a onclick="ChangeName()">更改用户名</a></li>
                                <li><a href="<%=basePath%>admin" target="_blank">登录后台</a></li>
                                <li><a href="<%=basePath%>user/logout">退出登录</a></li>
                            </ul>
                        </div>
                    </li>
                </c:if>
                <c:if test="${empty cur_user}">
                    <li>
                        <a onclick="showLogin()">登录</a>
                    </li>
                    <li>
                        <a onclick="showSignup()">注册</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </nav>
</div>
<!--
    描述：登录
-->
<div ng-controller="loginController" class="ng-scope">
    <div id="login-show" class="login stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <a onclick="showLogin()">
                    <div class="col s12 title"></div>
                </a>
                <form action="<%=basePath%>user/login" method="post" role="form">
                    <div class="input-field col s12">
                        <input type="text" name="phone" id="login_phone" required="required" pattern="^1[0-9]{10}$" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>手机&nbsp;&nbsp;<div id="login_errorPhone" style="color:red;display:inline;"></div></label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" id="login_password"  name="password" required="required" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required" />
                        <label>密码&nbsp;&nbsp;<div id="errorPassword" style="color:red;display:inline;"></div></label>
                    </div>
                    <button type="submit" id="loginIn" class="waves-effect waves-light btn login-btn red lighten-1">
                        <i class="iconfont left"></i>
                        <em>登录</em>
                    </button>
                    <div class="col s12 signup-area">
                        <em>没有账号？赶快</em>
                        <a onclick="showSignup()" class="signup-btn">注册</a>
                        <em>吧！</em>
                        <p>
                            &nbsp;
                        </p>
                        <a onclick="NoshowLogin()" class="signup-btn">先逛逛</a>
                    </div>

                </form>
<%--                <c:if test="${empty cur_user}">--%>

<%--                </c:if>--%>

            </div>
        </div>
    </div>
</div>
<!--

    描述：注册
-->
<div ng-controller="signupController" class="ng-scope">
    <div id="signup-show" class="signup stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <a onclick="showSignup()">
                    <div class="col s12 title"></div>
                </a>
                <form action="<%=basePath%>user/addUser" method="POST" role="form" id="signup_form">
                    <div class="input-field col s12">
                        <input type="text" name="username" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>昵称</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="text" name="phone" id="phone" required="required" pattern="^1[0-9]{10}$" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>手机&nbsp;&nbsp;<div id="errorPhone" style="color:red;display:inline;"></div></label>
                           
                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="password" required="required" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required" />
                        <label>密码</label>
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                        <button type="submit" id="register" class="waves-effect waves-light btn verify-btn red lighten-1">
                            <i class="iconfont left"></i>
                            <em>点击注册</em>
                        </button>
                    </div>
                    <div ng-show="checkTelIsShow" class="login-area col s12">
                        <em>已有账号？去</em>
                        <a onclick="showLogin()">登录</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!--更改用户名-->
<div ng-controller="changeNameController" class="ng-scope">
    <div id="changeName" class="change-name stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <div class="col s12 title">
                    <h1>修改用户名</h1>
                </div>
                <form action="<%=basePath%>user/changeName" method="post"  role="form">
                    <div class="input-field col s12">
                        <input type="text" name="username" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>修改用户名</label>
                         
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                   <button class="waves-effect waves-light btn publish-btn red lighten-1">
                            <i class="iconfont left"></i>
                            <em>确认</em>
                        </button>   
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!--
    左侧导航条
-->
<div ng-controller="sidebarController" class="sidebar stark-components ng-scope">
    <li ng-class="{true: 'active'}[isAll]">
        <a href="<%=basePath%>goods/catelog" class="index">
            <img src="<%=basePath%>img/navigator_pic.png">
            <em >最新发布</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isDigital]">
        <a href="<%=basePath%>goods/catelog/1" class="digital">
            <img src="<%=basePath%>img/navigator_pic.png"  />
            <em>闲置数码</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isRide]">
        <a href="<%=basePath%>goods/catelog/2" class="ride">
            <img src="<%=basePath%>img/navigator_pic.png"/>
            <em>出行代步</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isCommodity]">
        <a href="<%=basePath%>goods/catelog/3" class="commodity">
            <img src="<%=basePath%>img/navigator_pic.png"/>
            <em>日用电器</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isBook]">
        <a href="<%=basePath%>goods/catelog/4" class="book">
            <img src="<%=basePath%>img/navigator_pic.png"/>
            <em>图书教材</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isMakeup]">
        <a href="<%=basePath%>goods/catelog/5" class="makeup">
            <img src="<%=basePath%>img/navigator_pic.png"/>
            <em>美妆衣物</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSport]">
        <a href="<%=basePath%>goods/catelog/6" class="sport">
            <img src="<%=basePath%>img/navigator_pic.png"/>
            <em>运动棋牌</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSmallthing]">
        <a href="<%=basePath%>goods/catelog/7" class="smallthing">
            <img src="<%=basePath%>img/navigator_pic.png"/>
            <em>票券小物</em>
        </a>
    </li>
    <div class="info">
        <a href="#">关于我们</a><em>-</em>
        <a href="#">联系我们</a>
        <p>©2021 轻松闲置交易市场</p>
    </div>
</div>
<!--

    描述：右侧显示部分
-->
<div class="main-content">
    <!--

        描述：右侧banner（图片）部分
    -->
    <div class="slider-wapper">
        <div class="slideshow">
            <div id="sli_img">
                <img src="../img/home-banner-1.png" width="920px" height="400px" />
                <img src="../img/home-banner-2.png" width="920px" height="400px" />
                <img src="../img/home-banner-3.jpg" width="920px" height="400px" />
                <img src="../img/home-banner-4.jpg" width="920px" height="400px" />
            </div>
            <ul class="page" id="page">
                <li class="active">1</li>
                <li>2</li>
                <li>3</li>
                <li>4</li>
            </ul>
            <div id="control">
                <button type="button" id="prev">&lt;&lt;</button>
                <button type="button" id="next">&gt;&gt;</button>
            </div>
        </div>
    </div>
    <!--

        描述：最新发布
    -->
    <div class="index-title">
        <a style="margin-left: 50%">最新发布</a>
        <hr class="hr1" style="margin-left: 49%">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>轻松闲置</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <!--

        描述：闲置数码
    -->
    <div class="index-title">
        <a style="margin-left: 50%">闲置数码</a>
        <hr class="hr1" style="margin-left: 49%">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods1}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>轻松闲置</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <!--

        描述：出行代步
    -->
    <div class="index-title">
        <a style="margin-left: 50%">出行代步</a>
        <hr class="hr1" style="margin-left: 49%">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods2}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>轻松闲置</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a style="margin-left: 50%">日用电器</a>
        <hr class="hr1" style="margin-left: 49%">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods3}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>轻松闲置</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a style="margin-left: 50%">图书教材</a>
        <hr class="hr1" style="margin-left: 49%">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods4}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>轻松闲置</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a style="margin-left: 50%">美妆衣物</a>
        <hr class="hr1" style="margin-left: 49%">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods5}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>轻松闲置</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a style="margin-left: 50%">运动棋牌</a>
        <hr class="hr1" style="margin-left: 49%">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods6}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>轻松闲置</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a style="margin-left: 50%">票券小物</a>
        <hr class="hr1" style="margin-left: 49%">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods7}">//
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}" />
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>轻松闲置</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
<%--<script src="jquery-3.1.1.min.js" type="text/javascript" charset="utf-8"></script>--%>
<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js" ></script>
<script type="text/javascript">
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
</script>
<script src="https://cdn.bootcdn.net/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<script>
    var msg = '<%=(String) request.getSession().getAttribute("msg")%>';
    switch (msg) {
        case "success":
            // alert("登陆成功！");
            swal({
                title: "登录成功",
                text: "欢迎您"
            })
            break;
        case "wrong":
            swal({
                title: "密码错误",
                text: "请重试"
            })
            break;
        case "ban":
            swal({
                title: "该用户已停用",
                text: "请联系管理人员"
            })
            break;
        case "no":
            swal({
                title: "该手机号未注册",
                text: "请先去注册"
            })
            break;
    }
    <%request.getSession().removeAttribute("msg");%>
</script>

</html>
