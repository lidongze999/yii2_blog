/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : yii2_blog

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-02-25 11:20:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `auth_key` varchar(32) NOT NULL COMMENT '自动登录key',
  `password_hash` varchar(255) NOT NULL COMMENT '加密密码',
  `password_reset_token` varchar(255) DEFAULT NULL COMMENT '重置密码token',
  `email_validate_token` varchar(255) DEFAULT NULL COMMENT '邮箱验证token',
  `email` varchar(255) NOT NULL COMMENT '邮箱',
  `role` smallint(6) NOT NULL DEFAULT '10' COMMENT '角色等级',
  `status` smallint(6) NOT NULL DEFAULT '10' COMMENT '状态',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `vip_lv` int(11) DEFAULT '0' COMMENT 'vip等级',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=561 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('560', 'admin', 'zcb0j0qPMKTZPRetPvAklhJyEkNxZ2qz', '$2y$13$sv6/Mz2/G.nM50Xngtu8ZO7oLphpeg9hWW9y0NgxC7fTSvy7KUGm2', null, null, 'wfnking@sina.com', '10', '10', null, '0', '1487705957', '1487705957');

-- ----------------------------
-- Table structure for `cats`
-- ----------------------------
DROP TABLE IF EXISTS `cats`;
CREATE TABLE `cats` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `cat_name` varchar(255) DEFAULT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of cats
-- ----------------------------
INSERT INTO `cats` VALUES ('1', '分类1');
INSERT INTO `cats` VALUES ('2', '分类2');

-- ----------------------------
-- Table structure for `feeds`
-- ----------------------------
DROP TABLE IF EXISTS `feeds`;
CREATE TABLE `feeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `content` varchar(255) NOT NULL COMMENT '内容',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='聊天信息表';

-- ----------------------------
-- Records of feeds
-- ----------------------------
INSERT INTO `feeds` VALUES ('10', '560', 'hi', '1487930158');
INSERT INTO `feeds` VALUES ('11', '561', '好大', '1487930100');
INSERT INTO `feeds` VALUES ('12', '562', '不大不小', '1487130158');
INSERT INTO `feeds` VALUES ('13', '561', 'hi', '1487937306');
INSERT INTO `feeds` VALUES ('14', '561', '我的心好累', '1487937354');
INSERT INTO `feeds` VALUES ('15', '561', '二万五千年', '1487938867');
INSERT INTO `feeds` VALUES ('16', '561', '「滚床单」有哪些优雅的法？\n管鲍之交。', '1487938924');
INSERT INTO `feeds` VALUES ('17', '561', '做我女朋友行不行，行就行，不行我再想想办法。', '1487938944');

-- ----------------------------
-- Table structure for `posts`
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `summary` varchar(255) DEFAULT NULL COMMENT '摘要',
  `content` text COMMENT '内容',
  `label_img` varchar(255) DEFAULT NULL COMMENT '标签图',
  `cat_id` int(11) DEFAULT NULL COMMENT '分类id',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `is_valid` tinyint(1) DEFAULT '0' COMMENT '是否有效：0-未发布 1-已发布',
  `created_at` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_cat_valid` (`cat_id`,`is_valid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='文章主表';

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES ('2', '我的哥啊', '01.小保姆嗓门特别大，主人叮嘱，今晚来的都是有身份的人，说话务必小声一点。吃完饭，主人客人玩牌，小保姆收拾完想早点休息，于是凑近男主人耳边轻声道：“那我先睡了哈。”', '<ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><span id=\"text110\" style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51); line-height: 28px;\"><span style=\"font-family:Verdana;margin: 0px; padding: 0px;\">01.小保姆嗓门特别大，主人叮嘱，今晚来的都是有身份的人，说话务必小声一点。吃完饭，主人客人玩牌，小保姆收拾完想早点休息，于是凑近男主人耳边轻声道：“那我先睡了哈。”</span></span></ul><p><br/></p>', '/images/20170223/1487855521131311.jpg', '2', '560', 'test', '0', '1487855751', '1487855751');
INSERT INTO `posts` VALUES ('16', '屌炸了', '最近买了电子烟，使用感觉还不错。昨天出门坐公交随手就塞到牛仔裤兜里了，可能是牛仔裤太紧，压到开关了，整个车厢的人都看我胯下部位一直在冒烟，我还专心看手机根本没发觉，直到一个好心的哥', '<p><span style=\"color: rgb(51, 51, 51); font-family: Tahoma, Arial, &#39;Hiragino Sans GB&#39;, 冬青黑, &#39;Microsoft YaHei&#39;, 微软雅黑, SimSun, 宋体, Heiti, 黑体, sans-serif; line-height: 30px; text-indent: 28px; background-color: rgb(255, 255, 255);\">最近买了电子烟，使用感觉还不错。昨天出门坐公交随手就塞到牛仔裤兜里了，可能是牛仔裤太紧，压到开关了，整个车厢的人都看我胯下部位一直在冒烟，我还专心看手机根本没发觉，直到一个好心的哥们拍拍我，哥们你好像屌炸了。</span></p>', '/images/20170223/1487860644553474.jpg', '2', '561', 'alf', '0', '1487861119', '1487861119');
INSERT INTO `posts` VALUES ('17', '真假美猴王', '西天取经，六耳猕猴混来进来，真假美猴王只有唐僧能分辨出来。 唐僧说:“为师想吃桃子。” 两猴犹豫了一下，都变成了桃子。 突然唐僧大喊:“八戒，给我', '<p><span style=\"color: rgb(51, 51, 51); font-family: Tahoma, Arial, &#39;Hiragino Sans GB&#39;, 冬青黑, &#39;Microsoft YaHei&#39;, 微软雅黑, SimSun, 宋体, Heiti, 黑体, sans-serif; line-height: 30px; text-indent: 28px; background-color: rgb(255, 255, 255);\">西天取经，六耳猕猴混来进来，真假美猴王只有唐僧能分辨出来。 唐僧说:“为师想吃桃子。” 两猴犹豫了一下，都变成了桃子。 突然唐僧大喊:“八戒，给我</span></p>', '/images/20170223/1487861162271659.jpg', '1', '561', 'alf', '1', '1487861174', '1487861174');
INSERT INTO `posts` VALUES ('18', '海纳百川，有容乃大；壁立千仞，无欲则刚', '海纳百川，有容乃大；壁立千仞，无欲则刚。此联为清末政治家林则徐任两广总督时在总督府衙题书的堂联。意为：大海因为有宽广的度量才容纳了成百上千的河流；高山因为没有勾心斗角的凡世杂欲才如', '<p>&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"font-family: sans-serif; font-size: 16px;\">海纳百川，有容乃大；壁立千仞，无欲则刚。此联为清末政治家</span><a target=\"_blank\" href=\"http://baike.baidu.com/view/7659.htm\" style=\"font-family: sans-serif; font-size: 16px; color: rgb(19, 110, 194); text-decoration: none;\">林则徐</a><span style=\"font-family: sans-serif; font-size: 16px;\">任两广总督时在总督府衙题书的堂联。意为：大海因为有宽广的度量才容纳了成百上千的河流；高山因为没有勾心斗角的凡世杂欲才如此的挺拔。上下联最后一字——“大”与“刚”，意思是说，这种</span><a target=\"_blank\" href=\"http://baike.baidu.com/view/80259.htm\" style=\"font-family: sans-serif; font-size: 16px; color: rgb(19, 110, 194); text-decoration: none;\">浩然之气</a><span style=\"font-family: sans-serif; font-size: 16px;\">，最伟大，最刚强。更表明了作者至大至刚的浩然之气。这种海纳百川的胸怀和“壁立千仞”的刚直，来源于“无欲”。这样的气度和“无欲”情怀以及至大至刚的浩然之气，正是心理健康不可缺少的维生素。</span></p><p><br/></p>', '', '2', '561', 'alf', '1', '1487939657', '1487939657');

-- ----------------------------
-- Table structure for `post_extends`
-- ----------------------------
DROP TABLE IF EXISTS `post_extends`;
CREATE TABLE `post_extends` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `post_id` int(11) DEFAULT NULL COMMENT '文章id',
  `browser` int(11) DEFAULT '0' COMMENT '浏览量',
  `collect` int(11) DEFAULT '0' COMMENT '收藏量',
  `praise` int(11) DEFAULT '0' COMMENT '点赞',
  `comment` int(11) DEFAULT '0' COMMENT '评论',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='文章扩展表';

-- ----------------------------
-- Records of post_extends
-- ----------------------------
INSERT INTO `post_extends` VALUES ('38', '16', '8', '0', '0', '0');
INSERT INTO `post_extends` VALUES ('39', '17', '5', '0', '0', '0');
INSERT INTO `post_extends` VALUES ('40', '18', '12', '0', '0', '0');

-- ----------------------------
-- Table structure for `relation_post_tags`
-- ----------------------------
DROP TABLE IF EXISTS `relation_post_tags`;
CREATE TABLE `relation_post_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `post_id` int(11) DEFAULT NULL COMMENT '文章ID',
  `tag_id` int(11) DEFAULT NULL COMMENT '标签ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_id` (`post_id`,`tag_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='鏂囩珷鍜屾爣绛惧叧绯昏〃';

-- ----------------------------
-- Records of relation_post_tags
-- ----------------------------
INSERT INTO `relation_post_tags` VALUES ('1', '16', '6');
INSERT INTO `relation_post_tags` VALUES ('2', '16', '7');
INSERT INTO `relation_post_tags` VALUES ('3', '17', '6');
INSERT INTO `relation_post_tags` VALUES ('4', '17', '8');
INSERT INTO `relation_post_tags` VALUES ('5', '18', '9');

-- ----------------------------
-- Table structure for `tags`
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `tag_name` varchar(255) DEFAULT NULL COMMENT '标签名称',
  `post_num` int(11) DEFAULT '0' COMMENT '关联文章数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_name` (`tag_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='标签表';

-- ----------------------------
-- Records of tags
-- ----------------------------
INSERT INTO `tags` VALUES ('6', '笑话', '2');
INSERT INTO `tags` VALUES ('7', '电子烟', '1');
INSERT INTO `tags` VALUES ('8', '美猴王', '1');
INSERT INTO `tags` VALUES ('9', '经典', '1');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `auth_key` varchar(32) NOT NULL COMMENT '自动登录key',
  `password_hash` varchar(255) NOT NULL COMMENT '加密密码',
  `password_reset_token` varchar(255) DEFAULT NULL COMMENT '重置密码token',
  `email_validate_token` varchar(255) DEFAULT NULL COMMENT '邮箱验证token',
  `email` varchar(255) NOT NULL COMMENT '邮箱',
  `role` smallint(6) NOT NULL DEFAULT '10' COMMENT '角色等级',
  `status` smallint(6) NOT NULL DEFAULT '10' COMMENT '状态',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `vip_lv` int(11) DEFAULT '0' COMMENT 'vip等级',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=563 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('561', 'alf', 'HhW2c21T9Wdid2SMioru-6x8Qk9A-e1d', '$2y$13$YgVDIvx2AW216iIgUQjiceybPDtEEKgUtIEjqenCYwsP9RQxh4t1m', null, null, 'aflking@sina.com', '10', '10', null, '0', '1487785306', '1487785306');
INSERT INTO `user` VALUES ('562', 'user', 'u40QUjqzU55hwD91_MxFlNFF4MTLgB5S', '$2y$13$KQcUtSHuoad4jHhHs4gwEeuhwJT4OHclSl6wMiDLNWEr/CR2fagK.', null, null, 'user@arfoo.top', '10', '10', null, '0', '1487820067', '1487820067');
