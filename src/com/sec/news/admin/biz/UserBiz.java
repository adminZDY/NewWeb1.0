package com.sec.news.admin.biz;

import com.sec.news.model.User;

/**
 * @author zdy
 * @site XXX
 * @company XXX公司
 * @create 2019-11-20-17:15
 */
public interface UserBiz {

    /**
     * 后台用户登录验证
     * @param user
     * @return 是否正确
     */
    public boolean adminLogin(User user);

    /**
     * 后台用户修改
     * @param user
     * @return 是否修改成功
     */
    public boolean updateUserInfo(User user);


}
