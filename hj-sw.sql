/*
 Navicat Premium Data Transfer

 Source Server         : iamhj
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : sw

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 09/07/2021 17:35:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hj_goods
-- ----------------------------
DROP TABLE IF EXISTS `hj_goods`;
CREATE TABLE `hj_goods`  (
  `goods_id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type_id` int(11) NULL DEFAULT NULL,
  `price` int(11) NULL DEFAULT NULL,
  `number` int(11) NULL DEFAULT NULL,
  `describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `seller_id` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`goods_id`) USING BTREE,
  INDEX `user_id`(`seller_id`) USING BTREE,
  INDEX `type_id`(`type_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hj_goods
-- ----------------------------
INSERT INTO `hj_goods` VALUES (20, 'ThinkPHP网站开发教程', 4, 15, 20, '本书讲解使用ThinkPHP框架开发动态网站，有丰富的实战例子。', 'https://img10.360buyimg.com/n1/s200x200_jfs/t1/137034/33/225/47746/5eca3b72Ec415a16b/38ba44c31adade76.jpg', 84);
INSERT INTO `hj_goods` VALUES (18, 'Type-C数据线', 2, 5, 20, '适合Type-C充电接口的数码产品；双面都能充电', 'https://img13.360buyimg.com/n1/s450x450_jfs/t1/111738/21/13859/29678/5f27d8adE29e30fd4/c61787aba129b976.jpg', 84);
INSERT INTO `hj_goods` VALUES (19, '小风扇', 3, 10, 20, 'Micro-USB接口可充电迷你小风扇，绿色的', 'http://www.doublepow.com/Uploads/5acad69ad9c20.jpg', 84);
INSERT INTO `hj_goods` VALUES (21, '白色U盘', 2, 20, 20, '128G超大容量的U盘', 'https://img12.360buyimg.com/n7/jfs/t1/125142/12/10776/80410/5f4473f0Eeed8da73/870f3709c4480751.jpg', 84);
INSERT INTO `hj_goods` VALUES (17, '黑色签字笔', 1, 1, 20, '巨能写签字笔，油墨超多，书写时间超长', 'https://cdn.cnbj0.fds.api.mi-img.com/b2c-shopapi-pms/pms_1559616366.16874615.jpg', 84);
INSERT INTO `hj_goods` VALUES (25, '无线充电套装', 2, 50, 20, '20W高通无线充；白色', '/uploads/20210108/cc1770e74ba65cf7a49bbdecd0865c1c.jpg', 87);
INSERT INTO `hj_goods` VALUES (26, '自拍杆', 2, 20, 20, '小米支架式自拍杆；雅蓝色', '/uploads/20210108/5b0b1d39583d32c9c7d2a7f5a07ff651.jpg', 87);

-- ----------------------------
-- Table structure for hj_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `hj_goods_type`;
CREATE TABLE `hj_goods_type`  (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hj_goods_type
-- ----------------------------
INSERT INTO `hj_goods_type` VALUES (1, '学习用品');
INSERT INTO `hj_goods_type` VALUES (2, '数码产品');
INSERT INTO `hj_goods_type` VALUES (3, '生活用品');
INSERT INTO `hj_goods_type` VALUES (4, '书籍');

-- ----------------------------
-- Table structure for hj_menu
-- ----------------------------
DROP TABLE IF EXISTS `hj_menu`;
CREATE TABLE `hj_menu`  (
  `menu_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '菜单编号',
  `url` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单地址',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `parent_id` int(5) NOT NULL DEFAULT 0 COMMENT '父栏目ID',
  `sort` int(11) NULL DEFAULT 1 COMMENT '排序',
  `visible` tinyint(1) NULL DEFAULT NULL COMMENT '是否可见',
  `open` tinyint(1) NULL DEFAULT NULL COMMENT '是否展开',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hj_menu
-- ----------------------------
INSERT INTO `hj_menu` VALUES (4, '', '商品管理', 'layui-icon-app', 0, 1, 1, 1);
INSERT INTO `hj_menu` VALUES (5, '/hj/goods/index', '所有商品', '', 4, 1, 1, 1);
INSERT INTO `hj_menu` VALUES (6, '/hj/goods_type/index', '商品类型', NULL, 4, 1, 1, 1);
INSERT INTO `hj_menu` VALUES (7, '', '店铺管理', 'layui-icon-home', 0, 1, 1, 1);
INSERT INTO `hj_menu` VALUES (8, '/hj/order/seller_order', '店铺订单', '', 7, 1, 1, 1);
INSERT INTO `hj_menu` VALUES (9, '/hj/goods/seller_form', '店铺商品', '', 7, 1, 1, 1);
INSERT INTO `hj_menu` VALUES (10, '/hj/order/buyer_order', '购买订单', '', 4, 1, 1, 1);

-- ----------------------------
-- Table structure for hj_order
-- ----------------------------
DROP TABLE IF EXISTS `hj_order`;
CREATE TABLE `hj_order`  (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `buyer_id` int(11) NULL DEFAULT NULL COMMENT '买家编号',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人姓名',
  `seller_id` int(11) NULL DEFAULT NULL COMMENT '卖家编号',
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货地址',
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品编号',
  `goods_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `buy_number` int(11) NULL DEFAULT NULL COMMENT '商品数量',
  `pay` int(11) NULL DEFAULT NULL COMMENT '支付金额',
  `send_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '未发货' COMMENT '商品发货状态',
  `receive_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '未收货' COMMENT '商品收货状态',
  `picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 50 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hj_order
-- ----------------------------
INSERT INTO `hj_order` VALUES (41, 89, '刘燕', 84, '13879003333', '湖北省武汉市555号', 21, '白色U盘', 1, 20, '未发货', '未收货', 'https://img12.360buyimg.com/n7/jfs/t1/125142/12/10776/80410/5f4473f0Eeed8da73/870f3709c4480751.jpg');
INSERT INTO `hj_order` VALUES (38, 85, '李明', 87, '13879001111', '江西省南昌市111号', 25, '无线充电套装', 1, 50, '未发货', '未收货', '/uploads/20210108/cc1770e74ba65cf7a49bbdecd0865c1c.jpg');
INSERT INTO `hj_order` VALUES (42, 84, '王红', 84, '13879002222', '北京市111号', 17, '黑色签字笔', 1, 1, '未发货', '未收货', 'https://cdn.cnbj0.fds.api.mi-img.com/b2c-shopapi-pms/pms_1559616366.16874615.jpg');
INSERT INTO `hj_order` VALUES (40, 89, '刘燕', 87, '13879003333', '湖北省武汉市555号', 26, '自拍杆', 1, 20, '未发货', '未收货', '/uploads/20210108/5b0b1d39583d32c9c7d2a7f5a07ff651.jpg');
INSERT INTO `hj_order` VALUES (37, 85, '张三峰', 84, '18079003333', '江西省华东交通大学1号', 20, 'ThinkPHP网站开发教程', 1, 15, '已发货', '未收货', 'https://img10.360buyimg.com/n1/s200x200_jfs/t1/137034/33/225/47746/5eca3b72Ec415a16b/38ba44c31adade76.jpg');
INSERT INTO `hj_order` VALUES (49, 85, '李明', 84, '13879001111', '江西省南昌市111号', 21, '白色U盘', 1, 20, '未发货', '未收货', 'https://img12.360buyimg.com/n7/jfs/t1/125142/12/10776/80410/5f4473f0Eeed8da73/870f3709c4480751.jpg');

-- ----------------------------
-- Table structure for hj_role
-- ----------------------------
DROP TABLE IF EXISTS `hj_role`;
CREATE TABLE `hj_role`  (
  `role_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `menus` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hj_role
-- ----------------------------
INSERT INTO `hj_role` VALUES (2, '普通用户', '4,5,10,');
INSERT INTO `hj_role` VALUES (3, '店主', '4,5,7,8,9,10,');

-- ----------------------------
-- Table structure for hj_user
-- ----------------------------
DROP TABLE IF EXISTS `hj_user`;
CREATE TABLE `hj_user`  (
  `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(70) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `real_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `role_id` mediumint(8) NULL DEFAULT NULL COMMENT '角色编号',
  `gender` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '性别',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货地址',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 90 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hj_user
-- ----------------------------
INSERT INTO `hj_user` VALUES (87, 'seller2', 'e10adc3949ba59abbe56e057f20f883e', '胡帅', 3, '男', '', '13879004444', '上海市333号');
INSERT INTO `hj_user` VALUES (85, 'buyer1', 'e10adc3949ba59abbe56e057f20f883e', '李明', 2, '男', '/uploads/20201230/4016080765fb9e9a5bf68385f2d00358.jpg', '13879001111', '江西省南昌市111号');
INSERT INTO `hj_user` VALUES (84, 'seller1', 'e10adc3949ba59abbe56e057f20f883e', '王红', 3, '女', '', '13879002222', '北京市111号');
INSERT INTO `hj_user` VALUES (89, 'buyer2', 'e10adc3949ba59abbe56e057f20f883e', '刘燕', 2, '女', '', '13879003333', '湖北省武汉市555号');

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
) ENGINE = MyISAM AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sw_course
-- ----------------------------
INSERT INTO `sw_course` VALUES (20, '【1508100011】高等数学(A)Ⅰ', 1, '逸夫楼', '2021-06-16', 3, 120, 2, 118, 80, '已开班', '未选课');
INSERT INTO `sw_course` VALUES (18, '【1509100011】大学英语Ⅰ', 1, '明智楼', '2021-06-17', 4, 120, 14, 106, 81, '已开班', '已选课');
INSERT INTO `sw_course` VALUES (19, '【1508100311】大学物理Ⅰ', 2, '31栋', '2021-06-19', 4, 120, 3, 117, 82, '已开班', '已选课');
INSERT INTO `sw_course` VALUES (17, '【1506110890】离散数学', 3, '明智楼', '2021-06-14', 4, 120, 0, 120, 83, '未开班', '未选课');
INSERT INTO `sw_course` VALUES (16, '【1506110260】计算机网络', 4, '6栋', '2021-06-15', 4, 120, 1, 119, 84, '已开班', '未选课');
INSERT INTO `sw_course` VALUES (15, '【1506110900】数据结构', 3, '明智楼', '2021-06-19', 4, 120, 1, 119, 85, '已开班', '已选课');
INSERT INTO `sw_course` VALUES (14, '【1506110360】操作系统', 5, '逸夫楼', '2021-06-15', 4, 120, 0, 120, 86, '未开班', '未选课');
INSERT INTO `sw_course` VALUES (13, '【1506190130】软件工程', 6, '明智楼', '2021-06-18', 4, 120, 0, 120, 87, '未开班', '未选课');
INSERT INTO `sw_course` VALUES (12, '【1514190020】信息安全技术', 6, '逸夫楼', '2021-06-14', 4, 120, 1, 119, 83, '已开班', '已选课');
INSERT INTO `sw_course` VALUES (11, '【1506110880】编译原理', 6, '逸夫楼', '2021-06-15', 4, 120, 1, 119, 88, '已开班', '已选课');
INSERT INTO `sw_course` VALUES (22, '【1508100012】高等数学(A)Ⅱ', 2, '逸夫楼', '2021-06-16', 4, 40, 1, 39, 80, '已开班', '未选课');
INSERT INTO `sw_course` VALUES (24, '【1509101482】大学英语Ⅱ', 2, '明智楼', '2021-06-16', 4, 30, 2, 28, 81, '已开班', '未选课');
INSERT INTO `sw_course` VALUES (25, '【1506100050】程序设计基础(C语言)', 1, '逸夫楼101', '2021-06-25', 2, 80, 0, 80, 80, '已开班', '未选课');
INSERT INTO `sw_course` VALUES (26, '【1506100101】计算机基础', 1, '图书馆101', '2021-06-24', 3, 60, 0, 60, 80, '已开班', '未选课');

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
) ENGINE = MyISAM AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = MyISAM AUTO_INCREMENT = 59 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sw_select
-- ----------------------------
INSERT INTO `sw_select` VALUES (1, 91, 80, 20, '【1508100011】高等数学(A)Ⅰ', 1, '逸夫楼', '2021-06-16', 4, '已打分', 90, 90, 90, '优秀');
INSERT INTO `sw_select` VALUES (2, 92, 80, 20, '【1508100011】高等数学(A)Ⅰ', 1, '逸夫楼', '2021-06-16', 4, '未打分', NULL, NULL, NULL, NULL);
INSERT INTO `sw_select` VALUES (3, 91, 81, 18, '【1509100011】大学英语Ⅰ', 1, '明智楼', '2021-06-17', 4, '未打分', NULL, NULL, NULL, NULL);
INSERT INTO `sw_select` VALUES (52, 91, 83, 12, '【1514190020】信息安全技术', 6, '逸夫楼', '2021-06-14', 4, '未打分', NULL, NULL, NULL, NULL);
INSERT INTO `sw_select` VALUES (58, 80, 81, 18, '【1509100011】大学英语Ⅰ', 1, '明智楼', '2021-06-17', 4, '未打分', NULL, NULL, NULL, NULL);
INSERT INTO `sw_select` VALUES (49, 91, 84, 16, '【1506110260】计算机网络', 4, '6栋', '2021-06-15', 4, '未打分', NULL, NULL, NULL, NULL);
INSERT INTO `sw_select` VALUES (50, 91, 82, 19, '【1508100311】大学物理Ⅰ', 2, '31栋', '2021-06-19', 4, '未打分', NULL, NULL, NULL, NULL);
INSERT INTO `sw_select` VALUES (51, 91, 88, 11, '【1506110880】编译原理', 6, '逸夫楼', '2021-06-15', 4, '已打分', 65, 65, 65, '及格');
INSERT INTO `sw_select` VALUES (54, 91, 82, 19, '【1508100311】大学物理Ⅰ', 2, '31栋', '2021-06-19', 4, '未打分', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sw_semester
-- ----------------------------
DROP TABLE IF EXISTS `sw_semester`;
CREATE TABLE `sw_semester`  (
  `semester_id` int(11) NOT NULL AUTO_INCREMENT,
  `semester_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`semester_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
  `online` int(11) NULL DEFAULT 0,
  `company` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `identity` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 95 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sw_user
-- ----------------------------
INSERT INTO `sw_user` VALUES (80, '2001', 'e10adc3949ba59abbe56e057f20f883e', '左黎明', 3, '男', '/uploads/20210616/7e3b52b4388fdf582b50b49b8e9fe617.png', '18079014431', '江西赣州', 1, 1625822506, 1, '信息工程学院', '教授');
INSERT INTO `sw_user` VALUES (81, '2002', 'e10adc3949ba59abbe56e057f20f883e', '李宗', 3, '女', '/uploads/20210617/b8e0f726a7a904edd57a0aeaa776d5fa.png', '11111111111', '江西南昌', 1, 1624034162, 0, '信息工程学院', '讲师');
INSERT INTO `sw_user` VALUES (82, '2003', 'e10adc3949ba59abbe56e057f20f883e', '刘正方', 3, '男', NULL, '18079002222', '江西南昌', 1, NULL, 0, '信息工程学院', '副教授');
INSERT INTO `sw_user` VALUES (83, '2004', 'e10adc3949ba59abbe56e057f20f883e', '万涛', 3, '女', NULL, '18079001111', '江西南昌', 1, NULL, 0, '信息工程学院', '副教授');
INSERT INTO `sw_user` VALUES (84, '2005', 'e10adc3949ba59abbe56e057f20f883e', '谢昕', 3, '男', '/uploads/20201230/a11502d2fc1026fdb0397364a153093f.jpg', '19970720985', '江西赣州', 1, NULL, 0, '信息工程学院', '教授');
INSERT INTO `sw_user` VALUES (85, '2006', 'e10adc3949ba59abbe56e057f20f883e', '刘艳丽', 3, '女', '/uploads/20210109/fe8ec829606d2260f9dc3a8a3e489027.jpg', '19970720985', '江西赣州于都', 1, NULL, 0, '信息工程学院', '教授');
INSERT INTO `sw_user` VALUES (86, '2007', 'e10adc3949ba59abbe56e057f20f883e', '刘美香', 3, '女', NULL, '11111111113', '江西南昌', 1, NULL, 0, '信息工程学院', '讲师');
INSERT INTO `sw_user` VALUES (87, '2008', 'e10adc3949ba59abbe56e057f20f883e', '舒文豪', 3, '女', '/uploads/20201230/a11502d2fc1026fdb0397364a153093f.jpg', '19970720985', '江西赣州', 1, NULL, 0, '信息工程学院', '副教授');
INSERT INTO `sw_user` VALUES (88, '2009', 'e10adc3949ba59abbe56e057f20f883e', '邹长军', 3, '男', '/uploads/20201230/a11502d2fc1026fdb0397364a153093f.jpg', '19970720985', '江西赣州', 1, 1624503768, 0, '信息工程学院', '讲师');
INSERT INTO `sw_user` VALUES (91, '2018061008000401', 'e10adc3949ba59abbe56e057f20f883e', '小胡', 2, '男', '/uploads/20210625/1191a754a8d23e78f25c976a7107a955.jpg', '18079014431', '江西新余', 1, 1624618313, 1, '信息工程学院', '本专科生');
INSERT INTO `sw_user` VALUES (92, '2018061008000402', 'e10adc3949ba59abbe56e057f20f883e', '小承', 2, '女', NULL, '12333532354', '江西赣州', 1, 1624034140, 0, '信息工程学院', '本专科生');
INSERT INTO `sw_user` VALUES (93, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'admin', 1, '男', NULL, '19023456879', '江西赣州', 1, 1624698237, 1, '信息工程学院', '管理员');
INSERT INTO `sw_user` VALUES (94, '123', '202cb962ac59075b964b07152d234b70', NULL, 2, '', NULL, '11111111118', '江西南昌', 1, NULL, 0, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
