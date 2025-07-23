-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 17, 2025 at 02:45 AM
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
(1, 'Priority Option', 0, NULL),
(2, 'Ticket Name Option', 0, NULL),
(3, 'Gender Option', 1, NULL),
(4, 'Video View (TV)', 0, NULL),
(5, 'Sliding Text', 1, '                    Office of the Ombudsman for Mindanao                    happy bday'),
(6, 'Kiosk Password', 0, 'kiosk'),
(7, 'RGB Screen (TV)', 1, '5:30:0.7:0'),
(8, 'RGB Screen (Kiosk)', 1, '10:0:0:0'),
(9, 'BG Video (TV)', 0, NULL),
(10, 'BG Video (Kiosk)', 1, NULL),
(11, 'Staff Inactive Beep', 1, '60');

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `name` text NOT NULL,
  `id` int(11) NOT NULL,
  `link` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`name`, `id`, `link`) VALUES
('sample480.mp4', 17, 'sample480.mp4'),
('sample720.mp4', 18, 'sample720.mp4');

-- --------------------------------------------------------

--
-- Table structure for table `mediabg`
--

CREATE TABLE `mediabg` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `link` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mediabg`
--

INSERT INTO `mediabg` (`id`, `name`, `link`) VALUES
(4, 'sample480.mp4', 'sample480.mp4'),
(5, 'sample720.mp4', 'sample720.mp4');

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
  `timeCreated` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`id`, `serviceType`, `serviceCode`, `assignedGroup`, `timeCreated`) VALUES
(14, 'FILING / SUBMISSION OF CASE-RELATED DOCUMENTS', 'FS', '_MAIN_', NULL),
(15, 'SUBMISSION OF SALN', 'S', '_MAIN_', NULL),
(16, 'REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE', 'CG', '_MAIN_', NULL),
(17, 'REQUEST FOR CASE INFORMATION', 'CI', '_MAIN_', NULL),
(18, 'FILING OF NEW COMPLAINTS', 'NC', '_MAIN_', NULL),
(19, 'REQUEST FOR COPY OF SALN', 'CS', '_MAIN_', NULL),
(20, 'APPLICATION FOR OMB CLEARANCE', 'AC', '_MAIN_', NULL),
(21, 'PAYMENTS', 'P', '_MAIN_', NULL),
(22, 'RELEASING OF CHECKS', 'RC', '_MAIN_', NULL),
(23, 'RELEASING OF CLEARANCE', 'RL', '_MAIN_', NULL),
(24, 'REQUEST FOR ASSISTANCE', 'RA', '_MAIN_', NULL),
(27, 'Test1', 'T1', '_MAIN_', NULL),
(28, 'Test2', 'T2', '_MAIN_', NULL),
(29, 'Test3', 'T3', '_MAIN_', NULL),
(30, 'Test4', 'T4', '_MAIN_', NULL),
(31, 'Test5', 'T5', '_MAIN_', NULL),
(32, 'Test6', 'T6', '_MAIN_', NULL),
(33, 'Test7', 'T7', '_MAIN_', NULL),
(34, 'Test8', 'T8', '_MAIN_', NULL),
(35, 'Test9', 'T9', '_MAIN_', NULL),
(36, 'Test10', 'T10', '_MAIN_', NULL),
(37, 'Test11', 'T11', '_MAIN_', NULL),
(38, 'Test12', 'T12', '_MAIN_', NULL),
(39, 'Test13', 'T13', '_MAIN_', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `servicegroup`
--

CREATE TABLE `servicegroup` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `assignedGroup` text NOT NULL,
  `timeCreated` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `servicegroup`
--

INSERT INTO `servicegroup` (`id`, `name`, `assignedGroup`, `timeCreated`) VALUES
(8, 'New', '_MAIN_', '2025-07-16 14:22:56.816');

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
  `displayIndex` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `station`
--

INSERT INTO `station` (`id`, `stationNumber`, `inSession`, `userInSession`, `ticketServing`, `stationName`, `sessionPing`, `displayIndex`) VALUES
(18, 1, 0, '', '', 'Window', '', 1),
(19, 2, 0, '', '', 'Window', '', 2),
(20, 3, 1, 'staff', '', 'Window', '2025-07-17 00:13:55.459', 3),
(21, 4, 1, 'staff', '', 'Window', '2025-07-17 00:10:01.424', 4),
(22, 5, 0, '', '', 'Window', '', 5),
(23, 6, 0, '', '', 'Window', '', 6),
(24, 7, 0, '', '', 'Window', '', 7),
(25, 8, 0, '', '', 'Window', '', 8),
(26, 9, 0, '', '', 'Window', '', 9),
(27, 10, 0, '', '', 'Window', '', 10);

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
(111, '2025-07-16 17:59:30.861', '001', 'FS', 'FILING / SUBMISSION OF CASE-RELATED DOCUMENTS', 'staff', 'Window', 3, '2025-07-16 18:12:30.091', '2025-07-16 19:07:19.377', 'Done', '2025-07-16 17:59:30.861: ticketGenerated, 2025-07-16 18:12:30.091: serving on Window3 by staff, 2025-07-16 19:07:19.377: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, NULL),
(112, '2025-07-16 17:59:32.641', '001', 'S', 'SUBMISSION OF SALN', 'staff', 'Window', 3, '2025-07-16 19:14:36.304', '2025-07-16 19:45:13.946', 'Done', '2025-07-16 17:59:32.641: ticketGenerated, 2025-07-16 19:14:36.304: serving on Window3 by staff, 2025-07-16 19:45:13.946: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1, NULL),
(113, '2025-07-16 17:59:35.633', '001', 'CG', 'REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE', 'staff', 'Window', 3, '2025-07-16 19:45:51.708', '2025-07-16 19:53:33.315', 'Done', '2025-07-16 17:59:35.633: ticketGenerated, 2025-07-16 19:45:51.708: serving on Window3 by staff, 2025-07-16 19:53:33.315: Ticket Session Finished', 0, 'Regular', 1, 0, '', 0, NULL),
(114, '2025-07-16 17:59:36.958', '001', 'CI', 'REQUEST FOR CASE INFORMATION', '', '', 0, '', '', 'Pending', '2025-07-16 17:59:36.958: ticketGenerated', 1, 'Senior Citizen', 1, 0, '', 0, NULL),
(115, '2025-07-16 17:59:38.192', '001', 'NC', 'FILING OF NEW COMPLAINTS', '', '', 0, '', '', 'Pending', '2025-07-16 17:59:38.192: ticketGenerated', 1, 'Pregnant', 1, 0, '', 0, NULL),
(116, '2025-07-16 17:59:39.121', '001', 'CS', 'REQUEST FOR COPY OF SALN', '', '', 0, '', '', 'Pending', '2025-07-16 17:59:39.121: ticketGenerated', 1, 'PWD', 1, 0, '', 0, NULL),
(117, '2025-07-16 19:50:32.706', '002', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-16 19:50:32.706: ticketGenerated', 0, 'Regular', 1, 0, '', 0, NULL),
(118, '2025-07-16 19:52:22.698', '003', 'S', 'SUBMISSION OF SALN', 'staff', 'Window', 3, '2025-07-16 19:53:42.770', '2025-07-16 19:58:03.069', 'Done', '2025-07-16 19:52:22.698: ticketGenerated, 2025-07-16 19:53:42.770: serving on Window3 by staff, 2025-07-16 19:58:03.069: Ticket Session Finished', 1, 'PWD', 1, 0, '', 0, NULL),
(119, '2025-07-16 19:52:23.935', '002', 'FS', 'FILING / SUBMISSION OF CASE-RELATED DOCUMENTS', '', '', 0, '', '', 'Pending', '2025-07-16 19:52:23.935: ticketGenerated', 0, 'Regular', 1, 0, '', 0, NULL),
(121, '2025-07-16 19:52:27.068', '003', 'FS', 'FILING / SUBMISSION OF CASE-RELATED DOCUMENTS', '', '', 0, '', '', 'Pending', '2025-07-16 19:52:27.068: ticketGenerated', 0, 'Regular', 1, 0, '', 0, NULL),
(122, '2025-07-17 00:40:34.070', '001', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-17 00:40:34.070: ticketGenerated', 0, 'Regular', 1, 0, '', 0, NULL),
(123, '2025-07-17 00:40:41.405', '002', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-17 00:40:41.405: ticketGenerated', 0, 'Regular', 1, 0, '', 0, NULL),
(124, '2025-07-17 00:47:21.248', '003', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-17 00:47:21.248: ticketGenerated', 0, 'Regular', 1, 0, '', 0, NULL),
(125, '2025-07-17 00:48:03.186', '004', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-17 00:48:03.186: ticketGenerated', 0, 'Regular', 1, 0, '', 0, NULL),
(126, '2025-07-17 00:50:44.419', '005', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-17 00:50:44.419: ticketGenerated', 0, 'Regular', 1, 0, '', 0, NULL),
(127, '2025-07-17 01:16:21.823', '006', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-17 01:16:21.823: ticketGenerated', 1, 'Regular', 1, 0, 'Test', 0, 'Male'),
(128, '2025-07-17 01:17:11.456', '007', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-17 01:17:11.456: ticketGenerated', 0, 'Regular', 1, 0, '', 0, 'Male');

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
(20, 'staff', 'Staff', '[FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, SUBMISSION OF SALN, REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE, REQUEST FOR CASE INFORMATION, FILING OF NEW COMPLAINTS, REQUEST FOR COPY OF SALN, APPLICATION FOR OMB CLEARANCE, PAYMENTS, RELEASING OF CHECKS, RELEASING OF CLEARANCE, REQUEST FOR ASSISTANCE]', 'staff', '2025-07-17 00:07:05.837', '[FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, SUBMISSION OF SALN, REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE]', 'Window 3_20');

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `controls`
--
ALTER TABLE `controls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `servicegroup`
--
ALTER TABLE `servicegroup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `station`
--
ALTER TABLE `station`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
