-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 03, 2024 at 10:18 AM
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
-- Database: `angat_sikat_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `budget_allocation`
--

CREATE TABLE `budget_allocation` (
  `allocation_id` int(11) NOT NULL,
  `organization_id` int(11) NOT NULL,
  `category` enum('Activities','Purchases','Maintenance and Other Expenses') NOT NULL,
  `allocated_budget` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_spent` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `budget_allocation`
--

INSERT INTO `budget_allocation` (`allocation_id`, `organization_id`, `category`, `allocated_budget`, `total_spent`, `created_at`, `updated_at`) VALUES
(1, 1, 'Activities', 30000.00, 2500.00, '2024-09-22 17:46:30', '2024-10-22 13:47:19'),
(2, 1, 'Purchases', 6500.00, 1200.00, '2024-09-22 17:46:30', '2024-10-08 17:26:50'),
(3, 1, 'Maintenance and Other Expenses', 28000.00, 800.00, '2024-09-22 17:46:30', '2024-10-08 17:26:33');

-- --------------------------------------------------------

--
-- Table structure for table `budget_approvals`
--

CREATE TABLE `budget_approvals` (
  `approval_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `category` enum('Events','Purchases','Maintenance') NOT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `status` enum('Pending','Approved','Disapproved') DEFAULT 'Pending',
  `organization_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `archived` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `budget_approvals`
--

INSERT INTO `budget_approvals` (`approval_id`, `title`, `category`, `attachment`, `status`, `organization_id`, `created_by`, `created_at`, `archived`) VALUES
(1, 'Merch Sale', 'Events', 'Doc1.docx', 'Approved', 1, 1, '2024-09-22 21:38:02', 0),
(3, 'Bytes and Pixels', 'Events', '8749da4e528f2cf87f22980a0100ef8c.jpg', 'Approved', 1, 1, '2024-09-22 21:48:22', 0),
(4, 'Office Supplies', 'Purchases', 'Project1.layout', 'Approved', 1, 1, '2024-09-22 21:48:42', 0),
(5, 'AI Seminar', 'Events', '551f198530c37fededbd7f5b817747f9.jpg', 'Pending', 1, 1, '2024-09-23 07:11:57', 0),
(6, 'TechFest', 'Events', 'STUB.docx', 'Approved', 1, 1, '2024-09-23 07:34:43', 0),
(7, 'Film Festival', 'Events', 'Doc3.docx', 'Pending', 1, 1, '2024-09-23 10:42:22', 0),
(8, '7th Gawad Parangal', 'Events', 'Doc1.docx', 'Approved', 1, 1, '2024-09-23 11:17:45', 0),
(9, 'Nexus Screening', 'Events', 'Budget_Request.jpg', 'Approved', 2, 1, '2024-09-24 15:55:12', 0),
(10, 'Training', 'Events', 'Payroll_Request.jpg', 'Pending', 2, 1, '2024-09-24 15:59:00', 0),
(11, 'College Press Conference', 'Events', 'Project_Proposal.png', 'Approved', 2, 1, '2024-09-24 16:00:12', 0),
(12, 'PACSA', 'Events', 'Payroll_Request.jpg', 'Pending', 2, 1, '2024-09-24 17:06:29', 0),
(13, 'LHEPC', 'Events', 'Payroll_Request.jpg', 'Pending', 2, 1, '2024-09-24 17:31:39', 0),
(14, 'Tabloid Distribution', 'Events', 'Payroll_Request.jpg', 'Pending', 2, 1, '2024-09-24 17:40:30', 0),
(15, 'U-Games', 'Events', 'Doc1.docx', 'Approved', 2, 1, '2024-10-04 07:34:41', 0),
(16, 'Promotional Video', 'Events', 'FIRST PERIODICAL AP REVIEWER.docx', 'Approved', 1, 1, '2024-10-08 17:37:17', 0);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `event_venue` varchar(255) NOT NULL,
  `event_start_date` date NOT NULL,
  `event_end_date` date NOT NULL,
  `event_type` varchar(100) DEFAULT NULL,
  `event_status` enum('Pending','Approved','Disapproved') NOT NULL,
  `accomplishment_status` tinyint(1) DEFAULT 0,
  `organization_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `archived` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `title`, `event_venue`, `event_start_date`, `event_end_date`, `event_type`, `event_status`, `accomplishment_status`, `organization_id`, `created_by`, `created_at`, `archived`) VALUES
(1, 'Test', 'Technovation Center', '2024-09-14', '2024-09-14', 'Expense', 'Pending', 1, NULL, NULL, '2024-09-08 09:30:20', 1),
(2, 'Test Edit Again', 'Technovation Center', '2024-09-14', '2024-09-15', 'Expense', 'Pending', 0, 1, NULL, '2024-09-08 09:32:31', 1),
(3, 'ConAss', 'Student Center Building', '2024-09-09', '2024-09-09', 'Expense', 'Pending', 1, 1, NULL, '2024-09-08 10:15:44', 1),
(4, 'Gawad Parangal', 'Court I', '2024-11-28', '2024-11-28', 'Expense', 'Pending', 0, 1, NULL, '2024-09-08 10:34:11', 1),
(5, 'TechFest', 'Court I', '2024-09-29', '2024-09-30', 'Expense', 'Approved', 1, NULL, NULL, '2024-09-21 16:07:08', 0),
(6, 'Trojan\'s Night', 'CvSU Hostel', '2024-09-10', '2024-09-12', 'Expense', 'Approved', 1, NULL, NULL, '2024-09-22 07:33:45', 1),
(7, 'Bytes and Pixels', 'CCL-7', '2024-09-02', '2024-09-03', 'Expense', 'Approved', 1, NULL, NULL, '2024-09-22 12:44:37', 0),
(8, 'Merch Sale', 'Department of Computer Studies', '2024-09-23', '2024-09-29', 'Expense', 'Approved', 1, 1, NULL, '2024-09-22 12:45:49', 0),
(9, 'Film Festival', 'Department of Computer Studies', '2024-09-08', '2024-09-14', 'Income', 'Pending', 0, 1, NULL, '2024-09-22 15:20:28', 1),
(10, 'AI Seminar', 'Technovation Center', '2024-09-24', '2024-09-26', 'Expense', 'Pending', 0, 1, NULL, '2024-09-22 15:21:48', 1),
(11, '7th Gawad Parangal', 'Court I', '2024-09-10', '2024-09-12', 'Expense', 'Approved', 0, 1, NULL, '2024-09-23 11:17:22', 1),
(12, 'Drag Race', 'Court II', '2024-09-30', '2024-10-02', 'Income', 'Pending', 0, 1, NULL, '2024-09-24 14:41:21', 1),
(13, 'Nexus Screening', 'OCA', '2024-09-27', '2024-09-29', 'Expense', 'Approved', 1, 2, NULL, '2024-09-24 15:46:14', 0),
(14, 'Training', 'Student Center Building', '2025-01-13', '2025-01-19', 'Expense', 'Pending', 0, 2, NULL, '2024-09-24 15:48:42', 0),
(15, 'College Press Conference', 'CvSU-CCAT', '2024-10-26', '2024-09-28', 'Expense', 'Approved', 0, 2, NULL, '2024-09-24 15:50:29', 0),
(16, 'PACSA', 'Alfonso, Cavite', '2024-11-21', '2024-11-24', 'Expense', 'Pending', 0, 2, NULL, '2024-09-24 17:04:25', 0),
(17, 'LHEPC', 'Lucban, Quezon', '2025-01-20', '2025-01-23', 'Income', 'Pending', 1, 2, NULL, '2024-09-24 17:09:39', 0),
(18, 'Tabloid Distribution', 'Student Center Building', '2024-09-15', '2024-09-17', 'Income', '', 0, 2, NULL, '2024-09-24 17:39:49', 1),
(19, 'U-Games', 'CvSU-Main Campus', '2024-10-07', '2024-10-11', 'Expense', 'Approved', 0, 2, NULL, '2024-10-04 07:32:31', 0),
(20, 'Promotional Video', 'DCS', '2024-10-21', '2024-10-26', 'Expense', 'Approved', 0, 1, NULL, '2024-10-08 17:28:32', 0),
(21, 'Accreditation', 'DCS', '2024-11-27', '2024-10-29', 'Expense', 'Pending', 0, 1, NULL, '2024-10-22 13:52:31', 0);

-- --------------------------------------------------------

--
-- Table structure for table `event_items`
--

CREATE TABLE `event_items` (
  `item_id` int(11) NOT NULL,
  `event_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(10,2) GENERATED ALWAYS AS (`quantity` * `amount`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event_items`
--

INSERT INTO `event_items` (`item_id`, `event_id`, `description`, `quantity`, `unit`, `amount`) VALUES
(1, 5, 'Test I', 5, '1', 30.00),
(2, NULL, 'Test I', 5, '1', 30.00),
(5, 6, 'Food Allowance', 20, '0', 45.00),
(8, 7, 'Test', 5, '1', 46.00),
(9, 10, 'Speakers', 2, '1', 40.00),
(10, 10, 'Laptop', 1, '1', 25.00),
(11, 10, 'Chairs', 50, '1', 30.00),
(13, 13, 'Food Allowance', 40, '1', 75.00),
(14, 19, 'Food Allowance', 40, '1', 75.00),
(15, 8, 'BYTE Lanyard', 300, '1', 80.00),
(16, 8, 'BYTE Shirt', 300, '1', 400.00),
(17, 20, 'Multimedia Fees', 1, '1', 1000.00);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `expense_id` int(11) NOT NULL,
  `organization_id` int(11) NOT NULL,
  `category` enum('Activities','Purchases','Maintenance') NOT NULL,
  `title` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`expense_id`, `organization_id`, `category`, `title`, `amount`, `reference`, `created_at`) VALUES
(1, 1, 'Activities', 'Sports Day Supplies', 1200.00, 'sports_day_supplies.pdf', '2024-10-04 15:38:44'),
(2, 1, 'Purchases', 'Office Stationery', 850.00, 'office_stationery.pdf', '2024-10-04 15:38:44'),
(3, 1, 'Maintenance', 'Building Repair', 4500.00, 'building_repair.pdf', '2024-10-04 15:38:44'),
(4, 1, 'Activities', 'End of Year Party', 1500.00, 'year_end_party.pdf', '2024-10-04 15:38:44'),
(5, 1, 'Purchases', 'Food for Meeting', 700.00, 'meeting_food.pdf', '2024-10-04 15:38:44'),
(6, 1, 'Activities', 'Workshop', 18750.00, 'LR 001', '2024-10-04 16:05:14');

-- --------------------------------------------------------

--
-- Table structure for table `maintenance`
--

CREATE TABLE `maintenance` (
  `maintenance_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `total_budget` decimal(10,2) DEFAULT 0.00,
  `maintenance_status` enum('pending','approved','disapproved') DEFAULT 'pending',
  `completion_status` tinyint(1) DEFAULT 0,
  `organization_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `archived` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE `organizations` (
  `organization_id` int(11) NOT NULL,
  `organization_name` varchar(255) NOT NULL,
  `organization_logo` varchar(255) DEFAULT NULL,
  `organization_members` int(11) NOT NULL DEFAULT 0,
  `organization_status` enum('Probationary','Level I','Level II') NOT NULL DEFAULT 'Probationary',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `balance` decimal(15,2) DEFAULT 0.00,
  `beginning_balance` decimal(15,2) DEFAULT 0.00,
  `cash_on_bank` decimal(15,2) DEFAULT 0.00,
  `cash_on_hand` decimal(15,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `organizations`
--

INSERT INTO `organizations` (`organization_id`, `organization_name`, `organization_logo`, `organization_members`, `organization_status`, `created_at`, `balance`, `beginning_balance`, `cash_on_bank`, `cash_on_hand`) VALUES
(1, 'Beacon of Youth Technology Enthusiasts', NULL, 500, 'Level I', '2024-09-22 12:16:55', 22500.00, 50000.00, 22000.00, 500.00),
(2, 'The CvSU-R Nexus', NULL, 20, 'Level I', '2024-09-22 12:17:31', 110000.00, 120000.00, 100000.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `purchase_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `total_budget` decimal(10,2) DEFAULT 0.00,
  `purchase_status` enum('Pending','Approved','Disapproved') NOT NULL DEFAULT 'Pending',
  `completion_status` tinyint(1) DEFAULT 0,
  `archived` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `organization_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`purchase_id`, `title`, `total_budget`, `purchase_status`, `completion_status`, `archived`, `created_at`, `organization_id`, `created_by`) VALUES
(1, 'Office Supplies', 0.00, 'Approved', 1, 0, '2024-09-22 18:42:38', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_items`
--

CREATE TABLE `purchase_items` (
  `item_id` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) GENERATED ALWAYS AS (`quantity` * `amount`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchase_items`
--

INSERT INTO `purchase_items` (`item_id`, `purchase_id`, `description`, `quantity`, `unit`, `amount`) VALUES
(1, 1, 'A4 Paper', 3.00, '1', 100.00),
(2, 1, 'Ballpen', 20.00, '1', 15.00);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('admin','officer','member') NOT NULL,
  `organization_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `first_name`, `last_name`, `email`, `role`, `organization_id`) VALUES
(1, 'sayilisayily', '1234', 'Zylei', 'Sugue', 'zylei.sugue@cvsu.edu.ph', 'officer', 1),
(2, 'cervyramos', '$2y$10$KcqtqSw/M76nW84YD3EbWOXl.XJVkHLPR2AV5eo2g1Pyv/z/QlVxC', 'Cervy', 'Ramos', 'cervyramos@gmail.com', 'officer', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `budget_allocation`
--
ALTER TABLE `budget_allocation`
  ADD PRIMARY KEY (`allocation_id`),
  ADD KEY `organization_id` (`organization_id`);

--
-- Indexes for table `budget_approvals`
--
ALTER TABLE `budget_approvals`
  ADD PRIMARY KEY (`approval_id`),
  ADD KEY `fk_organization` (`organization_id`),
  ADD KEY `fk_user` (`created_by`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `organization_id` (`organization_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `event_items`
--
ALTER TABLE `event_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`expense_id`),
  ADD KEY `organization_id` (`organization_id`);

--
-- Indexes for table `maintenance`
--
ALTER TABLE `maintenance`
  ADD PRIMARY KEY (`maintenance_id`),
  ADD KEY `fk_organization_maintenance` (`organization_id`),
  ADD KEY `fk_user_maintenance` (`created_by`);

--
-- Indexes for table `organizations`
--
ALTER TABLE `organizations`
  ADD PRIMARY KEY (`organization_id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`purchase_id`),
  ADD KEY `fk_organization_id` (`organization_id`),
  ADD KEY `fk_created_by` (`created_by`);

--
-- Indexes for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `purchase_id` (`purchase_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `organization_id` (`organization_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `budget_allocation`
--
ALTER TABLE `budget_allocation`
  MODIFY `allocation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `budget_approvals`
--
ALTER TABLE `budget_approvals`
  MODIFY `approval_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `event_items`
--
ALTER TABLE `event_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `expense_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `maintenance`
--
ALTER TABLE `maintenance`
  MODIFY `maintenance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `organizations`
--
ALTER TABLE `organizations`
  MODIFY `organization_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `budget_allocation`
--
ALTER TABLE `budget_allocation`
  ADD CONSTRAINT `budget_allocation_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`) ON DELETE CASCADE;

--
-- Constraints for table `budget_approvals`
--
ALTER TABLE `budget_approvals`
  ADD CONSTRAINT `fk_organization` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `events_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `event_items`
--
ALTER TABLE `event_items`
  ADD CONSTRAINT `event_items_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`);

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`) ON DELETE CASCADE;

--
-- Constraints for table `maintenance`
--
ALTER TABLE `maintenance`
  ADD CONSTRAINT `fk_organization_maintenance` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_maintenance` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `fk_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD CONSTRAINT `purchase_items_ibfk_1` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`purchase_id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
