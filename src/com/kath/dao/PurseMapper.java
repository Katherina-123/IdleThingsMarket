package com.kath.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kath.pojo.Purse;

public interface PurseMapper {

	//充值
	public void updatePurseByuserId(Integer userId, Float balance);

	//购物后减少相应金额
	public void updatePurseOfdel(Integer userId, Float balance);

	//为用户添加钱包
	public void addPurse(Integer userId);

	public Purse selectPurseByUserId(Integer user_id);

	public void updatePurse(Purse purse);

	//管理员用
	public List<Purse> selectPurseList();

	public List<Purse> getPagePurseByPurse(@Param("userId")Integer userId,@Param("state")Integer state);

	public Purse selectPurseById(int id);

	public void updateByPrimaryKey(Purse purse);

	public void updatePurseById(Purse purse);

	


}
