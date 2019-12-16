package com.sec.news.admin.biz.Impl;

import com.sec.news.admin.biz.UserBiz;
import com.sec.news.dao.Impl.UserDaoImpl;
import com.sec.news.dao.UserDao;
import com.sec.news.model.User;

/**
 * @author zdy
 * @site XXX
 * @company XXX公司
 * @create 2019-11-20-17:15
 */
public class UserBizImpl implements UserBiz{

    private UserDao userDao = new UserDaoImpl();

    @Override
    public boolean adminLogin(User user) {
        return userDao.validateUser(user);
    }

    @Override
    public boolean updateUserInfo(User user) {
        return userDao.updateUser(user);
    }
}
