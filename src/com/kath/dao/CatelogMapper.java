package com.kath.dao;

import org.apache.ibatis.annotations.Param;

import com.kath.pojo.Catelog;

import java.util.List;

public interface CatelogMapper {
    //管理员未使用到delete和insert功能
    int deleteByPrimaryKey(Integer id);

    int insert(Catelog record);

    int insertSelective(Catelog record);

    Catelog selectByPrimaryKey(Integer id);//根据商品类别查询商品

    int updateByPrimaryKeySelective(Catelog record);

    int updateByPrimaryKey(Catelog record);

    int updateCatelogNum(@Param("id") Integer id,@Param("number") Integer number);

    List<Catelog> getAllCatelog();//查询所有正常商品类别

    int getCount(Catelog catelog);

}