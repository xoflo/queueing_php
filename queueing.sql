-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 21, 2025 at 07:22 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `queueing`
--

-- --------------------------------------------------------

--
-- Table structure for table `controls`
--

CREATE TABLE `controls` (
  `id` int(11) NOT NULL,
  `controlName` text NOT NULL,
  `value` int(11) NOT NULL,
  `other` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `controls`
--

INSERT INTO `controls` (`id`, `controlName`, `value`, `other`) VALUES
(1, 'Priority Option', 1, NULL),
(2, 'Ticket Name Option', 0, NULL),
(3, 'Gender Option', 0, NULL),
(4, 'Video View (TV)', 1, NULL),
(5, 'Sliding Text', 1, '                    Office of the Ombudsman for Mindanao                    happy bday'),
(6, 'Kiosk Password', 0, 'kiosk'),
(7, 'RGB Screen (TV)', 1, '5:30:0.7:0'),
(8, 'RGB Screen (Kiosk)', 1, '10:0:0:0'),
(9, 'BG Video (TV)', 0, NULL),
(10, 'BG Video (Kiosk)', 1, NULL),
(11, 'Staff Inactive Beep', 1, '60'),
(17, 'One Session per User', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `name` text NOT NULL,
  `id` int(11) NOT NULL,
  `link` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mediabg`
--

CREATE TABLE `mediabg` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `link` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `priorities`
--

CREATE TABLE `priorities` (
  `priorityName` text NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `priorities`
--

INSERT INTO `priorities` (`priorityName`, `id`) VALUES
('Pregnant', 1),
('PWD', 2),
('Senior Citizen', 3);

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `id` int(11) NOT NULL,
  `serviceType` text NOT NULL,
  `serviceCode` text NOT NULL,
  `assignedGroup` text NOT NULL,
  `timeCreated` text DEFAULT NULL,
  `displayIndex` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`id`, `serviceType`, `serviceCode`, `assignedGroup`, `timeCreated`, `displayIndex`) VALUES
(63, 'TEST1', 'T1', '_MAIN_', '2025-07-31 14:53:43.778', 1),
(65, 'TEST2', 'T2', '_MAIN_', '2025-07-31 14:56:38.946', 2),
(66, 'groupservice', 'gs1', 'Group', '2025-07-31 15:01:04.958', 1),
(67, 'groupservice2', 'gs2', 'Group', '2025-07-31 15:01:24.248', 0);

-- --------------------------------------------------------

--
-- Table structure for table `servicegroup`
--

CREATE TABLE `servicegroup` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `assignedGroup` text NOT NULL,
  `timeCreated` text DEFAULT NULL,
  `displayIndex` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `servicegroup`
--

INSERT INTO `servicegroup` (`id`, `name`, `assignedGroup`, `timeCreated`, `displayIndex`) VALUES
(11, 'Group', '_MAIN_', '2025-07-31 15:00:53.675', 0);

-- --------------------------------------------------------

--
-- Table structure for table `station`
--

CREATE TABLE `station` (
  `id` int(11) NOT NULL,
  `stationNumber` int(11) DEFAULT NULL,
  `inSession` int(11) DEFAULT NULL,
  `userInSession` text DEFAULT NULL,
  `ticketServing` text DEFAULT NULL,
  `stationName` text NOT NULL,
  `sessionPing` text DEFAULT NULL,
  `displayIndex` int(11) DEFAULT NULL,
  `ticketServingId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `station`
--

INSERT INTO `station` (`id`, `stationNumber`, `inSession`, `userInSession`, `ticketServing`, `stationName`, `sessionPing`, `displayIndex`, `ticketServingId`) VALUES
(18, 1, 0, '', '', 'Window', '', 1, NULL),
(19, 2, 0, '', '', 'Window', '', 2, NULL),
(20, 3, 0, '', '', 'Window', '', 3, NULL),
(21, 4, 0, '', '', 'Window', '', 4, NULL),
(22, 5, 0, '', '', 'Window', '', 5, NULL),
(23, 6, 0, '', '', 'Window', '', 6, NULL),
(24, 7, 0, '', '', 'Window', '', 7, NULL),
(25, 8, 0, '', '', 'Window', '', 8, NULL),
(26, 9, 0, '', '', 'Window', '', 9, NULL),
(27, 10, 0, '', '', 'Window', '', 10, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `id` int(11) NOT NULL,
  `timeCreated` text NOT NULL,
  `number` text NOT NULL,
  `serviceCode` text NOT NULL,
  `serviceType` text NOT NULL,
  `userAssigned` text DEFAULT NULL,
  `stationName` text DEFAULT NULL,
  `stationNumber` int(11) DEFAULT NULL,
  `timeTaken` text DEFAULT NULL,
  `timeDone` text DEFAULT NULL,
  `status` text NOT NULL,
  `log` text NOT NULL,
  `priority` int(11) NOT NULL,
  `priorityType` text NOT NULL,
  `printStatus` int(11) NOT NULL,
  `callCheck` int(11) NOT NULL,
  `ticketName` text NOT NULL,
  `blinker` int(11) NOT NULL,
  `gender` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`id`, `timeCreated`, `number`, `serviceCode`, `serviceType`, `userAssigned`, `stationName`, `stationNumber`, `timeTaken`, `timeDone`, `status`, `log`, `priority`, `priorityType`, `printStatus`, `callCheck`, `ticketName`, `blinker`, `gender`) VALUES
(714, '2025-07-29 19:23:11.929', '001', 'S', 'SUBMISSION OF SALN', 'staff', 'Window', 1, '2025-07-29 19:59:36.562880', '2025-07-29 20:05:00.264123', 'Done', '2025-07-29 19:23:11.929: ticketGenerated, 2025-07-29 19:23:15.009017: serving on Window4 by kai, 2025-07-29 19:23:45.817458: ticket called again, 2025-07-29 19:24:23.361350: ticket called again, 2025-07-29 19:24:35.646672: ticket called again, 2025-07-29 19:24:54.202022: ticket called again, 2025-07-29 19:26:20.840257: ticket called again, 2025-07-29 19:26:30.809329: ticket called again, 2025-07-29 19:26:51.649618: ticket called again, 2025-07-29 19:27:09.953994: ticket called again, 2025-07-29 19:27:25.291486: ticket called again, 2025-07-29 19:37:59.572379: ticket transferred to FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, 2025-07-29 19:38:03.989170: serving on Window1 by staff, 2025-07-29 19:38:17.142102: ticket transferred to PAYMENTS, 2025-07-29 19:38:17.995243: serving on Window4 by kai, 2025-07-29 19:59:29.327604: ticket transferred to FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, 2025-07-29 19:59:36.562880: serving on Window1 by staff, 2025-07-29 20:05:00.264123: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(715, '2025-07-29 20:00:11.726', '001', 'P', 'PAYMENTS', 'kai', 'Window', 4, '2025-07-29 20:03:32.875421', '2025-07-29 20:03:46.612652', 'Done', '2025-07-29 20:00:11.726: ticketGenerated, 2025-07-29 20:00:18.274817: serving on Window4 by kai, 2025-07-29 20:03:18.671702: ticket called again, 2025-07-29 20:03:26.057044: ticket called again, 2025-07-29 20:03:32.875457: ticket called again, 2025-07-29 20:03:46.612652: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(716, '2025-07-29 20:00:34.788', '002', 'P', 'PAYMENTS', 'kai', 'Window', 4, '2025-07-29 20:05:06.583214', '2025-07-29 20:06:13.250316', 'Done', '2025-07-29 20:00:34.788: ticketGenerated, 2025-07-29 20:03:46.612652: serving on Window4 by kai, 2025-07-29 20:04:25.455663: ticket called again, 2025-07-29 20:05:06.583249: ticket called again, 2025-07-29 20:06:13.250316: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(717, '2025-07-29 20:05:31.856', '002', 'S', 'SUBMISSION OF SALN', 'staff', 'Window', 1, '2025-07-29 20:25:40.946815', '2025-07-29 20:29:58.757108', 'Done', '2025-07-29 20:05:31.856: ticketGenerated, 2025-07-29 20:05:35.432263: serving on Window1 by staff, 2025-07-29 20:05:55.044518: ticket called again, 2025-07-29 20:06:08.291442: ticket transferred to PAYMENTS, 2025-07-29 20:06:13.250316: serving on Window4 by kai, 2025-07-29 20:06:29.136904: ticket transferred to FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, 2025-07-29 20:06:32.813088: serving on Window1 by staff, 2025-07-29 20:06:34.138868: ticket called again, 2025-07-29 20:07:07.982088: ticket transferred to PAYMENTS, 2025-07-29 20:12:06.076530: serving on Window4 by kai, 2025-07-29 20:12:21.230486: ticket called again, 2025-07-29 20:12:37.635598: ticket called again, 2025-07-29 20:12:52.988116: ticket transferred to FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, 2025-07-29 20:16:12.969804: serving on Window1 by staff, 2025-07-29 20:16:57.137897: ticket transferred to PAYMENTS, 2025-07-29 20:17:29.529197: serving on Window4 by kai, 2025-07-29 20:17:36.282608: ticket called again, 2025-07-29 20:17:55.668402: ticket called again, 2025-07-29 20:18:03.136591: ticket called again, 2025-07-29 20:19:40.646230: ticket called again, 2025-07-29 20:19:53.515885: ticket called again, 2025-07-29 20:20:00.367793: ticket called again, 2025-07-29 20:20:18.422550: ticket called again, 2025-07-29 20:20:55.583909: ticket called again, 2025-07-29 20:24:11.600564: ticket called again, 2025-07-29 20:24:21.319235: ticket transferred to FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, 2025-07-29 20:24:32.452088: serving on Window1 by staff, 2025-07-29 20:24:51.174913: ticket transferred to PAYMENTS, 2025-07-29 20:24:53.327335: serving on Window4 by kai, 2025-07-29 20:25:10.180928: ticket transferred to FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, 2025-07-29 20:25:16.230440: serving on Window1 by staff, 2025-07-29 20:25:40.946844: ticket called again, 2025-07-29 20:29:58.757108: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(718, '2025-07-29 20:25:28.030', '003', 'P', 'PAYMENTS', 'kai', 'Window', 4, '2025-07-29 20:32:44.034158', '2025-07-29 20:37:28.490952', 'Done', '2025-07-29 20:25:28.030: ticketGenerated, 2025-07-29 20:25:29.756318: serving on Window4 by kai, 2025-07-29 20:25:57.544231: ticket called again, 2025-07-29 20:26:49.991357: ticket called again, 2025-07-29 20:29:11.362477: ticket called again, 2025-07-29 20:29:33.915938: ticket transferred to FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, 2025-07-29 20:30:46.815936: serving on Window1 by staff, 2025-07-29 20:31:08.255022: ticket transferred to PAYMENTS, 2025-07-29 20:31:10.058836: serving on Window4 by kai, 2025-07-29 20:31:26.430047: ticket called again, 2025-07-29 20:31:34.531599: ticket transferred to FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, 2025-07-29 20:31:40.821122: serving on Window1 by staff, 2025-07-29 20:31:57.332065: ticket transferred to PAYMENTS, 2025-07-29 20:32:00.338844: serving on Window4 by kai, 2025-07-29 20:32:06.791027: ticket called again, 2025-07-29 20:32:13.609148: ticket transferred to FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, 2025-07-29 20:32:23.969095: serving on Window1 by staff, 2025-07-29 20:32:38.444286: ticket transferred to PAYMENTS, 2025-07-29 20:32:44.034158: serving on Window4 by kai, 2025-07-29 20:37:28.490952: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(719, '2025-07-29 20:35:19.121', '003', 'FS', 'REQUEST FOR CASE INFORMATION', 'staff3', 'Window', 5, '2025-07-29 20:38:41.397', NULL, 'Serving', '2025-07-29 20:35:19.121: ticketGenerated, 2025-07-29 20:36:29.986048: serving on Window1 by staff, 2025-07-29 20:37:23.232097: ticket transferred to REQUEST FOR CASE INFORMATION, 2025-07-29 20:37:29.552: serving on Window5 by staff3, 2025-07-29 20:37:45.872: ticket called again, 2025-07-29 20:38:03.201: ticket called again, 2025-07-29 20:38:18.952: ticket called again, 2025-07-29 20:38:41.397: ticket called again', 0, 'Regular', 1, 1, '', 1, ''),
(720, '2025-07-29 20:35:23.161', '001', 'S', 'SUBMISSION OF SALN', '', '', 0, NULL, NULL, 'Pending', '2025-07-29 20:35:23.161: ticketGenerated', 0, 'Regular', 1, 0, '', 0, ''),
(721, '2025-07-29 20:35:28.709', '001', 'CG', 'REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE', '', '', 0, '', '', 'Pending', '2025-07-29 20:35:28.709: ticketGenerated', 0, 'Regular', 1, 0, '', 0, ''),
(722, '2025-07-29 20:35:32.974', '001', 'CI', 'REQUEST FOR CASE INFORMATION', 'staff3', 'Window', 5, '2025-07-29 20:36:19.469', '2025-07-29 20:37:29.552', 'Done', '2025-07-29 20:35:32.974: ticketGenerated, 2025-07-29 20:36:19.469: serving on Window5 by staff3, 2025-07-29 20:37:29.552: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(723, '2025-07-29 20:35:36.823', '001', 'NC', 'PAYMENTS', 'kai', 'Window', 4, '2025-07-29 21:33:11.855694', NULL, 'Serving', '2025-07-29 20:35:36.823: ticketGenerated, 2025-07-29 20:36:07.429: serving on Window6 by staff4, 2025-07-29 20:36:58.124: ticket transferred to PAYMENTS, 2025-07-29 20:37:28.490952: serving on Window4 by kai, 2025-07-29 20:37:58.816759: ticket called again, 2025-07-29 20:38:23.739148: ticket called again, 2025-07-29 20:38:42.228400: ticket called again, 2025-07-29 20:52:50.082867: ticket called again, 2025-07-29 20:53:02.003086: ticket called again, 2025-07-29 20:53:18.974094: ticket called again, 2025-07-29 21:32:58.402237: ticket called again, 2025-07-29 21:33:00.635460: ticket called again, 2025-07-29 21:33:11.855729: ticket called again', 0, 'Regular', 1, 1, '', 1, ''),
(724, '2025-07-29 20:35:41.434', '001', 'CS', 'REQUEST FOR COPY OF SALN', 'staff6', 'Window', 7, '2025-07-29 20:36:00.294', NULL, 'Serving', '2025-07-29 20:35:41.434: ticketGenerated, 2025-07-29 20:36:00.294: serving on Window7 by staff6', 0, 'Regular', 1, 1, '', 1, ''),
(725, '2025-07-29 21:13:03.830', '005', 'S', 'SUBMISSION OF SALN', 'staff', 'Window', 1, '2025-07-29 21:39:01.428870', NULL, 'Serving', '2025-07-29 21:13:03.830: ticketGenerated, 2025-07-29 21:33:25.409407: serving on Window4 by kai, 2025-07-29 21:33:41.996382: ticket called again, 2025-07-29 21:37:21.003867: ticket transferred to FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, 2025-07-29 21:37:32.027970: serving on Window1 by staff, 2025-07-29 21:37:42.270881: ticket called again, 2025-07-29 21:37:55.484715: ticket called again, 2025-07-29 21:38:10.379439: ticket called again, 2025-07-29 21:39:01.428923: ticket called again', 0, 'Regular', 1, 1, '', 1, ''),
(726, '2025-07-29 21:14:03.375', '006', 'P', 'PAYMENTS', 'kai', 'Window', 4, '2025-07-29 21:38:59.545895', NULL, 'Serving', '2025-07-29 21:14:03.375: ticketGenerated, 2025-07-29 21:37:21.003867: serving on Window4 by kai, 2025-07-29 21:37:34.274195: ticket called again, 2025-07-29 21:37:43.977578: ticket called again, 2025-07-29 21:37:59.747909: ticket called again, 2025-07-29 21:38:49.543884: ticket called again, 2025-07-29 21:38:59.545933: ticket called again', 0, 'Regular', 1, 1, '', 1, ''),
(727, '2025-07-30 13:36:36.755', '001', 'S', 'SUBMISSION OF SALN', 'staff', 'Window', 2, '2025-07-30 13:36:54.008', NULL, 'Serving', '2025-07-30 13:36:36.755: ticketGenerated, 2025-07-30 13:36:54.008: serving on Window2 by staff', 0, 'Regular', 1, 1, '', 1, ''),
(728, '2025-08-06 14:39:43.975', '001', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-06 14:48:18.135', '2025-08-06 14:48:31.358', 'Done', '2025-08-06 14:39:43.975: ticketGenerated, 2025-08-06 14:48:18.135: serving on Window1 by staff, 2025-08-06 14:48:31.358: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(729, '2025-08-06 14:42:51.276', '002', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-06 14:48:31.358', '2025-08-06 14:48:36.519', 'Done', '2025-08-06 14:42:51.276: ticketGenerated, 2025-08-06 14:48:31.358: serving on Window1 by staff, 2025-08-06 14:48:36.519: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(730, '2025-08-06 14:48:05.271', '003', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-06 14:55:29.113', '2025-08-06 14:55:32.297', 'Done', '2025-08-06 14:48:05.271: ticketGenerated, 2025-08-06 14:48:36.519: serving on Window1 by staff, 2025-08-06 14:55:29.113: ticket called again, 2025-08-06 14:55:32.297: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(731, '2025-08-06 14:50:06.840', '004', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-06 14:55:32.297', '2025-08-06 14:55:37.981', 'Done', '2025-08-06 14:50:06.840: ticketGenerated, 2025-08-06 14:55:32.297: serving on Window1 by staff, 2025-08-06 14:55:37.981: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(732, '2025-08-06 14:55:05.798', '005', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-06 14:55:37.981', '2025-08-06 14:55:39.396', 'Done', '2025-08-06 14:55:05.798: ticketGenerated, 2025-08-06 14:55:37.981: serving on Window1 by staff, 2025-08-06 14:55:39.396: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(733, '2025-08-06 14:55:17.486', '006', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-06 14:55:39.396', '2025-08-06 14:55:40.967', 'Done', '2025-08-06 14:55:17.486: ticketGenerated, 2025-08-06 14:55:39.396: serving on Window1 by staff, 2025-08-06 14:55:40.967: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(734, '2025-08-06 14:56:28.131', '007', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-06 14:56:37.482', '2025-08-06 14:57:08.870', 'Done', '2025-08-06 14:56:28.131: ticketGenerated, 2025-08-06 14:56:37.482: serving on Window1 by staff, 2025-08-06 14:57:08.870: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(735, '2025-08-06 14:57:01.538', '008', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-06 14:57:08.870', '2025-08-06 14:57:12.286', 'Done', '2025-08-06 14:57:01.538: ticketGenerated, 2025-08-06 14:57:08.870: serving on Window1 by staff, 2025-08-06 14:57:12.286: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(736, '2025-08-06 14:57:22.216', '009', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-06 14:58:06.023', '2025-08-06 15:19:17.669', 'Done', '2025-08-06 14:57:22.216: ticketGenerated, 2025-08-06 14:58:06.023: serving on Window1 by staff, 2025-08-06 15:19:17.669: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(737, '2025-08-06 15:19:09.728', '010', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-06 15:19:17.669', '2025-08-06 15:19:37.012', 'Done', '2025-08-06 15:19:09.728: ticketGenerated, 2025-08-06 15:19:17.669: serving on Window1 by staff, 2025-08-06 15:19:37.012: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(738, '2025-08-06 15:19:23.888', '011', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-06 15:19:37.012', '2025-08-06 15:19:38.615', 'Done', '2025-08-06 15:19:23.888: ticketGenerated, 2025-08-06 15:19:37.012: serving on Window1 by staff, 2025-08-06 15:19:38.615: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(739, '2025-08-06 15:19:31.842', '012', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-06 15:19:38.615', '2025-08-06 15:19:40.256', 'Done', '2025-08-06 15:19:31.842: ticketGenerated, 2025-08-06 15:19:38.615: serving on Window1 by staff, 2025-08-06 15:19:40.256: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(740, '2025-08-15 13:44:41.392', '001', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-15 13:46:18.970', '2025-08-15 13:46:22.662', 'Done', '2025-08-15 13:44:41.392: ticketGenerated, 2025-08-15 13:45:58.269: serving on Window1 by staff, 2025-08-15 13:46:03.508: ticket transferred to TEST1, 2025-08-15 13:46:10.990: serving on Window1 by staff, 2025-08-15 13:46:14.848: ticket transferred to TEST1, 2025-08-15 13:46:18.970: serving on Window1 by staff, 2025-08-15 13:46:22.662: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(741, '2025-08-15 13:45:51.660', '002', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-15 13:46:03.508', '2025-08-15 13:46:10.990', 'Done', '2025-08-15 13:45:51.660: ticketGenerated, 2025-08-15 13:46:03.508: serving on Window1 by staff, 2025-08-15 13:46:10.990: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(742, '2025-08-15 16:12:43.777', '003', 'T1', 'groupservice', 'staff3', 'Window', 3, '2025-08-15 16:14:14.113', '2025-08-15 16:14:17.103', 'Done', '2025-08-15 16:12:43.777: ticketGenerated, 2025-08-15 16:13:10.619: serving on Window1 by staff, 2025-08-15 16:13:15.877: ticket transferred to TEST2, 2025-08-15 16:14:03.078: serving on Window2 by staff2, 2025-08-15 16:14:06.331: ticket transferred to groupservice, 2025-08-15 16:14:14.113: serving on Window3 by staff3, 2025-08-15 16:14:17.103: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(743, '2025-08-18 12:51:06.325', '001', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-18 12:51:41.450', '2025-08-18 12:52:14.335', 'Done', '2025-08-18 12:51:06.325: ticketGenerated TEST1, 2025-08-18 12:51:41.450: serving on Window1 by staff, 2025-08-18 12:52:14.335: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, ''),
(744, '2025-08-18 12:51:20.478', '002', 'T1', 'TEST1', 'staff', 'Window', 1, '2025-08-18 12:52:14.335', '2025-08-18 12:57:45.557', 'Done', '2025-08-18 12:51:20.478: ticketGenerated TEST1, 2025-08-18 12:52:14.335: serving on Window1 by staff, 2025-08-18 12:57:45.557: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `pass` text NOT NULL,
  `userType` text NOT NULL,
  `serviceType` text DEFAULT NULL,
  `username` text NOT NULL,
  `loggedIn` text DEFAULT NULL,
  `servicesSet` text DEFAULT NULL,
  `assignedStation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `pass`, `userType`, `serviceType`, `username`, `loggedIn`, `servicesSet`, `assignedStation`) VALUES
(2, 'admin', 'Admin', NULL, 'admin', NULL, '[ul]', 'All_999'),
(27, 'staff', 'Staff', '[TEST1]', 'staff', NULL, '[TEST1]', 'Window 1_18'),
(28, 'staff2', 'Staff', '[TEST2]', 'staff2', NULL, '[TEST2]', 'Window 2_19'),
(29, 'staff3', 'Staff', '[groupservice]', 'staff3', NULL, '[groupservice]', 'Window 3_20');

-- --------------------------------------------------------

--
-- Table structure for table `userlog`
--

CREATE TABLE `userlog` (
  `id` int(11) NOT NULL,
  `timestamp` text NOT NULL,
  `state` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `user` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userlog`
--

INSERT INTO `userlog` (`id`, `timestamp`, `state`, `userId`, `user`) VALUES
(14, '2025-08-20 11:03:17', 1, 27, 'staff'),
(15, '2025-08-20 11:04:20', 0, 27, 'staff'),
(16, '2025-08-20 11:22:11', 1, 27, 'staff'),
(17, '2025-08-20 11:22:19', 0, 27, 'staff'),
(18, '2025-08-20 11:23:08', 1, 27, 'staff'),
(19, '2025-08-20 11:23:13', 3, 27, 'staff'),
(20, '2025-08-20 11:03:17', 1, 27, 'staff'),
(21, '2025-08-20 11:04:20', 0, 27, 'staff'),
(22, '2025-08-20 11:22:11', 1, 27, 'staff'),
(23, '2025-08-20 11:22:19', 0, 27, 'staff'),
(24, '2025-08-20 11:23:08', 1, 27, 'staff'),
(25, '2025-08-20 11:23:13', 3, 27, 'staff'),
(26, '2025-08-20 11:03:17', 1, 27, 'staff'),
(27, '2025-08-20 11:04:20', 0, 27, 'staff'),
(28, '2025-08-20 11:22:11', 1, 27, 'staff'),
(29, '2025-08-20 11:22:19', 0, 27, 'staff'),
(30, '2025-08-20 11:23:08', 1, 27, 'staff'),
(31, '2025-08-20 11:23:13', 3, 27, 'staff'),
(32, '2025-08-20 11:03:17', 1, 27, 'staff'),
(33, '2025-08-20 11:04:20', 0, 27, 'staff'),
(34, '2025-08-20 11:22:11', 1, 27, 'staff'),
(35, '2025-08-20 11:22:19', 0, 27, 'staff'),
(36, '2025-08-20 11:23:08', 1, 27, 'staff'),
(37, '2025-08-20 11:23:13', 3, 27, 'staff'),
(38, '2025-08-20 11:03:17', 1, 27, 'staff'),
(39, '2025-08-20 11:04:20', 0, 27, 'staff'),
(40, '2025-08-20 11:22:11', 1, 27, 'staff'),
(41, '2025-08-20 11:22:19', 0, 27, 'staff'),
(42, '2025-08-20 11:23:08', 1, 27, 'staff'),
(43, '2025-08-20 11:23:13', 3, 27, 'staff'),
(44, '2025-08-20 11:03:17', 1, 27, 'staff'),
(45, '2025-08-20 11:04:20', 0, 27, 'staff'),
(46, '2025-08-20 11:22:11', 1, 27, 'staff'),
(47, '2025-08-20 11:22:19', 0, 27, 'staff'),
(48, '2025-08-20 11:23:08', 1, 27, 'staff'),
(49, '2025-08-20 11:23:13', 3, 27, 'staff'),
(50, '2025-08-20 11:03:17', 1, 27, 'staff'),
(51, '2025-08-20 11:04:20', 0, 27, 'staff'),
(52, '2025-08-20 11:22:11', 1, 27, 'staff'),
(53, '2025-08-20 11:22:19', 0, 27, 'staff'),
(54, '2025-08-20 11:23:08', 1, 27, 'staff'),
(55, '2025-08-20 11:23:13', 3, 27, 'staff'),
(56, '2025-08-20 11:03:17', 1, 27, 'staff'),
(57, '2025-08-20 11:04:20', 0, 27, 'staff'),
(58, '2025-08-20 11:22:11', 1, 27, 'staff'),
(59, '2025-08-20 11:22:19', 0, 27, 'staff'),
(60, '2025-08-20 11:23:08', 1, 27, 'staff'),
(61, '2025-08-20 11:23:13', 3, 27, 'staff'),
(62, '2025-08-20 11:03:17', 1, 27, 'staff'),
(63, '2025-08-20 11:04:20', 0, 27, 'staff'),
(64, '2025-08-20 11:22:11', 1, 27, 'staff'),
(65, '2025-08-20 11:22:19', 0, 27, 'staff'),
(66, '2025-08-20 11:23:08', 1, 27, 'staff'),
(67, '2025-08-20 11:23:13', 3, 27, 'staff'),
(68, '2025-08-20 11:03:17', 1, 27, 'staff'),
(69, '2025-08-20 11:04:20', 0, 27, 'staff'),
(70, '2025-08-20 11:22:11', 1, 27, 'staff'),
(71, '2025-08-20 11:22:19', 0, 27, 'staff'),
(72, '2025-08-20 11:23:08', 1, 27, 'staff'),
(73, '2025-08-20 11:23:13', 3, 27, 'staff'),
(74, '2025-08-20 11:03:17', 1, 27, 'staff'),
(75, '2025-08-20 11:04:20', 0, 27, 'staff'),
(76, '2025-08-20 11:22:11', 1, 27, 'staff'),
(77, '2025-08-20 11:22:19', 0, 27, 'staff'),
(78, '2025-08-20 11:23:08', 1, 27, 'staff'),
(79, '2025-08-20 11:23:13', 3, 27, 'staff'),
(80, '2025-08-20 11:03:17', 1, 27, 'staff'),
(81, '2025-08-20 11:04:20', 0, 27, 'staff'),
(82, '2025-08-20 11:22:11', 1, 27, 'staff'),
(83, '2025-08-20 11:22:19', 0, 27, 'staff'),
(84, '2025-08-20 11:23:08', 1, 27, 'staff'),
(85, '2025-08-20 11:23:13', 3, 27, 'staff'),
(86, '2025-08-20 11:03:17', 1, 27, 'staff'),
(87, '2025-08-20 15:19:49', 1, 27, 'staff'),
(88, '2025-08-20 15:19:52', 0, 27, 'staff'),
(89, '2025-08-20 15:33:53', 3, 27, 'staff');

-- --------------------------------------------------------

--
-- Table structure for table `version`
--

CREATE TABLE `version` (
  `id` int(11) NOT NULL,
  `version` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `version`
--

INSERT INTO `version` (`id`, `version`) VALUES
(0, 'v1.0.3');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `controls`
--
ALTER TABLE `controls`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mediabg`
--
ALTER TABLE `mediabg`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `priorities`
--
ALTER TABLE `priorities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `servicegroup`
--
ALTER TABLE `servicegroup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `station`
--
ALTER TABLE `station`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `userlog`
--
ALTER TABLE `userlog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `version`
--
ALTER TABLE `version`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `controls`
--
ALTER TABLE `controls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `mediabg`
--
ALTER TABLE `mediabg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `priorities`
--
ALTER TABLE `priorities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `servicegroup`
--
ALTER TABLE `servicegroup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `station`
--
ALTER TABLE `station`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=745;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `userlog`
--
ALTER TABLE `userlog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
