-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 04, 2025 at 12:56 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kopi_papa_web`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `email`, `password`, `created_at`) VALUES
(1, 'Admin1', 'Admin1@email.com', '1234', '2024-12-24 00:32:50'),
(2, 'admin2', 'admin2@email.com', '12345', '2024-12-24 00:33:47'),
(3, 'admin3', 'admin3@email.com', '12345', '2024-12-24 00:33:59');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `variant` enum('Hot','Iced') NOT NULL,
  `size` enum('Regular','Large') NOT NULL,
  `sugar` enum('Normal','Less') NOT NULL,
  `ice` enum('Normal','Less') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('pending','completed','cancelled') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `member_id`, `product_id`, `quantity`, `price`, `variant`, `size`, `sugar`, `ice`, `created_at`, `updated_at`, `status`) VALUES
(1, 1, 1, 2, 4.80, '', 'Regular', 'Normal', 'Normal', '2024-12-30 07:54:04', '2024-12-30 07:55:27', 'completed'),
(2, 1, 6, 1, 7.80, '', 'Large', 'Less', 'Normal', '2024-12-30 07:54:04', '2024-12-30 07:55:27', 'completed'),
(12, 9, 7, 2, 4.80, 'Hot', 'Regular', 'Normal', '', '2024-12-31 03:15:59', '2025-01-01 18:52:48', 'completed'),
(13, 9, 5, 1, 4.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-31 03:16:21', '2025-01-01 18:52:48', 'completed'),
(14, 9, 3, 2, 4.80, 'Hot', 'Regular', 'Normal', '', '2024-12-31 03:33:29', '2025-01-01 18:52:48', 'completed'),
(20, 9, 13, 2, 10.80, '', '', '', '', '2024-12-31 09:45:44', '2025-01-01 18:52:48', 'completed'),
(21, 9, 14, 2, 3.80, '', '', '', '', '2025-01-01 08:31:13', '2025-01-01 18:52:48', 'completed'),
(38, 9, 1, 1, 4.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 06:44:45', '2025-01-03 06:45:07', 'completed'),
(39, 9, 17, 1, 12.00, 'Hot', 'Regular', 'Normal', '', '2025-01-03 06:49:46', '2025-01-03 06:50:00', 'completed'),
(40, 9, 1, 1, 4.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 06:58:31', '2025-01-03 06:58:45', 'completed'),
(41, 4, 2, 1, 9.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 08:07:35', '2025-01-03 08:07:51', 'completed'),
(42, 4, 4, 1, 6.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 08:07:37', '2025-01-03 08:07:51', 'completed'),
(43, 4, 2, 1, 9.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 08:14:10', '2025-01-03 08:14:21', 'completed'),
(44, 4, 3, 1, 6.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 08:14:12', '2025-01-03 08:14:21', 'completed'),
(45, 4, 2, 1, 9.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 08:20:51', '2025-01-03 08:21:01', 'completed'),
(46, 4, 4, 1, 6.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 08:20:53', '2025-01-03 08:21:01', 'completed'),
(47, 4, 2, 1, 9.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 08:22:33', '2025-01-03 08:22:41', 'completed'),
(48, 4, 1, 1, 4.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 08:26:34', '2025-01-03 08:26:43', 'completed'),
(49, 4, 2, 1, 9.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 08:27:20', '2025-01-03 08:27:30', 'completed'),
(50, 4, 2, 1, 9.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 15:07:29', '2025-01-03 15:14:16', 'completed'),
(51, 4, 7, 1, 5.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 15:07:31', '2025-01-03 15:14:16', 'completed'),
(52, 4, 8, 1, 4.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 15:14:45', '2025-01-03 15:14:56', 'completed'),
(53, 4, 7, 1, 5.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 15:14:46', '2025-01-03 15:14:56', 'completed'),
(54, 6, 2, 1, 9.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 15:46:57', '2025-01-03 15:47:14', 'completed'),
(55, 6, 4, 1, 6.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 15:46:59', '2025-01-03 15:47:14', 'completed'),
(56, 6, 1, 1, 4.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 15:47:01', '2025-01-03 15:47:14', 'completed'),
(57, 4, 7, 1, 5.80, 'Hot', 'Regular', 'Normal', '', '2025-01-03 15:56:05', '2025-01-04 06:07:14', 'completed'),
(58, 4, 4, 1, 6.80, 'Hot', 'Regular', 'Normal', '', '2025-01-04 06:07:39', '2025-01-04 06:08:08', 'completed'),
(59, 4, 3, 1, 6.80, 'Iced', 'Regular', 'Normal', 'Less', '2025-01-04 06:07:42', '2025-01-04 06:08:08', 'completed'),
(60, 4, 3, 1, 8.80, 'Iced', 'Large', 'Normal', 'Normal', '2025-01-04 06:07:51', '2025-01-04 06:08:08', 'completed'),
(61, 4, 1, 1, 4.80, 'Hot', 'Regular', 'Normal', '', '2025-01-04 06:30:57', '2025-01-04 06:31:19', 'completed'),
(62, 4, 2, 1, 9.80, 'Hot', 'Regular', 'Normal', '', '2025-01-04 06:30:59', '2025-01-04 06:31:19', 'completed'),
(63, 4, 3, 1, 6.80, 'Hot', 'Regular', 'Normal', '', '2025-01-04 06:31:00', '2025-01-04 06:31:19', 'completed'),
(64, 4, 4, 1, 6.80, 'Hot', 'Regular', 'Normal', '', '2025-01-04 06:31:02', '2025-01-04 06:31:19', 'completed'),
(65, 4, 5, 1, 6.80, 'Hot', 'Regular', 'Normal', '', '2025-01-04 06:31:04', '2025-01-04 06:31:19', 'completed'),
(66, 4, 6, 1, 7.80, 'Hot', 'Regular', 'Normal', '', '2025-01-04 06:31:06', '2025-01-04 06:31:19', 'completed'),
(67, 3, 2, 2, 9.80, 'Hot', 'Regular', 'Normal', '', '2024-11-20 01:14:22', '2024-11-20 01:15:22', 'completed'),
(68, 3, 8, 1, 4.80, 'Hot', 'Regular', 'Normal', '', '2024-11-20 01:14:30', '2024-11-20 01:15:22', 'completed'),
(69, 3, 14, 1, 3.80, '', '', '', '', '2024-11-20 01:14:45', '2024-11-20 01:15:22', 'completed'),
(70, 5, 1, 2, 4.80, 'Hot', 'Regular', 'Less', '', '2024-11-20 06:29:30', '2024-11-20 06:30:45', 'completed'),
(71, 5, 7, 1, 5.80, 'Hot', 'Regular', 'Normal', '', '2024-11-20 06:29:55', '2024-11-20 06:30:45', 'completed'),
(72, 5, 15, 1, 2.80, '', '', '', '', '2024-11-20 06:30:15', '2024-11-20 06:30:45', 'completed'),
(73, 7, 3, 2, 6.80, 'Iced', 'Large', 'Normal', 'Less', '2024-11-21 02:19:22', '2024-11-21 02:20:33', 'completed'),
(74, 7, 13, 1, 10.80, '', '', '', '', '2024-11-21 02:19:45', '2024-11-21 02:20:33', 'completed'),
(75, 2, 6, 2, 7.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-11-21 08:44:12', '2024-11-21 08:45:12', 'completed'),
(76, 2, 9, 1, 6.80, 'Hot', 'Regular', 'Less', '', '2024-11-21 08:44:25', '2024-11-21 08:45:12', 'completed'),
(77, 2, 8, 1, 4.80, 'Hot', 'Regular', 'Normal', '', '2024-11-21 08:44:38', '2024-11-21 08:45:12', 'completed'),
(78, 2, 14, 1, 3.80, '', '', '', '', '2024-11-21 08:44:50', '2024-11-21 08:45:12', 'completed'),
(79, 9, 5, 2, 6.80, 'Iced', 'Large', 'Less', 'Normal', '2024-11-24 01:24:15', '2024-11-24 01:25:33', 'completed'),
(80, 9, 10, 1, 6.80, 'Iced', 'Regular', 'Normal', 'Less', '2024-11-24 01:24:45', '2024-11-24 01:25:33', 'completed'),
(81, 9, 16, 2, 3.80, '', '', '', '', '2024-11-24 01:25:00', '2024-11-24 01:25:33', 'completed'),
(82, 3, 2, 2, 9.80, 'Hot', 'Regular', 'Normal', '', '2024-11-24 06:14:30', '2024-11-24 06:15:45', 'completed'),
(83, 3, 11, 1, 5.80, 'Iced', 'Large', 'Less', 'Normal', '2024-11-24 06:14:55', '2024-11-24 06:15:45', 'completed'),
(84, 3, 13, 1, 10.80, '', '', '', '', '2024-11-24 06:15:20', '2024-11-24 06:15:45', 'completed'),
(85, 5, 4, 2, 6.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-11-25 02:39:15', '2024-11-25 02:40:22', 'completed'),
(86, 5, 8, 1, 4.80, 'Hot', 'Large', 'Less', '', '2024-11-25 02:39:35', '2024-11-25 02:40:22', 'completed'),
(87, 5, 15, 2, 2.80, '', '', '', '', '2024-11-25 02:39:55', '2024-11-25 02:40:22', 'completed'),
(88, 2, 6, 2, 7.80, 'Iced', 'Regular', 'Less', 'Less', '2024-11-25 08:29:20', '2024-11-25 08:30:15', 'completed'),
(89, 2, 12, 1, 6.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-11-25 08:29:40', '2024-11-25 08:30:15', 'completed'),
(90, 2, 14, 2, 3.80, '', '', '', '', '2024-11-25 08:29:55', '2024-11-25 08:30:15', 'completed'),
(91, 8, 3, 2, 6.80, 'Iced', 'Large', 'Normal', 'Less', '2024-11-29 00:44:15', '2024-11-29 00:45:22', 'completed'),
(92, 8, 9, 1, 6.80, 'Hot', 'Regular', 'Less', '', '2024-11-29 00:44:35', '2024-11-29 00:45:22', 'completed'),
(93, 8, 13, 1, 10.80, '', '', '', '', '2024-11-29 00:44:55', '2024-11-29 00:45:22', 'completed'),
(94, 2, 1, 2, 4.80, 'Hot', 'Regular', 'Normal', '', '2024-11-29 05:19:30', '2024-11-29 05:20:45', 'completed'),
(95, 2, 10, 1, 6.80, 'Iced', 'Regular', 'Less', 'Normal', '2024-11-29 05:19:55', '2024-11-29 05:20:45', 'completed'),
(96, 2, 14, 2, 3.80, '', '', '', '', '2024-11-29 05:20:20', '2024-11-29 05:20:45', 'completed'),
(97, 5, 2, 2, 9.80, 'Hot', 'Large', 'Normal', '', '2024-11-29 08:54:25', '2024-11-29 08:55:33', 'completed'),
(98, 5, 11, 1, 5.80, 'Iced', 'Regular', 'Normal', 'Less', '2024-11-29 08:54:45', '2024-11-29 08:55:33', 'completed'),
(99, 5, 15, 3, 2.80, '', '', '', '', '2024-11-29 08:55:05', '2024-11-29 08:55:33', 'completed'),
(100, 3, 6, 2, 7.80, 'Iced', 'Regular', 'Less', 'Normal', '2024-11-30 01:29:20', '2024-11-30 01:30:15', 'completed'),
(101, 3, 8, 1, 4.80, 'Hot', 'Large', 'Normal', '', '2024-11-30 01:29:40', '2024-11-30 01:30:15', 'completed'),
(102, 3, 14, 2, 3.80, '', '', '', '', '2024-11-30 01:29:55', '2024-11-30 01:30:15', 'completed'),
(103, 6, 2, 2, 9.80, 'Hot', 'Regular', 'Normal', '', '2024-12-02 01:19:20', '2024-12-02 01:20:33', 'completed'),
(104, 6, 8, 1, 4.80, 'Hot', 'Large', 'Less', '', '2024-12-02 01:19:45', '2024-12-02 01:20:33', 'completed'),
(105, 6, 15, 3, 2.80, '', '', '', '', '2024-12-02 01:20:05', '2024-12-02 01:20:33', 'completed'),
(106, 3, 4, 2, 6.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-02 06:44:15', '2024-12-02 06:45:15', 'completed'),
(107, 3, 10, 1, 6.80, 'Iced', 'Regular', 'Less', 'Less', '2024-12-02 06:44:35', '2024-12-02 06:45:15', 'completed'),
(108, 3, 14, 2, 3.80, '', '', '', '', '2024-12-02 06:44:55', '2024-12-02 06:45:15', 'completed'),
(109, 8, 2, 1, 9.80, 'Hot', 'Large', 'Normal', '', '2024-12-03 02:29:30', '2024-12-03 02:30:48', 'completed'),
(110, 8, 3, 2, 6.80, 'Iced', 'Regular', 'Less', 'Normal', '2024-12-03 02:29:55', '2024-12-03 02:30:48', 'completed'),
(111, 8, 13, 1, 10.80, '', '', '', '', '2024-12-03 02:30:20', '2024-12-03 02:30:48', 'completed'),
(112, 2, 6, 2, 7.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-03 07:54:15', '2024-12-03 07:55:22', 'completed'),
(113, 2, 9, 1, 6.80, 'Hot', 'Regular', 'Less', '', '2024-12-03 07:54:35', '2024-12-03 07:55:22', 'completed'),
(114, 2, 16, 2, 3.80, '', '', '', '', '2024-12-03 07:54:55', '2024-12-03 07:55:22', 'completed'),
(115, 3, 4, 2, 6.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-07 01:39:15', '2024-12-07 01:40:22', 'completed'),
(116, 3, 11, 1, 5.80, 'Iced', 'Large', 'Less', 'Normal', '2024-12-07 01:39:35', '2024-12-07 01:40:22', 'completed'),
(117, 3, 13, 1, 10.80, '', '', '', '', '2024-12-07 01:39:55', '2024-12-07 01:40:22', 'completed'),
(118, 7, 2, 2, 9.80, 'Hot', 'Regular', 'Normal', '', '2024-12-07 06:24:30', '2024-12-07 06:25:45', 'completed'),
(119, 7, 8, 1, 4.80, 'Hot', 'Large', 'Less', '', '2024-12-07 06:24:55', '2024-12-07 06:25:45', 'completed'),
(120, 7, 15, 3, 2.80, '', '', '', '', '2024-12-07 06:25:20', '2024-12-07 06:25:45', 'completed'),
(121, 2, 6, 2, 7.80, 'Iced', 'Regular', 'Normal', 'Less', '2024-12-08 02:14:15', '2024-12-08 02:15:33', 'completed'),
(122, 2, 10, 1, 6.80, 'Iced', 'Regular', 'Less', 'Normal', '2024-12-08 02:14:45', '2024-12-08 02:15:33', 'completed'),
(123, 2, 14, 2, 3.80, '', '', '', '', '2024-12-08 02:15:05', '2024-12-08 02:15:33', 'completed'),
(124, 5, 2, 1, 9.80, 'Hot', 'Large', 'Normal', '', '2024-12-08 07:49:20', '2024-12-08 07:50:15', 'completed'),
(125, 5, 3, 2, 6.80, 'Iced', 'Regular', 'Less', 'Normal', '2024-12-08 07:49:40', '2024-12-08 07:50:15', 'completed'),
(126, 5, 13, 1, 10.80, '', '', '', '', '2024-12-08 07:49:55', '2024-12-08 07:50:15', 'completed'),
(127, 9, 5, 2, 6.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-11 02:19:20', '2024-12-11 02:20:33', 'completed'),
(128, 9, 11, 1, 5.80, 'Iced', 'Regular', 'Less', 'Less', '2024-12-11 02:19:45', '2024-12-11 02:20:33', 'completed'),
(129, 9, 16, 3, 3.80, '', '', '', '', '2024-12-11 02:20:05', '2024-12-11 02:20:33', 'completed'),
(130, 2, 4, 2, 6.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-11 07:44:15', '2024-12-11 07:45:15', 'completed'),
(131, 2, 10, 1, 6.80, 'Iced', 'Regular', 'Less', 'Less', '2024-12-11 07:44:35', '2024-12-11 07:45:15', 'completed'),
(132, 2, 15, 3, 2.80, '', '', '', '', '2024-12-11 07:44:55', '2024-12-11 07:45:15', 'completed'),
(133, 7, 2, 2, 9.80, 'Hot', 'Large', 'Normal', '', '2024-12-12 03:29:30', '2024-12-12 03:30:48', 'completed'),
(134, 7, 8, 1, 4.80, 'Hot', 'Regular', 'Less', '', '2024-12-12 03:29:55', '2024-12-12 03:30:48', 'completed'),
(135, 7, 13, 1, 10.80, '', '', '', '', '2024-12-12 03:30:20', '2024-12-12 03:30:48', 'completed'),
(136, 4, 6, 2, 7.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-12 08:54:15', '2024-12-12 08:55:22', 'completed'),
(137, 4, 9, 1, 6.80, 'Hot', 'Regular', 'Less', '', '2024-12-12 08:54:35', '2024-12-12 08:55:22', 'completed'),
(138, 4, 14, 2, 3.80, '', '', '', '', '2024-12-12 08:54:55', '2024-12-12 08:55:22', 'completed'),
(139, 4, 2, 2, 9.80, 'Hot', 'Large', 'Normal', '', '2024-12-16 02:29:20', '2024-12-16 02:30:33', 'completed'),
(140, 4, 8, 1, 4.80, 'Hot', 'Regular', 'Less', '', '2024-12-16 02:29:45', '2024-12-16 02:30:33', 'completed'),
(141, 4, 15, 3, 2.80, '', '', '', '', '2024-12-16 02:30:05', '2024-12-16 02:30:33', 'completed'),
(142, 7, 4, 2, 6.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-16 07:44:15', '2024-12-16 07:45:15', 'completed'),
(143, 7, 11, 1, 5.80, 'Iced', 'Regular', 'Less', 'Less', '2024-12-16 07:44:35', '2024-12-16 07:45:15', 'completed'),
(144, 7, 14, 2, 3.80, '', '', '', '', '2024-12-16 07:44:55', '2024-12-16 07:45:15', 'completed'),
(145, 2, 6, 2, 7.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-17 03:19:30', '2024-12-17 03:20:48', 'completed'),
(146, 2, 3, 1, 6.80, 'Iced', 'Large', 'Less', 'Normal', '2024-12-17 03:19:55', '2024-12-17 03:20:48', 'completed'),
(147, 2, 13, 1, 10.80, '', '', '', '', '2024-12-17 03:20:20', '2024-12-17 03:20:48', 'completed'),
(148, 8, 5, 2, 6.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-17 08:34:15', '2024-12-17 08:35:22', 'completed'),
(149, 8, 10, 1, 6.80, 'Iced', 'Regular', 'Less', 'Less', '2024-12-17 08:34:35', '2024-12-17 08:35:22', 'completed'),
(150, 8, 16, 3, 3.80, '', '', '', '', '2024-12-17 08:34:55', '2024-12-17 08:35:22', 'completed'),
(151, 7, 2, 2, 9.80, 'Hot', 'Regular', 'Normal', '', '2024-12-21 02:14:20', '2024-12-21 02:15:33', 'completed'),
(152, 7, 3, 1, 6.80, 'Iced', 'Regular', 'Less', 'Normal', '2024-12-21 02:14:45', '2024-12-21 02:15:33', 'completed'),
(153, 7, 14, 2, 3.80, '', '', '', '', '2024-12-21 02:15:05', '2024-12-21 02:15:33', 'completed'),
(154, 2, 5, 2, 6.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-21 07:39:15', '2024-12-21 07:40:15', 'completed'),
(155, 2, 11, 1, 5.80, 'Iced', 'Regular', 'Less', 'Less', '2024-12-21 07:39:35', '2024-12-21 07:40:15', 'completed'),
(156, 2, 16, 3, 3.80, '', '', '', '', '2024-12-21 07:39:55', '2024-12-21 07:40:15', 'completed'),
(157, 5, 4, 2, 6.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-22 03:24:30', '2024-12-22 03:25:48', 'completed'),
(158, 5, 10, 1, 6.80, 'Iced', 'Large', 'Less', 'Normal', '2024-12-22 03:24:55', '2024-12-22 03:25:48', 'completed'),
(159, 5, 13, 1, 10.80, '', '', '', '', '2024-12-22 03:25:20', '2024-12-22 03:25:48', 'completed'),
(160, 8, 6, 2, 7.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-22 08:29:15', '2024-12-22 08:30:22', 'completed'),
(161, 8, 8, 1, 4.80, 'Hot', 'Regular', 'Less', '', '2024-12-22 08:29:35', '2024-12-22 08:30:22', 'completed'),
(162, 8, 15, 3, 2.80, '', '', '', '', '2024-12-22 08:29:55', '2024-12-22 08:30:22', 'completed'),
(163, 2, 4, 2, 6.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-26 02:24:20', '2024-12-26 02:25:33', 'completed'),
(164, 2, 11, 1, 5.80, 'Iced', 'Regular', 'Less', 'Less', '2024-12-26 02:24:45', '2024-12-26 02:25:33', 'completed'),
(165, 2, 13, 1, 10.80, '', '', '', '', '2024-12-26 02:25:05', '2024-12-26 02:25:33', 'completed'),
(166, 5, 2, 2, 9.80, 'Hot', 'Regular', 'Normal', '', '2024-12-26 07:49:15', '2024-12-26 07:50:15', 'completed'),
(167, 5, 8, 1, 4.80, 'Hot', 'Regular', 'Less', '', '2024-12-26 07:49:35', '2024-12-26 07:50:15', 'completed'),
(168, 5, 14, 2, 3.80, '', '', '', '', '2024-12-26 07:49:55', '2024-12-26 07:50:15', 'completed'),
(169, 8, 6, 2, 7.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-27 03:14:30', '2024-12-27 03:15:48', 'completed'),
(170, 8, 3, 1, 6.80, 'Iced', 'Large', 'Less', 'Normal', '2024-12-27 03:14:55', '2024-12-27 03:15:48', 'completed'),
(171, 8, 13, 1, 10.80, '', '', '', '', '2024-12-27 03:15:20', '2024-12-27 03:15:48', 'completed'),
(172, 3, 5, 2, 6.80, 'Iced', 'Regular', 'Normal', 'Normal', '2024-12-27 08:39:15', '2024-12-27 08:40:22', 'completed'),
(173, 3, 10, 1, 6.80, 'Iced', 'Regular', 'Less', 'Less', '2024-12-27 08:39:35', '2024-12-27 08:40:22', 'completed'),
(174, 3, 16, 3, 3.80, '', '', '', '', '2024-12-27 08:39:55', '2024-12-27 08:40:22', 'completed');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 'member1', 'member1@email.com', '123456', '2024-12-24 00:34:23', '2025-01-03 06:19:19'),
(2, 'member2', 'member2@email.com', '12345', '2024-12-24 00:34:35', '2025-01-03 05:16:41'),
(3, 'member3', 'member3@email.com', '12345', '2024-12-24 00:34:44', '2024-12-24 00:34:44'),
(4, 'abc', 'abc@email.com', 'ABCabc123!', '2024-12-26 23:14:35', '2024-12-26 23:14:35'),
(5, 'bcd', 'bcd@email.com', 'BCDbcd123!', '2024-12-28 22:56:01', '2025-01-03 05:16:24'),
(6, 'cde', 'cde@email.com', 'CDEcde123!', '2024-12-28 23:01:36', '2024-12-28 23:01:36'),
(7, 'qihuan', 'qihuanlim2002@gmail.com', 'Qihuan2002!', '2024-12-29 00:33:46', '2024-12-29 00:33:46'),
(8, 'kopipapa', 'kopipapaweb@gmail.com', 'New123!', '2024-12-29 00:43:31', '2024-12-29 06:10:30'),
(9, 'kaijian', 'kjchung007@gmail.com', '123@Aa', '2024-12-29 00:45:31', '2024-12-31 18:08:23'),
(10, 'ruijie', 'tenruijie@gmail.com', 'Ruijie123!', '2024-12-29 00:52:24', '2024-12-29 00:52:24');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('completed','pending','cancelled') DEFAULT 'completed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `member_id`, `order_date`, `total_amount`, `status`) VALUES
(3, 4, '2025-01-03 15:14:16', 15.60, 'completed'),
(4, 4, '2025-01-03 15:14:56', 10.60, 'completed'),
(5, 6, '2025-01-03 15:47:14', 21.40, 'completed'),
(6, 1, '2024-12-02 06:20:05', 24.60, 'completed'),
(7, 2, '2024-12-03 08:25:33', 18.40, 'completed'),
(8, 3, '2024-12-05 10:30:19', 12.40, 'completed'),
(9, 4, '2024-12-10 03:35:01', 22.20, 'completed'),
(10, 5, '2024-12-12 02:52:43', 28.60, 'completed'),
(11, 6, '2024-12-15 12:40:09', 14.20, 'completed'),
(12, 7, '2024-12-18 06:10:50', 16.40, 'completed'),
(13, 8, '2024-12-22 05:56:23', 20.80, 'completed'),
(14, 9, '2024-12-25 04:50:00', 15.60, 'completed'),
(15, 1, '2025-01-01 01:15:22', 35.60, 'completed'),
(16, 2, '2025-01-02 03:45:12', 25.80, 'completed'),
(17, 3, '2025-01-02 07:22:03', 20.40, 'completed'),
(18, 4, '2025-01-02 10:25:01', 30.20, 'completed'),
(19, 5, '2025-01-03 02:40:59', 40.00, 'completed'),
(20, 6, '2025-01-03 06:55:10', 22.80, 'completed'),
(21, 4, '2025-01-04 06:07:14', 5.80, 'completed'),
(22, 4, '2025-01-04 06:08:08', 20.40, 'completed'),
(23, 4, '2025-01-04 06:31:19', 42.80, 'completed'),
(24, 3, '2024-11-20 01:15:22', 28.40, 'completed'),
(25, 5, '2024-11-20 06:30:45', 19.60, 'completed'),
(26, 7, '2024-11-21 02:20:33', 25.80, 'completed'),
(27, 2, '2024-11-21 08:45:12', 31.20, 'completed'),
(28, 4, '2024-11-22 00:30:55', 22.40, 'completed'),
(29, 1, '2024-11-22 05:25:18', 29.60, 'completed'),
(30, 6, '2024-11-23 03:10:42', 24.20, 'completed'),
(31, 8, '2024-11-23 07:55:30', 33.80, 'completed'),
(32, 9, '2024-11-24 01:25:33', 27.20, 'completed'),
(33, 3, '2024-11-24 06:15:45', 32.40, 'completed'),
(34, 5, '2024-11-25 02:40:22', 24.80, 'completed'),
(35, 2, '2024-11-25 08:30:15', 29.60, 'completed'),
(36, 7, '2024-11-26 03:20:48', 35.80, 'completed'),
(37, 4, '2024-11-26 07:45:30', 23.20, 'completed'),
(38, 1, '2024-11-27 01:35:12', 31.60, 'completed'),
(39, 6, '2024-11-27 05:50:25', 28.40, 'completed'),
(40, 8, '2024-11-29 00:45:22', 30.60, 'completed'),
(41, 2, '2024-11-29 05:20:45', 25.80, 'completed'),
(42, 5, '2024-11-29 08:55:33', 33.40, 'completed'),
(43, 3, '2024-11-30 01:30:15', 28.20, 'completed'),
(44, 7, '2024-11-30 06:25:48', 34.60, 'completed'),
(45, 1, '2024-11-30 09:40:30', 26.80, 'completed'),
(46, 4, '2024-12-01 02:15:12', 31.20, 'completed'),
(47, 9, '2024-12-01 07:35:25', 29.40, 'completed'),
(48, 6, '2024-12-02 01:20:33', 32.40, 'completed'),
(49, 3, '2024-12-02 06:45:15', 27.60, 'completed'),
(50, 8, '2024-12-03 02:30:48', 34.80, 'completed'),
(51, 2, '2024-12-03 07:55:22', 29.20, 'completed'),
(52, 5, '2024-12-04 03:25:45', 31.60, 'completed'),
(53, 7, '2024-12-04 08:40:30', 28.80, 'completed'),
(54, 1, '2024-12-05 01:15:12', 33.20, 'completed'),
(55, 4, '2024-12-05 06:35:25', 30.40, 'completed'),
(56, 9, '2024-12-06 02:50:33', 26.80, 'completed'),
(57, 6, '2024-12-06 07:20:45', 35.60, 'completed'),
(58, 3, '2024-12-07 01:40:22', 29.80, 'completed'),
(59, 7, '2024-12-07 06:25:45', 32.60, 'completed'),
(60, 2, '2024-12-08 02:15:33', 27.40, 'completed'),
(61, 5, '2024-12-08 07:50:15', 34.20, 'completed'),
(62, 1, '2024-12-09 03:30:48', 30.60, 'completed'),
(63, 8, '2024-12-09 08:20:30', 28.80, 'completed'),
(64, 4, '2024-12-10 01:55:12', 33.40, 'completed'),
(65, 6, '2024-12-10 06:40:25', 31.20, 'completed'),
(66, 9, '2024-12-11 02:20:33', 31.80, 'completed'),
(67, 2, '2024-12-11 07:45:15', 28.40, 'completed'),
(68, 7, '2024-12-12 03:30:48', 33.60, 'completed'),
(69, 4, '2024-12-12 08:55:22', 30.20, 'completed'),
(70, 8, '2024-12-13 01:25:45', 34.80, 'completed'),
(71, 1, '2024-12-13 06:40:30', 29.60, 'completed'),
(72, 5, '2024-12-14 02:15:12', 32.40, 'completed'),
(73, 3, '2024-12-14 07:35:25', 27.80, 'completed'),
(74, 6, '2024-12-15 03:50:33', 35.20, 'completed'),
(75, 9, '2024-12-15 08:20:45', 30.80, 'completed'),
(76, 4, '2024-12-16 02:30:33', 32.60, 'completed'),
(77, 7, '2024-12-16 07:45:15', 29.40, 'completed'),
(78, 2, '2024-12-17 03:20:48', 34.80, 'completed'),
(79, 8, '2024-12-17 08:35:22', 31.20, 'completed'),
(80, 5, '2024-12-18 01:45:45', 33.60, 'completed'),
(81, 1, '2024-12-18 06:50:30', 28.80, 'completed'),
(82, 9, '2024-12-19 02:25:12', 35.20, 'completed'),
(83, 3, '2024-12-19 07:40:25', 30.60, 'completed'),
(84, 6, '2024-12-20 03:15:33', 32.40, 'completed'),
(85, 4, '2024-12-20 08:30:45', 29.80, 'completed'),
(86, 7, '2024-12-21 02:15:33', 33.80, 'completed'),
(87, 2, '2024-12-21 07:40:15', 30.60, 'completed'),
(88, 5, '2024-12-22 03:25:48', 32.80, 'completed'),
(89, 8, '2024-12-22 08:30:22', 29.40, 'completed'),
(90, 1, '2024-12-23 01:50:45', 34.60, 'completed'),
(91, 4, '2024-12-23 06:45:30', 31.20, 'completed'),
(92, 6, '2024-12-24 02:30:12', 33.40, 'completed'),
(93, 9, '2024-12-24 07:35:25', 28.80, 'completed'),
(94, 3, '2024-12-25 03:20:33', 35.20, 'completed'),
(95, 7, '2024-12-25 08:25:45', 30.40, 'completed'),
(96, 2, '2024-12-26 02:25:33', 32.60, 'completed'),
(97, 5, '2024-12-26 07:50:15', 29.80, 'completed'),
(98, 8, '2024-12-27 03:15:48', 34.40, 'completed'),
(99, 3, '2024-12-27 08:40:22', 31.60, 'completed'),
(100, 6, '2024-12-28 01:55:45', 33.20, 'completed'),
(101, 9, '2024-12-28 06:30:30', 30.40, 'completed'),
(102, 4, '2024-12-29 02:45:12', 35.60, 'completed'),
(103, 7, '2024-12-29 07:20:25', 28.80, 'completed'),
(104, 1, '2024-12-30 03:35:33', 32.20, 'completed'),
(105, 5, '2024-12-30 08:15:45', 29.60, 'completed');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `item_total` decimal(10,2) NOT NULL,
  `variant` enum('hot','iced') DEFAULT NULL,
  `size` enum('Regular','Large') DEFAULT NULL,
  `sugar` enum('Normal','Less') DEFAULT NULL,
  `ice` enum('Normal','Less') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `product_name`, `quantity`, `unit_price`, `item_total`, `variant`, `size`, `sugar`, `ice`) VALUES
(1, 3, 2, 'PAPA SPANISH LATTE KAW', 1, 9.80, 9.80, 'hot', 'Regular', 'Normal', ''),
(2, 3, 7, 'KOPI TEH KAHWIN PING', 1, 5.80, 5.80, 'hot', 'Regular', 'Normal', ''),
(3, 4, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Regular', 'Normal', ''),
(4, 4, 7, 'KOPI TEH KAHWIN PING', 1, 5.80, 5.80, 'hot', 'Regular', 'Normal', ''),
(5, 5, 2, 'PAPA SPANISH LATTE KAW', 1, 9.80, 9.80, 'hot', 'Regular', 'Normal', ''),
(6, 5, 4, 'KOPI PING JELLY', 1, 6.80, 6.80, 'hot', 'Regular', 'Normal', ''),
(7, 5, 1, 'PAPA KOPI PING KAW', 1, 4.80, 4.80, 'hot', 'Regular', 'Normal', ''),
(8, 6, 1, 'PAPA KOPI PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Normal', ''),
(9, 6, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Large', 'Normal', 'Normal'),
(10, 6, 5, '3 LATER KOPI', 1, 6.80, 6.80, 'hot', 'Regular', 'Less', 'Normal'),
(11, 7, 2, 'PAPA SPANISH LATTE KAW', 1, 9.80, 9.80, 'hot', 'Regular', 'Normal', ''),
(12, 7, 6, 'ICE MOCHA', 1, 7.80, 7.80, 'iced', 'Regular', 'Less', 'Less'),
(13, 7, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Large', 'Normal', ''),
(14, 8, 7, 'KOPI TEH KAHWIN PING', 1, 5.80, 5.80, 'hot', 'Regular', 'Normal', ''),
(15, 8, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Normal'),
(16, 9, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, 'hot', 'Regular', 'Normal', ''),
(17, 9, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'hot', 'Regular', 'Less', 'Normal'),
(18, 9, 5, '3 LATER KOPI', 1, 6.80, 6.80, 'iced', 'Large', 'Normal', 'Less'),
(19, 10, 4, 'KOPI PING JELLY', 1, 6.80, 6.80, 'iced', 'Regular', 'Normal', 'Normal'),
(20, 10, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Regular', 'Less', 'Less'),
(21, 10, 9, '3 LAYER TEH', 1, 6.80, 6.80, 'iced', 'Regular', 'Normal', 'Normal'),
(22, 11, 12, 'ICE COCOA', 1, 6.80, 6.80, 'hot', 'Regular', 'Normal', ''),
(23, 11, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Normal'),
(24, 11, 1, 'PAPA KOPI PING KAW', 1, 4.80, 4.80, 'iced', 'Regular', 'Normal', ''),
(25, 12, 6, 'ICE MOCHA', 1, 7.80, 7.80, 'hot', 'Regular', 'Normal', 'Normal'),
(26, 12, 4, 'KOPI PING JELLY', 1, 6.80, 6.80, 'iced', 'Large', 'Normal', ''),
(27, 12, 9, '3 LAYER TEH', 1, 6.80, 6.80, 'hot', 'Regular', 'Normal', 'Less'),
(28, 13, 7, 'KOPI TEH KAHWIN PING', 1, 5.80, 5.80, 'hot', 'Regular', 'Normal', ''),
(29, 13, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, 'hot', 'Large', 'Normal', ''),
(30, 13, 5, '3 LATER KOPI', 1, 6.80, 6.80, 'iced', 'Regular', 'Normal', 'Less'),
(31, 14, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, 'hot', 'Regular', 'Normal', ''),
(32, 14, 2, 'PAPA SPANISH LATTE KAW', 1, 9.80, 9.80, 'iced', 'Large', 'Normal', ''),
(33, 14, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Regular', 'Normal', ''),
(34, 15, 1, 'PAPA KOPI PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Normal', ''),
(35, 15, 6, 'ICE MOCHA', 1, 7.80, 7.80, 'iced', 'Regular', 'Less', 'Less'),
(36, 15, 12, 'ICE COCOA', 1, 6.80, 6.80, 'hot', 'Regular', 'Less', 'Normal'),
(37, 15, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'iced', 'Large', 'Normal', 'Normal'),
(38, 16, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Large', 'Normal', 'Less'),
(39, 16, 5, '3 LATER KOPI', 1, 6.80, 6.80, 'hot', 'Regular', 'Less', 'Normal'),
(40, 16, 7, 'KOPI TEH KAHWIN PING', 1, 5.80, 5.80, 'iced', 'Regular', 'Normal', 'Normal'),
(41, 17, 9, '3 LAYER TEH', 2, 6.80, 13.60, 'hot', 'Regular', 'Normal', 'Less'),
(42, 17, 4, 'KOPI PING JELLY', 1, 6.80, 6.80, 'iced', 'Regular', 'Normal', ''),
(43, 17, 12, 'ICE COCOA', 1, 6.80, 6.80, 'hot', 'Large', 'Normal', 'Less'),
(44, 18, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Less'),
(45, 18, 8, 'TEH PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Normal', 'Normal'),
(46, 18, 6, 'ICE MOCHA', 1, 7.80, 7.80, 'iced', 'Regular', 'Normal', 'Normal'),
(47, 18, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'hot', 'Large', 'Less', 'Normal'),
(48, 19, 1, 'PAPA KOPI PING KAW', 3, 4.80, 14.40, 'hot', 'Regular', 'Normal', ''),
(49, 19, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', ''),
(50, 19, 9, '3 LAYER TEH', 1, 6.80, 6.80, 'iced', 'Large', 'Less', 'Normal'),
(51, 19, 5, '3 LATER KOPI', 1, 6.80, 6.80, 'hot', 'Regular', 'Normal', 'Less'),
(52, 20, 7, 'KOPI TEH KAHWIN PING', 2, 5.80, 11.60, 'hot', 'Regular', 'Normal', 'Normal'),
(53, 20, 12, 'ICE COCOA', 1, 6.80, 6.80, 'iced', 'Large', 'Normal', ''),
(54, 20, 14, 'CHICKEN SHAO PAU', 1, 3.80, 3.80, 'hot', 'Regular', 'Normal', ''),
(55, 20, 6, 'ICE MOCHA', 1, 7.80, 7.80, 'iced', 'Regular', 'Normal', 'Less'),
(56, 21, 7, 'KOPI TEH KAHWIN PING', 1, 5.80, 5.80, 'hot', 'Regular', 'Normal', ''),
(57, 22, 4, 'KOPI PING JELLY', 1, 6.80, 6.80, 'hot', 'Regular', 'Normal', ''),
(58, 22, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Regular', 'Normal', 'Less'),
(59, 22, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Large', 'Normal', 'Normal'),
(60, 23, 1, 'PAPA KOPI PING KAW', 1, 4.80, 4.80, 'hot', 'Regular', 'Normal', ''),
(61, 23, 2, 'PAPA SPANISH LATTE KAW', 1, 9.80, 9.80, 'hot', 'Regular', 'Normal', ''),
(62, 23, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'hot', 'Regular', 'Normal', ''),
(63, 23, 4, 'KOPI PING JELLY', 1, 6.80, 6.80, 'hot', 'Regular', 'Normal', ''),
(64, 23, 5, '3 LATER KOPI', 1, 6.80, 6.80, 'hot', 'Regular', 'Normal', ''),
(65, 23, 6, 'ICE MOCHA', 1, 7.80, 7.80, 'hot', 'Regular', 'Normal', ''),
(66, 24, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Regular', 'Normal', ''),
(67, 24, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Regular', 'Normal', ''),
(68, 24, 14, 'CHICKEN SHAO PAU', 1, 3.80, 3.80, '', '', '', ''),
(69, 25, 1, 'PAPA KOPI PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Less', ''),
(70, 25, 7, 'KOPI TEH KAHWIN PING', 1, 5.80, 5.80, 'hot', 'Regular', 'Normal', ''),
(71, 25, 15, 'PAPA EGG TART', 1, 2.80, 2.80, '', '', '', ''),
(72, 26, 3, 'PAPA STYLE AMERICANO', 2, 6.80, 13.60, 'iced', 'Large', 'Normal', 'Less'),
(73, 26, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(74, 27, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Normal', 'Normal'),
(75, 27, 9, '3 LAYER TEH', 1, 6.80, 6.80, 'hot', 'Regular', 'Less', ''),
(76, 27, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Regular', 'Normal', ''),
(77, 27, 14, 'CHICKEN SHAO PAU', 1, 3.80, 3.80, '', '', '', ''),
(78, 28, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(79, 28, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Large', 'Less', ''),
(80, 28, 15, 'PAPA EGG TART', 1, 2.80, 2.80, '', '', '', ''),
(81, 29, 2, 'PAPA SPANISH LATTE KAW', 1, 9.80, 9.80, 'hot', 'Regular', 'Normal', ''),
(82, 29, 5, '3 LATER KOPI', 2, 6.80, 13.60, 'iced', 'Regular', 'Less', 'Normal'),
(83, 29, 16, 'ROTI KIAP', 1, 3.80, 3.80, '', '', '', ''),
(84, 30, 10, 'HK JELLY MILK TEA', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(85, 30, 7, 'KOPI TEH KAHWIN PING', 1, 5.80, 5.80, 'hot', 'Regular', 'Less', ''),
(86, 30, 15, 'PAPA EGG TART', 1, 2.80, 2.80, '', '', '', ''),
(87, 31, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Large', 'Normal', ''),
(88, 31, 12, 'ICE COCOA', 1, 6.80, 6.80, 'iced', 'Regular', 'Normal', 'Less'),
(89, 31, 11, 'ICE LEMON TEA', 1, 5.80, 5.80, 'iced', 'Regular', 'Normal', 'Normal'),
(90, 32, 5, '3 LATER KOPI', 2, 6.80, 13.60, 'iced', 'Large', 'Less', 'Normal'),
(91, 32, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Normal', 'Less'),
(92, 32, 16, 'ROTI KIAP', 2, 3.80, 7.60, '', '', '', ''),
(93, 33, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Regular', 'Normal', ''),
(94, 33, 11, 'ICE LEMON TEA', 1, 5.80, 5.80, 'iced', 'Large', 'Less', 'Normal'),
(95, 33, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(96, 34, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(97, 34, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Large', 'Less', ''),
(98, 34, 15, 'PAPA EGG TART', 2, 2.80, 5.60, '', '', '', ''),
(99, 35, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Less', 'Less'),
(100, 35, 12, 'ICE COCOA', 1, 6.80, 6.80, 'iced', 'Regular', 'Normal', 'Normal'),
(101, 35, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(102, 36, 2, 'PAPA SPANISH LATTE KAW', 1, 9.80, 9.80, 'hot', 'Regular', 'Normal', ''),
(103, 36, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Large', 'Less', 'Normal'),
(104, 36, 9, '3 LAYER TEH', 1, 6.80, 6.80, 'hot', 'Regular', 'Normal', ''),
(105, 36, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(106, 37, 7, 'KOPI TEH KAHWIN PING', 2, 5.80, 11.60, 'hot', 'Regular', 'Normal', ''),
(107, 37, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Normal'),
(108, 37, 15, 'PAPA EGG TART', 2, 2.80, 5.60, '', '', '', ''),
(109, 38, 1, 'PAPA KOPI PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Less', ''),
(110, 38, 6, 'ICE MOCHA', 1, 7.80, 7.80, 'iced', 'Large', 'Normal', 'Normal'),
(111, 38, 11, 'ICE LEMON TEA', 2, 5.80, 11.60, 'iced', 'Regular', 'Normal', 'Less'),
(112, 38, 16, 'ROTI KIAP', 1, 3.80, 3.80, '', '', '', ''),
(113, 39, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'hot', 'Regular', 'Normal', ''),
(114, 39, 8, 'TEH PING KAW', 2, 4.80, 9.60, 'hot', 'Large', 'Less', ''),
(115, 39, 15, 'PAPA EGG TART', 2, 2.80, 5.60, '', '', '', ''),
(116, 40, 3, 'PAPA STYLE AMERICANO', 2, 6.80, 13.60, 'iced', 'Large', 'Normal', 'Less'),
(117, 40, 9, '3 LAYER TEH', 1, 6.80, 6.80, 'hot', 'Regular', 'Less', ''),
(118, 40, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(119, 41, 1, 'PAPA KOPI PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Normal', ''),
(120, 41, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Normal'),
(121, 41, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(122, 42, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Large', 'Normal', ''),
(123, 42, 11, 'ICE LEMON TEA', 1, 5.80, 5.80, 'iced', 'Regular', 'Normal', 'Less'),
(124, 42, 15, 'PAPA EGG TART', 3, 2.80, 8.40, '', '', '', ''),
(125, 43, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Less', 'Normal'),
(126, 43, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Large', 'Normal', ''),
(127, 43, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(128, 44, 2, 'PAPA SPANISH LATTE KAW', 1, 9.80, 9.80, 'hot', 'Regular', 'Normal', ''),
(129, 44, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Large', 'Less', 'Normal'),
(130, 44, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(131, 45, 7, 'KOPI TEH KAHWIN PING', 2, 5.80, 11.60, 'hot', 'Regular', 'Normal', ''),
(132, 45, 12, 'ICE COCOA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Less'),
(133, 45, 16, 'ROTI KIAP', 2, 3.80, 7.60, '', '', '', ''),
(134, 46, 5, '3 LATER KOPI', 2, 6.80, 13.60, 'iced', 'Large', 'Normal', 'Normal'),
(135, 46, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Normal'),
(136, 46, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(137, 47, 1, 'PAPA KOPI PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Normal', ''),
(138, 47, 6, 'ICE MOCHA', 1, 7.80, 7.80, 'iced', 'Large', 'Less', 'Normal'),
(139, 47, 15, 'PAPA EGG TART', 4, 2.80, 11.20, '', '', '', ''),
(140, 48, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Regular', 'Normal', ''),
(141, 48, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Large', 'Less', ''),
(142, 48, 15, 'PAPA EGG TART', 3, 2.80, 8.40, '', '', '', ''),
(143, 49, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(144, 49, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Less'),
(145, 49, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(146, 50, 2, 'PAPA SPANISH LATTE KAW', 1, 9.80, 9.80, 'hot', 'Large', 'Normal', ''),
(147, 50, 3, 'PAPA STYLE AMERICANO', 2, 6.80, 13.60, 'iced', 'Regular', 'Less', 'Normal'),
(148, 50, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(149, 51, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Normal', 'Normal'),
(150, 51, 9, '3 LAYER TEH', 1, 6.80, 6.80, 'hot', 'Regular', 'Less', ''),
(151, 51, 16, 'ROTI KIAP', 2, 3.80, 7.60, '', '', '', ''),
(152, 52, 1, 'PAPA KOPI PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Normal', ''),
(153, 52, 7, 'KOPI TEH KAHWIN PING', 2, 5.80, 11.60, 'hot', 'Large', 'Less', ''),
(154, 52, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(155, 53, 5, '3 LATER KOPI', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Less'),
(156, 53, 11, 'ICE LEMON TEA', 1, 5.80, 5.80, 'iced', 'Regular', 'Less', 'Normal'),
(157, 53, 15, 'PAPA EGG TART', 3, 2.80, 8.40, '', '', '', ''),
(158, 54, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Regular', 'Normal', ''),
(159, 54, 12, 'ICE COCOA', 1, 6.80, 6.80, 'iced', 'Large', 'Less', 'Normal'),
(160, 54, 16, 'ROTI KIAP', 2, 3.80, 7.60, '', '', '', ''),
(161, 55, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(162, 55, 8, 'TEH PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Less', ''),
(163, 55, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(164, 56, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Less', 'Less'),
(165, 56, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Normal', 'Normal'),
(166, 56, 15, 'PAPA EGG TART', 2, 2.80, 5.60, '', '', '', ''),
(167, 57, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Large', 'Normal', ''),
(168, 57, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Normal'),
(169, 57, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(170, 58, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(171, 58, 11, 'ICE LEMON TEA', 1, 5.80, 5.80, 'iced', 'Large', 'Less', 'Normal'),
(172, 58, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(173, 59, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Regular', 'Normal', ''),
(174, 59, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Large', 'Less', ''),
(175, 59, 15, 'PAPA EGG TART', 3, 2.80, 8.40, '', '', '', ''),
(176, 60, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Normal', 'Less'),
(177, 60, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Normal'),
(178, 60, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(179, 61, 2, 'PAPA SPANISH LATTE KAW', 1, 9.80, 9.80, 'hot', 'Large', 'Normal', ''),
(180, 61, 3, 'PAPA STYLE AMERICANO', 2, 6.80, 13.60, 'iced', 'Regular', 'Less', 'Normal'),
(181, 61, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(182, 62, 1, 'PAPA KOPI PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Normal', ''),
(183, 62, 7, 'KOPI TEH KAHWIN PING', 2, 5.80, 11.60, 'hot', 'Regular', 'Less', ''),
(184, 62, 16, 'ROTI KIAP', 2, 3.80, 7.60, '', '', '', ''),
(185, 63, 5, '3 LATER KOPI', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(186, 63, 12, 'ICE COCOA', 1, 6.80, 6.80, 'iced', 'Large', 'Less', 'Less'),
(187, 63, 15, 'PAPA EGG TART', 3, 2.80, 8.40, '', '', '', ''),
(188, 64, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Regular', 'Normal', ''),
(189, 64, 9, '3 LAYER TEH', 1, 6.80, 6.80, 'hot', 'Regular', 'Less', ''),
(190, 64, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(191, 65, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(192, 65, 8, 'TEH PING KAW', 2, 4.80, 9.60, 'hot', 'Large', 'Less', ''),
(193, 65, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(194, 66, 5, '3 LATER KOPI', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(195, 66, 11, 'ICE LEMON TEA', 1, 5.80, 5.80, 'iced', 'Regular', 'Less', 'Less'),
(196, 66, 16, 'ROTI KIAP', 3, 3.80, 11.40, '', '', '', ''),
(197, 67, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(198, 67, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Less'),
(199, 67, 15, 'PAPA EGG TART', 3, 2.80, 8.40, '', '', '', ''),
(200, 68, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Large', 'Normal', ''),
(201, 68, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Regular', 'Less', ''),
(202, 68, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(203, 69, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Normal', 'Normal'),
(204, 69, 9, '3 LAYER TEH', 1, 6.80, 6.80, 'hot', 'Regular', 'Less', ''),
(205, 69, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(206, 70, 2, 'PAPA SPANISH LATTE KAW', 1, 9.80, 9.80, 'hot', 'Large', 'Normal', ''),
(207, 70, 3, 'PAPA STYLE AMERICANO', 2, 6.80, 13.60, 'iced', 'Regular', 'Less', 'Normal'),
(208, 70, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(209, 71, 1, 'PAPA KOPI PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Normal', ''),
(210, 71, 7, 'KOPI TEH KAHWIN PING', 2, 5.80, 11.60, 'hot', 'Large', 'Less', ''),
(211, 71, 15, 'PAPA EGG TART', 3, 2.80, 8.40, '', '', '', ''),
(212, 72, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(213, 72, 12, 'ICE COCOA', 1, 6.80, 6.80, 'iced', 'Large', 'Less', 'Normal'),
(214, 72, 16, 'ROTI KIAP', 3, 3.80, 11.40, '', '', '', ''),
(215, 73, 5, '3 LATER KOPI', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Less'),
(216, 73, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Regular', 'Less', ''),
(217, 73, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(218, 74, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Regular', 'Normal', ''),
(219, 74, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Normal'),
(220, 74, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(221, 75, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Normal', 'Normal'),
(222, 75, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Less'),
(223, 75, 15, 'PAPA EGG TART', 3, 2.80, 8.40, '', '', '', ''),
(224, 76, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Large', 'Normal', ''),
(225, 76, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Regular', 'Less', ''),
(226, 76, 15, 'PAPA EGG TART', 3, 2.80, 8.40, '', '', '', ''),
(227, 77, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(228, 77, 11, 'ICE LEMON TEA', 1, 5.80, 5.80, 'iced', 'Regular', 'Less', 'Less'),
(229, 77, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(230, 78, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Normal', 'Normal'),
(231, 78, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Large', 'Less', 'Normal'),
(232, 78, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(233, 79, 5, '3 LATER KOPI', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(234, 79, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Less'),
(235, 79, 16, 'ROTI KIAP', 3, 3.80, 11.40, '', '', '', ''),
(236, 80, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Regular', 'Normal', ''),
(237, 80, 9, '3 LAYER TEH', 1, 6.80, 6.80, 'hot', 'Regular', 'Less', ''),
(238, 80, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(239, 81, 1, 'PAPA KOPI PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Normal', ''),
(240, 81, 7, 'KOPI TEH KAHWIN PING', 2, 5.80, 11.60, 'hot', 'Large', 'Less', ''),
(241, 81, 15, 'PAPA EGG TART', 3, 2.80, 8.40, '', '', '', ''),
(242, 82, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Large', 'Normal', ''),
(243, 82, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Normal'),
(244, 82, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(245, 83, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(246, 83, 12, 'ICE COCOA', 1, 6.80, 6.80, 'iced', 'Large', 'Less', 'Normal'),
(247, 83, 16, 'ROTI KIAP', 3, 3.80, 11.40, '', '', '', ''),
(248, 84, 5, '3 LATER KOPI', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Less'),
(249, 84, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Regular', 'Less', ''),
(250, 84, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(251, 85, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Normal', 'Normal'),
(252, 85, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Less'),
(253, 85, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(254, 86, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Regular', 'Normal', ''),
(255, 86, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Normal'),
(256, 86, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(257, 87, 5, '3 LATER KOPI', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(258, 87, 11, 'ICE LEMON TEA', 1, 5.80, 5.80, 'iced', 'Regular', 'Less', 'Less'),
(259, 87, 16, 'ROTI KIAP', 3, 3.80, 11.40, '', '', '', ''),
(260, 88, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(261, 88, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Large', 'Less', 'Normal'),
(262, 88, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(263, 89, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Normal', 'Normal'),
(264, 89, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Regular', 'Less', ''),
(265, 89, 15, 'PAPA EGG TART', 3, 2.80, 8.40, '', '', '', ''),
(266, 90, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Large', 'Normal', ''),
(267, 90, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Normal'),
(268, 90, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(269, 91, 1, 'PAPA KOPI PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Normal', ''),
(270, 91, 7, 'KOPI TEH KAHWIN PING', 2, 5.80, 11.60, 'hot', 'Large', 'Less', ''),
(271, 91, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(272, 92, 5, '3 LATER KOPI', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(273, 92, 12, 'ICE COCOA', 1, 6.80, 6.80, 'iced', 'Large', 'Less', 'Less'),
(274, 92, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(275, 93, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(276, 93, 9, '3 LAYER TEH', 1, 6.80, 6.80, 'hot', 'Regular', 'Less', ''),
(277, 93, 16, 'ROTI KIAP', 2, 3.80, 7.60, '', '', '', ''),
(278, 94, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Regular', 'Normal', ''),
(279, 94, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Normal'),
(280, 94, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(281, 95, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Normal', 'Normal'),
(282, 95, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Less'),
(283, 95, 15, 'PAPA EGG TART', 3, 2.80, 8.40, '', '', '', ''),
(284, 96, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(285, 96, 11, 'ICE LEMON TEA', 1, 5.80, 5.80, 'iced', 'Regular', 'Less', 'Less'),
(286, 96, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(287, 97, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Regular', 'Normal', ''),
(288, 97, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Regular', 'Less', ''),
(289, 97, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(290, 98, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Normal', 'Normal'),
(291, 98, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Large', 'Less', 'Normal'),
(292, 98, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(293, 99, 5, '3 LATER KOPI', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(294, 99, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Less'),
(295, 99, 16, 'ROTI KIAP', 3, 3.80, 11.40, '', '', '', ''),
(296, 100, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Large', 'Normal', ''),
(297, 100, 9, '3 LAYER TEH', 1, 6.80, 6.80, 'hot', 'Regular', 'Less', ''),
(298, 100, 15, 'PAPA EGG TART', 2, 2.80, 5.60, '', '', '', ''),
(299, 101, 1, 'PAPA KOPI PING KAW', 2, 4.80, 9.60, 'hot', 'Regular', 'Normal', ''),
(300, 101, 7, 'KOPI TEH KAHWIN PING', 2, 5.80, 11.60, 'hot', 'Large', 'Less', ''),
(301, 101, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', ''),
(302, 102, 2, 'PAPA SPANISH LATTE KAW', 2, 9.80, 19.60, 'hot', 'Large', 'Normal', ''),
(303, 102, 3, 'PAPA STYLE AMERICANO', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Normal'),
(304, 102, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(305, 103, 4, 'KOPI PING JELLY', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Normal'),
(306, 103, 12, 'ICE COCOA', 1, 6.80, 6.80, 'iced', 'Large', 'Less', 'Normal'),
(307, 103, 16, 'ROTI KIAP', 2, 3.80, 7.60, '', '', '', ''),
(308, 104, 5, '3 LATER KOPI', 2, 6.80, 13.60, 'iced', 'Regular', 'Normal', 'Less'),
(309, 104, 8, 'TEH PING KAW', 1, 4.80, 4.80, 'hot', 'Regular', 'Less', ''),
(310, 104, 13, 'BASQUE BURN CHEESE CAKE', 1, 10.80, 10.80, '', '', '', ''),
(311, 105, 6, 'ICE MOCHA', 2, 7.80, 15.60, 'iced', 'Regular', 'Normal', 'Normal'),
(312, 105, 10, 'HK JELLY MILK TEA', 1, 6.80, 6.80, 'iced', 'Regular', 'Less', 'Less'),
(313, 105, 14, 'CHICKEN SHAO PAU', 2, 3.80, 7.60, '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) NOT NULL,
  `category` enum('Drinks','Food') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `image`, `category`, `created_at`, `updated_at`) VALUES
(1, 'PAPA KOPI PING KAW', 4.80, 'Papa Kopi Ping Kaw.png', 'Drinks', '2024-12-24 00:35:48', '2025-01-02 17:35:55'),
(2, 'PAPA SPANISH LATTE KAW', 9.80, 'Papa Spanish Latte Kaw.png', 'Drinks', '2024-12-24 00:35:48', '2024-12-30 07:45:16'),
(3, 'PAPA STYLE AMERICANO', 6.80, 'Papa Style Americano.png', 'Drinks', '2024-12-24 00:35:48', '2024-12-30 07:45:16'),
(4, 'KOPI PING JELLY', 6.80, 'Kopi Ping Jelly.png', 'Drinks', '2024-12-24 00:35:48', '2024-12-30 07:45:16'),
(5, '3 LATER KOPI', 6.80, '3 Layer Kopi.png', 'Drinks', '2024-12-24 00:35:48', '2024-12-30 07:45:16'),
(6, 'ICE MOCHA', 7.80, 'Ice Mocha.png', 'Drinks', '2024-12-24 00:35:48', '2024-12-30 07:45:16'),
(7, 'KOPI TEH KAHWIN PING', 5.80, 'Kopi Teh Kahwin Ping.png', 'Drinks', '2024-12-24 00:35:48', '2024-12-30 07:45:16'),
(8, 'TEH PING KAW', 4.80, 'Teh Ping Kaw.png', 'Drinks', '2024-12-24 00:35:48', '2024-12-30 07:45:16'),
(9, '3 LAYER TEH', 6.80, '3 Layer Teh.png', 'Drinks', '2024-12-24 00:35:48', '2024-12-30 07:45:16'),
(10, 'HK JELLY MILK TEA', 6.80, 'HK Jelly Milk Tea.png', 'Drinks', '2024-12-24 00:35:48', '2024-12-30 07:45:16'),
(11, 'ICE LEMON TEA', 5.80, 'Ice Lemon Tea.png', 'Drinks', '2024-12-24 00:35:48', '2024-12-30 07:45:16'),
(12, 'ICE COCOA', 6.80, 'Ice Cocoa.png', 'Drinks', '2024-12-24 00:35:48', '2024-12-30 07:45:16'),
(13, 'BASQUE BURN CHEESE CAKE', 10.80, 'Basque Burn Cheese Cake.png', 'Food', '2024-12-24 00:35:48', '2024-12-24 00:35:48'),
(14, 'CHICKEN SHAO PAU', 3.80, 'Chicken Shao Pau.png', 'Food', '2024-12-24 00:35:48', '2024-12-24 00:35:48'),
(15, 'PAPA EGG TART', 2.80, 'Papa Egg Tart.png', 'Food', '2024-12-24 00:35:48', '2024-12-24 00:35:48'),
(16, 'ROTI KIAP', 3.80, 'Roti Kiap.png', 'Food', '2024-12-24 00:35:48', '2024-12-24 00:35:48'),
(17, 'ZUS 1', 12.00, '6777678a62d8e.png', 'Drinks', '2025-01-03 04:28:58', '2025-01-03 04:28:58');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `member_id` (`member_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=175;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=314;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_member_fk` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_items_product_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
