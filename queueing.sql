-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 02, 2025 at 11:18 AM
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
(2, 'Ticket Name Option', 1, NULL),
(3, 'Video in Queue Display', 1, NULL),
(4, 'Sliding Text', 1, '                    Office of the Ombudsman for Mindanao                    Welcome to Davao City                    This Text Will Overflow The Field But Not Separated by Enter');

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
('sample.mp4', 3, 'sample.mp4'),
('sample2.mp4', 4, 'sample2.mp4');

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
(14, 'FILING / SUBMISSION OF CASE-RELATED DOCUMENTS ', 'FS', '_MAIN_'),
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
  `inSession` int(11) NOT NULL,
  `userInSession` text NOT NULL,
  `ticketServing` text NOT NULL,
  `stationName` text NOT NULL,
  `sessionPing` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `station`
--

INSERT INTO `station` (`id`, `stationNumber`, `inSession`, `userInSession`, `ticketServing`, `stationName`, `sessionPing`) VALUES
(5, 1, 0, '', '', 'Teller', ''),
(6, 2, 0, '', '', 'Teller', ''),
(10, 0, 0, '', '', 'Station', '');

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
  `ticketName` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`id`, `timeCreated`, `number`, `serviceCode`, `serviceType`, `userAssigned`, `stationName`, `stationNumber`, `timeTaken`, `timeDone`, `status`, `log`, `priority`, `priorityType`, `printStatus`, `callCheck`, `ticketName`) VALUES
(59, '2025-06-24 11:19:29.005265', '001', 'E', 'Evaluation', 'staff', 'Teller', 1, '2025-06-24 11:21:45.865814', '2025-06-24 11:25:35.449317', 'Done', '2025-06-24 11:19:29.005265: ticketGenerated, 2025-06-24 11:21:45.865814: serving on Teller1 by staff, 2025-06-24 11:25:35.449317: ticket session finished', 0, 'None', 1, 0, ''),
(60, '2025-06-24 11:19:31.282680', '002', 'E', 'Evaluation', 'staff', 'Teller', 1, '2025-06-24 11:25:35.449317', '2025-06-24 11:25:51.410378', 'Done', '2025-06-24 11:19:31.282680: ticketGenerated, 2025-06-24 11:25:35.449317: serving on Teller1 by staff, 2025-06-24 11:25:51.410378: ticket session finished', 0, 'None', 1, 0, ''),
(61, '2025-06-24 11:19:33.011278', '003', 'E', 'Evaluation', 'staff', 'Teller', 1, '2025-06-24 11:25:51.410378', '2025-06-24 11:28:11.919024', 'Done', '2025-06-24 11:19:33.011278: ticketGenerated, 2025-06-24 11:25:51.410378: serving on Teller1 by staff, 2025-06-24 11:28:11.919024: ticket session finished', 0, 'None', 1, 1, ''),
(62, '2025-06-24 11:19:34.836744', '004', 'E', 'Releasing', 'staff', 'Teller', 1, '2025-06-24 11:28:54.422304', '2025-06-24 12:39:09.854647', 'Done', '2025-06-24 11:19:34.836744: ticketGenerated, 2025-06-24 11:28:11.919024: serving on Teller1 by staff, 2025-06-24 11:28:31.918543: ticket transferred to Releasing, 2025-06-24 11:28:54.422304: serving on Teller1 by staff, 2025-06-24 12:39:09.854647: ticket session finished', 0, 'None', 1, 1, ''),
(64, '2025-07-01 16:44:25.595', '001', 'S', 'SUBMISSION OF SALN', 'staff', 'Teller', 1, '2025-07-02 16:56:44.280', '2025-07-02 16:58:08.932', 'Done', '2025-07-01 16:44:25.595: ticketGenerated, 2025-07-02 16:56:44.280: serving on Teller1 by staff, 2025-07-02 16:58:08.932: ticket session finished', 0, 'None', 1, 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `pass` text NOT NULL,
  `userType` text NOT NULL,
  `serviceType` text NOT NULL,
  `username` text NOT NULL,
  `loggedIn` text DEFAULT NULL,
  `servicesSet` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `pass`, `userType`, `serviceType`, `username`, `loggedIn`, `servicesSet`) VALUES
(2, 'admin', 'Admin', '', 'admin', NULL, ''),
(11, 'staff', 'Staff', '[SUBMISSION OF SALN, REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE]', 'staff', '2025-07-02 17:17:16.317', '[SUBMISSION OF SALN, REDRESS OF CLIENTS\' COMPLAINTS & GRIEVANCE]');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
