/*
 Navicat Premium Data Transfer

 Source Server         : yue
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3307
 Source Schema         : web

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 24/06/2021 14:57:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sw_course
-- ----------------------------
DROP TABLE IF EXISTS `sw_course`;
CREATE TABLE `sw_course`  (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程名',
  `semester_id` int(22) NULL DEFAULT NULL COMMENT '学期',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上课地址',
  `time` date NULL DEFAULT NULL COMMENT '上课时间',
  `credit` int(11) NULL DEFAULT NULL COMMENT '学分',
  `quantity` int(11) NULL DEFAULT NULL COMMENT '容量',
  `selected_number` int(11) NULL DEFAULT 0 COMMENT '已选',
  `rest_number` int(11) NULL DEFAULT NULL COMMENT '可选',
  `user_id` int(10) NULL DEFAULT NULL COMMENT '任课教师',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '未开班' COMMENT '开班状态',
  `select_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '未选课' COMMENT '选课状态',
  PRIMARY KEY (`course_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `semester_id`(`semester_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sw_course
-- ----------------------------
INSERT INTO `sw_course` VALUES (20, '【1508100011】高等数学(A)Ⅰ', 1, '逸夫楼', '2021-06-16', 4, 120, 2, 118, 80, '未开班', '未选课');
INSERT INTO `sw_course` VALUES (18, '【1509100011】大学英语Ⅰ', 1, '明智楼', '2021-06-17', 4, 120, 10, 110, 81, '已开班', '未选课');
INSERT INTO `sw_course` VALUES (19, '【1508100311】大学物理Ⅰ', 2, '31栋', '2021-06-19', 4, 120, 2, 118, 82, '已开班', '已选课');
INSERT INTO `sw_course` VALUES (17, '【1506110890】离散数学', 3, '明智楼', '2021-06-14', 4, 120, 0, 120, 83, '未开班', '未选课');
INSERT INTO `sw_course` VALUES (16, '【1506110260】计算机网络', 4, '6栋', '2021-06-15', 4, 120, 1, 119, 84, '已开班', '未选课');
INSERT INTO `sw_course` VALUES (15, '【1506110900】数据结构', 3, '明智楼', '2021-06-19', 4, 120, 0, 120, 85, '已开班', '未选课');
INSERT INTO `sw_course` VALUES (14, '【1506110360】操作系统', 5, '逸夫楼', '2021-06-15', 4, 120, 0, 120, 86, '未开班', '未选课');
INSERT INTO `sw_course` VALUES (13, '【1506190130】软件工程', 6, '明智楼', '2021-06-18', 4, 120, 0, 120, 87, '未开班', '未选课');
INSERT INTO `sw_course` VALUES (12, '【1514190020】信息安全技术', 6, '逸夫楼', '2021-06-14', 4, 120, 0, 120, 83, '已开班', '未选课');
INSERT INTO `sw_course` VALUES (11, '【1506110880】编译原理', 6, '逸夫楼', '2021-06-15', 4, 120, 1, 119, 88, '已开班', '已选课');
INSERT INTO `sw_course` VALUES (22, '【1508100012】高等数学(A)Ⅱ', 2, '逸夫楼', '2021-06-16', 4, 40, 1, 39, 80, '已开班', '未选课');
INSERT INTO `sw_course` VALUES (24, '【1509101482】大学英语Ⅱ', 2, '明智楼', '2021-06-16', 4, 30, 2, 28, 81, '已开班', '未选课');

-- ----------------------------
-- Table structure for sw_menu
-- ----------------------------
DROP TABLE IF EXISTS `sw_menu`;
CREATE TABLE `sw_menu`  (
  `menu_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '菜单编号',
  `url` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单地址',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `parent_id` int(5) NOT NULL DEFAULT 0 COMMENT '父栏目ID',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  `visible` tinyint(1) NULL DEFAULT 1 COMMENT '是否可见',
  `open` tinyint(1) NULL DEFAULT 1 COMMENT '是否展开',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sw_menu
-- ----------------------------
INSERT INTO `sw_menu` VALUES (1, '', '系统功能', 'layui-icon-set', 0, 1, 1, 1);
INSERT INTO `sw_menu` VALUES (2, '/sw/role/index', '角色管理', NULL, 1, 1, 1, 1);
INSERT INTO `sw_menu` VALUES (3, '/sw/user/index', '用户管理', NULL, 1, 3, 1, 1);
INSERT INTO `sw_menu` VALUES (4, '', '选课管理', 'layui-icon-app', 0, 1, 1, 1);
INSERT INTO `sw_menu` VALUES (5, '/sw/course/index', '课程列表', NULL, 4, 1, 1, 1);
INSERT INTO `sw_menu` VALUES (6, '/sw/semester/index', '学期', NULL, 4, 1, 1, 1);
INSERT INTO `sw_menu` VALUES (7, '', '课程管理', 'layui-icon-home', 0, 1, 1, 1);
INSERT INTO `sw_menu` VALUES (8, '/sw/select/teacher_select', '选课学生列表', NULL, 7, 1, 1, 1);
INSERT INTO `sw_menu` VALUES (9, '/sw/course/teacher_form', '我的课程列表', NULL, 7, 1, 1, 1);
INSERT INTO `sw_menu` VALUES (10, '/sw/select/student_select', '已选课程列表', NULL, 4, 1, 1, 1);
INSERT INTO `sw_menu` VALUES (11, '', '成绩管理', 'layui-icon-read', 0, 1, 1, 1);
INSERT INTO `sw_menu` VALUES (12, '/sw/select/teacher_score', '班级成绩', NULL, 11, 1, 1, 1);
INSERT INTO `sw_menu` VALUES (13, '/sw/select/student_score', '我的成绩', NULL, 11, 1, 1, 1);
INSERT INTO `sw_menu` VALUES (14, '/sw/select/select', '选课列表', NULL, 7, 1, 1, 1);

-- ----------------------------
-- Table structure for sw_role
-- ----------------------------
DROP TABLE IF EXISTS `sw_role`;
CREATE TABLE `sw_role`  (
  `role_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `role_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menus` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sw_role
-- ----------------------------
INSERT INTO `sw_role` VALUES (1, 'admin', 'admin', '1,2,3,4,5,6,7,14,');
INSERT INTO `sw_role` VALUES (2, 'student', 'student', '4,5,10,11,13,');
INSERT INTO `sw_role` VALUES (3, 'teacher', 'teacher', '4,5,7,8,9,11,12,');

-- ----------------------------
-- Table structure for sw_select
-- ----------------------------
DROP TABLE IF EXISTS `sw_select`;
CREATE TABLE `sw_select`  (
  `select_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NULL DEFAULT NULL COMMENT '学生编号',
  `teacher_id` int(11) NULL DEFAULT NULL COMMENT '教师编号',
  `course_id` int(11) NULL DEFAULT NULL COMMENT '课程编号',
  `course_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程名称',
  `semester_id` int(11) NULL DEFAULT NULL COMMENT '学期',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上课地址',
  `time` date NULL DEFAULT NULL COMMENT '上课时间',
  `credit` int(11) NULL DEFAULT NULL COMMENT '学分',
  `score_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '未打分' COMMENT '分数状态',
  `normal_score` int(5) NULL DEFAULT NULL COMMENT '平时成绩',
  `test_score` int(5) NULL DEFAULT NULL COMMENT '考试成绩',
  `total_score` int(5) NULL DEFAULT NULL COMMENT '总评分',
  `grade_score` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '等级',
  PRIMARY KEY (`select_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 52 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sw_select
-- ----------------------------
INSERT INTO `sw_select` VALUES (1, 91, 80, 20, '【1508100011】高等数学(A)Ⅰ', 1, '逸夫楼', '2021-06-16', 4, '已打分', 91, 91, 91, '优秀');
INSERT INTO `sw_select` VALUES (2, 92, 80, 20, '【1508100011】高等数学(A)Ⅰ', 1, '逸夫楼', '2021-06-16', 4, '已打分', 80, 80, 80, '良好');
INSERT INTO `sw_select` VALUES (3, 91, 81, 18, '【1509100011】大学英语Ⅰ', 1, '明智楼', '2021-06-17', 4, '已打分', 75, 75, 75, '中等');
INSERT INTO `sw_select` VALUES (47, 91, 81, 18, '【1509100011】大学英语Ⅰ', 1, '明智楼', '2021-06-17', 4, '未打分', NULL, NULL, NULL, '');
INSERT INTO `sw_select` VALUES (48, 91, 80, 22, '【1508100012】高等数学(A)Ⅱ', 2, '逸夫楼', '2021-06-16', 4, '未打分', NULL, NULL, NULL, '');
INSERT INTO `sw_select` VALUES (49, 91, 84, 16, '【1506110260】计算机网络', 4, '6栋', '2021-06-15', 4, '未打分', NULL, NULL, NULL, NULL);
INSERT INTO `sw_select` VALUES (50, 91, 82, 19, '【1508100311】大学物理Ⅰ', 2, '31栋', '2021-06-19', 4, '未打分', NULL, NULL, NULL, NULL);
INSERT INTO `sw_select` VALUES (51, 91, 88, 11, '【1506110880】编译原理', 6, '逸夫楼', '2021-06-15', 4, '已打分', 65, 65, 65, '及格');

-- ----------------------------
-- Table structure for sw_semester
-- ----------------------------
DROP TABLE IF EXISTS `sw_semester`;
CREATE TABLE `sw_semester`  (
  `semester_id` int(11) NOT NULL AUTO_INCREMENT,
  `semester_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`semester_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sw_semester
-- ----------------------------
INSERT INTO `sw_semester` VALUES (1, '2018-2019第一学期');
INSERT INTO `sw_semester` VALUES (2, '2018-2019第二学期');
INSERT INTO `sw_semester` VALUES (3, '2019-2020第一学期');
INSERT INTO `sw_semester` VALUES (4, '2019-2020第二学期');
INSERT INTO `sw_semester` VALUES (5, '2020-2021第一学期');
INSERT INTO `sw_semester` VALUES (6, '2020-2021第二学期');
INSERT INTO `sw_semester` VALUES (7, '2021-2022第一学期');
INSERT INTO `sw_semester` VALUES (8, '2021-2022第二学期');

-- ----------------------------
-- Table structure for sw_user
-- ----------------------------
DROP TABLE IF EXISTS `sw_user`;
CREATE TABLE `sw_user`  (
  `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(70) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `real_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `role_id` mediumint(8) NULL DEFAULT NULL COMMENT '角色编号',
  `gender` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '性别',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '江西南昌' COMMENT '家庭地址',
  `status` tinyint(2) NULL DEFAULT 1,
  `login_time` int(11) NULL DEFAULT NULL,
  `online` int(11) NULL DEFAULT NULL,
  `company` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `identity` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 94 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sw_user
-- ----------------------------
INSERT INTO `sw_user` VALUES (80, '2001', 'c4ca4238a0b923820dcc509a6f75849b', '左黎明', 3, '男', '/uploads/20210616/7e3b52b4388fdf582b50b49b8e9fe617.png', '18079014431', '江西赣州', 1, 1624516265, 1, '信息工程学院', '教授');
INSERT INTO `sw_user` VALUES (81, '2002', 'c4ca4238a0b923820dcc509a6f75849b', '李宗', 3, '女', '/uploads/20210617/b8e0f726a7a904edd57a0aeaa776d5fa.png', '11111111111', '江西南昌', 1, 1624034162, 0, '信息工程学院', '讲师');
INSERT INTO `sw_user` VALUES (82, '2003', 'c4ca4238a0b923820dcc509a6f75849b', '刘正方', 3, '男', NULL, '18079002222', '江西南昌', 1, NULL, 0, '信息工程学院', '副教授');
INSERT INTO `sw_user` VALUES (83, '2004', 'c4ca4238a0b923820dcc509a6f75849b', '万涛', 3, '女', NULL, '18079001111', '江西南昌', 1, NULL, 0, '信息工程学院', '副教授');
INSERT INTO `sw_user` VALUES (84, '2005', 'c4ca4238a0b923820dcc509a6f75849b', '谢昕', 3, '男', '/uploads/20201230/a11502d2fc1026fdb0397364a153093f.jpg', '19970720985', '江西赣州', 1, NULL, 0, '信息工程学院', '教授');
INSERT INTO `sw_user` VALUES (85, '2006', 'c4ca4238a0b923820dcc509a6f75849b', '刘艳丽', 3, '女', '/uploads/20210109/fe8ec829606d2260f9dc3a8a3e489027.jpg', '19970720985', '江西赣州于都', 1, NULL, 0, '信息工程学院', '教授');
INSERT INTO `sw_user` VALUES (86, '2007', 'c4ca4238a0b923820dcc509a6f75849b', '刘美香', 3, '女', NULL, '11111111113', '江西南昌', 1, NULL, 0, '信息工程学院', '讲师');
INSERT INTO `sw_user` VALUES (87, '2008', 'c4ca4238a0b923820dcc509a6f75849b', '舒文豪', 3, '女', '/uploads/20201230/a11502d2fc1026fdb0397364a153093f.jpg', '19970720985', '江西赣州', 1, NULL, 0, '信息工程学院', '副教授');
INSERT INTO `sw_user` VALUES (88, '2009', 'c4ca4238a0b923820dcc509a6f75849b', '邹长军', 3, '男', '/uploads/20201230/a11502d2fc1026fdb0397364a153093f.jpg', '19970720985', '江西赣州', 1, 1624503768, 0, '信息工程学院', '讲师');
INSERT INTO `sw_user` VALUES (91, '2018061008000401', 'c4ca4238a0b923820dcc509a6f75849b', '小艾', 2, '男', '', '19970720994', '江西赣州', 1, 1624517437, 1, '信息工程学院', '本专科生');
INSERT INTO `sw_user` VALUES (92, '2018061008000402', 'c4ca4238a0b923820dcc509a6f75849b', '小承', 2, '女', NULL, '12333532354', '江西赣州', 1, 1624034140, 0, '信息工程学院', '本专科生');
INSERT INTO `sw_user` VALUES (93, 'admin', 'c4ca4238a0b923820dcc509a6f75849b', 'admin', 1, '男', NULL, '19023456879', '江西赣州', 1, 1624514026, 0, '信息工程学院', '管理员');

SET FOREIGN_KEY_CHECKS = 1;
