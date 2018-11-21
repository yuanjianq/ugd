package com.gfan.report.frame.dao;

import com.gfan.report.frame.module.UserPwd;
import com.gfan.report.frame.module.UserPwdExample;
import java.util.List;

public interface UserPwdDAO {
    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table user_pwd
     *
     * @ibatorgenerated Wed Apr 29 15:46:44 CST 2015
     */
    int countByExample(UserPwdExample example);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table user_pwd
     *
     * @ibatorgenerated Wed Apr 29 15:46:44 CST 2015
     */
    int deleteByExample(UserPwdExample example);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table user_pwd
     *
     * @ibatorgenerated Wed Apr 29 15:46:44 CST 2015
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table user_pwd
     *
     * @ibatorgenerated Wed Apr 29 15:46:44 CST 2015
     */
    void insert(UserPwd record);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table user_pwd
     *
     * @ibatorgenerated Wed Apr 29 15:46:44 CST 2015
     */
    void insertSelective(UserPwd record);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table user_pwd
     *
     * @ibatorgenerated Wed Apr 29 15:46:44 CST 2015
     */
    List selectByExample(UserPwdExample example);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table user_pwd
     *
     * @ibatorgenerated Wed Apr 29 15:46:44 CST 2015
     */
    UserPwd selectByPrimaryKey(Integer id);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table user_pwd
     *
     * @ibatorgenerated Wed Apr 29 15:46:44 CST 2015
     */
    int updateByExampleSelective(UserPwd record, UserPwdExample example);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table user_pwd
     *
     * @ibatorgenerated Wed Apr 29 15:46:44 CST 2015
     */
    int updateByExample(UserPwd record, UserPwdExample example);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table user_pwd
     *
     * @ibatorgenerated Wed Apr 29 15:46:44 CST 2015
     */
    int updateByPrimaryKeySelective(UserPwd record);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table user_pwd
     *
     * @ibatorgenerated Wed Apr 29 15:46:44 CST 2015
     */
    int updateByPrimaryKey(UserPwd record);
}