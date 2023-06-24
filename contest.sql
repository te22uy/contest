/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1_3306
 Source Server Type    : MySQL
 Source Server Version : 100427
 Source Host           : 127.0.0.1:3306
 Source Schema         : contest

 Target Server Type    : MySQL
 Target Server Version : 100427
 File Encoding         : 65001

 Date: 18/05/2023 20:49:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for allquestion
-- ----------------------------
DROP TABLE IF EXISTS `allquestion`;
CREATE TABLE if not exists `allquestion`  (
  `questionId` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `level` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `answerA` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `answerB` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `answerC` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `answerD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `answerE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `rightAnswer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`questionId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1230 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of allquestion
-- ----------------------------
INSERT INTO `allquestion` VALUES (1212, '理工', '单选题', '1+1=', '1', '2', '3', '4', NULL, 'B');
INSERT INTO `allquestion` VALUES (1213, '农医类', '判断题', '12223123', '123123123', '12', '', '', '', 'A');
INSERT INTO `allquestion` VALUES (1214, '电子信息类', '单选题', '123', '123213', '123213', '123213', '213123', '', 'A');
INSERT INTO `allquestion` VALUES (1215, '人文社科类', '判断题', '123213', '123123', '12312313', '', '', '', 'A');
INSERT INTO `allquestion` VALUES (1217, '人文社科类', '多选题', '', '', '', '', '', '', 'B');
INSERT INTO `allquestion` VALUES (1218, '理工类', '多选题', '', '', '', '', '', '', 'B');
INSERT INTO `allquestion` VALUES (1219, '农医类', '判断题', '12321', '12312', '123213', '', '', '', 'A');
INSERT INTO `allquestion` VALUES (1220, '人文社科类', '判断题', '21312', '12321', '12312', '', '', '', 'B');
INSERT INTO `allquestion` VALUES (1221, '人文社科类', '单选题', '123', '123', '123', '123123', '13', '', 'B');
INSERT INTO `allquestion` VALUES (1222, '人文社科类', '单选题', '123', '123', '213', '1231', '23', '', 'C');
INSERT INTO `allquestion` VALUES (1223, '农医类', '判断题', '123', '123', '123', '', '', '', '');
INSERT INTO `allquestion` VALUES (1224, '农医类', '单选题', '123', '123', '123', '123', '123', '', 'A');
INSERT INTO `allquestion` VALUES (1225, '人文社科类', '判断题', '12312', '12312', '12312', '', '', '', 'A');
INSERT INTO `allquestion` VALUES (1226, '农医类', '多选题', '213123', '12312', '12312', '12312', '12312', '123123', 'E');
INSERT INTO `allquestion` VALUES (1227, '农医类', '多选题', '12', '12', '12', '12', '12', '12', 'AC');
INSERT INTO `allquestion` VALUES (1228, '农医类', '多选题', '多选题答案ac', '213', '123', '1232', '12312', '123213', 'AC');
INSERT INTO `allquestion` VALUES (1229, '农医类', '多选题', '213', '123213', '12321', '123', '123', '123', 'AB');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE if not exists `category`  (
  `category` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`category`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('人文社科类');
INSERT INTO `category` VALUES ('农医类');
INSERT INTO `category` VALUES ('理工类');
INSERT INTO `category` VALUES ('电子信息类');
INSERT INTO `category` VALUES ('综合类');

-- ----------------------------
-- Table structure for contestinfo
-- ----------------------------
DROP TABLE IF EXISTS `contestinfo`;
CREATE TABLE if not exists `contestinfo`  (
  `contestId` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `Organizer` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '主办方',
  `undertaker` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '承办方',
  `Startdate` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '开始时间',
  `Enddate` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '结束时间',
  `Examtime` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '考试时间',
  `category` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '竞赛类别',
  `level` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '竞赛级别',
  `contestImg` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '竞赛封面',
  `detail` longtext CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL COMMENT '竞赛详情',
  `outdated` int NULL DEFAULT 0 COMMENT '过期标识',
  PRIMARY KEY (`contestId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of contestinfo
-- ----------------------------
INSERT INTO `contestinfo` VALUES (9, '全国大学生数学建模竞赛', '中国工业与应用数学学会', '成都理工大学工程技术学院', '2023-01-20', '2023-04-27', NULL, '综合类', '排行榜国赛', 'image/全国大学生数学建模竞赛.png', '<h1>大赛类别</h1>\n<h4><strong>2023年第二届全国青年创新翻译大赛共分汉译英、英译汉两个类别。</strong></h4>\n<h4><strong>英译汉类别报名入口：在本页面完成报名</strong></h4>\n<h4><strong>汉译英类别报名入口：点击链接立即报名&nbsp;<a href=\"https://www.saikr.com/vse/Translation/2023CE\">https://www.saikr.com/vse/Translation/2023CE</a></strong></h4>\n<h1>&nbsp;</h1>\n<h1>大赛背景</h1>\n<p>为贯彻、落实教育部《关于加快建设高水平本科教育 全面提高人才培养能力的意见》文件精神，促进我国翻译教育事业的发展和专业人员翻译水平的提高，调动高等院校在校学生提升语言应用能力的积极性，推动国际化、复合型人才队伍建设，中国出版集团有限公司成员单位中国对外翻译有限公司在顺利举办第一届&ldquo;全国青年创新翻译大赛&rdquo;的基础上，现面向广大翻译学习者、爱好者举办第二届&ldquo;全国青年创新翻译大赛&rdquo;。（China Young Translators\' Contest，简称CYTC）。</p>\n<p>各高校可将本次竞赛获奖成绩作为本校大学生综合素质全面测定加分的重要参考依据。</p>\n<h1>&nbsp;</h1>\n<h1>主办单位</h1>\n<p><img src=\"https://publicqn.saikr.com/2022/02/28/492_621caf56b9613.jpg\" alt=\"\" width=\"419\" height=\"78\"></p>\n<p>&nbsp;</p>\n<p>中国对外翻译有限公司（简称&ldquo;中译公司&rdquo;，原&ldquo;中国对外翻译出版公司&rdquo;），英文名称：China Translation Corporation（简称&ldquo;CTC&rdquo;），是直属于中宣部下属中国出版集团的国家级翻译机构，1973年经国务院批准成立，是新中国的第一家翻译公司、也是目前中国唯一的国有翻译企业。近五十年来，中译公司作为实力雄厚的联合国文件翻译提供商，具有长期积累的极其丰富、行业领先的语言服务经验。</p>\n<p>中译公司前身为经周总理批示成立的&ldquo;联合国资料小组&rdquo;，1979年经国务院批准正式改为&ldquo;中国对外翻译出版公司&rdquo;。此间，我国党和国家领导人都见证了中译公司的成长和壮大历程。2011年，中译公司改企转制，更名为&ldquo;中国对外翻译出版有限公司&rdquo;，由事业单位转为国有企业。后因上市需要，更名为&ldquo;中国对外翻译有限公司&rdquo;。</p>\n<p>中译公司作为中国翻译行业的&ldquo;国家队&rdquo;，始终坚持正确的翻译方向，积极承担党和国家的重大翻译任务和国际级、国家级大型赛事会议活动等，在语言服务领域取得了辉煌的业绩。</p>\n<p>&nbsp;</p>\n<p><strong>&middot;</strong>2008年，中译公司获评北京市政府外事办&ldquo;北京市规范公共场所英语标识工作先进单位&rdquo;荣誉称号。</p>\n<p><strong>&middot;</strong>2013年，中译公司获评中国翻译协会&nbsp;&ldquo;翻译品牌企业&rdquo;荣誉称号。</p>\n<p><strong>&middot;</strong>2014年，中译公司获评&ldquo;中国服务贸易十大杰出单位&rdquo;荣誉称号。</p>\n<p><strong>&middot;</strong>2014年，中译公司获评中国翻译协会&ldquo;诚信承诺单位&rdquo;荣誉称号。</p>\n<p><strong>&middot;</strong>2015年，中译公司获评中国翻译协会&ldquo;2014年度优秀单位会员&rdquo;荣誉称号。</p>\n<p><strong>&middot;</strong>2016年，中译公司在深圳文博会上获评&ldquo;国家文化出口重点企业&rdquo;荣誉称号。&nbsp;&nbsp;</p>\n<p><strong>&middot;</strong>2017年，中译公司获评&ldquo;2015-2017年度首都文明单位&rdquo;荣誉称号。</p>\n<p><strong>&middot;</strong>2021年，中译公司获评&ldquo;全国新闻出版广播影视系统先进集体&rdquo;荣誉称号。</p>\n<p><strong>&middot;</strong>2021年，中译公司获评&ldquo;2020-2021年度社会责任贡献单位&rdquo;荣誉称号。</p>\n<p><strong>&middot;</strong>2021年，中译公司获评&ldquo;2018-2020年度首都文明单位&rdquo;荣誉称号。</p>\n<p><strong>&middot;</strong>2022年，中译公司连续12年获评&ldquo;国家文化出口重点企业&rdquo;荣誉称号。</p>\n<h1>协办单位</h1>\n<p>中译在线</p>\n<h1>&nbsp;</h1>\n<h1>大赛时间</h1>\n<p>本届大赛即日启动，<strong>请各地区高校教研部门或教师及时向全国翻译大赛组委会提交报名名单</strong>。</p>\n<p><strong>报名时间：</strong>2022年12月26日至2023年3月10日</p>\n<p><strong>译文提交时间：</strong>2023年1月9日至3月10日</p>\n<p><strong>评阅启动时间：</strong>2023年3月11日</p>\n<h1>&nbsp;</h1>\n<h1>参赛对象</h1>\n<p><strong>普通高等院校</strong>、<strong>高职院校</strong>、<strong>二级学院</strong>、<strong>独立学院</strong>、<strong>本、专科</strong>在校大学生及<strong>研究生</strong>均可报名参加，专业不限；其他社会各界翻译爱好者也可以报名参赛。</p>\n<h1>&nbsp;</h1>\n<h1>大赛形式</h1>\n<p>全国青年创新翻译大赛分 A、B、C、D 四个类别，<strong>参赛者可根据自身情况选择不同组别进行参赛。</strong></p>\n<p><strong>A组：</strong>研究生及同等学历</p>\n<p><strong>B组：</strong>外国语言文学类本科及同等学历</p>\n<p><strong>C组：</strong>非外国语言文学类本科及同等学历</p>\n<p><strong>D组：</strong>专科及同等学历</p>\n<h1>&nbsp;</h1>\n<h1>大赛报名工作</h1>\n<p>全国各高校的研究生及本、专科所有年级及各专业学生均可自愿报名参加本届大赛。参赛方式：</p>\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. 以教研部门为单位统一组织报名参加大赛。</p>\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. 以学校为单位统一组织报名参加大赛。</p>\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. 以班级为单位统一组织报名参加大赛。</p>\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. 以个人为单位报名参加大赛。</p>\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5. 坚持学生自愿报名参加活动的原则。本活动&ldquo;重在参与，面向全体&rdquo;，不得采取只选择部分&ldquo;尖子生&rdquo; 参加大赛，而把大部分学生排除在外的做法。</p>\n<p>参赛者可以直接在大赛官方报名入口进行报名。</p>\n<p>英译汉类别报名链接：<a href=\"https://www.saikr.com/vse/Translation/2023EC\">https://www.saikr.com/vse/Translation/2023EC</a></p>\n<p>汉译英类别报名链接：<a href=\"https://www.saikr.com/vse/Translation/2023EC\">https://www.saikr.com/vse/Translation/2023CE</a></p>\n<h1>&nbsp;</h1>\n<h1>内容范围</h1>\n<p align=\"justify\">多领域文本笔译（英译汉、汉译英），大赛试题来源于原创文本及海内外公开出版或发行的书籍或期刊。</p>\n<h1>&nbsp;</h1>\n<h1>参赛须知</h1>\n<p><strong>参赛方式：</strong></p>\n<p>&nbsp; &nbsp; &nbsp;请参赛师生于译文提交截止日前，将参赛译文上传至报名网站，即为提交成功。无需邮寄任何纸质作品。</p>\n<p>&nbsp; &nbsp; &nbsp;参赛者需将电子档的文件命名为：参赛组别+英译汉+真实姓名+学校名称，进行电子档提交</p>\n<p><strong>作品要求：</strong></p>\n<p>&nbsp; &nbsp; &nbsp;参赛译文必须由参赛者本人独立完成，严禁抄袭或照搬机器翻译结果。译文要求忠实原文、用词准确、表达流畅，格式和标点符号使用正确。</p>\n<h1>&nbsp;</h1>\n<h1>奖项设置</h1>\n<h3>1.个人奖项</h3>\n<p>个人奖项四个类别设<strong>全国冠、亚、季军（各1名），一、二、三等奖及优秀奖。</strong></p>\n<p>个人奖项获奖比例<strong>（根据实际提交的译文份数计算）：</strong></p>\n<p><strong>冠、亚、季军及一等奖：5%</strong></p>\n<p><strong>二等奖：8%</strong></p>\n<p><strong>三等奖：15%</strong></p>\n<p><strong>优秀奖：18%</strong></p>\n<p><img src=\"https://publicqn.saikr.com/2022/12/26/670_63a959c1169d2.png\" alt=\"\" width=\"515\" height=\"365\"></p>\n<p><strong>获奖证书样图</strong></p>\n<p>&nbsp;</p>\n<p><strong>注：（以上个人奖项均颁发获奖证书；未获奖参赛者完整提交作品后可申领参赛证明。）</strong></p>\n<h3>&nbsp;</h3>\n<h3>2.集体奖项：</h3>\n<p><strong>全国优秀指导教师奖：</strong>根据指导参赛的学生获奖情况进行综合评定。</p>\n<h1><img src=\"https://publicqn.saikr.com/2022/12/26/109_63a94c10bea47.jpg\" alt=\"\" width=\"365\" height=\"516\"></h1>\n<p><strong>全国优秀指导教师证书样图</strong></p>\n<h1>&nbsp;</h1>\n<h1>大赛奖励</h1>\n<p>四个组别的冠军共4人，可直接<strong>进入</strong><strong>本届大赛主办单位&mdash;&mdash;</strong><strong>中国对外翻译有限公司进行实习</strong><strong>。</strong></p>\n<h1>&nbsp;</h1>\n<h1>收费标准</h1>\n<p>报名费49元（包含阅卷、评审、工本费、证书制作费、邮寄费等）</p>\n<p><strong>现大赛赛题已经公布，故报名后不可退赛，不可更改大赛类别，以上情况大赛组委会概不受理。</strong></p>\n<h1>&nbsp;</h1>\n<h1>竞赛交流群</h1>\n<p>QQ1群：603940640</p>\n<p>QQ2群：711595892</p>\n<p>QQ3群：720698090</p>\n<p>QQ4群：603760901</p>\n<p>QQ5群：712908912</p>\n<p>QQ6群：467714426</p>\n<p>*加入任意一群即可</p>', 2);
INSERT INTO `contestinfo` VALUES (10, '中国“互联网+”大学生创新创业大赛', '教育部、中央统战部', '全国各地', '2023-01-12', '2023-04-27', NULL, '农医类', '非排行榜国赛', 'image/中国“互联网+”大学生创新创业大赛.png', '<h1>竞赛信息</h1>\n<p>&nbsp; &nbsp; &nbsp; &nbsp;为进一步加强创新人才培养体系建设，深入贯彻落实习总书记关于技能人才工作特别是技能竞赛工作的重要指示精神，根据《国务院办公厅关于进一步支持大学生创新创业的指导意见》 （国办发〔2021〕35号）、教育部《关于加快建设高水平本科教 育全面提高人才培养能力的意见》（教高〔2018〕2号）等文件精神，充分调动学生的主动性、积极性和创造性，激发学生的创新思维和创新意识，逐渐掌握思考问题、解决问题的方法、提高其创新实践的能力，配合国家高校创新创业人才培养燎原计划，中国商业联合会将举办特此举办&ldquo;2022年&ldquo;创新实践杯&rdquo;全国大学生英语词汇竞赛&rdquo;。</p>\n<p>&nbsp; &nbsp; &nbsp; &nbsp;本次大赛由中国商业联合会主办，中国商业联合会商业创新工作委员会承办。请各高校积极参赛，认真做好报名与组织工作，通过大赛推动高校创新创业教育的深化与完善，进一步提升各校实践教学水平和创新型人才培养质量，为国家提供更多具有发展性、创新性、批判性思维，能够引领未来发展的人才。</p>\n<p>&nbsp;</p>\n<h1><strong>一、主办单位简介</strong></h1>\n<p>&nbsp;</p>\n<p><img src=\"https://publicqn.saikr.com/2022/09/03/565_6312fc51945f4.jpeg\" alt=\"\" width=\"346\" height=\"80\"></p>\n<p>&nbsp;</p>\n<p>中国商业联合会官网：<a href=\"https://www.cgcc.org.cn/\">https://www.cgcc.org.cn/</a></p>\n<p>&nbsp; &nbsp; &nbsp; &nbsp;中国商业联合会成立于1994年，登记管理机关是民政部，党建领导机关是国务院国有资产监督管理委员会党委，是非营利性社会组织。现设有工作机构13个，分支机构33个；直接会员4500多家，间接会员8万多家；接受政府委托，<strong>管理14个企事业单位，代管40个全国性专业协会、学会和研究会，主管33家国内外公开发行的报刊、出版社。</strong>本会分别是亚太零售商协会联盟、国际零售论坛的成员。</p>\n<p>&nbsp;&nbsp;<a href=\"https://www.cgcc.org.cn/gywm/6/1/49713.html\">中国商业联合会党委履行党建领导责任的全国性行业协会、学会和研究会</a>&nbsp;</p>\n<p><a href=\"https://www.cgcc.org.cn/gywm/6/3/50542.html\">中国商业联合会主管报刊社</a></p>\n<p>&nbsp; &nbsp; &nbsp;&nbsp;</p>\n<h1><strong>二、竞赛主题</strong></h1>\n<p>2022年&ldquo;创新实践杯&rdquo;全国大学生英语词汇竞赛</p>\n<p>&nbsp;</p>\n<h1><strong>三、参赛对象</strong></h1>\n<p>&nbsp; &nbsp; &nbsp; &nbsp;参赛对象为全国所有高等院校（本科类和高职高专类院校）在读专科生、本科生、研究生，以个人形式自愿报名参加，不限专业。</p>\n<h3>&nbsp;</h3>\n<h1><strong>四、参赛费用</strong></h1>\n<p>&nbsp; &nbsp; &nbsp; &nbsp;50元/人（包含考务、组织、出题、评审、邮寄等相关费用），获奖者可获得纸质版荣誉证书。</p>\n<p><strong>注：请参赛人员报名缴费前务必认真确认比赛项目。一旦缴费，不予退款。</strong></p>\n<p>&nbsp;</p>\n<h1><strong>五、竞赛时间安排</strong></h1>\n<p><strong>报名时间</strong></p>\n<p>即日起&mdash;2023年1月31日</p>\n<p><strong>比赛时间</strong></p>\n<p><s>第一考场：2022年12月31日（已结束）</s></p>\n<p>第二考场：2023年1月31日<strong>(9:00-18:00任选1小时完成即可！)</strong></p>\n<p>&nbsp;</p>\n<h1><strong>六、竞赛规则</strong></h1>\n<p>&nbsp; &nbsp; &nbsp; 竞赛采取线上闭卷答题形式。参赛选手在固定考试时间内从赛氪官网或APP进入题库答题。比赛用时&nbsp;<strong>60 分钟</strong>，初赛成绩达<strong>60分以上者</strong>根据分数发放相应荣誉证书。</p>\n<p>练习题库一经使用，不予支持任何理由的退费！</p>\n<h1><strong>七、奖项设置</strong></h1>\n<p>成绩排名根据参赛选手得分进行<strong>降序排列</strong>，得分相同者按比赛用时排序，<strong>用时短者</strong>在先。</p>\n<h3><strong>1.学生奖项</strong></h3>\n<p>一等奖：90&mdash;100分，荣誉证书</p>\n<p>二等奖：80&mdash;89分，荣誉证书</p>\n<p>三等奖：60&mdash;79分，荣誉证书</p>\n<p><img src=\"https://publicqn.saikr.com/2022/12/07/524_63901239247ee.png\" alt=\"\" width=\"206\" height=\"289\"></p>\n<p>&nbsp;</p>\n<h3>2.教师奖项：</h3>\n<p>组织参与学生报名人数20名，颁发优秀指导教师奖电子版。</p>\n<p>&nbsp;</p>\n<h3>3.集体奖项：</h3>\n<p>组织50人以上的参赛单位，颁发&ldquo;优秀组织奖证书&rdquo;电子版</p>\n<p>组织200人以上的参赛单位，可申请&ldquo;优秀英语教育基地&rdquo;荣誉匾额</p>\n<p>&nbsp;</p>\n<h1>八、<strong>全国商务外语翻译证书</strong></h1>\n<p>&nbsp; &nbsp; &nbsp;在本次大赛中获奖的同学可获得申领全国外语翻译证书的资格：</p>\n<p>&nbsp; &nbsp; &nbsp;前<strong>40%</strong>获奖同学可以获得翻译证书申领资格，其中前5%的获奖选手可申请高级笔译证书&nbsp;，15%的获奖选手可申请中级笔译证书&nbsp;，20%的获奖选手可申请初级笔译证书。</p>\n<p>&nbsp;</p>\n<p><img src=\"https://publicqn.saikr.com/2022/11/07/299_6368d7731ae60.png\" alt=\"\" width=\"1459\" height=\"327\"></p>\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 初级笔译/290元&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;中级笔译/380元&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;高级笔译/590元</p>\n<h1>&nbsp;</h1>\n<h1>九、竞赛交流</h1>\n<p>组委会QQ：1749286429</p>\n<p>竞赛交流QQ群1：<s><a href=\"https://jq.qq.com/?_wv=1027&amp;k=faecnLor\">133207776</a></s>（此群已满）</p>\n<p>竞赛交流QQ群2：<s><a href=\"https://jq.qq.com/?_wv=1027&amp;k=iDWvEf2c\">556379244</a></s>（此群已满）</p>\n<p>竞赛交流QQ群3:&nbsp; &nbsp;<a href=\"https://jq.qq.com/?_wv=1027&amp;k=PvEby3Xs\">737417002</a>（点击群号即可加群）</p>\n<p>竞赛交流QQ群4:&nbsp; &nbsp;<a href=\"https://jq.qq.com/?_wv=1027&amp;k=SSprnGSL\">347441273</a>（点击群号即可加群）</p>\n<p>&nbsp;</p>\n<p>组委会联系电话&amp;微信： 17791358879</p>\n<p>&nbsp;</p>\n<p>报名成功后联系竞赛秘书可免费领取考研历年真题</p>\n<p><img src=\"https://publicqn.saikr.com/2023/01/11/919_63be5ec3aff9d.png\" alt=\"\" width=\"563\" height=\"95\"></p>\n<p>&nbsp;</p>\n<figure><img src=\"https://publicqn.saikr.com/2022/10/22/544_6353494c4f3d9.jpg\" alt=\"\" width=\"258\" height=\"258\">\n<figcaption><strong>&nbsp; &nbsp; &nbsp;扫码关注，获得竞赛信息与成绩</strong></figcaption>\n</figure>\n<figure><img src=\"https://publicqn.saikr.com/2022/10/22/523_6353497329982.jpg\" alt=\"\" width=\"258\" height=\"258\">\n<figcaption><strong>&nbsp; &nbsp; &nbsp;扫码关注，获得更多竞赛信息</strong></figcaption>\n</figure>\n<p>&nbsp;<br>&nbsp;</p>\n<h3><strong>大学生赛事交流QQ群，点击群号加入！</strong></h3>\n<table dir=\"ltr\" border=\"1\" cellspacing=\"1\" cellpadding=\"1\" align=\"center\">\n<tbody>\n<tr>\n<td>\n<figure><img src=\"https://publicqn.saikr.com/2022/10/27/912_635a469a072a7.png\" alt=\"\" width=\"149\" height=\"149\">\n<figcaption><strong>群号：<a href=\"https://jq.qq.com/?_wv=1027&amp;k=FuFTWseN\">296690260</a></strong></figcaption>\n</figure>\n</td>\n<td>\n<figure><img src=\"https://publicqn.saikr.com/2022/10/27/806_635a46afa3c14.png\" alt=\"\" width=\"152\" height=\"152\">\n<figcaption><strong>群号：<a href=\"https://jq.qq.com/?_wv=1027&amp;k=9RCl3itX\">366744225</a></strong></figcaption>\n</figure>\n</td>\n<td>\n<figure><img src=\"https://publicqn.saikr.com/2022/10/27/947_635a46d160d51.png\" alt=\"\" width=\"154\" height=\"154\">\n<figcaption><strong>群号：<a href=\"https://jq.qq.com/?_wv=1027&amp;k=TAKP6FYF\">752811833</a></strong></figcaption>\n</figure>\n</td>\n</tr>\n<tr>\n<td>\n<figure><img src=\"https://publicqn.saikr.com/2022/10/27/124_635a47b0a5b06.png\" alt=\"\" width=\"147\" height=\"147\">\n<figcaption><strong>群号：<a href=\"https://jq.qq.com/?_wv=1027&amp;k=P5nM0Z7O\">753052749</a></strong></figcaption>\n</figure>\n</td>\n<td>\n<figure><img src=\"https://publicqn.saikr.com/2022/10/27/844_635a4c8a3cff4.png\" alt=\"\" width=\"149\" height=\"149\">\n<figcaption><strong>群号：<a href=\"https://jq.qq.com/?_wv=1027&amp;k=XWrDDO3B\">763547792</a></strong></figcaption>\n</figure>\n</td>\n<td>\n<figure><img src=\"https://publicqn.saikr.com/2022/10/27/390_635a4caf8c0fb.png\" alt=\"\" width=\"153\" height=\"153\">\n<figcaption><strong>群号：<a href=\"https://jq.qq.com/?_wv=1027&amp;k=HCrjCHtS\">285968612</a></strong></figcaption>\n</figure>\n</td>\n</tr>\n</tbody>\n</table>', 2);
INSERT INTO `contestinfo` VALUES (11, '全国大学生计算机设计大赛', '中国教育电视台', '成都理工大学工程和技术学院', '2023-01-14', '2023-06-07', NULL, '理工类', '省赛', 'image/全国大学生计算机设计大赛.png', '<div class=\"event4-1-detail-box v-4-9\">\n<div class=\"title-box\">\n<h3 class=\"title\">竞赛信息</h3>\n<div id=\"detail\" class=\"title-mod\"></div>\n</div>\n<div class=\"event4-1-detail-text-box text-body clearfix\">\n<p>2023 年是全面贯彻落实党的二十大精神的开局之年，切实把党 中央重大决策部署转化为推动科技创新的生动实践。准确把握《中华人民共和国国民经济和社会发展第十四个五年规划和 2035 年远景 目标纲要》新使命新要求，构建万物互联、融合创新的现代信息产 业体系。为深入实施科教兴国战略，增强大学生的信息技术能力。 经研究决定，大国英才职业技能鉴定中心面向全国大学生举办&ldquo;2023 年全国大学生信息技术认证挑战赛&rdquo;。</p>\n<p>本次活动得到了<strong>中国通信工业协会通信和信息技术创新人才培养工程项目办公室</strong>及<strong>中华出版促进会全媒体人才委员会</strong>的大力支持。欢迎各高校积极组织参赛，建议 将本次竞赛成绩作为本校测评加分和评奖评优的重要参考依据。</p>\n<h1>&nbsp;</h1>\n<h1>主办单位</h1>\n<p><a href=\"http://www.bozhubo.com/\"><img src=\"https://publicqn.saikr.com/2023/01/05/349_63b66d98866c2.png\" alt=\"\" width=\"588\" height=\"93\"></a></p>\n<p><span style=\"font-family: 微软雅黑;\"><strong>大国英才</strong></span><span style=\"font-family: 微软雅黑;\"><strong>职业技能鉴定中心</strong></span>是经国家市场监督管理部门批准的职业技能鉴定中心，中心大力营造国家重视技能、社会崇尚技能、人人享有技能的社会环境。发展中国特色学徒制，推进岗课赛证综合育人。</p>\n<h1>&nbsp;</h1>\n<h1>支持单位</h1>\n<p><strong>中国通信工业协会通信和信息技术创新人才培养工程项目办公室</strong></p>\n<p><strong>中华出版促进会全媒体人才委员会</strong></p>\n<h1>&nbsp;</h1>\n<h1>大赛时间</h1>\n<p>报名时间：2023年1月4日-2023年2月26日</p>\n<p>比赛时间：2023年2月27日-2023年3月5日</p>\n<p>成绩公布：2023年4月</p>\n<h1>&nbsp;</h1>\n<h1>参赛对象</h1>\n<p>普通高等院校、高职院校、二级学院、独立学院、本、专科在校大学生及研究生均可报名参加，专业不限；其他社会人员也可以报名参赛。</p>\n<h1>&nbsp;</h1>\n<h1>大赛内容</h1>\n<p>比赛模式：大赛组委会进行出题，题目类型为选择题、判断题或操作题，由大赛组委会进行统一阅卷。</p>\n<h1>&nbsp;</h1>\n<h1>比赛科目</h1>\n<p>大赛共分为10个科目分别进行评比，其中包含：Word科目、Excel科目、C语言/C++科目、Java科目、Python科目、算法科目、视频剪辑科目、新媒体科目、嵌入式科目、云计算科目。参赛者可选择其中一个或多个科目进行参赛。</p>\n<h1>&nbsp;</h1>\n<h1>大赛奖项</h1>\n<p>每个赛道设<strong>，一、二、三等奖及优秀奖。</strong>获奖比例（根据实际参与决赛的人数计算）：</p>\n<p align=\"center\"><strong>一等奖：5%</strong></p>\n<p align=\"center\"><strong>二等奖：10%</strong></p>\n<p align=\"center\"><strong>三等奖：40%</strong></p>\n<p><strong>优秀奖：参赛者未获奖但完整提交作品可获得优秀奖。</strong></p>\n<p><img src=\"https://publicqn.saikr.com/2023/01/06/980_63b77cfa08bf5.jpg\" alt=\"\" width=\"394\" height=\"557\"></p>\n<p><strong>获奖证书样图</strong></p>\n<h1>&nbsp;</h1>\n<h1><strong>集体奖项</strong></h1>\n<p><strong>全国优秀组织单位奖：</strong>根据组织参赛的学生人数及学生获奖人数进行综合评定。</p>\n<p><strong>全国优秀指导教师奖：</strong>根据指导参赛的学生人数及学生获奖人数进行综合评定。</p>\n<p><strong>（以上集体奖项均颁发纸质版获奖证书）</strong></p>\n<p><img src=\"https://publicqn.saikr.com/2023/01/06/842_63b77d223da76.png\" alt=\"\" width=\"534\" height=\"378\"></p>\n<p><strong>优秀指导教师证书样图</strong></p>\n<h1>&nbsp;</h1>\n<h1>大赛奖励</h1>\n<p>每个科目的成绩优异者可获得由<strong>中国通信工业协会</strong>颁发该科目资格证书申领资格，具体申领条件如下：</p>\n<p>*获得一等奖的参赛选手可申领<strong>高级</strong>职业技术水平证书；<br>*获得二等奖的参赛选手可申领<strong>中级</strong>职业技术水平证书；<br>*获得三等奖的参赛选手可申领<strong>初级</strong>职业技术水平证书。</p>\n<p><img src=\"https://publicqn.saikr.com/2023/01/05/992_63b69aa634908.png\" alt=\"\" width=\"471\" height=\"660\"></p>\n<p><strong>职业技术水平证书样图</strong></p>\n<h1>&nbsp;</h1>\n<h1>大赛收费</h1>\n<p>每人每项需要缴纳报名及评审费用、纸质版证书费用共计 50 元，通过大赛官网缴纳；费用用于大赛组织、命题、 评审、赛题讲解、赛后指导及证书发放等工作。</p>\n<h1>&nbsp;</h1>\n<h1>大赛交流群</h1>\n<p><a href=\"https://jq.qq.com/?_wv=1027&amp;k=qmYOJtZX\">1群：700589039</a></p>\n</div>\n</div>\n<div class=\"event4-1-detail-box event4-1-doc-box\">\n<div class=\"title-box\">\n<h3 class=\"title\">附件下载</h3>\n</div>\n<div class=\"event4-1-detail-text-box\">\n<div class=\"item\" title=\"2023年全国大学生信息技术认证挑战赛官方通知.pdf\">2023年全国大学生信息技术认证挑战赛官方通知.pdf&nbsp;&nbsp;<a href=\"https://publicqn.saikr.com/2023/01/05/contest63b667509fea83.009279941672899414880.pdf?attname=2023%E5%B9%B4%E5%85%A8%E5%9B%BD%E5%A4%A7%E5%AD%A6%E7%94%9F%E4%BF%A1%E6%81%AF%E6%8A%80%E6%9C%AF%E8%AE%A4%E8%AF%81%E6%8C%91%E6%88%98%E8%B5%9B%E5%AE%98%E6%96%B9%E9%80%9A%E7%9F%A5.pdf\">点击下载</a></div>\n</div>\n</div>\n<div class=\"event4-1-detail-box v-4-9\">\n<div class=\"title-box\">\n<h3 class=\"title\">通知公告(2)</h3>\n<div id=\"notice\" class=\"title-mod\"></div>\n</div>\n</div>\n<div class=\"sk-cop-inform-box\">\n<ul class=\"sk-inform-list notice-ul-height\">\n<li class=\"item\">\n<div class=\"sk-inform-top clearfix\"><a class=\"fl inform-tit\" title=\"2023年全国大学生信息技术认证挑战赛报名流程\" href=\"https://www.saikr.com/c/nd/10865\" target=\"_blank\" rel=\"noopener\">2023年全国大学生信息技术认证挑战赛报名流程</a></div>\n<p class=\"para\">1、登录大赛官网：https://www.saikr.com/vse/Information &nbsp; 2、点击官网右侧【立即报名】 &nbsp; 3、按顺序填写报名信息，确认无误后点击【下一步】 &nbsp; 4、点击下一步后跳转至该页面，确认报名信息无误后下滑，点击【确认报名】即可，如需修改信息点击【上一步】进行修改。&hellip;</p>\n<p class=\"inform-time-new\">2023.01.06 16:25</p>\n</li>\n</ul>\n</div>', 1);
INSERT INTO `contestinfo` VALUES (12, '全国大学生结构设计竞赛', '中国高等教育学会工程教育委员会', '成都理工大学工程技术学院', '2023-01-11', '2023-05-27', NULL, '农医类', '区域赛', 'image/全国大学生结构设计竞赛.png', '<div class=\"title-box\">\n<h3 class=\"title\">竞赛信息</h3>\n<div id=\"detail\" class=\"title-mod\"></div>\n</div>\n<div class=\"event4-1-detail-text-box text-body clearfix\">\n<p>&ldquo;《英语世界》杯&rdquo;全国大学生英语词汇大赛于2022年发起，旨在顺应时代发展大势，聚焦国家时事热点，把脉外语教育动向，引领外语教育改革，大力提升全国大学生的语言应用能力、文化意识和跨文化交际能力。大赛特色为每年围绕不同主题在大学生中进行英语词汇技巧的比拼。</p>\n<p>经研究决定，商务印书馆《英语世界》杂志社特举办&ldquo;2023年第二届《英语世界》杯全国大学生英语词汇大赛&rdquo;。本届大赛主题为&ldquo;公益&rdquo;，希望当代大学生在磨砺英语词汇能力的同时，深入了解公益相关知识，践行公益活动，传承公益精神，增强使命感和责任感。</p>\n<p>建议各高校紧扣立德树人的根本任务，协助做好本校的组织学习工作，引导大学生群体关注公益，通过词汇竞赛引导大学生群体深入探索公益主题、讲好公益故事。各高校可将本次竞赛获奖成绩作为本校大学生综合素质方面测定及加分的重要参考依据。</p>\n<p>&nbsp;</p>\n<h3><strong>一、&nbsp;主办单位</strong></h3>\n<p>商务印书馆《英语世界》杂志社</p>\n<p>&nbsp;</p>\n<h3><strong>二</strong><strong>、&nbsp;时间安排</strong></h3>\n<p>1.&nbsp;赛事报名阶段：2023年1月5日至2023年3月3日</p>\n<p>2.&nbsp;正式比赛阶段：2023年3月4日至2023年3月5日</p>\n<p>3.&nbsp;获奖公示阶段：2023年3月</p>\n<p>&nbsp;</p>\n<h3><strong>三</strong><strong>、&nbsp;参赛对象</strong></h3>\n<p>全国高校全日制在校生（研究生、本科生、专科生）</p>\n<p>&nbsp;</p>\n<h3><strong>四、 内容范围</strong></h3>\n<p>公益相关知识，主题参考《英语世界》2021年第11期&ldquo;聚焦慈善&rdquo;专栏和2022年第2期&ldquo;聚焦志愿服务&rdquo;专栏。</p>\n<p>&nbsp;</p>\n<h3><strong>五</strong><strong>、&nbsp;竞赛形式</strong></h3>\n<p>全部采用客观单项选择题型，共50道题，满分100分，比赛时长50分钟。</p>\n<p>&nbsp;</p>\n<h3><strong>六</strong><strong>、&nbsp;奖项设置</strong></h3>\n<p>1.&nbsp;设全国一、二、三等奖、优秀奖；100分～90分为一等奖，89分～80分为二等奖，79分～70分为三等奖，69分～60分为优秀奖。</p>\n<p><img src=\"https://publicqn.saikr.com/2023/01/06/7_63b7e37d7845a.jpg\" alt=\"\" width=\"230\" height=\"325\"></p>\n<p>2.&nbsp;报名参赛可获得电子版参赛证明。</p>\n<p><img src=\"https://publicqn.saikr.com/2023/01/06/601_63b7e3b115244.jpg\" alt=\"\" width=\"242\" height=\"343\"></p>\n<p>3.&nbsp;全国优秀指导教师奖：师生同奖，学生获奖，其指导教师可获得证书表彰。</p>\n<p><img src=\"https://publicqn.saikr.com/2023/01/06/439_63b7e3ead0da3.jpg\" alt=\"\" width=\"252\" height=\"356\"></p>\n<p>4.&nbsp;全国优秀组织奖：根据组织参赛数量及选手获奖情况综合评定。</p>\n<p>5.&nbsp;全国优秀志愿者：根据志愿者等级判定进行登记评定。</p>\n<p>&nbsp;</p>\n<h3><strong>七</strong><strong>、&nbsp;报名费用</strong></h3>\n<p>为应对不断攀升的竞赛出题及证书工本邮寄成本、遏制少数人不参与考试的行为，大赛酌情收取报名费 49 元（包含竞赛出题、工本、证书制作邮寄等费用），以保障大赛的良性开展。恳请参赛者谅解为盼。</p>\n<p>&nbsp;</p>\n<h3><strong>八、 交流方式</strong></h3>\n<p>组委会老师QQ：2177390063</p>\n<p>组委会老师微信：saikr01</p>\n<p>大赛官方交流1群：703212441</p>\n<p>大赛官方交流2群：526059148</p>\n<p>&nbsp;</p>\n<h3><strong>九、&nbsp;其他事项</strong></h3>\n<p>1.&nbsp;报名赛事务必填写真实姓名。</p>\n<p>2.&nbsp;大赛唯一指定报名通道：赛氪网（https://www.saikr.com/vse/WOWT2023）。</p>\n<p>3. 因报名后同时享有数字刊阅读权限及VIP专属课程权限，故不可进行退赛退费操作。</p>\n<p>4.&nbsp;大赛组委会负责比赛的组织实施等各项工作。</p>\n<p>5.&nbsp;大赛组委会拥有大赛活动的最终解释权。</p>\n</div>', 1);
INSERT INTO `contestinfo` VALUES (13, 'uashga', 'sdfgdsfg', 'dfsgdfsg', '2023-02-28', '2023-03-08', NULL, '人文社科类', '排行榜国赛', 'image/徐灵飞电子签名.png', '<p>dfgdfgd</p>', 2);

-- ----------------------------
-- Table structure for contestquestion
-- ----------------------------
DROP TABLE IF EXISTS `contestquestion`;
CREATE TABLE if not exists `contestquestion`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `questionId` int UNSIGNED NOT NULL,
  `contestid` int UNSIGNED NOT NULL,
  `score` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `contestid`(`contestid` ASC) USING BTREE,
  INDEX `ques`(`questionId` ASC) USING BTREE,
  CONSTRAINT `contestid` FOREIGN KEY (`contestid`) REFERENCES `contestinfo` (`contestId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ques` FOREIGN KEY (`questionId`) REFERENCES `allquestion` (`questionId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contestquestion
-- ----------------------------
INSERT INTO `contestquestion` VALUES (9, 1212, 10, '100');
INSERT INTO `contestquestion` VALUES (10, 1220, 10, '100');
INSERT INTO `contestquestion` VALUES (11, 1212, 9, '1.75');
INSERT INTO `contestquestion` VALUES (12, 1213, 9, '1.75');
INSERT INTO `contestquestion` VALUES (13, 1212, 10, '1.75');
INSERT INTO `contestquestion` VALUES (14, 1213, 10, '1.75');
INSERT INTO `contestquestion` VALUES (15, 1228, 11, '3');

-- ----------------------------
-- Table structure for level
-- ----------------------------
DROP TABLE IF EXISTS `level`;
CREATE TABLE if not exists `level`  (
  `level` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`level`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of level
-- ----------------------------
INSERT INTO `level` VALUES ('区域赛');
INSERT INTO `level` VALUES ('排行榜国赛');
INSERT INTO `level` VALUES ('省赛');
INSERT INTO `level` VALUES ('非排行榜国赛');

-- ----------------------------
-- Table structure for milecode
-- ----------------------------
DROP TABLE IF EXISTS `milecode`;
CREATE TABLE if not exists `milecode`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `emile` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `code` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `log_time` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of milecode
-- ----------------------------

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE if not exists `news`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `NewsName` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `NewAuthor` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `time` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (10, '【高校竞赛数据查询指南】2021全国普通高校大学生竞赛分析报告', '小米', '2023-01-20 18:57:18', '<h5 class=\"ql-align-justify\"><span class=\"ql-size-large\">2021年3月22日，中国高等教育学会高校竞赛评估与管理体系研究工作组发布2020全国普通高校大学生竞赛排行榜，其中包含本科院校榜单13个、高职院校榜单10个、省份榜单3个（详见表1）。</span></h5>\n<h5 class=\"ql-align-center\"><span class=\"ql-size-large\"><img src=\"https://www.cahe.edu.cn/upload/gdjy/catcher/20210320/1616253421683730.jpg\" alt=\"文字文稿4.jpg\" width=\"611\" height=\"1024\"></span></h5>\n<h5 class=\"ql-align-justify\"><span class=\"ql-size-large\">2021年3月9日，全国高校竞赛评估与管理体系研究专家委员会会议在杭州召开。会上采取无记名投票方式，新增13项竞赛纳入2020全国普通高校大学生竞赛排行榜（榜单内已有竞赛的子赛纳入但不计算竞赛项目数）。纳入排行榜的全部竞赛项目共57项（详见表2）。</span></h5>\n<h5><span class=\"ql-size-large\"><img src=\"https://www.cahe.edu.cn/upload/gdjy/catcher/20210320/1616253422374181.jpg\" alt=\"文字文稿1.jpg\"></span></h5>\n<h5 class=\"ql-align-justify\"><span class=\"ql-size-large\">本轮大学生竞赛排行榜遵循公平、公正、公开的原则，秉承\"质量为本、谨慎推进\"的工作思路，根据获奖贡献、组织贡献和研究贡献三个方面相关数据进行排行，其中新增竞赛只计算2020年度数据，单项竞赛中单校获奖数超过20项按照奖项等级从高到低取前20项计分。</span></h5>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<h5 class=\"ql-align-justify\"><span class=\"ql-size-large\">今年发布的大学生竞赛排行榜榜单与去年相比呈现以下变化：①新增了\"五轮总排行榜\"，包括本科、高职和省份三种类型。从2017年12月发布第一轮全国普通高校大学生竞赛排行榜以来，中国高等教育学会已经连续发布四轮榜单，为从更长的时间段了解各高校大学生竞赛发展态势，特在今年发布\"五轮总榜单\"（时间跨度从2012年到2020年）。②不再发布示范高职和骨干高职子榜单。随着高等职业院校重点支持政策的变化，目前正处于\"双高\"建设阶段，故不再发布示范高职和骨干高职两类子榜单，只发布\"双高\"建设学校子榜单（一般高职范围界定为：除了\"双高\"建设学校以外的高等职业院校）。</span></h5>\n<h5 class=\"ql-align-justify\">&nbsp;</h5>\n<h5><span class=\"ql-size-large\"> 据统计，五轮总榜单（本科）中，哈尔滨工业大学位列榜首、浙江大学和上海交通大学分列第二名和第三名。2016-2020年榜单（本科）共列入全国1199所本科院校，哈尔滨工业大学位列榜首，浙江大学和西安交通大学分列第二名和第三名，第四到第十名分别是武汉大学、电子科技大学、华中科技大学、东南大学、山东大学、上海交通大学、西南交通大学。</span></h5>\n<p>&nbsp;</p>\n<h5 class=\"ql-align-justify\"><span class=\"ql-size-large\">在学校类型分布上，理工类高校表现最抢眼，有66所理工类高校进入前100，154所理工类高校进入前300；其次是综合类高校，有25所进入前100，74所进入前300；再次，师范类有7所进入前100，35所进入前300；农林类有2所进入前100，18所进入前300；最后，人文社科类和医药类没有高校进入前100，仅有17所人文社科类院校和2所医药类院校进入前300。结果还显示，&ldquo;双一流&rdquo;建设高校在榜单中名列前茅，41所列入排行榜的世界一流大学建设高校（国防科技大学未纳入排行榜）全部进入前300，其中有35所高校进入前100；66所世界一流学科建设高校进入前300，其中33所进入前100。193所地方院校进入前300，其中32所院校进入前100。</span></h5>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<h5 class=\"ql-align-justify\"><span class=\"ql-size-large\">从区域来看，东部地区优势明显，得分占总分的42.66%，中部地区为23.48%，西部地区为23.10%，东北地区为10.76%。在东部地区各省份中，除了海南省由于高校数量较少，占比较低之外，各省份的贡献占比在5.65%到15.61%之间；中部地区各省份贡献占比在10.28%到23.53%之间；西部地区各省份贡献占比差异较大，最低的只有1.38%，最高的达到18.69%，提示了西部地区的&ldquo;不均衡&rdquo;态势。东北地区辽宁省、吉林省、黑龙江省分别为44.84%、28.25%和26.91%。</span></h5>\n<h5 class=\"ql-align-justify\"><span class=\"ql-size-large\">从各省高校进入前300榜单的情况来看，进入高校数量前3的为：江苏省（24所）、北京市（22所）、浙江省和山东省并列（18所），进入高校数量占比前3的为：重庆市（36.00%）、上海市（35.90%）和北京市（32.84%）；从进入前100榜单的情况来看，进入高校数量前3的为：江苏省（12所）、北京市（9所）、浙江省、上海市和山东省并列（7所），进入高校数量占比前3的为：上海市（17.95%）、江苏省（15.58%）和海南省（14.29%）。</span></h5>\n<h5><span class=\"ql-size-large\"><img src=\"https://www.cahe.edu.cn/upload/gdjy/catcher/20210320/1616253422360625.jpg\" alt=\"文字文稿3_01.jpg\"></span></h5>\n<h5 class=\"ql-align-justify\">&nbsp;</h5>\n<h5><span class=\"ql-size-large\"> 据统计，五轮总榜单（高职）中，金华职业技术学院位列榜首、北京工业职业技术学院和北京电子科技职业学院分列第二名和第三名。2016-2020年榜单（高职）共列入全国1071所高职院校，金华职业技术学院位列榜首，重庆电子工程职业学院和深圳职业技术学院分别位居第二名和第三名，第四到第十名分别是芜湖职业技术学院、山东商业职业技术学院、福建信息职业技术学院、长沙民政职业技术学院、江西环境工程职业学院、江西应用技术职业学院、陕西工业职业技术学院。</span></h5>\n<p>&nbsp;</p>\n<h5 class=\"ql-align-justify\"><span class=\"ql-size-large\">从区域来看，东部地区得分占总分的40.76%，中部地区为27.84%，西部地区为24.76%，东北地区为6.64%。在东部地区各省份中，除海南省占比为2.55%外，其他各省份的贡献占比在5.18%到19.23%之间；中部地区各省份贡献占比在11.58%到21.15%之间；西部地区各省份贡献占比差异较大，12个省中有3个省贡献率在5%以下，5个省贡献率在10%以上，最低的只有0.65%，最高的达到18.26%。东北地区辽宁省、黑龙江省、吉林省分别为46.63%、31.09%和22.28%。</span></h5>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<h5 class=\"ql-align-justify\"><span class=\"ql-size-large\">从各省份高校进入前300的情况来看，进入高校数量前3的为：江苏省（30所）、山东省（24所）和浙江省（24所），进入高校数量占比前3的为：浙江省（48.00%）、重庆市（34.88%）、江苏省和西藏自治区（33.33%）；前100榜单中，江苏省最高（12所），安徽省和山东省次之（9所），广东省、浙江省和重庆市并列第三（各7所），进入高校数量占比前3的为：重庆市（16.28%）、北京市（16.00%）和浙江省（14.00%）。</span></h5>\n<h5><span class=\"ql-size-large\"><img src=\"https://www.cahe.edu.cn/upload/gdjy/catcher/20210320/1616253422988204.jpg\" alt=\"文字文稿3_01.jpg\"></span></h5>\n<h5 class=\"ql-align-justify\"><span class=\"ql-size-large\">榜单结果同步在中国高等教育学会官网（http://www.hie.edu.cn/）及微信公众号，中国高等教育学会工程教育专业委员会官网（http://csee.zju.edu.cn/）和全国高校学生竞赛与教师发展数据平台（http://rank.moocollege.com）发布。</span></h5>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<h5 class=\"ql-align-justify\"><span class=\"ql-size-large\">此次公布的排行榜拟于第56届中国高等教育博览会期间专题解读。</span></h5>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<h5 class=\"ql-align-justify\"><span class=\"ql-size-large\">第56届中国高等教育博览会以\"跨界聚合&middot;交叉融合：高质量发展\"为主题，定于5月21-23日在青岛&middot;红岛国际会议展览中心举办。敬请关注！</span></h5>\n<h5 class=\"ql-align-justify\">&nbsp;</h5>\n<h5><a class=\"ql-size-large\" href=\"https://oss.moocollege.com/10009668/edit/%E9%99%84%E4%BB%B61%20%E5%85%A8%E5%9B%BD%E6%99%AE%E9%80%9A%E9%AB%98%E6%A0%A1%E5%A4%A7%E5%AD%A6%E7%94%9F%E7%AB%9E%E8%B5%9B%E6%8E%92%E8%A1%8C%E6%A6%9C%E6%B8%85%E5%8D%95%EF%BC%88%E6%9C%AC%E7%A7%91%EF%BC%89%EF%BC%88%E5%8F%91%E5%B8%83%EF%BC%89_0Wvf8Smx_1616372894295.pdf\" target=\"_blank\" rel=\"noopener noreferrer\">附件1 全国普通高校大学生竞赛排行榜清单（本科）（发布）.pdf</a></h5>\n<h5><a class=\"ql-size-large\" href=\"https://oss.moocollege.com/10009668/edit/%E9%99%84%E4%BB%B62%20%E5%85%A8%E5%9B%BD%E6%99%AE%E9%80%9A%E9%AB%98%E6%A0%A1%E5%A4%A7%E5%AD%A6%E7%94%9F%E7%AB%9E%E8%B5%9B%E6%8E%92%E8%A1%8C%E6%A6%9C%E6%B8%85%E5%8D%95%EF%BC%88%E9%AB%98%E8%81%8C%EF%BC%89%EF%BC%88%E5%8F%91%E5%B8%83%EF%BC%89_C1O1BoHz_1616372894301.pdf\" target=\"_blank\" rel=\"noopener noreferrer\">附件2 全国普通高校大学生竞赛排行榜清单（高职）（发布）.pdf</a></h5>\n<h5><a class=\"ql-size-large\" href=\"https://oss.moocollege.com/10009668/edit/%E9%99%84%E4%BB%B63%20%E5%85%A8%E5%9B%BD%E6%99%AE%E9%80%9A%E9%AB%98%E6%A0%A1%E5%A4%A7%E5%AD%A6%E7%94%9F%E7%AB%9E%E8%B5%9B%E6%8E%92%E8%A1%8C%E6%A6%9C%E6%B8%85%E5%8D%95%EF%BC%88%E7%9C%81%E4%BB%BD%EF%BC%89%EF%BC%88%E5%8F%91%E5%B8%83%EF%BC%89_2uGrKq4J_1616372894311.pdf\" target=\"_blank\" rel=\"noopener noreferrer\">附件3 全国普通高校大学生竞赛排行榜清单（省份）（发布）.pdf</a></h5>');
INSERT INTO `news` VALUES (11, '第三届中国高校智能机器人创意大赛圆满成功', '小米', '2023-01-20 18:58:16', '<p><img src=\"https://new.moocollege.com/edit/20201231/4af708c2cbc411e9bda100163e040299/MtP5bNle_1609401115796/%E4%B8%AD%E5%9B%BD%E9%AB%98%E6%A0%A1%E6%99%BA%E8%83%BD%E6%9C%BA%E5%99%A8%E4%BA%BA%E5%88%9B%E6%84%8F%E5%A4%A7%E8%B5%9BBANNER.jpg\"></p>\n<p>2020年12月6日，第三届中国高校智能机器人创意大赛盛大落幕，此次大赛覆盖29个省份，共335所高等院校2378支队伍报名参赛，规模超往届，充分体现了各大高校老师和学生对大赛浓厚的兴趣和喜爱！经综合评审，共有536支队伍进决赛，评选出463支队伍获奖，其中一等奖53项，二等奖135项，三等奖251项，入围奖24项。为进一步推进学生创新意识和创造能力培养、强化学生动手能力和工程实践能力又增添了浓墨重彩的一笔。</p>\n<p>&nbsp;</p>\n<h3>打造云端竞赛新模式</h3>\n<p>值得一提的是，此次主办方在疫情情况下使用摩课云竞赛平台，以线上赛前指导+线上竞赛全流程执行的方式开创了云端竞赛新模式。</p>\n<p>赛前指导为参赛学生及指导老师提供了系列主题培训，共开展7次线上讲座，直播邀请机器人领域的著名专家，提前给到参赛学生以实践性的指导意见和往期优秀经验，给到学生最切实的帮助和引导，极大提升参赛体验，受到广大学生好评！竞赛采用一站式云端执行模式，参赛者以直播决赛、评委以直播评审。</p>\n<p>&nbsp;</p>\n<h3>3主题1专项，类型丰富</h3>\n<p>此次大赛由中国高等教育学会指导，中国高校智能机器人创意大赛组委会、浙江大学机器人研究院、浙江省余姚市人民政府共同主办。于2019年12月27日正式启动，分创意类、竞技类、格斗类3个主题赛和专项赛，给参赛选手以多维度、多方位的选择空间和发挥空间。</p>\n<h3>&nbsp;</h3>\n<h3>评审专家团强力助阵</h3>\n<p>竞赛由初赛、决赛评审和线上答辩等环节组成，各赛项最终的决赛线上答辩从11月28日开始，至12月6日结束。此次评审专家来自清华大学、中国科学院大学、浙江大学、华中科技大学、北京航空航天大学、大连理工大学、北京理工大学、电子科技大学等高校的知名专家学者。</p>\n<h3>&nbsp;</h3>\n<h3>竞赛精彩瞬间</h3>\n<p>决赛现场评审，按竞赛主题分为&ldquo;创意区&rdquo;、&ldquo;魔方区&rdquo;和&ldquo;格斗区&rdquo;和一个专项区，专家们通过线上会议对参赛学生作品进行一一评审。决赛现场，学生们纷纷以饱满的热情、丰富的语言及多样的表现形式，阐述了自己的作品创意及特色。线上好不热闹，集创新与使用于一体，可谓新颖独特、创意无限。</p>\n<p>主题一（创意设计）：家庭智能机器人&mdash;&mdash;让生活更美好　</p>\n<p>本次竞赛创意设计主题是设计制作出家庭智能型服务机器人。该主题贴近生活，又服务于生活。决赛中线上各种创意十足、功能多样、形态丰富的智能机器人令人目不暇接，有能够节约人力、免去吸纳油烟的自动烧烤创意机器人，有能够进行大型游泳池清洁的智能机器人，也有契合当下垃圾分类提倡，帮助自动识别分类的垃圾分拣智能机器人。</p>\n<p><img src=\"https://new.moocollege.com/edit/20201231/4af708c2cbc411e9bda100163e040299/7mevZ2IM_1609401312400/1.png\"></p>\n<p class=\"ql-align-center\">图注：创意区部分作品及专家评审问辩</p>\n<p>&nbsp;</p>\n<h3>主题二（魔方竞技）：&mdash;&mdash;挑战极限</h3>\n<p>本赛项参照人类魔方竞速规则，设计制作魔方机器人，综合运用机械、电子、信息和自然科学知识，实现比人&ldquo;计算&rdquo;更快、&ldquo;翻动&rdquo;更加灵活迅速的目标。魔方机器人限采用双手臂，手指限采用二指或五指的形式，手腕容许有转动和摆动，手臂为固定。</p>\n<p>上午参赛学生们各显神通，将竞技实战发挥的淋漓尽致，通过实战演绎进行PK角逐，比拼现场惊喜刺激不断。</p>\n<p><img src=\"https://new.moocollege.com/edit/20201231/4af708c2cbc411e9bda100163e040299/QdKW4uqx_1609401336058/2.png\"></p>\n<p class=\"ql-align-center\">图注：魔方区部分作品及专家评审问辩</p>\n<p class=\"ql-align-center\">&nbsp;</p>\n<h3>主题三（创意格斗及无人机专项挑战）：&mdash;挑战更强</h3>\n<p>&ldquo;IRFC&rdquo;智能机器人格斗大赛及无人机专项挑战赛将中国武术文化、竞技运动与人工智能、机器人等技术相结合。参赛学生通过团队协作，创造性制作属于自己的智能机器人进行对抗比赛。因为疫情原因，组委会开发了一套基于智能机器人的仿真系统，参赛队伍根据提供的仿真场景、机器人模型、传感器、控制器接口等，综合运用机械、电子、软件等专业知识，发挥创意设计各自的机器人作品 ，通过仿真和实物的结合，实现&ldquo;挑战更强&rdquo;的竞赛目标，在线仿真结合实物评选的创新模式，受到了各参赛队一致好评。</p>\n<p><img src=\"https://new.moocollege.com/edit/20201231/4af708c2cbc411e9bda100163e040299/VmjUklXF_1609401354645/3.png\"></p>\n<p class=\"ql-align-center\">图注：格斗区部分作品及线上裁判问辩</p>\n<p>&nbsp;</p>\n<h3>专项（专项竞赛-ROS机器人挑战赛）</h3>\n<p>ROS机器人挑战赛设有两类共4个赛项，第一类是地面机器人挑战赛，第二类是空中机器人挑战赛。</p>\n<p>A组：ROS机器人迷宫探险夺宝赛</p>\n<p>B组：ROS机械臂智能抓取赛</p>\n<p>C组：智能无人机挑战赛，基于ROS机器人操作系统的应用Slam的自主建图导航避障、目标识别等人工智能技术完成任务；</p>\n<p>D组：智能无人机挑战赛，基于Python编程，体现无人机视觉应用技术能力。</p>\n<p>各队选手们的奇思妙想、独特的线上比赛方式，不仅令嘉宾们耳目一新，也使比赛更具有趣味性和创新性。</p>\n<p>&nbsp;</p>\n<p>以赛促学，激发大学生进行科学研究与探索的兴趣；以赛促教，完善实践育人体系；以赛促联，进一步加强教育与产业、学校与社会、校际之间、课堂内外的联系与协同。竞赛不仅是学生创意的体现，更是创新教育和实践育人的主战场之一，恭喜第三届中国高校智能机器人创意大赛取得完满成功，期待第四届的精彩召开！</p>\n<p>&nbsp;</p>');
INSERT INTO `news` VALUES (12, '2022年“《英语世界》杯”翻译大赛', '小米', '2023-01-20 18:59:03', '<p><img src=\"https://new.moocollege.com/edit/2020424/4af708c2cbc411e9bda100163e040299/6QDhnwjM_1587717290179/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20200424163434.png\"></p>\n<p class=\"ql-align-center\"><strong>投稿截止时间：2020年7月20日24时</strong></p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&ldquo;《英语世界》杯&rdquo;翻译大赛肇始于2010年，由商务印书馆《英语世界》杂志社主办。短短数载，大赛参赛人数屡创新高，目前已经成为国内最有影响的翻译赛事之一。为推动翻译学科进一步发展，促进中外文化交流，我们秉承&ldquo;给力英语学习，探寻翻译之星&rdquo;的理念，于2020年继续举办第十一届&ldquo;《英语世界》杯&rdquo;翻译大赛，诚邀广大翻译爱好者积极参与，比秀佳译。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">第十一届&ldquo;《英语世界》杯&rdquo;翻译大赛得到杭州师范大学的大力支持，并由该校冠名本届比赛。2020 年的翻译大赛包含&ldquo;英译汉&rdquo;和&ldquo;汉译英&rdquo;两个组别。大赛初评交给合办院校的老师，以确保大赛评审的权威性和公信力。复评和终评我们将延续历届传统，从全国各地邀请知名翻译专家进行评审。</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-center\"><strong>合办院校</strong></p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-justify\">杭州师范大学&nbsp;外国语学院</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-center\"><strong>协办单位</strong></p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-justify\">中国翻译协会社会科学翻译委员会、中国外文局CATTI项目管理中心、中国英汉语比较研究会英汉翻译研究学科委员会、浙江省翻译协会、河南省翻译协会、山东省翻译协会、四川省翻译协会、广东省翻译协会、湖北省翻译理论与教学研究会、陕西省翻译协会、江苏省翻译协会、成都通译翻译有限公司、全国商务外语翻译考试（BETT）办公室、英文巴士网（www.en84.com）等。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-center\"><strong>赛程及评审</strong></p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-justify\">1. 2020年4月28日发布大赛原文（4月28日），10月公布获奖结果，见诸以下媒体：</p>\n<p class=\"ql-align-justify\">《英语世界》2020年第5期（启事及原文）和第10期（获奖结果等）、</p>\n<p class=\"ql-align-justify\">《英语世界》网站、《英语世界》微信公众平台、《英语世界》微博、杭州师范大学外国语学院网站、商务印书馆网站、英文巴士网。</p>\n<p class=\"ql-align-justify\">2. 参赛投稿截止时间：2020年7月20日24时。</p>\n<p class=\"ql-align-justify\">3. 大赛各项最新进展将通过《英语世界》微信公众号实时发布，请予关注。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-center\"><strong>参赛要求</strong></p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-justify\">1. 参赛者国籍、年龄、学历不限。</p>\n<p class=\"ql-align-justify\">2. 参赛译文须独立完成，不接受合作译稿。</p>\n<p class=\"ql-align-justify\">3. 仅第一次投稿有效，不接受修改后的再投稿件。</p>\n<p class=\"ql-align-justify\">4. 只接受电子版投稿，不接受纸质投稿。</p>\n<p class=\"ql-align-justify\">5. 在大赛截稿日之前，请妥善保存参赛译文，勿在报刊、网络等任何媒体上以任何方式公布，违者取消参赛资格并承担相应后果。</p>\n<p class=\"ql-align-justify\">6. 参赛译文一经发现抄袭或雷同，即取消涉事者参赛资格。</p>\n<p class=\"ql-align-justify\">7. 参赛者投稿即视为其本人同意和自愿遵守本启事的各项规定。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-center\"><strong>奖项及证明</strong></p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-justify\">1. &ldquo;英译汉&rdquo;和&ldquo;汉译英&rdquo;每组拟分别设置一等奖1名，二等奖2名，三等奖3名，优秀奖若干名。</p>\n<p class=\"ql-align-justify\">2. 一、二、三等奖颁发证书、奖金和奖品，优秀奖颁发证书和奖品。</p>\n<p class=\"ql-align-justify\">3. 所有获奖者均获赠2021年1&mdash;12期《英语世界》杂志，并有机会受邀成为《英语世界》的译者。</p>\n<p class=\"ql-align-justify\">4.积极组织学生参加翻译大赛的院校，颁发&ldquo;优秀组织奖&rdquo;证书；获奖院校有机会成为&ldquo;《英语世界》翻译实践基地&rdquo;合作单位。</p>\n<p class=\"ql-align-justify\">5. 入围复审名单的参赛者，应本人要求可由本社开具&ldquo;入围复审&rdquo;的书面证明。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-center\"><strong>报名及缴费</strong></p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-justify\">1. 为应对不断攀升的评审成本、提高奖励额度、遏制少数人敷衍投稿的行为，本届大赛酌情收取少量、不至给参赛者造成较大负担的参赛费，以保障大赛良性开展。恳请参赛者谅解为盼。</p>\n<p class=\"ql-align-justify\">2. 单独参加&ldquo;英译汉&rdquo;或&ldquo;汉译英&rdquo;其中一项比赛缴纳参赛费30元，两项均参加缴纳参赛费60元。</p>\n<p class=\"ql-align-justify\">3. 报名缴费流程：直接扫码进入大赛报名界面【请尽量通过PC端操作】，根据提示填写报名信息并缴纳相关报名费。</p>\n<p class=\"ql-align-justify\">4. 报名后没有成功缴费的，所投稿件无法进入评审程序。</p>\n<p class=\"ql-align-justify\">5. 因人力所限，缴费后无论是否提交参赛译文，费用概不退还，缴费时务请注意。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-center\"><strong>投稿规范</strong></p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-justify\">1.个人信息表及参赛译文于截稿日之前以附件形式发送至电子邮箱：<strong>yysjfyds@sina.com 。</strong></p>\n<p class=\"ql-align-justify\">2. 邮件主题：参赛者姓名+&times;&times;&times;（&times;&times;&times;为报名手机号，下同）。</p>\n<p class=\"ql-align-justify\">3.个人信息表：文件名&ldquo;&times;&times;&times;个人信息&rdquo;，excel格式，附件发送。请于文末链接下载表格模板。</p>\n<p class=\"ql-align-justify\">4.参赛译文：文件名&ldquo;&times;&times;&times;英译汉&rdquo;或&ldquo;&times;&times;&times;汉译英&rdquo;，word 格式，附件发送；同时参加两项比赛，请发送两个word附件，请勿合并成一个文件。</p>\n<p class=\"ql-align-justify\">5.参赛译文格式：宋体（英译汉）/Times New Roman（汉译英），黑色，小四号，1.5倍行距，两端对齐。译文每段之前请务必添加编号【1】【2】【3】&hellip;&hellip;（如原文所示）。</p>\n<p class=\"ql-align-justify\">6. 参赛译文中请勿留下任何个人信息，否则匿名评审过程中将被提前淘汰。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-center\"><strong>评审保障制度</strong></p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-justify\">为保证大赛评审的公平、公正和透明，尽量保证评审结果的客观和可靠，本届大赛在评审过程中特别设立以下制度：</p>\n<p class=\"ql-align-justify\">1. 本校回避制度：合办院校本校参赛稿的初评概由《英语世界》编辑部负责评审，而不交由合办院校本校教师评审。</p>\n<p class=\"ql-align-justify\">2. 复审申诉制度：拟定复审名单通过《英语世界》微信公众号发布后，未能进入该名单的参赛者3日内有权提出申诉。提出申诉需另交90元的二次评审费用，申诉稿将邀请三位外部专家独立负责二次评审；二次评审发现确属初评失误的，将退还二次评审费用，否则费用不予退还。大赛会根据申诉稿二次评审结果重新公布最终入围复审名单。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-center\"><strong>联系方式</strong></p>\n<p>&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">为办好本届翻译大赛，特成立大赛组委会，负责整个大赛的组织、实施和评审工作。组委会办公室设在《英语世界》编辑部。</p>\n<p class=\"ql-align-justify\">联系人：陈老师</p>\n<p class=\"ql-align-justify\">电话/传真：010-65539242</p>\n<p class=\"ql-align-justify\">地址：北京朝阳门外大街吉庆里9号楼E-2-1005（邮编100020）</p>\n<p>&nbsp;</p>\n<p>转自大学学科竞赛微信公众号：https://mp.weixin.qq.com/s/HOI-w98Hc6QVlKvXh4_7xQ</p>');
INSERT INTO `news` VALUES (13, '第十八届SuperMap杯高校GIS大赛开赛', '小米', '2023-01-20 18:59:54', '<p class=\"ql-align-center\"><img src=\"https://new.moocollege.com/edit/2020424/4af708c2cbc411e9bda100163e040299/763RAya2_1587717095895/1587717075(1).jpg\"></p>\n<p class=\"ql-align-center\"><strong>作品提交截止：2020年8月31日</strong></p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\"><strong>各相关院校：</strong></p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">SuperMap杯高校GIS大赛已经成功举办了十七届，通过比赛，加深了各院校学生对GIS技术的理解，推进了GIS技术的教学应用，为GIS人才培养搭建了良好的平台。中国地理学会、中国地理信息产业协会和北京超图软件股份有限公司决定联合举办第十八届SuperMap杯高校GIS大赛，并吸纳更多的海外高校参与，现将有关事宜通知如下：</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\"><strong>组织机构</strong></p>\n<p class=\"ql-align-justify\"><strong>主办单位</strong></p>\n<p class=\"ql-align-justify\">中国地理学会</p>\n<p class=\"ql-align-justify\">中国地理信息产业协会</p>\n<p class=\"ql-align-justify\">北京超图软件股份有限公司</p>\n<p class=\"ql-align-justify\"><strong>支持单位</strong></p>\n<p class=\"ql-align-justify\">华为技术有限公司</p>\n<p class=\"ql-align-justify\">麒麟软件有限公司</p>\n<p class=\"ql-align-justify\">江苏传智播客教育科技股份有限公司</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\"><strong>&nbsp;参赛对象</strong></p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">●中国赛区：全国高校2020年的在籍学生（含2020届），包括专科、本科和研究生（含硕士和博士）。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">●海外赛区：其他各国高校2020年的在籍学生。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">●每组团队由同一所高校的1-4名参赛学生和至多2名指导教师组成。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\"><strong>竞赛内容</strong></p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">1.制图组：自由选题，内容不限。通过数据的加工处理和制图的表达手段，创作具有特色风格的专题平面地图。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">2.分析组：自由选题，内容不限。通过对空间数据的分析和挖掘，解决行业应用和日常生活中的实际需求。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">3.论文组：基于GIS的学术和应用研究，如应用案例和行业解决方案、二三维一体化的应用、发展现状与趋势研究、大数据和人工智能等新兴技术的应用、开发技巧和心得等。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">4.命题开发组：统一命题，提供数据和项目框架，根据题目需求完成GIS应用系统的功能开发。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">5.开发组：自由选题，内容不限。结合当前的主流IT技术，设计并开发应用系统，体现GIS在各个领域的应用价值。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\"><strong>评审组织</strong></p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">1.大赛组委会将邀请业界知名专家学者组成评审委员会，本着公开、公平、公正的原则，负责大赛评审。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">2.制图组、分析组、论文组和命题开发组由评审委员会评比并最终排名。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">3.开发组由评审委员会评比和排名，产生决赛名单，通过决赛现场答辩，由评审委员会评比并最终排名。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\"><strong>赛程安排</strong></p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">●2020年3月16日：开始报名。</p>\n<p class=\"ql-align-justify\">●2020年4月6日：启动校园选拔赛，鼓励高校教师自主申办。</p>\n<p class=\"ql-align-justify\">●2020年6月1日：开放作品接收渠道。</p>\n<p class=\"ql-align-justify\">●2020年8月31日：作品提交截止。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\"><strong>奖项设置（中国赛区）</strong></p>\n<p class=\"ql-align-center\"><img src=\"https://new.moocollege.com/edit/2020424/4af708c2cbc411e9bda100163e040299/nk8dXaXi_1587717120703/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20200424163147.png\"></p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">1.奖金：特等奖10000元/组，一等奖5000元/组，二等奖2000元/组，三等奖500元/组，命题开发组挑战奖共享奖金20000元，开发组优胜奖200元/组。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">2.针对优胜奖及更高奖项，颁发优秀指导教师证书。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">3.针对三等奖及更高奖项，提供在实习和招聘中获得优先录用的机会。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\"><strong>参赛费用</strong></p>\n<p class=\"ql-align-justify\">不收取任何费用，免费提供相关软件和培训。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\"><strong>报名方式</strong></p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">大赛报名、信息发布、完整赛制和培训资源，请关注微信公众号&ldquo;GIS大赛&rdquo;。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;<img src=\"https://new.moocollege.com/edit/2020424/4af708c2cbc411e9bda100163e040299/BDGwnyS4_1587717127022/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20200424163151.jpg\"></p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\"><strong>培训安排</strong></p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">直播课程：大赛辅导、JavaScript导学。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">培训视频：软件操作、接口规范、JavaScript编程。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">教师培训：暑期举办线下培训班，详细通知于5月发布。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\"><strong>联系方式</strong></p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">电&nbsp;话：010-59896196</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">QQ群：781022469</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">网&nbsp;站：<strong>http://www.giscontest.com/</strong></p>\n<p>&nbsp;</p>\n<p>转自大学学科竞赛微信公众号：https://mp.weixin.qq.com/s/EzDBPGXLl9hUsAkbe4JBIA</p>');
INSERT INTO `news` VALUES (14, '第十七届“上译”杯翻译竞赛', '小米', '2023-01-20 19:00:22', '<p><strong>截稿日期：2020年8月10日24:00</strong></p>\n<p class=\"ql-align-justify\">主办：</p>\n<p class=\"ql-align-justify\">上海市文学艺术界联合会</p>\n<p class=\"ql-align-justify\">上海世纪出版（集团）有限公司</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">承办：上海翻译家协会</p>\n<p>上海译文出版社《外国文艺》杂志</p>\n<p>&nbsp;</p>\n<p class=\"ql-align-justify\">由<strong>上海翻译家协会</strong>和<strong>上海译文出版社</strong>共同承办，以推进我国翻译事业的繁荣发展、发现和培养翻译新人为宗旨的翻译竞赛成功举办十六届后，已成为翻译界知名赛事。本届&ldquo;上译&rdquo;杯翻译竞赛特设两个语种&mdash;&mdash;<strong>英语和西班牙语</strong>。具体参赛规则如下：</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">一、本届竞赛为英语、西班牙语翻译竞赛。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">二、参赛者年龄：45周岁以下<strong>（1975年1月1日后出生）</strong>。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">三、原文将刊登于2020年第3期（2020年6月出版）的《外国文艺》杂志及微信公众号（微信搜索&ldquo;上海译文外国文艺&rdquo;）、上海译文出版社微信公众号（微信搜索&ldquo;上海译文&rdquo;）、上海翻译家协会网站www.sta.org.cn及微信公众号（微信搜索&ldquo;上海翻译家协会&rdquo;）。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">四、本届翻译竞赛评选委员会由各大高校、出版社的专家学者组成。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">五、本届比赛采用网络参赛方式。英语组选手请将译作发送到engflaa@yiwen.com.cn，西班牙语组请发送到tcflaa@yiwen.com.cn。请于邮件标题中写明：&ldquo;上译&rdquo;杯翻译竞赛+姓名。注意附件中须包括两个WORD格式文件：译文和个人信息（标题采用三号黑体，正文五号宋体），请将两个文件分别命名为&ldquo;姓名+译文&rdquo;及&ldquo;姓名+个人信息&rdquo;。译文中请不要添加任何与译者个人身份信息相关的文字或符号，否则译文无效；个人信息中请写明姓名、性别、出生年月日、工作学习单位及家庭住址、联系电话、E-MAIL地址。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">六、参赛译文必须独立完成，合译、抄袭或请他人校订过的译文均属无效。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">七、决赛<strong>截稿日期为2020年8月10日24:00</strong>。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">八、&nbsp;为鼓励更多的翻译爱好者参与比赛，提高翻译水平，两个语种各设：</p>\n<p class=\"ql-align-justify\">一等奖1名（证书及价值6000元的奖金和奖品），</p>\n<p class=\"ql-align-justify\">二等奖2名（证书及价值3000元的奖金和奖品），</p>\n<p class=\"ql-align-justify\">三等奖3名（证书及价值2000元的奖金和奖品），</p>\n<p class=\"ql-align-justify\">优胜奖20名（证书及价值300元的奖品），</p>\n<p class=\"ql-align-justify\">此外还设优秀组织奖1名（价值5000元的奖金和奖品）。</p>\n<p class=\"ql-align-justify\">各奖项在没有合格译文的情况下将作相应空缺。</p>\n<p class=\"ql-align-justify\">获奖证书及奖品务必及时领取，两年内未领者视为自动放弃。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">九、《外国文艺》将于2020年第6期（2020年12月出版）公布评选结果并刊登优秀译文，竞赛结果将同时在《外国文艺》杂志、上海译文出版社、上海翻译家协会的微信等公众平台上公布。</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">十、以上条款的解释权归上海译文出版社所有。</p>\n<p class=\"ql-align-center\">&nbsp;</p>\n<p class=\"ql-align-center\">英语组评委</p>\n<p class=\"ql-align-justify\">（按姓氏笔画排序）</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">冯庆华&nbsp;上海外国语大学教授、博导；上海翻译家协会理事</p>\n<p class=\"ql-align-justify\">曲卫国&nbsp;复旦大学外文学院教授、博导；上海翻译家协会会员</p>\n<p class=\"ql-align-justify\">吴&nbsp;&nbsp;洪&nbsp;上海译文出版社编审、原副总编；原上海翻译家协会副会长</p>\n<p class=\"ql-align-justify\">张春柏&nbsp;华东师范大学外语学院教授、博导；原上海翻译家协会副会长；中国资深翻译家</p>\n<p class=\"ql-align-justify\">黄源深&nbsp;上海对外经贸大学教授、博导；原上海翻译家协会副会长；中国资深翻译家</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-center\">西班牙语组评委</p>\n<p class=\"ql-align-justify\">（按姓氏笔画排序）</p>\n<p class=\"ql-align-justify\">&nbsp;</p>\n<p class=\"ql-align-justify\">尹承东 原中央编译局副局长、主审，西班牙语翻译专家，原中央编译出版社社长兼总编</p>\n<p class=\"ql-align-justify\">张伟? 南京大学西班牙语系主任，博士，副教授</p>\n<p class=\"ql-align-justify\">陆经生 上海外国语大学西方语系教授，原上海翻译家协会常务理事</p>\n<p class=\"ql-align-justify\">范&nbsp;晔 北京大学西葡语系主任，博士，副教授</p>\n<p class=\"ql-align-justify\">程弋洋 复旦大学西班牙语言文学系主任，博士，青年研究员</p>\n<p>&nbsp;</p>\n<p>转自大学学科竞赛微信公众号：https://mp.weixin.qq.com/s/vmfO9e3Qo4LJXmKpGyuzsQ</p>');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE if not exists `teacher`  (
  `techid` int NOT NULL AUTO_INCREMENT,
  `number` int NOT NULL,
  `name` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `sex` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `age` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `job_title` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `school` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `specialized` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT '111111',
  `rule` int UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`techid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (1, 123, '小米', '男', '29', '教授', '成都理工大学', '计算机科学与技术', '13095584930', '12331@qq.com', '123', 1);
INSERT INTO `teacher` VALUES (2, 12, '小红', '女', '26', '教授', '成都理工大学工程技术学院', '软件工程', '13059960594', '123121@qq.com', '12', 0);
INSERT INTO `teacher` VALUES (3, 2147483647, '小明', '男', '1999', '助教', '成都理工大学工程技术', '计算机科学与技术', '13092203943', '2638532721@qq.com', '111111', 0);
INSERT INTO `teacher` VALUES (4, 1203, '羡慕', '男', '2022', '副教授', '西华大学', '计算机科学与技术', '15238495847', '123121@qq.com', '111111', 0);
INSERT INTO `teacher` VALUES (5, 12421, '显示', '男', '2004-12-01', '助教', '成都理工大学', '软件工程', '13002938493', '2837463728@qq.com', '111111', 0);
INSERT INTO `teacher` VALUES (6, 123, '12', '男', '2023-01-29', '教授', '成都理工大学', '123', '13095584930', '12331@qq.com', '111111', 0);
INSERT INTO `teacher` VALUES (7, 12321, 'w123', '女', '2023-01-29', '助教', '123', '123', '15647738495', '121212@qq.com', '111111', 0);

-- ----------------------------
-- Table structure for usercontest
-- ----------------------------
DROP TABLE IF EXISTS `usercontest`;
CREATE TABLE if not exists `usercontest`  (
  `userid` int NOT NULL AUTO_INCREMENT,
  `username` int UNSIGNED NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `contestId` int UNSIGNED NULL DEFAULT NULL,
  `contestName` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `conteststar` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `contestEnd` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `contestcategory` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `Contestlevel` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `Answertime` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `score` varchar(20) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE,
  INDEX `contestid1`(`contestId` ASC) USING BTREE,
  INDEX `user`(`username` ASC) USING BTREE,
  CONSTRAINT `contestid1` FOREIGN KEY (`contestId`) REFERENCES `contestinfo` (`contestId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of usercontest
-- ----------------------------
INSERT INTO `usercontest` VALUES (53, 121212, '士大夫', 9, '2023年第二届全国青年创新翻译大赛【英译汉类别】', '2023-01-11', '2023-02-27', '综合类', '排行榜国赛', NULL, '32');
INSERT INTO `usercontest` VALUES (54, 121212, '士大夫', 10, '2022年“创新实践杯”全国大学生英语词汇竞赛', '2023-01-04', '2023-02-21', '农医类', '非排行榜国赛', NULL, '76');
INSERT INTO `usercontest` VALUES (56, 1414, '二手房', 10, '2022年“创新实践杯”全国大学生英语词汇竞赛', '2023-01-04', '2023-02-21', '农医类', '非排行榜国赛', NULL, '96');
INSERT INTO `usercontest` VALUES (57, 1414, '二手房', 9, '2023年第二届全国青年创新翻译大赛【英译汉类别】', '2023-01-11', '2023-02-27', '综合类', '排行榜国赛', NULL, '49');
INSERT INTO `usercontest` VALUES (58, 13113, '范德萨', 9, '2023年第二届全国青年创新翻译大赛【英译汉类别】', '2023-01-11', '2023-02-27', '综合类', '排行榜国赛', NULL, '60');
INSERT INTO `usercontest` VALUES (61, 13223, '123123', 10, '2022年“创新实践杯”全国大学生英语词汇竞赛', '2023-01-04', '2023-02-21', '农医类', '非排行榜国赛', NULL, '84');
INSERT INTO `usercontest` VALUES (63, 123123, '梵蒂冈v', 9, '2023年第二届全国青年创新翻译大赛【英译汉类别】', '2023-01-11', '2023-02-27', '综合类', '排行榜国赛', NULL, '69');
INSERT INTO `usercontest` VALUES (67, 123, '小米', 9, '2023年第二届全国青年创新翻译大赛【英译汉类别】', '2023-01-11', '2023-02-27', '综合类', '排行榜国赛', '2023-04-04 18:33:01', '3.5');
INSERT INTO `usercontest` VALUES (69, 123, '小米', 11, '全国大学生计算机设计大赛', '2023-01-14', '2023-06-07', '理工类', '省赛', '2023-04-04 18:33:01', '3');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE if not exists `users`  (
  `username` int UNSIGNED NOT NULL,
  `userpassword` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `name` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `school` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `department` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `professional` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `grade` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (123, '1212', '小米', '男', '1212@qq.com', '成都理工大学工程技术学院', '12', '12', '2019', '黑龙江省,哈尔滨市,道里区');
INSERT INTO `users` VALUES (1313, '1313', NULL, NULL, '1313@qq.com', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (1414, '1414', '二手房', '男', '21323@qq.com', '但是', '而无法让', '二五', '2019', '山西省,太原市,小店区');
INSERT INTO `users` VALUES (13113, '131314', '范德萨', '女', '1212212@qq.com', '答复地方', '发放时', '323', '2019', '山西省,太原市,小店区');
INSERT INTO `users` VALUES (13223, '1232', '123123', '男', '2132323@qq.com', '123', '123', '123', '2020', '黑龙江省,哈尔滨市,道里区');
INSERT INTO `users` VALUES (121212, '121212', '士大夫', '女', '121212@qq.com', '12312', '21312', '123123', '2019', '山西省,太原市,小店区');
INSERT INTO `users` VALUES (123123, '123123', '梵蒂冈v', '男', '2121323@qq.com', '32w43', '234', '234', '2019', '黑龙江省,哈尔滨市,道里区');

-- ----------------------------
-- Event structure for deleteLog
-- ----------------------------
DROP EVENT IF EXISTS `deleteLog`;
delimiter ;;
CREATE EVENT `deleteLog`
ON SCHEDULE
EVERY '30' SECOND STARTS '2022-11-22 02:16:38'
ON COMPLETION PRESERVE
DO BEGIN
DELETE from milecode where TIMESTAMPDIFF(MINUTE,log_time,now())>15;
END
;;
delimiter ;

-- ----------------------------
-- Event structure for upcontent
-- ----------------------------
DROP EVENT IF EXISTS `upcontent`;
delimiter ;;
CREATE EVENT `upcontent`
ON SCHEDULE
EVERY '2' MINUTE STARTS '2022-12-08 23:40:51'
ON COMPLETION PRESERVE
DO BEGIN
UPDATE contestinfo SET outdated = 
CASE WHEN NOW() < Startdate THEN 0
		 WHEN Startdate < NOW() AND Enddate >NOW() THEN 1
			WHEN NOW() > Enddate THEN 2
END;
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
