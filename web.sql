/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : 127.0.0.1:3306
 Source Schema         : web

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 24/11/2020 22:21:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `book_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NULL DEFAULT NULL,
  `book_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`book_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, 2, '经济管理');
INSERT INTO `book` VALUES (2, 1, 'C++语言');
INSERT INTO `book` VALUES (3, 1, '离散数学');
INSERT INTO `book` VALUES (4, 3, '中国文化');
INSERT INTO `book` VALUES (5, 1, 'PHP基础');

-- ----------------------------
-- Table structure for book_type
-- ----------------------------
DROP TABLE IF EXISTS `book_type`;
CREATE TABLE `book_type`  (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_type
-- ----------------------------
INSERT INTO `book_type` VALUES (1, '计算机类');
INSERT INTO `book_type` VALUES (2, '经济类');
INSERT INTO `book_type` VALUES (3, '文艺类');

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置的key键名',
  `value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置的val值',
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置分组',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, 'smtp_server', 'smtp.qq.com111', 'smtp');
INSERT INTO `config` VALUES (2, 'smtp_port', '465', 'smtp');
INSERT INTO `config` VALUES (3, 'smtp_user', '331549185@qq.com', 'smtp');
INSERT INTO `config` VALUES (4, 'smtp_pwd', '12017700', 'smtp');
INSERT INTO `config` VALUES (5, 'regis_smtp_enable', '1', 'smtp');
INSERT INTO `config` VALUES (6, 'email_id', '11', 'smtp');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` int(11) NULL DEFAULT NULL,
  `status` tinyint(2) NULL DEFAULT 1 COMMENT '1 正常 2至顶  0 隐藏',
  `views` int(11) NULL DEFAULT 0 COMMENT '阅读次数',
  PRIMARY KEY (`news_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 96 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (87, 1, NULL, '社会新闻1', '<p>asdfasdfasfd</p><p>asdfasdfasfd</p><p style=\"line-height: 16px;\"><img src=\"http://mytp.com/static/ueditor/dialogs/attachment/fileTypeImages/icon_doc.gif\"/><a style=\"font-size:12px; color:#0066cc;\" href=\"/uploads/20200329/1585489452524431.docx\" title=\"2016版毕业要求.docx\">2016版毕业要求.docx</a></p><p><br/></p>', 1586414643, 1, 0);
INSERT INTO `news` VALUES (88, 3, NULL, '经济新闻1', '<p>asdf00</p><p>asdfasdfasdf</p><p>asdfasdfasdf</p>', 1586414594, 2, 0);
INSERT INTO `news` VALUES (89, 3, NULL, '经济新闻1', '<p>asdfasdfasfd1</p><p>asdfasdfasfd</p><p style=\"line-height: 16px;\"><img src=\"http://mytp.com/static/ueditor/dialogs/attachment/fileTypeImages/icon_doc.gif\"/><a style=\"font-size:12px; color:#0066cc;\" href=\"/uploads/20200329/1585489452524431.docx\" title=\"2016版毕业要求.docx\">2016版毕业要求.docx</a></p><p><br/></p>', 1586414632, 0, 0);
INSERT INTO `news` VALUES (93, 2, NULL, '体育新闻1', '<p>99</p>', 1588490378, 1, 0);
INSERT INTO `news` VALUES (94, 1, NULL, 'web网页课设', '<p>大家好~</p>', 1591345129, 1, 0);

-- ----------------------------
-- Table structure for news_type
-- ----------------------------
DROP TABLE IF EXISTS `news_type`;
CREATE TABLE `news_type`  (
  `type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news_type
-- ----------------------------
INSERT INTO `news_type` VALUES (1, '社会新闻');
INSERT INTO `news_type` VALUES (2, '体育新闻');
INSERT INTO `news_type` VALUES (3, '经济新闻');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `url` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `parent_id` int(5) NOT NULL DEFAULT 0 COMMENT '父栏目ID',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `visible` tinyint(1) NULL DEFAULT 1 COMMENT '是否可见',
  `open` tinyint(1) NULL DEFAULT 1 COMMENT '1',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '', '系统功能', 'layui-icon-set', 0, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (2, '/admin/menu/index', '菜单管理', '', 1, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (3, '/admin/role/index', '角色管理', '', 1, 3, 1, 1);
INSERT INTO `sys_menu` VALUES (4, '/admin/user/index', '用户管理', '', 1, 2, 1, 1);
INSERT INTO `sys_menu` VALUES (5, '/admin/news/index', '新闻列表', '', 6, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (6, '', '新闻管理', 'layui-icon-date', 0, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (7, '/admin/news_type/index', '新闻类别', '', 6, 2, 1, 1);
INSERT INTO `sys_menu` VALUES (8, '', '图书管理', 'layui-icon-read', 0, 8, 1, 1);
INSERT INTO `sys_menu` VALUES (9, '/teach/books/index', '图书列表', '', 8, 1, 1, 1);
INSERT INTO `sys_menu` VALUES (10, '/teach/books/type', '图书类别', '', 8, 2, 1, 1);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `role_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menus` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', '1,2,3,4,5,6,7,8,9,10,');
INSERT INTO `sys_role` VALUES (2, '老师', 'teacher', '1,4,8,9,10,');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(70) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `role_id` mediumint(8) NULL DEFAULT NULL COMMENT '分组ID',
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `realname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `gender` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `login_time` int(11) NULL DEFAULT NULL COMMENT '最后登录时间',
  `status` tinyint(2) NULL DEFAULT 1 COMMENT '状态',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `online` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `user_username`(`username`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 73 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '1', 'c4ca4238a0b923820dcc509a6f75849b', 1, '4', '超管', '女', '24', 1606227488, 1, NULL, 0);
INSERT INTO `sys_user` VALUES (58, 'zh', 'c4ca4238a0b923820dcc509a6f75849b', 2, '1', '曾辉', '男', '', 1606227577, 1, '/uploads/20201124/c764388e79ebea5ec136aa3afb29ae5e.jpg', 1);

SET FOREIGN_KEY_CHECKS = 1;
