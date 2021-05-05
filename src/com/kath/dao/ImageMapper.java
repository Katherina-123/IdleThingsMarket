package com.kath.dao;

import java.util.List;

import com.kath.pojo.Image;

public interface ImageMapper {
    int deleteByPrimaryKey(Integer id);

    //删除商品时根据商品id删除图片
    int deleteImagesByGoodsPrimaryKey(Integer goodsId);

    int insert(Image record);

    int insertSelective(Image record);

    Image selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Image record);

    int updateByPrimaryKeyWithBLOBs(Image record);

    int updateByPrimaryKey(Image record);

    //根据商品id遍历商品图片
    List<Image> selectByGoodsPrimaryKey(Integer goodsId);
}