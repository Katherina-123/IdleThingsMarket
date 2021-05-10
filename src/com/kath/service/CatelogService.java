package com.kath.service;

import java.util.List;

import com.kath.pojo.Catelog;

/**
 * Created by kath on 2021/4/9.
 */
public interface CatelogService {
    public List<Catelog> getAllCatelog();
    public int getCount(Catelog catelog);
    Catelog selectByPrimaryKey(Integer id);
    int updateByPrimaryKey(Catelog record);
    int updateCatelogNum(Integer id,Integer number);
}
