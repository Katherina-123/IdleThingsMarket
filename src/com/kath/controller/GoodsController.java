package com.kath.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kath.pojo.Catelog;
import com.kath.pojo.CommentExtend;
import com.kath.pojo.Comments;
import com.kath.pojo.Goods;
import com.kath.pojo.GoodsExtend;
import com.kath.pojo.Image;
import com.kath.pojo.Purse;
import com.kath.pojo.User;
import com.kath.service.CatelogService;
import com.kath.service.GoodsService;
import com.kath.service.ImageService;
import com.kath.service.PurseService;
import com.kath.service.UserService;
import com.kath.util.DateUtil;


@Controller
@RequestMapping(value = "/goods")
public class GoodsController {
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private ImageService imageService;
	@Autowired
	private CatelogService catelogService;
	@Autowired
	private UserService userService;
	@Resource
	private PurseService purseService;
	

	/**
	 * 首页显示商品，每一类商品查询6件，根据最新上架排序 key的命名为catelogGoods1、catelogGoods2....
	 *   √
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/homeGoods")
	public ModelAndView homeGoods() throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		// 商品种类数量
		int catelogSize = 7;
		// 每个种类显示商品数量
		int goodsSize = 6;

		List<Goods> goodsList = null;
		List<GoodsExtend> goodsAndImage = null;

//		 获取最新发布列表，数量为6
		goodsList = goodsService.getGoodsOrderByDate(goodsSize);
		goodsAndImage = new ArrayList<GoodsExtend>();
		for (int j = 0; j < goodsList.size(); j++) {
			// 将用户信息和image信息封装到GoodsExtend类中，传给前台
			GoodsExtend goodsExtend = new GoodsExtend();
			Goods goods = goodsList.get(j);
			List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
			goodsExtend.setGoods(goods);
			goodsExtend.setImages(images);
			goodsAndImage.add(j, goodsExtend);
		}
		String key0 = "catelog" + "Goods";
		modelAndView.addObject(key0, goodsAndImage);

		/* 获取其他列表物品信息，数量为6 */
		for (int i = 1; i <= catelogSize; i++) {
			goodsList = goodsService.getGoodsByCatelogOrderByDate(i, goodsSize);
			goodsAndImage = new ArrayList<GoodsExtend>();
			for (int j = 0; j < goodsList.size(); j++) {
				// 将用户信息和image信息封装到GoodsExtend类中，传给前台
				GoodsExtend goodsExtend = new GoodsExtend();
				Goods goods = goodsList.get(j);
				List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
				goodsExtend.setGoods(goods);
				goodsExtend.setImages(images);
				goodsAndImage.add(j, goodsExtend);
			}
			String key = "catelog" + "Goods" + i;
			//前台items="${catelogGoods1}数据传递
			//key = “catelogGoods1”
			modelAndView.addObject(key, goodsAndImage);
		}
		modelAndView.setViewName("goods/homeGoods");
		return modelAndView;
	}

	/**
	 * 搜索商品   √
	 * 
	 * @param str          //ajax传值
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/search")
	public ModelAndView searchGoods(@RequestParam(value = "str", required = false) String str) throws Exception {
		List<Goods> goodsList = goodsService.searchGoods(str, str);
		List<GoodsExtend> goodsExtendList = new ArrayList<GoodsExtend>();
		for (int i = 0; i < goodsList.size(); i++) {
			GoodsExtend goodsExtend = new GoodsExtend();
			//将查询出来的商品赋给goods
			Goods goods = goodsList.get(i);
			//根据商品ID获取图片
			List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(goods.getId());
			//goods->goodsExtend，展出图片
			goodsExtend.setGoods(goods);
			goodsExtend.setImages(imageList);
			//将所有查询出来的商品放入goodsExtendList
			goodsExtendList.add(i, goodsExtend);
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("goodsExtendList", goodsExtendList);
		//搜索框id="search"，name="str"
		modelAndView.addObject("search", str);
		modelAndView.setViewName("/goods/searchGoods");
		return modelAndView;
	}

	/**
	 * 获取最新商品  √
	 * 
	 * @param str
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/catelog")
	public ModelAndView homeGoods(HttpServletRequest request, @RequestParam(value = "str", required = false) String str)
			throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		// 显示的商品数量
		int goodsSize = 12;
		List<Goods> goodsList = null;
		List<GoodsExtend> goodsAndImage = null;
		// 获取最新发布列表
		goodsList = goodsService.getGoodsByStr(goodsSize, str, str);
		goodsAndImage = new ArrayList<GoodsExtend>();
		for (int j = 0; j < goodsList.size(); j++) {
			// 将商品信息和image信息封装到GoodsExtend类中，传给前台
			GoodsExtend goodsExtend = new GoodsExtend();
			Goods goods = goodsList.get(j);
			List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
			goodsExtend.setGoods(goods);
			goodsExtend.setImages(images);
			goodsAndImage.add(j, goodsExtend);
		}
		modelAndView.addObject("goodsExtendList", goodsAndImage);
		modelAndView.addObject("search", str);
		modelAndView.setViewName("/goods/catelogGoods");
		return modelAndView;
	}

	/**
	 * 查询该类商品    √
	 * 
	 * @param id
	 *            要求该参数不为空  str,required=false
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/catelog/{id}")
	//	@PathVariable 可以将URL中占位符参数{xxx}绑定到处理器类的方法形参中@PathVariable(“xxx“)
	public ModelAndView catelogGoods(HttpServletRequest request, @PathVariable("id") Integer id,
			@RequestParam(value = "str", required = false) String str) throws Exception {
		//传入的str是null,id是catelog的id
		List<Goods> goodsList = goodsService.getGoodsByCatelog(id, str, str);
		//根据分类id获取catelog
		Catelog catelog = catelogService.selectByPrimaryKey(id);
		List<GoodsExtend> goodsExtendList = new ArrayList<GoodsExtend>();
		for (int i = 0; i < goodsList.size(); i++) {
			GoodsExtend goodsExtend = new GoodsExtend();
			Goods goods = goodsList.get(i);
			//获取每个商品图片
			List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(goods.getId());
			//封装goodsextend
			goodsExtend.setGoods(goods);
			goodsExtend.setImages(imageList);
			goodsExtendList.add(i, goodsExtend);
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("goodsExtendList", goodsExtendList);
		modelAndView.addObject("catelog", catelog);
//		modelAndView.addObject("search", str);
		modelAndView.setViewName("/goods/catelogGoods");
		return modelAndView;
	}

	/**
	 * 根据商品id查询该商品详细信息  √
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goodsId/{id}")
//	@PathVariable 可以将URL中占位符参数{xxx}绑定到处理器类的方法形参中@PathVariable(“xxx“)
//	@RequestParam用于将请求参数区数据映射到功能处理方法的参数上。
	public ModelAndView getGoodsById(HttpServletRequest request, @PathVariable("id") Integer id,
			@RequestParam(value = "str", required = false) String str) throws Exception {
		//具体商品
		Goods goods = goodsService.getGoodsByPrimaryKey(id);
		//通过goods.getUserId获取商品卖家
		User seller = userService.selectByPrimaryKey(goods.getUserId());
		//商品分类
		Catelog catelog = catelogService.selectByPrimaryKey(goods.getCatelogId());
		//GoodsExtend获取商品图片和评论
		GoodsExtend goodsExtend = new GoodsExtend();
		List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(id);
		CommentExtend CommentExtend=goodsService.selectCommentsByGoodsId(id);
		goodsExtend.setGoods(goods);
		goodsExtend.setImages(imageList);

		//添加数据
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("CommentExtend",CommentExtend);
		modelAndView.addObject("goodsExtend", goodsExtend);
		modelAndView.addObject("seller", seller);
		modelAndView.addObject("search", str);
		modelAndView.addObject("catelog", catelog);
		modelAndView.setViewName("/goods/detailGoods");
		return modelAndView;

	}
	
	 /**
	  * ajax请求
     * 发布评论   √
     * @return 
     */
    @RequestMapping(value = "/addComments",method=RequestMethod.POST)
	public void addComments(HttpServletRequest request,Comments comments) {
    	//请求里传入了goodsId和content
    	User cur_user = (User)request.getSession().getAttribute("cur_user");
    	//评论用户
        comments.setUser(cur_user);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        Date createAt =new Date();
        //评论发布时间
		comments.setCreateAt(sdf.format(createAt));
        goodsService.addComments(comments);
       
	}

	/**
	 * 修改商品信息
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editGoods/{id}")
	public ModelAndView editGoods(HttpServletRequest request,@PathVariable("id") Integer id) throws Exception {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Goods goods = goodsService.getGoodsByPrimaryKey(id);
		List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(id);
		GoodsExtend goodsExtend = new GoodsExtend();
		goodsExtend.setGoods(goods);
		goodsExtend.setImages(imageList);
		ModelAndView modelAndView = new ModelAndView();
		Integer userId = cur_user.getId();
		Purse myPurse = purseService.getPurseByUserId(userId);
		modelAndView.addObject("myPurse", myPurse);
		// 将商品信息添加到model
		modelAndView.addObject("goodsExtend", goodsExtend);
		modelAndView.setViewName("/goods/editGoods");
		return modelAndView;
	}

	/**
	 * 提交商品更改信息
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editGoodsSubmit")
	public String editGoodsSubmit(HttpServletRequest request, Goods goods) throws Exception {
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		goods.setUserId(cur_user.getId());
		String polish_time = DateUtil.getNowDay();
		goods.setPolishTime(polish_time);
		goods.setStatus(1);
		goodsService.updateGoodsByPrimaryKeyWithBLOBs(goods.getId(), goods);
		return "user/goods";
	}

	/**
	 * 商品下架
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/offGoods")
	public ModelAndView offGoods() throws Exception {

		return null;
	}

	/**
	 * 用户删除商品
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteGoods/{id}")
	public String deleteGoods(HttpServletRequest request, @PathVariable("id") Integer id) throws Exception {
		Goods goods = goodsService.getGoodsByPrimaryKey(id);
		// 删除商品后，catlog的number-1，user表的goods_num-1，image删除,更新session的值
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		goods.setUserId(cur_user.getId());
		int number = cur_user.getGoodsNum();
		Integer calelog_id = goods.getCatelogId();
		Catelog catelog = catelogService.selectByPrimaryKey(calelog_id);
		catelogService.updateCatelogNum(calelog_id, catelog.getNumber() - 1);
		userService.updateGoodsNum(cur_user.getId(), number - 1);
		cur_user.setGoodsNum(number - 1);
		request.getSession().setAttribute("cur_user", cur_user);// 修改session值
		//imageService.deleteImagesByGoodsPrimaryKey(id);
		goodsService.deleteGoodsByPrimaryKey(id);
		return "user/goods";
	}

	/**
	 * 发布商品 将用户钱包数据传给前台并转到发布商品页面   √
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/publishGoods")
	public ModelAndView publishGoods(HttpServletRequest request) {
		// 获取当前用户
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		Integer userId = cur_user.getId();
		Purse myPurse = purseService.getPurseByUserId(userId);
		ModelAndView mv = new ModelAndView();
		//传递钱包数据，发布物品页面显示钱包数据
		mv.addObject("myPurse", myPurse);
		mv.setViewName("/goods/pubGoods");
		return mv;
	}

	/**
	 * 提交发布的商品信息   发布按钮后提交表单的请求  √
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/publishGoodsSubmit")
//	MultipartFile是spring类型，代表HTML中form data方式上传的文件，包含二进制数据+文件名称。
//	public String publishGoodsSubmit(HttpServletRequest request, Image ima, Goods goods, MultipartFile image)

	public String publishGoodsSubmit(HttpServletRequest request, Image ima, Goods goods)
			throws Exception {
		// 查询出当前用户cur_user对象，便于使用id
		User cur_user = (User) request.getSession().getAttribute("cur_user");
		goods.setUserId(cur_user.getId());
		goodsService.addGood(goods, 10);// 在goods表中插入物品
		// 返回插入的该物品的id
		int goodsId = goods.getId();
		ima.setGoodsId(goodsId);
		imageService.insert(ima);// 在image表中插入商品图片
		// 发布商品后，catlog的number+1，user表的goods_num+1，更新session的值
		int number = cur_user.getGoodsNum();
		Integer calelog_id = goods.getCatelogId();
		Catelog catelog = catelogService.selectByPrimaryKey(calelog_id);
		catelogService.updateCatelogNum(calelog_id, catelog.getNumber() + 1);
		userService.updateGoodsNum(cur_user.getId(), number + 1);
		cur_user.setGoodsNum(number + 1);
		request.getSession().setAttribute("cur_user", cur_user);// 修改session值，因为当前用户有数据修改
		return "goods/pubGoods";
	}

	/**
	 * 上传物品
	 * 
	 * @param session
	 * @param myfile
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadFile")
	public Map<String, Object> uploadFile(HttpSession session, MultipartFile myfile)
			throws IllegalStateException, IOException {
			// 原始名称
			String oldFileName = myfile.getOriginalFilename(); // 获取上传文件的原名
			// 存储图片的物理路径
			String file_path = session.getServletContext().getRealPath("upload");
			// System.out.println("file_path:"+file_path);
			// 上传图片
			if (myfile != null && oldFileName != null && oldFileName.length() > 0) {
				// 新的图片名称
				String newFileName = UUID.randomUUID() + oldFileName.substring(oldFileName.lastIndexOf("."));
				// 新图片
				File newFile = new File(file_path + "/" + newFileName);
				// 将内存中的数据写入磁盘
				myfile.transferTo(newFile);
				// 将新图片名称返回到前端
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("success", "成功啦");
				map.put("imgUrl", newFileName);
				return map;
			} else {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("error", "图片不合法");
				return map;
			}
		}

	/**
	 * 根据商品id查询该商品详细信息  √
	 * 
	 * @param id  商品id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyId/{id}")
	public ModelAndView getGoodsdetailById(HttpServletRequest request, @PathVariable("id") Integer id)
			throws Exception {
       //封装商品
		Goods goods = goodsService.getGoodsByPrimaryKey(id);
		GoodsExtend goodsExtend = new GoodsExtend();
		List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(id);
		goodsExtend.setGoods(goods);
		goodsExtend.setImages(imageList);
       //封装用户
		User cur_user = (User)request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();
		Purse myPurse=purseService.getPurseByUserId(userId);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("goodsExtend", goodsExtend);
		modelAndView.addObject("myPurse",myPurse);
		modelAndView.setViewName("/user/pay");
		return modelAndView;
	}
	
}