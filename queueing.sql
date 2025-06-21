-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 21, 2025 at 06:43 AM
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
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `controls`
--

INSERT INTO `controls` (`id`, `controlName`, `value`) VALUES
(1, 'Priority Option', 1),
(2, 'Ticket Name Option', 1),
(3, 'Video in Queue Display', 1);

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `name` text NOT NULL,
  `id` int(11) NOT NULL,
  `link` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`name`, `id`, `link`) VALUES
('Queue Display Video', 1, 0x68747470733a2f2f7777772e796f75747562652e636f6d2f77617463683f763d4a787736466141306a3349);

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
(6, 'Evaluation', 'E', '_MAIN_'),
(8, 'Releasing', 'R', '_MAIN_'),
(9, 'Payment', 'P', '_MAIN_'),
(10, 'Cashier', 'C', '_MAIN_');

-- --------------------------------------------------------

--
-- Table structure for table `servicegroup`
--

CREATE TABLE `servicegroup` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `assignedGroup` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `servicegroup`
--

INSERT INTO `servicegroup` (`id`, `name`, `assignedGroup`) VALUES
(5, 'Law 1 Subgroup', 'Law');

-- --------------------------------------------------------

--
-- Table structure for table `station`
--

CREATE TABLE `station` (
  `id` int(11) NOT NULL,
  `stationNumber` int(11) NOT NULL,
  `inSession` int(11) NOT NULL,
  `userInSession` text NOT NULL,
  `serviceType` text NOT NULL,
  `ticketServing` text NOT NULL,
  `stationName` text NOT NULL,
  `sessionPing` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `station`
--

INSERT INTO `station` (`id`, `stationNumber`, `inSession`, `userInSession`, `serviceType`, `ticketServing`, `stationName`, `sessionPing`) VALUES
(5, 1, 0, '', 'Evaluation', '', 'Teller', ''),
(6, 2, 0, '', 'Releasing', '', 'Teller', '');

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
(34, '2025-06-19 16:45:20.075', '001', 'E', 'Evaluation', 'staff1', 'Teller', 1, '2025-06-19 16:46:08.685', '', 'Serving', '2025-06-19 16:45:20.075: ticketGenerated, 2025-06-19 16:46:08.685: serving on Teller1 by staff1', 0, 'None', 1, 1, '');

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
(2, 'admin', 'Admin', '', 'admin', '2025-06-13 21:43:13.235', NULL),
(8, 'staff1', 'Staff', '[Evaluation, Cashier]', 'staff1', '2025-06-19 16:46:18.356', '[Evaluation, Cashier]'),
(9, 'staff', 'Staff', '[Releasing, Payment]', 'staff', '2025-06-19 16:45:59.552', '[Releasing, Payment]');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `priorities`
--
ALTER TABLE `priorities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `servicegroup`
--
ALTER TABLE `servicegroup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `station`
--
ALTER TABLE `station`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
