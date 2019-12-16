package com.sec.news.biz.Impl;

import com.sec.news.biz.FrontBiz;
import com.sec.news.dao.Impl.NewDaoImpl;
import com.sec.news.dao.Impl.TypeDaoImpl;
import com.sec.news.dao.NewDao;
import com.sec.news.dao.TypeDao;
import com.sec.news.model.News;
import com.sec.news.model.PageModel;
import com.sec.news.model.Type;

import java.util.ArrayList;
import java.util.List;

public class FrontBizImpl implements FrontBiz {

    NewDao newDao = new NewDaoImpl();
    TypeDao typedao = new TypeDaoImpl();
    @Override
    public ArrayList<News> selectNew() {
        return newDao.selectNews();
    }

    @Override
    public void selectNewByType(PageModel<News> pm, int id) {
        newDao.selectNewsByTypeId(pm,id);
    }

    @Override
    public News selectNewById(int typeid) {
        return newDao.selectByNewsId(typeid);
    }

    @Override
    public void selectNewByPage(PageModel<News> pm) {
        newDao.selectNews(pm);
    }

    @Override
    public int selectNewCount() {
        return newDao.selectNewsCount();
    }

    @Override
    public int selectNewsByIdCount(int typeid) {
        return newDao.selectNewsByIdCount(typeid);
    }

    @Override
    public ArrayList<Type> selectNewsType() {
        return typedao.selectNewsType();
    }

    @Override
    public void selectNewsdim(PageModel<News> pm, String text) {
        newDao.selectNewsdim(pm,text);
    }

    @Override
    public boolean updatcount(int newsid, int count) {
        return newDao.updatecount(newsid, count);
    }

    @Override
    public List<News> selectTopNews(int selectNum) {
        return newDao.selectTopNews(selectNum);
    }

    @Override
    public List<News> selectHotNews(int selectNum) {
        return newDao.selectHotNews(selectNum);
    }

    @Override
    public News selectByNewsId(int newId) {
        return newDao.selectByNewsId(newId);
    }
}
