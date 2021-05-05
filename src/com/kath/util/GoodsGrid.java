package com.kath.util;

import javax.xml.bind.annotation.XmlRootElement;

import com.kath.pojo.Goods;

import java.util.List;

/**
 * Created by kath on 2021/4/26.
 */

@XmlRootElement
//管理员操作商品表工具类
public class GoodsGrid {
    private int current;//当前页面号
    private int rowCount;//每页行数
    private int total;//总行数
    private List<Goods> rows;

    public int getCurrent() {
        return current;
    }

    public void setCurrent(int current) {
        this.current = current;
    }

    public int getRowCount() {
        return rowCount;
    }

    public void setRowCount(int rowCount) {
        this.rowCount = rowCount;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<Goods> getRows() {
        return rows;
    }

    public void setRows(List<Goods> rows) {
        this.rows = rows;
    }
}
