-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 11, 2025 at 06:26 AM
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
(9, 'BG Video (TV)', 1, NULL),
(10, 'BG Video (Kiosk)', 1, NULL),
(11, 'Staff Inactive Beep', 1, '120');

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
('sample1080.mp4', 15, 'sample1080.mp4');

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
(2, 'sample1080.mp4', 'sample1080.mp4');

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
  `assignedGroup` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`id`, `serviceType`, `serviceCode`, `assignedGroup`) VALUES
(14, 'FILING / SUBMISSION OF CASE-RELATED DOCUMENTS', 'FS', '_MAIN_'),
(15, 'SUBMISSION OF SALN', 'S', '_MAIN_'),
(16, 'REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE', 'CG', '_MAIN_'),
(17, 'REQUEST FOR CASE INFORMATION', 'CI', '_MAIN_'),
(18, 'FILING OF NEW COMPLAINTS', 'NC', '_MAIN_'),
(19, 'REQUEST FOR COPY OF SALN', 'CS', '_MAIN_'),
(20, 'APPLICATION FOR OMB CLEARANCE', 'AC', '_MAIN_'),
(21, 'PAYMENTS', 'P', '_MAIN_'),
(22, 'RELEASING OF CHECKS', 'RC', '_MAIN_'),
(23, 'RELEASING OF CLEARANCE', 'RL', '_MAIN_'),
(24, 'REQUEST FOR ASSISTANCE', 'RA', '_MAIN_');

-- --------------------------------------------------------

--
-- Table structure for table `servicegroup`
--

CREATE TABLE `servicegroup` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `assignedGroup` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `sessionPing` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `station`
--

INSERT INTO `station` (`id`, `stationNumber`, `inSession`, `userInSession`, `ticketServing`, `stationName`, `sessionPing`) VALUES
(5, 1, 1, 'staff', '', 'Window', '2025-07-11 12:20:14.253869'),
(6, 2, 0, '', '', 'Window', ''),
(10, 3, 0, '', '', 'Window', ''),
(11, 4, 0, '', '', 'Window', ''),
(12, 5, 0, '', '', 'Window', ''),
(13, 6, 0, '', '', 'Window', ''),
(14, 7, 0, '', '', 'Window', '');

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
  `blinker` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`id`, `timeCreated`, `number`, `serviceCode`, `serviceType`, `userAssigned`, `stationName`, `stationNumber`, `timeTaken`, `timeDone`, `status`, `log`, `priority`, `priorityType`, `printStatus`, `callCheck`, `ticketName`, `blinker`) VALUES
(88, '2025-07-11 13:56:04.778297', '001', 'S', 'SUBMISSION OF SALN', 'staff', 'Window', 1, '2025-07-11 12:18:00.731463', '2025-07-11 12:19:45.149601', 'Done', '2025-07-08 13:56:04.778297: ticketGenerated, 2025-07-08 17:25:03.743172: serving on Teller1 by staff, 2025-07-08 17:27:44.248986: serving on Teller1 by staff, 2025-07-08 17:33:30.934555: serving on Teller1 by staff, 2025-07-08 17:42:10.128208: serving on Teller1 by staff, 2025-07-11 12:12:37.897622: serving on Window1 by staff, 2025-07-11 12:18:00.731463: serving on Window1 by staff, 2025-07-11 12:19:45.149601: Ticket Session Finished', 0, 'Regular', 1, 1, '', 1),
(89, '2025-07-11 14:36:03.957434', '001', 'S', 'SUBMISSION OF SALN', 'staff', 'Window', 1, '2025-07-11 11:34:56.292601', '', 'Pending', '2025-07-10 14:36:03.957434: ticketGenerated, 2025-07-11 11:24:46.877849: serving on Window1 by staff, 2025-07-11 11:34:56.292601: serving on Window1 by staff', 0, 'Pregnant', 1, 1, '', 1),
(90, '2025-07-10 14:42:46.509561', '002', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-10 14:42:46.509561: ticketGenerated', 0, 'Regular', 1, 0, '', 0),
(91, '2025-07-10 14:47:52.304526', '003', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-10 14:47:52.304526: ticketGenerated', 0, 'Regular', 1, 0, '', 0),
(92, '2025-07-10 14:59:48.590701', '004', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-10 14:59:48.590701: ticketGenerated', 0, 'Regular', 1, 0, '', 0),
(93, '2025-07-10 15:00:02.780760', '005', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-10 15:00:02.780760: ticketGenerated', 0, 'Regular', 1, 0, '', 0),
(94, '2025-07-10 15:00:12.174684', '006', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-10 15:00:12.174684: ticketGenerated', 0, 'Regular', 1, 0, '', 0),
(95, '2025-07-10 15:00:23.484018', '007', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-10 15:00:23.484018: ticketGenerated', 0, 'Regular', 1, 0, '', 0),
(96, '2025-07-10 15:15:45.688115', '008', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-10 15:15:45.688115: ticketGenerated', 0, 'Regular', 1, 0, '', 0),
(97, '2025-07-10 15:16:19.448900', '009', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-10 15:16:19.448900: ticketGenerated', 0, 'Regular', 1, 0, '', 0),
(98, '2025-07-10 15:26:01.753688', '010', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-10 15:26:01.753688: ticketGenerated', 0, 'Regular', 1, 0, '', 0),
(99, '2025-07-10 15:26:26.039850', '011', 'S', 'SUBMISSION OF SALN', '', '', 0, '', '', 'Pending', '2025-07-10 15:26:26.039850: ticketGenerated', 0, 'Regular', 1, 0, '', 0);

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
  `servicesSet` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `pass`, `userType`, `serviceType`, `username`, `loggedIn`, `servicesSet`) VALUES
(2, 'admin', 'Admin', '', 'admin', NULL, ''),
(14, 'staff', 'Staff', '[FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, SUBMISSION OF SALN, REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE]', 'staff', '2025-07-11 12:20:15.358571', '[FILING / SUBMISSION OF CASE-RELATED DOCUMENTS, SUBMISSION OF SALN, REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE]');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `mediabg`
--
ALTER TABLE `mediabg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `priorities`
--
ALTER TABLE `priorities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `servicegroup`
--
ALTER TABLE `servicegroup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `station`
--
ALTER TABLE `station`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
