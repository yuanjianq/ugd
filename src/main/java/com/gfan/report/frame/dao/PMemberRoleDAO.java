package com.gfan.report.frame.dao;

import com.gfan.report.frame.module.PMemberRole;
import com.gfan.report.frame.module.PMemberRoleExample;
import java.util.List;

public interface PMemberRoleDAO {
    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table p_member_role
     *
     * @ibatorgenerated Wed Apr 29 16:17:26 CST 2015
     */
    int countByExample(PMemberRoleExample example);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table p_member_role
     *
     * @ibatorgenerated Wed Apr 29 16:17:26 CST 2015
     */
    int deleteByExample(PMemberRoleExample example);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table p_member_role
     *
     * @ibatorgenerated Wed Apr 29 16:17:26 CST 2015
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table p_member_role
     *
     * @ibatorgenerated Wed Apr 29 16:17:26 CST 2015
     */
    void insert(PMemberRole record);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table p_member_role
     *
     * @ibatorgenerated Wed Apr 29 16:17:26 CST 2015
     */
    void insertSelective(PMemberRole record);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table p_member_role
     *
     * @ibatorgenerated Wed Apr 29 16:17:26 CST 2015
     */
    List selectByExample(PMemberRoleExample example);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table p_member_role
     *
     * @ibatorgenerated Wed Apr 29 16:17:26 CST 2015
     */
    PMemberRole selectByPrimaryKey(Integer id);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table p_member_role
     *
     * @ibatorgenerated Wed Apr 29 16:17:26 CST 2015
     */
    int updateByExampleSelective(PMemberRole record, PMemberRoleExample example);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table p_member_role
     *
     * @ibatorgenerated Wed Apr 29 16:17:26 CST 2015
     */
    int updateByExample(PMemberRole record, PMemberRoleExample example);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table p_member_role
     *
     * @ibatorgenerated Wed Apr 29 16:17:26 CST 2015
     */
    int updateByPrimaryKeySelective(PMemberRole record);

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table p_member_role
     *
     * @ibatorgenerated Wed Apr 29 16:17:26 CST 2015
     */
    int updateByPrimaryKey(PMemberRole record);
}