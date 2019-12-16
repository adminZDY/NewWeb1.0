package com.sec.news.dao;

import com.sec.news.model.User;

public interface UserDao {

    /**
     * 注册用户
     * @param user
     * @return
     */
    public boolean insertUser(User user);

    /**
     * 删除用户
     * @param id 用户编号
     * @return
     */
    @Deprecated
    public boolean deleteUser(int id);

    /**
     * 修改用户信息
     * @param user
     * @return
     */
	public boolean updateUser(User user);

    /**
     * 注册语句1
     * 查询是否存在该用户名
     * @param username
     * @return 是否存在，统计行数
     */
    public boolean existsUser(String username);

    /**
     * 登录
     * 验证用户是否存在(顺便将对象初始化)
     * @param user 提供用户名和密码，系统自动查询ID
     * @return 返回User对象
     */
    public boolean validateUser(User user);

    /**
     * 通过用户Id查询用户信息
     * @param userId 提供整型Id即可
     * @return 返回User对象
     */
    public User selectUserById(int userId);
}
