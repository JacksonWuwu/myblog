/*
 Navicat MySQL Data Transfer

 Source Server         : mysql123
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : springblog

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 01/04/2022 06:47:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '博客id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '博客标题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '博客内容',
  `first_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '博客封面',
  `flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原创转载',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '摘要',
  `view` int NULL DEFAULT NULL COMMENT '阅读数',
  `appreciation` bit(1) NULL DEFAULT NULL COMMENT '开启赞赏',
  `share_statement` bit(1) NULL DEFAULT NULL COMMENT '转载声明',
  `commentabled` bit(1) NULL DEFAULT NULL COMMENT '开启评论',
  `published` bit(1) NULL DEFAULT NULL COMMENT '是否发布',
  `recommend` bit(1) NULL DEFAULT NULL COMMENT '是否推荐',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `type_id` int NULL DEFAULT NULL COMMENT '类型',
  `user_id` int NULL DEFAULT NULL COMMENT '作者用户',
  `likes` bigint NULL DEFAULT NULL COMMENT '喜欢数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `2`(`user_id`) USING BTREE,
  INDEX `1`(`type_id`) USING BTREE,
  CONSTRAINT `1` FOREIGN KEY (`type_id`) REFERENCES `t_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_blog
-- ----------------------------
INSERT INTO `t_blog` VALUES (12, 'Django整合markdown', '## 前言\r\n\r\n最近自己在开发一个blog，因为比较喜欢用Markdown来写文章，而且目前很多平台都支持Markdown的语法，所以想给blog装个Markdown的编辑器。于是，就搜了一下，发现了django-mdeditor这个库，给大家分享一下。\r\n\r\n## 简单介绍\r\n\r\n**Github地址:** https://github.com/pylixm/django-mdeditor \r\n\r\nDjango-mdeditor 是基于 Editor.md 的一个 django Markdown 文本编辑插件应用。\r\n\r\nDjango-mdeditor 的灵感参考自伟大的项目 django-ckeditor（https://github.com/django-ckeditor/django-ckeditor）\r\n\r\n## 后端编辑器使用\r\n\r\n### 1.安装相关库\r\n\r\n```\r\npip install django-mdeditor  # 用于后台编辑\r\npip install markdown # 用于前端显示\r\n```\r\n\r\n首先大家先安装这两个库，django-mdeditor库就是用在我们管理后台的md编辑器，markdown则是在前端显示时使用。\r\n\r\n### 2.配置\r\n\r\n安装完两个库后，我们需要进行相关的配置。\r\n\r\n\r\n![](https://imgkr.cn-bj.ufileos.com/95c8ddff-3cee-4a31-bfcc-530069d2375b.png)\r\n\r\n新增setting配置：\r\n\r\n```\r\nINSTALLED_APPS = [\r\n    \'django.contrib.admin\',\r\n    \'django.contrib.auth\',\r\n    \'django.contrib.contenttypes\',\r\n    \'django.contrib.sessions\',\r\n    \'django.contrib.messages\',\r\n    \'django.contrib.staticfiles\',\r\n    \'blog\',\r\n    \'mdeditor\',\r\n]\r\n```\r\n\r\n除了配置上面的信息，还需要配置资源文件夹：\r\n\r\n```\r\nMEDIA_ROOT = os.path.join(BASE_DIR, \'media\')  \r\n\r\nMEDIA_URL = \'/media/\'   #你上传的文件和图片会默认存在/media/editor下\r\n```\r\n\r\n以为就完了？不，你还需要去url进行配置：\r\n\r\n\r\n![点击放大](https://imgkr.cn-bj.ufileos.com/d517f0c2-d008-4f38-8086-c1bf69883476.png)\r\n\r\n大家把我打红框的代码弄上去就ok了\r\n\r\n这时，我们就大概配置完成了。\r\n\r\n### 3.使用Markdown\r\n\r\n\r\n\r\n![点击放大](https://imgkr.cn-bj.ufileos.com/1925edaf-64db-4217-8057-6570db74faae.png)\r\n\r\n\r\n此时只需要在model中填写相应的属性，即可调用该编辑器。\r\n\r\n当然，在进入管理页面之前，你需要在admin中进行注册\r\n\r\n```python\r\nadmin.site.register(Acticle) # Acticle 是我文章的model名\r\n```\r\n\r\n打开后台之后，我们就会发现Markdown编辑器出现了：\r\n\r\n![](https://imgkr.cn-bj.ufileos.com/c9821626-0d9f-4838-b7ae-514d16c6ed18.png)\r\n\r\n我们在这里插入的图片或者上传的文件都会在media文件夹中，这个文件夹在上面配置中提到，必须要有！！！\r\n\r\n\r\n## 前端使用\r\n\r\n我们使用了Markdown编辑器编写的文章在前端显示时，必须得将Markdown语法“翻译”成富文本的形式，所以这里我们需要使用到markdown这个库。\r\n\r\n### 视图函数\r\n\r\n```\r\npip install markdown\r\n```\r\n\r\n我们书写的博客文章内容存在Post的body属性里，回到我们的详情页视图函数，对post的body 的值做一下渲染，把Markdown文本转为HTML文本再传递给模板：\r\n\r\n```python\r\nimport markdown\r\nfrom django.shortcuts import render, get_object_or_404\r\nfrom .models import Post\r\n \r\ndef post_article(request, pk):\r\n    post = get_object_or_404(Post, pk=pk)\r\n    # 记得在顶部引入 markdown 模块\r\n    post.body = markdown.markdown(post.body,\r\n                                  extensions=[\r\n                                     \'markdown.extensions.extra\',\r\n                                     \'markdown.extensions.codehilite\',\r\n                                     \'markdown.extensions.toc\',\r\n                                  ])\r\n    return render(request, \'blog/detail.html\', context={\'post\': post})\r\n```\r\n\r\n可能有些朋友不懂get_object_or_404方法，给大家简单介绍一下get_object_or_404：我们原来调用django 的get方法(model.object.get())，如果查询的对象不存在的话，会抛出一个DoesNotExist的异常，现在我们调用django get_object_or_404方法，它会默认的调用django 的get方法，如果查询的对象不存在的话，会抛出一个Http404的异常，我感觉这样对用户比较友好，如果用户查询某个产品不存在的话，我们就显示404的页面给用户，比直接显示异常好。\r\n\r\n**markdown.extensions.extra：** 用于标题、表格、引用这些基本转换\r\n\r\n**markdown.extensions.codehilite：** 用于语法高亮\r\n\r\n**markdown.extensions.toc：** 用于生成目录\r\n\r\n### 替换网页模板\r\n\r\n在模板中找到展示博客文章的地方加上如下代码，注意这里需要使用safe过滤器。\r\n\r\n```\r\n<div>\r\n    {{ post.body|safe }}\r\n</div>\r\n```\r\n\r\n通过这样就能够显示md语法的文章了\r\n\r\n## 总结\r\n\r\n在开发过程中遇到的一个小需求就分享给大家，当然我介绍的只是mdeditor的一部分知识，mdeditor还有一些相关的配置，这里我就没给大家说了，大家可以去GitHub上自行看他们的官方文档，顺便也可以去star一下！\r\n\r\n- 第一点\r\n- 第二点\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n', 'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2857909136,365461141&fm=26&gp=0.jpg', '转载', '最近自己在开发一个blog，因为比较喜欢用Markdown来写文章，而且目前很多平台都支持Markdown的语法，所以想给blog装个Markdown的编辑器。于是，就搜了一下，发现了django-mdeditor这个库，给大家分享一下。', 197, b'1', b'1', b'1', b'1', b'1', '2020-05-12 17:42:17', '2022-02-12 17:42:17', 3, 1, 12);
INSERT INTO `t_blog` VALUES (18, '分享| 我收藏夹里贼好用的网站', '## 前言\r\n\r\n各位小伙伴大家好，今天又来分享一波自己收藏的超好用的网站，之前写过两期实用网站分享，感觉反馈都不错。今天抽空再来跟大家分享一波，当然如果你有一些好的网站，欢迎给我私信分享！\r\n\r\n\r\n\r\n![](https://imgkr.cn-bj.ufileos.com/b6443eb6-897a-4cd1-8409-bb5cfc222632.png)\r\n\r\n\r\n## 贼好用的网站\r\n\r\n### 1. processon\r\n\r\n\r\n![](https://imgkr.cn-bj.ufileos.com/2970c006-7a7c-4cf9-abcc-6f24a904caa5.png)\r\n\r\nwww.processon.com\r\n\r\n这个网站是真心不错，尤其是对于程序员群体来说，不仅仅可以画UML，原型图，网络拓扑图等等，还能看到网上各路大神分享出来的思维导图。简直就是学习利器！非常强烈推荐！！！\r\n\r\n\r\n### 2. cloudconvert\r\n\r\n\r\n![](https://imgkr.cn-bj.ufileos.com/48ee08bf-ecba-43cb-9281-1f9faa528480.png)\r\n\r\ncloudconvert.com\r\n\r\n有时候真的会被格式问题搞的蛋疼，这个网站还是挺良心的，支持非常多的格式转换。相信这个能够给你带来很多的便利！\r\n\r\n### 3. easyicon\r\n\r\n\r\n![](https://imgkr.cn-bj.ufileos.com/61cd1981-a742-434d-bad1-3af63005dc99.png)\r\n\r\nwww.easyicon.net\r\n\r\n图标网，写前端美工必备网站，无数个图标随意选，各种格式大小随便挑。\r\n\r\n\r\n### 4. mdnice\r\n\r\n\r\n![](https://imgkr.cn-bj.ufileos.com/df4867d5-6fbf-4392-8a14-d55467e7f33f.png)\r\n\r\nmdnice.com\r\n\r\n这是一个md美化编辑器，可以美化公众号、知乎等平台的md文章。\r\n\r\n\r\n\r\n\r\n\r\n\r\n## 结尾\r\n\r\n以上就是我这次的分享，希望能够给你一些帮助，也非常感谢这些良心站长的网站。\r\n\r\n\r\n![](https://imgkr.cn-bj.ufileos.com/9792fa9c-7f17-4c0d-a3c2-8115700921f9.png)\r\n\r\n\r\n\r\n', 'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3984473917,238095211&fm=26&gp=0.jpg', '原创', '分享一些贼好用的网站，欢迎进来看看！', 167, b'1', b'1', b'1', b'1', b'1', '2020-06-29 19:25:31', '2022-03-31 19:56:59', 3, 1, 8);
INSERT INTO `t_blog` VALUES (22, 'spring概述及IOC理论推导', '## 简介\r\n\r\nSpring : 春天 --->给软件行业带来了春天\r\n\r\n2002年，Rod Jahnson首次推出了Spring框架雏形interface21框架。\r\n\r\n2004年3月24日，Spring框架以interface21框架为基础，经过重新设计，发布了1.0正式版。\r\n\r\n很难想象Rod Johnson的学历 , 他是悉尼大学的博士，然而他的专业不是计算机，而是音乐学。\r\n\r\nSpring理念 : 使现有技术更加实用 . 本身就是一个大杂烩 , 整合现有的框架技术\r\n\r\n官网 : http://spring.io/\r\n\r\n官方下载地址 : https://repo.spring.io/libs-release-local/org/springframework/spring/\r\n\r\nGitHub : https://github.com/spring-projects\r\n\r\n\r\n\r\n## 优点\r\n\r\n1、Spring是一个开源免费的框架 , 容器  .\r\n\r\n2、Spring是一个轻量级的框架 , 非侵入式的 .\r\n\r\n3、控制反转 IoC  , 面向切面 Aop\r\n\r\n4、对事物的支持 , 对框架的支持\r\n\r\n.......\r\n\r\n一句话概括：\r\n\r\n**Spring是一个轻量级的控制反转(IoC)和面向切面(AOP)的容器（框架）。**\r\n\r\n\r\n\r\n## 组成\r\n\r\n\r\n\r\nSpring 框架是一个分层架构，由 7 个定义良好的模块组成。Spring 模块构建在核心容器之上，核心容器定义了创建、配置和管理 bean 的方式 .\r\n\r\n\r\n\r\n\r\n组成 Spring 框架的每个模块（或组件）都可以单独存在，或者与其他一个或多个模块联合实现。每个模块的功能如下：\r\n\r\n核心容器：核心容器提供 Spring 框架的基本功能。核心容器的主要组件是 BeanFactory，它是工厂模式的实现。BeanFactory 使用控制反转（IOC） 模式将应用程序的配置和依赖性规范与实际的应用程序代码分开。\r\n\r\nSpring 上下文：Spring 上下文是一个配置文件，向 Spring 框架提供上下文信息。Spring 上下文包括企业服务，例如 JNDI、EJB、电子邮件、国际化、校验和调度功能。\r\n\r\n**Spring AOP：**通过配置管理特性，Spring AOP 模块直接将面向切面的编程功能 , 集成到了 Spring 框架中。所以，可以很容易地使 Spring 框架管理任何支持 AOP的对象。Spring AOP 模块为基于 Spring 的应用程序中的对象提供了事务管理服务。通过使用 Spring AOP，不用依赖组件，就可以将声明性事务管理集成到应用程序中。\r\n\r\n**Spring DAO：**JDBC DAO 抽象层提供了有意义的异常层次结构，可用该结构来管理异常处理和不同数据库供应商抛出的错误消息。异常层次结构简化了错误处理，并且极大地降低了需要编写的异常代码数量（例如打开和关闭连接）。Spring DAO 的面向 JDBC 的异常遵从通用的 DAO 异常层次结构。\r\n\r\n**Spring ORM：**Spring 框架插入了若干个 ORM 框架，从而提供了 ORM 的对象关系工具，其中包括 JDO、Hibernate 和 iBatis SQL Map。所有这些都遵从 Spring 的通用事务和 DAO 异常层次结构。\r\n\r\n**Spring Web 模块：**Web 上下文模块建立在应用程序上下文模块之上，为基于 Web 的应用程序提供了上下文。所以，Spring 框架支持与 Jakarta Struts 的集成。Web 模块还简化了处理多部分请求以及将请求参数绑定到域对象的工作。\r\n\r\n**Spring MVC 框架：**MVC 框架是一个全功能的构建 Web 应用程序的 MVC 实现。通过策略接口，MVC 框架变成为高度可配置的，MVC 容纳了大量视图技术，其中包括 JSP、Velocity、Tiles、iText 和 POI。\r\n\r\n\r\n\r\n## 拓展\r\n\r\nSpring Boot与Spring Cloud\r\n\r\nSpring Boot 是 Spring 的一套快速配置脚手架，可以基于Spring Boot 快速开发单个微服务;\r\n\r\nSpring Cloud是基于Spring Boot实现的；\r\n\r\nSpring Boot专注于快速、方便集成的单个微服务个体，Spring Cloud关注全局的服务治理框架；\r\n\r\nSpring Boot使用了约束优于配置的理念，很多集成方案已经帮你选择好了，能不配置就不配置 , Spring Cloud很大的一部分是基于Spring Boot来实现，Spring Boot可以离开Spring Cloud独立使用开发项目，但是Spring Cloud离不开Spring Boot，属于依赖的关系。\r\n\r\nSpringBoot在SpringClound中起到了承上启下的作用，如果你要学习SpringCloud必须要学习SpringBoot。\r\n\r\n\r\n\r\n## IoC基础\r\n新建一个空白的maven项目\r\n\r\n分析实现\r\n\r\n我们先用我们原来的方式写一段代码 .\r\n\r\n1、先写一个UserDao接口\r\n```java\r\npublic interface UserDao {\r\n   public void getUser();\r\n}\r\n```\r\n2、再去写Dao的实现类\r\n```java\r\npublic class UserDaoImpl implements UserDao {\r\n   @Override\r\n   public void getUser() {\r\n       System.out.println(\"获取用户数据\");\r\n  }\r\n}\r\n```\r\n3、然后去写UserService的接口\r\n```java\r\npublic interface UserService {\r\n   public void getUser();\r\n}\r\n```\r\n4、最后写Service的实现类\r\n```java\r\npublic class UserServiceImpl implements UserService {\r\n   private UserDao userDao = new UserDaoImpl();\r\n\r\n   @Override\r\n   public void getUser() {\r\n       userDao.getUser();\r\n  }\r\n}\r\n```\r\n5、测试一下\r\n```java\r\n@Test\r\npublic void test(){\r\n   UserService service = new UserServiceImpl();\r\n   service.getUser();\r\n}\r\n```\r\n这是原来的方式,现在修改一下 .\r\n\r\n把Userdao的实现类增加一个 .\r\n```java\r\npublic class UserDaoMySqlImpl implements UserDao {\r\n   @Override\r\n   public void getUser() {\r\n       System.out.println(\"MySql获取用户数据\");\r\n  }\r\n}\r\n```\r\n紧接着去使用MySql的话 , 就需要去service实现类里面修改对应的实现\r\n```java\r\npublic class UserServiceImpl implements UserService {\r\n   private UserDao userDao = new UserDaoMySqlImpl();\r\n\r\n   @Override\r\n   public void getUser() {\r\n       userDao.getUser();\r\n  }\r\n}\r\n```\r\n在假设, 再增加一个Userdao的实现类 .\r\n```java\r\npublic class UserDaoOracleImpl implements UserDao {\r\n   @Override\r\n   public void getUser() {\r\n       System.out.println(\"Oracle获取用户数据\");\r\n  }\r\n}\r\n```\r\n那么要使用Oracle , 又需要去service实现类里面修改对应的实现 . 假设我们的这种需求非常大 , 这种方式就根本不适用了, 甚至反人类对吧 , 每次变动 , 都需要修改大量代码 . 这种设计的耦合性太高了, 牵一发而动全身 .\r\n\r\n那我们如何去解决呢 ?\r\n\r\n我们可以在需要用到他的地方 , 不去实现它 , 而是留出一个接口 , 利用set , 我们去代码里修改下 .\r\n```java\r\npublic class UserServiceImpl implements UserService {\r\n   private UserDao userDao;\r\n// 利用set实现\r\n   public void setUserDao(UserDao userDao) {\r\n       this.userDao = userDao;\r\n  }\r\n\r\n   @Override\r\n   public void getUser() {\r\n       userDao.getUser();\r\n  }\r\n}\r\n```\r\n现在去我们的测试类里 , 进行测试 ;\r\n```java\r\n@Test\r\npublic void test(){\r\n   UserServiceImpl service = new UserServiceImpl();\r\n   service.setUserDao( new UserDaoMySqlImpl() );\r\n   service.getUser();\r\n   //那我们现在又想用Oracle去实现呢\r\n   service.setUserDao( new UserDaoOracleImpl() );\r\n   service.getUser();\r\n}\r\n```\r\n他们已经发生了根本性的变化 , 很多地方都不一样了 . 仔细去思考一下 , 以前所有东西都是由程序去进行控制创建 , 而现在是由我们自行控制创建对象 , 把主动权交给了调用者 . 程序不用去管怎么创建,怎么实现了 . 它只负责提供一个接口 .\r\n\r\n这种思想 , 从本质上解决了问题 , 我们程序员不再去管理对象的创建了 , 更多的去关注业务的实现 . 耦合性大大降低 . 这也就是IOC的原型 !\r\n\r\n\r\n\r\n## IOC本质\r\n\r\n控制反转IoC(Inversion of Control)，是一种设计思想，DI(依赖注入)是实现IoC的一种方法，也有人认为DI只是IoC的另一种说法。没有IoC的程序中 , 我们使用面向对象编程 , 对象的创建与对象间的依赖关系完全硬编码在程序中，对象的创建由程序自己控制，控制反转后将对象的创建转移给第三方，个人认为所谓控制反转就是：获得依赖对象的方式反转了。\r\n\r\n\r\n\r\nIoC是Spring框架的核心内容，使用多种方式完美的实现了IoC，可以使用XML配置，也可以使用注解，新版本的Spring也可以零配置实现IoC。\r\n\r\nSpring容器在初始化时先读取配置文件，根据配置文件或元数据创建与组织对象存入容器中，程序使用时再从Ioc容器中取出需要的对象。\r\n\r\n图片\r\n\r\n采用XML方式配置Bean的时候，Bean的定义信息是和实现分离的，而采用注解的方式可以把两者合为一体，Bean的定义信息直接以注解的形式定义在实现类中，从而达到了零配置的目的。\r\n\r\n控制反转是一种通过描述（XML或注解）并通过第三方去生产或获取特定对象的方式。在Spring中实现控制反转的是IoC容器，其实现方法是依赖注入（Dependency Injection,DI）。', 'https://spring.io/images/why-spring-02-d7c8f81f3847758aa94612e8a4edb5c9.svg', '原创', 'spring概述及IOC理论推导', 12, b'1', b'0', b'1', b'1', b'1', '2022-03-31 19:03:09', '2022-03-30 20:24:27', 16, 1, 1);
INSERT INTO `t_blog` VALUES (23, '什么是MVC', '**MVC是模型(Model)、视图(View)、控制器(Controller)的简写，是一种软件设计规范。**\r\n\r\n是将业务逻辑、数据、显示分离的方法来组织代码。\r\n\r\nMVC主要作用是降低了视图与业务逻辑间的双向偶合。\r\n\r\nMVC不是一种设计模式，MVC是一种架构模式。当然不同的MVC存在差异。\r\n\r\n**Model（模型）：**数据模型，提供要展示的数据，因此包含数据和行为，可以认为是领域模型或JavaBean组件（包含数据和行为），不过现在一般都分离开来：Value Object（数据Dao） 和 服务层（行为Service）。也就是模型提供了模型数据查询和模型数据的状态更新等功能，包括数据和业务。\r\n**\r\nView（视图）：**负责进行模型的展示，一般就是我们见到的用户界面，客户想看到的东西。\r\n\r\n**Controller（控制器）：**接收用户请求，委托给模型进行处理（状态改变），处理完毕后把返回的模型数据返回给视图，由视图负责展示。也就是说控制器做了个调度员的工作。\r\n\r\n最典型的MVC就是JSP + servlet + javabean的模式。\r\n\r\n\r\n![](/img/upload/blog/屏幕截图 2022-03-31 193126.png)\r\n\r\n## Model1时代\r\n在web早期的开发中，通常采用的都是Model1。\r\n\r\nModel1中，主要分为两层，视图层和模型层。\r\n\r\n\r\nModel1优点：架构简单，比较适合小型项目开发；\r\n\r\nModel1缺点：JSP职责不单一，职责过重，不便于维护；\r\n\r\n## Model2时代\r\nModel2把一个项目分成三部分，包括视图、控制、模型。\r\n\r\n![](/img/upload/blog/屏幕截图 2022-03-31 193411.png)\r\n\r\n用户发请求\r\n\r\nServlet接收请求数据，并调用对应的业务逻辑方法\r\n\r\n业务处理完毕，返回更新后的数据给servlet\r\n\r\nservlet转向到JSP，由JSP来渲染页面\r\n\r\n响应给前端更新后的页面\r\n\r\n**职责分析：**\r\n\r\nController：控制器\r\n\r\n取得表单数据\r\n\r\n调用业务逻辑\r\n\r\n转向指定的页面\r\n\r\nModel：模型\r\n\r\n业务逻辑\r\n\r\n保存数据的状态\r\n\r\nView：视图\r\n\r\n显示页面\r\n\r\nModel2这样不仅提高的代码的复用率与项目的扩展性，且大大降低了项目的维护成本。Model 1模式的实现比较简单，适用于快速开发小规模项目，Model1中JSP页面身兼View和Controller两种角色，将控制逻辑和表现逻辑混杂在一起，从而导致代码的重用性非常低，增加了应用的扩展性和维护的难度。Model2消除了Model1的缺点。\r\n\r\n\r\n\r\n## Servlet\r\n新建一个Maven工程当做父工程！pom依赖！\r\n```xml\r\n<dependencies>\r\n   <dependency>\r\n       <groupId>junit</groupId>\r\n       <artifactId>junit</artifactId>\r\n       <version>4.12</version>\r\n   </dependency>\r\n   <dependency>\r\n       <groupId>org.springframework</groupId>\r\n       <artifactId>spring-webmvc</artifactId>\r\n       <version>5.1.9.RELEASE</version>\r\n   </dependency>\r\n   <dependency>\r\n       <groupId>javax.servlet</groupId>\r\n       <artifactId>servlet-api</artifactId>\r\n       <version>2.5</version>\r\n   </dependency>\r\n   <dependency>\r\n       <groupId>javax.servlet.jsp</groupId>\r\n       <artifactId>jsp-api</artifactId>\r\n       <version>2.2</version>\r\n   </dependency>\r\n   <dependency>\r\n       <groupId>javax.servlet</groupId>\r\n       <artifactId>jstl</artifactId>\r\n       <version>1.2</version>\r\n   </dependency>\r\n</dependencies>\r\n```\r\n建立一个Moudle：springmvc-01-servlet ， 添加Web app的支持！\r\n\r\n导入servlet 和 jsp 的 jar 依赖\r\n```xml\r\n<dependency>\r\n   <groupId>javax.servlet</groupId>\r\n   <artifactId>servlet-api</artifactId>\r\n   <version>2.5</version>\r\n</dependency>\r\n<dependency>\r\n   <groupId>javax.servlet.jsp</groupId>\r\n   <artifactId>jsp-api</artifactId>\r\n   <version>2.2</version>\r\n</dependency>\r\n```\r\n编写一个Servlet类，用来处理用户的请求\r\n\r\n```java\r\n//实现Servlet接口\r\npublic class HelloServlet extends HttpServlet {\r\n   @Override\r\n   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {\r\n       //取得参数\r\n       String method = req.getParameter(\"method\");\r\n       if (method.equals(\"add\")){\r\n           req.getSession().setAttribute(\"msg\",\"执行了add方法\");\r\n      }\r\n       if (method.equals(\"delete\")){\r\n           req.getSession().setAttribute(\"msg\",\"执行了delete方法\");\r\n      }\r\n       //业务逻辑\r\n       //视图跳转\r\n       req.getRequestDispatcher(\"/WEB-INF/jsp/hello.jsp\").forward(req,resp);\r\n  }\r\n\r\n   @Override\r\n   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {\r\n       doGet(req,resp);\r\n  }\r\n}\r\n```\r\n编写Hello.jsp，在WEB-INF目录下新建一个jsp的文件夹，新建hello.jsp\r\n```xml\r\n<%@ page contentType=\"text/html;charset=UTF-8\" language=\"java\" %>\r\n<html>\r\n<head>\r\n   <title>Jackson</title>\r\n</head>\r\n<body>\r\n${msg}\r\n</body>\r\n</html>\r\n```\r\n在web.xml中注册Servlet\r\n```xml\r\n<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<web-app xmlns=\"http://xmlns.jcp.org/xml/ns/javaee\"\r\n        xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\r\n        xsi:schemaLocation=\"http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd\"\r\n        version=\"4.0\">\r\n   <servlet>\r\n       <servlet-name>HelloServlet</servlet-name>\r\n       <servlet-class>com.Jackson.servlet.HelloServlet</servlet-class>\r\n   </servlet>\r\n   <servlet-mapping>\r\n       <servlet-name>HelloServlet</servlet-name>\r\n       <url-pattern>/user</url-pattern>\r\n   </servlet-mapping>\r\n\r\n</web-app>\r\n```\r\n配置Tomcat，并启动测试\r\n\r\nlocalhost:8080/user?method=add\r\n\r\nlocalhost:8080/user?method=delete\r\n\r\nMVC框架要做哪些事情\r\n\r\n将url映射到java类或java类的方法 .\r\n\r\n封装用户提交的数据 .\r\n\r\n处理请求--调用相关的业务处理--封装响应数据 .\r\n\r\n将响应的数据进行渲染 . jsp / html 等表示层数据 .\r\n\r\n说明：\r\n\r\n	常见的服务器端MVC框架有：Struts、Spring MVC、ASP.NET MVC、Zend Framework、JSF；\r\n	常见前端MVC框架：vue、angularjs、react、backbone；\r\n	由MVC演化出了另外一些模式如：MVP、MVVM 等等....', 'https://spring.io/images/spring-logo-9146a4d3298760c2e7e49595184e1975.svg', '原创', 'MVC是一种软件设计规范。', 12, b'1', b'0', b'1', b'1', b'1', '2022-03-31 20:07:30', '2022-02-05 21:19:25', 18, 1, 2);
INSERT INTO `t_blog` VALUES (24, '优秀的持久层框架——Mybatis', '### 1.1、 什么是Mybatis\r\n\r\n- MyBatis 是一款优秀的**持久层框架**\r\n- 它支持定制化 SQL、存储过程以及高级映射。\r\n- MyBatis 避免了几乎所有的 JDBC 代码和手动设置参数以及获取结果集。\r\n- MyBatis 可以使用简单的 XML 或注解来配置和映射原生类型、接口和 Java 的 POJO（Plain Old Java Objects，普通老式 Java 对象）为数据库中的记录。\r\n- MyBatis 本是[apache](https://baike.baidu.com/item/apache/6265)的一个开源项目[iBatis](https://baike.baidu.com/item/iBatis), 2010年这个项目由apache software foundation 迁移到了google code，并且改名为MyBatis 。\r\n- 2013年11月迁移到Github。\r\n\r\n\r\n\r\n如何获得Mybatis？\r\n\r\n- maven仓库：\r\n\r\n  ```xml\r\n  <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->\r\n  <dependency>\r\n      <groupId>org.mybatis</groupId>\r\n      <artifactId>mybatis</artifactId>\r\n      <version>3.5.2</version>\r\n  </dependency>\r\n  ```\r\n\r\n- Github ： https://github.com/mybatis/mybatis-3/releases\r\n\r\n- 中文文档：https://mybatis.org/mybatis-3/zh/index.html\r\n\r\n\r\n\r\n### 1.2、持久化\r\n\r\n数据持久化\r\n\r\n- 持久化就是将程序的数据在持久状态和瞬时状态转化的过程\r\n- 内存：**断电即失**\r\n- 数据库(Jdbc)，io文件持久化。\r\n- 生活：冷藏. 罐头。\r\n\r\n**为什么需要需要持久化？**\r\n\r\n- 有一些对象，不能让他丢掉。\r\n\r\n- 内存太贵了\r\n\r\n\r\n\r\n### 1.3、持久层\r\n\r\nDao层，Service层，Controller层….\r\n\r\n- 完成持久化工作的代码块\r\n- 层界限十分明显。\r\n\r\n\r\n\r\n### 1.4 为什么需要Mybatis？\r\n\r\n- 帮助程序猿将数据存入到数据库中。\r\n- 方便\r\n- 传统的JDBC代码太复杂了。简化。框架。自动化。\r\n- 不用Mybatis也可以。更容易上手。 **技术没有高低之分**\r\n- 优点：\r\n  - 简单易学\r\n  - 灵活\r\n  - sql和代码的分离，提高了可维护性。\r\n  - 提供映射标签，支持对象与数据库的orm字段关系映射\r\n  - 提供对象关系映射标签，支持对象关系组建维护\r\n  - 提供xml标签，支持编写动态sql。\r\n\r\n\r\n\r\n**最重要的一点：使用的人多！**\r\n\r\nSpring   SpringMVC    SpringBoot\r\n\r\n\r\n\r\n## 2、第一个Mybatis程序\r\n\r\n思路：搭建环境-->导入Mybatis-->编写代码-->测试！\r\n\r\n### 2.1、搭建环境\r\n\r\n搭建数据库\r\n\r\n```java\r\nCREATE DATABASE `mybatis`;\r\n\r\nUSE `mybatis`;\r\n\r\nCREATE TABLE `user`(\r\n  `id` INT(20) NOT NULL PRIMARY KEY,\r\n  `name` VARCHAR(30) DEFAULT NULL,\r\n  `pwd` VARCHAR(30) DEFAULT NULL\r\n)ENGINE=INNODB DEFAULT CHARSET=utf8;\r\n\r\nINSERT INTO `user`(`id`,`name`,`pwd`) VALUES \r\n(1,\'王五\',\'123456\'),\r\n(2,\'张三\',\'123456\'),\r\n(3,\'李四\',\'123890\')\r\n```\r\n\r\n新建项目\r\n\r\n1. 新建一个普通的maven项目\r\n\r\n2. 删除src目录\r\n\r\n3. 导入maven依赖\r\n\r\n   ```xml\r\n   \r\n       <!--导入依赖-->\r\n       <dependencies>\r\n           <!--mysql驱动-->\r\n           <dependency>\r\n               <groupId>mysql</groupId>\r\n               <artifactId>mysql-connector-java</artifactId>\r\n               <version>5.1.47</version>\r\n           </dependency>\r\n           <!--mybatis-->\r\n           <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->\r\n           <dependency>\r\n               <groupId>org.mybatis</groupId>\r\n               <artifactId>mybatis</artifactId>\r\n               <version>3.5.2</version>\r\n           </dependency>\r\n           <!--junit-->\r\n           <dependency>\r\n               <groupId>junit</groupId>\r\n               <artifactId>junit</artifactId>\r\n               <version>4.12</version>\r\n           </dependency>\r\n       </dependencies>\r\n   ```\r\n\r\n### 2.2、创建一个模块\r\n\r\n- 编写mybatis的核心配置文件\r\n\r\n  ```xml\r\n  <?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n  <!DOCTYPE configuration\r\n          PUBLIC \"-//mybatis.org//DTD Config 3.0//EN\"\r\n          \"http://mybatis.org/dtd/mybatis-3-config.dtd\">\r\n  <!--configuration核心配置文件-->\r\n  <configuration>\r\n  \r\n      <environments default=\"development\">\r\n          <environment id=\"development\">\r\n              <transactionManager type=\"JDBC\"/>\r\n              <dataSource type=\"POOLED\">\r\n                  <property name=\"driver\" value=\"com.mysql.jdbc.Driver\"/>\r\n                  <property name=\"url\" value=\"jdbc:mysql://localhost:3306/mybatis?useSSL=true&amp;useUnicode=true&amp;characterEncoding=UTF-8\"/>\r\n                  <property name=\"username\" value=\"root\"/>\r\n                  <property name=\"password\" value=\"123456\"/>\r\n              </dataSource>\r\n          </environment>\r\n      </environments>\r\n  \r\n  </configuration>\r\n  ```\r\n\r\n- 编写mybatis工具类\r\n\r\n  ```java\r\n  //sqlSessionFactory --> sqlSession\r\n  public class MybatisUtils {\r\n  \r\n      private static SqlSessionFactory sqlSessionFactory;\r\n  \r\n      static{\r\n          try {\r\n              //使用Mybatis第一步：获取sqlSessionFactory对象\r\n              String resource = \"mybatis-config.xml\";\r\n              InputStream inputStream = Resources.getResourceAsStream(resource);\r\n              sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);\r\n          } catch (IOException e) {\r\n              e.printStackTrace();\r\n          }\r\n  \r\n      }\r\n  \r\n      //既然有了 SqlSessionFactory，顾名思义，我们就可以从中获得 SqlSession 的实例了。\r\n      // SqlSession 完全包含了面向数据库执行 SQL 命令所需的所有方法。\r\n      public static SqlSession  getSqlSession(){\r\n          return sqlSessionFactory.openSession();\r\n      }\r\n  \r\n  }\r\n  \r\n  ```\r\n\r\n### 2.3、编写代码\r\n\r\n- 实体类\r\n\r\n```java\r\n  package com.kuang.pojo;\r\n  \r\n  //实体类\r\n  public class User {\r\n      private int id;\r\n      private String name;\r\n      private String pwd;\r\n  \r\n      public User() {\r\n      }\r\n  \r\n      public User(int id, String name, String pwd) {\r\n          this.id = id;\r\n          this.name = name;\r\n          this.pwd = pwd;\r\n      }\r\n  \r\n      public int getId() {\r\n          return id;\r\n      }\r\n  \r\n      public void setId(int id) {\r\n          this.id = id;\r\n      }\r\n  \r\n      public String getName() {\r\n          return name;\r\n      }\r\n  \r\n      public void setName(String name) {\r\n          this.name = name;\r\n      }\r\n  \r\n      public String getPwd() {\r\n          return pwd;\r\n      }\r\n  \r\n      public void setPwd(String pwd) {\r\n          this.pwd = pwd;\r\n      }\r\n  \r\n      @Override\r\n      public String toString() {\r\n          return \"User{\" +\r\n                  \"id=\" + id +\r\n                  \", name=\'\" + name + \'\\\'\' +\r\n                  \", pwd=\'\" + pwd + \'\\\'\' +\r\n                  \'}\';\r\n      }\r\n  }\r\n  \r\n  ```\r\n\r\n- Dao接口\r\n\r\n  ```java\r\n  public interface UserDao {\r\n      List<User> getUserList();\r\n  }\r\n  ```\r\n\r\n- 接口实现类由原来的UserDaoImpl转变为一个 Mapper配置文件.\r\n\r\n  ```xml\r\n  <?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n          <!DOCTYPE mapper\r\n                  PUBLIC \"-//mybatis.org//DTD Mapper 3.0//EN\"\r\n                  \"http://mybatis.org/dtd/mybatis-3-mapper.dtd\">\r\n          <!--namespace=绑定一个对应的Dao/Mapper接口-->\r\n  <mapper namespace=\"com.kuang.dao.UserDao\">\r\n  \r\n  <!--select查询语句-->\r\n     <select id=\"getUserList\" resultType=\"com.kuang.pojo.User\">\r\n         select * from mybatis.user\r\n     </select>\r\n  \r\n  </mapper>\r\n  ```\r\n\r\n### 2.4、测试\r\n\r\n注意点：\r\n\r\norg.apache.ibatis.binding.BindingException: Type interface com.kuang.dao.UserDao is not known to the MapperRegistry.\r\n\r\n**MapperRegistry是什么？**\r\n\r\n核心配置文件中注册 mappers\r\n\r\n```java\r\n  @Test\r\n  public void test(){\r\n      //第一步：获得SqlSession对象\r\n      SqlSession sqlSession = MybatisUtils.getSqlSession();\r\n  \r\n  \r\n      //方式一：getMapper\r\n      UserDao userDao = sqlSession.getMapper(UserDao.class);\r\n      List<User> userList = userDao.getUserList();\r\n  \r\n      for (User user : userList) {\r\n          System.out.println(user);\r\n      }\r\n  \r\n  \r\n  \r\n      //关闭SqlSession\r\n      sqlSession.close();\r\n  }\r\n  \r\n  ```\r\n\r\n\r\n\r\n可以能会遇到的问题：\r\n\r\n1. 配置文件没有注册\r\n2. 绑定接口错误。\r\n3. 方法名不对\r\n4. 返回类型不对\r\n5. Maven导出资源问题', 'http://mybatis.org/images/mybatis-logo.png', '原创', '第一个Mybatis程序', 2, b'1', b'0', b'1', b'1', b'1', '2022-03-31 21:08:41', '2022-03-31 21:08:41', 18, 1, 1);

-- ----------------------------
-- Table structure for t_blog_tags
-- ----------------------------
DROP TABLE IF EXISTS `t_blog_tags`;
CREATE TABLE `t_blog_tags`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `blog_id` bigint NOT NULL COMMENT '博客id',
  `tags_id` int NOT NULL COMMENT '标签id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `blog_id`(`blog_id`) USING BTREE,
  INDEX `13`(`tags_id`) USING BTREE,
  CONSTRAINT `12` FOREIGN KEY (`blog_id`) REFERENCES `t_blog` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `13` FOREIGN KEY (`tags_id`) REFERENCES `t_tag` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 239 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_blog_tags
-- ----------------------------
INSERT INTO `t_blog_tags` VALUES (111, 12, 1);
INSERT INTO `t_blog_tags` VALUES (112, 12, 4);
INSERT INTO `t_blog_tags` VALUES (113, 12, 8);
INSERT INTO `t_blog_tags` VALUES (204, 18, 4);
INSERT INTO `t_blog_tags` VALUES (225, 22, 5);
INSERT INTO `t_blog_tags` VALUES (226, 22, 11);
INSERT INTO `t_blog_tags` VALUES (227, 24, 8);
INSERT INTO `t_blog_tags` VALUES (228, 24, 12);
INSERT INTO `t_blog_tags` VALUES (229, 24, 13);
INSERT INTO `t_blog_tags` VALUES (236, 23, 5);
INSERT INTO `t_blog_tags` VALUES (237, 23, 8);
INSERT INTO `t_blog_tags` VALUES (238, 23, 12);

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `create_time` datetime NULL DEFAULT NULL COMMENT '发表日期',
  `blog_id` bigint NULL DEFAULT NULL COMMENT '关联博客id',
  `parent_comment_id` bigint NULL DEFAULT NULL COMMENT '父评论',
  `admin_comment` bit(1) NULL DEFAULT NULL COMMENT '是否为管理员',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `3`(`blog_id`) USING BTREE,
  CONSTRAINT `3` FOREIGN KEY (`blog_id`) REFERENCES `t_blog` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (54, '小黑黑', '123@qq.com', '来一个新评论', '/images/1.jpeg', '2020-05-15 18:38:57', 12, NULL, b'0');
INSERT INTO `t_comment` VALUES (55, '123', '123@qq.com', '报道！', '/images/1.jpeg', '2020-05-15 18:40:17', 12, NULL, b'0');
INSERT INTO `t_comment` VALUES (57, '123', 'qq915873525@163.com', '新来的！', '/images/1.jpeg', '2020-05-15 18:45:19', 12, NULL, b'0');
INSERT INTO `t_comment` VALUES (62, '测试', '123@qq.com', '测试滑动', '/images/1.jpeg', '2020-05-15 18:55:34', 12, NULL, b'0');
INSERT INTO `t_comment` VALUES (92, 'Zom', '123@qq.com', 'Hello', 'http://q1.qlogo.cn/g?b=qq&nk=123&s=100', '2020-05-29 07:24:34', 12, 52, b'0');

-- ----------------------------
-- Table structure for t_link
-- ----------------------------
DROP TABLE IF EXISTS `t_link`;
CREATE TABLE `t_link`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '友链名称',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '友链地址',
  `canshow` bit(1) NULL DEFAULT NULL COMMENT '是否显示前台',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_link
-- ----------------------------
INSERT INTO `t_link` VALUES (6, 'whitebear’s blog', 'www.whitebear.top', b'1');

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES (1, '算法');
INSERT INTO `t_tag` VALUES (2, '技术');
INSERT INTO `t_tag` VALUES (3, '认知');
INSERT INTO `t_tag` VALUES (4, '经验');
INSERT INTO `t_tag` VALUES (5, 'Java');
INSERT INTO `t_tag` VALUES (8, '编程');
INSERT INTO `t_tag` VALUES (9, '感悟');
INSERT INTO `t_tag` VALUES (11, 'springboot');
INSERT INTO `t_tag` VALUES (12, 'SSM');
INSERT INTO `t_tag` VALUES (13, 'Mybatis');

-- ----------------------------
-- Table structure for t_type
-- ----------------------------
DROP TABLE IF EXISTS `t_type`;
CREATE TABLE `t_type`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_type
-- ----------------------------
INSERT INTO `t_type` VALUES (3, '编程开发');
INSERT INTO `t_type` VALUES (9, 'Java开发');
INSERT INTO `t_type` VALUES (14, '编程语言');
INSERT INTO `t_type` VALUES (15, 'Web开发');
INSERT INTO `t_type` VALUES (16, 'springboot');
INSERT INTO `t_type` VALUES (18, 'SSM');
INSERT INTO `t_type` VALUES (26, '算法');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int NOT NULL COMMENT 'id',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `type` int NULL DEFAULT NULL COMMENT '用户类型',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'Jackson', 'jackson', '202cb962ac59075b964b07152d234b70', '792741356@qq.com', 'http://mms0.baidu.com/it/u=3264485442,2573860381&fm=253&app=120&f=JPEG&fmt=auto&q=75?w=500&h=500', NULL, '2020-05-04 18:02:39', '2020-05-04 18:02:42');

SET FOREIGN_KEY_CHECKS = 1;
