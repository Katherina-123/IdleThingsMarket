package com.kath.controller;

import org.springframework.stereotype.Controller;

import com.kath.service.CatelogService;

import javax.annotation.Resource;

/**
 * Created by kath on 2021/3/10.
 */
@Controller
public class CatelogController {
    @Resource
    private CatelogService catelogService;

}
