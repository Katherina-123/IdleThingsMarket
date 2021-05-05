package com.kath.dao;

import java.util.List;

import com.kath.pojo.Notice;

public interface NoticeMapper {

    int insertSelective(Notice record);

	public List<Notice> getNoticeList();

}