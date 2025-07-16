-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 16, 2025 at 09:23 AM
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
(3, 'Video View (TV)', 1, NULL),
(4, 'Sliding Text', 1, '                    Office of the Ombudsman for Mindanao                    happy bday'),
(5, 'Kiosk Password', 0, 'kiosk'),
(6, 'RGB Screen (TV)', 1, '5:30:0.7:0'),
(7, 'RGB Screen (Kiosk)', 1, '10:0:0:0'),
(9, 'BG Video (TV)', 0, NULL),
(12, 'BG Video (Kiosk)', 1, NULL),
(13, 'Staff Inactive Beep', 1, '60'),
(14, 'Gender Option', 0, NULL);

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
(20, 3, 0, '', '', 'Window', '', 3),
(21, 4, 0, '', '', 'Window', '', 4),
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
(108, '2025-07-15 00:42:02.884', '001', 'S', 'SUBMISSION OF SALN', 'staff', 'Window', 1, '2025-07-15 00:42:16.948', '', 'Serving', '2025-07-15 00:42:02.884: ticketGenerated, 2025-07-15 00:42:16.948: serving on Windows1 by staff', 0, 'Regular', 1, 1, '', 1, NULL),
(109, '2025-07-15 00:42:03.844', '002', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-15 00:42:03.844: ticketGenerated', 0, 'Regular', 1, 0, '', 0, NULL),
(110, '2025-07-15 00:42:04.727', '003', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-15 00:42:04.727: ticketGenerated', 0, 'Regular', 1, 0, '', 0, NULL);

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
(2, 'admin', 'Admin', '', 'admin', NULL, '', ''),
(14, 'staff', 'Staff', '[FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, SUBMISSION OF SALN, REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE]', 'staff', '2025-07-15 00:46:48.125', '[FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, SUBMISSION OF SALN, REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE]', ''),
(16, 'staff1', 'Staff', '[FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, SUBMISSION OF SALN, REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE]', 'staff1', NULL, '[FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, SUBMISSION OF SALN, REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE]', ''),
(17, 'staff2', 'Staff', '[SUBMISSION OF SALN]', 'staff2', NULL, '[SUBMISSION OF SALN]', ''),
(18, 'staff3', 'Staff', '[SUBMISSION OF SALN]', 'staff3', NULL, '[SUBMISSION OF SALN]', '');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
