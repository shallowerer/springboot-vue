/*
SQLyog Enterprise - MySQL GUI v7.15 
MySQL - 5.1.73-community : Database - graduation_project
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`graduation_project` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `graduation_project`;

/*Table structure for table `admin_group` */

DROP TABLE IF EXISTS `admin_group`;

CREATE TABLE `admin_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_name` varchar(50) NOT NULL COMMENT '管理组名',
  `level` tinyint(4) DEFAULT '0' COMMENT '等级',
  `power` varchar(5000) DEFAULT NULL COMMENT '权限ID',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_name` (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员分组信息表';

/*Data for the table `admin_group` */

/*Table structure for table `admin_log` */

DROP TABLE IF EXISTS `admin_log`;

CREATE TABLE `admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `server_id` int(11) DEFAULT '0' COMMENT '服务器ID',
  `admin_id` int(11) DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(50) DEFAULT NULL COMMENT '管理者名字',
  `controller` varchar(50) DEFAULT NULL COMMENT '控制器',
  `action` varchar(50) DEFAULT NULL COMMENT '动作',
  `detail` varchar(500) DEFAULT NULL COMMENT '详情',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP',
  `result` varchar(500) DEFAULT NULL COMMENT '操作结果',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员操作日志';

/*Data for the table `admin_log` */

/*Table structure for table `admin_menu` */

DROP TABLE IF EXISTS `admin_menu`;

CREATE TABLE `admin_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(64) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `name_zh` varchar(64) DEFAULT NULL,
  `icon_cls` varchar(64) DEFAULT NULL,
  `component` varchar(64) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `admin_menu` */

insert  into `admin_menu`(`id`,`path`,`name`,`name_zh`,`icon_cls`,`component`,`parent_id`) values (1,'/admin','AdminIndex','首页','el-icon-s-home','AdminIndex',0),(2,'/admin/dashboard','DashboardAdmin','运行情况',NULL,'dashboard/admin/index',1),(3,'/admin','User','用户管理','el-icon-user','AdminIndex',0),(4,'/admin','Content','门店管理','el-icon-tickets','AdminIndex',0),(5,'/admin','System','系统配置','el-icon-s-tools','AdminIndex',0),(6,'/admin/user/profile','Profile','用户信息',NULL,'user/UserProfile',3),(7,'/admin/user/role','Role','角色配置',NULL,'user/Role',3),(8,'/admin/content/book','BookManagement','图书管理',NULL,'content/BookManagement',4),(9,'/admin/content/banner','BannerManagement','广告管理',NULL,'content/BannerManagement',4),(10,'/admin/content/article','ArticleManagement','文章管理',NULL,'content/ArticleManagement',4),(11,'/admin','Person','个人管理','el-icon-female','AdminIndex',0),(12,'/admin/person','PersonInfo','个人信息','','person/PersonInfo',11),(13,'/admin','VIP','会员管理','el-icon-s-custom','AdminIndex',0),(14,'/admin/dashboard','SysInfo','系统信息',NULL,'dashboard/admin/index',5),(16,'/admin/vip/vip_info','VIPInfo','会员信息',NULL,'vip/VIPInfo',13),(17,'/admin/vip/vip_send','VIPSend','短信群发',NULL,'vip/VIPSend',13),(18,'/admin/vip/vip_bill','VIPList','购物账单',NULL,'vip/VIPBill',13),(19,'/admin','Delivery','配送管理','el-icon-bicycle','AdminIndex',0),(20,'/admin/delivery/delivery_info','DeliveryInfo','配送信息',NULL,'delivery/DeliveryInfo',19);

/*Table structure for table `admin_permission` */

DROP TABLE IF EXISTS `admin_permission`;

CREATE TABLE `admin_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `desc_` varchar(100) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `admin_permission` */

insert  into `admin_permission`(`id`,`name`,`desc_`,`url`) values (1,'users_management','用户信息','/api/admin/user'),(2,'roles_management','角色配置','/api/admin/role'),(3,'content_management','内容管理','/api/admin/content');

/*Table structure for table `admin_role` */

DROP TABLE IF EXISTS `admin_role`;

CREATE TABLE `admin_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `name_zh` varchar(100) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

/*Data for the table `admin_role` */

insert  into `admin_role`(`id`,`name`,`name_zh`,`enabled`) values (1,'sysAdmin','超级管理员',1),(2,'contentManager','门店管理员',1),(3,'visitor','访客',1),(4,'test','测试角色',1),(5,'rider','骑手',1);

/*Table structure for table `admin_role_menu` */

DROP TABLE IF EXISTS `admin_role_menu`;

CREATE TABLE `admin_role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) DEFAULT NULL,
  `mid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8;

/*Data for the table `admin_role_menu` */

insert  into `admin_role_menu`(`id`,`rid`,`mid`) values (14,6,1),(15,6,2),(16,6,3),(17,6,4),(18,6,5),(19,6,6),(20,6,7),(21,6,8),(22,6,9),(23,6,10),(24,6,11),(25,6,12),(26,6,13),(32,1,1),(33,1,2),(34,1,3),(35,1,6),(36,1,7),(37,1,4),(38,1,8),(39,1,9),(40,1,10),(41,1,5),(42,1,11),(43,1,12),(44,1,13),(160,2,1),(161,2,2),(162,2,4),(163,2,8),(164,2,9),(165,2,10),(166,2,5),(167,2,11),(168,2,12),(169,2,13),(170,4,1),(171,4,2),(172,4,3),(173,4,6),(174,4,7),(175,4,4),(176,4,8),(177,4,9),(178,4,10),(179,4,5),(180,4,11),(181,4,12),(182,4,13),(183,5,12),(184,5,13);

/*Table structure for table `admin_role_permission` */

DROP TABLE IF EXISTS `admin_role_permission`;

CREATE TABLE `admin_role_permission` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `rid` int(20) DEFAULT NULL,
  `pid` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_role_permission_role_1` (`rid`),
  KEY `fk_role_permission_permission_1` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

/*Data for the table `admin_role_permission` */

insert  into `admin_role_permission`(`id`,`rid`,`pid`) values (4,6,1),(5,6,2),(6,6,3),(7,1,1),(8,1,2),(9,1,3),(39,2,3),(40,4,1),(41,4,2),(42,4,3);

/*Table structure for table `admin_user` */

DROP TABLE IF EXISTS `admin_user`;

CREATE TABLE `admin_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `account` varchar(50) NOT NULL COMMENT '登录账号',
  `password` varchar(50) NOT NULL COMMENT '登录密码',
  `username` varchar(20) DEFAULT NULL COMMENT '用户名字',
  `group_id` int(11) DEFAULT '0' COMMENT '管理组ID',
  `last_login` varchar(500) DEFAULT NULL COMMENT '上次登录信息',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员信息表';

/*Data for the table `admin_user` */

/*Table structure for table `admin_user_role` */

DROP TABLE IF EXISTS `admin_user_role`;

CREATE TABLE `admin_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `rid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_operator_role_operator_1` (`uid`),
  KEY `fk_operator_role_role_1` (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `admin_user_role` */

insert  into `admin_user_role`(`id`,`uid`,`rid`) values (10,2,2),(11,1,1),(12,3,3),(13,4,1),(15,5,5);

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` tinyint(4) DEFAULT '0' COMMENT '分类类型',
  `name` varchar(50) DEFAULT NULL COMMENT '分类名字',
  `cover` varchar(500) DEFAULT NULL COMMENT '图片',
  `parent_id` int(11) DEFAULT '0' COMMENT '上一级ID',
  `desc` varchar(500) DEFAULT NULL COMMENT '简单的描述',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='通用的分类表';

/*Data for the table `category` */

insert  into `category`(`id`,`type`,`name`,`cover`,`parent_id`,`desc`,`status`,`add_time`) values (1,1,'1','1',1,'1',10,1),(2,1,'1','1',1,'1',10,1),(3,22,NULL,NULL,0,NULL,10,0),(4,22,NULL,NULL,0,NULL,10,0),(5,25,NULL,NULL,0,NULL,10,0),(6,66,NULL,NULL,0,NULL,10,0);

/*Table structure for table `commodity` */

DROP TABLE IF EXISTS `commodity`;

CREATE TABLE `commodity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(11) DEFAULT '0' COMMENT '商店ID',
  `cate_id` int(11) DEFAULT '0' COMMENT '分类ID',
  `title` varchar(50) DEFAULT NULL COMMENT '商品名字',
  `desc` varchar(100) DEFAULT NULL COMMENT '描述',
  `cover` varchar(500) DEFAULT NULL COMMENT '食品封面图',
  `origin_price` decimal(10,0) DEFAULT '0' COMMENT '原价',
  `sell_price` decimal(10,0) DEFAULT '0' COMMENT '售价',
  `discount` decimal(10,0) DEFAULT '10' COMMENT '折扣',
  `like` int(11) DEFAULT '0' COMMENT '点赞',
  `limit_num` int(11) DEFAULT '0' COMMENT '限购数量',
  `option` varchar(500) DEFAULT NULL COMMENT '规格选项',
  `total_sales` int(11) DEFAULT NULL COMMENT '总的销量',
  `month_sales` int(11) DEFAULT NULL COMMENT '月销量',
  `praise_rate` float DEFAULT '100' COMMENT '好评率',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='商品信息表';

/*Data for the table `commodity` */

insert  into `commodity`(`id`,`shop_id`,`cate_id`,`title`,`desc`,`cover`,`origin_price`,`sell_price`,`discount`,`like`,`limit_num`,`option`,`total_sales`,`month_sales`,`praise_rate`,`status`,`add_time`) values (1,1,1,'衣服','1','vue.png','1','1','1',1,1,'1',1,1,100,10,1),(2,0,1,'衣服',NULL,'el.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(3,0,1,'衣服',NULL,'vue.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(4,0,1,'衣服',NULL,'how2j.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(5,0,1,'衣服',NULL,'vue.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(6,0,1,'衣服',NULL,'el.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(7,0,1,'衣服',NULL,'vue.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(8,0,1,'衣服',NULL,'vue.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(9,0,1,'衣服',NULL,'springboot.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(10,0,1,'衣服',NULL,'vue.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(11,0,1,'衣服',NULL,'vue.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(12,0,1,'衣服',NULL,'vue.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(13,0,1,'衣服',NULL,'vue.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(14,0,2,'帽子',NULL,'vue.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(15,0,3,'帽子',NULL,'vue.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(16,0,4,'帽子',NULL,'springboot.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(17,0,5,'帽子',NULL,'el.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(18,0,6,'帽子',NULL,'','0','0','10',0,0,NULL,NULL,NULL,100,10,0),(19,0,3,'dd',NULL,'el.png','0','0','10',0,0,NULL,NULL,NULL,100,10,0);

/*Table structure for table `coupon` */

DROP TABLE IF EXISTS `coupon`;

CREATE TABLE `coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `coupon_id` varchar(50) DEFAULT NULL COMMENT '红包ID',
  `shop_id` int(11) DEFAULT '0' COMMENT '商铺Id',
  `type` tinyint(4) DEFAULT '0' COMMENT '红包类型',
  `title` varchar(20) DEFAULT NULL COMMENT '红包标题',
  `target_money` decimal(10,0) DEFAULT '0' COMMENT '需要满足的金额',
  `discount_money` decimal(10,0) DEFAULT '0' COMMENT '优惠金额',
  `end_time` int(11) DEFAULT '0' COMMENT '结束时间',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  `number` varchar(20) DEFAULT '0' COMMENT '可以领取的数量',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupon_id` (`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='红包发布表';

/*Data for the table `coupon` */

/*Table structure for table `coupon_accept` */

DROP TABLE IF EXISTS `coupon_accept`;

CREATE TABLE `coupon_accept` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(11) DEFAULT '0' COMMENT '商铺ID',
  `user_id` int(11) DEFAULT '0' COMMENT '用户ID',
  `mobile` varchar(20) DEFAULT NULL COMMENT '领卷的号码',
  `coupon_id` varchar(50) DEFAULT NULL COMMENT '红包ID',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  `use_time` int(11) DEFAULT '0' COMMENT '使用时间',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='红包领取表';

/*Data for the table `coupon_accept` */

/*Table structure for table `deliver` */

DROP TABLE IF EXISTS `deliver`;

CREATE TABLE `deliver` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(20) DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `password` varchar(50) DEFAULT NULL COMMENT '登录密码',
  `score` float DEFAULT '5' COMMENT '平均评分',
  `month_task_num` int(11) DEFAULT '0' COMMENT '最近一个月完成的订单量',
  `total_task_num` int(11) DEFAULT '0' COMMENT '总完成的订单量',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='送餐员信息表';

/*Data for the table `deliver` */

/*Table structure for table `deliver_lincense` */

DROP TABLE IF EXISTS `deliver_lincense`;

CREATE TABLE `deliver_lincense` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `deliver_id` int(11) DEFAULT '0' COMMENT '送餐员ID',
  `idcard_num` varchar(50) DEFAULT NULL COMMENT '身份证号码',
  `idcard_img` varchar(500) DEFAULT NULL COMMENT '身份证正面',
  `idcard_img_back` varchar(500) DEFAULT NULL COMMENT '身份证背面',
  `bond_money` decimal(10,0) DEFAULT '0' COMMENT '缴纳的保证金',
  `health_img` varchar(500) DEFAULT NULL COMMENT '健康证',
  `images` varchar(500) DEFAULT NULL COMMENT '其他的图片',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='送餐员认证信息表';

/*Data for the table `deliver_lincense` */

/*Table structure for table `deliver_task` */

DROP TABLE IF EXISTS `deliver_task`;

CREATE TABLE `deliver_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(50) DEFAULT NULL COMMENT '订单ID',
  `deliver_id` int(11) DEFAULT '0' COMMENT '送餐员ID',
  `send_cost` decimal(10,0) DEFAULT '0' COMMENT '配送费',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单配送表';

/*Data for the table `deliver_task` */

/*Table structure for table `food` */

DROP TABLE IF EXISTS `food`;

CREATE TABLE `food` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(11) DEFAULT '0' COMMENT '商店ID',
  `cate_id` int(11) DEFAULT '0' COMMENT '分类ID',
  `title` varchar(50) DEFAULT NULL COMMENT '食品名字',
  `desc` varchar(100) DEFAULT NULL COMMENT '描述',
  `cover` varchar(500) DEFAULT NULL COMMENT '食品封面图',
  `origin_price` decimal(10,0) DEFAULT '0' COMMENT '原价',
  `sell_price` decimal(10,0) DEFAULT '0' COMMENT '售价',
  `discount` decimal(10,0) DEFAULT '10' COMMENT '折扣',
  `like` int(11) DEFAULT '0' COMMENT '点赞',
  `limit_num` int(11) DEFAULT '0' COMMENT '限购数量',
  `option` varchar(500) DEFAULT NULL COMMENT '规格选项',
  `total_sales` int(11) DEFAULT NULL COMMENT '总的销量',
  `month_sales` int(11) DEFAULT NULL COMMENT '月销量',
  `praise_rate` float DEFAULT '100' COMMENT '好评率',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜品信息表';

/*Data for the table `food` */

/*Table structure for table `food_category` */

DROP TABLE IF EXISTS `food_category`;

CREATE TABLE `food_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(11) DEFAULT '0' COMMENT '商铺ID',
  `name` varchar(50) DEFAULT NULL COMMENT '分类类型',
  `desc` varchar(500) DEFAULT NULL COMMENT '描述',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家的食物分类';

/*Data for the table `food_category` */

/*Table structure for table `mysite` */

DROP TABLE IF EXISTS `mysite`;

CREATE TABLE `mysite` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` tinyint(4) DEFAULT '0' COMMENT '分类',
  `key` varchar(100) DEFAULT NULL COMMENT '键',
  `value` text COMMENT '值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_key` (`type`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网站基本设置';

/*Data for the table `mysite` */

/*Table structure for table `notice` */

DROP TABLE IF EXISTS `notice`;

CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` tinyint(4) DEFAULT '0' COMMENT '通知类型',
  `user_ids` varchar(500) DEFAULT NULL COMMENT '需要通知的用户IDs',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `from` varchar(20) DEFAULT NULL COMMENT '消息来源',
  `content` varchar(500) DEFAULT NULL COMMENT '通知内容',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知信息表';

/*Data for the table `notice` */

/*Table structure for table `order` */

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(50) NOT NULL COMMENT '订单ID',
  `user_id` int(11) DEFAULT '0' COMMENT '用户ID',
  `shop_id` int(11) DEFAULT '0' COMMENT '商铺ID',
  `box_cost` decimal(10,0) DEFAULT '0' COMMENT '餐盒费',
  `send_cost` decimal(10,0) DEFAULT '0' COMMENT '配送费',
  `total_money` decimal(10,0) DEFAULT '0' COMMENT '总价',
  `discount_money` decimal(10,0) DEFAULT '0' COMMENT '优惠金额',
  `coupon_id` varchar(50) DEFAULT NULL COMMENT '红包ID',
  `coupon_money` decimal(10,0) DEFAULT '0' COMMENT '红包满减金额',
  `pay_money` decimal(10,0) DEFAULT '0' COMMENT '实付金额',
  `pay_way` tinyint(4) DEFAULT '0' COMMENT '支付方式',
  `demand_time` int(11) DEFAULT '0' COMMENT '限定的时间',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单主表';

/*Data for the table `order` */

/*Table structure for table `order_comment` */

DROP TABLE IF EXISTS `order_comment`;

CREATE TABLE `order_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(50) DEFAULT NULL COMMENT '订单ID',
  `user_id` int(11) DEFAULT '0' COMMENT '用户ID',
  `content` varchar(500) DEFAULT NULL COMMENT '评论内容',
  `images` varchar(1000) DEFAULT NULL COMMENT '评论图片',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  `path` varchar(500) DEFAULT NULL COMMENT '回复的ID路径:1/2/3/5',
  `num_praise` int(11) DEFAULT '0' COMMENT '点赞次数',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态',
  `re_comment_id` int(11) DEFAULT '0' COMMENT '引用的评论ID',
  `like_ids` varchar(500) DEFAULT NULL COMMENT '点赞用户的IDs',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单--评论';

/*Data for the table `order_comment` */

/*Table structure for table `order_detail` */

DROP TABLE IF EXISTS `order_detail`;

CREATE TABLE `order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(50) NOT NULL COMMENT '订单ID',
  `user_username` varchar(20) DEFAULT NULL COMMENT '用户名',
  `user_mobile` varchar(20) DEFAULT NULL COMMENT '用户联系电话',
  `user_address_id` int(11) DEFAULT '0' COMMENT '用户地址ID',
  `user_address` varchar(500) DEFAULT NULL COMMENT '用户详细地址',
  `user_longitude` varchar(20) DEFAULT NULL COMMENT '用户地址-经度',
  `user_latitude` varchar(20) DEFAULT NULL COMMENT '用户地址-纬度',
  `shop_shopname` varchar(20) DEFAULT NULL COMMENT '商铺名字',
  `shop_mobile` varchar(20) DEFAULT NULL COMMENT '商铺联系电话',
  `shop_address` varchar(500) DEFAULT NULL COMMENT '商铺详细地址',
  `shop_longitude` varchar(20) DEFAULT NULL COMMENT '商铺地址-经度',
  `shop_latitude` varchar(20) DEFAULT NULL COMMENT '商铺地址-纬度',
  `deliver_id` int(11) DEFAULT NULL COMMENT '送餐员ID',
  `deliver_name` varchar(20) DEFAULT NULL COMMENT '送餐员姓名',
  `deliver_mobile` varchar(20) DEFAULT NULL COMMENT '送餐员联系电话',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单详情表';

/*Data for the table `order_detail` */

/*Table structure for table `order_food` */

DROP TABLE IF EXISTS `order_food`;

CREATE TABLE `order_food` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(50) DEFAULT NULL COMMENT '订单ID',
  `shop_id` int(11) DEFAULT '0' COMMENT '商铺ID',
  `shopname` varchar(50) DEFAULT NULL COMMENT '商铺名称',
  `food_id` int(11) DEFAULT '0' COMMENT '商品ID',
  `title` varchar(50) DEFAULT NULL COMMENT '商品标题',
  `cover` varchar(500) DEFAULT NULL COMMENT '商品封面',
  `origin_price` decimal(10,0) DEFAULT '0' COMMENT '原价',
  `sell_price` decimal(10,0) DEFAULT '0' COMMENT '售价',
  `number` int(11) DEFAULT '0' COMMENT '下单数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单商品详情表';

/*Data for the table `order_food` */

/*Table structure for table `order_process` */

DROP TABLE IF EXISTS `order_process`;

CREATE TABLE `order_process` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(50) DEFAULT NULL COMMENT '订单ID',
  `content` varchar(500) DEFAULT NULL COMMENT '进度备注内容',
  `reason` varchar(500) DEFAULT NULL COMMENT '理由',
  `order_status` tinyint(4) DEFAULT '0' COMMENT '进度状态',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单--进度详情';

/*Data for the table `order_process` */

/*Table structure for table `order_refund` */

DROP TABLE IF EXISTS `order_refund`;

CREATE TABLE `order_refund` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(50) DEFAULT NULL COMMENT '订单ID',
  `user_id` int(11) DEFAULT '0' COMMENT '用户ID',
  `username` varchar(20) DEFAULT NULL COMMENT '用户姓名',
  `pay_money` decimal(10,0) DEFAULT '0' COMMENT '需要退回的款项',
  `refund_reason` varchar(500) DEFAULT NULL COMMENT '退款原因',
  `apply_time` int(11) DEFAULT '0' COMMENT '申请时间',
  `service_cost` decimal(10,0) DEFAULT '0' COMMENT '协商的需要扣除的手续费',
  `handle_time` int(11) DEFAULT '0' COMMENT '卖家处理时间',
  `finish_time` int(11) DEFAULT '0' COMMENT '退款完成时间',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单--退款处理';

/*Data for the table `order_refund` */

/*Table structure for table `pay` */

DROP TABLE IF EXISTS `pay`;

CREATE TABLE `pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` varchar(50) DEFAULT NULL COMMENT '订单ID',
  `user_id` int(11) DEFAULT '0' COMMENT '用户ID',
  `shop_id` int(11) DEFAULT '0' COMMENT '商店ID',
  `total_money` decimal(10,0) DEFAULT '0' COMMENT '支付总数',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  `deal_time` int(11) DEFAULT '0' COMMENT '处理时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单支付表';

/*Data for the table `pay` */

/*Table structure for table `search_record` */

DROP TABLE IF EXISTS `search_record`;

CREATE TABLE `search_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `content` varchar(50) DEFAULT NULL COMMENT '搜索记录',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户搜索记录';

/*Data for the table `search_record` */

/*Table structure for table `shop` */

DROP TABLE IF EXISTS `shop`;

CREATE TABLE `shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shopname` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `mobile` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `login_info` varchar(500) DEFAULT NULL COMMENT '登录信息',
  `num_login_error` tinyint(4) DEFAULT '0' COMMENT '登录错误次数',
  `time_login_lock` int(11) DEFAULT '0' COMMENT '锁定登录时间',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家登录';

/*Data for the table `shop` */

/*Table structure for table `shop_activity` */

DROP TABLE IF EXISTS `shop_activity`;

CREATE TABLE `shop_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` tinyint(4) DEFAULT '0' COMMENT '活动分类',
  `shop_id` int(11) DEFAULT '0' COMMENT '商铺ID',
  `target` decimal(10,0) DEFAULT '0' COMMENT '满足的消费金额',
  `cut` decimal(10,0) DEFAULT '0' COMMENT '优惠金额',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家活动';

/*Data for the table `shop_activity` */

/*Table structure for table `shop_collect` */

DROP TABLE IF EXISTS `shop_collect`;

CREATE TABLE `shop_collect` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(11) DEFAULT '0' COMMENT '店铺ID',
  `user_id` int(11) DEFAULT '0' COMMENT '用户ID',
  `add_time` int(11) DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺收藏表';

/*Data for the table `shop_collect` */

/*Table structure for table `shop_info` */

DROP TABLE IF EXISTS `shop_info`;

CREATE TABLE `shop_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(11) DEFAULT '0' COMMENT '商店ID',
  `tag` varchar(100) DEFAULT NULL COMMENT '商铺所属的TAG',
  `shopname` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `contact_man` varchar(20) DEFAULT NULL COMMENT '联系人',
  `contact_mobile` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `cateid` int(11) DEFAULT '0' COMMENT '门店类型',
  `begin_time` int(11) DEFAULT '0' COMMENT '营业开始时间',
  `end_time` int(11) DEFAULT '0' COMMENT '营业结束时间',
  `store_img` varchar(500) DEFAULT NULL COMMENT '门店图片',
  `instore_img` varchar(500) DEFAULT NULL COMMENT '店内图片',
  `logo_img` varchar(500) DEFAULT NULL COMMENT 'logo图片',
  `longitude` varchar(20) DEFAULT NULL COMMENT '经度',
  `latitude` varchar(20) DEFAULT NULL COMMENT '纬度',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `district` varchar(20) DEFAULT NULL COMMENT '区',
  `address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `street` varchar(100) DEFAULT NULL COMMENT '街道/门牌号',
  `mobile` varchar(20) DEFAULT NULL COMMENT '外卖电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `images` varchar(500) DEFAULT NULL COMMENT '其他图片',
  `notice` varchar(500) DEFAULT NULL COMMENT '商家公告',
  `score` float DEFAULT '0' COMMENT '平均评分',
  `send_time` varchar(50) DEFAULT NULL COMMENT '配送时间',
  `box_cost` decimal(10,0) DEFAULT '0' COMMENT '餐盒费用',
  `send_cost` decimal(10,0) DEFAULT '0' COMMENT '配送费用',
  `floor_send_cost` decimal(10,0) DEFAULT '0' COMMENT '起送消费',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商铺信息表';

/*Data for the table `shop_info` */

/*Table structure for table `shop_license` */

DROP TABLE IF EXISTS `shop_license`;

CREATE TABLE `shop_license` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '商店ID',
  `idacrd_name` varchar(20) DEFAULT NULL COMMENT '身份证姓名',
  `idcard_num` varchar(50) DEFAULT NULL COMMENT '身份证号码',
  `idcard_img` varchar(500) DEFAULT NULL COMMENT '身份证图片',
  `business_img` varchar(500) DEFAULT NULL COMMENT '营业执照图片',
  `business_num` varchar(100) DEFAULT NULL COMMENT '营业执照注册号',
  `business_name` varchar(50) DEFAULT NULL COMMENT '营业执照名称',
  `business_address` varchar(100) DEFAULT NULL COMMENT '营业执照注册地址',
  `business_begintime` int(11) DEFAULT '0' COMMENT '营业执照开始时间',
  `business_endtime` int(11) DEFAULT '0' COMMENT '营业执照结束时间',
  `license_img` varchar(500) DEFAULT NULL COMMENT '餐饮服务许可证图片',
  `license_num` varchar(100) DEFAULT NULL COMMENT '许可证名称',
  `license_address` varchar(100) DEFAULT NULL COMMENT '许可证注册地址',
  `license_begintime` int(11) DEFAULT '0' COMMENT '证件开始时间',
  `license_endtime` int(11) DEFAULT '0' COMMENT '许可证结束时间',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家入驻许可证';

/*Data for the table `shop_license` */

/*Table structure for table `shop_log` */

DROP TABLE IF EXISTS `shop_log`;

CREATE TABLE `shop_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `server_id` int(11) DEFAULT '0' COMMENT '服务器ID',
  `admin_id` int(11) DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(50) DEFAULT NULL COMMENT '管理者名字',
  `controller` varchar(50) DEFAULT NULL COMMENT '控制器',
  `action` varchar(50) DEFAULT NULL COMMENT '动作',
  `detail` varchar(500) DEFAULT NULL COMMENT '详情',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP',
  `result` varchar(500) DEFAULT NULL COMMENT '操作结果',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家操作日志';

/*Data for the table `shop_log` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(50) DEFAULT NULL COMMENT '用户昵称',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `salt` varchar(50) DEFAULT NULL COMMENT '加盐',
  `password` varchar(50) DEFAULT NULL COMMENT '登录密码',
  `open_id` varchar(100) DEFAULT NULL COMMENT '微信openid',
  `wallet` decimal(10,0) DEFAULT '0' COMMENT '钱包',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `truename` varchar(50) DEFAULT NULL COMMENT '用户真实姓名',
  `gender` varchar(10) DEFAULT NULL COMMENT '性别',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='用户登录表';

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`phone`,`salt`,`password`,`open_id`,`wallet`,`email`,`truename`,`gender`,`status`,`add_time`,`enabled`) values (1,'admin','10000','Qq4zTKmlkZxw4MlkrqZ+rw==','2ca813ba080db368eb428df4dbeb1c7b',NULL,'0','10000@qq.com','超级管理员',NULL,10,0,1),(2,'seller','10086','vE2f68grNJyuMW4eijMyEg==','b90a54a97c8c5cb0dd327a2ff317adc3',NULL,'0','10086@qq.com','卖家',NULL,10,0,1),(3,'visitor','10010',NULL,NULL,NULL,'0','10010@qq.com','访客',NULL,10,0,1),(4,'test',NULL,'wbbH8ufanWSc/Q7i4b15sQ==','807cd1a1421d389ffc9de2ed63f643a3',NULL,'0',NULL,'测试员',NULL,10,0,1),(5,'rider',NULL,'XlfgDl9poQ2+YJJGhOe88w==','f81678c4f794f2875d9ae8b2661ee942',NULL,'0',NULL,'骑手',NULL,10,0,1);

/*Table structure for table `user_address` */

DROP TABLE IF EXISTS `user_address`;

CREATE TABLE `user_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `username` varchar(50) DEFAULT NULL COMMENT '姓名',
  `gender` varchar(10) DEFAULT '先生' COMMENT '性别',
  `mobile` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `province` varchar(50) DEFAULT NULL COMMENT '省',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `district` varchar(50) DEFAULT NULL COMMENT '区',
  `longitude` varchar(20) DEFAULT NULL COMMENT '经度',
  `latitude` varchar(20) DEFAULT NULL COMMENT '纬度',
  `address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `street` varchar(100) DEFAULT NULL COMMENT '街道,门牌号',
  `tag` tinyint(4) DEFAULT '0' COMMENT '标签',
  `default` tinyint(4) DEFAULT '0' COMMENT '是否为默认地址',
  `status` tinyint(4) DEFAULT '10' COMMENT '状态',
  `add_time` int(11) DEFAULT '0' COMMENT '加入时间',
  `edit_time` int(11) DEFAULT '0' COMMENT '编辑时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户配送地址';

/*Data for the table `user_address` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
