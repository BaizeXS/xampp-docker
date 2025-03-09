-- -------------------------------------------------------
-- Laravel Bookstore 项目数据库初始化脚本
-- -------------------------------------------------------
-- 创建日期: 2025年
-- 适用于: Laravel Bookstore 项目
-- 编码: utf16_unicode_ci
-- 引擎: InnoDB
-- -------------------------------------------------------

-- 删除旧数据库（如果存在）
DROP DATABASE IF EXISTS `bookstore`;

-- 创建新的书店数据库（使用utf16_unicode_ci编码）
CREATE DATABASE IF NOT EXISTS `bookstore` CHARACTER SET utf16 COLLATE utf16_unicode_ci;

-- 使用书店数据库
USE `bookstore`;

-- 设置SQL模式
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- -------------------------------------------------------
-- 表结构: `categories` (图书分类)
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS `categories` (
  `category_id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE utf16_unicode_ci AUTO_INCREMENT=6;

-- 表数据: `categories`
INSERT INTO `categories` (`category_id`, `name`) VALUES
(3, 'HTML & Web design'),
(5, 'Programming');

-- -------------------------------------------------------
-- 表结构: `contact` (联系信息)
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS `contact` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `store_name` varchar(45) NOT NULL,
  `store_address` varchar(150) NOT NULL,
  `tel_no` varchar(8) NOT NULL,
  `fax_no` varchar(8) NOT NULL,
  `email` varchar(45) NOT NULL,
  `store_loc_x` double NOT NULL,
  `store_loc_y` double NOT NULL,
  `mtr_loc_x` double NOT NULL,
  `mtr_loc_y` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE utf16_unicode_ci AUTO_INCREMENT=4;

-- 表数据: `contact`
INSERT INTO `contact` (`id`, `store_name`, `store_address`, `tel_no`, `fax_no`, `email`, `store_loc_x`, `store_loc_y`, `mtr_loc_x`, `mtr_loc_y`) VALUES
(1, 'ZF Bookstore MK', 'Shop 05, 4/F, Langham Place Shopping Mall, 8 Argyle Street Mong Kok', '23232323', '24242424', 'mk@zf-bookstore.com', 22.317733, 114.168816, 22.318319, 114.169363),
(2, 'ZF Bookstore TST', 'Shop G, 2/F, Star Computer City, Star House, TST, Hong Kong', '25252525', '26262626', 'tst@zf-bookstore.com', 22.294685, 114.169449, 22.295628, 114.172164),
(3, 'ZF Bookstore CB', 'Shop 1009, 10/F, Windsor House, 331 Gloucester Road, Causeway Bay, Hong Kong', '27272727', '28282828', 'cb@zf-bookstore.com', 22.280648, 114.186401, 22.28028, 114.185022);

-- -------------------------------------------------------
-- 表结构: `googlekeys` (Google API密钥)
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS `googlekeys` (
  `key_id` int(11) NOT NULL auto_increment,
  `key_value` varchar(255) NOT NULL,
  `key_status` varchar(1) NOT NULL,
  PRIMARY KEY (`key_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE utf16_unicode_ci AUTO_INCREMENT=8;

-- 表数据: `googlekeys`
INSERT INTO `googlekeys` (`key_id`, `key_value`, `key_status`) VALUES
(1, 'ABQIAAAAQgfz6A9ItGmXyuAmLIIr5hSbiI8Q8SJp_rjpYZBvjY-HFYAkVhQU3kQtFy_kYXvWVIxKR9ZYfBfHkw', 'A');

-- -------------------------------------------------------
-- 表结构: `books` (图书信息)
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS `books` (
  `id` int(11) NOT NULL auto_increment,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `author` varchar(100) default NULL,
  `publisher` varchar(100) default NULL,
  `isbn` varchar(13) default NULL,
  `price` float NOT NULL,
  `language` varchar(50) default NULL,
  `pages` int(11) default '0',
  `edition` varchar(30) default NULL,
  `binding` varchar(30) default NULL,
  `description` text,
  `product_url` varchar(255) default NULL,
  `image_url` varchar(100) default NULL,
  `notes` text,
  `is_recommended` tinyint(4) default '0',
  `rating` int(11) default '0',
  `rating_count` int(11) default '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE utf16_unicode_ci AUTO_INCREMENT=8;

-- 表数据: `books`
INSERT INTO `books` (`id`, `category_id`, `name`, `author`, `publisher`, `isbn`, `price`, `language`, `pages`, `edition`, `binding`, `description`, `product_url`, `image_url`, `notes`, `is_recommended`, `rating`, `rating_count`) VALUES
(1, 5, 'Core Java, Vol. 2: Advanced Features (8/e)', 'Cay S. Horstmann, Gary Cornell', 'Prentice Hall Press, Inc.', '9780132354790', 150, 'English', 1056, 'Eighth Edition', 'Paperback', 'The revised edition of the idic Core Java, Volume II Advanced Features, covers advanced user-interface programming and the enterprise features of the Java SE 6 platform. Like Volume I (which covers the core language and library features), this volume has been updated for Java SE 6 and new coverage is highlighted throughout. All sample programs have been carefully crafted to illustrate the latest programming techniques, displaying best-practices solutions to the types of real-world problems professional developers encounter. Volume II includes new sections on the StAX API, JDBC 4, compiler API, scripting framework, splash screen and tray APIs, and many other Java SE 6 enhancements. In this book, the authors focus on the more advanced features of the Java language, including complete coverage of Streams and Files Networking Database programming XML JNDI and LDAP Internationalization Advanced GUI components Java 2D and advanced AWT JavaBeans Security RMI and Web services Collections Annotations Native methods For thorough coverage of Java fundamentals?including interfaces and inner classes, GUI programming with Swing, exception handling, generics, collections, and concurrency look for the eighth edition of Core Java, Volume I Fundamentals (ISBN: 978-0-13-235476-9).', 'http://www.amazon.com/Core-Java-Vol-Advanced-Features/dp/0132354799', 'images/books/9780132354790-01.png', 'The revised edition of the idic Core Java, Volume II Advanced Features, covers advanced user-interface programming and the enterprise features of the Java SE 6 platform. Like Volume I (which covers the core language and library features), this volume has been updated for Java SE 6 and new coverage is highlighted throughout. All sample programs have been carefully crafted to illustrate the latest programming techniques, displaying best-practices solutions to the types of real-world problems professional developers encounter. Volume II includes new sections on the StAX API, JDBC 4, compiler API, scripting framework, splash screen and tray APIs, and many other Java SE 6 enhancements. In this book, the authors focus on the more advanced features of the Java language, including complete coverage of Streams and Files Networking Database programming XML JNDI and LDAP Internationalization Advanced GUI components Java 2D and advanced AWT JavaBeans Security RMI and Web services Collections Annotations Native methods For thorough coverage of Java fundamentals?including interfaces and inner classes, GUI programming with Swing, exception handling, generics, collections, and concurrency look for the eighth edition of Core Java, Volume I Fundamentals (ISBN: 978-0-13-235476-9).', 1, 16, 7),
(2, 3, 'Web Site Engineering: Beyond Web Page Design', 'Thomas A. Powell (Author), David L. Jones (Author), Dominique C. Cutts (Author)', 'Prentice Hall Press, Inc.', '9780136509202', 240, 'English', 324, 'First Edition', 'Paperback', 'Systematically addresses the management, technical & operational issues that arise when Web sites become sophisticated application deployment platforms, providing insights into the urgent issues that will make or break today\\''s large, sophisticated sites. Paper.', 'http://www.amazon.com/Web-Site-Engineering-Beyond-Design/dp/0136509207', 'images/books/9780136509202-01.png', 'Systematically addresses the management, technical & operational issues that arise when Web sites become sophisticated application deployment platforms, providing insights into the urgent issues that will make or break today\\''s large, sophisticated sites. Paper.', 0, 0, 0),
(3, 3, 'Learning jQuery 1.3', 'Jonathan Chaffer (Author), Karl Swedberg (Author), John Resig (Foreword) ', 'Packt Publishing (February 13, 2009)', '9781847196705', 320, 'English', 444, NULL, 'Paperback', 'Product Description\r\nBetter Interaction Design and Web Development with Simple JavaScript Techniques\r\n\r\nAn introduction to jQuery that requires minimal programming experience\r\nDetailed solutions to specific client-side problems\r\nFor web designers to create interactive elements for their designs\r\nFor developers to create the best user interface for their web applications\r\nPacked with great examples, code, and clear explanations\r\nRevised and updated version of the first book to help you learn jQuery', 'http://www.amazon.com/Learning-jQuery-1-3-Jonathan-Chaffer/dp/1847196705/ref=sr_1_1?ie=UTF8&s=books&qid=1263765649&sr=1-1', 'images/books/9781847196705-01.png', 'Product Description\r\nBetter Interaction Design and Web Development with Simple JavaScript Techniques\r\n\r\nAn introduction to jQuery that requires minimal programming experience\r\nDetailed solutions to specific client-side problems\r\nFor web designers to create interactive elements for their designs\r\nFor developers to create the best user interface for their web applications\r\nPacked with great examples, code, and clear explanations\r\nRevised and updated version of the first book to help you learn jQuery', 0, 0, 0),
(4, 3, 'jQuery Reference Guide: A Comprehensive Exploration of the Popular JavaScript Library ', 'Jonathan Chaffer (Author), Karl Swedberg (Author) ', 'Packt Publishing (July 30, 2007)', '9781847193810', 320, NULL, 0, 'First Edition', 'Paperback', 'Product Description\r\nA Comprehensive Exploration of the Popular JavaScript Library\r\n\r\nOrganized menu to every method, function, and selector in the jQuery library\r\nQuickly look up features of the jQuery library\r\nUnderstand the anatomy of a jQuery script\r\nExtend jQuery''s built-in capabilities with plug-ins, and even write your own', 'http://www.amazon.com/jQuery-Reference-Guide-Comprehensive-Exploration/dp/1847193811/ref=pd_sim_b_5', 'images/books/9781847193810-01.png', 'Product Description\r\nA Comprehensive Exploration of the Popular JavaScript Library\r\n\r\nOrganized menu to every method, function, and selector in the jQuery library\r\nQuickly look up features of the jQuery library\r\nUnderstand the anatomy of a jQuery script\r\nExtend jQuery''s built-in capabilities with plug-ins, and even write your own', 0, 0, 0),
(5, 3, 'jQuery Cookbook (Animal Guide)', 'Luke Welling, Laura Thomson', ' O''Reilly Media', '9780596159771', 330, NULL, 476, NULL, NULL, 'Product Description\r\njQuery simplifies building rich, interactive web frontends. Getting started with this JavaScript library is easy, but it can take years to fully realize its breadth and depth; this cookbook shortens the learning curve considerably. With these recipes, you''ll learn patterns and practices from 19 leading developers who use jQuery for everything from integrating simple components into websites and applications to developing complex, high-performance user interfaces. \r\n\r\nIdeal for newcomers and JavaScript veterans alike, jQuery Cookbook starts with the basics and then moves to practical use cases with tested solutions to common web development hurdles. You also get recipes on advanced topics, such as methods for applying jQuery to large projects.\r\nSolve problems involving events, effects, dimensions, forms, themes, and user interface elements\r\nLearn how to enhance your forms, and how to position and reposition elements on a page\r\nMake the most of jQuery''s event management system, including custom events and custom event data\r\nCreate UI elements-such as tabs, accordions, and modals-from scratch\r\nOptimize your code to eliminate bottlenecks and ensure peak performance\r\nLearn how to test your jQuery applications\r\nThe book''s contributors include:\r\n\r\nCody Lindley\r\nJames Padolsey\r\nRalph Whitbeck\r\nJonathan Sharp\r\nMichael Geary and Scott González\r\nRebecca Murphey\r\nRemy Sharp\r\nAriel Flesler\r\nBrian Cherne\r\nJörn Zaefferer\r\nMike Hostetler\r\nNathan Smith', 'http://www.amazon.com/jQuery-Cookbook-Animal-Guide-Lindley/dp/0596159773/ref=pd_sim_b_5', 'images/books/9780596159771-01.png', 'Product Description\r\njQuery simplifies building rich, interactive web frontends. Getting started with this JavaScript library is easy, but it can take years to fully realize its breadth and depth; this cookbook shortens the learning curve considerably. With these recipes, you''ll learn patterns and practices from 19 leading developers who use jQuery for everything from integrating simple components into websites and applications to developing complex, high-performance user interfaces. \r\n\r\nIdeal for newcomers and JavaScript veterans alike, jQuery Cookbook starts with the basics and then moves to practical use cases with tested solutions to common web development hurdles. You also get recipes on advanced topics, such as methods for applying jQuery to large projects.\r\nSolve problems involving events, effects, dimensions, forms, themes, and user interface elements\r\nLearn how to enhance your forms, and how to position and reposition elements on a page\r\nMake the most of jQuery''s event management system, including custom events and custom event data\r\nCreate UI elements-such as tabs, accordions, and modals-from scratch\r\nOptimize your code to eliminate bottlenecks and ensure peak performance\r\nLearn how to test your jQuery applications\r\nThe book''s contributors include:\r\n\r\nCody Lindley\r\nJames Padolsey\r\nRalph Whitbeck\r\nJonathan Sharp\r\nMichael Geary and Scott González\r\nRebecca Murphey\r\nRemy Sharp\r\nAriel Flesler\r\nBrian Cherne\r\nJörn Zaefferer\r\nMike Hostetler\r\nNathan Smith', 0, 0, 0);

-- -------------------------------------------------------
-- 表结构: `members` (会员信息)
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS `members` (
  `member_id` int(11) NOT NULL auto_increment,
  `member_login` varchar(20) NOT NULL,
  `member_password` varchar(20) NOT NULL,
  `member_level` int(11) NOT NULL default '1',
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(50) default NULL,
  `birthday` date default NULL,
  `address` varchar(50) default NULL,
  `notes` text,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE utf16_unicode_ci AUTO_INCREMENT=22;

-- 表数据: `members`
INSERT INTO `members` (`member_id`, `member_login`, `member_password`, `member_level`, `first_name`, `last_name`, `email`, `phone`, `birthday`, `address`, `notes`) VALUES
(1, 'admin', 'admin', 2, 'Administrator', 'Account', 'admin@localhost', NULL, '1980-10-10', NULL, NULL),
(2, 'guest', 'guest', 1, 'Guest', 'Account', 'guest@localhost', NULL, '1980-10-21', NULL, NULL),
(6, 'steven', 'steven', 1, 'steven', 'steven', 'cibsteven@gmail.com', 'steven', '1977-10-21', 'steven', NULL),
(21, 'aaa', 'aaa', 1, 'aaa', 'aaa', 'aaa@gmail.com', 'aaa', '2001-10-10', 'aaa', NULL);

-- -------------------------------------------------------
-- 表结构: `stores` (书店信息)
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS `stores` (
  `store_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(200) NOT NULL,
  `address` varchar(200) NOT NULL,
  `tel` varchar(45) NOT NULL,
  `fax` varchar(45) NOT NULL,
  `email` varchar(100) NOT NULL,
  `MTRstation` varchar(100) NOT NULL,
  `MTR_Lat` double NOT NULL,
  `MTR_Lon` double NOT NULL,
  `Lat` double NOT NULL,
  `Lon` double NOT NULL,
  `ImagePath` varchar(100) NOT NULL,
  PRIMARY KEY (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE utf16_unicode_ci AUTO_INCREMENT=4;

-- 表数据: `stores`
INSERT INTO `stores` (`store_id`, `name`, `address`, `tel`, `fax`, `email`, `MTRstation`, `MTR_Lat`, `MTR_Lon`, `Lat`, `Lon`, `ImagePath`) VALUES
(1, 'ZF Bookstore TST', 'Shop G, 2/F, Star Computer City, Star House, TST, Hong Kong', '25252525', '26262626', 'tst@zf-bookstore.com', 'Tsim Sha Tsui MTR Exit F', 22.295628, 114.172164, 22.294685, 114.169449, 'images/contact/bookazine.jpg'),
(2, 'ZF Bookstore CB', 'Shop 1009, 10/F, Windsor House, 331 Gloucester Road, Causeway Bay', '27272727', '28282828', 'cb@zf-bookstore.com', 'Causeway Bay MTR Exit E ', 22.28028, 114.185022, 22.280648, 114.186401, 'images/contact/commercial.jpg'),
(3, 'ZF Bookstore MK', 'Shop 05, 4/F, Langham Place Shopping Mall, 8 Argyle Street Mong Kok', '23232323', '24242424', 'mk@zf-bookstore.com', 'Mong Kok MTR Exit E1', 22.318319, 114.169363, 22.317733, 114.168816, 'images/contact/dymocks.jpg');

-- -------------------------------------------------------
-- Laravel 数据库（供Laravel项目使用）
-- -------------------------------------------------------
CREATE DATABASE IF NOT EXISTS `laravel` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 