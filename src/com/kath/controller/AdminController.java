package com.kath.controller;

import com.kath.pojo.*;
import com.kath.service.*;
import com.kath.util.GoodsGrid;
import com.kath.util.OrdersGrid;
import com.kath.util.PurseGrid;
import com.kath.util.UserGrid;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *  2021-3-7 10:40:38
 */
@Controller
@RequestMapping(value = "/admin")
public class AdminController {

	@Resource
	private UserService userService;

	@Resource
	private GoodsService goodsService;

	@Resource
	private CatelogService catelogService;

	@Resource
	private OrdersService ordersService;

	@Resource
	private PurseService purseService;

	@Resource
	private AdminService adminService;

	/**
	 *    √
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String login(HttpSession session) {

		return "/admin/login";
	}


	/**
	 *  登录发出请求进入首页  √
	 * @param request
	 * @param admins
	 * @return
	 */
	@RequestMapping(value = "/index", method = RequestMethod.POST)
	public String index(HttpServletRequest request, Admin admins) {
		//findAdmin返回admin类型
		Admin myadmin = adminService.findAdmin(admins.getPhone(), admins.getPassword());
		if (myadmin != null) {
			request.getSession().setAttribute("admin", myadmin);
			return "/admin/index";
		}
		return "/admin/login";

	}

	/**
	 *  其他页面请求首页  √
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/indexs")
	public String indexs(HttpServletRequest request) {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		if (admin != null) {
			Integer id = admin.getId();
			Admin myadmin = adminService.findAdminById(id);
			request.getSession().setAttribute("admin", myadmin);
			return "/admin/index";
		}
		return "/admin/login";

	}


	/**
	 * 个人信息  √
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/info")
	@ResponseBody
	public ModelAndView getInfo(HttpServletRequest request) {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("admin", admin);
		modelAndView.setViewName("admin/info");
		return modelAndView;
	}

	/**
	 *  请求修改密码页面  √
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/modify")
	@ResponseBody
	public ModelAndView getModify(HttpServletRequest request) {
		Admin admin = (Admin) request.getSession().getAttribute("admin");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("admin", admin);
		modelAndView.setViewName("admin/modify");
		return modelAndView;
	}

	/**
	 * 修改密码  √
	 * @param request
	 * @param admin
	 * @return
	 */
	@RequestMapping(value = "/changePassword")
	@ResponseBody
	public ModelAndView changePassword(HttpServletRequest request,Admin admin) {
		String pwd=request.getParameter("password1");
		ModelAndView modelAndView = new ModelAndView();

		//cur_admin是当前修改密码后封装的admin，admin是当前session中的admin
		Admin cur_admin = (Admin) request.getSession().getAttribute("admin");
		//判断cur_admin输入的原密码是否与admin的密码相同
		if(admin.getPassword().equals(cur_admin.getPassword())) {
			cur_admin.setPassword(pwd);
			adminService.updateAdmin(cur_admin);
		}else {
			modelAndView.addObject("msg", "原密码有误，请重新输入！");
			modelAndView.setViewName("admin/modify");
			return modelAndView;
		}
		modelAndView.setViewName("admin/login");
		return modelAndView;
	}

	/********************************************************
	 * 用户管理 1.查找所有用户 2.查看用户 3.修改用户 4.删除用户 5.查询用户
	 * 
	 **********************************************************/

	/**
	 * 查找所有用户   √
	 * @param pageNum
	 * @return
	 */
	@RequestMapping(value = "/userList")
	@ResponseBody
	public ModelAndView getUserList(@RequestParam("pageNum") int pageNum) {
		ModelAndView modelAndView = new ModelAndView();
		int pageSize = 10;
		//用户总数量
		int total = userService.getUserNum();
		//从pageNum页开始，每页pageSize条数据
		List<User> rows = userService.getPageUser(pageNum, pageSize);
		UserGrid userGrid = new UserGrid();
		//当前页码
		userGrid.setCurrent(pageNum);
		//当前每页行数
		userGrid.setRowCount(pageSize);
		//当前用户列表
		userGrid.setRows(rows);
		//总行数
		userGrid.setTotal(total);
		modelAndView.addObject("userGrid", userGrid);
		modelAndView.setViewName("admin/user/user_list");
		return modelAndView;
	}

	/**
	 * Modal查看用户  √
	 * @Param id(json格式）
	 *
	 * */
	@RequestMapping(value = "/getUser")
	@ResponseBody
	public User getUser(HttpServletRequest request) {
		String id = request.getParameter("id");
		User user = userService.getUserById(Integer.parseInt(id));
		return user;
	}

	/**
	 * ajax请求
	 * 修改用户   √
	 * @Param：user
	 *
	 *  */
	@RequestMapping(value = "/updateUser", method = RequestMethod.POST)
	@ResponseBody
	public String updateUser(HttpServletRequest request, User user) {
		User users = userService.selectByPrimaryKey(user.getId());
		user.setPassword(users.getPassword());
		try {
			userService.updateUserName(user);
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"保存失败!\"}";
		}
		return "{\"success\":true,\"msg\":\"保存成功!\"}";
	}

	/**
	 * 删除用户
	 * ids[]
	 * 可能是批量处理
	 * */
	@RequestMapping(value = "/deleteUser", method = RequestMethod.POST)
	@ResponseBody
	public String deleteUser(HttpServletRequest request, @RequestParam(value = "ids[]") String[] ids) {
		try {
			for (int i = 0; i < ids.length; i++) {
				userService.deleteUserById(ids[i]);
			}
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"删除失败!\"}";
		}
		return "{\"success\":true,\"msg\":\"删除成功!\"}";
	}

	/**
	 * 查询用户
	 * @param request
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/searchUser", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView searchUser(HttpServletRequest request, User user) {
		ModelAndView mv = new ModelAndView();
		//当前页数和每页行数
		int pageNum = 1;
		int pageSize = 10;
		//获取当前用户总数
		int total = userService.getUserNum();
		//获取传入的属性对应的用户的其他数据
		String phone = user.getPhone();
		String username = user.getUsername();
		String qq = user.getQq();
		//查询出符合要求的用户列表
		List<User> rows = userService.getPageUserByUser(phone, username, qq, pageNum, pageSize);
		UserGrid userGrid = new UserGrid();
		User searchuser = new User();
		//封装选择条件的用户，显示到搜索栏
		searchuser.setPhone(phone);
		searchuser.setUsername(username);
		searchuser.setQq(qq);
		//封装userGid，pageNum=1，pageSize=10，rows是符合条件用户列表，total是用户总数
		userGrid.setCurrent(pageNum);
		userGrid.setRowCount(pageSize);
		userGrid.setRows(rows);
		userGrid.setTotal(total);
		mv.addObject("userGrid", userGrid);
		mv.addObject("searchuser", searchuser);
		mv.setViewName("admin/user/user_list");
		return mv;
	}

	/*********************************************************
	 * 商品管理 1.查找所有商品 2.查看商品 3.修改商品 4.删除商品 5.查询商品 kath
	 * 
	 **********************************************************/

	/**
	 * 查找所有商品  √
	 *
	 *
	 * */
	@RequestMapping(value = "/goodsList")
	@ResponseBody
	public ModelAndView getGoodsList(@RequestParam("pageNum") int pageNum) {
		ModelAndView modelAndView = new ModelAndView();
		int pageSize = 10;
		int total = goodsService.getGoodsNum();
		//从当前页码开始，按每页10条数据获取商品对象列表
		List<Goods> rows = goodsService.getPageGoods(pageNum, pageSize);
		GoodsGrid goodsGrid = new GoodsGrid();
		//封装商品对象列表
		goodsGrid.setCurrent(pageNum);
		goodsGrid.setRowCount(pageSize);
		goodsGrid.setRows(rows);
		goodsGrid.setTotal(total);
		modelAndView.addObject("goodsGrid", goodsGrid);
		modelAndView.setViewName("admin/goods/goods_list");
		return modelAndView;
	}

	/**
	 * Modal查看选择商品  √
	 * @param request  (goodsId)
	 *
	 *
	 * */
	@RequestMapping(value = "/getGoods")
	@ResponseBody
	public Goods getGoods(HttpServletRequest request) {
		String id = request.getParameter("id");
		Goods goods = goodsService.getGoodsById(Integer.parseInt(id));
		return goods;
	}

	/**
	 * 修改商品  √
	 * @param goods  (name,catelogId,price,realPrice,startTime,describle,status,)
	 *
	 *
	 * */
	@RequestMapping(value = "/updateGoods", method = RequestMethod.POST)
	@ResponseBody
	public String updateGoods(HttpServletRequest request, Goods goods) {
		int id = goods.getId();
		//原商品
		Goods oldGoods = goodsService.getGoodsById(id);
		//goods封装原商品的用户id，和下架时间
		goods.setUserId(oldGoods.getUserId());
		goods.setPolishTime(oldGoods.getPolishTime());
		goods.setEndTime(oldGoods.getEndTime());
		try {
			//根据id修改商品
			goodsService.updateGoodsByPrimaryKeyWithBLOBs(goods.getId(), goods);
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"保存失败!\"}";
		}
		return "{\"success\":true,\"msg\":\"保存成功!\"}";
	}

	/**
	 * 删除商品  √
	 * @param ids  String 数组
	 *
	 * */
	@RequestMapping(value = "/deleteGoods", method = RequestMethod.POST)
	@ResponseBody
	public String deleteGoods(HttpServletRequest request, @RequestParam(value = "ids[]") String[] ids) {
		try {
			for (int i = 0; i < ids.length; i++) {
				goodsService.deleteGoodsByPrimaryKeys(Integer.parseInt(ids[i]));
			}
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"删除失败!\"}";
		}
		return "{\"success\":true,\"msg\":\"删除成功!\"}";
	}

	/**
	 * 查询商品  √
	 * @param goods  (id,name,status,)
	 *
	 * */
	@RequestMapping(value = "/searchGoods", method = RequestMethod.POST)
	public ModelAndView searchGoods(HttpServletRequest request, Goods goods) {
		ModelAndView mv = new ModelAndView();
		int pageNum = 1;
		int pageSize = 10;
		int total = goodsService.getGoodsNum();
		Integer id = goods.getId();
		String name = goods.getName();
		Integer status = goods.getStatus();
		//从第一页开始，按每页10条数据获取符合条件的商品对象列表
		List<Goods> rows = goodsService.getPageGoodsByGoods(id, name, status, pageNum, pageSize);
		GoodsGrid goodsGrid = new GoodsGrid();
		Goods searchgoods = new Goods();
		//封装选择条件商品，显示到搜索栏框
		searchgoods.setId(id);
		searchgoods.setName(name);
		searchgoods.setStatus(status);
		//封装goodsGrid
		goodsGrid.setCurrent(pageNum);
		goodsGrid.setRowCount(pageSize);
		goodsGrid.setRows(rows);
		goodsGrid.setTotal(total);
		mv.addObject("goodsGrid", goodsGrid);
		mv.addObject("searchgoods", searchgoods);
		mv.setViewName("admin/goods/goods_list");
		return mv;
	}

	/**
	 * 商品分类可视图
	 * @return
	 */
	@RequestMapping(value = "/goodsCategoryList")
	@ResponseBody
	public ModelAndView getGoodsCategoryList() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("admin/category/category_list");
		return modelAndView;
	}

	/*********************************************************
	 * 订单管理 1.查找所有订单 2.查看订单 3.修改订单 4.删除订单 5.查询订单 kath
	 * 
	 **********************************************************/

	/**
	 * 查找所有订单  √
	 * @param pageNum
	 *
	 * */
	@RequestMapping(value = "/ordersList")
	@ResponseBody
	public ModelAndView getOrdersList(@RequestParam("pageNum") int pageNum) {
		ModelAndView modelAndView = new ModelAndView();
		int pageSize = 10;
		int total = ordersService.getOrdersNum();
		//获取当前页面订单对象列表
		List<Orders> rows = ordersService.getPageOrders(pageNum, pageSize);
		//封装订单列表ordersGrid
		OrdersGrid ordersGrid = new OrdersGrid();
		ordersGrid.setCurrent(pageNum);
		ordersGrid.setRowCount(pageSize);
		ordersGrid.setRows(rows);
		ordersGrid.setTotal(total);
		modelAndView.addObject("ordersGrid", ordersGrid);
		modelAndView.setViewName("admin/orders/orders_list");
		return modelAndView;
	}

	/**
	 * modal查看选择订单  √
	 * @param request  (orderid,orderNum,orderInformation,orderPrice,orderDate,orderState)
	 *
	 *
	 * */
	@RequestMapping(value = "/getOrders")
	@ResponseBody
	public Orders getOrders(HttpServletRequest request) {
		String id = request.getParameter("id");
		Orders orders = ordersService.getOrdersById(Integer.parseInt(id));
		//返回该订单
		return orders;
	}

	/**
	 * 修改订单  √
	 * @param orders
	 *(orderNum,orderInformation,orderPrice,orderDate,orderState)
	 *
	 *
	 * */
	@RequestMapping(value = "/updateOrders", method = RequestMethod.POST)
	@ResponseBody
	public String updateOrders(HttpServletRequest request, Orders orders) {
		int id = orders.getId();
		//取出原订单
		Orders oldorders = ordersService.getOrdersById(id);
		//将原订单的用户属性和商品属性封装到一个新的订单对象
		orders.setGoodsId(oldorders.getGoodsId());
		orders.setUserId(oldorders.getUserId());
		//获取该订单对应的商品
		Goods goods=goodsService.getGoodsById(oldorders.getGoods().getId());
		//判断前端传来的订单状态数据与原订单状态数据是否相同
		if (oldorders.getOrderState() != orders.getOrderState()) {
			Float balance = orders.getOrderPrice();
			if (orders.getOrderState() == 3) {
				//如果订单已完成，卖家钱包加上商品价格
				purseService.updatePurseByuserId(goods.getUserId(), balance);
			} else {
				//前端传来的数据是将已完成状态修改，卖家减去商品价格
				purseService.updatePurseOfdel(goods.getUserId(), balance);
			}
		}
		try {
			//更新订单信息
			ordersService.updateByPrimaryKey(id, orders);
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"保存失败!\"}";
		}
		return "{\"success\":true,\"msg\":\"保存成功!\"}";
	}

	/**
	 * 删除订单   √
	 * 可能批量处理
	 *
	 *
	 * */
	@RequestMapping(value = "/deleteOrders", method = RequestMethod.POST)
	@ResponseBody
	public String deleteOrders(HttpServletRequest request, @RequestParam(value = "ids[]") String[] ids) {
		try {
			for (int i = 0; i < ids.length; i++) {
				ordersService.deleteOrdersByPrimaryKeys(Integer.parseInt(ids[i]));
			}
		} catch (Exception e) {
			return "{\"success\":false,\"msg\":\"删除失败!\"}";
		}
		return "{\"success\":true,\"msg\":\"删除成功!\"}";
	}
	
	/**
	 * 查询订单 √
	 * @param orders  (orderNum,orderInformation,orderState)
	 *
	 *
	 * */
	@RequestMapping(value = "/searchOrders", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView searchOrders(HttpServletRequest request, Orders orders) {
		ModelAndView mv = new ModelAndView();
		int pageNum = 1;
		int pageSize = 10;
		int total = ordersService.getOrdersNum();
		Long orderNum = orders.getOrderNum();
		String orderInformation = orders.getOrderInformation();
		Integer orderState = orders.getOrderState();
		//符合条件的订单对象列表
		List<Orders> rows = ordersService.getPageOrdersByOrders(orderNum, orderInformation, orderState, pageNum, pageSize);
		OrdersGrid ordersGrid = new OrdersGrid();
		Orders searchorders = new Orders();
		//封装选择条件的对象，显示到搜索栏
		searchorders.setOrderNum(orderNum);
		searchorders.setOrderInformation(orderInformation);
		searchorders.setOrderState(orderState);
		//封装订单对象列表
		ordersGrid.setCurrent(pageNum);
		ordersGrid.setRowCount(pageSize);
		ordersGrid.setRows(rows);
		ordersGrid.setTotal(total);
		mv.addObject("ordersGrid", ordersGrid);
		mv.addObject("searchorders", searchorders);
		mv.setViewName("admin/orders/orders_list");
		return mv;
	}
	
	
	/*********************************************************
	 * 钱包管理 1.查找所有钱包 2.查看钱包 3.修改钱包 4.删除钱包 5.查询钱包 kath
	 * 
	 **********************************************************/

	/**
	 * 查看全部钱包列表
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/purseList")
	@ResponseBody
	public ModelAndView getPurseList(HttpServletRequest request) {
		int pageNum=Integer.parseInt(request.getParameter("pageNum"));
		ModelAndView modelAndView = new ModelAndView();
		int pageSize = 10;
		int total = purseService.getPurseNum();
		//获取当前页的钱包对象列表
		List<Purse> rows = purseService.getPagePurse(pageNum, pageSize);
		//封装钱包列表对象
		PurseGrid purseGrid = new PurseGrid();
		purseGrid.setCurrent(pageNum);
		purseGrid.setRowCount(pageSize);
		purseGrid.setRows(rows);
		purseGrid.setTotal(total);
		modelAndView.addObject("purseGrid", purseGrid);
		modelAndView.setViewName("admin/purse/purse_list");
		return modelAndView;
	}

	/**
	 *搜索钱包  √
	 * @param purse(userid,state)
	 *
	 *
	 * */
	@RequestMapping(value = "/searchPurse", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView searchPurse(HttpServletRequest request, Purse purse) {
		ModelAndView mv = new ModelAndView();
		//当前页码
		int pageNum = 1;
		//每页条数
		int pageSize = 10;
		//钱包总数
		int total = purseService.getPurseNum();
		Integer userId = purse.getUserId();
		Integer state=purse.getState();
		//符合条件的钱包列表
		List<Purse> rows = purseService.getPagePurseByPurse(userId,state, pageNum, pageSize);
		PurseGrid purseGrid = new PurseGrid();
		Purse searchpurse = new Purse();
		//封装选择条件的钱包，显示到搜索框
		searchpurse.setUserId(userId);
		searchpurse.setState(state);
		//封装钱包表
		purseGrid.setCurrent(pageNum);
		purseGrid.setRowCount(pageSize);
		purseGrid.setRows(rows);
		purseGrid.setTotal(total);
		mv.addObject("purseGrid", purseGrid);
		mv.addObject("searchpurse", searchpurse);
		mv.setViewName("admin/purse/purse_list");
		return mv;
	}
	
	/**
	 * 查看订单  √
	 *
	 *
	 *
	 * */
	@RequestMapping(value = "/getPurse")
	@ResponseBody
	public Purse getPurse(HttpServletRequest request) {
		String id = request.getParameter("id");
		Purse purse = purseService.getPurseById(Integer.parseInt(id));
		return purse;
	}
	

	/**
	 * 通过钱包请求   √
	 * @Param Purse(userId,balance,recharge,withdrawls,state)
	 *
	 * */
	@RequestMapping(value = "/updatePursePass", method = RequestMethod.POST)
	@ResponseBody
	public String updatePursePass(HttpServletRequest request, Purse purse) {
		Float balance=purse.getBalance();
		//设置钱包状态为2，已通过
		purse.setState(2);
		try {
			if(purse.getRecharge()!=null){//充值 充值金额!=null 当前金额=当前金额+充值金额
				Float recharge=purse.getRecharge();
				Float balanceRecharge=balance+recharge;
				purse.setBalance(balanceRecharge);
				purseService.updatePursePassById(purse.getId(),purse);
			}if(purse.getWithdrawals()!=null) {//提现
				Float withdrawals=purse.getWithdrawals();
				Float balanceWithdrawals=balance-withdrawals;
				purse.setBalance(balanceWithdrawals);
				purseService.updatePurseRefuseById(purse.getId(),purse);
			}	
		} 
		catch (Exception e) {
			return "{\"success\":true,\"msg\":\"审核失败，请核对金额!\"}";
		}
		return "{\"success\":true,\"msg\":\"审核成功!\"}";
	}
	
	/**
	 * 不通过
	 *
	 *
	 *
	 * */
	@RequestMapping(value = "/updatePurseRefuse", method = RequestMethod.POST)
	@ResponseBody
	public String updatePurseRefuse(HttpServletRequest request, Purse purse) {
		//设置钱包状态为1，不通过
		purse.setState(1);
		try {
			
		 purseService.updatePurseRefuseById(purse.getId(),purse);
				
		} 
		catch (Exception e) {
			return "{\"success\":true,\"msg\":\"审核失败!\"}";
		}
		return "{\"success\":true,\"msg\":\"审核成功!\"}";
	}
	
	/**
	 * 用户查看审核结果  √
	 *
	 *
	 * */
//	@RequestMapping(value = "/updatePurseState", method = RequestMethod.POST)
//	public ModelAndView updatePurseState(HttpServletRequest request) {
//		 Integer id=Integer.parseInt(request.getParameter("id"));
//		 Purse myPurse= purseService.getPurseById(id);
//		 myPurse.setState(null);
//		 this.purseService.updateByPrimaryKey(id,myPurse);//修改state为null
//		 ModelAndView mv = new ModelAndView();
//		 mv.addObject("myPurse",myPurse);
//		 mv.setViewName("user/purse");
//		 return mv;
//	}
	@RequestMapping(value = "/updatePurseState", method = RequestMethod.POST)
	public ModelAndView updatePurseState(HttpServletRequest request) {
		Integer id=Integer.parseInt(request.getParameter("id"));
		Purse myPurse= purseService.getPurseById(id);
		myPurse.setState(null);
		this.purseService.updateByPrimaryKey(id,myPurse);//修改state为null
		ModelAndView mv = new ModelAndView();
		mv.addObject("myPurse",myPurse);
		mv.setViewName("user/purse");
		return mv;
	}
}