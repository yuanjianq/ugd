/*
Navicat MySQL Data Transfer

Source Server         : 10.8.8.57_ugd
Source Server Version : 50505
Source Host           : 10.8.8.57:3306
Source Database       : game_channel

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2016-04-22 15:26:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for corp_partner_user
-- ----------------------------
DROP TABLE IF EXISTS `corp_partner_user`;
CREATE TABLE `corp_partner_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '合作者用户id,此处存的id是后台身份系统返回的id',
  `partner_id` int(11) DEFAULT NULL COMMENT '合作方id',
  `phone_no` varchar(18) CHARACTER SET utf8 DEFAULT NULL COMMENT '联系电话',
  `email` varchar(128) CHARACTER SET utf8 DEFAULT NULL COMMENT '邮箱',
  `name` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '合作者姓名',
  `status` tinyint(4) DEFAULT NULL COMMENT '用户状态：0初始化、1正常、2禁用、3删除',
  `channel_id` int(11) DEFAULT NULL COMMENT '渠道id',
  `admin` tinyint(4) DEFAULT NULL COMMENT '是否是管理员',
  `tag_id` int(11) DEFAULT NULL COMMENT '用户所属等级（若合作者是管理员，则他没有等级，此处存0）',
  `managed` tinyint(2) DEFAULT NULL COMMENT '合作者是否受合作管理平台管理 true 受管理，false不受管理',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  KEY `partner_id` (`partner_id`),
  KEY `channel_id` (`channel_id`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='合作用户信息表：合作方账号信息，仅维护合作信息，账号信息使用<后台身份系统>';

-- ----------------------------
-- Records of corp_partner_user
-- ----------------------------

-- ----------------------------
-- Table structure for fact_channel
-- ----------------------------
DROP TABLE IF EXISTS `fact_channel`;
CREATE TABLE `fact_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(255) DEFAULT NULL,
  `DATA_TIME` varchar(255) NOT NULL DEFAULT '',
  `CHANNEL_CODE` varchar(255) NOT NULL DEFAULT '' COMMENT '渠道编码',
  `CHANNEL_NAME` varchar(255) DEFAULT NULL COMMENT '渠道名称',
  `DAY_ACTIVATE_COUNT` int(11) DEFAULT NULL COMMENT '每日新增人数',
  `DAY_ACTIVATE_DIS` int(11) DEFAULT '0' COMMENT '扣量后人数',
  `REMAIN2_RATE` varchar(255) DEFAULT NULL COMMENT '次日留存率',
  `REMAIN7_RATE` varchar(255) DEFAULT NULL COMMENT '7日留存率',
  `INSERT_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`DATA_TIME`,`CHANNEL_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=39757 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fact_channel
-- ----------------------------
INSERT INTO `fact_channel` VALUES ('496', '110000355', '2015-07-06', '2015051802', '华友数码', '0', '0', '-', '-', '2015-07-15 19:05:40');
INSERT INTO `fact_channel` VALUES ('560', '110000345', '2015-07-10', '2015071001', 'wifi渠道', '2', '1', '0.00%', '0.00%', '2015-07-16 14:00:02');
INSERT INTO `fact_channel` VALUES ('561', '110000345', '2015-07-11', '2015071001', 'wifi渠道', '0', '0', '-', '-', '2015-07-16 14:00:02');
INSERT INTO `fact_channel` VALUES ('562', '110000345', '2015-07-12', '2015071001', 'wifi渠道', '0', '0', '-', '-', '2015-07-16 14:00:02');
INSERT INTO `fact_channel` VALUES ('563', '110000345', '2015-07-13', '2015071001', 'wifi渠道', '110', '88', '58.18%', '20.91%', '2015-07-16 14:00:02');
INSERT INTO `fact_channel` VALUES ('564', '110000345', '2015-07-14', '2015071001', 'wifi渠道', '128', '102', '46.88%', '14.06%', '2015-07-16 14:00:02');
INSERT INTO `fact_channel` VALUES ('565', '110000345', '2015-07-15', '2015071001', 'wifi渠道', '141', '112', '36.17%', '11.35%', '2015-07-16 14:00:02');
INSERT INTO `fact_channel` VALUES ('567', '110000346', '2015-07-10', '2015071002', 'wifi渠道', '31', '24', '51.61%', '32.26%', '2015-07-16 14:00:03');
INSERT INTO `fact_channel` VALUES ('568', '110000346', '2015-07-11', '2015071002', 'wifi渠道', '103', '82', '34.95%', '23.30%', '2015-07-16 14:00:03');
INSERT INTO `fact_channel` VALUES ('569', '110000346', '2015-07-12', '2015071002', 'wifi渠道', '84', '67', '35.71%', '14.29%', '2015-07-16 14:00:03');
INSERT INTO `fact_channel` VALUES ('570', '110000346', '2015-07-13', '2015071002', 'wifi渠道', '77', '61', '50.65%', '18.18%', '2015-07-16 14:00:03');
INSERT INTO `fact_channel` VALUES ('571', '110000346', '2015-07-14', '2015071002', 'wifi渠道', '310', '248', '52.26%', '17.42%', '2015-07-16 14:00:03');
INSERT INTO `fact_channel` VALUES ('572', '110000346', '2015-07-15', '2015071002', 'wifi渠道', '490', '392', '44.90%', '14.29%', '2015-07-16 14:00:03');
INSERT INTO `fact_channel` VALUES ('574', '110000347', '2015-07-10', '2015071003', 'banner推荐', '269', '215', '40.89%', '0.00%', '2015-07-16 14:00:03');
INSERT INTO `fact_channel` VALUES ('575', '110000347', '2015-07-11', '2015071003', 'banner推荐', '315', '252', '41.90%', '0.00%', '2015-07-16 14:00:03');
INSERT INTO `fact_channel` VALUES ('576', '110000347', '2015-07-12', '2015071003', 'banner推荐', '330', '264', '41.52%', '0.00%', '2015-07-16 14:00:03');

-- ----------------------------
-- Table structure for log_function_click
-- ----------------------------
DROP TABLE IF EXISTS `log_function_click`;
CREATE TABLE `log_function_click` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '用户编号',
  `USER_NAME` varchar(64) DEFAULT NULL COMMENT '用户名',
  `USER_IP` varchar(32) DEFAULT NULL COMMENT '用户IP',
  `FUNCTION_ID` int(11) DEFAULT NULL,
  `FUNCTION_NAME` varchar(64) DEFAULT NULL,
  `LOG_TIME` datetime DEFAULT NULL COMMENT '登录时间',
  `INSERT_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '插入时间',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=13114 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log_function_click
-- ----------------------------
INSERT INTO `log_function_click` VALUES ('3854', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '23', '单机游戏统计', '2015-06-23 20:09:47', '2015-06-23 20:09:47');
INSERT INTO `log_function_click` VALUES ('3855', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '24', '联运游戏统计', '2015-06-23 20:09:49', '2015-06-23 20:09:49');
INSERT INTO `log_function_click` VALUES ('3856', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '23', '单机游戏统计', '2015-06-23 20:09:50', '2015-06-23 20:09:50');
INSERT INTO `log_function_click` VALUES ('3857', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '24', '联运游戏统计', '2015-06-23 20:09:51', '2015-06-23 20:09:51');
INSERT INTO `log_function_click` VALUES ('3858', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '23', '单机游戏统计', '2015-06-23 20:09:52', '2015-06-23 20:09:52');
INSERT INTO `log_function_click` VALUES ('3859', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '24', '联运游戏统计', '2015-06-23 20:09:54', '2015-06-23 20:09:54');
INSERT INTO `log_function_click` VALUES ('3860', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '23', '单机游戏统计', '2015-06-23 20:11:38', '2015-06-23 20:11:38');
INSERT INTO `log_function_click` VALUES ('3861', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '24', '联运游戏统计', '2015-06-23 20:11:45', '2015-06-23 20:11:45');
INSERT INTO `log_function_click` VALUES ('3862', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '23', '单机游戏统计', '2015-06-23 20:11:54', '2015-06-23 20:11:54');
INSERT INTO `log_function_click` VALUES ('3863', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '24', '联运游戏统计', '2015-06-23 20:12:05', '2015-06-23 20:12:05');
INSERT INTO `log_function_click` VALUES ('3864', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '23', '单机游戏统计', '2015-06-23 20:12:16', '2015-06-23 20:12:16');
INSERT INTO `log_function_click` VALUES ('3865', 'ceshi01@imopan.com', '测试', '10.8.8.172', '23', '单机游戏统计', '2015-06-24 10:55:14', '2015-06-24 10:55:14');
INSERT INTO `log_function_click` VALUES ('3866', 'ceshi01@imopan.com', '测试', '10.8.8.172', '24', '联运游戏统计', '2015-06-24 11:07:34', '2015-06-24 11:07:34');
INSERT INTO `log_function_click` VALUES ('3867', 'ceshi01@imopan.com', '测试', '10.8.8.172', '24', '联运游戏统计', '2015-06-24 11:08:23', '2015-06-24 11:08:23');
INSERT INTO `log_function_click` VALUES ('3868', 'ceshi01@imopan.com', '测试', '10.8.8.172', '23', '单机游戏统计', '2015-06-24 11:29:29', '2015-06-24 11:29:29');
INSERT INTO `log_function_click` VALUES ('3869', 'ceshi01@imopan.com', '测试', '10.8.8.172', '23', '单机游戏统计', '2015-06-24 11:30:51', '2015-06-24 11:30:51');
INSERT INTO `log_function_click` VALUES ('3870', 'ceshi01@imopan.com', '测试', '10.8.8.172', '23', '单机游戏统计', '2015-06-24 11:31:05', '2015-06-24 11:31:05');
INSERT INTO `log_function_click` VALUES ('3871', 'ceshi01@imopan.com', '测试', '10.8.8.172', '23', '单机游戏统计', '2015-06-24 15:24:23', '2015-06-24 15:24:23');
INSERT INTO `log_function_click` VALUES ('3872', 'ceshi01@imopan.com', '测试', '10.8.8.172', '24', '联运游戏统计', '2015-06-24 15:24:29', '2015-06-24 15:24:29');
INSERT INTO `log_function_click` VALUES ('13108', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '33', '机锋市场渠道数据', '2016-03-22 13:46:51', '2016-03-22 13:46:51');
INSERT INTO `log_function_click` VALUES ('13109', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '24', '联运游戏统计', '2016-03-22 13:46:53', '2016-03-22 13:46:53');
INSERT INTO `log_function_click` VALUES ('13110', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '30', '联运游戏统计admin', '2016-03-22 13:46:54', '2016-03-22 13:46:54');
INSERT INTO `log_function_click` VALUES ('13111', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '24', '联运游戏统计', '2016-03-22 13:47:05', '2016-03-22 13:47:05');
INSERT INTO `log_function_click` VALUES ('13112', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '23', '单机游戏统计', '2016-03-22 13:53:17', '2016-03-22 13:53:17');
INSERT INTO `log_function_click` VALUES ('13113', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '39', '机锋市场调控', '2016-03-22 13:53:18', '2016-03-22 13:53:18');

-- ----------------------------
-- Table structure for log_sql_query
-- ----------------------------
DROP TABLE IF EXISTS `log_sql_query`;
CREATE TABLE `log_sql_query` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '用户编号',
  `USER_NAME` varchar(64) DEFAULT NULL COMMENT '用户名',
  `USER_IP` varchar(32) DEFAULT NULL COMMENT '用户IP',
  `REPORT_ID` varchar(64) DEFAULT NULL,
  `QUERY_TYPE` varchar(64) DEFAULT NULL,
  `LOG_TIME` datetime DEFAULT NULL COMMENT '登录时间',
  `INSERT_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '插入时间',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=65864 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log_sql_query
-- ----------------------------
INSERT INTO `log_sql_query` VALUES ('15331', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'select_product_dj.rptdisger', '简单查询', '2015-06-23 20:09:48', '2015-06-23 20:09:48');
INSERT INTO `log_sql_query` VALUES ('15332', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'dj_query_detail_count.rptdisger', '分页查询', '2015-06-23 20:09:48', '2015-06-23 20:09:48');
INSERT INTO `log_sql_query` VALUES ('15333', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'select_product_dj.rptdisger', '简单查询', '2015-06-23 20:09:49', '2015-06-23 20:09:49');
INSERT INTO `log_sql_query` VALUES ('15334', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'dj_query_detail_count.rptdisger', '分页查询', '2015-06-23 20:09:49', '2015-06-23 20:09:49');
INSERT INTO `log_sql_query` VALUES ('15335', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'select_product_dj.rptdisger', '简单查询', '2015-06-23 20:09:51', '2015-06-23 20:09:51');
INSERT INTO `log_sql_query` VALUES ('15336', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'dj_query_detail_count.rptdisger', '分页查询', '2015-06-23 20:09:51', '2015-06-23 20:09:51');
INSERT INTO `log_sql_query` VALUES ('15337', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'select_product_dj.rptdisger', '简单查询', '2015-06-23 20:09:51', '2015-06-23 20:09:51');
INSERT INTO `log_sql_query` VALUES ('15338', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'dj_query_detail_count.rptdisger', '分页查询', '2015-06-23 20:09:51', '2015-06-23 20:09:51');
INSERT INTO `log_sql_query` VALUES ('15339', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'select_product_dj.rptdisger', '简单查询', '2015-06-23 20:09:52', '2015-06-23 20:09:52');
INSERT INTO `log_sql_query` VALUES ('15340', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'dj_query_detail_count.rptdisger', '分页查询', '2015-06-23 20:09:52', '2015-06-23 20:09:52');
INSERT INTO `log_sql_query` VALUES ('65854', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'select_product_ly.rptdisger', '简单查询', '2016-03-22 13:47:05', '2016-03-22 13:47:05');
INSERT INTO `log_sql_query` VALUES ('65855', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'ly_query_detail_count.rptdisger', '分页查询', '2016-03-22 13:47:05', '2016-03-22 13:47:05');
INSERT INTO `log_sql_query` VALUES ('65856', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'ly_query_detail_count_total.rptdisger', '简单查询', '2016-03-22 13:47:05', '2016-03-22 13:47:05');
INSERT INTO `log_sql_query` VALUES ('65857', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'select_product_dj.rptdisger', '简单查询', '2016-03-22 13:53:17', '2016-03-22 13:53:17');
INSERT INTO `log_sql_query` VALUES ('65858', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'dj_query_detail_count.rptdisger', '分页查询', '2016-03-22 13:53:17', '2016-03-22 13:53:17');
INSERT INTO `log_sql_query` VALUES ('65859', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'dj_query_detail_count_total.rptdisger', '简单查询', '2016-03-22 13:53:17', '2016-03-22 13:53:17');
INSERT INTO `log_sql_query` VALUES ('65860', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'gfan_query_channel_count.rptdisger', '分页查询', '2016-03-22 13:53:18', '2016-03-22 13:53:18');
INSERT INTO `log_sql_query` VALUES ('65861', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'select_gfan_channel_count.rptdisger', '简单查询', '2016-03-22 13:53:18', '2016-03-22 13:53:18');
INSERT INTO `log_sql_query` VALUES ('65862', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'device_query_creat_count.rptdisger', '分页查询', '2016-03-22 13:53:27', '2016-03-22 13:53:27');
INSERT INTO `log_sql_query` VALUES ('65863', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', 'device_query_down_count.rptdisger', '分页查询', '2016-03-22 13:53:27', '2016-03-22 13:53:27');

-- ----------------------------
-- Table structure for log_user_login
-- ----------------------------
DROP TABLE IF EXISTS `log_user_login`;
CREATE TABLE `log_user_login` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `USER_ID` varchar(64) DEFAULT NULL COMMENT '用户编号',
  `USER_NAME` varchar(64) DEFAULT NULL COMMENT '用户名',
  `USER_IP` varchar(32) DEFAULT NULL COMMENT '用户IP',
  `LOG_TIME` datetime DEFAULT NULL COMMENT '登录时间',
  `INSERT_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '插入时间',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=5943 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log_user_login
-- ----------------------------
INSERT INTO `log_user_login` VALUES ('550', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '2015-06-23 20:09:44', '2015-06-23 20:09:44');
INSERT INTO `log_user_login` VALUES ('551', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '2015-06-23 20:11:34', '2015-06-23 20:11:34');
INSERT INTO `log_user_login` VALUES ('552', 'ceshi01@imopan.com', '测试', '10.8.8.172', '2015-06-24 10:55:13', '2015-06-24 10:55:13');
INSERT INTO `log_user_login` VALUES ('553', 'ceshi01@imopan.com', '测试', '10.8.8.172', '2015-06-24 11:29:27', '2015-06-24 11:29:27');
INSERT INTO `log_user_login` VALUES ('554', 'ceshi01@imopan.com', '测试', '10.8.8.172', '2015-06-24 11:31:04', '2015-06-24 11:31:04');
INSERT INTO `log_user_login` VALUES ('555', 'ceshi01@imopan.com', '测试', '10.8.8.172', '2015-06-24 15:24:22', '2015-06-24 15:24:22');
INSERT INTO `log_user_login` VALUES ('556', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '2015-06-24 15:46:12', '2015-06-24 15:46:12');
INSERT INTO `log_user_login` VALUES ('557', '1828189105@qq.com', '赵家新', '10.8.8.172', '2015-06-25 14:21:30', '2015-06-25 14:21:30');
INSERT INTO `log_user_login` VALUES ('558', '1828189105@qq.com', '赵家新', '10.8.8.172', '2015-06-25 15:57:37', '2015-06-25 15:57:37');
INSERT INTO `log_user_login` VALUES ('559', '1828189105@qq.com', '赵家新', '10.8.8.172', '2015-06-25 15:59:16', '2015-06-25 15:59:16');
INSERT INTO `log_user_login` VALUES ('5933', '2362080020@qq.com', '张坚', '10.8.8.172', '2016-02-16 18:13:33', '2016-02-16 18:13:33');
INSERT INTO `log_user_login` VALUES ('5934', '2362080020@qq.com', '张坚', '10.8.8.172', '2016-02-16 18:19:16', '2016-02-16 18:19:16');
INSERT INTO `log_user_login` VALUES ('5935', '2362080020@qq.com', '张坚', '10.8.8.172', '2016-02-16 18:23:58', '2016-02-16 18:23:58');
INSERT INTO `log_user_login` VALUES ('5936', '2362080020@qq.com', '张坚', '10.8.8.172', '2016-02-18 14:49:53', '2016-02-18 14:49:53');
INSERT INTO `log_user_login` VALUES ('5937', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '2016-03-04 18:08:27', '2016-03-04 18:08:27');
INSERT INTO `log_user_login` VALUES ('5938', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '2016-03-07 17:36:04', '2016-03-07 17:36:04');
INSERT INTO `log_user_login` VALUES ('5939', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '2016-03-14 14:01:11', '2016-03-14 14:01:11');
INSERT INTO `log_user_login` VALUES ('5940', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '2016-03-14 14:45:14', '2016-03-14 14:45:14');
INSERT INTO `log_user_login` VALUES ('5941', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '2016-03-14 17:44:32', '2016-03-14 17:44:32');
INSERT INTO `log_user_login` VALUES ('5942', 'admin@gfan.com', 'admin@gfan.com', '10.8.8.172', '2016-03-22 13:46:40', '2016-03-22 13:46:40');

-- ----------------------------
-- Table structure for p_member_role
-- ----------------------------
DROP TABLE IF EXISTS `p_member_role`;
CREATE TABLE `p_member_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100325 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of p_member_role
-- ----------------------------
INSERT INTO `p_member_role` VALUES ('280', '100000001', '501');
INSERT INTO `p_member_role` VALUES ('283', '110000007', '44');
INSERT INTO `p_member_role` VALUES ('286', '110000018', '23');
INSERT INTO `p_member_role` VALUES ('289', '110000019', '23');
INSERT INTO `p_member_role` VALUES ('290', '110000022', '23');
INSERT INTO `p_member_role` VALUES ('291', '110000020', '114');
INSERT INTO `p_member_role` VALUES ('292', '110000012', '503');
INSERT INTO `p_member_role` VALUES ('294', '110000016', '502');
INSERT INTO `p_member_role` VALUES ('295', '110000001', '15');
INSERT INTO `p_member_role` VALUES ('296', '110000028', '504');
INSERT INTO `p_member_role` VALUES ('301', '110000014', '115');
INSERT INTO `p_member_role` VALUES ('302', '110000017', '106');
INSERT INTO `p_member_role` VALUES ('303', '110000014', '502');
INSERT INTO `p_member_role` VALUES ('306', '110000060', '504');
INSERT INTO `p_member_role` VALUES ('310', '110000006', '44');
INSERT INTO `p_member_role` VALUES ('311', '110000009', '44');
INSERT INTO `p_member_role` VALUES ('355', '110000172', '504');
INSERT INTO `p_member_role` VALUES ('357', '110000165', '500');
INSERT INTO `p_member_role` VALUES ('358', '110000164', '500');
INSERT INTO `p_member_role` VALUES ('359', '110000163', '500');
INSERT INTO `p_member_role` VALUES ('360', '110000160', '500');
INSERT INTO `p_member_role` VALUES ('361', '110000158', '500');
INSERT INTO `p_member_role` VALUES ('362', '110000156', '500');
INSERT INTO `p_member_role` VALUES ('363', '110000155', '500');
INSERT INTO `p_member_role` VALUES ('364', '110000150', '500');
INSERT INTO `p_member_role` VALUES ('365', '110000125', '500');
INSERT INTO `p_member_role` VALUES ('366', '110000123', '500');
INSERT INTO `p_member_role` VALUES ('367', '110000120', '500');
INSERT INTO `p_member_role` VALUES ('368', '110000119', '500');
INSERT INTO `p_member_role` VALUES ('369', '110000117', '500');
INSERT INTO `p_member_role` VALUES ('370', '110000114', '500');
INSERT INTO `p_member_role` VALUES ('371', '110000110', '500');
INSERT INTO `p_member_role` VALUES ('374', '110000096', '500');
INSERT INTO `p_member_role` VALUES ('376', '110000056', '500');
INSERT INTO `p_member_role` VALUES ('378', '110000179', '500');
INSERT INTO `p_member_role` VALUES ('382', '110000017', '43');
INSERT INTO `p_member_role` VALUES ('383', '110000017', '503');
INSERT INTO `p_member_role` VALUES ('388', '110000039', '43');
INSERT INTO `p_member_role` VALUES ('389', '110000039', '503');
INSERT INTO `p_member_role` VALUES ('390', '110000197', '500');
INSERT INTO `p_member_role` VALUES ('391', '110000198', '504');
INSERT INTO `p_member_role` VALUES ('401', '110000216', '501');
INSERT INTO `p_member_role` VALUES ('403', '110000213', '501');
INSERT INTO `p_member_role` VALUES ('405', '110000227', '500');
INSERT INTO `p_member_role` VALUES ('406', '110000228', '500');
INSERT INTO `p_member_role` VALUES ('407', '110000231', '500');
INSERT INTO `p_member_role` VALUES ('408', '110000232', '500');
INSERT INTO `p_member_role` VALUES ('411', '110000236', '500');
INSERT INTO `p_member_role` VALUES ('412', '110000237', '500');
INSERT INTO `p_member_role` VALUES ('419', '110000243', '500');
INSERT INTO `p_member_role` VALUES ('100001', '110000244', '500');
INSERT INTO `p_member_role` VALUES ('100002', '110000245', '500');
INSERT INTO `p_member_role` VALUES ('100003', '110000246', '500');
INSERT INTO `p_member_role` VALUES ('100004', '110000247', '500');
INSERT INTO `p_member_role` VALUES ('100005', '110000248', '500');
INSERT INTO `p_member_role` VALUES ('100006', '110000249', '500');
INSERT INTO `p_member_role` VALUES ('100007', '110000250', '500');
INSERT INTO `p_member_role` VALUES ('100008', '110000251', '500');
INSERT INTO `p_member_role` VALUES ('100009', '110000234', '501');
INSERT INTO `p_member_role` VALUES ('100010', '110000252', '500');
INSERT INTO `p_member_role` VALUES ('100011', '110000253', '500');
INSERT INTO `p_member_role` VALUES ('100012', '110000254', '500');
INSERT INTO `p_member_role` VALUES ('100013', '110000255', '500');
INSERT INTO `p_member_role` VALUES ('100014', '110000256', '500');
INSERT INTO `p_member_role` VALUES ('100015', '110000257', '500');
INSERT INTO `p_member_role` VALUES ('100016', '110000258', '500');
INSERT INTO `p_member_role` VALUES ('100017', '110000259', '500');
INSERT INTO `p_member_role` VALUES ('100018', '110000260', '500');
INSERT INTO `p_member_role` VALUES ('100019', '110000261', '500');
INSERT INTO `p_member_role` VALUES ('100020', '110000262', '500');
INSERT INTO `p_member_role` VALUES ('100022', '110000264', '500');
INSERT INTO `p_member_role` VALUES ('100023', '110000265', '500');
INSERT INTO `p_member_role` VALUES ('100024', '110000266', '500');
INSERT INTO `p_member_role` VALUES ('100025', '110000267', '500');
INSERT INTO `p_member_role` VALUES ('100026', '110000268', '500');
INSERT INTO `p_member_role` VALUES ('100027', '110000269', '500');
INSERT INTO `p_member_role` VALUES ('100028', '110000270', '500');
INSERT INTO `p_member_role` VALUES ('100029', '110000271', '500');
INSERT INTO `p_member_role` VALUES ('100031', '110000035', '501');
INSERT INTO `p_member_role` VALUES ('100033', '110000272', '500');
INSERT INTO `p_member_role` VALUES ('100034', '110000277', '505');
INSERT INTO `p_member_role` VALUES ('100035', '110000278', '505');
INSERT INTO `p_member_role` VALUES ('100036', '110000279', '500');
INSERT INTO `p_member_role` VALUES ('100037', '110000283', '500');
INSERT INTO `p_member_role` VALUES ('100038', '110000275', '601');
INSERT INTO `p_member_role` VALUES ('100039', '110000281', '601');
INSERT INTO `p_member_role` VALUES ('100040', '110000221', '601');
INSERT INTO `p_member_role` VALUES ('100041', '110000284', '601');
INSERT INTO `p_member_role` VALUES ('100042', '110000285', '601');
INSERT INTO `p_member_role` VALUES ('100044', '110000229', '601');
INSERT INTO `p_member_role` VALUES ('100052', '110000287', '601');
INSERT INTO `p_member_role` VALUES ('100053', '110000292', '501');
INSERT INTO `p_member_role` VALUES ('100054', '110000293', '500');
INSERT INTO `p_member_role` VALUES ('100056', '110000294', '501');
INSERT INTO `p_member_role` VALUES ('100057', '110000298', '500');
INSERT INTO `p_member_role` VALUES ('100064', '110000286', '501');
INSERT INTO `p_member_role` VALUES ('100065', '110000288', '500');
INSERT INTO `p_member_role` VALUES ('100066', '110000300', '501');
INSERT INTO `p_member_role` VALUES ('100067', '110000301', '500');
INSERT INTO `p_member_role` VALUES ('100069', '110000297', '23');
INSERT INTO `p_member_role` VALUES ('100070', '110000305', '501');
INSERT INTO `p_member_role` VALUES ('100071', '110000306', '500');
INSERT INTO `p_member_role` VALUES ('100073', '110000315', '602');
INSERT INTO `p_member_role` VALUES ('100075', '110000319', '602');
INSERT INTO `p_member_role` VALUES ('100077', '110000324', '602');
INSERT INTO `p_member_role` VALUES ('100078', '110000321', '612');
INSERT INTO `p_member_role` VALUES ('100088', '110000325', '605');
INSERT INTO `p_member_role` VALUES ('100091', '110000333', '602');
INSERT INTO `p_member_role` VALUES ('100092', '110000304', '605');
INSERT INTO `p_member_role` VALUES ('100094', '110000338', '602');
INSERT INTO `p_member_role` VALUES ('100095', '110000339', '604');
INSERT INTO `p_member_role` VALUES ('100096', '110000326', '605');
INSERT INTO `p_member_role` VALUES ('100097', '110000341', '604');
INSERT INTO `p_member_role` VALUES ('100098', '110000342', '602');
INSERT INTO `p_member_role` VALUES ('100104', '110000336', '606');
INSERT INTO `p_member_role` VALUES ('100105', '110000344', '604');
INSERT INTO `p_member_role` VALUES ('100112', '110000349', '606');
INSERT INTO `p_member_role` VALUES ('100113', '110000348', '606');
INSERT INTO `p_member_role` VALUES ('100115', '110000347', '606');
INSERT INTO `p_member_role` VALUES ('100116', '110000346', '606');
INSERT INTO `p_member_role` VALUES ('100117', '110000345', '606');
INSERT INTO `p_member_role` VALUES ('100118', '110000350', '604');
INSERT INTO `p_member_role` VALUES ('100119', '110000351', '606');
INSERT INTO `p_member_role` VALUES ('100121', '110000355', '606');
INSERT INTO `p_member_role` VALUES ('100122', '110000356', '606');
INSERT INTO `p_member_role` VALUES ('100123', '110000357', '606');
INSERT INTO `p_member_role` VALUES ('100124', '110000358', '606');
INSERT INTO `p_member_role` VALUES ('100125', '110000354', '606');
INSERT INTO `p_member_role` VALUES ('100126', '110000360', '606');
INSERT INTO `p_member_role` VALUES ('100127', '110000361', '602');
INSERT INTO `p_member_role` VALUES ('100129', '110000364', '606');
INSERT INTO `p_member_role` VALUES ('100130', '110000363', '606');
INSERT INTO `p_member_role` VALUES ('100133', '110000365', '611');
INSERT INTO `p_member_role` VALUES ('100134', '110000368', '606');
INSERT INTO `p_member_role` VALUES ('100135', '110000367', '606');
INSERT INTO `p_member_role` VALUES ('100136', '110000366', '606');
INSERT INTO `p_member_role` VALUES ('100137', '110000369', '606');
INSERT INTO `p_member_role` VALUES ('100138', '110000382', '606');
INSERT INTO `p_member_role` VALUES ('100140', '110000380', '606');
INSERT INTO `p_member_role` VALUES ('100141', '110000379', '606');
INSERT INTO `p_member_role` VALUES ('100142', '110000378', '606');
INSERT INTO `p_member_role` VALUES ('100143', '110000377', '606');
INSERT INTO `p_member_role` VALUES ('100144', '110000376', '606');
INSERT INTO `p_member_role` VALUES ('100145', '110000375', '606');
INSERT INTO `p_member_role` VALUES ('100146', '110000374', '606');
INSERT INTO `p_member_role` VALUES ('100147', '110000373', '606');
INSERT INTO `p_member_role` VALUES ('100148', '110000372', '606');
INSERT INTO `p_member_role` VALUES ('100149', '110000381', '606');
INSERT INTO `p_member_role` VALUES ('100150', '110000371', '606');
INSERT INTO `p_member_role` VALUES ('100151', '110000370', '606');
INSERT INTO `p_member_role` VALUES ('100152', '110000383', '602');
INSERT INTO `p_member_role` VALUES ('100153', '110000385', '606');
INSERT INTO `p_member_role` VALUES ('100154', '110000384', '606');
INSERT INTO `p_member_role` VALUES ('100155', '110000386', '604');
INSERT INTO `p_member_role` VALUES ('100156', '110000387', '606');
INSERT INTO `p_member_role` VALUES ('100158', '110000389', '604');
INSERT INTO `p_member_role` VALUES ('100159', '110000390', '606');
INSERT INTO `p_member_role` VALUES ('100160', '110000391', '606');
INSERT INTO `p_member_role` VALUES ('100161', '110000392', '606');
INSERT INTO `p_member_role` VALUES ('100162', '110000393', '606');
INSERT INTO `p_member_role` VALUES ('100163', '110000394', '607');
INSERT INTO `p_member_role` VALUES ('100164', '110000395', '606');
INSERT INTO `p_member_role` VALUES ('100165', '110000396', '606');
INSERT INTO `p_member_role` VALUES ('100166', '110000309', '612');
INSERT INTO `p_member_role` VALUES ('100167', '110000397', '606');
INSERT INTO `p_member_role` VALUES ('100168', '110000398', '606');
INSERT INTO `p_member_role` VALUES ('100169', '110000399', '606');
INSERT INTO `p_member_role` VALUES ('100170', '110000400', '606');
INSERT INTO `p_member_role` VALUES ('100171', '110000401', '606');
INSERT INTO `p_member_role` VALUES ('100172', '110000402', '606');
INSERT INTO `p_member_role` VALUES ('100173', '110000404', '606');
INSERT INTO `p_member_role` VALUES ('100174', '110000405', '606');
INSERT INTO `p_member_role` VALUES ('100175', '110000406', '606');
INSERT INTO `p_member_role` VALUES ('100176', '110000407', '606');
INSERT INTO `p_member_role` VALUES ('100177', '110000408', '606');
INSERT INTO `p_member_role` VALUES ('100178', '110000409', '606');
INSERT INTO `p_member_role` VALUES ('100179', '110000410', '606');
INSERT INTO `p_member_role` VALUES ('100180', '110000411', '606');
INSERT INTO `p_member_role` VALUES ('100181', '110000412', '606');
INSERT INTO `p_member_role` VALUES ('100182', '110000413', '606');
INSERT INTO `p_member_role` VALUES ('100183', '110000414', '606');
INSERT INTO `p_member_role` VALUES ('100184', '110000415', '606');
INSERT INTO `p_member_role` VALUES ('100185', '110000417', '606');
INSERT INTO `p_member_role` VALUES ('100186', '110000416', '606');
INSERT INTO `p_member_role` VALUES ('100187', '110000419', '606');
INSERT INTO `p_member_role` VALUES ('100188', '110000421', '606');
INSERT INTO `p_member_role` VALUES ('100189', '110000422', '606');
INSERT INTO `p_member_role` VALUES ('100190', '110000423', '606');
INSERT INTO `p_member_role` VALUES ('100191', '110000424', '606');
INSERT INTO `p_member_role` VALUES ('100192', '110000425', '606');
INSERT INTO `p_member_role` VALUES ('100193', '110000426', '606');
INSERT INTO `p_member_role` VALUES ('100194', '110000427', '606');
INSERT INTO `p_member_role` VALUES ('100195', '110000428', '606');
INSERT INTO `p_member_role` VALUES ('100196', '110000429', '606');
INSERT INTO `p_member_role` VALUES ('100197', '110000430', '606');
INSERT INTO `p_member_role` VALUES ('100198', '110000431', '606');
INSERT INTO `p_member_role` VALUES ('100199', '110000432', '606');
INSERT INTO `p_member_role` VALUES ('100200', '110000433', '606');
INSERT INTO `p_member_role` VALUES ('100201', '110000434', '606');
INSERT INTO `p_member_role` VALUES ('100202', '110000435', '606');
INSERT INTO `p_member_role` VALUES ('100203', '110000436', '606');
INSERT INTO `p_member_role` VALUES ('100204', '110000437', '606');
INSERT INTO `p_member_role` VALUES ('100205', '110000438', '606');
INSERT INTO `p_member_role` VALUES ('100206', '110000439', '606');
INSERT INTO `p_member_role` VALUES ('100207', '110000440', '606');
INSERT INTO `p_member_role` VALUES ('100208', '110000441', '606');
INSERT INTO `p_member_role` VALUES ('100209', '110000442', '606');
INSERT INTO `p_member_role` VALUES ('100210', '110000443', '606');
INSERT INTO `p_member_role` VALUES ('100211', '110000444', '606');
INSERT INTO `p_member_role` VALUES ('100212', '110000445', '606');
INSERT INTO `p_member_role` VALUES ('100213', '110000446', '606');
INSERT INTO `p_member_role` VALUES ('100214', '110000447', '606');
INSERT INTO `p_member_role` VALUES ('100215', '110000448', '606');
INSERT INTO `p_member_role` VALUES ('100216', '110000449', '606');
INSERT INTO `p_member_role` VALUES ('100217', '110000450', '606');
INSERT INTO `p_member_role` VALUES ('100218', '110000451', '606');
INSERT INTO `p_member_role` VALUES ('100219', '110000452', '606');
INSERT INTO `p_member_role` VALUES ('100220', '110000453', '606');
INSERT INTO `p_member_role` VALUES ('100221', '110000454', '606');
INSERT INTO `p_member_role` VALUES ('100222', '110000455', '606');
INSERT INTO `p_member_role` VALUES ('100223', '110000457', '606');
INSERT INTO `p_member_role` VALUES ('100224', '110000458', '606');
INSERT INTO `p_member_role` VALUES ('100225', '110000460', '606');
INSERT INTO `p_member_role` VALUES ('100226', '110000461', '606');
INSERT INTO `p_member_role` VALUES ('100227', '110000462', '606');
INSERT INTO `p_member_role` VALUES ('100228', '110000463', '606');
INSERT INTO `p_member_role` VALUES ('100229', '110000464', '606');
INSERT INTO `p_member_role` VALUES ('100230', '110000465', '606');
INSERT INTO `p_member_role` VALUES ('100231', '110000466', '606');
INSERT INTO `p_member_role` VALUES ('100232', '110000467', '606');
INSERT INTO `p_member_role` VALUES ('100233', '110000468', '606');
INSERT INTO `p_member_role` VALUES ('100234', '110000469', '606');
INSERT INTO `p_member_role` VALUES ('100235', '110000470', '606');
INSERT INTO `p_member_role` VALUES ('100236', '110000471', '606');
INSERT INTO `p_member_role` VALUES ('100237', '110000472', '606');
INSERT INTO `p_member_role` VALUES ('100238', '110000473', '611');
INSERT INTO `p_member_role` VALUES ('100239', '110000474', '606');
INSERT INTO `p_member_role` VALUES ('100240', '110000475', '606');
INSERT INTO `p_member_role` VALUES ('100241', '110000476', '606');
INSERT INTO `p_member_role` VALUES ('100242', '110000477', '606');
INSERT INTO `p_member_role` VALUES ('100243', '110000478', '606');
INSERT INTO `p_member_role` VALUES ('100244', '110000479', '606');
INSERT INTO `p_member_role` VALUES ('100245', '110000480', '606');
INSERT INTO `p_member_role` VALUES ('100246', '110000481', '606');
INSERT INTO `p_member_role` VALUES ('100247', '110000482', '606');
INSERT INTO `p_member_role` VALUES ('100248', '110000483', '606');
INSERT INTO `p_member_role` VALUES ('100249', '110000484', '606');
INSERT INTO `p_member_role` VALUES ('100250', '110000485', '606');
INSERT INTO `p_member_role` VALUES ('100251', '110000486', '606');
INSERT INTO `p_member_role` VALUES ('100252', '110000487', '606');
INSERT INTO `p_member_role` VALUES ('100253', '110000488', '606');
INSERT INTO `p_member_role` VALUES ('100254', '110000489', '606');
INSERT INTO `p_member_role` VALUES ('100255', '110000490', '606');
INSERT INTO `p_member_role` VALUES ('100256', '110000491', '606');
INSERT INTO `p_member_role` VALUES ('100257', '110000492', '606');
INSERT INTO `p_member_role` VALUES ('100258', '110000493', '606');
INSERT INTO `p_member_role` VALUES ('100259', '110000494', '606');
INSERT INTO `p_member_role` VALUES ('100260', '110000495', '606');
INSERT INTO `p_member_role` VALUES ('100261', '110000496', '606');
INSERT INTO `p_member_role` VALUES ('100262', '110000497', '606');
INSERT INTO `p_member_role` VALUES ('100263', '110000498', '606');
INSERT INTO `p_member_role` VALUES ('100264', '110000499', '606');
INSERT INTO `p_member_role` VALUES ('100265', '110000500', '606');
INSERT INTO `p_member_role` VALUES ('100266', '110000501', '606');
INSERT INTO `p_member_role` VALUES ('100267', '110000502', '606');
INSERT INTO `p_member_role` VALUES ('100268', '110000503', '606');
INSERT INTO `p_member_role` VALUES ('100269', '110000504', '606');
INSERT INTO `p_member_role` VALUES ('100270', '110000505', '606');
INSERT INTO `p_member_role` VALUES ('100271', '110000506', '606');
INSERT INTO `p_member_role` VALUES ('100272', '110000508', '606');
INSERT INTO `p_member_role` VALUES ('100273', '110000507', '606');
INSERT INTO `p_member_role` VALUES ('100274', '110000509', '613');
INSERT INTO `p_member_role` VALUES ('100275', '110000510', '606');
INSERT INTO `p_member_role` VALUES ('100276', '110000511', '606');
INSERT INTO `p_member_role` VALUES ('100277', '110000512', '606');
INSERT INTO `p_member_role` VALUES ('100278', '110000513', '606');
INSERT INTO `p_member_role` VALUES ('100279', '110000533', '606');
INSERT INTO `p_member_role` VALUES ('100280', '110000532', '606');
INSERT INTO `p_member_role` VALUES ('100281', '110000531', '606');
INSERT INTO `p_member_role` VALUES ('100282', '110000530', '606');
INSERT INTO `p_member_role` VALUES ('100283', '110000529', '606');
INSERT INTO `p_member_role` VALUES ('100284', '110000528', '606');
INSERT INTO `p_member_role` VALUES ('100285', '110000527', '606');
INSERT INTO `p_member_role` VALUES ('100286', '110000526', '606');
INSERT INTO `p_member_role` VALUES ('100287', '110000525', '606');
INSERT INTO `p_member_role` VALUES ('100288', '110000524', '606');
INSERT INTO `p_member_role` VALUES ('100289', '110000523', '606');
INSERT INTO `p_member_role` VALUES ('100290', '110000522', '606');
INSERT INTO `p_member_role` VALUES ('100291', '110000521', '606');
INSERT INTO `p_member_role` VALUES ('100292', '110000520', '606');
INSERT INTO `p_member_role` VALUES ('100293', '110000519', '606');
INSERT INTO `p_member_role` VALUES ('100294', '110000514', '606');
INSERT INTO `p_member_role` VALUES ('100295', '110000515', '606');
INSERT INTO `p_member_role` VALUES ('100296', '110000516', '606');
INSERT INTO `p_member_role` VALUES ('100297', '110000517', '606');
INSERT INTO `p_member_role` VALUES ('100298', '110000518', '606');
INSERT INTO `p_member_role` VALUES ('100299', '110000535', '606');
INSERT INTO `p_member_role` VALUES ('100300', '110000536', '606');
INSERT INTO `p_member_role` VALUES ('100301', '110000537', '606');
INSERT INTO `p_member_role` VALUES ('100302', '110000538', '606');
INSERT INTO `p_member_role` VALUES ('100303', '110000534', '606');
INSERT INTO `p_member_role` VALUES ('100304', '110000539', '606');
INSERT INTO `p_member_role` VALUES ('100305', '110000540', '606');
INSERT INTO `p_member_role` VALUES ('100306', '110000541', '606');
INSERT INTO `p_member_role` VALUES ('100307', '110000542', '606');
INSERT INTO `p_member_role` VALUES ('100308', '110000543', '606');
INSERT INTO `p_member_role` VALUES ('100309', '110000544', '606');
INSERT INTO `p_member_role` VALUES ('100310', '110000545', '606');
INSERT INTO `p_member_role` VALUES ('100311', '110000552', '606');
INSERT INTO `p_member_role` VALUES ('100312', '110000551', '606');
INSERT INTO `p_member_role` VALUES ('100313', '110000550', '606');
INSERT INTO `p_member_role` VALUES ('100314', '110000549', '606');
INSERT INTO `p_member_role` VALUES ('100315', '110000548', '606');
INSERT INTO `p_member_role` VALUES ('100316', '110000547', '606');
INSERT INTO `p_member_role` VALUES ('100317', '110000546', '606');
INSERT INTO `p_member_role` VALUES ('100318', '110000553', '606');
INSERT INTO `p_member_role` VALUES ('100319', '110000554', '606');
INSERT INTO `p_member_role` VALUES ('100320', '110000555', '606');
INSERT INTO `p_member_role` VALUES ('100321', '110000557', '606');
INSERT INTO `p_member_role` VALUES ('100322', '110000556', '606');
INSERT INTO `p_member_role` VALUES ('100323', '110000559', '604');
INSERT INTO `p_member_role` VALUES ('100324', '110000560', '604');

-- ----------------------------
-- Table structure for p_role
-- ----------------------------
DROP TABLE IF EXISTS `p_role`;
CREATE TABLE `p_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `desc` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `sys_id` int(11) DEFAULT '2',
  `operate` varchar(255) COLLATE utf8_bin DEFAULT '修改' COMMENT '操作',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=614 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of p_role
-- ----------------------------
INSERT INTO `p_role` VALUES ('501', '渠道后台管理员', '渠道后台管理员', '渠道后台管理员', '5', '修改');
INSERT INTO `p_role` VALUES ('602', '单机业务渠道', '单机业务渠道', '单机业务渠道', '2', '修改');
INSERT INTO `p_role` VALUES ('603', '单机业务管理员', '单机业务管理员', '单机业务管理员', '2', '修改');
INSERT INTO `p_role` VALUES ('604', '联运业务渠道', '联运业务渠道', '联运业务渠道', '2', '修改');
INSERT INTO `p_role` VALUES ('605', '联运业务管理员', '联运业务管理员', '联运业务管理员', '2', '修改');
INSERT INTO `p_role` VALUES ('606', '机锋市场渠道', '机锋市场渠道管理员', '机锋市场渠道', '2', '修改');
INSERT INTO `p_role` VALUES ('607', '机锋市场管理员', '机锋市场管理员', '机锋市场管理员', '2', '修改');
INSERT INTO `p_role` VALUES ('611', '机锋市场&单机业务', '机锋市场&单机业务', '机锋市场&单机业务', '2', '修改');
INSERT INTO `p_role` VALUES ('612', '机锋市场&单机业务管理员', '机锋市场&单机业务管理员', '机锋市场&单机业务管理员', '2', '修改');
INSERT INTO `p_role` VALUES ('613', '机锋市场渠道调控管理员', '机锋市场渠道调控管理员', '机锋市场渠道调控管理员', '2', '修改');

-- ----------------------------
-- Table structure for rep_dj_device_count
-- ----------------------------
DROP TABLE IF EXISTS `rep_dj_device_count`;
CREATE TABLE `rep_dj_device_count` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATA_TIME` varchar(255) DEFAULT NULL COMMENT '日期',
  `USER_ID` int(11) DEFAULT NULL,
  `CHANNEL_NAME` varchar(255) DEFAULT NULL COMMENT '渠道名称',
  `PRODUCT_ID` int(11) DEFAULT NULL COMMENT '产品ID',
  `PRODUCT_NAME` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `REGISTER_USER` int(11) DEFAULT NULL COMMENT '注册人数',
  `INSERT_TIME` datetime DEFAULT NULL COMMENT '插入时间',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rep_dj_device_count
-- ----------------------------
INSERT INTO `rep_dj_device_count` VALUES ('1', '2015-06-08', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '34', '2015-06-17 19:05:45');
INSERT INTO `rep_dj_device_count` VALUES ('2', '2015-06-09', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '40', '2015-06-17 19:06:19');
INSERT INTO `rep_dj_device_count` VALUES ('3', '2015-06-10', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '57', '2015-06-17 19:06:22');
INSERT INTO `rep_dj_device_count` VALUES ('4', '2015-06-11', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '62', '2015-06-17 19:06:24');
INSERT INTO `rep_dj_device_count` VALUES ('5', '2015-06-12', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '33', '2015-06-17 19:06:27');
INSERT INTO `rep_dj_device_count` VALUES ('6', '2015-06-13', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '43', '2015-06-17 19:06:29');
INSERT INTO `rep_dj_device_count` VALUES ('7', '2015-06-14', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '32', '2015-06-18 11:26:16');
INSERT INTO `rep_dj_device_count` VALUES ('9', '2015-06-15', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '26', '2015-06-24 09:51:40');
INSERT INTO `rep_dj_device_count` VALUES ('10', '2015-06-16', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '28', '2015-06-24 09:51:44');
INSERT INTO `rep_dj_device_count` VALUES ('11', '2015-06-17', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '26', '2015-06-24 09:51:48');
INSERT INTO `rep_dj_device_count` VALUES ('12', '2015-06-18', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '28', '2015-06-24 09:52:23');
INSERT INTO `rep_dj_device_count` VALUES ('13', '2015-06-19', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '31', '2015-06-24 09:52:29');
INSERT INTO `rep_dj_device_count` VALUES ('14', '2015-06-20', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '28', '2015-06-24 09:52:31');
INSERT INTO `rep_dj_device_count` VALUES ('15', '2015-06-21', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '22', '2015-06-24 09:52:37');
INSERT INTO `rep_dj_device_count` VALUES ('16', '2015-06-22', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '18', '2015-06-24 09:52:34');
INSERT INTO `rep_dj_device_count` VALUES ('17', '2015-06-23', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '18', '2015-06-24 09:52:40');
INSERT INTO `rep_dj_device_count` VALUES ('18', '2015-06-08', '110000319', '广州七达信息技术有限公司', '1033370', '老k德州', '14', '2015-06-24 09:52:42');
INSERT INTO `rep_dj_device_count` VALUES ('19', '2015-06-09', '110000319', '广州七达信息技术有限公司', '1033370', '老k德州', '7', '2015-06-24 09:52:44');
INSERT INTO `rep_dj_device_count` VALUES ('20', '2015-06-10', '110000319', '广州七达信息技术有限公司', '1033370', '老k德州', '0', '2015-06-24 09:52:48');
INSERT INTO `rep_dj_device_count` VALUES ('24', '2015-06-25', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '13', '2015-06-26 15:25:06');
INSERT INTO `rep_dj_device_count` VALUES ('25', '2015-06-26', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '16', '2015-06-29 17:54:15');
INSERT INTO `rep_dj_device_count` VALUES ('23', '2015-06-24', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '17', '2015-06-26 15:25:03');
INSERT INTO `rep_dj_device_count` VALUES ('26', '2015-06-27', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '11', '2015-06-29 17:54:17');
INSERT INTO `rep_dj_device_count` VALUES ('27', '2015-06-28', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '12', '2015-06-29 17:54:20');
INSERT INTO `rep_dj_device_count` VALUES ('28', '2015-07-01', '110000324', '江西易臻科技有限公司', '1032245', '千王AAA ', null, '2015-07-01 11:35:30');
INSERT INTO `rep_dj_device_count` VALUES ('29', '2015-06-29', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '9', '2015-07-01 14:41:30');
INSERT INTO `rep_dj_device_count` VALUES ('30', '2015-06-30', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '9', '2015-07-01 14:41:33');
INSERT INTO `rep_dj_device_count` VALUES ('31', '2015-07-01', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '11', '2015-07-01 14:41:33');
INSERT INTO `rep_dj_device_count` VALUES ('32', '2015-07-02', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '12', '2015-07-01 14:41:33');
INSERT INTO `rep_dj_device_count` VALUES ('33', '2015-07-03', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '13', '2015-07-06 18:44:06');
INSERT INTO `rep_dj_device_count` VALUES ('34', '2015-07-04', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '10', '2015-07-06 18:44:10');
INSERT INTO `rep_dj_device_count` VALUES ('35', '2015-07-05', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '13', '2015-07-06 18:44:12');
INSERT INTO `rep_dj_device_count` VALUES ('36', '2015-07-12', '110000333', '北京摩比万思科技有限公司', '1033422', '全民连连消', '15', '2015-07-06 18:59:49');
INSERT INTO `rep_dj_device_count` VALUES ('37', '2015-07-06', '110000333', '北京摩比万思科技有限公司', '1025104', '点乐斗地主', null, '2015-07-06 18:59:51');
INSERT INTO `rep_dj_device_count` VALUES ('38', '2015-07-06', '110000333', '北京摩比万思科技有限公司', '1025105', '点乐斗牛', null, '2015-07-06 18:59:53');
INSERT INTO `rep_dj_device_count` VALUES ('39', '2015-07-06', '110000333', '北京摩比万思科技有限公司', '925257', '点乐五张', null, '2015-07-06 18:59:56');
INSERT INTO `rep_dj_device_count` VALUES ('40', '2015-07-06', '110000333', '北京摩比万思科技有限公司', '1020891', '锐游扎金花', null, '2015-07-06 18:59:59');
INSERT INTO `rep_dj_device_count` VALUES ('41', '2015-07-06', '110000333', '北京摩比万思科技有限公司', '1042896', '超级玛丽（奔跑吧）', null, '2015-07-06 19:00:02');
INSERT INTO `rep_dj_device_count` VALUES ('42', '2015-07-06', '110000333', '北京摩比万思科技有限公司', '1043416', '开心猜猜看', null, '2015-07-06 19:00:05');
INSERT INTO `rep_dj_device_count` VALUES ('43', '2015-07-06', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '8', '2015-07-08 17:55:42');
INSERT INTO `rep_dj_device_count` VALUES ('44', '2015-07-07', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '11', '2015-07-08 17:55:44');
INSERT INTO `rep_dj_device_count` VALUES ('45', '2015-07-09', '110000338', '北京金岩石科技有限公司', '1046169', '1557_机锋_机锋斗地主', null, '2015-07-09 10:57:10');
INSERT INTO `rep_dj_device_count` VALUES ('46', '2015-07-08', '110000319', '广州七达信息技术有限公司', '1033363', '老k斗地主', '8', '2015-07-09 17:02:54');
INSERT INTO `rep_dj_device_count` VALUES ('47', '2015-07-14', '110000342', '重庆聚米网络科技有限公司', '1046169', '1571_机锋_机锋斗地主', '103', '2015-07-10 18:15:59');
INSERT INTO `rep_dj_device_count` VALUES ('48', '2015-07-14', '110000361', '济南掌赢软件科技有限公司', '1046169', '1555_机锋_机锋斗地主', null, '2015-07-14 17:41:31');
INSERT INTO `rep_dj_device_count` VALUES ('49', '2015-07-14', '110000361', '济南掌赢软件科技有限公司', '1046169', '1556_机锋_机锋斗地主', null, '2015-07-14 17:41:34');
INSERT INTO `rep_dj_device_count` VALUES ('50', '2015-07-10', '110000383', '济南掌赢软件科技有限公司', '1046169', '1571_机锋_机锋斗地主', '3', '2015-07-14 17:41:34');
INSERT INTO `rep_dj_device_count` VALUES ('51', '2015-07-11', '110000383', '济南掌赢软件科技有限公司', '1046169', '1571_机锋_机锋斗地主', '22', '2015-07-14 17:41:34');
INSERT INTO `rep_dj_device_count` VALUES ('52', '2015-07-12', '110000383', '济南掌赢软件科技有限公司', '1046169', '1571_机锋_机锋斗地主', '23', '2015-07-14 17:41:34');
INSERT INTO `rep_dj_device_count` VALUES ('53', '2015-07-13', '110000383', '济南掌赢软件科技有限公司', '1046169', '1571_机锋_机锋斗地主', '18', '2015-07-14 17:41:34');
INSERT INTO `rep_dj_device_count` VALUES ('54', '2015-07-15', '110000342', '重庆聚米网络科技有限公司', '1046169', '1571_机锋_机锋斗地主', '225', '2015-07-14 17:41:34');
INSERT INTO `rep_dj_device_count` VALUES ('56', '2015-07-13', '110000333', '北京摩比万思科技有限公司', '1033422', '全民连连消', '1', '2015-07-14 17:41:34');
INSERT INTO `rep_dj_device_count` VALUES ('57', '2015-07-14', '110000333', '北京摩比万思科技有限公司', '1033422', '全民连连消', '7', '2015-07-14 17:41:34');
INSERT INTO `rep_dj_device_count` VALUES ('58', '2015-07-15', '110000333', '北京摩比万思科技有限公司', '1033422', '全民连连消', '3', '2015-07-14 17:41:34');

-- ----------------------------
-- Table structure for rep_query
-- ----------------------------
DROP TABLE IF EXISTS `rep_query`;
CREATE TABLE `rep_query` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `REPORT_NAME` varchar(128) NOT NULL DEFAULT '' COMMENT '报表名称',
  `REPORT_DESCRIBE` varchar(128) DEFAULT NULL,
  `REPORT_SQL` varchar(3072) DEFAULT NULL COMMENT '查询的sql语句',
  `COUNT_SQL` varchar(2048) DEFAULT NULL,
  `REPLACE_FIELD` varchar(128) DEFAULT NULL COMMENT '替换的文本',
  `COUNT_FIELD` varchar(256) DEFAULT NULL,
  `QUERY_FIELD` varchar(256) DEFAULT NULL COMMENT '查询的条件',
  `REPORT_RESULT` varchar(512) DEFAULT NULL COMMENT '返回的结果',
  `REPORT_TITLE` varchar(512) DEFAULT NULL COMMENT '产生的表头',
  `REPORT_DB` varchar(32) DEFAULT NULL,
  `REPORT_USED` smallint(4) DEFAULT '1' COMMENT '1,正在使用;2,废弃',
  `INSERT_TIME` date DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`REPORT_NAME`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8414 DEFAULT CHARSET=utf8 COMMENT='前端展示查询语句';

-- ----------------------------
-- Records of rep_query
-- ----------------------------
INSERT INTO `rep_query` VALUES ('104', 'device_query_creat_count', '报表查询：机锋市场渠道调控新增分时段信息', 'SELECT creat00,creat1,creat2,creat3,creat4,creat5,creat6,creat7,creat8,creat9,creat10,creat11,creat12,creat13,creat14,creat15,creat16,creat17,creat18,creat19,creat20,creat21,creat22,creat23 FROM device_creat_count WHERE channel_id=:channel_id AND data_time=:data_time', 'SELECT count(*) COUNT FROM device_creat_count WHERE channel_id=:channel_id AND data_time=:data_time', null, 'channel_id=String,data_time=String', 'channel_id=String,data_time=String,start_index=Integer,end_index=Integer', 'creat1=String,creat2=String,creat3=String,creat4=String,creat5=String,creat6=String,creat7=String,creat8=String,creat9=String,creat10=String,creat11=String,creat12=String,creat13=String,creat14=String,creat15=String,creat16=String,creat17=String,creat18=String,creat19=String,creat20=String,creat21=String,creat22=String,creat23=String,creat00=String', '00~1,1~2,2~3,3~4,4~5,5~6,6~7,7~8,8~9,9~10,10~11,11~12,12~13,13~14,14~15,15~16,16~17,17~18,18~19,19~20,20~21,21~22,22~23,23~00', 'distribute', '1', '2015-06-24');
INSERT INTO `rep_query` VALUES ('103', 'device_query_down_count', '报表查询：机锋市场渠道调控下载分时段信息', 'SELECT down00,down1,down2,down3,down4,down5,down6,down7,down8,down9,down10,down11,down12,down13,down14,down15,down16,down7,down18,down19,down20,down21,down22,down23 FROM device_down_count WHERE channel_id=:channel_id AND data_time=:data_time', 'SELECT count(*) COUNT FROM device_down_count WHERE channel_id=:channel_id AND data_time=:data_time', null, 'channel_id=String,data_time=String', 'channel_id=String,data_time=String,start_index=Integer,end_index=Integer', 'down1=String,down2=String,down3=String,down4=String,down5=String,down6=String,down7=String,down8=String,down9=String,down10=String,down11=String,down12=String,down13=String,down14=String,down15=String,down16=String,down7=String,down18=String,down19=String,down20=String,down21=String,down22=String,down23=String,down00=String', '00~1,1~2,2~3,3~4,4~5,5~6,6~7,7~8,8~9,9~10,10~11,11~12,12~13,13~14,14~15,15~16,16~17,17~18,18~19,19~20,20~21,21~22,22~23,23~00', 'distribute', '1', '2015-06-24');
INSERT INTO `rep_query` VALUES ('70', 'dj_query_detail_count', '报表查询：单机游戏数据统计', 'select DATA_TIME,CHANNEL_NAME,PRODUCT_NAME,REGISTER_USER from REP_DJ_DEVICE_COUNT WHERE data_time>=:start_time AND data_time<=:end_time and product_id=:product_id AND USER_ID=:user_id ORDER BY data_time DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from REP_DJ_DEVICE_COUNT WHERE data_time>=:start_time AND data_time<=:end_time and product_id=:product_id AND USER_ID=:user_id', null, 'start_time=String,end_time=String,product_id=Integer,user_id=Integer', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer,product_id=Integer,user_id=Integer', 'DATA_TIME=String,CHANNEL_NAME=String,PRODUCT_NAME=String,REGISTER_USER=Integer', '日期,渠道名称,应用名称,新增人数', null, '1', '2015-06-18');
INSERT INTO `rep_query` VALUES ('8412', 'dj_query_detail_count_admin', '报表查询：单机游戏数据统计(admin)', 'select DATA_TIME,PRODUCT_ID,CHANNEL_NAME,PRODUCT_NAME,REGISTER_USER from REP_DJ_DEVICE_COUNT WHERE data_time>=:start_time AND data_time<=:end_time ORDER BY data_time DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from REP_DJ_DEVICE_COUNT WHERE data_time>=:start_time AND data_time<=:end_time', null, 'start_time=String,end_time=String', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer', 'DATA_TIME=String,PRODUCT_ID=String,CHANNEL_NAME=String,PRODUCT_NAME=String,REGISTER_USER=Integer', '日期,产品ID,渠道名称,应用名称,新增人数', null, '1', null);
INSERT INTO `rep_query` VALUES ('74', 'dj_query_detail_count_total', '报表查询：单机游戏数据统计累计', 'SELECT \'合计\' DATA_TIME,\'-\' CHANNEL_NAME,\'-\' PRODUCT_NAME,sum(REGISTER_USER) REGISTER_USER FROM REP_DJ_DEVICE_COUNT WHERE data_time>=:start_time AND data_time<=:end_time and product_id=:product_id AND USER_ID=:user_id', null, '', null, 'start_time=String,end_time=String,product_id=Integer,user_id=Integer', 'DATA_TIME=String,CHANNEL_NAME=String,PRODUCT_NAME=String,REGISTER_USER=Integer', '日期,渠道名称,应用名称,新增人数', null, '1', '2015-06-24');
INSERT INTO `rep_query` VALUES ('8413', 'dj_query_detail_count_total_admin', '报表查询：单机游戏数据统计累计(admin)', 'SELECT \'合计\' DATA_TIME,\'-\' PRODUCT_ID,\'-\' CHANNEL_NAME,\'-\' PRODUCT_NAME,sum(REGISTER_USER) REGISTER_USER FROM REP_DJ_DEVICE_COUNT WHERE data_time>=:start_time AND data_time<=:end_time', null, null, null, 'start_time=String,end_time=String', 'DATA_TIME=String,PRODUCT_ID=String,CHANNEL_NAME=String,PRODUCT_NAME=String,REGISTER_USER=Integer', '日期,产品ID,渠道名称,应用名称,新增人数', null, '1', null);
INSERT INTO `rep_query` VALUES ('2', 'functionlog', '报表查询：功能日志', 'SELECT * FROM LOG_FUNCTION_CLICK WHERE LOG_TIME >= :start_time AND LOG_TIME <= :end_time ORDER BY LOG_TIME DESC LIMIT :start_index,:end_index', 'SELECT count(*) COUNT FROM LOG_FUNCTION_CLICK WHERE LOG_TIME >= :start_time AND LOG_TIME <= :end_time', null, 'start_time=String,end_time=String', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer', 'USER_ID=String,USER_NAME=String,USER_IP=String,FUNCTION_ID=String,FUNCTION_NAME=String,LOG_TIME=String', '登录名,用户名,登录IP,功能ID,功能名称,登录时间', '', '0', '2014-12-09');
INSERT INTO `rep_query` VALUES ('116', 'gfan_query_channel_count', '报表查询：查询机锋市场渠道调控信息', 'SELECT data_time,channel_id,channel_name,activate_count,active_count,apk_count,cpa_count,cps_count,pay_money,CONCAT(IFNULL(truncate(remain2_rate * 100,2),0),\'%\') remain2_rate,CONCAT(IFNULL(truncate(remain3_rate * 100,2),0),\'%\') remain3_rate,CONCAT(IFNULL(truncate(remain5_rate * 100,2),0),\'%\') remain5_rate,operate FROM gfan_channel_count_base_day WHERE data_time>=:start_time AND data_time<=:end_time ORDER BY data_time desc  LIMIT :start_index,:end_index', 'SELECT count(*) COUNT FROM gfan_channel_count_base_day WHERE data_time>=:start_time AND data_time<=:end_time ORDER BY data_time ', null, 'start_time=String,end_time=String', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer', 'data_time=String,channel_id=String,channel_name=String,activate_count=String,active_count=Integer,apk_count=Integer,cpa_count=Integer,cps_count=Integer,pay_money=String,remain2_rate=String,remain3_rate=String,remain5_rate=String,operate=String', '日期,渠道id,渠道名称,新增激活,日活跃,apk下载,cpa下载,cps下载,充值金额,次日留存,3日留存,5日留存,操作', 'distribute', '1', '2015-06-24');
INSERT INTO `rep_query` VALUES ('90', 'gfan_query_detail_count', '报表查询：机锋市场数据统计', 'select DATA_TIME,DAY_ACTIVATE_DIS,REMAIN2_RATE,REMAIN7_RATE from fact_channel WHERE data_time>=:start_time AND data_time<=:end_time and channel_code=:channel_code AND user_id=:user_id ORDER BY data_time DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from fact_channel WHERE data_time>=:start_time AND data_time<=:end_time and channel_code=:channel_code AND user_id=:user_id', null, 'start_time=String,end_time=String,channel_code=String,user_id=Integer', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer,channel_code=String,user_id=Integer', 'DATA_TIME=String,DAY_ACTIVATE_DIS=Integer,REMAIN2_RATE=String,REMAIN7_RATE=String', '日期,新增人数,次日留存,7日留存', 'distribute', '1', '2015-06-18');
INSERT INTO `rep_query` VALUES ('118', 'gfan_query_detail_count_admin', '报表查询：机锋市场数据统计(admin)', 'select DATA_TIME,CHANNEL_CODE,CHANNEL_NAME,DAY_ACTIVATE_COUNT,DAY_ACTIVATE_DIS,REMAIN2_RATE,REMAIN7_RATE from fact_channel WHERE data_time>=:start_time AND data_time<=:end_time  ORDER BY data_time DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from fact_channel WHERE data_time>=:start_time AND data_time<=:end_time ', null, 'start_time=String,end_time=String', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer', 'DATA_TIME=String,CHANNEL_CODE=String,CHANNEL_NAME=String,DAY_ACTIVATE_COUNT=Integer,DAY_ACTIVATE_DIS=Integer,REMAIN2_RATE=String,REMAIN7_RATE=String', '日期,渠道编号,渠道名称,新增人数,扣量后新增人数,次日留存,7日留存', 'distribute', '1', '2015-06-24');
INSERT INTO `rep_query` VALUES ('91', 'gfan_query_detail_count_total', '报表查询：机锋市场数据统计累计', 'SELECT \'合计\' DATA_TIME,sum(DAY_ACTIVATE_DIS) DAY_ACTIVATE_DIS,\'-\' REMAIN2_RATE,\'-\' REMAIN7_RATE FROM fact_channel WHERE data_time>=:start_time AND data_time<=:end_time and channel_code=:channel_code AND user_id=:user_id', null, '', null, 'start_time=String,end_time=String,channel_code=String,user_id=Integer', 'DATA_TIME=String,DAY_ACTIVATE_DIS=Integer,REMAIN2_RATE=String,REMAIN7_RATE=String', '日期,新增人数,次日留存,7日留存', 'distribute', '1', '2015-06-24');
INSERT INTO `rep_query` VALUES ('117', 'gfan_query_detail_count_total_admin', '报表查询：机锋市场数据统计累计(admin)', 'SELECT \'合计\' DATA_TIME,\'-\' CHANNEL_CODE,\'-\' CHANNEL_NAME,sum(DAY_ACTIVATE_COUNT) DAY_ACTIVATE_COUNT,sum(DAY_ACTIVATE_DIS) DAY_ACTIVATE_DIS,\'-\' REMAIN2_RATE,\'-\' REMAIN7_RATE FROM fact_channel WHERE data_time>=:start_time AND data_time<=:end_time', null, null, null, 'start_time=String,end_time=String', 'DATA_TIME=String,CHANNEL_CODE=String,CHANNEL_NAME=String,DAY_ACTIVATE_COUNT=Integer,DAY_ACTIVATE_DIS=Integer,REMAIN2_RATE=String,REMAIN7_RATE=String', '日期,渠道编号,渠道名称,新增人数,扣量后新增人数,次日留存,7日留存', 'distribute', '1', '2015-06-24');
INSERT INTO `rep_query` VALUES ('108', 'gfan_updata_info', '报表修改：机锋市场数据扣量', 'select CHANNEL_CODE,CHANNEL_NAME,concat(truncate(ALL_DIS * 100,0),\'%\') ALL_DIS,concat(truncate(CHANNEL_DIS * 100,0),\'%\') CHANNEL_DIS,OPERATE from dis_channel  ORDER BY ID DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from dis_channel ', null, '', 'start_index=Integer,end_index=Integer', 'CHANNEL_CODE=String,CHANNEL_NAME=String,ALL_DIS=String,CHANNEL_DIS=String,OPERATE=String', '渠道ID,渠道名称,默认扣量,渠道扣量,操作', 'distribute', '1', '2015-06-24');
INSERT INTO `rep_query` VALUES ('76', 'insert_product_dj', '更改表：单机游戏录入', 'INSERT INTO REP_DJ_DEVICE_COUNT(data_time,user_id,channel_name,product_id,product_name,register_user,insert_time) VALUES(:data_time,:user_id,:channel_name,:product_id,:product_name,:register_user,:insert_time)', null, null, null, 'data_time=String,user_id=Integer,channel_name=String,product_id=Integer,product_name=String,register_user=Integer,insert_time=String', 'data_time=String,user_id=Integer,channel_name=String,product_id=Integer,product_name=String,register_user=Integer,insert_time=String', '1,2,3,4,5,6,7', null, '1', '2015-06-26');
INSERT INTO `rep_query` VALUES ('71', 'ly_query_detail_count', '报表查询：联运游戏数据统计', 'select DATA_TIME,CHANNEL_NAME,PRODUCT_NAME,REGISTER_IMEL,REGISTER_USER,CONSUME_USER,AMPLE_MONEY from REP_LY_DEVICE_COUNT WHERE CHECK_MODE=1 and  data_time>=:start_time AND data_time<=:end_time and product_id=:product_id AND USER_ID=:user_id ORDER BY data_time DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from REP_LY_DEVICE_COUNT WHERE data_time>=:start_time AND data_time<=:end_time and product_id=:product_id and CHECK_MODE=1 AND USER_ID=:user_id', null, 'start_time=String,end_time=String,product_id=Integer,user_id=Integer', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer,product_id=Integer,user_id=Integer', 'DATA_TIME=String,CHANNEL_NAME=String,PRODUCT_NAME=String,REGISTER_IMEL=Integer,REGISTER_USER=Integer,CONSUME_USER=Integer,AMPLE_MONEY=Integer', '日期,渠道名称,应用名称,新增设备数,新增人数,付费人数,充值金额', 'uniongame', '1', '2015-06-18');
INSERT INTO `rep_query` VALUES ('71', 'ly_query_detail_count_admin', '报表查询：联运游戏数据统计(admin)', 'select DATA_TIME,CHANNEL_NAME,PRODUCT_NAME,BEFORE_REGISTER_IMEL,BEFORE_REGISTER_USER,BEFORE_CONSUME_USER,BEFORE_AMPLE_MONEY,CON_MONEY,IFNULL(CONCAT(truncate(REMAIN2_RATE*100,2),\'%\'),\'-\') REMAIN2_RATE,IFNULL(CONCAT(truncate(REMAIN2_RATE*100,2),\'%\'),\'-\') REMAIN3_RATE from REP_LY_DEVICE_COUNT WHERE CHECK_MODE=1 and  data_time>=:start_time AND data_time<=:end_time ORDER BY data_time DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from REP_LY_DEVICE_COUNT WHERE data_time>=:start_time AND data_time<=:end_time and CHECK_MODE=1', null, 'start_time=String,end_time=String', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer', 'DATA_TIME=String,CHANNEL_NAME=String,PRODUCT_NAME=String,BEFORE_REGISTER_IMEL=Integer,BEFORE_REGISTER_USER=Integer,BEFORE_CONSUME_USER=Integer,BEFORE_AMPLE_MONEY=Integer,CON_MONEY=Integer,REMAIN2_RATE=String,REMAIN3_RATE=String', '日期,渠道名称,应用名称,新增设备数,新增人数,付费人数,充值金额,充值ARPU,次日留存,3日留存', 'uniongame', '1', null);
INSERT INTO `rep_query` VALUES ('75', 'ly_query_detail_count_total', '报表查询：联运游戏数据统计累计', 'SELECT \'合计\' DATA_TIME,\'-\' CHANNEL_NAME,\'-\' PRODUCT_NAME,sum(REGISTER_IMEL) REGISTER_IMEL,sum(REGISTER_USER) REGISTER_USER,sum(CONSUME_USER) CONSUME_USER,sum(AMPLE_MONEY) AMPLE_MONEY FROM REP_LY_DEVICE_COUNT WHERE CHECK_MODE=1 and data_time>=:start_time AND data_time<=:end_time and product_id=:product_id AND USER_ID=:user_id', null, 'DATA_TIME', null, 'start_time=String,end_time=String,product_id=Integer,user_id=Integer', 'DATA_TIME=String,CHANNEL_NAME=String,PRODUCT_NAME=String,REGISTER_IMEL=Integer,REGISTER_USER=Integer,CONSUME_USER=Integer,AMPLE_MONEY=Integer', '日期,渠道名称,应用名称,新增设备数,新增人数,付费人数,充值金额', 'uniongame', '1', null);
INSERT INTO `rep_query` VALUES ('119', 'ly_query_detail_count_total_admin', '报表查询：联运游戏数据统计累计(admin)', 'SELECT \'合计\' DATA_TIME,\'-\' CHANNEL_NAME,\'-\' PRODUCT_NAME,sum(BEFORE_REGISTER_IMEL) BEFORE_REGISTER_IMEL,sum(BEFORE_REGISTER_USER) BEFORE_REGISTER_USER,sum(BEFORE_CONSUME_USER) BEFORE_CONSUME_USER,sum(BEFORE_AMPLE_MONEY) BEFORE_AMPLE_MONEY,sum(CON_MONEY) CON_MONEY,\'-\' REMAIN2_RATE,\'-\' REMAIN3_RATE FROM REP_LY_DEVICE_COUNT WHERE CHECK_MODE=1 and data_time>=:start_time AND data_time<=:end_time', null, null, null, 'start_time=String,end_time=String', 'DATA_TIME=String,CHANNEL_NAME=String,PRODUCT_NAME=String,BEFORE_REGISTER_IMEL=Integer,BEFORE_REGISTER_USER=Integer,BEFORE_CONSUME_USER=Integer,BEFORE_AMPLE_MONEY=Integer,CON_MONEY=Integer,REMAIN2_RATE=String,REMAIN3_RATE=String', '日期,渠道名称,应用名称,新增设备数,新增人数,付费人数,充值金额,充值ARPU,次日留存,3日留存', 'uniongame', '1', null);
INSERT INTO `rep_query` VALUES ('111', 'ly_updata_info', '报表修改：联运游戏数据扣量', 'select PRODUCT_NAME,CHANNEL_ID,CHANNEL_NAME,IF(DEAL_MODE=1,\'CPS\',\'CPA\') DEAL_MODE,concat(truncate(CHECK_PER * 100,0),\'%\') CHECK_PER,ORDER_ID,OPERATE from BASE_GAME_CHANNEL  ORDER BY ID DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from BASE_GAME_CHANNEL', null, '', 'start_index=Integer,end_index=Integer', 'PRODUCT_NAME=String,CHANNEL_ID=Integer,CHANNEL_NAME=String,DEAL_MODE=String,CHECK_PER=String,ORDER_ID=Integer,OPERATE=String', '产品名称,渠道ID,渠道名称,交易类型,扣量百分比,订单编号,操作', 'uniongame', '1', '2015-07-06');
INSERT INTO `rep_query` VALUES ('115', 'm_channel_id_gfan_query_channel_count', '报表查询：查询机锋市场渠道调控信息模糊channelid', 'SELECT data_time,channel_id,channel_name,activate_count,active_count,apk_count,cpa_count,cps_count,pay_money,CONCAT(IFNULL(truncate(remain2_rate * 100,2),0),\'%\') remain2_rate,CONCAT(IFNULL(truncate(remain3_rate * 100,2),0),\'%\') remain3_rate,CONCAT(IFNULL(truncate(remain5_rate * 100,2),0),\'%\') remain5_rate,operate FROM gfan_channel_count_base_day WHERE data_time>=:start_time AND data_time<=:end_time and channel_id=:channel_id ORDER BY data_time desc  LIMIT :start_index,:end_index', 'SELECT count(*) COUNT FROM gfan_channel_count_base_day WHERE data_time>=:start_time AND data_time<=:end_time and channel_id=:channel_id ORDER BY data_time ', null, 'start_time=String,end_time=String,channel_id=String', 'start_time=String,end_time=String,channel_id=String,start_index=Integer,end_index=Integer', 'data_time=String,channel_id=String,channel_name=String,activate_count=String,active_count=Integer,apk_count=Integer,cpa_count=Integer,cps_count=Integer,pay_money=String,remain2_rate=String,remain3_rate=String,remain5_rate=String,operate=String', '日期,渠道id,渠道名称,新增激活,日活跃,apk下载,cpa下载,cps下载,充值金额,次日留存,3日留存,5日留存,操作', 'distribute', '1', '2015-06-24');
INSERT INTO `rep_query` VALUES ('93', 'm_channel_id_gfan_query_detail_count_admin', '报表查询：机锋市场数据统计(admin)模糊id', 'select DATA_TIME,CHANNEL_CODE,CHANNEL_NAME,DAY_ACTIVATE_COUNT,DAY_ACTIVATE_DIS,REMAIN2_RATE,REMAIN7_RATE from fact_channel WHERE data_time>=:start_time AND data_time<=:end_time and channel_code=:channel_code ORDER BY data_time DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from fact_channel WHERE data_time>=:start_time AND data_time<=:end_time and channel_code=:channel_code', null, 'start_time=String,end_time=String,channel_code=String', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer,channel_code=String', 'DATA_TIME=String,CHANNEL_CODE=String,CHANNEL_NAME=String,DAY_ACTIVATE_COUNT=Integer,DAY_ACTIVATE_DIS=Integer,REMAIN2_RATE=String,REMAIN7_RATE=String', '日期,渠道编号,渠道名称,新增人数,扣量后新增人数,次日留存,7日留存', 'distribute', '1', '2015-06-24');
INSERT INTO `rep_query` VALUES ('94', 'm_channel_id_gfan_query_detail_count_total_admin', '报表查询：机锋市场数据统计累计(admin)模糊id', 'SELECT \'合计\' DATA_TIME,\'-\' CHANNEL_CODE,\'-\' CHANNEL_NAME,sum(DAY_ACTIVATE_COUNT) DAY_ACTIVATE_COUNT,sum(DAY_ACTIVATE_DIS) DAY_ACTIVATE_DIS,\'-\' REMAIN2_RATE,\'-\' REMAIN7_RATE FROM fact_channel WHERE data_time>=:start_time AND data_time<=:end_time and CHANNEL_CODE=:channel_code ', null, null, null, 'start_time=String,end_time=String,channel_code=String', 'DATA_TIME=String,CHANNEL_CODE=String,CHANNEL_NAME=String,DAY_ACTIVATE_COUNT=Integer,DAY_ACTIVATE_DIS=Integer,REMAIN2_RATE=String,REMAIN7_RATE=String', '日期,渠道编号,渠道名称,新增人数,扣量后新增人数,次日留存,7日留存', 'distribute', '1', '2015-06-24');
INSERT INTO `rep_query` VALUES ('107', 'm_channel_id_gfan_updata_info', '报表修改：机锋市场数据扣量模糊id', 'select CHANNEL_CODE,CHANNEL_NAME,concat(truncate(ALL_DIS * 100,0),\'%\') ALL_DIS,concat(truncate(CHANNEL_DIS * 100,0),\'%\') CHANNEL_DIS,OPERATE from dis_channel where CHANNEL_CODE=:channel_id ORDER BY ID DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from dis_channel  where CHANNEL_CODE=:channel_id', null, 'channel_id=String', 'channel_id=String,start_index=Integer,end_index=Integer', 'CHANNEL_CODE=String,CHANNEL_NAME=String,ALL_DIS=String,CHANNEL_DIS=String,OPERATE=String', '渠道ID,渠道名称,默认扣量,渠道扣量,操作', 'distribute', '1', '2015-06-24');
INSERT INTO `rep_query` VALUES ('105', 'm_channel_name_gfan_updata_info', '报表修改：机锋市场数据扣量模糊name', 'select CHANNEL_CODE,CHANNEL_NAME,concat(truncate(ALL_DIS * 100,0),\'%\') ALL_DIS,concat(truncate(CHANNEL_DIS * 100,0),\'%\') CHANNEL_DIS,OPERATE from dis_channel where CHANNEL_NAME LIKE :channel_name ORDER BY ID DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from dis_channel  where CHANNEL_NAME LIKE :channel_name', null, 'channel_name=String', 'channel_name=String,start_index=Integer,end_index=Integer', 'CHANNEL_CODE=String,CHANNEL_NAME=String,ALL_DIS=String,CHANNEL_DIS=String,OPERATE=String', '渠道ID,渠道名称,默认扣量,渠道扣量,操作', 'distribute', '1', '2015-06-24');
INSERT INTO `rep_query` VALUES ('122', 'm_channel_name_ly_query_detail_count_admin', '报表查询：联运游戏数据统计(admin)模糊name', 'select DATA_TIME,CHANNEL_NAME,PRODUCT_NAME,BEFORE_REGISTER_IMEL,BEFORE_REGISTER_USER,BEFORE_CONSUME_USER,BEFORE_AMPLE_MONEY,CON_MONEY,IFNULL(CONCAT(truncate(REMAIN2_RATE*100,2),\'%\'),\'-\') REMAIN2_RATE,IFNULL(CONCAT(truncate(REMAIN2_RATE*100,2),\'%\'),\'-\') REMAIN3_RATE from REP_LY_DEVICE_COUNT WHERE CHECK_MODE=1 and  data_time>=:start_time AND data_time<=:end_time and  CHANNEL_NAME like :channel_name ORDER BY data_time DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from REP_LY_DEVICE_COUNT WHERE data_time>=:start_time AND data_time<=:end_time and CHANNEL_NAME like :channel_name and CHECK_MODE=1', null, 'start_time=String,end_time=String,channel_name=String', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer,channel_name=String', 'DATA_TIME=String,CHANNEL_NAME=String,PRODUCT_NAME=String,BEFORE_REGISTER_IMEL=Integer,BEFORE_REGISTER_USER=Integer,BEFORE_CONSUME_USER=Integer,BEFORE_AMPLE_MONEY=Integer,CON_MONEY=Integer,REMAIN2_RATE=String,REMAIN3_RATE=String', '日期,渠道名称,应用名称,新增设备数,新增人数,付费人数,充值金额,充值ARPU,次日留存,3日留存', 'uniongame', '1', null);
INSERT INTO `rep_query` VALUES ('123', 'm_channel_name_ly_query_detail_count_total_admin', '报表查询：联运游戏数据统计累计(admin)模糊name', 'SELECT \'合计\' DATA_TIME,\'-\' CHANNEL_NAME,\'-\' PRODUCT_NAME,sum(BEFORE_REGISTER_IMEL) BEFORE_REGISTER_IMEL,sum(BEFORE_REGISTER_USER) BEFORE_REGISTER_USER,sum(BEFORE_CONSUME_USER) BEFORE_CONSUME_USER,sum(BEFORE_AMPLE_MONEY) BEFORE_AMPLE_MONEY,sum(CON_MONEY) CON_MONEY,\'-\' REMAIN2_RATE,\'-\' REMAIN3_RATE FROM REP_LY_DEVICE_COUNT WHERE CHECK_MODE=1 and data_time>=:start_time AND data_time<=:end_time and CHANNEL_NAME like :channel_name', null, null, null, 'start_time=String,end_time=String,channel_name=String', 'DATA_TIME=String,CHANNEL_NAME=String,PRODUCT_NAME=String,BEFORE_REGISTER_IMEL=Integer,BEFORE_REGISTER_USER=Integer,BEFORE_CONSUME_USER=Integer,BEFORE_AMPLE_MONEY=Integer,CON_MONEY=Integer,REMAIN2_RATE=String,REMAIN3_RATE=String', '日期,渠道名称,应用名称,新增设备数,新增人数,付费人数,充值金额,充值ARPU,次日留存,3日留存', 'uniongame', '1', null);
INSERT INTO `rep_query` VALUES ('110', 'm_channel_name_ly_updata_info', '报表修改：联运游戏数据扣量模糊产品渠道name', 'select PRODUCT_NAME,CHANNEL_ID,CHANNEL_NAME,IF(DEAL_MODE=1,\'CPA\',\'CPS\') DEAL_MODE,concat(truncate(CHECK_PER * 100,0),\'%\') CHECK_PER,ORDER_ID,OPERATE from BASE_GAME_CHANNEL where CHANNEL_NAME LIKE :channel_name ORDER BY ID DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from BASE_GAME_CHANNEL where CHANNEL_NAME LIKE :channel_name', null, 'channel_name=String', 'channel_name=String,start_index=Integer,end_index=Integer', 'PRODUCT_NAME=String,CHANNEL_ID=Integer,CHANNEL_NAME=String,DEAL_MODE=String,CHECK_PER=String,ORDER_ID=Integer,OPERATE=String', '产品名称,渠道ID,渠道名称,交易类型,扣量百分比,订单编号,操作', 'uniongame', '1', null);
INSERT INTO `rep_query` VALUES ('78', 'm_channel_product_name_ly_detail_count_admin', '报表查询：联运游戏数据统计(admin)模糊name', 'select DATA_TIME,CHANNEL_NAME,PRODUCT_NAME,BEFORE_REGISTER_IMEL,BEFORE_REGISTER_USER,BEFORE_CONSUME_USER,BEFORE_AMPLE_MONEY,CON_MONEY,IFNULL(CONCAT(truncate(REMAIN2_RATE*100,2),\'%\'),\'-\') REMAIN2_RATE,IFNULL(CONCAT(truncate(REMAIN2_RATE*100,2),\'%\'),\'-\') REMAIN3_RATE from REP_LY_DEVICE_COUNT WHERE CHECK_MODE=1 and  data_time>=:start_time AND data_time<=:end_time  and CHANNEL_NAME like :channel_name and PRODUCT_NAME like :product_name  ORDER BY data_time DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from REP_LY_DEVICE_COUNT WHERE data_time>=:start_time AND data_time<=:end_time and CHANNEL_NAME like :channel_name and PRODUCT_NAME like :product_name and CHECK_MODE=1', null, 'start_time=String,end_time=String,product_name=String,channel_name=String', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer,product_name=String,channel_name=String', 'DATA_TIME=String,CHANNEL_NAME=String,PRODUCT_NAME=String,BEFORE_REGISTER_IMEL=Integer,BEFORE_REGISTER_USER=Integer,BEFORE_CONSUME_USER=Integer,BEFORE_AMPLE_MONEY=Integer,CON_MONEY=Integer,REMAIN2_RATE=String,REMAIN3_RATE=String', '日期,渠道名称,应用名称,新增设备数,新增人数,付费人数,充值金额,充值ARPU,次日留存,3日留存', 'uniongame', '1', null);
INSERT INTO `rep_query` VALUES ('86', 'm_channel_product_name_ly_detail_count_total_admin', '报表查询：联运游戏数据统计累计(admin)模糊name', 'SELECT \'合计\' DATA_TIME,\'-\' CHANNEL_NAME,\'-\' PRODUCT_NAME,sum(BEFORE_REGISTER_IMEL) BEFORE_REGISTER_IMEL,sum(BEFORE_REGISTER_USER) BEFORE_REGISTER_USER,sum(BEFORE_CONSUME_USER) BEFORE_CONSUME_USER,sum(BEFORE_AMPLE_MONEY) BEFORE_AMPLE_MONEY,sum(CON_MONEY) CON_MONEY,\'-\' REMAIN2_RATE,\'-\' REMAIN3_RATE FROM REP_LY_DEVICE_COUNT WHERE CHECK_MODE=1 and data_time>=:start_time AND data_time<=:end_time and CHANNEL_NAME like :channel_name and PRODUCT_NAME like :product_name', null, null, null, 'start_time=String,end_time=String,product_name=String,channel_name=String', 'DATA_TIME=String,CHANNEL_NAME=String,PRODUCT_NAME=String,BEFORE_REGISTER_IMEL=Integer,BEFORE_REGISTER_USER=Integer,BEFORE_CONSUME_USER=Integer,BEFORE_AMPLE_MONEY=Integer,CON_MONEY=Integer,REMAIN2_RATE=String,REMAIN3_RATE=String', '日期,渠道名称,应用名称,新增设备数,新增人数,付费人数,充值金额,充值ARPU,次日留存,3日留存', 'uniongame', '1', null);
INSERT INTO `rep_query` VALUES ('771', 'm_product_id_dj_query_detail_count_admin', '报表查询：单机游戏数据统计(admin)模糊id', 'select DATA_TIME,PRODUCT_ID,CHANNEL_NAME,PRODUCT_NAME,REGISTER_USER from REP_DJ_DEVICE_COUNT WHERE data_time>=:start_time AND data_time<=:end_time and product_id=:product_id ORDER BY data_time DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from REP_DJ_DEVICE_COUNT WHERE data_time>=:start_time AND data_time<=:end_time and product_id=:product_id', null, 'start_time=String,end_time=String,product_id=Integer', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer,product_id=Integer', 'DATA_TIME=String,PRODUCT_ID=String,CHANNEL_NAME=String,PRODUCT_NAME=String,REGISTER_USER=Integer', '日期,产品ID,渠道名称,应用名称,新增人数', null, '1', null);
INSERT INTO `rep_query` VALUES ('851', 'm_product_id_dj_query_detail_count_total_admin', '报表查询：单机游戏数据统计累计(admin)模糊id', 'SELECT \'合计\' DATA_TIME,\'-\' PRODUCT_ID,\'-\' CHANNEL_NAME,\'-\' PRODUCT_NAME,sum(REGISTER_USER) REGISTER_USER FROM REP_DJ_DEVICE_COUNT WHERE data_time>=:start_time AND data_time<=:end_time and product_id=:product_id ', null, null, null, 'start_time=String,end_time=String,product_id=Integer', 'DATA_TIME=String,PRODUCT_ID=String,CHANNEL_NAME=String,PRODUCT_NAME=String,REGISTER_USER=Integer', '日期,产品ID,渠道名称,应用名称,新增人数', null, '1', null);
INSERT INTO `rep_query` VALUES ('109', 'm_product_name_ly_updata_info', '报表修改：联运游戏数据扣量模糊产品产品name', 'select PRODUCT_NAME,CHANNEL_ID,CHANNEL_NAME,IF(DEAL_MODE=1,\'CPA\',\'CPS\') DEAL_MODE,concat(truncate(CHECK_PER * 100,0),\'%\') CHECK_PER,ORDER_ID,OPERATE from BASE_GAME_CHANNEL where PRODUCT_NAME LIKE :product_name ORDER BY ID DESC LIMIT :start_index,:end_index', 'select count(id) COUNT from BASE_GAME_CHANNEL where PRODUCT_NAME LIKE :product_name', null, 'product_name=String', 'product_name=String,start_index=Integer,end_index=Integer', 'PRODUCT_NAME=String,CHANNEL_ID=Integer,CHANNEL_NAME=String,DEAL_MODE=String,CHECK_PER=String,ORDER_ID=Integer,OPERATE=String', '产品名称,渠道ID,渠道名称,交易类型,扣量百分比,订单编号,操作', 'uniongame', '1', null);
INSERT INTO `rep_query` VALUES ('112', 'm_user_displayname_user_updata_info', '报表查询：user用户表查询模糊id', 'SELECT id,display_name,user_name,register_time,IF(state=\'0\',\'正常\',\'禁用\') as state,operate FROM `user` where display_name like :user_displayname ORDER BY id DESC LIMIT :start_index,:end_index', 'SELECT count(*) as COUNT  FROM  `user`  where display_name like :user_displayname', null, 'user_displayname=String', 'start_index=Integer,end_index=Integer,user_displayname=String', 'id=String,display_name=String,user_name=String,register_time=String,state=String,operate=String', '用户ID,渠道名称,登录帐号,注册时间,用户状态,操作', null, '1', null);
INSERT INTO `rep_query` VALUES ('113', 'm_user_name_user_updata_info', '报表查询：user用户表查询模糊name', 'SELECT id,display_name,user_name,register_time,IF(state=\'0\',\'正常\',\'禁用\') as state,operate FROM `user` where user_name like :user_name ORDER BY id DESC LIMIT :start_index,:end_index', 'SELECT count(*) as COUNT  FROM  `user`  where display_name like :user_name  ', null, 'user_name=String', 'start_index=Integer,end_index=Integer,user_name=String', 'id=String,display_name=String,user_name=String,register_time=String,state=String,operate=String', '用户ID,渠道名称,登录帐号,注册时间,用户状态,操作', null, '1', null);
INSERT INTO `rep_query` VALUES ('3', 'querylog', '报表查询：查询日志', 'SELECT * FROM LOG_SQL_QUERY WHERE LOG_TIME >= :start_time AND LOG_TIME <= :end_time ORDER BY LOG_TIME DESC LIMIT :start_index,:end_index', 'SELECT count(*) COUNT FROM LOG_SQL_QUERY WHERE LOG_TIME >= :start_time AND LOG_TIME <= :end_time', null, 'start_time=String,end_time=String', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer', 'USER_ID=String,USER_NAME=String,USER_IP=String,REPORT_ID=String,QUERY_TYPE=String,LOG_TIME=String', '登录名,用户名,登录IP,查询ID,查询类型,登录时间', '', '0', '2014-12-09');
INSERT INTO `rep_query` VALUES ('100', 'role_select_user', 'SELECT查询：查询角色', 'SELECT id,`value` as name from p_role ORDER BY id DESC ', null, null, null, null, 'id=String,name=String', '序号,名称', null, '1', null);
INSERT INTO `rep_query` VALUES ('99', 'role_updata_info', '报表查询：role角色表查询', 'SELECT id,`value`,`name`,`desc`,operate FROM p_role ORDER BY id DESC LIMIT :start_index,:end_index', 'SELECT count(*) as COUNT  FROM  p_role', null, null, 'start_index=Integer,end_index=Integer', 'id=String,value=String,name=String,desc=String,operate=String', '角色ID,角色名称,角色关键字,角色描述,操作', null, '1', '2015-07-19');
INSERT INTO `rep_query` VALUES ('121', 'select_channel_ly_admin', 'SELECT查询：查询联运游戏应用名称(admin)', 'SELECT DISTINCT CHANNEL_ID,CHANNEL_NAME FROM REP_LY_DEVICE_COUNT where check_mode=1 ORDER BY data_time DESC', null, null, null, null, 'CHANNEL_ID=Integer,CHANNEL_NAME=String', '序号,名称', 'uniongame', '1', null);
INSERT INTO `rep_query` VALUES ('101', 'select_gfan_channel_count', 'SELECT查询：查询机锋市场统计调控', 'select channel_id as id,channel_name as name from gfan_channel_count_base_day GROUP BY channel_id ORDER BY data_time ', null, null, null, null, 'id=String,name=String', '序号,名称', 'distribute', '1', '2015-07-26');
INSERT INTO `rep_query` VALUES ('72', 'select_product_dj', 'SELECT查询：查询单机游戏应用名称', 'SELECT DISTINCT PRODUCT_ID,PRODUCT_NAME FROM REP_DJ_DEVICE_COUNT where USER_ID=:user_id ORDER BY data_time DESC', null, null, null, 'user_id=Integer', 'PRODUCT_ID=Integer,PRODUCT_NAME=String ', '序号,名称', null, '1', '2015-06-17');
INSERT INTO `rep_query` VALUES ('79', 'select_product_dj_admin', 'SELECT查询：查询单机游戏应用名称(admin)', 'SELECT DISTINCT PRODUCT_ID,PRODUCT_NAME FROM REP_DJ_DEVICE_COUNT  ORDER BY data_time DESC', null, null, null, null, 'PRODUCT_ID=Integer,PRODUCT_NAME=String', '序号,名称', null, '1', null);
INSERT INTO `rep_query` VALUES ('92', 'select_product_gfan', 'SELECT查询：查询机锋游戏应用名称', 'SELECT DISTINCT CHANNEL_CODE,CHANNEL_NAME FROM fact_channel where user_id=:user_id ORDER BY data_time DESC', null, null, null, 'user_id=Integer', 'CHANNEL_CODE=String,CHANNEL_NAME=String', '序号,名称', 'distribute', '1', '2015-06-17');
INSERT INTO `rep_query` VALUES ('95', 'select_product_gfan_admin', 'SELECT查询：查询机锋游戏应用名称(admin)', 'SELECT DISTINCT CHANNEL_CODE,CHANNEL_NAME FROM fact_channel ORDER BY data_time DESC', null, null, null, null, 'CHANNEL_CODE=String,CHANNEL_NAME=String', '序号,名称', 'distribute', '1', null);
INSERT INTO `rep_query` VALUES ('73', 'select_product_ly', 'SELECT查询：查询联运游戏应用名称', 'SELECT DISTINCT PRODUCT_ID,PRODUCT_NAME FROM REP_LY_DEVICE_COUNT where check_mode=1 AND USER_ID=:user_id ORDER BY data_time DESC', null, null, null, 'user_id=Integer', 'PRODUCT_ID=Integer,PRODUCT_NAME=String', '序号,名称', 'uniongame', '1', '2015-06-18');
INSERT INTO `rep_query` VALUES ('84', 'select_product_ly_admin', 'SELECT查询：查询联运游戏应用名称(admin)', 'SELECT DISTINCT PRODUCT_ID,PRODUCT_NAME FROM REP_LY_DEVICE_COUNT where channel_name like :channel_name and check_mode=1 ORDER BY data_time DESC', null, null, '', 'channel_name=String', 'PRODUCT_ID=Integer,PRODUCT_NAME=String', '序号,名称', 'uniongame', '1', '2015-07-19');
INSERT INTO `rep_query` VALUES ('1', 'userlog', '报表查询：登录日志', 'SELECT * FROM LOG_USER_LOGIN WHERE LOG_TIME >= :start_time AND LOG_TIME <= :end_time ORDER BY LOG_TIME DESC LIMIT :start_index,:end_index', 'SELECT count(*) COUNT FROM LOG_USER_LOGIN WHERE LOG_TIME >= :start_time AND LOG_TIME <= :end_time', null, 'start_time=String,end_time=String', 'start_time=String,end_time=String,start_index=Integer,end_index=Integer', 'USER_ID=String,USER_NAME=String,USER_IP=String,LOG_TIME=String', '登录名,用户名,登录IP,登录时间', '', '0', '2014-12-08');
INSERT INTO `rep_query` VALUES ('114', 'user_updata_info', '报表查询：user用户表查询', 'SELECT id,display_name,user_name,register_time,IF(state=\'0\',\'正常\',\'禁用\') as state,operate FROM `user`  ORDER BY id DESC LIMIT :start_index,:end_index', 'SELECT count(*) as COUNT  FROM  `user`   ', null, '', 'start_index=Integer,end_index=Integer', 'id=String,display_name=String,user_name=String,register_time=String,state=String,operate=String', '用户ID,渠道名称,登录帐号,注册时间,用户状态,操作', null, '1', '2015-07-18');

-- ----------------------------
-- Table structure for trans_log
-- ----------------------------
DROP TABLE IF EXISTS `trans_log`;
CREATE TABLE `trans_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_time` varchar(16) NOT NULL COMMENT '数据所属日期',
  `table_name` varchar(64) NOT NULL COMMENT '传输的表名称',
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '是否已经处理。0：没有处理。1：已经处理。',
  `duration` int(11) NOT NULL COMMENT '传输的时间：单位秒',
  `insert_time` datetime DEFAULT NULL COMMENT '数据插入时间',
  UNIQUE KEY `id` (`id`),
  KEY `data_time` (`data_time`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 COMMENT='每天计算的记录';

-- ----------------------------
-- Records of trans_log
-- ----------------------------
INSERT INTO `trans_log` VALUES ('19', '2015-06-30', 'REP_LY_DEVICE_COUNT', '0', '0', '2015-07-13 11:46:20');
INSERT INTO `trans_log` VALUES ('20', '2015-07-01', 'REP_LY_DEVICE_COUNT', '0', '0', '2015-07-13 11:46:31');
INSERT INTO `trans_log` VALUES ('21', '2015-07-02', 'REP_LY_DEVICE_COUNT', '0', '0', '2015-07-13 11:46:44');
INSERT INTO `trans_log` VALUES ('22', '2015-07-03', 'REP_LY_DEVICE_COUNT', '0', '0', '2015-07-13 11:46:55');
INSERT INTO `trans_log` VALUES ('23', '2015-07-04', 'REP_LY_DEVICE_COUNT', '0', '0', '2015-07-13 11:47:27');
INSERT INTO `trans_log` VALUES ('24', '2015-07-05', 'REP_LY_DEVICE_COUNT', '0', '0', '2015-07-13 11:48:12');
INSERT INTO `trans_log` VALUES ('25', '2015-07-06', 'REP_LY_DEVICE_COUNT', '0', '0', '2015-07-13 11:48:29');
INSERT INTO `trans_log` VALUES ('26', '2015-07-07', 'REP_LY_DEVICE_COUNT', '0', '0', '2015-07-13 11:48:39');
INSERT INTO `trans_log` VALUES ('116', '2015-09-04', 'fact_channel', '0', '0', '2015-09-06 11:28:43');
INSERT INTO `trans_log` VALUES ('117', '2015-09-05', 'fact_channel', '0', '0', '2015-09-06 11:30:19');
INSERT INTO `trans_log` VALUES ('118', '2015-09-06', 'fact_channel', '0', '0', '2015-09-07 12:09:45');
INSERT INTO `trans_log` VALUES ('119', '2015-09-07', 'fact_channel', '0', '0', '2015-09-10 17:42:08');
INSERT INTO `trans_log` VALUES ('120', '2015-09-08', 'fact_channel', '0', '0', '2015-09-10 17:43:35');
INSERT INTO `trans_log` VALUES ('121', '2015-09-09', 'fact_channel', '0', '0', '2015-09-10 17:45:11');
INSERT INTO `trans_log` VALUES ('122', '2015-09-10', 'fact_channel', '0', '0', '2015-09-11 13:47:22');
INSERT INTO `trans_log` VALUES ('123', '2015-09-11', 'fact_channel', '0', '0', '2015-09-14 10:47:54');
INSERT INTO `trans_log` VALUES ('124', '2015-09-12', 'fact_channel', '0', '0', '2015-09-14 11:25:49');
INSERT INTO `trans_log` VALUES ('125', '2015-09-13', 'fact_channel', '0', '0', '2015-09-14 11:29:01');
INSERT INTO `trans_log` VALUES ('126', '2015-09-14', 'fact_channel', '0', '0', '2015-09-17 18:25:28');
INSERT INTO `trans_log` VALUES ('127', '2015-09-15', 'fact_channel', '0', '0', '2015-09-17 18:27:34');
INSERT INTO `trans_log` VALUES ('128', '2015-09-16', 'fact_channel', '0', '0', '2015-09-17 18:37:00');
INSERT INTO `trans_log` VALUES ('129', '2015-09-17', 'fact_channel', '0', '0', '2015-09-24 10:33:25');
INSERT INTO `trans_log` VALUES ('130', '2015-09-18', 'fact_channel', '0', '0', '2015-09-24 10:35:29');

-- ----------------------------
-- Table structure for ui_fw_function
-- ----------------------------
DROP TABLE IF EXISTS `ui_fw_function`;
CREATE TABLE `ui_fw_function` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ACTION_URL` varchar(3800) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `MODULE_ID` int(11) DEFAULT NULL,
  `ONLINE_STATUS` smallint(6) DEFAULT NULL,
  `SORT` int(11) DEFAULT NULL,
  `READ_CACHE` smallint(6) DEFAULT NULL,
  `IS_HIDE` tinyint(1) DEFAULT '0',
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `FUNCTION_TYPE` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ui_fw_function
-- ----------------------------
INSERT INTO `ui_fw_function` VALUES ('9', '登陆日志', '/frame/main.gfan', '4', '1', '1', '0', '0', '2014-12-09 11:08:16', '2014-09-05 12:34:44', '21');
INSERT INTO `ui_fw_function` VALUES ('10', '功能日志', '/frame/main.gfan', '4', '1', '2', '0', '0', '2014-12-09 11:16:59', '2014-12-09 11:16:41', '21');
INSERT INTO `ui_fw_function` VALUES ('11', '查询日志', '/frame/main.gfan', '4', '1', '3', '0', '0', '2014-12-09 11:17:00', '2014-12-09 11:16:44', '21');
INSERT INTO `ui_fw_function` VALUES ('23', '单机游戏统计', '/frame/main.gfan', '11', '1', '1', '0', '0', '2015-06-17 16:40:36', '2015-05-27 16:54:44', '21');
INSERT INTO `ui_fw_function` VALUES ('24', '联运游戏统计', '/frame/main.gfan', '11', '1', '3', '0', '0', '2015-07-21 15:46:01', '2015-06-11 16:54:49', '21');
INSERT INTO `ui_fw_function` VALUES ('25', '单机游戏录入&添加', '/frame/main.gfan', '12', '1', '1', '0', '0', '2015-07-16 18:46:33', '2015-06-23 10:07:47', '21');
INSERT INTO `ui_fw_function` VALUES ('26', '单机游戏统计admin', '/frame/main.gfan', '11', '1', '2', '0', '0', '2015-07-21 15:45:57', '2015-06-30 12:00:53', '21');
INSERT INTO `ui_fw_function` VALUES ('27', '联运游戏统计admin', '/frame/main.gfan', '11', '1', '4', '0', '0', '2015-07-21 15:46:05', '2015-06-30 12:00:55', '21');
INSERT INTO `ui_fw_function` VALUES ('28', '联运游戏渠道扣量', '/frame/main.gfan', '12', '1', '3', '0', '0', '2015-07-16 18:09:03', '2015-07-02 16:32:23', '21');
INSERT INTO `ui_fw_function` VALUES ('29', '机锋市场渠道数据统计', '/frame/main.gfan', '11', '1', '5', '0', '0', '2015-07-21 15:46:06', '2015-07-07 16:56:31', '21');
INSERT INTO `ui_fw_function` VALUES ('30', '机锋市场渠道数据统计admin', '/frame/main.gfan', '11', '1', '6', '0', '0', '2015-07-21 15:46:09', '2015-07-07 16:56:33', '21');
INSERT INTO `ui_fw_function` VALUES ('31', '联运游戏渠道添加', '/frame/main.gfan', '12', '1', '2', '0', '0', '2015-07-16 18:08:51', '2015-07-14 18:27:26', '21');
INSERT INTO `ui_fw_function` VALUES ('32', '机锋市场渠道添加', '/frame/main.gfan', '12', '1', '4', '0', '0', '2015-07-16 18:11:54', '2015-07-16 18:11:44', '21');
INSERT INTO `ui_fw_function` VALUES ('33', '机锋市场渠道扣量', '/frame/main.gfan', '12', '1', '5', '0', '0', '2015-07-16 18:11:52', '2015-07-16 18:11:44', '21');
INSERT INTO `ui_fw_function` VALUES ('34', '用户管理', '/frame/main.gfan', '13', '1', '1', '0', '0', '2015-07-18 23:24:35', '2015-07-18 23:24:29', '21');
INSERT INTO `ui_fw_function` VALUES ('35', '角色管理', '/frame/main.gfan', '13', '1', '3', '0', '0', '2015-07-30 10:27:09', '2015-07-18 23:24:29', '21');
INSERT INTO `ui_fw_function` VALUES ('36', '机锋市场渠道调控', '/frame/main.gfan', '11', '1', '7', '0', '0', '2015-07-26 21:56:15', '2015-07-26 21:56:09', '21');
INSERT INTO `ui_fw_function` VALUES ('37', '用户管理gfan', '/frame/main.gfan', '13', '1', '2', '0', '0', '2015-07-30 10:27:05', '2015-07-29 12:14:43', '21');

-- ----------------------------
-- Table structure for ui_fw_function_widget
-- ----------------------------
DROP TABLE IF EXISTS `ui_fw_function_widget`;
CREATE TABLE `ui_fw_function_widget` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_URL` varchar(3800) COLLATE utf8_bin DEFAULT NULL,
  `WIDGET_TYPE` smallint(4) DEFAULT NULL,
  `FUNCTION_ID` int(11) DEFAULT '0',
  `SORT` int(11) DEFAULT '0',
  `LEVEL` smallint(4) DEFAULT '0',
  `ENABLE_CACHE` int(11) DEFAULT NULL,
  `PARENT_ID` int(11) DEFAULT '0',
  `CREATE_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ui_fw_function_widget
-- ----------------------------
INSERT INTO `ui_fw_function_widget` VALUES ('1', '登录日志', '/frame/weblog/user_log', '1', '9', '1', '1', '1', '0', '2014-09-03 15:34:10', '2014-09-03 15:34:19');
INSERT INTO `ui_fw_function_widget` VALUES ('2', '功能日志', '/frame/weblog/function_log', '1', '10', '1', '1', '1', '0', '2014-12-09 11:17:39', '2014-12-09 11:17:44');
INSERT INTO `ui_fw_function_widget` VALUES ('3', '查询日志', '/frame/weblog/query_log', '1', '11', '1', '1', '1', '0', '2014-12-09 11:17:42', '2014-12-09 11:17:46');
INSERT INTO `ui_fw_function_widget` VALUES ('23', '单机游戏统计', '/frame/business/dj_device_count', '1', '23', '1', '1', '1', '0', '2015-06-11 17:11:13', '2015-05-29 17:11:19');
INSERT INTO `ui_fw_function_widget` VALUES ('24', '联运游戏统计', '/frame/business/ly_device_count', '1', '24', '3', '1', '1', '0', '2015-06-17 17:11:23', '2015-06-05 17:11:26');
INSERT INTO `ui_fw_function_widget` VALUES ('28', '单机游戏录入&添加', '/frame/business/dj_insert_info', '1', '25', '1', '1', '1', '0', '2015-06-23 10:09:23', '2015-06-23 10:09:28');
INSERT INTO `ui_fw_function_widget` VALUES ('29', '单机游戏统计admin', '/frame/business/dj_device_count_admin', '1', '26', '2', '1', '1', '0', '2015-06-30 12:02:47', '2015-06-30 12:02:53');
INSERT INTO `ui_fw_function_widget` VALUES ('30', '联运游戏统计admin', '/frame/business/ly_device_count_admin', '1', '27', '4', '1', '1', '0', '2015-06-30 12:02:49', '2015-06-30 12:02:55');
INSERT INTO `ui_fw_function_widget` VALUES ('31', '联运游戏渠道扣量', '/frame/business/ly_updata_info', '1', '28', '1', '1', '1', '0', '2015-07-02 16:33:01', '2015-07-02 16:33:03');
INSERT INTO `ui_fw_function_widget` VALUES ('32', '机锋市场渠道数据admin', '/frame/business/gfan_device_count_admin', '1', '30', '6', '1', '1', '0', '2015-07-07 16:57:00', '2015-07-07 16:57:02');
INSERT INTO `ui_fw_function_widget` VALUES ('33', '机锋市场渠道数据', '/frame/business/gfan_device_count', '1', '29', '5', '1', '1', '0', '2015-07-07 16:57:14', '2015-07-07 16:57:16');
INSERT INTO `ui_fw_function_widget` VALUES ('34', '联运游戏渠道添加', '/frame/business/ly_insert_info', '1', '31', '1', '1', '1', '0', '2015-07-14 18:28:00', '2015-07-14 18:28:03');
INSERT INTO `ui_fw_function_widget` VALUES ('35', '机锋市场渠道扣量', '/frame/business/gfan_updata_info', '1', '33', '1', '1', '1', '0', '2015-07-14 18:28:00', '2015-07-14 18:28:00');
INSERT INTO `ui_fw_function_widget` VALUES ('36', '机锋市场渠道添加', '/frame/business/gfan_insert_info', '1', '32', '1', '1', '1', '0', '2015-07-14 18:28:00', '2015-07-14 18:28:00');
INSERT INTO `ui_fw_function_widget` VALUES ('37', '用户管理', '/frame/business/user_updata_info', '1', '34', '1', '1', '1', '0', '2015-07-14 18:28:00', '2015-07-14 18:28:00');
INSERT INTO `ui_fw_function_widget` VALUES ('38', '角色管理', '/frame/business/role_updata_info', '1', '35', '3', '1', '1', '0', '2015-07-14 18:28:00', '2015-07-14 18:28:00');
INSERT INTO `ui_fw_function_widget` VALUES ('39', '机锋市场调控', '/frame/business/gfan_channel_count_admin', '1', '36', '1', '1', '1', '0', '2015-07-26 21:57:00', '2015-07-26 21:57:03');
INSERT INTO `ui_fw_function_widget` VALUES ('40', '用户管理gfan', '/frame/business/user_updata_info_gfan', '1', '37', '2', '1', '1', '0', '2015-07-29 12:15:47', '2015-07-29 12:15:49');

-- ----------------------------
-- Table structure for ui_fw_module
-- ----------------------------
DROP TABLE IF EXISTS `ui_fw_module`;
CREATE TABLE `ui_fw_module` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) NOT NULL,
  `ACTION_URL` varchar(300) DEFAULT NULL,
  `MODULE_LEVEL` smallint(6) NOT NULL DEFAULT '1',
  `PARENT_ID` int(11) NOT NULL DEFAULT '0',
  `SORT` int(11) NOT NULL DEFAULT '1',
  `VIEW_TYPE` varchar(64) DEFAULT NULL,
  `IMG_URL` varchar(100) DEFAULT NULL,
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ui_fw_module
-- ----------------------------
INSERT INTO `ui_fw_module` VALUES ('4', '系统功能', '#', '2', '0', '4', 'frontReportType', null, '2015-07-18 23:21:07', '2014-09-25 15:54:23');
INSERT INTO `ui_fw_module` VALUES ('11', '数据展示', '#', '2', '0', '1', 'frontReportType', null, '2015-07-21 15:39:56', '2015-06-10 16:52:58');
INSERT INTO `ui_fw_module` VALUES ('12', '数据管理', '#', '2', '0', '2', 'frontReportType', null, '2015-07-21 15:40:10', '2015-07-02 16:31:42');
INSERT INTO `ui_fw_module` VALUES ('13', '权限管理', '#', '2', '0', '3', 'frontReportType', null, '2015-07-18 23:21:19', '2015-07-18 23:21:13');

-- ----------------------------
-- Table structure for ui_fw_role_function_link
-- ----------------------------
DROP TABLE IF EXISTS `ui_fw_role_function_link`;
CREATE TABLE `ui_fw_role_function_link` (
  `ROLE_ID` int(11) NOT NULL,
  `FUNCTION_ID` int(11) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`FUNCTION_ID`),
  KEY `FK_UI_FW_ROLE_FUNCTION_LINK_FUNCTION_ID` (`FUNCTION_ID`),
  CONSTRAINT `UI_FW_ROLE_FUNCTION_LINK_ibfk_1` FOREIGN KEY (`FUNCTION_ID`) REFERENCES `ui_fw_function` (`ID`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ui_fw_role_function_link
-- ----------------------------
INSERT INTO `ui_fw_role_function_link` VALUES ('0', '34');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '9');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '10');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '11');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '23');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '24');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '25');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '26');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '27');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '28');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '29');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '30');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '31');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '32');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '33');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '34');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '35');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '36');
INSERT INTO `ui_fw_role_function_link` VALUES ('501', '37');
INSERT INTO `ui_fw_role_function_link` VALUES ('602', '23');
INSERT INTO `ui_fw_role_function_link` VALUES ('603', '9');
INSERT INTO `ui_fw_role_function_link` VALUES ('603', '10');
INSERT INTO `ui_fw_role_function_link` VALUES ('603', '11');
INSERT INTO `ui_fw_role_function_link` VALUES ('603', '25');
INSERT INTO `ui_fw_role_function_link` VALUES ('603', '26');
INSERT INTO `ui_fw_role_function_link` VALUES ('603', '34');
INSERT INTO `ui_fw_role_function_link` VALUES ('604', '24');
INSERT INTO `ui_fw_role_function_link` VALUES ('605', '9');
INSERT INTO `ui_fw_role_function_link` VALUES ('605', '10');
INSERT INTO `ui_fw_role_function_link` VALUES ('605', '11');
INSERT INTO `ui_fw_role_function_link` VALUES ('605', '27');
INSERT INTO `ui_fw_role_function_link` VALUES ('605', '28');
INSERT INTO `ui_fw_role_function_link` VALUES ('605', '31');
INSERT INTO `ui_fw_role_function_link` VALUES ('605', '34');
INSERT INTO `ui_fw_role_function_link` VALUES ('606', '29');
INSERT INTO `ui_fw_role_function_link` VALUES ('607', '9');
INSERT INTO `ui_fw_role_function_link` VALUES ('607', '10');
INSERT INTO `ui_fw_role_function_link` VALUES ('607', '11');
INSERT INTO `ui_fw_role_function_link` VALUES ('607', '30');
INSERT INTO `ui_fw_role_function_link` VALUES ('607', '32');
INSERT INTO `ui_fw_role_function_link` VALUES ('607', '33');
INSERT INTO `ui_fw_role_function_link` VALUES ('607', '37');
INSERT INTO `ui_fw_role_function_link` VALUES ('611', '23');
INSERT INTO `ui_fw_role_function_link` VALUES ('611', '29');
INSERT INTO `ui_fw_role_function_link` VALUES ('612', '9');
INSERT INTO `ui_fw_role_function_link` VALUES ('612', '10');
INSERT INTO `ui_fw_role_function_link` VALUES ('612', '11');
INSERT INTO `ui_fw_role_function_link` VALUES ('612', '25');
INSERT INTO `ui_fw_role_function_link` VALUES ('612', '26');
INSERT INTO `ui_fw_role_function_link` VALUES ('612', '30');
INSERT INTO `ui_fw_role_function_link` VALUES ('612', '32');
INSERT INTO `ui_fw_role_function_link` VALUES ('612', '33');
INSERT INTO `ui_fw_role_function_link` VALUES ('612', '34');
INSERT INTO `ui_fw_role_function_link` VALUES ('612', '37');
INSERT INTO `ui_fw_role_function_link` VALUES ('613', '9');
INSERT INTO `ui_fw_role_function_link` VALUES ('613', '10');
INSERT INTO `ui_fw_role_function_link` VALUES ('613', '11');
INSERT INTO `ui_fw_role_function_link` VALUES ('613', '36');

-- ----------------------------
-- Table structure for ui_fw_role_module_link
-- ----------------------------
DROP TABLE IF EXISTS `ui_fw_role_module_link`;
CREATE TABLE `ui_fw_role_module_link` (
  `ROLE_ID` int(11) NOT NULL,
  `MODULE_ID` int(11) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`MODULE_ID`),
  KEY `FK_UI_FW_ROLE_MODULE_LINK_MODULE_ID` (`MODULE_ID`),
  CONSTRAINT `UI_FW_ROLE_MODULE_LINK_ibfk_1` FOREIGN KEY (`MODULE_ID`) REFERENCES `ui_fw_module` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ui_fw_role_module_link
-- ----------------------------
INSERT INTO `ui_fw_role_module_link` VALUES ('501', '4');
INSERT INTO `ui_fw_role_module_link` VALUES ('501', '11');
INSERT INTO `ui_fw_role_module_link` VALUES ('501', '12');
INSERT INTO `ui_fw_role_module_link` VALUES ('501', '13');
INSERT INTO `ui_fw_role_module_link` VALUES ('602', '11');
INSERT INTO `ui_fw_role_module_link` VALUES ('603', '4');
INSERT INTO `ui_fw_role_module_link` VALUES ('603', '11');
INSERT INTO `ui_fw_role_module_link` VALUES ('603', '12');
INSERT INTO `ui_fw_role_module_link` VALUES ('603', '13');
INSERT INTO `ui_fw_role_module_link` VALUES ('604', '11');
INSERT INTO `ui_fw_role_module_link` VALUES ('605', '4');
INSERT INTO `ui_fw_role_module_link` VALUES ('605', '11');
INSERT INTO `ui_fw_role_module_link` VALUES ('605', '12');
INSERT INTO `ui_fw_role_module_link` VALUES ('605', '13');
INSERT INTO `ui_fw_role_module_link` VALUES ('606', '11');
INSERT INTO `ui_fw_role_module_link` VALUES ('607', '4');
INSERT INTO `ui_fw_role_module_link` VALUES ('607', '11');
INSERT INTO `ui_fw_role_module_link` VALUES ('607', '12');
INSERT INTO `ui_fw_role_module_link` VALUES ('607', '13');
INSERT INTO `ui_fw_role_module_link` VALUES ('611', '11');
INSERT INTO `ui_fw_role_module_link` VALUES ('612', '4');
INSERT INTO `ui_fw_role_module_link` VALUES ('612', '11');
INSERT INTO `ui_fw_role_module_link` VALUES ('612', '12');
INSERT INTO `ui_fw_role_module_link` VALUES ('612', '13');
INSERT INTO `ui_fw_role_module_link` VALUES ('613', '4');
INSERT INTO `ui_fw_role_module_link` VALUES ('613', '11');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User Id，自增',
  `display_name` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户显示名称',
  `user_name` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户登录名称，用于兼容开发者账号，对于新用户，user_name和email相同',
  `email` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT 'email，只有验证通过的email，才允许用email登录',
  `email_validated` bit(1) DEFAULT b'0' COMMENT '邮箱是否验证 0，认证 1，未认证',
  `user_name_type` bit(1) DEFAULT b'1' COMMENT '0 用户名（老用户），1邮箱',
  `type` tinyint(4) DEFAULT '1' COMMENT '1内部用户，2外部用户',
  `is_admin` bit(1) DEFAULT b'1' COMMENT '是否是身份系统管理账号',
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  `ou_id` int(11) DEFAULT NULL COMMENT '所属OU',
  `pwd_change_required` bit(1) DEFAULT b'0' COMMENT '下次登录是否需要修改密码',
  `state` int(11) DEFAULT '0' COMMENT '状态：1 禁用，0启用,-1删除',
  `operate` varchar(255) COLLATE utf8_bin DEFAULT '修改' COMMENT '功能按钮',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110000568 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('100000001', 'admin@gfan.com', 'admin@gfan.com', 'admin@gfan.com', '\0', '', '1', '', '2014-06-20 10:22:30', null, '\0', '0', '修改');
INSERT INTO `user` VALUES ('110000287', '田昊月', 'tianhaoyue@imopan.com', 'tianhaoyue@imopan.com', '\0', '', '1', '', '2015-06-03 14:51:26', null, '\0', '0', '修改');
INSERT INTO `user` VALUES ('110000307', '汤圣', 'tangsheng@imopan.com', 'tangsheng@imopan.com', '\0', '', '1', '', '2015-06-15 17:36:44', null, '\0', '0', '修改');
INSERT INTO `user` VALUES ('110000308', '高阳', 'gaoyang@imopan.com', 'gaoyang@imopan.com', '\0', '', '1', '', '2015-06-15 17:37:17', null, '\0', '0', '修改');
INSERT INTO `user` VALUES ('110000309', '张娜', 'zhangna@imopan.com', 'zhangna@imopan.com', '\0', '', '1', '', '2015-08-10 10:14:24', null, '\0', '0', '修改');
INSERT INTO `user` VALUES ('110000350', '张坚', '2362080020@qq.com', '2362080020@qq.com', '\0', '', '1', '', '2015-07-13 15:37:02', null, '\0', '0', '修改');
INSERT INTO `user` VALUES ('110000351', '金岩石', 'jinyanshi@163.com', 'jinyanshi@163.com', '\0', '', '1', '', '2015-07-13 17:40:04', null, '\0', '0', '修改');
INSERT INTO `user` VALUES ('110000354', '亚风通讯', 'jifeng10@163.com', 'jifeng10@163.com', '\0', '', '1', '', '2015-07-14 11:02:52', null, '\0', '0', '修改');
INSERT INTO `user` VALUES ('110000355', '华友数码', 'huayou@163.com', 'huayou@163.com', '\0', '', '1', '', '2015-07-14 11:03:33', null, '\0', '0', '修改');
INSERT INTO `user` VALUES ('110000356', '网盟', 'jifeng9@163.com', 'jifeng9@163.com', '\0', '', '1', '', '2015-07-14 11:04:22', null, '\0', '0', '修改');
INSERT INTO `user` VALUES ('110000357', '唯一网络', 'jifeng3@163.com', 'jifeng3@163.com', '\0', '', '1', '', '2015-07-14 11:05:11', null, '\0', '0', '修改');
INSERT INTO `user` VALUES ('110000358', '陕西海创', 'jifeng8@163.com', 'jifeng8@163.com', '\0', '', '1', '', '2015-07-14 11:06:33', null, '\0', '0', '修改');
INSERT INTO `user` VALUES ('110000359', 'yuanhui.chi@maien360.com', 'yuanhui.chi@maien360.com', 'yuanhui.chi@maien360.com', '\0', '', '2', '', '2015-07-14 16:40:14', null, '\0', '0', '修改');
INSERT INTO `user` VALUES ('110000567', '赤迈', 'jing.cheng@youxia-inc.com', 'jing.cheng@youxia-inc.com', '\0', '', '1', '', '2015-11-27 18:53:14', null, '\0', '0', '修改');

-- ----------------------------
-- Table structure for user_pwd
-- ----------------------------
DROP TABLE IF EXISTS `user_pwd`;
CREATE TABLE `user_pwd` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'user_pwd id,自增',
  `user_id` int(11) DEFAULT NULL COMMENT 'user id',
  `pwd_hash` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '密码Hash sha1',
  `pwd_salt` varchar(8) CHARACTER SET utf8 DEFAULT NULL COMMENT '密码Salt',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=568 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of user_pwd
-- ----------------------------
INSERT INTO `user_pwd` VALUES ('1', '100000001', 'a6b0ac83099e598eb248097fae3235b8', 'h7AVEWWK');
INSERT INTO `user_pwd` VALUES ('2', '110000001', 'bfd56b0a5f7aec8345b42887e46a8077', 'gReMQ2ft');
INSERT INTO `user_pwd` VALUES ('553', '110000553', '0b00ae8a7743c6f3262efcef419c18e3', 'gi5yylFa');
INSERT INTO `user_pwd` VALUES ('554', '110000554', '8557c0515e46d6aad2a10b528e856615', '1Gmv7P3d');
INSERT INTO `user_pwd` VALUES ('555', '110000555', '4cc2c853c0312f339dfcb3c06f0be966', 'Oxap{3w1');
INSERT INTO `user_pwd` VALUES ('556', '110000556', '92eb5f17ab5768f6a0ff4874f6bce192', 'qiMtxKmc');
INSERT INTO `user_pwd` VALUES ('557', '110000557', '6342068b94c50018a54c247b47797c72', 'jBdfX1tE');
INSERT INTO `user_pwd` VALUES ('558', '110000558', '4cc339407e39f7983049e7ff80ff7105', 'zybb3Iwh');
INSERT INTO `user_pwd` VALUES ('559', '110000559', '167abf6c5c7ae792f93b1980e724bf16', 'YMfYnhJs');
INSERT INTO `user_pwd` VALUES ('560', '110000560', '27fa4a36f0b112eda503a90ce592e3b0', 'vnr3Wnp0');
INSERT INTO `user_pwd` VALUES ('561', '110000561', '8f2b9e37ea4f4a0c0f83cb373b54dccc', 'h1DaJT7O');
INSERT INTO `user_pwd` VALUES ('562', '110000562', '9f32bc12e3fd3b655a61a32b39b3f4b9', 'jroFH8bT');
INSERT INTO `user_pwd` VALUES ('563', '110000563', '364f6ce7e7bf60dde86bdfaac1e167b7', 'ONjswtMh');
INSERT INTO `user_pwd` VALUES ('564', '110000564', 'a37e72550b839dde9ca386d27ef0692e', '6Weo4nA2');
INSERT INTO `user_pwd` VALUES ('565', '110000565', 'e9dd0dc87c5ec1a416c43c482c41f08c', '6jLTbMh4');
INSERT INTO `user_pwd` VALUES ('566', '110000566', '7c6d841d271000aa93ef60a15e861837', 'vezL0Lsg');
INSERT INTO `user_pwd` VALUES ('567', '110000567', '941843ee62ac2cad497af0dd4de8089c', 'mxEnxs37');
