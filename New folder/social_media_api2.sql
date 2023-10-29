-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2023 at 04:35 PM
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
-- Database: `social_media_api2`
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
(2, 1, 'twitter', '1708817086653386752', 'EvolveTeck', 'EvolveTeck', NULL, 'https://twitter.com/intent/user?user_id=1708817086653386752', '1708817086653386752-WRyD6t3aHPtXsqQeyjokEhdjOlnrYq', '8MdlSMKR1hkgAsOKTPhMttQTZKFRoGmTs4GrPYFMEokNY', 2000, '2023-10-25 07:05:15', '2023-10-25 09:15:43'),
(3, 1, 'youtube', 'UCDtui0aBpRnx1eNAzq7eUHQ', 'evovle inc', 'evovle inc', 'https://yt3.ggpht.com/ytc/APkrFKZhta5mRe5QbypayrwKrcYOl2L65mX_uncGM8F4yVLU3GonpgFTrQ6j22XgIdLg=s240-c-k-c0xffffffff-no-rj-mo', 'https://www.youtube.com/channel/UCDtui0aBpRnx1eNAzq7eUHQ', 'ya29.a0AfB_byB9ZUyzCgAo7b5FlMknnV7SYCrX4pzdzpaoFipC-TEMt6KCD4v-JXsvVoPi_usZwGMVp-agZb8wHLbpiCP8Td-FjN9FBdM-EYMznCVO0FqqpwoxmEwLEttzPlvUHjz-L6KKeMs64dnJuwqwZE6u0apzFxSAyyemaCgYKAW0SARMSFQGOcNnCiGhnaAspFUBNCMq', '1//03OvEbi37WB3TCgYIARAAGAMSNwF-L9IreW7zjQ2dmbRQsoUx9UwIhY3-n4v--YSy4gw3s6KVuQLvDnRoGJNS0heO13RQr5-rSsQ', 2000, NULL, '2023-10-25 09:15:43'),
(4, 1, 'youtube', 'UCFfozYKZZoCfh_Rs9gMujhQ', 'technology', 'technology', 'https://yt3.ggpht.com/ytc/APkrFKZXFiTCCxbhxXfRcKFRhOaYzS0vBwSrqko1PsRT38ibgk9arbawHBA_hpYP5Bx_=s88-c-k-c0x00ffffff-no-rj', 'https://www.youtube.com/channel/UCFfozYKZZoCfh_Rs9gMujhQ', 'ya29.a0AfB_byBUACPTfdNtRCmAiMr_eYkrkWW4KSOlyRgfLzejkBx9l-DoYOFkIFWNs8_R8VcW5T29axznpUg0MAvcI5u7b9BVYfpFKQJR7bOOAMuHkS2KrxEadYx0fLs8XoYnC0ruI5uUpS8-Zx2nAGcM97Eis4RODDME62qiaCgYKAfwSARISFQGOcNnCx-0_jKdMBT_4zR1_UqaECA0171', '1//03h13L1uysOhoCgYIARAAGAMSNwF-L9IrF5DkpJsEWl-htt72G-PML1W4FTttjfFe12DO2hNDILkEcg9jmwXDoNAQ3LvEKv0yQQo', 2000, '2023-10-25 08:57:09', '2023-10-25 09:15:43');

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
(9, '2023_10_22_140331_create_youtube_categories_table', 2),
(10, '2023_08_20_082346_create_publish_posts_table', 3),
(11, '2023_08_21_101501_create_time_thinks_table', 3),
(12, '2023_09_06_141453_create_settings_apis_table', 3),
(13, '2023_10_17_133937_create_post_images_table', 3),
(14, '2023_10_21_124254_create_permission_tables', 3),
(15, '2023_10_21_145259_create_user_has_roles_table', 3),
(16, '2023_10_24_131038_create_post_videos_table', 3),
(17, '2023_07_08_112058_create_messages_table', 4),
(18, '2023_07_19_081931_update_users', 4);

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

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'create', 'web', '2023-10-25 09:13:52', '2023-10-25 09:13:52'),
(2, 'Edit', 'web', '2023-10-25 09:13:59', '2023-10-25 09:13:59'),
(3, 'delete', 'web', '2023-10-25 09:14:03', '2023-10-25 09:14:03'),
(4, 'Add', 'web', '2023-10-26 05:28:35', '2023-10-26 05:28:35');

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
(1, 'App\\Models\\User', 1, 'API TOKEN', '6057c27a69cc3c1233807f8e23d6c6d273e4b52e8b18b4a6d22a3b4800b15c03', '[\"*\"]', NULL, NULL, '2023-10-29 07:18:45', '2023-10-29 07:18:45'),
(2, 'App\\Models\\User', 2, 'Api Token', '6b87e3b5b90097c6cb0cbb01d74d2ccb94a83497cc6c84d0863d2dd8f39ef3bc', '[\"*\"]', NULL, NULL, '2023-10-29 07:21:57', '2023-10-29 07:21:57'),
(3, 'App\\Models\\User', 2, 'API TOKEN', '511c09f487763b6b04bd394ea84dfef06d7a30a37c8dcb863101089d067e4007', '[\"*\"]', NULL, NULL, '2023-10-29 07:24:03', '2023-10-29 07:24:03'),
(4, 'App\\Models\\User', 2, 'API TOKEN', '2cf261070b633fb87edff4ac48febafb3289ef01a630ad4f335dfb0a631c049e', '[\"*\"]', NULL, NULL, '2023-10-29 07:48:57', '2023-10-29 07:48:57'),
(6, 'App\\Models\\User', 3, 'API TOKEN', '2aa0e790f0f40ad407d7eea550bbcf1e89383aeb550b7c4da01b417405dcf5f0', '[\"*\"]', '2023-10-29 13:22:26', NULL, '2023-10-29 09:28:38', '2023-10-29 13:22:26');

-- --------------------------------------------------------

--
-- Table structure for table `post_images`
--

CREATE TABLE `post_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `creator_id` bigint(20) UNSIGNED NOT NULL,
  `image` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `creator_id` bigint(20) UNSIGNED NOT NULL,
  `account_type` varchar(255) NOT NULL,
  `account_id` varchar(255) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `thumbnail` text DEFAULT NULL,
  `link` text DEFAULT NULL,
  `post_title` varchar(255) DEFAULT NULL,
  `content` text NOT NULL,
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
(1, 1, 'twitter', '1708817086653386752', 'EvolveTeck', 'published', NULL, NULL, NULL, 'k2', NULL, NULL, NULL, '2023-10-26 12:23:00', '1708817086653386752-WRyD6t3aHPtXsqQeyjokEhdjOlnrYq', '8MdlSMKR1hkgAsOKTPhMttQTZKFRoGmTs4GrPYFMEokNY', '2023-10-26 09:23:09', '2023-10-26 09:23:09'),
(2, 1, 'youtube', 'UCDtui0aBpRnx1eNAzq7eUHQ', 'evovle inc', 'published', 'uploadVideos/vecteezy_square-shape-tech-background-hud-small-squares-shape-loop_13449649_472.mp4', NULL, 'youtube', 'youtube_desc', 'public', 'k', NULL, '2023-10-29 14:52:45', 'ya29.a0AfB_byB9ZUyzCgAo7b5FlMknnV7SYCrX4pzdzpaoFipC-TEMt6KCD4v-JXsvVoPi_usZwGMVp-agZb8wHLbpiCP8Td-FjN9FBdM-EYMznCVO0FqqpwoxmEwLEttzPlvUHjz-L6KKeMs64dnJuwqwZE6u0apzFxSAyyemaCgYKAW0SARMSFQGOcNnCiGhnaAspFUBNCMq', '1//03OvEbi37WB3TCgYIARAAGAMSNwF-L9IreW7zjQ2dmbRQsoUx9UwIhY3-n4v--YSy4gw3s6KVuQLvDnRoGJNS0heO13RQr5-rSsQ', '2023-10-26 09:47:35', '2023-10-26 09:47:35'),
(3, 3, 'facebook', 'UCDtui0aBpRnx1eNAzq7eUHQ', 'evovle inc', 'published', 'uploadVideos/vecteezy_square-shape-tech-background-hud-small-squares-shape-loop_13449649_472.mp4', NULL, 'youtube', 'youtube_desc', 'public', 'k', NULL, '2023-10-29 15:34:57', 'ya29.a0AfB_byB9ZUyzCgAo7b5FlMknnV7SYCrX4pzdzpaoFipC-TEMt6KCD4v-JXsvVoPi_usZwGMVp-agZb8wHLbpiCP8Td-FjN9FBdM-EYMznCVO0FqqpwoxmEwLEttzPlvUHjz-L6KKeMs64dnJuwqwZE6u0apzFxSAyyemaCgYKAW0SARMSFQGOcNnCiGhnaAspFUBNCMq', '1//03OvEbi37WB3TCgYIARAAGAMSNwF-L9IreW7zjQ2dmbRQsoUx9UwIhY3-n4v--YSy4gw3s6KVuQLvDnRoGJNS0heO13RQr5-rSsQ', '2023-10-26 09:47:35', '2023-10-26 09:47:35');

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

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `role_color`, `created_at`, `updated_at`) VALUES
(1, 'Adminstrator', 'web', 'danger', '2023-10-25 09:13:43', '2023-10-26 05:25:56'),
(2, 'User', 'web', 'success', '2023-10-25 09:14:15', '2023-10-25 09:14:23');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 1);

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
(1, 1, 'facebook', '690179252628964', '9ac7abd4768f0bcf9c92779dd406b4d0', NULL, '2023-10-25 05:59:04', '2023-10-25 05:59:04'),
(2, 1, 'twitter', 'tBoZ80ztGOfOjMOx4VOwmdG2G', 'qQjq9BgXxPLc9TQXAtrnXHuRB2vtgSg9fljFUHq2K6ZrV2v56n', NULL, '2023-10-25 05:59:58', '2023-10-25 05:59:58'),
(3, 1, 'youtube', '400800346626-3pj9lb5923bmurej4bk6ql2v2rm29kco.apps.googleusercontent.com', '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', 'AIzaSyCZhW13YQV1En4FEtVET312rRwIbAj3Rp4', '2023-10-25 06:00:48', '2023-10-25 06:07:25');

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

--
-- Dumping data for table `social_posts`
--

INSERT INTO `social_posts` (`id`, `api_account_id`, `post_id`, `post_img`, `post_video`, `post_link`, `post_title`, `content`, `post_date`, `created_at`, `updated_at`) VALUES
(1, 3, 'hSO9P8e1uKA', NULL, 'https://i.ytimg.com/vi/hSO9P8e1uKA/hqdefault.jpg', 'https://www.youtube.com/watch?v=hSO9P8e1uKA', 'gh', '', '2023-10-21 06:11:46', NULL, NULL),
(2, 3, 'jf5kHCwgaJk', NULL, 'https://i.ytimg.com/vi/jf5kHCwgaJk/hqdefault.jpg', 'https://www.youtube.com/watch?v=jf5kHCwgaJk', 'Test title', 'Test descrition.', '2023-10-21 06:02:11', NULL, NULL),
(3, 3, 'AjtRl4s5CPQ', NULL, 'https://i.ytimg.com/vi/AjtRl4s5CPQ/hqdefault.jpg', 'https://www.youtube.com/watch?v=AjtRl4s5CPQ', 'laravel youtube test', 'test for youtube api.', '2023-10-15 09:58:42', NULL, NULL),
(4, 4, 'mUZxvThNxGc', NULL, 'https://i.ytimg.com/vi/mUZxvThNxGc/hqdefault.jpg', 'https://www.youtube.com/watch?v=mUZxvThNxGc', 'video for min', 'video min descreption.', '2023-10-22 11:03:31', '2023-10-25 09:06:43', '2023-10-25 09:06:43'),
(5, 4, 'QlQPjdf9z-s', NULL, 'https://i.ytimg.com/vi/QlQPjdf9z-s/hqdefault.jpg', 'https://www.youtube.com/watch?v=QlQPjdf9z-s', 'video youtube', 'fhryh.', '2023-10-22 10:38:46', '2023-10-25 09:06:43', '2023-10-25 09:06:43'),
(6, 4, '385TQq0zN4Q', NULL, 'https://i.ytimg.com/vi/385TQq0zN4Q/hqdefault.jpg', 'https://www.youtube.com/watch?v=385TQq0zN4Q', 'video youtube', 'fhryh.', '2023-10-22 10:37:19', '2023-10-25 09:06:43', '2023-10-25 09:06:43'),
(7, 4, 'LdTagvygxU8', NULL, 'https://i.ytimg.com/vi/LdTagvygxU8/hqdefault.jpg', 'https://www.youtube.com/watch?v=LdTagvygxU8', 'video youtube', 'fhryh.', '2023-10-22 10:35:21', '2023-10-25 09:06:43', '2023-10-25 09:06:43'),
(8, 4, 'vXF2i_9sea8', NULL, 'https://i.ytimg.com/vi/vXF2i_9sea8/hqdefault.jpg', 'https://www.youtube.com/watch?v=vXF2i_9sea8', 'technology video', 'test for technology channel.', '2023-10-19 04:50:01', '2023-10-25 09:06:43', '2023-10-25 09:06:43');

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
(1, 1, 3, NULL, NULL);

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
(1, 'Admin', 'admin', 'admin@gmail.com', NULL, '$2y$10$5qKXtOeHE.Jd9rgSQDt1XOWb9v1009OftzWANnCSEIFQVOSLvDW0S', NULL, '2023-10-12 06:59:55', '2023-10-29 09:46:39', 'admin', 'online'),
(2, 'omnia', 'user', 'omnia@gmail.com', NULL, '$2y$10$3/HPaEOX2QkUKsB/aYW4eOnS5WqBbYc3oe6Fk3rtdDEjtIY1a47s6', NULL, '2023-10-29 07:21:57', '2023-10-29 07:21:57', 'user', 'offline'),
(3, 'omnia', 'user', 'omnia2@gmail.com', NULL, '$2y$10$mvI.NFC6E8d0ZnyDtmHMNuX55GslumewMhnHj1KKRV8uX777U/pse', NULL, '2023-10-29 09:13:11', '2023-10-29 09:44:09', 'user', 'offline');

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

--
-- Dumping data for table `user_has_roles`
--

INSERT INTO `user_has_roles` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(3, 1, 2, NULL, NULL);

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
-- Dumping data for table `youtube_categories`
--

INSERT INTO `youtube_categories` (`id`, `category_id`, `category_name`, `created_at`, `updated_at`) VALUES
(1, 1, 'Film & Animation', '2023-10-26 10:15:03', '2023-10-26 10:15:03'),
(3, 2, 'Autos & Vehicles', '2023-10-26 10:36:18', '2023-10-26 10:36:18'),
(4, 10, 'Music', '2023-10-26 10:36:34', '2023-10-26 10:36:34');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `post_images`
--
ALTER TABLE `post_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `post_videos`
--
ALTER TABLE `post_videos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publish_posts`
--
ALTER TABLE `publish_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `settings_apis`
--
ALTER TABLE `settings_apis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `social_posts`
--
ALTER TABLE `social_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `time_thinks`
--
ALTER TABLE `time_thinks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_has_roles`
--
ALTER TABLE `user_has_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `youtube_categories`
--
ALTER TABLE `youtube_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
-- Constraints for table `post_images`
--
ALTER TABLE `post_images`
  ADD CONSTRAINT `post_images_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `publish_posts` (`creator_id`),
  ADD CONSTRAINT `post_images_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `publish_posts` (`id`);

--
-- Constraints for table `post_videos`
--
ALTER TABLE `post_videos`
  ADD CONSTRAINT `post_videos_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `publish_posts` (`creator_id`),
  ADD CONSTRAINT `post_videos_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `publish_posts` (`id`);

--
-- Constraints for table `publish_posts`
--
ALTER TABLE `publish_posts`
  ADD CONSTRAINT `publish_posts_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `publish_posts_youtube_category_foreign` FOREIGN KEY (`youtube_category`) REFERENCES `youtube_categories` (`id`);

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
