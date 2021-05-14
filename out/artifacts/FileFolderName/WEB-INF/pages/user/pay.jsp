<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>确认订单</title>
<link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon" />
<link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
<link rel="stylesheet" href="<%=basePath%>css/user.css" />

<!-- bootstrap -->
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>

<!--订单编号随机数（有可能重复）  -->
<script type="text/javascript">
	window.onload = function() {
		var oNum = document.getElementsByClassName('order-num');

		oNum[0].value = fRandomBy(00000000, 99999999);
	}
	function fRandomBy(under, over) {
		//arguments.length 函数实参个数
		switch (arguments.length) {
		case 1:
			//Math.random()生成一个小于1的数，parseInt将其处理为整数
			return parseInt(Math.random() * under + 1);
		case 2:
			return parseInt(Math.random() * (over - under + 1) + under);
		default:
			return 0;
		}
	}
</script>
<script>
	function ness_text(){
		var str = document.getElementById("text").value;
		if(str.length >0){
			document.getElementById("sub").disabled=false;
		}
		return;
	}
</script>

</head>
<body>
	<div class="pre-2" id="big_img">
		<img
			src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif"
			class="jcrop-preview jcrop_preview_s">
	</div>
	<div id="cover" style="min-height: 639px;">
		<div id="user_area">
			<div id="home_header">
                 <img src="<%=basePath%>img/home_header1.png"  style="margin-left: 20px;" >
           		 </a> 
				<a href="<%=basePath%>user/home">
					<div class="home"></div>
				</a>
			</div>
			<!--

            描述：左侧个人中心栏
        -->
			<div id="user_nav">
				<div class="user_info">
					<div class="head_img">
						<img src="<%=basePath%>img/photo.jpg">
					</div>
					<div class="big_headimg">
						<img src="">
					</div>
					<span class="name">${cur_user.username}</span>
					<hr>
				   <a class="btn" style="width: 98%;background-color: rgb(79, 190, 246);color:rgba(255, 255, 255, 1);" href="<%=basePath%>user/myPurse">我的钱包：￥${myPurse.balance}</a>
                <input type="hidden" value="${myPurse.recharge}" id="recharge"/>
                <input type="hidden" value="${myPurse.withdrawals}" id="withdrawals"/>
               <span class="btn" data-toggle="modal" data-target="#myModal"style="width: 98%; background-color: rgb(79, 190, 246); color: rgba(255, 255, 255, 1); margin-top: 0.5cm;">我的信用积分：${cur_user.power}</span>

				</div>
				<div class="home_nav">
					<ul>
						<a href="<%=basePath%>orders/myOrders">
							<li class="notice">
								<div></div> <span>订单中心</span> <strong></strong>
						</li>
						</a>
						<a href="<%=basePath%>user/allFocus">
							<li class="fri">
								<div></div> <span>关注列表</span> <strong></strong>
						</li>
						</a>
						<a href="<%=basePath%>goods/publishGoods">
							<li class="store">
								<div></div> <span>发布物品</span> <strong></strong>
						</li>
						</a>
						<a href="<%=basePath%>user/allGoods">
							<li class="second">
								<div></div> <span>我的闲置</span> <strong></strong>
						</li>
						</a>
						<a href="<%=basePath%>user/basic">
							<li class="set">
								<div></div> <span>个人设置</span> <strong></strong>
						</li>
						</a>
					</ul>
				</div>
			</div>
			<!--

            描述：右侧内容区域
        -->
			<div id="user_content">

				<div class="share">

					<!--

                    描述：关注商品展示
                -->
					<h1 style="text-align: center;margin-top: 50px">确认订单</h1>
					<hr />
					<div class="share_content">
						<div class="story">
							<form class="form-horizontal" role="form" action="<%=basePath%>orders/addOrders">
							<h4 >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;订单编号： <input name="orderNum" class="order-num" type="text" style="border:0px;background:rgba(0, 0, 0, 0);" value=""/>  <input name="goodsId" type="hidden" value="${goodsExtend.goods.id}"/> </h4>
								<div class="form-group">
									<label for="firstname" class="col-sm-2 control-label">图片:</label>
									<div class="col-sm-10">
                							<img style="height:150px;weight:150px;" src="<%=basePath%>upload/${goodsExtend.images[0].imgUrl}" />
									</div>
									<label for="firstname" class="col-sm-2 control-label">名称：</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" disabled="disabled" style="border:0px;background:rgba(0, 0, 0, 0); " value="${goodsExtend.goods.name}" >
									</div>
									<label for="firstname" class="col-sm-2 control-label">价格：</label>
									<div class="col-sm-10">
										<input name="orderPrice" type="text" class="form-control" style="border:0px;background:rgba(0, 0, 0, 0); " value="${goodsExtend.goods.price}">
									</div>
									<label for="firstname" class="col-sm-2 control-label" >备注：</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="text"
											placeholder="请输入备注（收获人信息 地址 联系方式等,必填）"
											   value="" name="orderInformation" required="required"
											   oninput="ness_text();"
										>
									</div>
								</div>
								<hr />
								<div class="form-group">
									<div class="col-sm-offset-4 col-sm-8">
									    <a href="<%=basePath%>goods/goodsId/${goodsExtend.goods.id}" class="btn btn-danger">取消支付</a>
										<c:if test="${myPurse.balance >= goodsExtend.goods.price}">
											<input type="submit" value="立即支付" class="btn btn-info" id="sub" disabled="disabled" /></c:if>
										<c:if test="${myPurse.balance < goodsExtend.goods.price}"><button disabled="disabled" class="btn btn-danger">余额不足，请充值！</button></c:if>
										
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>