package com.kath.service.impl;

import com.kath.dao.ImageMapper;
import com.kath.pojo.Image;
import com.kath.service.ImageService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;



@Service("imageService")
public class ImageServiceImpl implements ImageService {
    @Resource
    private ImageMapper imageMapper;
    //添加图片
    public int insert(Image record) {
        return imageMapper.insert(record);
    }
    //查找图片
    public List<Image> getImagesByGoodsPrimaryKey(Integer goodsId) {
        List<Image> image = imageMapper.selectByGoodsPrimaryKey(goodsId);
        return image;
    }
    public int deleteImagesByGoodsPrimaryKey(Integer goodsId) {
        return imageMapper.deleteImagesByGoodsPrimaryKey(goodsId);
    }
}
