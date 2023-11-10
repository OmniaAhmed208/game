-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 11, 2023 at 12:51 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `social_media_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `apis`
--

CREATE TABLE `apis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `creator_id` bigint(20) UNSIGNED NOT NULL,
  `account_type` varchar(255) NOT NULL,
  `account_id` varchar(255) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `account_pic` text DEFAULT NULL,
  `account_link` text NOT NULL,
  `token` varchar(1000) NOT NULL,
  `token_secret` varchar(1000) DEFAULT NULL,
  `update_interval` int(11) NOT NULL DEFAULT 60,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `apis`
--

INSERT INTO `apis` (`id`, `creator_id`, `account_type`, `account_id`, `account_name`, `email`, `account_pic`, `account_link`, `token`, `token_secret`, `update_interval`, `created_at`, `updated_at`) VALUES
(1, 1, 'twitter', '1708817086653386752', 'evolve inc', 'evolve.teck@gmail.com', '/storage/profile_images/1699446013.png', 'https://twitter.com/EvolveTeck', '1708817086653386752-rrWnFqX4ALKzZMXWgYdhaatcj7Il2f', 'FFgoPOWMuGuI1Zfx5pZBphOEWBPSpyYtS7G4jPPs1K5X0', 3000, '2023-11-07 07:16:11', '2023-11-07 07:16:11'),
(2, 1, 'twitter', '1708817086653386752', 'evolve inc', 'evolve.teck@gmail.com', '/storage/profile_images/1699446013.png', 'https://twitter.com/EvolveTeck', '1708817086653386752-rrWnFqX4ALKzZMXWgYdhaatcj7Il2f', 'FFgoPOWMuGuI1Zfx5pZBphOEWBPSpyYtS7G4jPPs1K5X0', 3000, '2023-11-07 07:16:11', '2023-11-08 10:20:13'),
(3, 2, 'twitter', '1708817086653386752', 'evolve inc', 'evolve.teck@gmail.com', '/storage/profile_images/1699446013.png', 'https://twitter.com/EvolveTeck', '1708817086653386752-rrWnFqX4ALKzZMXWgYdhaatcj7Il2f', 'FFgoPOWMuGuI1Zfx5pZBphOEWBPSpyYtS7G4jPPs1K5X0', 3000, '2023-11-07 07:16:11', '2023-11-08 10:20:13');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `instagrams`
--

CREATE TABLE `instagrams` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `insta_name` varchar(255) NOT NULL,
  `insta_token` varchar(1000) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `msg` varchar(255) DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `sender` varchar(255) NOT NULL,
  `receiver` varchar(255) NOT NULL,
  `is_seen` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2014_10_12_100000_create_password_resets_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2023_07_10_193132_create_apis_table', 1),
(7, '2023_07_11_085533_create_instagrams_table', 1),
(8, '2023_07_25_120359_create_social_posts_table', 1),
(9, '2023_08_21_101501_create_time_thinks_table', 1),
(10, '2023_09_06_140331_create_youtube_categories_table', 1),
(11, '2023_09_06_141453_create_settings_apis_table', 1),
(12, '2023_09_07_084231_create_publish_posts_table', 1),
(13, '2023_10_17_133937_create_post_images_table', 1),
(14, '2023_10_21_124254_create_permission_tables', 1),
(15, '2023_10_21_145259_create_user_has_roles_table', 1),
(16, '2023_10_24_131038_create_post_videos_table', 1),
(17, '2023_07_08_112058_create_messages_table', 2),
(18, '2023_07_19_081931_update_users', 2),
(28, '2023_11_07_142535_create_subscribers_table', 3),
(29, '2023_11_09_095934_create_subscriber_requests_table', 3),
(31, '2023_11_09_114219_create_news_letters_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `news_letters`
--

CREATE TABLE `news_letters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `creator_id` bigint(20) UNSIGNED NOT NULL,
  `title` text NOT NULL,
  `content` text DEFAULT NULL,
  `image` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news_letters`
--

INSERT INTO `news_letters` (`id`, `creator_id`, `title`, `content`, `image`, `created_at`, `updated_at`) VALUES
(1, 1, 'Card title that wraps to a new line', 'This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.', '/storage/uploadImages/5.jpg', '2023-11-09 12:37:24', '2023-11-10 20:33:31'),
(2, 1, 'A well-known quote, contained in a blockquote element.', '- Someone famous in Source Title', NULL, '2023-11-09 12:37:24', '2023-11-09 12:37:24'),
(3, 1, 'Card title that wraps to a new line', 'This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.', '/storage/uploadImages/18.jpg', '2023-11-09 12:37:24', '2023-11-09 12:37:24'),
(4, 1, 'A well-known quote, contained in a blockquote element.', 'This card has supporting text below as a natural lead-in to additional content.', NULL, '2023-11-09 12:37:24', '2023-11-09 12:37:24'),
(6, 1, 'Card title that wraps to a new line', 'This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.', '/storage/uploadImages/1.jpg', '2023-11-09 12:37:24', '2023-11-09 12:37:24');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(7, 'App\\Models\\User', 2, 'API TOKEN', 'ff0f9ac1367165c4eef1b2a8bca57b14c61374f4bb58c84ee3fbaca31485c7bd', '[\"*\"]', '2023-11-09 07:07:04', NULL, '2023-11-08 07:32:18', '2023-11-09 07:07:04'),
(9, 'App\\Models\\User', 1, 'API TOKEN', '2b9c826ece27b16a4321e93b37ddc386c440d9ba1902d8cafd501025493a22f2', '[\"*\"]', '2023-11-08 13:57:57', NULL, '2023-11-08 13:57:10', '2023-11-08 13:57:57');

-- --------------------------------------------------------

--
-- Table structure for table `post_images`
--

CREATE TABLE `post_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `creator_id` bigint(20) UNSIGNED DEFAULT NULL,
  `image` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_images`
--

INSERT INTO `post_images` (`id`, `post_id`, `creator_id`, `image`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '/storage/uploadImages/1699105915_1695127412.png', '2023-11-07 07:27:31', '2023-11-07 07:27:31'),
(3, 5, 1, '/storage/uploadImages/1699105915_1695127412.png', '2023-11-07 11:11:07', '2023-11-07 11:11:07'),
(5, 7, 1, '/storage/uploadImages/1699105915_1695127412.png', '2023-11-07 11:15:30', '2023-11-07 11:15:30'),
(6, 8, 1, '/storage/uploadImages/1699105915_1695127412.png', '2023-11-07 11:17:09', '2023-11-07 11:17:09'),
(8, 9, 1, '/storage/uploadImages/1699443663_1695127412.png', '2023-11-08 09:41:09', '2023-11-08 09:41:09');

-- --------------------------------------------------------

--
-- Table structure for table `post_videos`
--

CREATE TABLE `post_videos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `creator_id` bigint(20) UNSIGNED NOT NULL,
  `video` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publish_posts`
--

CREATE TABLE `publish_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `creator_id` bigint(20) UNSIGNED DEFAULT NULL,
  `account_type` varchar(255) NOT NULL,
  `account_id` varchar(255) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `thumbnail` text DEFAULT NULL,
  `link` text DEFAULT NULL,
  `post_title` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `youtube_privacy` varchar(255) DEFAULT NULL,
  `youtube_tags` text DEFAULT NULL,
  `youtube_category` bigint(20) UNSIGNED DEFAULT NULL,
  `scheduledTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tokenApp` varchar(1000) NOT NULL,
  `token_secret` varchar(1000) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `publish_posts`
--

INSERT INTO `publish_posts` (`id`, `creator_id`, `account_type`, `account_id`, `account_name`, `status`, `thumbnail`, `link`, `post_title`, `content`, `youtube_privacy`, `youtube_tags`, `youtube_category`, `scheduledTime`, `tokenApp`, `token_secret`, `created_at`, `updated_at`) VALUES
(1, 2, 'twitter', '1708817086653386752', 'evolve inc', 'pending', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-11-09 08:55:57', '1708817086653386752-rrWnFqX4ALKzZMXWgYdhaatcj7Il2f', 'FFgoPOWMuGuI1Zfx5pZBphOEWBPSpyYtS7G4jPPs1K5X0', '2023-11-07 07:17:56', '2023-11-09 06:55:57'),
(2, 1, 'twitter', '1708817086653386752', 'evolve inc', 'pending', NULL, NULL, NULL, 'post2', NULL, NULL, NULL, '2023-11-09 08:25:36', '1708817086653386752-rrWnFqX4ALKzZMXWgYdhaatcj7Il2f', 'FFgoPOWMuGuI1Zfx5pZBphOEWBPSpyYtS7G4jPPs1K5X0', '2023-11-07 07:27:31', '2023-11-09 06:25:36'),
(4, 1, 'twitter', '1708817086653386752', 'evolve inc', 'published', NULL, NULL, NULL, 'post', NULL, NULL, NULL, '2023-11-08 12:15:06', '1708817086653386752-rrWnFqX4ALKzZMXWgYdhaatcj7Il2f', 'FFgoPOWMuGuI1Zfx5pZBphOEWBPSpyYtS7G4jPPs1K5X0', '2023-11-07 07:27:31', '2023-11-08 10:15:06'),
(5, 1, 'twitter', '1708817086653386752', 'evolve inc', 'published', NULL, NULL, NULL, 'hgfhg', NULL, NULL, NULL, '2023-11-07 13:11:00', '1708817086653386752-rrWnFqX4ALKzZMXWgYdhaatcj7Il2f', 'FFgoPOWMuGuI1Zfx5pZBphOEWBPSpyYtS7G4jPPs1K5X0', '2023-11-07 11:11:07', '2023-11-07 11:11:07'),
(7, 1, 'twitter', '1708817086653386752', 'evolve inc', 'published', NULL, NULL, NULL, 'lklkm', NULL, NULL, NULL, '2023-11-07 13:15:00', '1708817086653386752-rrWnFqX4ALKzZMXWgYdhaatcj7Il2f', 'FFgoPOWMuGuI1Zfx5pZBphOEWBPSpyYtS7G4jPPs1K5X0', '2023-11-07 11:15:30', '2023-11-07 11:15:30'),
(8, 2, 'twitter', '1708817086653386752', 'evolve inc', 'published', NULL, NULL, NULL, 'test', NULL, NULL, NULL, '2023-11-08 11:09:28', '1708817086653386752-rrWnFqX4ALKzZMXWgYdhaatcj7Il2f', 'FFgoPOWMuGuI1Zfx5pZBphOEWBPSpyYtS7G4jPPs1K5X0', '2023-11-07 11:17:09', '2023-11-07 11:17:09'),
(9, 2, 'twitter', '1708817086653386752', 'evolve inc', 'published', NULL, NULL, NULL, '', NULL, NULL, NULL, '2023-11-08 15:12:49', '1708817086653386752-rrWnFqX4ALKzZMXWgYdhaatcj7Il2f', 'FFgoPOWMuGuI1Zfx5pZBphOEWBPSpyYtS7G4jPPs1K5X0', '2023-11-08 09:41:09', '2023-11-08 09:41:09');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `role_color` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings_apis`
--

CREATE TABLE `settings_apis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `creator_id` bigint(20) UNSIGNED NOT NULL,
  `appType` varchar(255) NOT NULL,
  `appID` varchar(255) NOT NULL,
  `appSecret` varchar(1000) NOT NULL,
  `apiKey` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings_apis`
--

INSERT INTO `settings_apis` (`id`, `creator_id`, `appType`, `appID`, `appSecret`, `apiKey`, `created_at`, `updated_at`) VALUES
(1, 1, 'facebook', '690179252628964', '9ac7abd4768f0bcf9c92779dd406b4d0', NULL, '2023-11-07 07:14:39', '2023-11-07 07:14:39'),
(2, 1, 'twitter', 'fz6f2j9VUq8KFoE6b8mzLXAOg', '0APmDjmsBNAHgS4kyZQ1iZ5byCP8jItcx0WNmWMPnVv8ahPDuK', NULL, '2023-11-07 07:15:05', '2023-11-07 11:08:56'),
(3, 1, 'youtube', '400800346626-3pj9lb5923bmurej4bk6ql2v2rm29kco.apps.googleusercontent.com', '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', 'AIzaSyCZhW13YQV1En4FEtVET312rRwIbAj3Rp4', '2023-11-07 07:15:38', '2023-11-07 07:15:38');

-- --------------------------------------------------------

--
-- Table structure for table `social_posts`
--

CREATE TABLE `social_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `api_account_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` varchar(255) NOT NULL,
  `post_img` text DEFAULT NULL,
  `post_video` text DEFAULT NULL,
  `post_link` text NOT NULL,
  `post_title` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `post_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscribers`
--

INSERT INTO `subscribers` (`id`, `email`, `created_at`, `updated_at`) VALUES
(1, 'admin@gmail.com', '2023-11-09 08:56:26', '2023-11-09 08:56:26'),
(2, 'user@gmail.com', '2023-11-09 08:56:41', '2023-11-09 08:56:41'),
(3, 'user2@gmail.com', '2023-11-09 08:56:41', '2023-11-09 08:56:41');

-- --------------------------------------------------------

--
-- Table structure for table `subscriber_requests`
--

CREATE TABLE `subscriber_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `subscriber_id` bigint(20) UNSIGNED NOT NULL,
  `service_name` varchar(255) NOT NULL,
  `reason` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscriber_requests`
--

INSERT INTO `subscriber_requests` (`id`, `subscriber_id`, `service_name`, `reason`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'v', NULL, NULL, '2023-11-09 08:56:26', '2023-11-09 08:56:26'),
(2, 2, 'v', NULL, NULL, '2023-11-09 08:57:02', '2023-11-09 08:57:02'),
(3, 1, 'v', NULL, NULL, '2023-11-09 09:04:19', '2023-11-09 09:04:19');

-- --------------------------------------------------------

--
-- Table structure for table `time_thinks`
--

CREATE TABLE `time_thinks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `creator_id` bigint(20) UNSIGNED NOT NULL,
  `time` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `time_thinks`
--

INSERT INTO `time_thinks` (`id`, `creator_id`, `time`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '2023-11-07 07:17:23', '2023-11-07 07:17:23'),
(2, 2, 2, '2023-11-07 07:17:23', '2023-11-07 07:17:23');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_type` varchar(255) NOT NULL DEFAULT 'user',
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_for_messages` varchar(255) NOT NULL DEFAULT 'user',
  `status_for_messages` varchar(255) NOT NULL DEFAULT 'offline'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `user_type`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `role_for_messages`, `status_for_messages`) VALUES
(1, 'Ahmed', 'admin', 'admin@gmail.com', NULL, '$2y$10$iRr8cmPtYzvj7BoHB1Y5d.QxvqgFjD3OYC3ZXwLqTjp6Y1JMezwlO', '8wG944tirFFVVO2ZDzB4y1rTNKo2mwJMMqgZwTssasq4P6rjidxLYx7Z6OSu', '2023-11-07 07:07:42', '2023-11-09 19:28:49', 'admin', 'online'),
(2, 'ali', 'user', 'ali@gmail.com', NULL, '$2y$10$iRr8cmPtYzvj7BoHB1Y5d.QxvqgFjD3OYC3ZXwLqTjp6Y1JMezwlO', 'ikJEDiKohXrNNhpAXKnyUm530yloAXhdEf4iuF9j2Raj0TRhoU4wVx5J8yby', '2023-11-07 07:07:42', '2023-11-08 10:21:31', 'user', 'offline');

-- --------------------------------------------------------

--
-- Table structure for table `user_has_roles`
--

CREATE TABLE `user_has_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `youtube_categories`
--

CREATE TABLE `youtube_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apis`
--
ALTER TABLE `apis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `apis_creator_id_foreign` (`creator_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `instagrams`
--
ALTER TABLE `instagrams`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `news_letters`
--
ALTER TABLE `news_letters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_letters_creator_id_foreign` (`creator_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `post_images`
--
ALTER TABLE `post_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_images_post_id_foreign` (`post_id`),
  ADD KEY `post_images_creator_id_foreign` (`creator_id`);

--
-- Indexes for table `post_videos`
--
ALTER TABLE `post_videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_videos_post_id_foreign` (`post_id`),
  ADD KEY `post_videos_creator_id_foreign` (`creator_id`);

--
-- Indexes for table `publish_posts`
--
ALTER TABLE `publish_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `publish_posts_creator_id_foreign` (`creator_id`),
  ADD KEY `publish_posts_youtube_category_foreign` (`youtube_category`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `settings_apis`
--
ALTER TABLE `settings_apis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `settings_apis_creator_id_foreign` (`creator_id`);

--
-- Indexes for table `social_posts`
--
ALTER TABLE `social_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `social_posts_api_account_id_foreign` (`api_account_id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriber_requests`
--
ALTER TABLE `subscriber_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscriber_requests_subscriber_id_foreign` (`subscriber_id`);

--
-- Indexes for table `time_thinks`
--
ALTER TABLE `time_thinks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `time_thinks_creator_id_foreign` (`creator_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_has_roles`
--
ALTER TABLE `user_has_roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_has_roles_user_id_foreign` (`user_id`),
  ADD KEY `user_has_roles_role_id_foreign` (`role_id`);

--
-- Indexes for table `youtube_categories`
--
ALTER TABLE `youtube_categories`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apis`
--
ALTER TABLE `apis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `instagrams`
--
ALTER TABLE `instagrams`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `news_letters`
--
ALTER TABLE `news_letters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `post_images`
--
ALTER TABLE `post_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `post_videos`
--
ALTER TABLE `post_videos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publish_posts`
--
ALTER TABLE `publish_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings_apis`
--
ALTER TABLE `settings_apis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `social_posts`
--
ALTER TABLE `social_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subscriber_requests`
--
ALTER TABLE `subscriber_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `time_thinks`
--
ALTER TABLE `time_thinks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_has_roles`
--
ALTER TABLE `user_has_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `youtube_categories`
--
ALTER TABLE `youtube_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `apis`
--
ALTER TABLE `apis`
  ADD CONSTRAINT `apis_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `news_letters`
--
ALTER TABLE `news_letters`
  ADD CONSTRAINT `news_letters_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `post_images`
--
ALTER TABLE `post_images`
  ADD CONSTRAINT `post_images_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `publish_posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `post_images_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `publish_posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `post_videos`
--
ALTER TABLE `post_videos`
  ADD CONSTRAINT `post_videos_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `publish_posts` (`creator_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `post_videos_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `publish_posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `publish_posts`
--
ALTER TABLE `publish_posts`
  ADD CONSTRAINT `publish_posts_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `publish_posts_youtube_category_foreign` FOREIGN KEY (`youtube_category`) REFERENCES `youtube_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `settings_apis`
--
ALTER TABLE `settings_apis`
  ADD CONSTRAINT `settings_apis_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `social_posts`
--
ALTER TABLE `social_posts`
  ADD CONSTRAINT `social_posts_api_account_id_foreign` FOREIGN KEY (`api_account_id`) REFERENCES `apis` (`id`);

--
-- Constraints for table `subscriber_requests`
--
ALTER TABLE `subscriber_requests`
  ADD CONSTRAINT `subscriber_requests_subscriber_id_foreign` FOREIGN KEY (`subscriber_id`) REFERENCES `subscribers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `time_thinks`
--
ALTER TABLE `time_thinks`
  ADD CONSTRAINT `time_thinks_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_has_roles`
--
ALTER TABLE `user_has_roles`
  ADD CONSTRAINT `user_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `user_has_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
