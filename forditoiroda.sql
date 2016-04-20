-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 20, 2016 at 11:59 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `forditoiroda`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `forditok`()
    NO SQL
SELECT fordito.fordito_id, fordito.nev, nyelv.megnevezes AS nyelv, fordito.forditasi_dij, fordito.napi_oldalszam, fordito.telefon, fordito.email FROM `fordito` AS fordito
LEFT JOIN `nyelv` AS nyelv ON fordito.nyelv_id = nyelv.nyelv_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `forditokSzuken`(IN `nyelv_id` INT, IN `oldal_min` INT, IN `oldal_max` INT)
    NO SQL
SELECT fordito.fordito_id, fordito.nev, nyelv.megnevezes AS nyelv, fordito.forditasi_dij, fordito.napi_oldalszam, fordito.telefon, fordito.email FROM `fordito` AS fordito
LEFT JOIN `nyelv` AS nyelv ON fordito.nyelv_id = nyelv.nyelv_id
WHERE nyelv.nyelv_id = nyelv_id AND fordito.napi_oldalszam >= oldal_min AND fordito.napi_oldalszam <= oldal_max$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `megrendelesek`()
    NO SQL
SELECT rendeles.megrendeles_id AS megrendeles_id, rendeles.datum AS rendeles_datum, megrendelo.nev AS megrendelo_nev, nyelv.megnevezes AS forditas_nyelve, fordito.nev AS fordito_nev, rendeles.oldalszam AS oldalszam, fordito.forditasi_dij AS forditas_dij,(rendeles.oldalszam * fordito.forditasi_dij) AS iranyar FROM `megrendeles` AS rendeles
LEFT JOIN `fordito` AS fordito ON rendeles.fordito_id = fordito.fordito_id
LEFT JOIN `megrendelo` AS megrendelo ON rendeles.megrendelo_id = megrendelo.megrendelo_id
LEFT JOIN `nyelv` AS nyelv ON fordito.nyelv_id = nyelv.nyelv_id
ORDER BY forditas_nyelve, fordito_nev ASC, oldalszam DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `megrendelesekSzuken`(IN `itemek` INT, IN `oldal` INT)
    NO SQL
SELECT rendeles.megrendeles_id AS megrendeles_id, rendeles.datum AS rendeles_datum, megrendelo.nev AS megrendelo_nev, nyelv.megnevezes AS forditas_nyelve, fordito.nev AS fordito_nev, rendeles.oldalszam AS oldalszam, fordito.forditasi_dij AS forditas_dij,(rendeles.oldalszam * fordito.forditasi_dij) AS iranyar FROM `megrendeles` AS rendeles
LEFT JOIN `fordito` AS fordito ON rendeles.fordito_id = fordito.fordito_id
LEFT JOIN `megrendelo` AS megrendelo ON rendeles.megrendelo_id = megrendelo.megrendelo_id
LEFT JOIN `nyelv` AS nyelv ON fordito.nyelv_id = nyelv.nyelv_id
ORDER BY forditas_nyelve, fordito_nev ASC, oldalszam DESC
LIMIT itemek OFFSET oldal$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `fordito`
--

CREATE TABLE IF NOT EXISTS `fordito` (
  `fordito_id` int(11) NOT NULL AUTO_INCREMENT,
  `nev` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `nyelv_id` int(11) DEFAULT NULL,
  `forditasi_dij` int(11) DEFAULT NULL,
  `napi_oldalszam` int(11) DEFAULT NULL,
  `telefon` varchar(14) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`fordito_id`),
  KEY `nyelv_id` (`nyelv_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci AUTO_INCREMENT=31 ;

--
-- Dumping data for table `fordito`
--

INSERT INTO `fordito` (`fordito_id`, `nev`, `nyelv_id`, `forditasi_dij`, `napi_oldalszam`, `telefon`, `email`) VALUES
(1, 'Jászai Dávid', 10, 3000, 20, '(70) 177-24-55', 'jaszaid@freemail.hu'),
(2, 'Ambrus Dénes', 2, 3000, 26, '(30) 242-52-60', 'ambrus.denes12@forditoiroda.hu'),
(3, 'Kaleczky Tamás', 2, 3000, 20, '(20) 610-72-51', 'kaleczkyt@freemail.hu'),
(4, 'Eszes Nikolett', 9, 2000, 20, '(70) 713-32-79', 'eszes.nikolett@forditoiroda.hu'),
(5, 'Cseszneki Lívia', 3, 2500, 26, '(30) 524-30-90', 'cseszneki.livia44@forditoiroda.hu'),
(6, 'Kányádi Rita', 2, 2000, 10, '(20) 310-16-59', 'kanyadir@freemail.hu'),
(7, 'Madarász Pál', 1, 3000, 10, '(70) 674-52-38', 'madaraszp@forditoiroda.hu'),
(8, 'Jászai Gergely', 1, 2500, 24, '(20) 321-28-44', 'jaszaig@gmail.com'),
(9, 'Fekete István', 2, 2500, 12, '(20) 881-96-47', 'feketei@gmail.com'),
(10, 'Eszes Zita', 7, 2500, 22, '(70) 363-74-50', 'eszesz@gmail.com'),
(11, 'Fási Ákos', 5, 3000, 28, '(20) 952-52-44', 'fasia55@freemail.hu'),
(12, 'Kaleczky Pál', 7, 3000, 24, '(70) 184-30-85', 'kaleczky.pal@freemail.hu'),
(13, 'Braun János', 10, 3000, 12, '(30) 212-85-31', 'braunj@gmail.com'),
(14, 'Gőgösi Katalin', 9, 3000, 14, '(20) 725-41-63', 'gogosik56@freemail.hu'),
(15, 'Békési István', 1, 3000, 28, '(20) 341-73-81', 'bekesi.istvan29@gmail.com'),
(16, 'Eszes Miklós', 8, 2000, 14, '(30) 652-47-75', 'eszes.miklos@freemail.hu'),
(17, 'Nagy Zsuzsanna', 7, 2500, 24, '(20) 674-87-88', 'nagy.zsuzsanna@gmail.com'),
(18, 'Kelemen Eleonóra', 8, 2500, 10, '(20) 950-28-49', 'kelemene@gmail.com'),
(19, 'Darázs Dávid', 6, 2000, 22, '(20) 587-53-60', 'darazs.david@freemail.hu'),
(20, 'Kaleczky Eleonóra', 10, 2500, 22, '(20) 800-71-46', 'kaleczky.eleonora@gmail.com'),
(21, 'Tolnai Gergely', 3, 2000, 24, '(20) 337-90-52', 'tolnai.gergely32@gmail.com'),
(22, 'Fazekas Lívia', 2, 2500, 18, '(70) 855-96-82', 'fazekas.livia57@freemail.hu'),
(23, 'Bethlen Fanny', 2, 2000, 24, '(30) 513-10-95', 'bethlen.fanny@freemail.hu'),
(24, 'Hegyi Ádám', 4, 2500, 18, '(20) 589-68-68', 'hegyia@freemail.hu'),
(25, 'Kányádi Ferenc', 9, 2000, 18, '(20) 216-14-69', 'kanyadif37@freemail.hu'),
(26, 'Turai Gabriella', 6, 2000, 14, '(20) 384-10-96', 'turaig18@forditoiroda.hu'),
(27, 'Halmosi Györgyi', 9, 2500, 14, '(70) 722-59-85', 'halmosig@freemail.hu'),
(28, 'Illovszki Zita', 9, 2500, 28, '(30) 857-32-80', 'illovszki.zita@freemail.hu'),
(29, 'Fekete György', 2, 3000, 28, '(20) 722-11-63', 'fekete.gyorgy18@freemail.hu'),
(30, 'Hun Sámuel', 9, 2000, 20, '(20) 905-29-40', 'hun.samuel@forditoiroda.hu');

-- --------------------------------------------------------

--
-- Table structure for table `megrendeles`
--

CREATE TABLE IF NOT EXISTS `megrendeles` (
  `megrendeles_id` int(11) NOT NULL AUTO_INCREMENT,
  `fordito_id` int(11) DEFAULT NULL,
  `megrendelo_id` int(11) DEFAULT NULL,
  `datum` date DEFAULT NULL,
  `oldalszam` int(11) DEFAULT NULL,
  PRIMARY KEY (`megrendeles_id`),
  KEY `fordito_id` (`fordito_id`),
  KEY `megrendelo_id` (`megrendelo_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci AUTO_INCREMENT=361 ;

--
-- Dumping data for table `megrendeles`
--

INSERT INTO `megrendeles` (`megrendeles_id`, `fordito_id`, `megrendelo_id`, `datum`, `oldalszam`) VALUES
(1, 4, 23, '2015-01-01', 14),
(2, 6, 60, '2015-01-01', 15),
(3, 21, 58, '2015-01-01', 14),
(4, 22, 78, '2015-01-02', 4),
(5, 9, 44, '2015-01-02', 5),
(6, 11, 36, '2015-01-03', 2),
(7, 16, 64, '2015-01-04', 4),
(8, 27, 96, '2015-01-04', 1),
(9, 12, 16, '2015-01-04', 2),
(10, 11, 87, '2015-01-04', 5),
(11, 15, 33, '2015-01-05', 22),
(12, 12, 9, '2015-01-05', 36),
(13, 27, 95, '2015-01-05', 1),
(14, 15, 36, '2015-01-05', 5),
(15, 5, 73, '2015-01-06', 2),
(16, 4, 90, '2015-01-06', 1),
(17, 25, 50, '2015-01-06', 3),
(18, 7, 50, '2015-01-07', 15),
(19, 4, 31, '2015-01-07', 4),
(20, 11, 83, '2015-01-07', 5),
(21, 18, 47, '2015-01-08', 37),
(22, 27, 17, '2015-01-09', 4),
(23, 4, 24, '2015-01-09', 5),
(24, 11, 6, '2015-01-11', 5),
(25, 20, 25, '2015-01-11', 32),
(26, 18, 60, '2015-01-11', 3),
(27, 7, 21, '2015-01-11', 2),
(28, 13, 36, '2015-01-12', 4),
(29, 14, 10, '2015-01-13', 3),
(30, 11, 68, '2015-01-13', 37),
(31, 26, 68, '2015-01-13', 12),
(32, 9, 90, '2015-01-14', 1),
(33, 21, 5, '2015-01-14', 34),
(34, 16, 89, '2015-01-14', 5),
(35, 14, 10, '2015-01-14', 3),
(36, 3, 45, '2015-01-15', 36),
(37, 28, 62, '2015-01-15', 1),
(38, 21, 22, '2015-01-15', 1),
(39, 14, 2, '2015-01-15', 1),
(40, 19, 72, '2015-01-15', 3),
(41, 28, 59, '2015-01-15', 4),
(42, 15, 78, '2015-01-15', 19),
(43, 24, 59, '2015-01-15', 1),
(44, 8, 69, '2015-01-15', 36),
(45, 4, 99, '2015-01-15', 3),
(46, 15, 79, '2015-01-16', 36),
(47, 12, 56, '2015-01-16', 3),
(48, 17, 71, '2015-01-16', 3),
(49, 2, 54, '2015-01-16', 38),
(50, 3, 18, '2015-01-16', 14),
(51, 5, 3, '2015-01-16', 4),
(52, 6, 38, '2015-01-17', 5),
(53, 10, 83, '2015-01-17', 1),
(54, 9, 74, '2015-01-17', 5),
(55, 6, 36, '2015-01-17', 4),
(56, 29, 30, '2015-01-17', 20),
(57, 2, 71, '2015-01-18', 1),
(58, 18, 70, '2015-01-18', 23),
(59, 9, 40, '2015-01-18', 3),
(60, 24, 27, '2015-01-19', 3),
(61, 13, 35, '2015-01-20', 2),
(62, 11, 2, '2015-01-20', 4),
(63, 23, 66, '2015-01-21', 18),
(64, 23, 95, '2015-01-21', 13),
(65, 26, 22, '2015-01-21', 33),
(66, 15, 2, '2015-01-21', 1),
(67, 15, 93, '2015-01-22', 31),
(68, 12, 22, '2015-01-22', 1),
(69, 17, 41, '2015-01-22', 3),
(70, 12, 64, '2015-01-22', 1),
(71, 15, 45, '2015-01-22', 4),
(72, 27, 87, '2015-01-22', 23),
(73, 12, 18, '2015-01-23', 1),
(74, 17, 86, '2015-01-23', 2),
(75, 22, 71, '2015-01-23', 1),
(76, 12, 24, '2015-01-24', 31),
(77, 4, 49, '2015-01-24', 2),
(78, 29, 2, '2015-01-24', 29),
(79, 30, 37, '2015-01-25', 3),
(80, 22, 40, '2015-01-25', 2),
(81, 15, 42, '2015-01-25', 5),
(82, 25, 85, '2015-01-25', 3),
(83, 20, 18, '2015-01-25', 2),
(84, 8, 62, '2015-01-25', 38),
(85, 22, 41, '2015-01-26', 5),
(86, 18, 35, '2015-01-26', 5),
(87, 8, 55, '2015-01-26', 5),
(88, 25, 53, '2015-01-26', 5),
(89, 21, 88, '2015-01-27', 1),
(90, 3, 38, '2015-01-27', 4),
(91, 8, 80, '2015-01-27', 19),
(92, 24, 58, '2015-01-28', 37),
(93, 17, 16, '2015-01-28', 4),
(94, 26, 24, '2015-01-28', 31),
(95, 4, 2, '2015-02-01', 4),
(96, 21, 59, '2015-02-01', 3),
(97, 15, 63, '2015-02-02', 2),
(98, 22, 10, '2015-02-02', 39),
(99, 23, 39, '2015-02-02', 2),
(100, 22, 89, '2015-02-03', 2),
(101, 30, 16, '2015-02-03', 1),
(102, 14, 22, '2015-02-03', 11),
(103, 22, 31, '2015-02-03', 4),
(104, 7, 96, '2015-02-04', 3),
(105, 22, 57, '2015-02-04', 26),
(106, 8, 74, '2015-02-05', 25),
(107, 18, 95, '2015-02-05', 21),
(108, 23, 66, '2015-02-05', 2),
(109, 28, 82, '2015-02-05', 4),
(110, 2, 51, '2015-02-06', 3),
(111, 12, 41, '2015-02-06', 1),
(112, 1, 35, '2015-02-06', 2),
(113, 18, 14, '2015-02-06', 1),
(114, 5, 61, '2015-02-06', 2),
(115, 14, 46, '2015-02-06', 26),
(116, 14, 11, '2015-02-06', 5),
(117, 3, 86, '2015-02-07', 2),
(118, 29, 77, '2015-02-07', 3),
(119, 28, 15, '2015-02-07', 1),
(120, 24, 84, '2015-02-07', 4),
(121, 22, 34, '2015-02-08', 5),
(122, 11, 64, '2015-02-08', 2),
(123, 27, 37, '2015-02-08', 3),
(124, 16, 68, '2015-02-08', 1),
(125, 11, 46, '2015-02-08', 3),
(126, 17, 73, '2015-02-09', 3),
(127, 27, 20, '2015-02-09', 3),
(128, 30, 16, '2015-02-09', 4),
(129, 5, 10, '2015-02-09', 4),
(130, 29, 48, '2015-02-10', 18),
(131, 16, 93, '2015-02-10', 2),
(132, 22, 51, '2015-02-10', 2),
(133, 12, 51, '2015-02-11', 38),
(134, 6, 60, '2015-02-11', 11),
(135, 28, 85, '2015-02-11', 2),
(136, 16, 88, '2015-02-12', 3),
(137, 11, 88, '2015-02-12', 4),
(138, 3, 5, '2015-02-12', 26),
(139, 29, 50, '2015-02-12', 37),
(140, 5, 92, '2015-02-12', 2),
(141, 3, 34, '2015-02-12', 2),
(142, 23, 66, '2015-02-12', 26),
(143, 30, 54, '2015-02-12', 4),
(144, 7, 83, '2015-02-12', 4),
(145, 5, 23, '2015-02-13', 37),
(146, 28, 78, '2015-02-13', 33),
(147, 28, 40, '2015-02-14', 27),
(148, 3, 67, '2015-02-14', 5),
(149, 4, 89, '2015-02-14', 5),
(150, 9, 29, '2015-02-16', 2),
(151, 11, 74, '2015-02-17', 11),
(152, 7, 20, '2015-02-18', 3),
(153, 16, 24, '2015-02-18', 38),
(154, 10, 1, '2015-02-18', 22),
(155, 28, 57, '2015-02-19', 26),
(156, 7, 54, '2015-02-19', 4),
(157, 4, 11, '2015-02-20', 5),
(158, 14, 71, '2015-02-20', 20),
(159, 9, 1, '2015-02-20', 4),
(160, 14, 6, '2015-02-21', 5),
(161, 26, 68, '2015-02-22', 4),
(162, 9, 33, '2015-02-22', 1),
(163, 4, 78, '2015-02-23', 4),
(164, 20, 27, '2015-02-23', 1),
(165, 25, 11, '2015-02-23', 4),
(166, 25, 30, '2015-02-24', 1),
(167, 5, 80, '2015-02-24', 2),
(168, 26, 76, '2015-02-24', 35),
(169, 3, 100, '2015-02-24', 3),
(170, 4, 61, '2015-02-24', 2),
(171, 23, 98, '2015-02-24', 11),
(172, 6, 1, '2015-02-25', 2),
(173, 14, 23, '2015-02-25', 1),
(174, 17, 16, '2015-02-25', 4),
(175, 14, 55, '2015-02-25', 3),
(176, 19, 41, '2015-02-26', 4),
(177, 24, 68, '2015-02-26', 4),
(178, 20, 5, '2015-02-26', 1),
(179, 6, 15, '2015-02-26', 37),
(180, 27, 49, '2015-02-27', 4),
(181, 3, 53, '2015-02-27', 17),
(182, 2, 42, '2015-02-28', 2),
(183, 3, 36, '2015-02-28', 3),
(184, 30, 90, '2015-02-28', 36),
(185, 15, 92, '2015-02-28', 5),
(186, 23, 45, '2015-02-28', 5),
(187, 14, 50, '2015-03-01', 4),
(188, 20, 1, '2015-03-01', 5),
(189, 28, 73, '2015-03-02', 5),
(190, 2, 86, '2015-03-02', 33),
(191, 17, 3, '2015-03-02', 4),
(192, 12, 21, '2015-03-03', 2),
(193, 19, 100, '2015-03-03', 3),
(194, 17, 84, '2015-03-03', 2),
(195, 17, 84, '2015-03-03', 38),
(196, 12, 19, '2015-03-03', 1),
(197, 5, 33, '2015-03-04', 3),
(198, 22, 79, '2015-03-04', 4),
(199, 27, 93, '2015-03-04', 4),
(200, 7, 86, '2015-03-04', 1),
(201, 24, 81, '2015-03-04', 39),
(202, 22, 44, '2015-03-05', 15),
(203, 20, 1, '2015-03-05', 5),
(204, 15, 50, '2015-03-06', 2),
(205, 2, 94, '2015-03-06', 3),
(206, 25, 68, '2015-03-06', 4),
(207, 12, 79, '2015-03-06', 4),
(208, 13, 20, '2015-03-07', 3),
(209, 23, 95, '2015-03-07', 3),
(210, 12, 11, '2015-03-07', 19),
(211, 24, 40, '2015-03-07', 1),
(212, 1, 1, '2015-03-07', 19),
(213, 25, 91, '2015-03-07', 38),
(214, 5, 73, '2015-03-07', 2),
(215, 18, 26, '2015-03-08', 26),
(216, 11, 37, '2015-03-09', 2),
(217, 25, 59, '2015-03-09', 4),
(218, 29, 83, '2015-03-10', 26),
(219, 23, 18, '2015-03-10', 2),
(220, 29, 14, '2015-03-10', 3),
(221, 1, 3, '2015-03-10', 3),
(222, 2, 70, '2015-03-10', 1),
(223, 1, 52, '2015-03-11', 4),
(224, 24, 78, '2015-03-11', 2),
(225, 25, 11, '2015-03-11', 5),
(226, 1, 96, '2015-03-12', 30),
(227, 22, 59, '2015-03-12', 39),
(228, 24, 98, '2015-03-12', 12),
(229, 14, 62, '2015-03-13', 16),
(230, 11, 9, '2015-03-13', 38),
(231, 24, 15, '2015-03-14', 1),
(232, 20, 17, '2015-03-14', 32),
(233, 8, 14, '2015-03-15', 38),
(234, 19, 20, '2015-03-15', 10),
(235, 28, 24, '2015-03-15', 1),
(236, 28, 21, '2015-03-15', 33),
(237, 2, 82, '2015-03-15', 1),
(238, 3, 96, '2015-03-15', 1),
(239, 9, 40, '2015-03-16', 29),
(240, 22, 19, '2015-03-16', 5),
(241, 1, 70, '2015-03-16', 5),
(242, 22, 71, '2015-03-16', 1),
(243, 13, 11, '2015-03-17', 2),
(244, 27, 43, '2015-03-17', 4),
(245, 19, 86, '2015-03-17', 1),
(246, 17, 96, '2015-03-17', 2),
(247, 25, 11, '2015-03-17', 5),
(248, 24, 21, '2015-03-18', 3),
(249, 20, 49, '2015-03-18', 1),
(250, 25, 53, '2015-03-18', 16),
(251, 14, 69, '2015-03-18', 2),
(252, 24, 82, '2015-03-19', 4),
(253, 17, 44, '2015-03-19', 1),
(254, 7, 17, '2015-03-20', 3),
(255, 11, 6, '2015-03-20', 3),
(256, 4, 32, '2015-03-21', 12),
(257, 18, 93, '2015-03-21', 2),
(258, 30, 70, '2015-03-21', 5),
(259, 18, 23, '2015-03-22', 1),
(260, 25, 25, '2015-03-22', 3),
(261, 5, 37, '2015-03-22', 2),
(262, 24, 6, '2015-03-22', 1),
(263, 1, 84, '2015-03-22', 1),
(264, 2, 26, '2015-03-23', 4),
(265, 27, 79, '2015-03-23', 3),
(266, 19, 94, '2015-03-23', 4),
(267, 6, 81, '2015-03-23', 4),
(268, 1, 57, '2015-03-24', 5),
(269, 14, 56, '2015-03-24', 3),
(270, 9, 86, '2015-03-25', 15),
(271, 24, 46, '2015-03-25', 5),
(272, 30, 13, '2015-03-25', 30),
(273, 1, 13, '2015-03-26', 23),
(274, 3, 12, '2015-03-27', 35),
(275, 2, 30, '2015-03-27', 2),
(276, 21, 89, '2015-03-27', 3),
(277, 5, 23, '2015-03-27', 3),
(278, 20, 49, '2015-03-27', 5),
(279, 17, 77, '2015-03-27', 16),
(280, 26, 35, '2015-03-28', 30),
(281, 26, 90, '2015-03-28', 4),
(282, 22, 97, '2015-03-28', 3),
(283, 4, 5, '2015-03-28', 1),
(284, 24, 55, '2015-04-01', 34),
(285, 21, 65, '2015-04-02', 3),
(286, 22, 45, '2015-04-02', 2),
(287, 24, 42, '2015-04-03', 1),
(288, 16, 84, '2015-04-03', 4),
(289, 28, 76, '2015-04-03', 24),
(290, 16, 84, '2015-04-03', 3),
(291, 21, 45, '2015-04-03', 4),
(292, 5, 66, '2015-04-04', 4),
(293, 13, 96, '2015-04-04', 15),
(294, 29, 87, '2015-04-04', 2),
(295, 30, 16, '2015-04-04', 5),
(296, 6, 56, '2015-04-04', 2),
(297, 29, 51, '2015-04-05', 4),
(298, 7, 54, '2015-04-05', 4),
(299, 15, 1, '2015-04-05', 1),
(300, 18, 80, '2015-04-06', 3),
(301, 27, 17, '2015-04-06', 2),
(302, 15, 61, '2015-04-08', 4),
(303, 14, 46, '2015-04-08', 5),
(304, 17, 26, '2015-04-09', 1),
(305, 12, 81, '2015-04-09', 25),
(306, 29, 64, '2015-04-09', 18),
(307, 8, 18, '2015-04-10', 1),
(308, 22, 20, '2015-04-10', 1),
(309, 10, 35, '2015-04-11', 29),
(310, 29, 91, '2015-04-12', 1),
(311, 21, 91, '2015-04-12', 13),
(312, 23, 96, '2015-04-13', 5),
(313, 15, 25, '2015-04-13', 16),
(314, 24, 90, '2015-04-13', 28),
(315, 8, 66, '2015-04-13', 2),
(316, 10, 74, '2015-04-14', 2),
(317, 25, 87, '2015-04-14', 36),
(318, 19, 71, '2015-04-14', 19),
(319, 16, 1, '2015-04-14', 4),
(320, 27, 22, '2015-04-15', 3),
(321, 12, 90, '2015-04-15', 3),
(322, 2, 50, '2015-04-15', 2),
(323, 20, 48, '2015-04-15', 4),
(324, 15, 12, '2015-04-15', 3),
(325, 16, 13, '2015-04-15', 3),
(326, 15, 46, '2015-04-17', 16),
(327, 11, 49, '2015-04-17', 1),
(328, 28, 74, '2015-04-17', 10),
(329, 28, 70, '2015-04-17', 33),
(330, 22, 23, '2015-04-17', 3),
(331, 11, 11, '2015-04-17', 1),
(332, 28, 43, '2015-04-18', 1),
(333, 11, 71, '2015-04-18', 5),
(334, 7, 73, '2015-04-19', 1),
(335, 18, 63, '2015-04-19', 2),
(336, 17, 4, '2015-04-20', 5),
(337, 16, 94, '2015-04-20', 2),
(338, 25, 68, '2015-04-20', 16),
(339, 13, 63, '2015-04-21', 39),
(340, 19, 76, '2015-04-21', 5),
(341, 3, 18, '2015-04-21', 5),
(342, 30, 88, '2015-04-22', 2),
(343, 12, 4, '2015-04-23', 1),
(344, 10, 27, '2015-04-23', 25),
(345, 28, 6, '2015-04-23', 26),
(346, 7, 99, '2015-04-23', 37),
(347, 4, 14, '2015-04-24', 35),
(348, 26, 96, '2015-04-24', 2),
(349, 5, 98, '2015-04-24', 1),
(350, 4, 15, '2015-04-24', 4),
(351, 7, 19, '2015-04-25', 1),
(352, 27, 65, '2015-04-25', 2),
(353, 4, 2, '2015-04-25', 18),
(354, 30, 35, '2015-04-26', 2),
(355, 10, 45, '2015-04-26', 4),
(356, 24, 40, '2015-04-27', 1),
(357, 15, 72, '2015-04-27', 38),
(358, 26, 50, '2015-04-27', 3),
(359, 13, 1, '2015-04-28', 2),
(360, 7, 6, '2016-04-20', 14);

-- --------------------------------------------------------

--
-- Table structure for table `megrendelo`
--

CREATE TABLE IF NOT EXISTS `megrendelo` (
  `megrendelo_id` int(11) NOT NULL AUTO_INCREMENT,
  `nev` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `telefon` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`megrendelo_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci AUTO_INCREMENT=101 ;

--
-- Dumping data for table `megrendelo`
--

INSERT INTO `megrendelo` (`megrendelo_id`, `nev`, `telefon`, `email`) VALUES
(1, 'Braun József', '(20) 260-61-70', 'braun.jozsef@freemail.hu'),
(2, 'Csala Rita', '(20) 442-92-21', 'csalar@gmail.com'),
(3, 'Andrási Zsuzsanna', '(20) 336-91-85', 'andrasiz@forditoiroda.hu'),
(4, 'Veres Ákos', '(70) 442-20-96', 'veresa@forditoiroda.hu'),
(5, 'Kertész Katalin', '(30) 626-98-68', 'kertesz.katalin@forditoiroda.hu'),
(6, 'Nagy Judit', '(70) 257-51-79', 'nagy.judit14@forditoiroda.hu'),
(7, 'Jászai Ákos', '(20) 176-28-17', 'jaszai.akos@freemail.hu'),
(8, 'Keller Nikolett', '(30) 915-68-69', 'kellern@forditoiroda.hu'),
(9, 'Tóth Klaudia', '(30) 203-65-96', 'tothk@forditoiroda.hu'),
(10, 'Csikós Adrián', '(20) 102-35-63', 'csikos.adrian@forditoiroda.hu'),
(11, 'Guttmann Zsanett', '(70) 654-11-96', 'guttmannz48@freemail.hu'),
(12, 'Baranyai Nikolett', '(20) 885-22-32', 'baranyain@freemail.hu'),
(13, 'Lukács Csilla', '(20) 577-39-10', 'lukacsc@forditoiroda.hu'),
(14, 'Guttmann Mariann', '(30) 367-90-45', 'guttmann.mariann@freemail.hu'),
(15, 'Horkai Dávid', '(70) 970-48-14', 'horkaid@gmail.com'),
(16, 'Csala Zsolt', '(30) 916-69-74', 'csala.zsolt@freemail.hu'),
(17, 'Bódog Viktor', '(30) 884-43-74', 'bodog.viktor@forditoiroda.hu'),
(18, 'Turai Ferenc', '(30) 169-94-45', 'turai.ferenc@gmail.com'),
(19, 'Zsolnai Gergely', '(20) 522-44-41', 'zsolnaig25@freemail.hu'),
(20, 'Tóth Nikolett', '(20) 994-91-83', 'toth.nikolett@gmail.com'),
(21, 'Tolnai Balázs', '(70) 110-41-73', 'tolnaib@gmail.com'),
(22, 'Zoltai Péter', '(30) 542-41-97', 'zoltai.peter28@freemail.hu'),
(23, 'Kaleczky Gabriella', '(70) 696-41-44', 'kaleczky.gabriella@forditoiroda.hu'),
(24, 'Ambrus Zita', '(30) 140-48-90', 'ambrus.zita@freemail.hu'),
(25, 'Tóth Ádám', '(70) 785-40-15', 'totha@gmail.com'),
(26, 'Ambrus Eleonóra', '(70) 851-42-81', 'ambrus.eleonora@freemail.hu'),
(27, 'Koczka Rita', '(30) 619-40-25', 'koczkar@gmail.com'),
(28, 'Zsiday Bettina', '(30) 789-29-41', 'zsidayb@forditoiroda.hu'),
(29, 'Jászai Bettina', '(30) 486-11-76', 'jaszai.bettina@gmail.com'),
(30, 'Illovszki Lívia', '(20) 341-13-59', 'illovszkil@freemail.hu'),
(31, 'Gőgösi Zoltán', '(70) 354-25-12', 'gogosi.zoltan28@forditoiroda.hu'),
(32, 'Csoó Örs', '(30) 860-25-50', 'csoo.ors@forditoiroda.hu'),
(33, 'Zsiday Gábor', '(20) 386-18-65', 'zsidayg@gmail.com'),
(34, 'Jászai Helga', '(20) 998-93-19', 'jaszai.helga@forditoiroda.hu'),
(35, 'Madarász Helga', '(30) 131-12-26', 'madarasz.helga39@forditoiroda.hu'),
(36, 'Balogh Nikolett', '(70) 513-49-98', 'baloghn56@gmail.com'),
(37, 'Gellért József', '(20) 464-81-79', 'gellert.jozsef@gmail.com'),
(38, 'Verpeléti Petra', '(20) 345-43-11', 'verpeleti.petra@forditoiroda.hu'),
(39, 'Nyúzó Judit', '(20) 169-74-86', 'nyuzo.judit@freemail.hu'),
(40, 'Eszes Lídia', '(20) 208-82-30', 'eszesl@freemail.hu'),
(41, 'Darázs Anikó', '(20) 448-84-57', 'darazs.aniko@gmail.com'),
(42, 'Zoltai Attila', '(20) 976-83-52', 'zoltaia@freemail.hu'),
(43, 'Csoó Bence', '(70) 410-16-23', 'csoob@forditoiroda.hu'),
(44, 'Molnár Tibor', '(20) 707-69-82', 'molnart@freemail.hu'),
(45, 'Andrási Ákos', '(70) 360-55-82', 'andrasia@freemail.hu'),
(46, 'Jászai Petra', '(30) 842-19-32', 'jaszai.petra@forditoiroda.hu'),
(47, 'Ambrus Zita', '(70) 745-58-94', 'ambrus.zita@freemail.hu'),
(48, 'Lukács Marietta', '(20) 121-32-53', 'lukacsm26@freemail.hu'),
(49, 'Molnár Zita', '(70) 459-44-58', 'molnarz@forditoiroda.hu'),
(50, 'Erdei Katalin', '(70) 559-30-46', 'erdeik@gmail.com'),
(51, 'Baranyai Lívia', '(30) 143-32-89', 'baranyai.livia@gmail.com'),
(52, 'Molnár Olga', '(30) 658-80-98', 'molnar.olga@freemail.hu'),
(53, 'Darázs János', '(20) 558-25-20', 'darazs.janos27@freemail.hu'),
(54, 'Kiss Pál', '(30) 116-35-30', 'kiss.pal49@forditoiroda.hu'),
(55, 'Kaló Marietta', '(30) 711-48-60', 'kalo.marietta@gmail.com'),
(56, 'Erdei Bence', '(70) 434-21-20', 'erdei.bence@gmail.com'),
(57, 'Zsikla Zita', '(20) 455-69-75', 'zsiklaz26@forditoiroda.hu'),
(58, 'Kaleczky Lajos', '(20) 957-88-89', 'kaleczky.lajos46@forditoiroda.hu'),
(59, 'Eszes Etelka', '(20) 367-18-20', 'eszes.etelka@freemail.hu'),
(60, 'Baranyai Helga', '(20) 756-89-19', 'baranyaih52@forditoiroda.hu'),
(61, 'Szűcs Viktor', '(30) 585-89-52', 'szucs.viktor@freemail.hu'),
(62, 'Molnár Gábor', '(30) 162-51-91', 'molnar.gabor@freemail.hu'),
(63, 'Fazekas Tímea', '(20) 353-86-15', 'fazekas.timea18@gmail.com'),
(64, 'Baranyai Edina', '(20) 578-12-73', 'baranyaie@freemail.hu'),
(65, 'Gellért Tibor', '(70) 218-70-52', 'gellert.tibor46@freemail.hu'),
(66, 'Kabai László', '(20) 189-20-29', 'kabai.laszlo@gmail.com'),
(67, 'Csiszér Györgyi', '(20) 545-62-57', 'csiszer.gyorgyi@forditoiroda.hu'),
(68, 'Bódog László', '(30) 333-31-40', 'bodogl@forditoiroda.hu'),
(69, 'Ambrus Marietta', '(70) 443-84-27', 'ambrus.marietta@forditoiroda.hu'),
(70, 'Herczeg Kitty', '(20) 408-25-47', 'herczegk50@freemail.hu'),
(71, 'Kabai Zsanett', '(20) 982-84-13', 'kabaiz@freemail.hu'),
(72, 'Solymos Helga', '(30) 509-29-96', 'solymosh37@forditoiroda.hu'),
(73, 'Csala Zita', '(30) 235-25-75', 'csalaz@gmail.com'),
(74, 'Andrási Bence', '(20) 407-20-53', 'andrasi.bence@forditoiroda.hu'),
(75, 'Varga István', '(20) 184-95-20', 'vargai54@forditoiroda.hu'),
(76, 'Csiszér Örs', '(20) 903-54-77', 'csiszero@forditoiroda.hu'),
(77, 'Herczeg Bence', '(20) 439-53-50', 'herczeg.bence44@forditoiroda.hu'),
(78, 'Halmosi Olga', '(30) 543-61-17', 'halmosio@forditoiroda.hu'),
(79, 'Fekete Zoltán', '(20) 360-15-11', 'feketez@forditoiroda.hu'),
(80, 'Baranyai Olga', '(70) 384-17-35', 'baranyai.olga@forditoiroda.hu'),
(81, 'Hun Kálmán', '(30) 792-75-51', 'hunk@gmail.com'),
(82, 'Jászai Zsuzsanna', '(30) 954-48-88', 'jaszai.zsuzsanna16@gmail.com'),
(83, 'Krasznai Viktor', '(70) 937-15-56', 'krasznai.viktor@freemail.hu'),
(84, 'Csala Bence', '(30) 888-54-83', 'csala.bence@freemail.hu'),
(85, 'Koczka Kitty', '(20) 365-29-79', 'koczka.kitty@gmail.com'),
(86, 'Illovszki Sámuel', '(20) 330-40-22', 'illovszki.samuel@gmail.com'),
(87, 'Nyúzó Barbara', '(30) 169-40-14', 'nyuzo.barbara57@gmail.com'),
(88, 'Balogh Barbara', '(20) 154-44-58', 'balogh.barbara@forditoiroda.hu'),
(89, 'Fekete Géza', '(20) 240-29-95', 'feketeg@gmail.com'),
(90, 'Gellért Etelka', '(20) 264-87-76', 'gellert.etelka@gmail.com'),
(91, 'Tóth Helga', '(20) 302-31-28', 'toth.helga58@forditoiroda.hu'),
(92, 'Csikós Lajos', '(70) 763-43-99', 'csikosl@freemail.hu'),
(93, 'Kelemen Anikó', '(20) 429-11-93', 'kelemena@freemail.hu'),
(94, 'Magyar Zsolt', '(20) 252-47-15', 'magyarz@freemail.hu'),
(95, 'Tóth Mariann', '(20) 290-82-14', 'tothm@gmail.com'),
(96, 'Csikós Balázs', '(20) 397-15-22', 'csikosb41@gmail.com'),
(97, 'Verpeléti Emília', '(30) 697-40-85', 'verpeletie@freemail.hu'),
(98, 'Zsiday Katalin', '(20) 152-69-64', 'zsiday.katalin@forditoiroda.hu'),
(99, 'Fási Roland', '(70) 107-26-79', 'fasi.roland@forditoiroda.hu'),
(100, 'Józsa Andrea', '(20) 126-45-53', 'jozsa.andrea@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `nyelv`
--

CREATE TABLE IF NOT EXISTS `nyelv` (
  `nyelv_id` int(11) NOT NULL AUTO_INCREMENT,
  `megnevezes` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`nyelv_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci AUTO_INCREMENT=11 ;

--
-- Dumping data for table `nyelv`
--

INSERT INTO `nyelv` (`nyelv_id`, `megnevezes`) VALUES
(1, 'angol'),
(2, 'német'),
(3, 'francia'),
(4, 'olasz'),
(5, 'spanyol'),
(6, 'portugál'),
(7, 'francia'),
(8, 'román'),
(9, 'szerb'),
(10, 'orosz');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `fordito`
--
ALTER TABLE `fordito`
  ADD CONSTRAINT `fordito_ibfk_1` FOREIGN KEY (`nyelv_id`) REFERENCES `nyelv` (`nyelv_id`);

--
-- Constraints for table `megrendeles`
--
ALTER TABLE `megrendeles`
  ADD CONSTRAINT `megrendeles_ibfk_2` FOREIGN KEY (`megrendelo_id`) REFERENCES `megrendelo` (`megrendelo_id`),
  ADD CONSTRAINT `megrendeles_ibfk_1` FOREIGN KEY (`fordito_id`) REFERENCES `fordito` (`fordito_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
