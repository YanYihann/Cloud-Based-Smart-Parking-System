-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 10, 2025 at 05:06 PM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cps3962`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `license_plate` varchar(20) NOT NULL,
  `spot_id` varchar(10) NOT NULL,
  `entry_time` datetime NOT NULL,
  `exit_time` datetime DEFAULT NULL,
  `payment_status` enum('Pending','Confirmed','NonMember') DEFAULT 'Pending',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `spot_id` (`spot_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `username`, `license_plate`, `spot_id`, `entry_time`, `exit_time`, `payment_status`) VALUES
(1, 'yanyihan', '88888', 'U1-1', '2025-04-23 13:00:00', '2025-05-10 11:22:09', 'Confirmed'),
(2, NULL, '11111', 'U1-1', '2025-05-10 08:22:40', '2025-05-10 11:22:41', 'NonMember'),
(3, 'yanyihan', '88888', 'U3-1', '2025-05-10 14:00:00', '2025-05-10 12:48:58', 'Confirmed'),
(4, 'yanyihan', '88888', 'O2-1', '2025-05-05 17:00:00', '2025-05-10 12:50:00', 'Confirmed'),
(5, NULL, '56789', 'U1-1', '2025-05-10 09:50:19', '2025-05-10 12:50:20', 'NonMember'),
(6, NULL, '77777', 'U1-1', '2025-05-10 11:50:33', '2025-05-10 12:50:35', 'NonMember'),
(7, NULL, '23456', 'U1-1', '2025-05-10 08:50:41', '2025-05-10 12:50:42', 'NonMember');

-- --------------------------------------------------------

--
-- Table structure for table `parking_spots`
--

DROP TABLE IF EXISTS `parking_spots`;
CREATE TABLE IF NOT EXISTS `parking_spots` (
  `id` int NOT NULL AUTO_INCREMENT,
  `spot_id` varchar(10) NOT NULL,
  `area` varchar(50) NOT NULL,
  `location` varchar(50) NOT NULL,
  `status` enum('Available','Booked') DEFAULT 'Available',
  PRIMARY KEY (`id`),
  UNIQUE KEY `spot_id` (`spot_id`)
) ENGINE=InnoDB AUTO_INCREMENT=636 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `parking_spots`
--

INSERT INTO `parking_spots` (`id`, `spot_id`, `area`, `location`, `status`) VALUES
(1, 'U1-1', 'Underground', 'U1', 'Available'),
(2, 'U1-2', 'Underground', 'U1', 'Available'),
(3, 'U1-3', 'Underground', 'U1', 'Available'),
(4, 'U1-4', 'Underground', 'U1', 'Available'),
(5, 'U1-5', 'Underground', 'U1', 'Available'),
(6, 'U1-6', 'Underground', 'U1', 'Available'),
(7, 'U1-7', 'Underground', 'U1', 'Available'),
(8, 'U1-8', 'Underground', 'U1', 'Available'),
(9, 'U1-9', 'Underground', 'U1', 'Available'),
(10, 'U1-10', 'Underground', 'U1', 'Available'),
(11, 'U1-11', 'Underground', 'U1', 'Available'),
(12, 'U1-12', 'Underground', 'U1', 'Available'),
(13, 'U1-13', 'Underground', 'U1', 'Available'),
(14, 'U1-14', 'Underground', 'U1', 'Available'),
(15, 'U1-15', 'Underground', 'U1', 'Available'),
(16, 'U1-16', 'Underground', 'U1', 'Available'),
(17, 'U1-17', 'Underground', 'U1', 'Available'),
(18, 'U1-18', 'Underground', 'U1', 'Available'),
(19, 'U1-19', 'Underground', 'U1', 'Available'),
(20, 'U1-20', 'Underground', 'U1', 'Available'),
(21, 'U1-21', 'Underground', 'U1', 'Available'),
(22, 'U1-22', 'Underground', 'U1', 'Available'),
(23, 'U1-23', 'Underground', 'U1', 'Available'),
(24, 'U1-24', 'Underground', 'U1', 'Available'),
(25, 'U1-25', 'Underground', 'U1', 'Available'),
(26, 'U1-26', 'Underground', 'U1', 'Available'),
(27, 'U1-27', 'Underground', 'U1', 'Available'),
(28, 'U1-28', 'Underground', 'U1', 'Available'),
(29, 'U1-29', 'Underground', 'U1', 'Available'),
(30, 'U1-30', 'Underground', 'U1', 'Available'),
(31, 'U1-31', 'Underground', 'U1', 'Available'),
(32, 'U1-32', 'Underground', 'U1', 'Available'),
(33, 'U1-33', 'Underground', 'U1', 'Available'),
(34, 'U1-34', 'Underground', 'U1', 'Available'),
(35, 'U1-35', 'Underground', 'U1', 'Available'),
(36, 'U1-36', 'Underground', 'U1', 'Available'),
(37, 'U1-37', 'Underground', 'U1', 'Available'),
(38, 'U1-38', 'Underground', 'U1', 'Available'),
(39, 'U1-39', 'Underground', 'U1', 'Available'),
(40, 'U1-40', 'Underground', 'U1', 'Available'),
(41, 'U1-41', 'Underground', 'U1', 'Available'),
(42, 'U1-42', 'Underground', 'U1', 'Available'),
(43, 'U1-43', 'Underground', 'U1', 'Available'),
(44, 'U1-44', 'Underground', 'U1', 'Available'),
(45, 'U1-45', 'Underground', 'U1', 'Available'),
(46, 'U1-46', 'Underground', 'U1', 'Available'),
(47, 'U1-47', 'Underground', 'U1', 'Available'),
(48, 'U1-48', 'Underground', 'U1', 'Available'),
(49, 'U1-49', 'Underground', 'U1', 'Available'),
(50, 'U1-50', 'Underground', 'U1', 'Available'),
(51, 'U1-51', 'Underground', 'U1', 'Available'),
(52, 'U1-52', 'Underground', 'U1', 'Available'),
(53, 'U1-53', 'Underground', 'U1', 'Available'),
(54, 'U1-54', 'Underground', 'U1', 'Available'),
(55, 'U1-55', 'Underground', 'U1', 'Available'),
(56, 'U1-56', 'Underground', 'U1', 'Available'),
(57, 'U1-57', 'Underground', 'U1', 'Available'),
(58, 'U1-58', 'Underground', 'U1', 'Available'),
(59, 'U1-59', 'Underground', 'U1', 'Available'),
(60, 'U1-60', 'Underground', 'U1', 'Available'),
(61, 'U1-61', 'Underground', 'U1', 'Available'),
(62, 'U1-62', 'Underground', 'U1', 'Available'),
(63, 'U1-63', 'Underground', 'U1', 'Available'),
(64, 'U1-64', 'Underground', 'U1', 'Available'),
(65, 'U1-65', 'Underground', 'U1', 'Available'),
(66, 'U1-66', 'Underground', 'U1', 'Available'),
(67, 'U1-67', 'Underground', 'U1', 'Available'),
(68, 'U1-68', 'Underground', 'U1', 'Available'),
(69, 'U1-69', 'Underground', 'U1', 'Available'),
(70, 'U1-70', 'Underground', 'U1', 'Available'),
(71, 'U1-71', 'Underground', 'U1', 'Available'),
(72, 'U1-72', 'Underground', 'U1', 'Available'),
(73, 'U1-73', 'Underground', 'U1', 'Available'),
(74, 'U1-74', 'Underground', 'U1', 'Available'),
(75, 'U1-75', 'Underground', 'U1', 'Available'),
(76, 'U1-76', 'Underground', 'U1', 'Available'),
(77, 'U1-77', 'Underground', 'U1', 'Available'),
(78, 'U1-78', 'Underground', 'U1', 'Available'),
(79, 'U1-79', 'Underground', 'U1', 'Available'),
(80, 'U1-80', 'Underground', 'U1', 'Available'),
(81, 'U1-81', 'Underground', 'U1', 'Available'),
(82, 'U1-82', 'Underground', 'U1', 'Available'),
(83, 'U1-83', 'Underground', 'U1', 'Available'),
(84, 'U1-84', 'Underground', 'U1', 'Available'),
(85, 'U1-85', 'Underground', 'U1', 'Available'),
(86, 'U1-86', 'Underground', 'U1', 'Available'),
(87, 'U1-87', 'Underground', 'U1', 'Available'),
(88, 'U1-88', 'Underground', 'U1', 'Available'),
(89, 'U1-89', 'Underground', 'U1', 'Available'),
(90, 'U1-90', 'Underground', 'U1', 'Available'),
(91, 'U1-91', 'Underground', 'U1', 'Available'),
(92, 'U1-92', 'Underground', 'U1', 'Available'),
(93, 'U1-93', 'Underground', 'U1', 'Available'),
(94, 'U1-94', 'Underground', 'U1', 'Available'),
(95, 'U1-95', 'Underground', 'U1', 'Available'),
(96, 'U1-96', 'Underground', 'U1', 'Available'),
(97, 'U1-97', 'Underground', 'U1', 'Available'),
(98, 'U1-98', 'Underground', 'U1', 'Available'),
(99, 'U1-99', 'Underground', 'U1', 'Available'),
(100, 'U1-100', 'Underground', 'U1', 'Available'),
(128, 'U2-1', 'Underground', 'U2', 'Available'),
(129, 'U2-2', 'Underground', 'U2', 'Available'),
(130, 'U2-3', 'Underground', 'U2', 'Available'),
(131, 'U2-4', 'Underground', 'U2', 'Available'),
(132, 'U2-5', 'Underground', 'U2', 'Available'),
(133, 'U2-6', 'Underground', 'U2', 'Available'),
(134, 'U2-7', 'Underground', 'U2', 'Available'),
(135, 'U2-8', 'Underground', 'U2', 'Available'),
(136, 'U2-9', 'Underground', 'U2', 'Available'),
(137, 'U2-10', 'Underground', 'U2', 'Available'),
(138, 'U2-11', 'Underground', 'U2', 'Available'),
(139, 'U2-12', 'Underground', 'U2', 'Available'),
(140, 'U2-13', 'Underground', 'U2', 'Available'),
(141, 'U2-14', 'Underground', 'U2', 'Available'),
(142, 'U2-15', 'Underground', 'U2', 'Available'),
(143, 'U2-16', 'Underground', 'U2', 'Available'),
(144, 'U2-17', 'Underground', 'U2', 'Available'),
(145, 'U2-18', 'Underground', 'U2', 'Available'),
(146, 'U2-19', 'Underground', 'U2', 'Available'),
(147, 'U2-20', 'Underground', 'U2', 'Available'),
(148, 'U2-21', 'Underground', 'U2', 'Available'),
(149, 'U2-22', 'Underground', 'U2', 'Available'),
(150, 'U2-23', 'Underground', 'U2', 'Available'),
(151, 'U2-24', 'Underground', 'U2', 'Available'),
(152, 'U2-25', 'Underground', 'U2', 'Available'),
(153, 'U2-26', 'Underground', 'U2', 'Available'),
(154, 'U2-27', 'Underground', 'U2', 'Available'),
(155, 'U2-28', 'Underground', 'U2', 'Available'),
(156, 'U2-29', 'Underground', 'U2', 'Available'),
(157, 'U2-30', 'Underground', 'U2', 'Available'),
(158, 'U2-31', 'Underground', 'U2', 'Available'),
(159, 'U2-32', 'Underground', 'U2', 'Available'),
(160, 'U2-33', 'Underground', 'U2', 'Available'),
(161, 'U2-34', 'Underground', 'U2', 'Available'),
(162, 'U2-35', 'Underground', 'U2', 'Available'),
(163, 'U2-36', 'Underground', 'U2', 'Available'),
(164, 'U2-37', 'Underground', 'U2', 'Available'),
(165, 'U2-38', 'Underground', 'U2', 'Available'),
(166, 'U2-39', 'Underground', 'U2', 'Available'),
(167, 'U2-40', 'Underground', 'U2', 'Available'),
(168, 'U2-41', 'Underground', 'U2', 'Available'),
(169, 'U2-42', 'Underground', 'U2', 'Available'),
(170, 'U2-43', 'Underground', 'U2', 'Available'),
(171, 'U2-44', 'Underground', 'U2', 'Available'),
(172, 'U2-45', 'Underground', 'U2', 'Available'),
(173, 'U2-46', 'Underground', 'U2', 'Available'),
(174, 'U2-47', 'Underground', 'U2', 'Available'),
(175, 'U2-48', 'Underground', 'U2', 'Available'),
(176, 'U2-49', 'Underground', 'U2', 'Available'),
(177, 'U2-50', 'Underground', 'U2', 'Available'),
(178, 'U2-51', 'Underground', 'U2', 'Available'),
(179, 'U2-52', 'Underground', 'U2', 'Available'),
(180, 'U2-53', 'Underground', 'U2', 'Available'),
(181, 'U2-54', 'Underground', 'U2', 'Available'),
(182, 'U2-55', 'Underground', 'U2', 'Available'),
(183, 'U2-56', 'Underground', 'U2', 'Available'),
(184, 'U2-57', 'Underground', 'U2', 'Available'),
(185, 'U2-58', 'Underground', 'U2', 'Available'),
(186, 'U2-59', 'Underground', 'U2', 'Available'),
(187, 'U2-60', 'Underground', 'U2', 'Available'),
(188, 'U2-61', 'Underground', 'U2', 'Available'),
(189, 'U2-62', 'Underground', 'U2', 'Available'),
(190, 'U2-63', 'Underground', 'U2', 'Available'),
(191, 'U2-64', 'Underground', 'U2', 'Available'),
(192, 'U2-65', 'Underground', 'U2', 'Available'),
(193, 'U2-66', 'Underground', 'U2', 'Available'),
(194, 'U2-67', 'Underground', 'U2', 'Available'),
(195, 'U2-68', 'Underground', 'U2', 'Available'),
(196, 'U2-69', 'Underground', 'U2', 'Available'),
(197, 'U2-70', 'Underground', 'U2', 'Available'),
(198, 'U2-71', 'Underground', 'U2', 'Available'),
(199, 'U2-72', 'Underground', 'U2', 'Available'),
(200, 'U2-73', 'Underground', 'U2', 'Available'),
(201, 'U2-74', 'Underground', 'U2', 'Available'),
(202, 'U2-75', 'Underground', 'U2', 'Available'),
(203, 'U2-76', 'Underground', 'U2', 'Available'),
(204, 'U2-77', 'Underground', 'U2', 'Available'),
(205, 'U2-78', 'Underground', 'U2', 'Available'),
(206, 'U2-79', 'Underground', 'U2', 'Available'),
(207, 'U2-80', 'Underground', 'U2', 'Available'),
(208, 'U2-81', 'Underground', 'U2', 'Available'),
(209, 'U2-82', 'Underground', 'U2', 'Available'),
(210, 'U2-83', 'Underground', 'U2', 'Available'),
(211, 'U2-84', 'Underground', 'U2', 'Available'),
(212, 'U2-85', 'Underground', 'U2', 'Available'),
(213, 'U2-86', 'Underground', 'U2', 'Available'),
(214, 'U2-87', 'Underground', 'U2', 'Available'),
(215, 'U2-88', 'Underground', 'U2', 'Available'),
(216, 'U2-89', 'Underground', 'U2', 'Available'),
(217, 'U2-90', 'Underground', 'U2', 'Available'),
(218, 'U2-91', 'Underground', 'U2', 'Available'),
(219, 'U2-92', 'Underground', 'U2', 'Available'),
(220, 'U2-93', 'Underground', 'U2', 'Available'),
(221, 'U2-94', 'Underground', 'U2', 'Available'),
(222, 'U2-95', 'Underground', 'U2', 'Available'),
(223, 'U2-96', 'Underground', 'U2', 'Available'),
(224, 'U2-97', 'Underground', 'U2', 'Available'),
(225, 'U2-98', 'Underground', 'U2', 'Available'),
(226, 'U2-99', 'Underground', 'U2', 'Available'),
(227, 'U2-100', 'Underground', 'U2', 'Available'),
(255, 'U3-1', 'Underground', 'U3', 'Available'),
(256, 'U3-2', 'Underground', 'U3', 'Available'),
(257, 'U3-3', 'Underground', 'U3', 'Available'),
(258, 'U3-4', 'Underground', 'U3', 'Available'),
(259, 'U3-5', 'Underground', 'U3', 'Available'),
(260, 'U3-6', 'Underground', 'U3', 'Available'),
(261, 'U3-7', 'Underground', 'U3', 'Available'),
(262, 'U3-8', 'Underground', 'U3', 'Available'),
(263, 'U3-9', 'Underground', 'U3', 'Available'),
(264, 'U3-10', 'Underground', 'U3', 'Available'),
(265, 'U3-11', 'Underground', 'U3', 'Available'),
(266, 'U3-12', 'Underground', 'U3', 'Available'),
(267, 'U3-13', 'Underground', 'U3', 'Available'),
(268, 'U3-14', 'Underground', 'U3', 'Available'),
(269, 'U3-15', 'Underground', 'U3', 'Available'),
(270, 'U3-16', 'Underground', 'U3', 'Available'),
(271, 'U3-17', 'Underground', 'U3', 'Available'),
(272, 'U3-18', 'Underground', 'U3', 'Available'),
(273, 'U3-19', 'Underground', 'U3', 'Available'),
(274, 'U3-20', 'Underground', 'U3', 'Available'),
(275, 'U3-21', 'Underground', 'U3', 'Available'),
(276, 'U3-22', 'Underground', 'U3', 'Available'),
(277, 'U3-23', 'Underground', 'U3', 'Available'),
(278, 'U3-24', 'Underground', 'U3', 'Available'),
(279, 'U3-25', 'Underground', 'U3', 'Available'),
(280, 'U3-26', 'Underground', 'U3', 'Available'),
(281, 'U3-27', 'Underground', 'U3', 'Available'),
(282, 'U3-28', 'Underground', 'U3', 'Available'),
(283, 'U3-29', 'Underground', 'U3', 'Available'),
(284, 'U3-30', 'Underground', 'U3', 'Available'),
(285, 'U3-31', 'Underground', 'U3', 'Available'),
(286, 'U3-32', 'Underground', 'U3', 'Available'),
(287, 'U3-33', 'Underground', 'U3', 'Available'),
(288, 'U3-34', 'Underground', 'U3', 'Available'),
(289, 'U3-35', 'Underground', 'U3', 'Available'),
(290, 'U3-36', 'Underground', 'U3', 'Available'),
(291, 'U3-37', 'Underground', 'U3', 'Available'),
(292, 'U3-38', 'Underground', 'U3', 'Available'),
(293, 'U3-39', 'Underground', 'U3', 'Available'),
(294, 'U3-40', 'Underground', 'U3', 'Available'),
(295, 'U3-41', 'Underground', 'U3', 'Available'),
(296, 'U3-42', 'Underground', 'U3', 'Available'),
(297, 'U3-43', 'Underground', 'U3', 'Available'),
(298, 'U3-44', 'Underground', 'U3', 'Available'),
(299, 'U3-45', 'Underground', 'U3', 'Available'),
(300, 'U3-46', 'Underground', 'U3', 'Available'),
(301, 'U3-47', 'Underground', 'U3', 'Available'),
(302, 'U3-48', 'Underground', 'U3', 'Available'),
(303, 'U3-49', 'Underground', 'U3', 'Available'),
(304, 'U3-50', 'Underground', 'U3', 'Available'),
(305, 'U3-51', 'Underground', 'U3', 'Available'),
(306, 'U3-52', 'Underground', 'U3', 'Available'),
(307, 'U3-53', 'Underground', 'U3', 'Available'),
(308, 'U3-54', 'Underground', 'U3', 'Available'),
(309, 'U3-55', 'Underground', 'U3', 'Available'),
(310, 'U3-56', 'Underground', 'U3', 'Available'),
(311, 'U3-57', 'Underground', 'U3', 'Available'),
(312, 'U3-58', 'Underground', 'U3', 'Available'),
(313, 'U3-59', 'Underground', 'U3', 'Available'),
(314, 'U3-60', 'Underground', 'U3', 'Available'),
(315, 'U3-61', 'Underground', 'U3', 'Available'),
(316, 'U3-62', 'Underground', 'U3', 'Available'),
(317, 'U3-63', 'Underground', 'U3', 'Available'),
(318, 'U3-64', 'Underground', 'U3', 'Available'),
(319, 'U3-65', 'Underground', 'U3', 'Available'),
(320, 'U3-66', 'Underground', 'U3', 'Available'),
(321, 'U3-67', 'Underground', 'U3', 'Available'),
(322, 'U3-68', 'Underground', 'U3', 'Available'),
(323, 'U3-69', 'Underground', 'U3', 'Available'),
(324, 'U3-70', 'Underground', 'U3', 'Available'),
(325, 'U3-71', 'Underground', 'U3', 'Available'),
(326, 'U3-72', 'Underground', 'U3', 'Available'),
(327, 'U3-73', 'Underground', 'U3', 'Available'),
(328, 'U3-74', 'Underground', 'U3', 'Available'),
(329, 'U3-75', 'Underground', 'U3', 'Available'),
(330, 'U3-76', 'Underground', 'U3', 'Available'),
(331, 'U3-77', 'Underground', 'U3', 'Available'),
(332, 'U3-78', 'Underground', 'U3', 'Available'),
(333, 'U3-79', 'Underground', 'U3', 'Available'),
(334, 'U3-80', 'Underground', 'U3', 'Available'),
(335, 'U3-81', 'Underground', 'U3', 'Available'),
(336, 'U3-82', 'Underground', 'U3', 'Available'),
(337, 'U3-83', 'Underground', 'U3', 'Available'),
(338, 'U3-84', 'Underground', 'U3', 'Available'),
(339, 'U3-85', 'Underground', 'U3', 'Available'),
(340, 'U3-86', 'Underground', 'U3', 'Available'),
(341, 'U3-87', 'Underground', 'U3', 'Available'),
(342, 'U3-88', 'Underground', 'U3', 'Available'),
(343, 'U3-89', 'Underground', 'U3', 'Available'),
(344, 'U3-90', 'Underground', 'U3', 'Available'),
(345, 'U3-91', 'Underground', 'U3', 'Available'),
(346, 'U3-92', 'Underground', 'U3', 'Available'),
(347, 'U3-93', 'Underground', 'U3', 'Available'),
(348, 'U3-94', 'Underground', 'U3', 'Available'),
(349, 'U3-95', 'Underground', 'U3', 'Available'),
(350, 'U3-96', 'Underground', 'U3', 'Available'),
(351, 'U3-97', 'Underground', 'U3', 'Available'),
(352, 'U3-98', 'Underground', 'U3', 'Available'),
(353, 'U3-99', 'Underground', 'U3', 'Available'),
(354, 'U3-100', 'Underground', 'U3', 'Available'),
(382, 'O1-1', 'Overground', 'O1', 'Available'),
(383, 'O1-2', 'Overground', 'O1', 'Available'),
(384, 'O1-3', 'Overground', 'O1', 'Available'),
(385, 'O1-4', 'Overground', 'O1', 'Available'),
(386, 'O1-5', 'Overground', 'O1', 'Available'),
(387, 'O1-6', 'Overground', 'O1', 'Available'),
(388, 'O1-7', 'Overground', 'O1', 'Available'),
(389, 'O1-8', 'Overground', 'O1', 'Available'),
(390, 'O1-9', 'Overground', 'O1', 'Available'),
(391, 'O1-10', 'Overground', 'O1', 'Available'),
(392, 'O1-11', 'Overground', 'O1', 'Available'),
(393, 'O1-12', 'Overground', 'O1', 'Available'),
(394, 'O1-13', 'Overground', 'O1', 'Available'),
(395, 'O1-14', 'Overground', 'O1', 'Available'),
(396, 'O1-15', 'Overground', 'O1', 'Available'),
(397, 'O1-16', 'Overground', 'O1', 'Available'),
(398, 'O1-17', 'Overground', 'O1', 'Available'),
(399, 'O1-18', 'Overground', 'O1', 'Available'),
(400, 'O1-19', 'Overground', 'O1', 'Available'),
(401, 'O1-20', 'Overground', 'O1', 'Available'),
(402, 'O1-21', 'Overground', 'O1', 'Available'),
(403, 'O1-22', 'Overground', 'O1', 'Available'),
(404, 'O1-23', 'Overground', 'O1', 'Available'),
(405, 'O1-24', 'Overground', 'O1', 'Available'),
(406, 'O1-25', 'Overground', 'O1', 'Available'),
(407, 'O1-26', 'Overground', 'O1', 'Available'),
(408, 'O1-27', 'Overground', 'O1', 'Available'),
(409, 'O1-28', 'Overground', 'O1', 'Available'),
(410, 'O1-29', 'Overground', 'O1', 'Available'),
(411, 'O1-30', 'Overground', 'O1', 'Available'),
(412, 'O1-31', 'Overground', 'O1', 'Available'),
(413, 'O1-32', 'Overground', 'O1', 'Available'),
(414, 'O1-33', 'Overground', 'O1', 'Available'),
(415, 'O1-34', 'Overground', 'O1', 'Available'),
(416, 'O1-35', 'Overground', 'O1', 'Available'),
(417, 'O1-36', 'Overground', 'O1', 'Available'),
(418, 'O1-37', 'Overground', 'O1', 'Available'),
(419, 'O1-38', 'Overground', 'O1', 'Available'),
(420, 'O1-39', 'Overground', 'O1', 'Available'),
(421, 'O1-40', 'Overground', 'O1', 'Available'),
(422, 'O1-41', 'Overground', 'O1', 'Available'),
(423, 'O1-42', 'Overground', 'O1', 'Available'),
(424, 'O1-43', 'Overground', 'O1', 'Available'),
(425, 'O1-44', 'Overground', 'O1', 'Available'),
(426, 'O1-45', 'Overground', 'O1', 'Available'),
(427, 'O1-46', 'Overground', 'O1', 'Available'),
(428, 'O1-47', 'Overground', 'O1', 'Available'),
(429, 'O1-48', 'Overground', 'O1', 'Available'),
(430, 'O1-49', 'Overground', 'O1', 'Available'),
(431, 'O1-50', 'Overground', 'O1', 'Available'),
(432, 'O1-51', 'Overground', 'O1', 'Available'),
(433, 'O1-52', 'Overground', 'O1', 'Available'),
(434, 'O1-53', 'Overground', 'O1', 'Available'),
(435, 'O1-54', 'Overground', 'O1', 'Available'),
(436, 'O1-55', 'Overground', 'O1', 'Available'),
(437, 'O1-56', 'Overground', 'O1', 'Available'),
(438, 'O1-57', 'Overground', 'O1', 'Available'),
(439, 'O1-58', 'Overground', 'O1', 'Available'),
(440, 'O1-59', 'Overground', 'O1', 'Available'),
(441, 'O1-60', 'Overground', 'O1', 'Available'),
(442, 'O1-61', 'Overground', 'O1', 'Available'),
(443, 'O1-62', 'Overground', 'O1', 'Available'),
(444, 'O1-63', 'Overground', 'O1', 'Available'),
(445, 'O1-64', 'Overground', 'O1', 'Available'),
(446, 'O1-65', 'Overground', 'O1', 'Available'),
(447, 'O1-66', 'Overground', 'O1', 'Available'),
(448, 'O1-67', 'Overground', 'O1', 'Available'),
(449, 'O1-68', 'Overground', 'O1', 'Available'),
(450, 'O1-69', 'Overground', 'O1', 'Available'),
(451, 'O1-70', 'Overground', 'O1', 'Available'),
(452, 'O1-71', 'Overground', 'O1', 'Available'),
(453, 'O1-72', 'Overground', 'O1', 'Available'),
(454, 'O1-73', 'Overground', 'O1', 'Available'),
(455, 'O1-74', 'Overground', 'O1', 'Available'),
(456, 'O1-75', 'Overground', 'O1', 'Available'),
(457, 'O1-76', 'Overground', 'O1', 'Available'),
(458, 'O1-77', 'Overground', 'O1', 'Available'),
(459, 'O1-78', 'Overground', 'O1', 'Available'),
(460, 'O1-79', 'Overground', 'O1', 'Available'),
(461, 'O1-80', 'Overground', 'O1', 'Available'),
(462, 'O1-81', 'Overground', 'O1', 'Available'),
(463, 'O1-82', 'Overground', 'O1', 'Available'),
(464, 'O1-83', 'Overground', 'O1', 'Available'),
(465, 'O1-84', 'Overground', 'O1', 'Available'),
(466, 'O1-85', 'Overground', 'O1', 'Available'),
(467, 'O1-86', 'Overground', 'O1', 'Available'),
(468, 'O1-87', 'Overground', 'O1', 'Available'),
(469, 'O1-88', 'Overground', 'O1', 'Available'),
(470, 'O1-89', 'Overground', 'O1', 'Available'),
(471, 'O1-90', 'Overground', 'O1', 'Available'),
(472, 'O1-91', 'Overground', 'O1', 'Available'),
(473, 'O1-92', 'Overground', 'O1', 'Available'),
(474, 'O1-93', 'Overground', 'O1', 'Available'),
(475, 'O1-94', 'Overground', 'O1', 'Available'),
(476, 'O1-95', 'Overground', 'O1', 'Available'),
(477, 'O1-96', 'Overground', 'O1', 'Available'),
(478, 'O1-97', 'Overground', 'O1', 'Available'),
(479, 'O1-98', 'Overground', 'O1', 'Available'),
(480, 'O1-99', 'Overground', 'O1', 'Available'),
(481, 'O1-100', 'Overground', 'O1', 'Available'),
(509, 'O2-1', 'Overground', 'O2', 'Available'),
(510, 'O2-2', 'Overground', 'O2', 'Available'),
(511, 'O2-3', 'Overground', 'O2', 'Available'),
(512, 'O2-4', 'Overground', 'O2', 'Available'),
(513, 'O2-5', 'Overground', 'O2', 'Available'),
(514, 'O2-6', 'Overground', 'O2', 'Available'),
(515, 'O2-7', 'Overground', 'O2', 'Available'),
(516, 'O2-8', 'Overground', 'O2', 'Available'),
(517, 'O2-9', 'Overground', 'O2', 'Available'),
(518, 'O2-10', 'Overground', 'O2', 'Available'),
(519, 'O2-11', 'Overground', 'O2', 'Available'),
(520, 'O2-12', 'Overground', 'O2', 'Available'),
(521, 'O2-13', 'Overground', 'O2', 'Available'),
(522, 'O2-14', 'Overground', 'O2', 'Available'),
(523, 'O2-15', 'Overground', 'O2', 'Available'),
(524, 'O2-16', 'Overground', 'O2', 'Available'),
(525, 'O2-17', 'Overground', 'O2', 'Available'),
(526, 'O2-18', 'Overground', 'O2', 'Available'),
(527, 'O2-19', 'Overground', 'O2', 'Available'),
(528, 'O2-20', 'Overground', 'O2', 'Available'),
(529, 'O2-21', 'Overground', 'O2', 'Available'),
(530, 'O2-22', 'Overground', 'O2', 'Available'),
(531, 'O2-23', 'Overground', 'O2', 'Available'),
(532, 'O2-24', 'Overground', 'O2', 'Available'),
(533, 'O2-25', 'Overground', 'O2', 'Available'),
(534, 'O2-26', 'Overground', 'O2', 'Available'),
(535, 'O2-27', 'Overground', 'O2', 'Available'),
(536, 'O2-28', 'Overground', 'O2', 'Available'),
(537, 'O2-29', 'Overground', 'O2', 'Available'),
(538, 'O2-30', 'Overground', 'O2', 'Available'),
(539, 'O2-31', 'Overground', 'O2', 'Available'),
(540, 'O2-32', 'Overground', 'O2', 'Available'),
(541, 'O2-33', 'Overground', 'O2', 'Available'),
(542, 'O2-34', 'Overground', 'O2', 'Available'),
(543, 'O2-35', 'Overground', 'O2', 'Available'),
(544, 'O2-36', 'Overground', 'O2', 'Available'),
(545, 'O2-37', 'Overground', 'O2', 'Available'),
(546, 'O2-38', 'Overground', 'O2', 'Available'),
(547, 'O2-39', 'Overground', 'O2', 'Available'),
(548, 'O2-40', 'Overground', 'O2', 'Available'),
(549, 'O2-41', 'Overground', 'O2', 'Available'),
(550, 'O2-42', 'Overground', 'O2', 'Available'),
(551, 'O2-43', 'Overground', 'O2', 'Available'),
(552, 'O2-44', 'Overground', 'O2', 'Available'),
(553, 'O2-45', 'Overground', 'O2', 'Available'),
(554, 'O2-46', 'Overground', 'O2', 'Available'),
(555, 'O2-47', 'Overground', 'O2', 'Available'),
(556, 'O2-48', 'Overground', 'O2', 'Available'),
(557, 'O2-49', 'Overground', 'O2', 'Available'),
(558, 'O2-50', 'Overground', 'O2', 'Available'),
(559, 'O2-51', 'Overground', 'O2', 'Available'),
(560, 'O2-52', 'Overground', 'O2', 'Available'),
(561, 'O2-53', 'Overground', 'O2', 'Available'),
(562, 'O2-54', 'Overground', 'O2', 'Available'),
(563, 'O2-55', 'Overground', 'O2', 'Available'),
(564, 'O2-56', 'Overground', 'O2', 'Available'),
(565, 'O2-57', 'Overground', 'O2', 'Available'),
(566, 'O2-58', 'Overground', 'O2', 'Available'),
(567, 'O2-59', 'Overground', 'O2', 'Available'),
(568, 'O2-60', 'Overground', 'O2', 'Available'),
(569, 'O2-61', 'Overground', 'O2', 'Available'),
(570, 'O2-62', 'Overground', 'O2', 'Available'),
(571, 'O2-63', 'Overground', 'O2', 'Available'),
(572, 'O2-64', 'Overground', 'O2', 'Available'),
(573, 'O2-65', 'Overground', 'O2', 'Available'),
(574, 'O2-66', 'Overground', 'O2', 'Available'),
(575, 'O2-67', 'Overground', 'O2', 'Available'),
(576, 'O2-68', 'Overground', 'O2', 'Available'),
(577, 'O2-69', 'Overground', 'O2', 'Available'),
(578, 'O2-70', 'Overground', 'O2', 'Available'),
(579, 'O2-71', 'Overground', 'O2', 'Available'),
(580, 'O2-72', 'Overground', 'O2', 'Available'),
(581, 'O2-73', 'Overground', 'O2', 'Available'),
(582, 'O2-74', 'Overground', 'O2', 'Available'),
(583, 'O2-75', 'Overground', 'O2', 'Available'),
(584, 'O2-76', 'Overground', 'O2', 'Available'),
(585, 'O2-77', 'Overground', 'O2', 'Available'),
(586, 'O2-78', 'Overground', 'O2', 'Available'),
(587, 'O2-79', 'Overground', 'O2', 'Available'),
(588, 'O2-80', 'Overground', 'O2', 'Available'),
(589, 'O2-81', 'Overground', 'O2', 'Available'),
(590, 'O2-82', 'Overground', 'O2', 'Available'),
(591, 'O2-83', 'Overground', 'O2', 'Available'),
(592, 'O2-84', 'Overground', 'O2', 'Available'),
(593, 'O2-85', 'Overground', 'O2', 'Available'),
(594, 'O2-86', 'Overground', 'O2', 'Available'),
(595, 'O2-87', 'Overground', 'O2', 'Available'),
(596, 'O2-88', 'Overground', 'O2', 'Available'),
(597, 'O2-89', 'Overground', 'O2', 'Available'),
(598, 'O2-90', 'Overground', 'O2', 'Available'),
(599, 'O2-91', 'Overground', 'O2', 'Available'),
(600, 'O2-92', 'Overground', 'O2', 'Available'),
(601, 'O2-93', 'Overground', 'O2', 'Available'),
(602, 'O2-94', 'Overground', 'O2', 'Available'),
(603, 'O2-95', 'Overground', 'O2', 'Available'),
(604, 'O2-96', 'Overground', 'O2', 'Available'),
(605, 'O2-97', 'Overground', 'O2', 'Available'),
(606, 'O2-98', 'Overground', 'O2', 'Available'),
(607, 'O2-99', 'Overground', 'O2', 'Available'),
(608, 'O2-100', 'Overground', 'O2', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `license_plate` varchar(20) NOT NULL,
  `spot_id` varchar(10) NOT NULL,
  `booking_id` int NOT NULL,
  `duration_hours` int NOT NULL,
  `total_fee` decimal(10,2) NOT NULL,
  `payment_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `spot_id` (`spot_id`),
  KEY `booking_id` (`booking_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `username`, `license_plate`, `spot_id`, `booking_id`, `duration_hours`, `total_fee`, `payment_time`) VALUES
(1, 'yanyihan', '88888', 'U1-1', 1, 407, 2035.00, '2025-05-10 11:22:09'),
(2, NULL, '11111', 'U1-1', 2, 4, 20.00, '2025-05-10 11:22:41'),
(3, 'yanyihan', '88888', 'U3-1', 3, 2, 10.00, '2025-05-10 12:48:58'),
(4, 'yanyihan', '88888', 'O2-1', 4, 116, 580.00, '2025-05-10 12:50:00'),
(5, NULL, '56789', 'U1-1', 5, 4, 20.00, '2025-05-10 12:50:20'),
(6, NULL, '77777', 'U1-1', 6, 2, 10.00, '2025-05-10 12:50:35'),
(7, NULL, '23456', 'U1-1', 7, 5, 25.00, '2025-05-10 12:50:42');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `license_plate` varchar(20) NOT NULL,
  `is_member` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `full_name`, `phone`, `license_plate`, `is_member`, `created_at`) VALUES
(1, 'yanyihan', '$2y$10$35gNcYlJowT98jAoUyIIYOT8ubnCXmTzsEqHpM7atIAuchzAKGgmi', 'yanyihan@kean.edu', 'yanyihan', '18057260560', '88888', 1, '2025-05-10 11:21:36'),
(2, 'Faye', '$2y$10$IjFyGB89W/rlhIp7vlvXk.4UCH.P3As/guep.nEJyT3ILxmIa.G7C', 'abc@12.com', 'Faye Chen', '1234567', 'A34D21', 1, '2025-05-10 12:43:38'),
(3, 'Liiscc', '$2y$10$o5aZVW8y9iiHXs5hKFQjl.yJtZ1mWrbx4svtfCCQF7tKpp1W2uYBW', 'Liisc@11.com', 'Lim', '14354657', 'Wt232d', 1, '2025-05-10 12:44:44'),
(4, 'Sed', '$2y$10$MzMOKO0NNkHspy4Vx.aVgOBvjxcVD6hd1V2YHjw0.ON/wFtigXImu', 'Sedd@ajd.com', 'Sed', '2454545', 'HE22', 1, '2025-05-10 12:47:03');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE SET NULL,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`spot_id`) REFERENCES `parking_spots` (`spot_id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE SET NULL,
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`spot_id`) REFERENCES `parking_spots` (`spot_id`),
  ADD CONSTRAINT `payments_ibfk_3` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
