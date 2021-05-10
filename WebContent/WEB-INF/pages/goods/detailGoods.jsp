<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>轻松闲置交易市场</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/index.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/index.bundle.js" ></script>
    <link rel="stylesheet" href="<%=basePath%>css/materialize-icon.css" />
    <link rel="stylesheet" href="<%=basePath%>css/detail.css" />
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
    </script>
    
    <script type="text/javascript">
    
    function  addFocus(id) {
        // 当前页面打开我的关注页面
    	location.href = '<%=basePath%>user/addFocus/'+id
    	alert("已关注成功，查看关注列表~")
    	
    }
    
	/* 前往支付 */
    function  toPay(id) {
        //当前页面打开支付页面
    	window.location.href = '<%=basePath%>goods/buyId/'+id
    }
	
    </script>
    
    
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
                <form ng-submit="search()" class="ng-pristine ng-invalid ng-invalid-required" action="<%=basePath%>goods/search">
                    <div class="input-field">
                        <input type="submit" class="button button2"value="搜索" style="height: 45px;width:80px;background-color:#ef5350;margin-top: -20px;">
                        <input id="search" name="str" placeholder="  搜索看看已有闲置吧..." style="height: 40px;width: 250px"
                               class="ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        </input>
                         
                    </div>
                   
                </form>
            </div>
            <ul class="right">
                <c:if test="${empty cur_user}">
                    <li class="publish-btn">
                        <button onclick="showLogin()" data-toggle="tooltip" 
                                 class="red lighten-1 waves-effect waves-light btn" 	>
                            我要发布</button>
                    </li>
                </c:if>
                <c:if test="${!empty cur_user}">
                    <li class="publish-btn">
                        <button data-position="bottom" class="red lighten-1 waves-effect waves-light btn">
                            <a href="<%=basePath%>goods/publishGoods">我要发布</a>
                        </button>
                    </li>
                    <li>
                        <a href="<%=basePath%>user/allGoods">我发布的商品</a>
                    </li>
                    <li>
                        <a>${cur_user.username}</a>
                    </li>
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
                <form action="<%=basePath%>user/login" method="post" commandName="user" role="form">
                    <div class="input-field col s12">
                        <input type="text" name="phone" required="required" pattern="^1[0-9]{10}$" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>手机</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="password" required="required" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required" />
                        <label>密码</label>
                    </div>
                    <button type="submit" class="waves-effect waves-light btn login-btn red lighten-1">
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
                <form:form action="../../user/addUser" method="post" commandName="user" role="form">
                    <div class="input-field col s12">
                        <input type="text" name="username" required="required" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>昵称</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="text" name="phone" required="required" pattern="^1[0-9]{10}$" class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched" />
                        <label>手机</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="password" required="required" class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required" />
                        <label>密码</label>
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                        <button type="submit" class="waves-effect waves-light btn verify-btn red lighten-1">
                            <i class="iconfont left"></i>
                            <em>点击注册</em>
                        </button>
                    </div>
                    <div ng-show="checkTelIsShow" class="login-area col s12">
                        <em>已有账号？去</em>
                        <a onclick="showLogin()">登录</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
<!--更改用户名-->
<%--ng-controller指明控制器--%>
<div ng-controller="changeNameController" class="ng-scope">
    <div id="changeName" class="change-name stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <div class="col s12 title">
                    <h1>修改用户名</h1>
                </div>
                <form:form action="../../user/changeName" method="post" commandName="user" role="form">
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
                </form:form>
            </div>
        </div>
    </div>
</div>
<!--显示商品详情-->
<div ng-controller="detailBoxController" class="detail-box stark-components z-depth-1 row ng-scope">
    <div class="col s12 path">
<%--        homegoods-->detaiGoods传过来CommentExtend，goodsExtend，seller，catelog--%>
        <a href="<%=basePath%>goods/catelog/${catelog.id}">${catelog.name}</a>
        <em>></em>
        <a>${goodsExtend.goods.name}</a>
    </div>
    <div class="col s6">
        <div class="slider" style="height: 440px;">
            <ul class="slides" style="height: 400px;">
<%--                获取图片存放地址--%>
                <img src="<%=basePath%>upload/${goodsExtend.images[0].imgUrl}" />
            </ul>
            <ul class="indicators" style="display:none;">
                <li class="indicator-item"></li>
                <li class="indicator-item"></li>
                <li class="indicator-item"></li>
                <li class="indicator-item"></li>
            </ul>
        </div>
    </div>
    <div class="col s6">
        <h1 class="item-name">${goodsExtend.goods.name}</h1>
        <h2 class="item-price">${goodsExtend.goods.price}</h2>
        <h2 class="publisher-info-title">原价：<span style="text-decoration:line-through;">${goodsExtend.goods.realPrice}</span></h2>
        <div class="item-public-info">
            <p class="bargain">可讲价</p>
            <p>
                <i class="iconfont"></i>
                <em class="item-location">${cur_user.address}</em>
            </p>
        </div>
        <div class="publisher-info-title">
            <em>卖家信息</em><hr>
        </div>
        <c:if test="${empty cur_user}">
            <div class="item-contact">
                <p class="not-login">
                    <a onclick="showLogin()">登录</a>
                    <em>或</em>
                    <a onclick="showSignup()">注册</a>
                    <em>后查看联系信息</em>
                </p>
            </div>
        </c:if>
        <c:if test="${!empty cur_user}">
            <div class="item-contact">
                <div>
                    <div class="base-blue z-depth-1 attr">
                        <i class="iconfont"></i>
                    </div>
                    <div class="value">${seller.username}</div>
                </div>
                <div>
                    <div class="base-blue z-depth-1 attr">
                        <i class="iconfont"></i>
                    </div>
                    <div class="value">${seller.phone}</div>
                </div>
                <div>
                    <div class="base-blue z-depth-1 attr">
                        <i class="iconfont"></i>
                    </div>
                    <c:if test="${seller.qq!=null}">
                    <div class="value">${seller.qq}</div>
                    </c:if>
                    <c:if test="${seller.qq==null}">
                    <div class="value">该用户没留下QQ</div>
                    </c:if>
                    
                </div>
                <div>
              
               <input type="button" value="加入关注" class="blue lighten-1 waves-effect waves-light btn" id="btn_cart" onclick="addFocus(${goodsExtend.goods.id})"></input>
               <c:if test="${cur_user.id==goodsExtend.goods.userId}">
               <input type="button" value="在线支付" data-toggle="tooltip"  title="不可以购买自己的东西哦~" disabled="disabled" class="blue lighten-1 waves-effect waves-light btn" id="btn_buy"></input>
                </c:if>
                <c:if test="${cur_user.id!=goodsExtend.goods.userId}">
               <input type="button" value="在线支付"  class="blue lighten-1 waves-effect waves-light btn" id="btn_buy" onclick="toPay(${goodsExtend.goods.id})"></input>
                </c:if>
                </div>
                
            </div>
        </c:if>
        <h1 class="item-pub-time">发布于 ${goodsExtend.goods.startTime}</h1>
    </div>
</div>
<div class="detail-box stark-components z-depth-1 row">
    <h1 class="title">商品描述</h1>
    <hr class="hr1" />
    <hr class="hr2" />
    <p class="section">描述：${goodsExtend.goods.describle}</p>
    <p class="section"></p>
    <p class="section">
        联系我的时候，请说明是在“轻松闲置交易市场”上看见的哦~
    </p>
</div>
<div class="row detail-area">
    <div class="clo s12">
        <div ng-controller="commentController" class="comment stark-components z-depth-1 ng-scope">
            <h1 class="title">评论</h1>
            <hr class="hr1" />
            <hr class="hr2" />
          <form id="addCommentForm" class="form-horizontal" >
            <div class="comment-add row">
                <div class="input-field col s12">
                    <i class="iconfont prefix"></i>
                    <input id="goodsId" name="goods.id" value="${goodsExtend.goods.id}" type="hidden"/>
                    <input id="commentbox" type="text" name="content" class="validate ng-pristine ng-untouched ng-valid ng-empty"/>
                    <label for="commentbox">这里写下评论</label>
                    <c:if test="${!empty cur_user}">
                    <button type="button" class="waves-effect wave-light btn comment-submit" onclick="addComments()">确认</button>
                    </c:if>
                     <c:if test="${empty cur_user}">
                    <button href="javacript:void(0);" data-toggle="tooltip"  title="您需要先登录哦！" disabled="disabled" class="waves-effect wave-light btn comment-submit">确认</button>
                    </c:if>
                   
                </div>
            </div>
            </form>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
/* 评论 */
function addComments(){
	$.ajax({
		url:'<%=basePath%>goods/addComments',
		type:'POST',
		data:$('#addCommentForm').serialize(),// 序列化表单值  
		dataType:'json',
	});
	alert("您已评论成功~")
	window.location.reload();
}
</script>
</html>