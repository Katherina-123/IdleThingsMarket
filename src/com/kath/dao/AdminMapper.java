package com.kath.dao;

import com.kath.pojo.Admin;

//只有管理员信息修改的数据处理，用户，订单，商品等都是分开的
public interface AdminMapper {
	
	
	public Admin findAdmin(Long phone, String password);

	public Admin findAdminById(Integer id);

	public void updateAdmin(Admin admins);

}
