package com.kath.pojo;
/**
 * 商品拓展 联合查询
 * @author kath
 *
 */
import java.util.List;
//继承Goods类
public class CommentExtend extends Goods{
    private List<Comments> comments;
	public List<Comments> getComments() {
		return comments;
	}
	public void setComments(List<Comments> comments) {
		this.comments = comments;
	}
	
	
}