-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 19, 2025 at 02:53 PM
-- Server version: 11.8.3-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u559191231_medsavedb`
--

-- --------------------------------------------------------

--
-- Table structure for table `ai_feedback`
--

CREATE TABLE `ai_feedback` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `was_correct` tinyint(1) NOT NULL,
  `feedback_notes` text DEFAULT NULL,
  `health_worker_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `health_centers`
--

CREATE TABLE `health_centers` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `level` enum('Primary','Secondary','Tertiary') NOT NULL,
  `specialties` text DEFAULT NULL,
  `distance` varchar(50) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `health_centers`
--

INSERT INTO `health_centers` (`id`, `name`, `level`, `specialties`, `distance`, `contact`, `address`, `latitude`, `longitude`, `created_at`) VALUES
(1, 'Mulago National Referral Hospital', 'Tertiary', 'High-risk Obstetrics,Neonatal ICU,Emergency C-Section,Maternal Medicine', '5 km', '+256-414-554-000', 'Mulago Hill, Kampala', NULL, NULL, '2025-10-19 13:19:20'),
(2, 'Kawempe General Hospital', 'Secondary', 'General Obstetrics,Labor Ward,Basic Emergency,Antenatal Care', '3 km', '+256-414-540-298', 'Kawempe, Kampala', NULL, NULL, '2025-10-19 13:19:20'),
(3, 'Kisenyi Health Center IV', 'Primary', 'Antenatal Care,Normal Delivery,Postnatal Care,Family Planning', '1 km', '+256-414-344-556', 'Kisenyi, Kampala', NULL, NULL, '2025-10-19 13:19:20'),
(4, 'Nsambya Hospital', 'Tertiary', 'High-risk Obstetrics,Pediatric Care,Emergency Services,ICU', '4 km', '+256-414-267-051', 'Nsambya, Kampala', NULL, NULL, '2025-10-19 13:19:20'),
(5, 'Naguru General Hospital', 'Secondary', 'Obstetrics,General Medicine,Laboratory Services', '6 km', '+256-414-234-567', 'Naguru, Kampala', NULL, NULL, '2025-10-19 13:19:20');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `age` int(11) NOT NULL,
  `gestational_age` int(11) NOT NULL,
  `blood_pressure` varchar(20) NOT NULL,
  `temperature` decimal(4,2) NOT NULL,
  `heart_rate` int(11) NOT NULL,
  `symptoms` text NOT NULL,
  `medical_history` text DEFAULT NULL,
  `current_medication` text DEFAULT NULL,
  `allergies` text DEFAULT NULL,
  `previous_pregnancies` text DEFAULT NULL,
  `complications` text DEFAULT NULL,
  `risk_score` int(11) NOT NULL,
  `urgency_level` enum('EMERGENCY','MEDIUM','LOW') NOT NULL,
  `risk_factors` text DEFAULT NULL,
  `recommended_center_id` int(11) DEFAULT NULL,
  `ai_clinical_support` text DEFAULT NULL,
  `whatsapp_alert_sent` tinyint(1) DEFAULT 0,
  `feedback_provided` tinyint(1) DEFAULT 0,
  `feedback_correct` tinyint(1) DEFAULT NULL,
  `registered_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `referrals`
--

CREATE TABLE `referrals` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `from_center` varchar(200) DEFAULT NULL,
  `to_center_id` int(11) NOT NULL,
  `urgency_level` varchar(20) DEFAULT NULL,
  `status` enum('pending','accepted','completed','rejected') DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` enum('admin','doctor','nurse') DEFAULT 'nurse',
  `health_center` varchar(200) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `full_name`, `email`, `role`, `health_center`, `created_at`) VALUES
(1, 'admin', '$2y$10$LeU8lc5NFCoNAoFz12OFFeh4Q2qj0t3fym.VAR29YX6C6cHC69TqK', 'System Administrator', NULL, 'admin', 'Central Admin', '2025-10-19 13:19:20'),
(2, 'medsave', 'medsave', 'medsave', 'ssenogab999@gmail.com', 'nurse', 'mulago', '2025-10-19 17:19:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ai_feedback`
--
ALTER TABLE `ai_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `health_worker_id` (`health_worker_id`);

--
-- Indexes for table `health_centers`
--
ALTER TABLE `health_centers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recommended_center_id` (`recommended_center_id`),
  ADD KEY `registered_by` (`registered_by`);

--
-- Indexes for table `referrals`
--
ALTER TABLE `referrals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `to_center_id` (`to_center_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ai_feedback`
--
ALTER TABLE `ai_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `health_centers`
--
ALTER TABLE `health_centers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `referrals`
--
ALTER TABLE `referrals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ai_feedback`
--
ALTER TABLE `ai_feedback`
  ADD CONSTRAINT `ai_feedback_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`),
  ADD CONSTRAINT `ai_feedback_ibfk_2` FOREIGN KEY (`health_worker_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`recommended_center_id`) REFERENCES `health_centers` (`id`),
  ADD CONSTRAINT `patients_ibfk_2` FOREIGN KEY (`registered_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `referrals`
--
ALTER TABLE `referrals`
  ADD CONSTRAINT `referrals_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`),
  ADD CONSTRAINT `referrals_ibfk_2` FOREIGN KEY (`to_center_id`) REFERENCES `health_centers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
