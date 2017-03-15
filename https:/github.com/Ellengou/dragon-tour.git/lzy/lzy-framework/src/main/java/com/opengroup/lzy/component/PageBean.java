package com.opengroup.lzy.component;

import java.util.List;
/**
 * 分页工具類
 * @author lc
 *
 * @date 2016年12月31日 下午10:53:50
 */
public class PageBean<T> {

    protected int pageNo;     // 当前页
    protected int total;      // 总记录数
    protected int totalPage;  // 总页数
    protected List<T> rows;   // 数据

    public PageBean() {}

    public PageBean(int total, List<T> rows) {
        this.total = total;
        this.rows = rows;
    }

    public PageBean(int total, List<T> rows, T incidental) {
        this.total = total;
        this.rows = rows;
    }
    
    public PageBean(int pageNo, int total, int totalPage, List<T> rows) {
        this.pageNo = pageNo;
        this.total = total;
        this.totalPage = totalPage;
        this.rows = rows;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public List<?> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }
}
