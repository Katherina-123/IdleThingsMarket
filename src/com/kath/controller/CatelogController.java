package com.kath.controller;

import org.springframework.stereotype.Controller;

import com.kath.service.CatelogService;

import javax.annotation.Resource;

/**
 * Created by lenovo on 2017/5/9.
 */
@Controller
public class CatelogController {
    @Resource
    private CatelogService catelogService;

}
