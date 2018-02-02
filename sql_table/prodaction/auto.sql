-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Фев 02 2018 г., 14:44
-- Версия сервера: 5.5.52-MariaDB
-- Версия PHP: 7.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `auto`
--

-- --------------------------------------------------------

--
-- Структура таблицы `addon`
--

CREATE TABLE IF NOT EXISTS `addon` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `price` float NOT NULL DEFAULT '0',
  `currency_id` int(11) NOT NULL DEFAULT '0',
  `price_is_multiplier` tinyint(1) NOT NULL DEFAULT '0',
  `add_to_order` tinyint(1) NOT NULL DEFAULT '0',
  `addon_category_id` int(11) NOT NULL,
  `can_change_quantity` tinyint(1) NOT NULL DEFAULT '0',
  `measure_id` int(11) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `addon_bindings`
--

CREATE TABLE IF NOT EXISTS `addon_bindings` (
  `id` int(11) NOT NULL,
  `addon_id` int(11) NOT NULL,
  `appliance_object_id` int(11) NOT NULL,
  `object_model_id` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `addon_category`
--

CREATE TABLE IF NOT EXISTS `addon_category` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `api_service`
--

CREATE TABLE IF NOT EXISTS `api_service` (
  `service_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `access_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires_in` int(10) unsigned NOT NULL,
  `create_ts` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `auth_assignment`
--

CREATE TABLE IF NOT EXISTS `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `auth_assignment`
--

INSERT INTO `auth_assignment` (`item_name`, `user_id`, `created_at`, `updated_at`, `rule_name`, `data`) VALUES
('admin', '1', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `auth_item`
--

CREATE TABLE IF NOT EXISTS `auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `auth_item`
--

INSERT INTO `auth_item` (`name`, `type`, `description`, `rule_name`, `data`, `created_at`, `updated_at`) VALUES
('admin', 1, 'Администратор', NULL, NULL, NULL, NULL),
('administrate', 2, 'Контрольная панель', NULL, NULL, NULL, NULL),
('api manage', 2, 'Управление API', NULL, NULL, NULL, NULL),
('cache manage', 2, 'Управление кешем', NULL, NULL, NULL, NULL),
('category manage', 2, 'Управление категориями', NULL, NULL, NULL, NULL),
('content manage', 2, 'Управление контентом', NULL, NULL, NULL, NULL),
('data manage', 2, 'Управление данными', NULL, NULL, NULL, NULL),
('form manage', 2, 'Управление формами', NULL, NULL, NULL, NULL),
('manager', 1, 'Менеджер', NULL, NULL, NULL, NULL),
('media manage', 2, 'Управление медиа', NULL, NULL, NULL, NULL),
('monitoring manage', 2, 'Управление мониторингом', NULL, NULL, NULL, NULL),
('navigation manage', 2, 'Управление навигацией', NULL, NULL, NULL, NULL),
('order manage', 2, 'Управление заказами', NULL, NULL, NULL, NULL),
('order status manage', 2, 'Управление статусами заказов', NULL, NULL, NULL, NULL),
('payment manage', 2, 'Управление способами оплаты', NULL, NULL, NULL, NULL),
('product manage', 2, 'Управление продуктами', NULL, NULL, NULL, NULL),
('property manage', 2, 'Управление свойствами', NULL, NULL, NULL, NULL),
('review manage', 2, 'Управление отзывами', NULL, NULL, NULL, NULL),
('seo manage', 2, 'Управление SEO', NULL, NULL, NULL, NULL),
('setting manage', 2, 'Управление настройками', NULL, NULL, NULL, NULL),
('shipping manage', 2, 'Управление способами доставки', NULL, NULL, NULL, NULL),
('shop manage', 2, 'Управление интернет-магазином', NULL, NULL, NULL, NULL),
('task manage', 2, 'Управление задачами', NULL, NULL, NULL, NULL),
('user manage', 2, 'Управление пользователями', NULL, NULL, NULL, NULL),
('view manage', 2, 'Управление представлениями', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `auth_item_child`
--

CREATE TABLE IF NOT EXISTS `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `auth_item_child`
--

INSERT INTO `auth_item_child` (`parent`, `child`) VALUES
('admin', 'administrate'),
('admin', 'api manage'),
('admin', 'cache manage'),
('admin', 'category manage'),
('admin', 'content manage'),
('admin', 'data manage'),
('admin', 'form manage'),
('admin', 'media manage'),
('admin', 'monitoring manage'),
('admin', 'navigation manage'),
('admin', 'order manage'),
('admin', 'order status manage'),
('admin', 'payment manage'),
('admin', 'product manage'),
('admin', 'property manage'),
('admin', 'review manage'),
('admin', 'seo manage'),
('admin', 'setting manage'),
('admin', 'shipping manage'),
('admin', 'shop manage'),
('admin', 'task manage'),
('admin', 'user manage'),
('admin', 'view manage'),
('manager', 'administrate'),
('manager', 'category manage'),
('manager', 'content manage'),
('manager', 'form manage'),
('manager', 'media manage'),
('manager', 'navigation manage'),
('manager', 'order manage'),
('manager', 'product manage'),
('manager', 'property manage'),
('manager', 'review manage'),
('manager', 'shop manage'),
('manager', 'view manage'),
('shop manage', 'category manage'),
('shop manage', 'order manage'),
('shop manage', 'product manage');

-- --------------------------------------------------------

--
-- Структура таблицы `auth_rule`
--

CREATE TABLE IF NOT EXISTS `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `backend_menu`
--

CREATE TABLE IF NOT EXISTS `backend_menu` (
  `id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT '0',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `route` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sort_order` int(10) unsigned DEFAULT '0',
  `added_by_ext` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rbac_check` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `css_class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `translation_category` varchar(120) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'app'
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `backend_menu`
--

INSERT INTO `backend_menu` (`id`, `parent_id`, `name`, `route`, `icon`, `sort_order`, `added_by_ext`, `rbac_check`, `css_class`, `translation_category`) VALUES
(1, 0, 'Root', '/backend/', NULL, 0, 'core', NULL, NULL, 'app'),
(2, 1, 'Dashboard', 'backend/dashboard/index', 'dashboard', 0, 'core', 'administrate', NULL, 'app'),
(3, 1, 'Pages', 'page/backend/index', 'file-o', 0, 'core', 'content manage', NULL, 'app'),
(4, 1, 'Shop', '', 'shopping-cart', 0, 'core', 'shop manage', NULL, 'app'),
(5, 4, 'Categories', 'shop/backend-category/index', 'tree', 0, 'core', 'category manage', NULL, 'app'),
(6, 4, 'Products', 'shop/backend-product/index', 'list', 0, 'core', 'product manage', NULL, 'app'),
(7, 4, 'Orders', '', 'list-alt', 0, 'core', 'order manage', NULL, 'app'),
(8, 4, 'Stages', 'shop/backend-stage/index', 'sitemap', 0, 'core', 'order status manage', NULL, 'app'),
(9, 4, 'Payment types', 'shop/backend-payment-type/index', 'info-circle', 0, 'core', 'payment manage', NULL, 'app'),
(10, 4, 'Filter sets', 'shop/backend-filter-sets/index', 'filter', 0, 'core', 'category manage', NULL, 'app'),
(11, 4, 'Shipping options', 'shop/backend-shipping-option/index', 'truck', 0, 'core', 'shipping manage', NULL, 'app'),
(12, 4, 'Categories groups', 'shop/backend-category-group/index', 'folder-o', 0, 'core', 'category manage', NULL, 'app'),
(13, 4, 'Prefiltered pages', 'shop/backend-prefiltered-pages/index', 'tag', 0, 'core', 'shop manage', NULL, 'app'),
(14, 4, 'Currencies', 'shop/backend-currencies/index', 'usd', 0, 'core', 'shop manage', NULL, 'app'),
(15, 4, 'Measures', 'shop/backend-measure/index', 'calculator', 0, 'core', 'shop manage', NULL, 'app'),
(16, 4, 'Discounts', 'shop/backend-discount/index', 'shekel', 0, 'core', 'shop manage', NULL, 'app'),
(17, 4, 'Warehouse', 'shop/backend-warehouse/index', 'cubes', 0, 'core', 'shop manage', NULL, 'app'),
(18, 1, 'Properties', '', 'cogs', 0, 'core', 'property manage', NULL, 'app'),
(19, 18, 'Properties', 'backend/properties/index', 'cogs', 0, 'core', 'property manage', NULL, 'app'),
(20, 18, 'Views', 'backend/view/index', 'desktop', 0, 'core', 'view manage', NULL, 'app'),
(21, 1, 'Reviews', 'review/backend-review/index', 'comment', 0, 'core', 'review manage', NULL, 'app'),
(22, 1, 'Rating groups', 'review/backend-rating/index', 'star-half-o', 0, 'core', 'review manage', NULL, 'app'),
(23, 1, 'Navigation', 'backend/navigation/index', 'navicon', 0, 'core', 'navigation manage', NULL, 'app'),
(24, 1, 'Forms', 'backend/form/index', 'list-ul', 0, 'core', 'form manage', NULL, 'app'),
(25, 1, 'Dynamic content', 'backend/dynamic-content/index', 'puzzle-piece', 0, 'core', 'content manage', NULL, 'app'),
(26, 1, 'Content Blocks', 'core/backend-chunk/index', 'file-code-o', 0, 'core', 'content manage', NULL, 'app'),
(27, 1, 'Sliders', 'backend/slider/index', 'arrows-h', 0, 'core', 'content manage', NULL, 'app'),
(28, 1, 'Users', 'user/backend-user/index', 'users', 0, 'core', 'user manage', NULL, 'app'),
(29, 1, 'Rbac', 'user/rbac/index', 'lock', 0, 'core', 'user manage', NULL, 'app'),
(30, 1, 'Seo', 'seo/manage/index', 'search', 0, 'core', 'seo manage', NULL, 'app'),
(31, 1, 'Images', '', 'picture-o', 0, 'core', 'content manage', NULL, 'app'),
(32, 31, 'Thumbnails sizes', 'image/backend-thumbnail-size/index', NULL, 0, 'core', 'content manage', NULL, 'app'),
(33, 31, 'Create thumbnails', 'image/backend-thumbnail/index', NULL, 0, 'core', 'content manage', NULL, 'app'),
(34, 31, 'Watermarks', 'image/backend-watermark/index', NULL, 0, 'core', 'content manage', NULL, 'app'),
(35, 31, 'Broken images', 'image/backend-error-images/index', NULL, 0, 'core', 'content manage', NULL, 'app'),
(36, 1, 'Error monitoring', 'backend/error-monitor/index', 'flash', 0, 'core', 'monitoring manage', NULL, 'app'),
(37, 1, 'Settings', '', 'gears', 0, 'core', 'setting manage', NULL, 'app'),
(38, 37, 'Tasks', 'background/manage/index', 'tasks', 0, 'core', 'task manage', NULL, 'app'),
(39, 37, 'Config', 'config/backend/index', 'gear', 0, 'core', 'setting manage', NULL, 'app'),
(40, 37, 'I18n', 'backend/i18n/index', 'language', 0, 'core', 'setting manage', NULL, 'app'),
(41, 37, 'Spam Form Checker', 'backend/spam-checker/index', 'send-o', 0, 'core', 'setting manage', NULL, 'app'),
(42, 37, 'Backend menu', 'backend/backend-menu/index', 'list-alt', 0, 'core', 'setting manage', NULL, 'app'),
(43, 37, 'Data', 'data/file/index', 'database', 0, 'core', 'data manage', NULL, 'app'),
(44, 37, 'YML', 'shop/backend-yml/settings', 'code', 0, 'core', 'content manage', NULL, 'app'),
(45, 37, 'Api', 'backend/api/index', 'exchange', 0, 'core', 'api manage', NULL, 'app'),
(46, 7, 'Orders', 'shop/backend-order/index', 'list-alt', 0, 'shop', 'order manage', '', 'app'),
(47, 7, 'Customers', 'shop/backend-customer/index', 'user', 1, 'shop', 'order manage', '', 'app'),
(48, 7, 'Contragents', 'shop/backend-contragent/index', 'user', 2, 'shop', 'order manage', '', 'app'),
(49, 37, 'Extensions', 'core/backend-extensions/index', 'puzzle-piece', 0, 'core', 'setting manage', '', 'app'),
(50, 4, 'Addons', 'shop/backend-addons/index', 'cart-plus', 0, 'core', 'product manage', '', 'app'),
(51, 37, 'Google Merchants', '/shop/backend-google-feed/settings', 'google', 0, 'core', 'content manage', NULL, 'app'),
(52, 37, 'Wysiwyg editors', '/core/backend-wysiwyg/index', 'pencil-square-o', 0, 'core', 'content manage', NULL, 'app');

-- --------------------------------------------------------

--
-- Структура таблицы `backgroundtasks_notify_message`
--

CREATE TABLE IF NOT EXISTS `backgroundtasks_notify_message` (
  `id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  `result_status` enum('SUCCESS','FAULT') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'SUCCESS',
  `result` text COLLATE utf8_unicode_ci,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `backgroundtasks_task`
--

CREATE TABLE IF NOT EXISTS `backgroundtasks_task` (
  `id` int(10) unsigned NOT NULL,
  `action` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('EVENT','REPEAT') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'EVENT',
  `initiator` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `params` text COLLATE utf8_unicode_ci,
  `init_event` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cron_expression` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','STOPPED','RUNNING','FAILED','COMPLETED','PROCESS') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fail_counter` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `options` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `backgroundtasks_task`
--

INSERT INTO `backgroundtasks_task` (`id`, `action`, `type`, `initiator`, `name`, `description`, `params`, `init_event`, `cron_expression`, `status`, `ts`, `fail_counter`, `options`) VALUES
(1, 'seo/sitemap/generate-sitemap', 'REPEAT', 1, 'sitemap', NULL, NULL, NULL, '0-59/15 * * * *', 'ACTIVE', '2017-11-28 12:51:10', 0, NULL),
(2, 'errornotifier/notify', 'REPEAT', 1, 'ErrorMonitor notifier', NULL, NULL, NULL, '*/1 * * * *', 'ACTIVE', '2017-11-28 12:51:10', 0, NULL),
(3, 'currency/update', 'REPEAT', 1, 'Currency update', NULL, NULL, NULL, '0 0 * * *', 'ACTIVE', '2017-11-28 12:51:10', 0, NULL),
(4, 'background/tasks/clear-old-notifications', 'REPEAT', 1, 'Clear old notify messages', NULL, NULL, NULL, '*/1 * * * *', 'ACTIVE', '2017-11-28 12:51:10', 0, '[]'),
(5, 'submissions/mark-spam', 'REPEAT', 1, 'Mark spam submissions as deleted', NULL, NULL, NULL, '* * */1 * *', 'ACTIVE', '2017-11-28 12:51:10', 0, '[]'),
(6, 'submissions/clear-deleted', 'REPEAT', 1, 'Clear deleted submissions', NULL, NULL, NULL, '* * */3 * *', 'ACTIVE', '2017-11-28 12:51:10', 0, '[]'),
(7, 'images/check-broken', 'REPEAT', 1, 'Check broken images', NULL, NULL, NULL, '* */1 * * *', 'ACTIVE', '2017-11-28 12:51:10', 0, NULL),
(8, 'submissions/send-new', 'REPEAT', 1, 'Send new submissions', NULL, NULL, NULL, '*/5 * * * *', 'ACTIVE', '2017-11-28 12:51:10', 0, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(10) unsigned NOT NULL,
  `category_group_id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `h1` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `meta_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `breadcrumbs_label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(80) COLLATE utf8_unicode_ci DEFAULT '',
  `slug_compiled` varchar(180) COLLATE utf8_unicode_ci DEFAULT '',
  `slug_absolute` tinyint(4) DEFAULT '0',
  `content` text COLLATE utf8_unicode_ci,
  `announce` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT '0',
  `title_append` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(3) unsigned DEFAULT '1',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `category`
--

INSERT INTO `category` (`id`, `category_group_id`, `parent_id`, `name`, `title`, `h1`, `meta_description`, `breadcrumbs_label`, `slug`, `slug_compiled`, `slug_absolute`, `content`, `announce`, `sort_order`, `title_append`, `active`, `date_added`, `date_modified`) VALUES
(1, 1, 0, 'Каталог', 'Каталог', 'Каталог', '', 'Каталог', 'сatalog', '', 0, '', '', 0, '', 1, '2018-01-04 16:51:15', '2018-01-04 17:01:07'),
(2, 1, 1, 'Мотоэкипировка', 'Мотоэкипировка', 'Мотоэкипировка', 'МотоэкипировкаМотоэкипировка description', 'Мотоэкипировка', 'motoekipirovka', '', 0, 'МотоэкипировкаМотоэкипировкаМотоэкипировкаМотоэкипировкаМотоэкипировкаМотоэкипировкаМотоэкипировкаМотоэкипировкаМотоэкипировкаМотоэкипировкаМотоэкипировкаМотоэкипировка', 'МотоэкипировкаМотоэкипировка МотоэкипировкаМотоэкипировка Мотоэкипировка МотоэкипировкаМотоэкипировкаМотоэкипировка', 3, '', 1, '2017-12-24 12:19:09', '2018-01-14 18:41:49'),
(3, 1, 2, 'Мотокуртки', 'Мотокуртки', 'Мотокуртки H1', 'МотокурткиМотокурткиМотокуртки', 'Мотокуртки', 'motokurtki', '', 0, 'МотокурткиМотокурткиvМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокуртки', 'МотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокурткиМотокуртки', 1, 'МотокурткиМотокурткиМотокуртки', 1, '2017-12-24 12:22:41', '2018-01-14 18:42:05'),
(4, 1, 3, 'Тестовая Категория', 'Тестовая Категория', 'Тестовая Категория', '', 'Тестовая Категория', 'testovaya-kategoriya', '', 0, '', '', 1, '', 1, '2018-01-03 14:54:45', '2018-01-14 18:04:20'),
(5, 1, 1, 'TEST21', 'TEST21', 'TEST21', '', 'TEST21', 'test21', '', 0, '', '', 1, '', 1, '2018-01-04 15:43:44', '2018-01-14 18:40:59'),
(7, 1, 1, 'sssss', 'sssss', 'sssss', '', 'sssss', 'sssss', '', 0, '', '', 2, '', 1, '2018-01-14 16:45:53', '2018-01-14 18:41:24');

-- --------------------------------------------------------

--
-- Структура таблицы `category_discount`
--

CREATE TABLE IF NOT EXISTS `category_discount` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `discount_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `category_eav`
--

CREATE TABLE IF NOT EXISTS `category_eav` (
  `id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL,
  `property_group_id` int(10) unsigned NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `category_group`
--

CREATE TABLE IF NOT EXISTS `category_group` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `category_group`
--

INSERT INTO `category_group` (`id`, `name`) VALUES
(1, 'Shop');

-- --------------------------------------------------------

--
-- Структура таблицы `category_group_route_templates`
--

CREATE TABLE IF NOT EXISTS `category_group_route_templates` (
  `id` int(10) unsigned NOT NULL,
  `category_group_id` int(11) unsigned NOT NULL,
  `route_id` int(10) unsigned NOT NULL,
  `template_json` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `category_property`
--

CREATE TABLE IF NOT EXISTS `category_property` (
  `object_model_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `city`
--

CREATE TABLE IF NOT EXISTS `city` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `city`
--

INSERT INTO `city` (`id`, `name`, `sort_order`, `slug`, `country_id`) VALUES
(1, 'Москва', 0, 'moscow', 1),
(2, 'Санкт-Петербург', 0, 'spb', 1),
(3, 'New York', 0, 'ny', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `commerceml_guid`
--

CREATE TABLE IF NOT EXISTS `commerceml_guid` (
  `id` int(11) NOT NULL,
  `guid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` text COLLATE utf8_unicode_ci,
  `model_id` bigint(20) DEFAULT NULL,
  `type` enum('PRODUCT','CATEGORY','PROPERTY') COLLATE utf8_unicode_ci DEFAULT 'PRODUCT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `configurable`
--

CREATE TABLE IF NOT EXISTS `configurable` (
  `id` int(11) NOT NULL,
  `module` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `section_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_in_config` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `configurable`
--

INSERT INTO `configurable` (`id`, `module`, `sort_order`, `section_name`, `display_in_config`) VALUES
(1, 'core', 1, 'Core', 1),
(2, 'DefaultTheme', 2, 'Default Theme', 1),
(3, 'shop', 3, 'Shop', 1),
(4, 'user', 4, 'Users & Roles', 1),
(5, 'page', 5, 'Pages', 1),
(6, 'image', 6, 'Images', 1),
(7, 'seo', 7, 'SEO', 1),
(8, 'backend', 8, 'Backend', 1),
(9, 'review', 9, 'Reviews', 1),
(10, 'data', 10, 'Data import/export', 1),
(11, 'background', 17, 'Background tasks', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `content_block`
--

CREATE TABLE IF NOT EXISTS `content_block` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `key` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  `preload` tinyint(4) DEFAULT '0',
  `group_id` int(2) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `content_block_group`
--

CREATE TABLE IF NOT EXISTS `content_block_group` (
  `id` int(11) NOT NULL,
  `parent_id` int(10) NOT NULL DEFAULT '1',
  `name` varchar(250) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `content_block_group`
--

INSERT INTO `content_block_group` (`id`, `parent_id`, `name`, `sort_order`) VALUES
(1, 0, 'root', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `content_decorators`
--

CREATE TABLE IF NOT EXISTS `content_decorators` (
  `id` int(11) NOT NULL,
  `added_by_ext` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `post_decorator` tinyint(1) NOT NULL DEFAULT '0',
  `class_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `content_decorators`
--

INSERT INTO `content_decorators` (`id`, `added_by_ext`, `post_decorator`, `class_name`, `sort_order`) VALUES
(1, 'core', 0, 'app\\modules\\core\\decorators\\ContentBlock', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `contragent`
--

CREATE TABLE IF NOT EXISTS `contragent` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `type` enum('Individual','Self-employed','Legal entity') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Individual'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `contragent`
--

INSERT INTO `contragent` (`id`, `customer_id`, `type`) VALUES
(1, 1, 'Individual'),
(2, 2, 'Individual');

-- --------------------------------------------------------

--
-- Структура таблицы `contragent_eav`
--

CREATE TABLE IF NOT EXISTS `contragent_eav` (
  `id` int(11) NOT NULL,
  `object_model_id` int(11) unsigned NOT NULL,
  `property_group_id` int(11) unsigned NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `country`
--

CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iso_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `country`
--

INSERT INTO `country` (`id`, `name`, `iso_code`, `sort_order`, `slug`) VALUES
(1, 'Россия', 'RUS', 0, 'rossiya'),
(2, 'USA', 'USA', 1, 'usa');

-- --------------------------------------------------------

--
-- Структура таблицы `currency`
--

CREATE TABLE IF NOT EXISTS `currency` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iso_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_main` tinyint(1) NOT NULL DEFAULT '0',
  `convert_nominal` float NOT NULL DEFAULT '1',
  `convert_rate` float NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `intl_formatting` tinyint(1) NOT NULL DEFAULT '1',
  `min_fraction_digits` int(11) NOT NULL DEFAULT '0',
  `max_fraction_digits` int(11) NOT NULL DEFAULT '2',
  `dec_point` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '.',
  `thousands_sep` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT ' ',
  `format_string` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `additional_rate` float NOT NULL DEFAULT '0',
  `additional_nominal` float NOT NULL DEFAULT '0',
  `currency_rate_provider_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `currency`
--

INSERT INTO `currency` (`id`, `name`, `iso_code`, `is_main`, `convert_nominal`, `convert_rate`, `sort_order`, `intl_formatting`, `min_fraction_digits`, `max_fraction_digits`, `dec_point`, `thousands_sep`, `format_string`, `additional_rate`, `additional_nominal`, `currency_rate_provider_id`) VALUES
(1, 'Ruble', 'RUB', 1, 1, 1, 0, 0, 0, 2, '.', ' ', '# руб.', 0, 0, 0),
(2, 'US Dollar', 'USD', 0, 1, 62.8353, 1, 1, 0, 2, ',', '.', '$ #', 0, 0, 0),
(3, 'Euro', 'EUR', 0, 1, 71.3243, 0, 1, 0, 2, '.', ' ', '&euro; #', 0, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `currency_rate_provider`
--

CREATE TABLE IF NOT EXISTS `currency_rate_provider` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `class_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `params` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `currency_rate_provider`
--

INSERT INTO `currency_rate_provider` (`id`, `name`, `class_name`, `params`) VALUES
(1, 'Google Finance', 'Swap\\Provider\\GoogleFinanceProvider', NULL),
(2, 'Cbr Finance', 'app\\components\\swap\\provider\\CbrFinanceProvider', NULL),
(3, 'Currency rate multi provider', 'app\\components\\swap\\provider\\CurrencyRateMultiProvider', '{"mainProvider":1,"secondProvider":2,"criticalDifference":20}');

-- --------------------------------------------------------

--
-- Структура таблицы `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT '0',
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middle_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `customer`
--

INSERT INTO `customer` (`id`, `user_id`, `first_name`, `middle_name`, `last_name`, `email`, `phone`) VALUES
(1, 1, 'Имя', '', '', '', ''),
(2, 0, 'asdas', '', '', '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `customer_eav`
--

CREATE TABLE IF NOT EXISTS `customer_eav` (
  `id` int(11) NOT NULL,
  `object_model_id` int(11) unsigned NOT NULL,
  `property_group_id` int(11) unsigned NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `data_export`
--

CREATE TABLE IF NOT EXISTS `data_export` (
  `user_id` int(11) unsigned NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('complete','failed','process') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'process',
  `update_time` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `data_import`
--

CREATE TABLE IF NOT EXISTS `data_import` (
  `user_id` int(11) unsigned NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('complete','failed','process') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'process',
  `update_time` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `delivery_information`
--

CREATE TABLE IF NOT EXISTS `delivery_information` (
  `id` int(11) NOT NULL,
  `contragent_id` int(11) NOT NULL,
  `country_id` int(11) DEFAULT '0',
  `city_id` int(11) DEFAULT '0',
  `zip_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `delivery_information`
--

INSERT INTO `delivery_information` (`id`, `contragent_id`, `country_id`, `city_id`, `zip_code`, `address`) VALUES
(1, 1, 1, 1, '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `discount`
--

CREATE TABLE IF NOT EXISTS `discount` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `appliance` enum('order_without_delivery','order_with_delivery','products','product_categories','delivery') NOT NULL,
  `value` float NOT NULL,
  `value_in_percent` tinyint(1) NOT NULL DEFAULT '1',
  `apply_order_price_lg` float NOT NULL DEFAULT '-1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `discount_code`
--

CREATE TABLE IF NOT EXISTS `discount_code` (
  `id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `discount_id` int(11) NOT NULL,
  `valid_from` timestamp NULL DEFAULT NULL,
  `valid_till` timestamp NULL DEFAULT NULL,
  `maximum_uses` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `discount_type`
--

CREATE TABLE IF NOT EXISTS `discount_type` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `checking_class` enum('Order','OrderItem') NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `add_view` varchar(255) DEFAULT NULL,
  `custom_view` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `discount_type`
--

INSERT INTO `discount_type` (`id`, `name`, `class`, `active`, `checking_class`, `sort_order`, `add_view`, `custom_view`) VALUES
(1, 'Discount Code', 'app\\modules\\shop\\models\\DiscountCode', 1, 'Order', 0, '@app/modules/shop/views/backend-discount/_discount_code', NULL),
(2, 'Category Discount', 'app\\modules\\shop\\models\\CategoryDiscount', 1, 'OrderItem', 0, '@app/modules/shop/views/backend-discount/_category_discount', NULL),
(3, 'User Discount', 'app\\modules\\shop\\models\\UserDiscount', 1, 'Order', 0, '@app/modules/shop/views/backend-discount/_user_discount', NULL),
(4, 'Order Discount', 'app\\modules\\shop\\models\\OrderDiscount', 1, 'Order', 0, '@app/modules/shop/views/backend-discount/_order_discount', NULL),
(5, 'Product Discount', 'app\\modules\\shop\\models\\ProductDiscount', 1, 'OrderItem', 0, '@app/modules/shop/views/backend-discount/_product_discount', NULL),
(6, 'Shipping Discount', 'app\\modules\\shop\\models\\ShippingDiscount', 1, 'Order', 0, '@app/modules/shop/views/backend-discount/_shipping_discount', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `dynagrid`
--

CREATE TABLE IF NOT EXISTS `dynagrid` (
  `id` varchar(100) NOT NULL DEFAULT '',
  `filter_id` varchar(100) DEFAULT NULL,
  `sort_id` varchar(100) DEFAULT NULL,
  `data` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `dynagrid_dtl`
--

CREATE TABLE IF NOT EXISTS `dynagrid_dtl` (
  `id` varchar(128) NOT NULL DEFAULT '',
  `category` varchar(10) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `data` text,
  `dynagrid_id` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `dynamic_content`
--

CREATE TABLE IF NOT EXISTS `dynamic_content` (
  `id` int(10) unsigned NOT NULL,
  `route` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content_block_name` varchar(80) COLLATE utf8_unicode_ci DEFAULT 'content',
  `announce` text COLLATE utf8_unicode_ci,
  `content` text COLLATE utf8_unicode_ci,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `h1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `apply_if_last_category_id` int(11) DEFAULT NULL,
  `apply_if_params` text COLLATE utf8_unicode_ci,
  `object_id` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `error_image`
--

CREATE TABLE IF NOT EXISTS `error_image` (
  `id` int(10) unsigned NOT NULL,
  `img_id` int(10) unsigned NOT NULL,
  `class_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `error_log`
--

CREATE TABLE IF NOT EXISTS `error_log` (
  `id` int(10) unsigned NOT NULL,
  `url_id` int(10) unsigned NOT NULL,
  `http_code` smallint(6) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `info` text COLLATE utf8_unicode_ci,
  `server_vars` text COLLATE utf8_unicode_ci,
  `request_vars` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `error_url`
--

CREATE TABLE IF NOT EXISTS `error_url` (
  `id` int(10) unsigned NOT NULL,
  `url` text COLLATE utf8_unicode_ci,
  `immediate_notify_count` int(10) unsigned DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `events`
--

CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) NOT NULL,
  `owner_class_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `event_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `event_class_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `selector_prefix` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `event_description` text COLLATE utf8_unicode_ci NOT NULL,
  `documentation_link` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `events`
--

INSERT INTO `events` (`id`, `owner_class_name`, `event_name`, `event_class_name`, `selector_prefix`, `event_description`, `documentation_link`) VALUES
(1, 'app\\modules\\shop\\ShopModule', 'product_page_showed', 'app\\modules\\shop\\events\\ProductPageShowed', '', 'Product page is showed to user', ''),
(2, 'app\\modules\\shop\\ShopModule', 'product_showed_in_list', 'app\\modules\\shop\\events\\ProductShowedInList', '', 'Product is showed in product listing(shop/product/list)', ''),
(3, 'app\\modules\\shop\\ShopModule', 'product_category_listed', 'app\\modules\\shop\\events\\ProductCategoryListed', '', 'Category is listed by shop/product/list as last_category_id.', ''),
(4, 'app\\modules\\shop\\ShopModule', 'order_stage_customer', 'app\\modules\\shop\\events\\StageCustomer', '', '', ''),
(5, 'app\\modules\\shop\\ShopModule', 'order_stage_delivery', 'app\\modules\\shop\\events\\StageDelivery', '', '', ''),
(6, 'app\\modules\\shop\\ShopModule', 'order_stage_payment', 'app\\modules\\shop\\events\\StagePayment', '', '', ''),
(7, 'app\\modules\\shop\\ShopModule', 'order_stage_payment_pay', 'app\\modules\\shop\\events\\StagePaymentPay', '', '', ''),
(8, 'app\\modules\\shop\\ShopModule', 'order_stageleaf_customer', 'app\\modules\\shop\\events\\StageLeafCustomer', '', '', ''),
(9, 'app\\modules\\shop\\ShopModule', 'order_stageleaf_payment_choose', 'app\\modules\\shop\\events\\StageLeafPayment', '', '', ''),
(10, 'app\\modules\\shop\\ShopModule', 'order_stageleaf_delivery_choose', 'app\\modules\\shop\\events\\StageLeafDelivery', '', '', ''),
(11, 'app\\modules\\shop\\ShopModule', 'order_stageleaf_payment_pay', 'app\\modules\\shop\\events\\StageLeafPaymentPay', '', '', ''),
(12, 'app\\modules\\shop\\ShopModule', 'order_stageleaf_manager_process', 'app\\modules\\shop\\events\\StageLeafManagerProcess', '', '', ''),
(13, 'app\\modules\\shop\\ShopModule', 'order_calculate', 'app\\modules\\shop\\events\\OrderCalculateEvent', '', '', ''),
(14, 'app\\modules\\shop\\ShopModule', 'order_stage_final', 'app\\modules\\shop\\events\\StageFinal', '', '', ''),
(15, 'app\\modules\\shop\\ShopModule', 'order_stage_leaf_final', 'app\\modules\\shop\\events\\StageLeafFinal', '', '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `event_handlers`
--

CREATE TABLE IF NOT EXISTS `event_handlers` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `handler_class_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handler_function_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `non_deletable` tinyint(1) NOT NULL DEFAULT '0',
  `triggering_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `event_handlers`
--

INSERT INTO `event_handlers` (`id`, `event_id`, `sort_order`, `handler_class_name`, `handler_function_name`, `is_active`, `non_deletable`, `triggering_type`) VALUES
(1, 1, 1, 'app\\modules\\shop\\helpers\\LastViewedProducts', 'handleProductShowed', 1, 1, 'application_trigger'),
(2, 4, 0, 'app\\modules\\shop\\helpers\\BaseOrderStageHandlers', 'handleStageCustomer', 1, 0, 'application_trigger'),
(3, 5, 0, 'app\\modules\\shop\\helpers\\BaseOrderStageHandlers', 'handleStageDelivery', 1, 0, 'application_trigger'),
(4, 6, 0, 'app\\modules\\shop\\helpers\\BaseOrderStageHandlers', 'handleStagePayment', 1, 0, 'application_trigger'),
(5, 7, 0, 'app\\modules\\shop\\helpers\\BaseOrderStageHandlers', 'handleStagePaymentPay', 1, 0, 'application_trigger'),
(6, 8, 0, 'app\\modules\\shop\\helpers\\BaseOrderStageHandlers', 'handleCustomer', 1, 0, 'application_trigger'),
(7, 9, 0, 'app\\modules\\shop\\helpers\\BaseOrderStageHandlers', 'handlePayment', 1, 0, 'application_trigger'),
(8, 10, 0, 'app\\modules\\shop\\helpers\\BaseOrderStageHandlers', 'handleDelivery', 1, 0, 'application_trigger'),
(9, 11, 0, 'app\\modules\\shop\\helpers\\BaseOrderStageHandlers', 'handlePaymentPay', 1, 0, 'application_trigger'),
(10, 12, 0, 'app\\modules\\shop\\helpers\\BaseOrderStageHandlers', 'handleManagerProcess', 1, 0, 'application_trigger'),
(11, 13, 0, 'app\\modules\\shop\\helpers\\PriceHandlers', 'handleSaveDiscounts', 1, 0, 'application_trigger'),
(12, 13, -5, 'app\\modules\\shop\\helpers\\PriceHandlers', 'handleSaveDelivery', 1, 0, 'application_trigger'),
(13, 14, 0, 'app\\modules\\shop\\helpers\\BaseOrderStageHandlers', 'handleStageFinal', 1, 1, 'application_trigger'),
(14, 15, 0, 'app\\modules\\shop\\helpers\\BaseOrderStageHandlers', 'handleFinal', 1, 1, 'application_trigger');

-- --------------------------------------------------------

--
-- Структура таблицы `extensions`
--

CREATE TABLE IF NOT EXISTS `extensions` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `force_version` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'dev-master',
  `type` int(11) NOT NULL DEFAULT '0',
  `latest_version` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `current_package_version_timestamp` timestamp NULL DEFAULT NULL,
  `latest_package_version_timestamp` timestamp NULL DEFAULT NULL,
  `homepage` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `namespace_prefix` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `extension_types`
--

CREATE TABLE IF NOT EXISTS `extension_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `extension_types`
--

INSERT INTO `extension_types` (`id`, `name`) VALUES
(1, 'Theme'),
(2, 'Module'),
(3, 'Frontend widget'),
(4, 'Dashboard widget'),
(5, 'Backend input widget');

-- --------------------------------------------------------

--
-- Структура таблицы `filter_sets`
--

CREATE TABLE IF NOT EXISTS `filter_sets` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `property_id` int(11) NOT NULL DEFAULT '0',
  `is_filter_by_price` tinyint(1) NOT NULL DEFAULT '0',
  `delegate_to_children` tinyint(1) NOT NULL DEFAULT '1',
  `is_range_slider` tinyint(1) NOT NULL DEFAULT '0',
  `multiple` tinyint(3) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `form`
--

CREATE TABLE IF NOT EXISTS `form` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `form_view` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `form_success_view` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_notification_addresses` text COLLATE utf8_unicode_ci NOT NULL,
  `email_notification_view` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `form_open_analytics_action_id` int(10) unsigned DEFAULT NULL,
  `form_submit_analytics_action_id` int(10) unsigned DEFAULT NULL,
  `subject_template` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '{form_name} #{id}'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `form`
--

INSERT INTO `form` (`id`, `name`, `form_view`, `form_success_view`, `email_notification_addresses`, `email_notification_view`, `form_open_analytics_action_id`, `form_submit_analytics_action_id`, `subject_template`) VALUES
(1, 'Review form', NULL, NULL, '', '@app/modules/review/views/review-email-template.php', NULL, NULL, '{form_name} #{id}');

-- --------------------------------------------------------

--
-- Структура таблицы `form_eav`
--

CREATE TABLE IF NOT EXISTS `form_eav` (
  `id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL,
  `property_group_id` int(10) unsigned NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `form_property`
--

CREATE TABLE IF NOT EXISTS `form_property` (
  `object_model_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `image`
--

CREATE TABLE IF NOT EXISTS `image` (
  `id` int(10) unsigned NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image_title` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT '0',
  `image_alt` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `image`
--

INSERT INTO `image` (`id`, `object_id`, `object_model_id`, `filename`, `image_title`, `sort_order`, `image_alt`) VALUES
(1, 2, 2, '11860c479a9df55cca1e2db59dfd6ff4-superman-symbol-superman-logo.jpg', 'Мотоэкипировка', 0, 'Мотоэкипировка'),
(2, 2, 3, 'e84d93de5ec534a4b6b0257e154cf85a-spider-man-logo-clipart-spider-man-logo-clipart-900-900.png', 'Мотокуртки', 0, 'Мотокуртки'),
(3, 3, 1, 'e316d0a7f474c8eb0e3766ae11319af1.jpeg', 'ALPINESTARS Куртка T-GP PLUS R AIR JACKETALPINESTARS Куртка T-GP PLUS R AIR JACKETALPINESTARS Куртка T-GP PLUS R AIR JACKETALPINESTARS Куртка T-GP PLUS R AIR JACKET', 1, 'ALPINESTARS Куртка T-GP PLUS R AIR JACKET'),
(4, 3, 1, '28be2c4a1e7094a49087bbce160719af.jpeg', 'ALPINESTARS Куртка T-GP PLUS R AIR JACKETALPINESTARS Куртка T-GP PLUS R AIR JACKETALPINESTARS Куртка T-GP PLUS R AIR JACKET', 0, 'ALPINESTARS Куртка T-GP PLUS R AIR JACKET'),
(5, 3, 1, '6be68bfae46adc09ea3aa3809e2508d2.jpeg', 'ALPINESTARS Куртка T-GP PLUS R AIR JACKET', 2, 'ALPINESTARS Куртка T-GP PLUS R AIR JACKETALPINESTARS Куртка T-GP PLUS R AIR JACKETALPINESTARS Куртка T-GP PLUS R AIR JACKET');

-- --------------------------------------------------------

--
-- Структура таблицы `layout`
--

CREATE TABLE IF NOT EXISTS `layout` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `layout` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `layout`
--

INSERT INTO `layout` (`id`, `name`, `layout`) VALUES
(1, 'Default', '\\\\layouts\\main'),
(2, 'Main page', '\\\\layouts\\main-page'),
(3, 'Page without sidebar', '\\\\layouts\\no-sidebar');

-- --------------------------------------------------------

--
-- Структура таблицы `link_anchor`
--

CREATE TABLE IF NOT EXISTS `link_anchor` (
  `id` int(10) unsigned NOT NULL,
  `model_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `model_id` int(10) unsigned NOT NULL,
  `anchor` text COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `link_anchor_binding`
--

CREATE TABLE IF NOT EXISTS `link_anchor_binding` (
  `id` int(10) unsigned NOT NULL,
  `link_anchor_id` int(10) unsigned NOT NULL,
  `view_file` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `params_hash` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `measure`
--

CREATE TABLE IF NOT EXISTS `measure` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `symbol` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nominal` float NOT NULL,
  `sort_order` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `measure`
--

INSERT INTO `measure` (`id`, `name`, `symbol`, `nominal`, `sort_order`) VALUES
(1, 'Штуки', 'шт', 1, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `migration`
--

CREATE TABLE IF NOT EXISTS `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `migration`
--

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m000000_000000_base', 1511873467),
('m150531_084444_new_init', 1511873470),
('m150608_070448_new_theme_widgets', 1511873470),
('m150608_081952_sample_nav_and_pages', 1511873470),
('m150609_064330_backend_menu', 1511873470),
('m150610_120338_backend_menu_fix', 1511873470),
('m150611_082506_DatePicker_submission', 1511873470),
('m150614_153629_larger_image_description', 1511873470),
('m150615_105848_navigation_widget', 1511873470),
('m150622_090046_filterSetSlider', 1511873470),
('m150629_104621_dynamic_content_announce', 1511873470),
('m150716_091156_qualityThumbnail', 1511873470),
('m150716_122316_multiple_filters', 1511873470),
('m150717_123227_selectable_wysiwyg', 1511873470),
('m150720_100330_wysiwyg_conf_view', 1511873470),
('m150722_072209_alt_for_images', 1511873470),
('m150722_122030_reviews_tree', 1511873470),
('m150723_094753_extensions_backend_menu', 1511873470),
('m150723_095512_backend_menu_fixes', 1511873470),
('m150724_114757_quality_fix', 1511873470),
('m150727_093721_reviews_root', 1511873470),
('m150730_080036_object_static_values_index', 1511873470),
('m150815_143352_navigation_object', 1511873470),
('m150819_083548_variation_omit_get', 1511873470),
('m150820_063318_measure_sort_order', 1511873470),
('m150824_073350_password_reset_token_length', 1511873470),
('m150825_073943_masked_input', 1511873470),
('m150827_075105_product_addons', 1511873470),
('m150827_113408_product_relation_property', 1511873470),
('m150831_132548_LastViewedProducts_widget', 1511873470),
('m150907_062636_background_form_sending', 1511873470),
('m150911_112257_child_view', 1511873470),
('m150923_101638_date_modified', 1511873470),
('m150930_112734_related_products_sort', 1511873470),
('m151014_104524_addon_sorts', 1511873470),
('m151021_140934_paypal', 1511873470),
('m151102_110139_yandex_spam_checker_remove', 1511873470),
('m151103_105905_shipping_discount', 1511873470),
('m151112_114139_config_fix', 1511873470),
('m151123_122215_multi_provider', 1511873470),
('m151207_103155_google_merchants', 1511873470),
('m151215_101221_aceWidget', 1511873470),
('m151215_114531_content_block_groups', 1511873470),
('m151217_065513_formSubjectTemplate', 1511873470),
('m151217_080426_TextareaWidget', 1511873470),
('m151217_104446_wysiwygEditorsMenu', 1511873470),
('m151218_203419_property_title_prepend', 1511873470),
('m160316_102050_create_wish_table', 1511873470),
('m160407_120856_add_text_to_slides', 1511873470),
('m160411_141737_resize_images', 1511873470),
('m160517_150022_delete_product_from_addon', 1511873470),
('m160620_112036_config_fix_parent_only', 1511873470),
('m160714_114125_warning_set_unique_static_value_key', 1511873470),
('m160812_065055_fix_dynamic_content', 1511873470),
('m161221_195847_ability_to_disable_navigation_elements', 1511873470),
('m161222_193732_json_editor_property_handler', 1511873470),
('m170127_063746_add_position_to_counter', 1511873470),
('m170408_060716_disctype_add_customview', 1511873470);

-- --------------------------------------------------------

--
-- Структура таблицы `model_anchor_index`
--

CREATE TABLE IF NOT EXISTS `model_anchor_index` (
  `model_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `next_index` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `navigation`
--

CREATE TABLE IF NOT EXISTS `navigation` (
  `id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `route` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `route_params` text COLLATE utf8_unicode_ci,
  `advanced_css_class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `navigation`
--

INSERT INTO `navigation` (`id`, `parent_id`, `name`, `url`, `route`, `route_params`, `advanced_css_class`, `sort_order`, `active`) VALUES
(1, 0, 'Main menu', '/', '/', '{}', '', 0, 1),
(6, 1, 'Акции', '/akcii', '', '{}', '', 0, 1),
(7, 1, 'Мотосервис', '/motoservis', '', '{}', '', 1, 1),
(8, 1, 'Статьи', '/stati', '', '{}', '', 3, 1),
(9, 1, 'Таблица размеров', '/tablica-razmerov', '', '{}', '', 4, 1),
(10, 1, 'Производители', '/proizvoditeli', '', '{}', '', 5, 1),
(11, 1, 'Контакты', '/kontakty', '', '{}', '', 7, 1),
(12, 1, 'Оплата и доставка', '/oplata-i-dostavka', '', '{}', '', 6, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `notification`
--

CREATE TABLE IF NOT EXISTS `notification` (
  `id` bigint(20) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` enum('default','primary','success','info','warning','danger') COLLATE utf8_unicode_ci DEFAULT 'default',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `viewed` tinyint(3) unsigned DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `object`
--

CREATE TABLE IF NOT EXISTS `object` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `object_class` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `object_table_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `column_properties_table_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `eav_table_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `categories_table_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `link_slug_category` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `link_slug_static_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `object_slug_attribute` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `object`
--

INSERT INTO `object` (`id`, `name`, `object_class`, `object_table_name`, `column_properties_table_name`, `eav_table_name`, `categories_table_name`, `link_slug_category`, `link_slug_static_value`, `object_slug_attribute`) VALUES
(1, 'Page', 'app\\modules\\page\\models\\Page', 'page', 'page_property', 'page_eav', 'page_category', 'page_category_full_slug', 'page_static_value_category', 'slug'),
(2, 'Category', 'app\\modules\\shop\\models\\Category', 'category', 'category_property', 'category_eav', 'category_category', 'category_category_full_slug', 'category_static_value_category', 'slug'),
(3, 'Product', 'app\\modules\\shop\\models\\Product', 'product', 'product_property', 'product_eav', 'product_category', 'product_category_full_slug', 'product_static_value_category', 'slug'),
(4, 'Order', 'app\\modules\\shop\\models\\Order', 'order', 'order_property', 'order_eav', 'order_category', 'order_category_full_slug', 'order_static_value_full_slug', 'slug'),
(5, 'Form', 'app\\models\\Form', 'form', 'form_property', 'form_eav', 'form_category', 'form_category_full_slug', 'form_static_value_full_sluug', 'slug'),
(6, 'Submission', 'app\\models\\Submission', 'submission', 'submission_property', 'submission_eav', 'submission_category', 'submission_category_full_slug', 'submission_static_value_full_slug', 'slug'),
(7, 'User', 'app\\modules\\user\\models\\User', 'user', 'user_property', 'user_eav', 'user_category', 'user_category_full_slug', 'user_static_value_full_slug', 'slug'),
(8, 'Property', 'app\\models\\Property', 'property', 'property_property', 'property_eav', 'property_category', 'property_category_full_slug', 'property_static_value_category', 'slug'),
(9, 'PropertyStaticValues', 'app\\models\\PropertyStaticValues', 'property_static_values', 'property_static_values_properties', 'property_static_values_eav', 'property_static_values_category', 'property_static_values_category_full_slug', 'property_static_values_static_value_category', 'slug'),
(10, 'Customer', 'app\\modules\\shop\\models\\Customer', 'customer', 'customer_property', 'customer_eav', 'customer_category', 'customer_category_slug', 'customer_slug_static', 'slug'),
(11, 'Contragent', 'app\\modules\\shop\\models\\Contragent', 'contragent', 'contragent_property', 'contragent_eav', 'contragent_category', 'contragent_category_slug', 'contragent_slug_static', 'slug'),
(12, 'OrderDeliveryInformation', 'app\\modules\\shop\\models\\OrderDeliveryInformation', 'order_delivery_information', 'order_delivery_information_property', 'order_delivery_information_eav', 'order_delivery_information_category', 'order_delivery_information_category_slug', 'order_delivery_information_slug_static', 'slug'),
(13, 'Navigation', 'app\\widgets\\navigation\\models\\Navigation', 'navigation', 'navigation_property', 'navigation_eav', 'navigation_category', 'navigation_category_full_slug', 'navigation_static_value_category', 'slug'),
(14, 'Addon', 'app\\modules\\shop\\models\\Addon', 'addon', 'addon_property', 'addon_eav', 'addon_category', 'addon_category_full_slug', 'addon_static_value_category', 'slug');

-- --------------------------------------------------------

--
-- Структура таблицы `object_property_group`
--

CREATE TABLE IF NOT EXISTS `object_property_group` (
  `id` int(10) unsigned NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL,
  `property_group_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `object_property_group`
--

INSERT INTO `object_property_group` (`id`, `object_id`, `object_model_id`, `property_group_id`) VALUES
(2, 3, 1, 6),
(5, 3, 1, 5),
(6, 3, 1, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `object_static_values`
--

CREATE TABLE IF NOT EXISTS `object_static_values` (
  `id` int(10) unsigned NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL,
  `property_static_value_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `object_static_values`
--

INSERT INTO `object_static_values` (`id`, `object_id`, `object_model_id`, `property_static_value_id`) VALUES
(1, 3, 1, 1),
(2, 3, 1, 2),
(3, 3, 1, 1),
(4, 3, 1, 1),
(5, 3, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `order`
--

CREATE TABLE IF NOT EXISTS `order` (
  `id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `manager_id` int(10) unsigned DEFAULT '0',
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `cart_forming_time` int(11) DEFAULT '0',
  `order_stage_id` int(10) unsigned NOT NULL,
  `payment_type_id` int(10) unsigned DEFAULT '0',
  `assigned_id` int(10) unsigned DEFAULT NULL,
  `tax_id` int(10) unsigned DEFAULT NULL,
  `external_id` varchar(38) COLLATE utf8_unicode_ci DEFAULT NULL,
  `items_count` float unsigned DEFAULT NULL,
  `total_price` float DEFAULT '0',
  `total_payed` float DEFAULT '0',
  `hash` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `is_deleted` tinyint(3) unsigned DEFAULT '0',
  `temporary` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `show_price_changed_notification` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0',
  `contragent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `in_cart` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `order`
--

INSERT INTO `order` (`id`, `user_id`, `manager_id`, `start_date`, `update_date`, `end_date`, `cart_forming_time`, `order_stage_id`, `payment_type_id`, `assigned_id`, `tax_id`, `external_id`, `items_count`, `total_price`, `total_payed`, `hash`, `is_deleted`, `temporary`, `show_price_changed_notification`, `customer_id`, `contragent_id`, `in_cart`) VALUES
(1, 1, 0, '2018-01-05 12:49:14', '2018-01-05 23:16:06', NULL, 0, 4, 1, NULL, NULL, NULL, 1, 49980, 0, '865f0962177b7f8d61b8410306c22c91', 0, 0, 0, 1, 1, 0),
(2, 1, 0, '2018-01-05 23:17:10', '2018-01-05 23:25:57', NULL, 0, 4, 1, NULL, NULL, NULL, 2, 71980, 0, '63cfd5ecd411ec0891467a7cb544e815', 0, 0, 0, 1, 1, 0),
(3, 1, 0, '2018-01-05 23:26:27', '2018-01-10 16:49:15', NULL, 0, 4, 1, NULL, NULL, NULL, 1, 12495, 0, '42b0053f038f7d46cefb33e3276e1296', 0, 0, 0, 1, 1, 0),
(4, 1, 0, '2018-01-10 17:02:08', '2018-01-10 17:02:08', NULL, 0, 1, 0, NULL, NULL, NULL, 2, 12495, 0, '8ce4e09ec9a8f2bf04fe0b8e22a517ea', 0, 1, 0, 0, 0, 1),
(5, 1, 0, '2018-01-11 13:14:17', '2018-01-11 13:16:21', NULL, 0, 1, 0, NULL, NULL, NULL, 2, 284890, 0, '291e8c04fb8df39b99739bddefdbf517', 0, 1, 0, 0, 0, 1),
(6, 0, 0, '2018-01-11 13:17:28', '2018-01-11 13:17:28', NULL, 0, 1, 0, NULL, NULL, NULL, 1, 0, 0, '774a6f521cdc446329f3320e2db734e6', 0, 1, 0, 0, 0, 1),
(7, 0, 0, '2018-01-11 15:27:10', '2018-01-11 15:27:10', NULL, 0, 1, 0, NULL, NULL, NULL, 0, 0, 0, 'c5f063c22946a6cb5836a22a0be1acc9', 0, 1, 0, 0, 0, 1),
(8, 0, 0, '2018-01-11 19:54:05', '2018-01-11 19:54:05', NULL, 0, 1, 0, NULL, NULL, NULL, 1, 12495, 0, 'c57aeb003e73d0e2634b2819a09fbea2', 0, 1, 0, 0, 0, 1),
(9, 0, 0, '2018-01-11 22:35:31', '2018-01-11 22:35:31', NULL, 0, 1, 0, NULL, NULL, NULL, 1, 49980, 0, '5cc88a68b69871c1ae19ef16c900d510', 0, 1, 0, 0, 0, 1),
(10, 0, 0, '2018-01-12 09:14:21', '2018-01-12 09:14:21', NULL, 0, 1, 0, NULL, NULL, NULL, 1, 15000, 0, 'b5b49b9a389b2774da7bea4f20dc81cd', 0, 1, 0, 0, 0, 1),
(11, 0, 0, '2018-01-12 11:03:04', '2018-01-12 11:03:04', NULL, 0, 1, 0, NULL, NULL, NULL, 1, 49980, 0, 'ee162d4250484f102009d208038d3c16', 0, 1, 0, 0, 0, 1),
(12, 0, 0, '2018-01-12 20:21:17', '2018-01-12 20:21:17', NULL, 0, 1, 0, NULL, NULL, NULL, 1, 2000, 0, 'fab7522ab221819db825ca5836c6bab9', 0, 1, 0, 0, 0, 1),
(13, 0, 0, '2018-01-12 20:25:49', '2018-01-12 20:25:49', NULL, 0, 1, 0, NULL, NULL, NULL, 1, 1000, 0, 'b8c918b288c9026902a7b175a964ce7d', 0, 1, 0, 0, 0, 1),
(14, 0, 0, '2018-01-12 20:35:11', '2018-01-12 20:35:11', NULL, 0, 1, 0, NULL, NULL, NULL, 1, 2000, 0, 'e3105f22d943fbaa9481b0c3a8a09521', 0, 1, 0, 0, 0, 1),
(15, 0, 0, '2018-01-12 23:06:58', '2018-01-12 23:06:58', NULL, 0, 1, 0, NULL, NULL, NULL, 1, 1000, 0, '41ae8c3fb0aff2931cb1bbf3396b0b65', 0, 1, 0, 0, 0, 1),
(16, 1, 0, '2018-01-14 10:08:32', '2018-01-14 11:02:43', NULL, 0, 1, 0, NULL, NULL, NULL, 1, 0, 0, '0201d7274d4fa49fac33707c77685925', 0, 1, 0, 0, 0, 1),
(17, 1, 0, '2018-01-14 20:35:48', '2018-01-14 20:37:49', NULL, 0, 1, 0, NULL, NULL, NULL, 2, 1000, 0, 'e6050a23b91145b14495fca2fcb1a8dc', 0, 1, 0, 0, 0, 1),
(18, 0, 0, '2018-01-14 20:40:37', '2018-01-14 20:40:37', NULL, 0, 1, 0, NULL, NULL, NULL, 0, 0, 0, '6b919f8f2a04da03d306e442dfc50851', 0, 1, 0, 0, 0, 1),
(19, 0, 0, '2018-01-15 08:45:09', '2018-01-15 08:45:46', NULL, 0, 2, 0, NULL, NULL, NULL, 0, 0, 0, 'c8cd9b083f583909eb7f4d70a0b27208', 0, 1, 0, 2, 2, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `order_category`
--

CREATE TABLE IF NOT EXISTS `order_category` (
  `id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `order_chat`
--

CREATE TABLE IF NOT EXISTS `order_chat` (
  `id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `message` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `order_code`
--

CREATE TABLE IF NOT EXISTS `order_code` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `discount_code_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `order_delivery_information`
--

CREATE TABLE IF NOT EXISTS `order_delivery_information` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `shipping_option_id` int(11) NOT NULL,
  `shipping_price` float NOT NULL DEFAULT '0',
  `shipping_price_total` float NOT NULL DEFAULT '0',
  `planned_delivery_date` date DEFAULT NULL,
  `planned_delivery_time` time DEFAULT NULL,
  `planned_delivery_time_range` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `order_delivery_information`
--

INSERT INTO `order_delivery_information` (`id`, `order_id`, `shipping_option_id`, `shipping_price`, `shipping_price_total`, `planned_delivery_date`, `planned_delivery_time`, `planned_delivery_time_range`) VALUES
(1, 1, 1, 0, 0, NULL, NULL, NULL),
(2, 2, 1, 0, 0, NULL, NULL, NULL),
(3, 3, 1, 0, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `order_delivery_information_eav`
--

CREATE TABLE IF NOT EXISTS `order_delivery_information_eav` (
  `id` int(11) NOT NULL,
  `object_model_id` int(11) unsigned NOT NULL,
  `property_group_id` int(11) unsigned NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `order_discount`
--

CREATE TABLE IF NOT EXISTS `order_discount` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `discount_id` int(11) NOT NULL,
  `applied_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `order_eav`
--

CREATE TABLE IF NOT EXISTS `order_eav` (
  `id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL,
  `property_group_id` int(10) unsigned NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `order_item`
--

CREATE TABLE IF NOT EXISTS `order_item` (
  `id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order_id` int(10) unsigned DEFAULT '0',
  `product_id` int(10) unsigned NOT NULL,
  `custom_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quantity` float NOT NULL DEFAULT '1',
  `price_per_pcs` float NOT NULL DEFAULT '0',
  `total_price_without_discount` float NOT NULL DEFAULT '0',
  `lock_product_price` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `discount_amount` float NOT NULL DEFAULT '0',
  `total_price` float NOT NULL DEFAULT '0',
  `addon_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `order_item`
--

INSERT INTO `order_item` (`id`, `parent_id`, `order_id`, `product_id`, `custom_name`, `quantity`, `price_per_pcs`, `total_price_without_discount`, `lock_product_price`, `discount_amount`, `total_price`, `addon_id`) VALUES
(37, 0, 4, 5, NULL, 1, 0, 0, 0, 0, 0, 0),
(38, 0, 4, 1, NULL, 1, 12495, 12495, 0, 0, 12495, 0),
(40, 0, 6, 5, NULL, 1, 0, 0, 0, 0, 0, 0),
(61, 0, 9, 1, NULL, 4, 12495, 49980, 0, 0, 49980, 0),
(72, 0, 5, 1, NULL, 22, 12495, 274890, 0, 0, 274890, 0),
(73, 0, 5, 4, NULL, 10, 1000, 10000, 0, 0, 10000, 0),
(75, 0, 11, 1, NULL, 4, 12495, 49980, 0, 0, 49980, 0),
(146, 0, 10, 4, NULL, 15, 1000, 15000, 0, 0, 15000, 0),
(147, 0, 12, 4, NULL, 2, 1000, 2000, 0, 0, 2000, 0),
(156, 0, 13, 4, NULL, 1, 1000, 1000, 0, 0, 1000, 0),
(157, 0, 14, 4, NULL, 2, 1000, 2000, 0, 0, 2000, 0),
(158, 0, 15, 4, NULL, 1, 1000, 1000, 0, 0, 1000, 0),
(177, 0, 8, 1, NULL, 1, 12495, 12495, 0, 0, 12495, 0),
(178, 0, 16, 5, NULL, 2, 0, 0, 0, 0, 0, 0),
(191, 0, 17, 5, NULL, 1, 0, 0, 0, 0, 0, 0),
(192, 0, 17, 4, NULL, 1, 1000, 1000, 0, 0, 1000, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `order_property`
--

CREATE TABLE IF NOT EXISTS `order_property` (
  `object_model_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `order_stage`
--

CREATE TABLE IF NOT EXISTS `order_stage` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name_frontend` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name_short` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_initial` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_buyer_stage` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `become_non_temporary` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_in_cart` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `immutable_by_user` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `immutable_by_manager` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `immutable_by_assigned` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `reach_goal_ym` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reach_goal_ga` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `view` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `order_stage`
--

INSERT INTO `order_stage` (`id`, `name`, `name_frontend`, `name_short`, `is_initial`, `is_buyer_stage`, `become_non_temporary`, `is_in_cart`, `immutable_by_user`, `immutable_by_manager`, `immutable_by_assigned`, `reach_goal_ym`, `reach_goal_ga`, `event_name`, `view`) VALUES
(1, 'customer', 'Информация о Вас', 'customer', 1, 1, 0, 1, 0, 0, 0, '', '', 'order_stage_customer', '@app/modules/shop/views/cart/stages/name.php'),
(2, 'delivery', 'Доставка', 'delivery', 0, 1, 0, 1, 0, 0, 0, '', '', 'order_stage_delivery', '@app/modules/shop/views/cart/stages/delivery.php'),
(3, 'payment', 'Выбор способа оплаты', 'payment', 0, 1, 0, 1, 0, 0, 0, '', '', 'order_stage_payment', '@app/modules/shop/views/cart/stages/payment.php'),
(4, 'payment pay', 'Оплата', 'payment pay', 0, 0, 1, 0, 0, 0, 0, '', '', 'order_stage_payment_pay', '@app/modules/shop/views/cart/stages/pay.php'),
(5, 'final', 'Заказ завершен', 'final', 0, 0, 0, 0, 1, 1, 1, '', '', 'order_stage_final', '');

-- --------------------------------------------------------

--
-- Структура таблицы `order_stage_leaf`
--

CREATE TABLE IF NOT EXISTS `order_stage_leaf` (
  `id` int(10) unsigned NOT NULL,
  `stage_from_id` int(10) unsigned NOT NULL,
  `stage_to_id` int(10) unsigned NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `button_label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `button_css_class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notify_buyer` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `buyer_notification_view` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notify_manager` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `manager_notification_view` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assign_to_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `assign_to_role` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notify_new_assigned_user` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `role_assignment_policy` enum('random','fair_distribution','last_picked_from_role') COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `order_stage_leaf`
--

INSERT INTO `order_stage_leaf` (`id`, `stage_from_id`, `stage_to_id`, `sort_order`, `button_label`, `button_css_class`, `notify_buyer`, `buyer_notification_view`, `notify_manager`, `manager_notification_view`, `assign_to_user_id`, `assign_to_role`, `notify_new_assigned_user`, `role_assignment_policy`, `event_name`) VALUES
(1, 1, 2, 0, 'Выбор способа доставки', 'btn btn-primary', 0, NULL, 0, NULL, 0, NULL, 0, 'random', 'order_stageleaf_customer'),
(2, 2, 3, 0, 'Выбор способа оплаты', 'btn btn-primary', 0, NULL, 0, NULL, 0, NULL, 0, 'random', 'order_stageleaf_delivery_choose'),
(3, 3, 4, 0, 'Перейти к оплате', 'btn btn-success', 0, NULL, 1, NULL, 0, NULL, 0, 'random', 'order_stageleaf_payment_choose'),
(4, 5, 4, 0, 'Заказ завершен', 'btn btn-primary', 0, NULL, 0, NULL, 0, NULL, 0, 'random', 'order_stage_leaf_final');

-- --------------------------------------------------------

--
-- Структура таблицы `order_transaction`
--

CREATE TABLE IF NOT EXISTS `order_transaction` (
  `id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `payment_type_id` int(10) unsigned NOT NULL,
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_date` timestamp NULL DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `total_sum` decimal(10,2) NOT NULL,
  `params` text COLLATE utf8_unicode_ci,
  `result_data` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `order_transaction`
--

INSERT INTO `order_transaction` (`id`, `order_id`, `payment_type_id`, `start_date`, `end_date`, `status`, `total_sum`, `params`, `result_data`) VALUES
(1, 1, 1, '2018-01-05 23:16:06', '2018-01-05 23:16:06', 5, 49980.00, NULL, NULL),
(2, 2, 1, '2018-01-05 23:25:57', '2018-01-05 23:25:57', 5, 71980.00, NULL, NULL),
(3, 3, 1, '2018-01-10 16:49:15', '2018-01-10 16:49:15', 5, 12495.00, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `page`
--

CREATE TABLE IF NOT EXISTS `page` (
  `id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned NOT NULL,
  `slug` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `slug_compiled` varchar(180) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `slug_absolute` tinyint(1) unsigned DEFAULT '0',
  `content` longtext COLLATE utf8_unicode_ci,
  `show_type` enum('show','list') COLLATE utf8_unicode_ci DEFAULT 'show',
  `published` tinyint(1) unsigned DEFAULT '1',
  `searchable` tinyint(1) unsigned DEFAULT '1',
  `robots` tinyint(3) unsigned DEFAULT '3',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` text COLLATE utf8_unicode_ci NOT NULL,
  `h1` text COLLATE utf8_unicode_ci,
  `meta_description` text COLLATE utf8_unicode_ci,
  `breadcrumbs_label` text COLLATE utf8_unicode_ci,
  `announce` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT '0',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` timestamp NULL DEFAULT NULL,
  `subdomain` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `page`
--

INSERT INTO `page` (`id`, `parent_id`, `slug`, `slug_compiled`, `slug_absolute`, `content`, `show_type`, `published`, `searchable`, `robots`, `name`, `title`, `h1`, `meta_description`, `breadcrumbs_label`, `announce`, `sort_order`, `date_added`, `date_modified`, `subdomain`) VALUES
(1, 0, ':mainpage:', '', 0, 'This is main page!', 'show', 1, 1, 3, NULL, 'Main page', NULL, NULL, NULL, NULL, 0, '2017-11-28 12:51:09', NULL, NULL),
(2, 1, 'oplata-i-dostavka', 'oplata-i-dostavka', 0, 'Оплата и доставка', 'show', 1, 1, 3, 'Оплата и доставка', 'Оплата и доставка', 'Оплата и доставка', 'Оплата и доставка', 'Оплата и доставка', '', 5, '2017-11-28 12:51:10', '2018-01-14 21:02:32', ''),
(3, 1, 'akcii', 'akcii', 0, 'Акции', 'show', 1, 1, 3, 'Акции', 'Акции', 'Акции', 'Акции', 'Акции', '', 0, '2017-11-28 12:51:10', '2018-01-14 20:56:07', ''),
(4, 1, 'motoservis', 'motoservis', 0, 'Мотосервис', 'show', 1, 1, 3, 'Мотосервис', 'Мотосервис', 'Мотосервис', 'Example META for Оплата', 'Мотосервис', '', 1, '2017-11-28 12:51:10', '2018-01-14 20:56:49', ''),
(5, 1, 'stati', 'stati', 0, '', 'show', 1, 1, 3, 'Статьи', 'Статьи', 'Статьи', '', 'Статьи', '', 2, '2018-01-14 21:00:03', NULL, ''),
(6, 1, 'tablica-razmerov', 'tablica-razmerov', 0, '', 'show', 1, 1, 3, 'Таблица размеров', 'Таблица размеров', 'Таблица размеров', '', 'Таблица размеров', '', 3, '2018-01-14 21:00:30', NULL, ''),
(7, 1, 'proizvoditeli', 'proizvoditeli', 0, '', 'show', 1, 1, 3, 'Производители', 'Производители', 'Производители', '', 'Производители', '', 4, '2018-01-14 21:02:08', NULL, ''),
(8, 1, 'kontakty', 'kontakty', 0, '', 'show', 1, 1, 3, 'Контакты', 'Контакты', 'Контакты', '', 'Контакты', '', 6, '2018-01-14 21:02:59', NULL, '');

-- --------------------------------------------------------

--
-- Структура таблицы `page_category`
--

CREATE TABLE IF NOT EXISTS `page_category` (
  `id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `page_eav`
--

CREATE TABLE IF NOT EXISTS `page_eav` (
  `id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL,
  `property_group_id` int(10) unsigned NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `page_property`
--

CREATE TABLE IF NOT EXISTS `page_property` (
  `object_model_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `payment_type`
--

CREATE TABLE IF NOT EXISTS `payment_type` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `class` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `params` text COLLATE utf8_unicode_ci,
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `commission` float DEFAULT '0',
  `active` tinyint(4) DEFAULT '0',
  `payment_available` tinyint(4) DEFAULT '1',
  `sort` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `payment_type`
--

INSERT INTO `payment_type` (`id`, `name`, `class`, `params`, `logo`, `commission`, `active`, `payment_available`, `sort`) VALUES
(1, 'Наличные', 'app\\components\\payment\\CashPayment', '[]', NULL, 0, 1, 1, 1),
(2, 'Robokassa', 'app\\components\\payment\\RobokassaPayment', '{"merchantLogin":"","merchantPass1":"","merchantPass2":"","merchantUrl":""}', NULL, 0, 1, 1, 2),
(3, 'PayU', 'app\\components\\payment\\PayUPayment', '{"merchantName":"","secretKey":""}', NULL, 0, 0, 1, 3),
(4, 'RBK Money', 'app\\components\\payment\\RBKMoneyPayment', '{"eshopId":"","currency":"RUR","language":"ru","secretKey":"","serviceName":""}', NULL, 0, 0, 1, 4),
(5, 'IntellectMoney', 'app\\components\\payment\\IntellectMoneyPayment', '{"eshopId":"","currency":"RUR","language":"ru","secretKey":"","serviceName":""}', NULL, 0, 0, 1, 5),
(6, 'Interkassa', 'app\\components\\payment\\InterkassaPayment', '{"checkoutId":"","currency":"RUB","locale":"ru","secretKey":""}', NULL, 0, 0, 1, 6),
(7, 'Futubank', 'app\\components\\payment\\FutubankPayment', '{"testing":"1","merchant":"","currency":"RUB","secretKey":""}', NULL, 0, 0, 1, 7),
(8, 'Pay2Pay', 'app\\components\\payment\\Pay2PayPayment', '{"hiddenKey":"","currency":"RUB","language":"ru","merchantId":"","secretKey":"","testMode":0}', NULL, 0, 0, 1, 8),
(9, 'SpryPay', 'app\\components\\payment\\SpryPayPayment', '{"currency":"rur","language":"ru","shopId":"","secretKey":""}', NULL, 0, 0, 1, 9),
(10, 'WalletOne', 'app\\components\\payment\\WalletOnePayment', '{"currency":643,"locale":"ru-RU","merchantId":"","secretKey":""}', NULL, 0, 0, 1, 10),
(11, 'PayOnline', 'app\\components\\payment\\PayOnlinePayment', '{"currency":"RUB","language":"ru","merchantId":"","privateKey":""}', NULL, 0, 0, 1, 11),
(12, 'LiqPay', 'app\\components\\payment\\LiqPayPayment', '{"currency":"RUB","language":"ru","privateKey":"","publicKey":""}', NULL, 0, 0, 1, 12),
(13, 'Platron', '`payment_type`', '{"merchantId":"","secretKey":"","strCurrency":"RUR","merchantUrl":"www.platron.ru","merchantScriptName":"payment.php"}', NULL, 0, 0, 1, 13),
(14, 'PayPal', 'app\\components\\payment\\PayPalPayment', '{"clientId":"","clientSecret":"","currency":"","transactionDescription":"","sandbox":false}', '', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `prefiltered_pages`
--

CREATE TABLE IF NOT EXISTS `prefiltered_pages` (
  `id` int(11) NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `last_category_id` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text COLLATE utf8_unicode_ci,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `announce` text COLLATE utf8_unicode_ci,
  `content` text COLLATE utf8_unicode_ci,
  `h1` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `meta_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `breadcrumbs_label` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `view_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `id` int(10) unsigned NOT NULL,
  `main_category_id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT '0',
  `option_generate` text COLLATE utf8_unicode_ci,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `h1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `breadcrumbs_label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(80) COLLATE utf8_unicode_ci DEFAULT '',
  `slug_compiled` varchar(180) COLLATE utf8_unicode_ci DEFAULT '',
  `slug_absolute` tinyint(4) DEFAULT '0',
  `content` text COLLATE utf8_unicode_ci,
  `announce` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT '0',
  `active` tinyint(4) DEFAULT '1',
  `price` float unsigned DEFAULT '0',
  `old_price` float unsigned DEFAULT '0',
  `sku` varchar(70) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `unlimited_count` tinyint(4) NOT NULL DEFAULT '1',
  `currency_id` int(10) unsigned NOT NULL DEFAULT '1',
  `measure_id` int(10) unsigned NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `product`
--

INSERT INTO `product` (`id`, `main_category_id`, `parent_id`, `option_generate`, `name`, `title`, `h1`, `meta_description`, `breadcrumbs_label`, `slug`, `slug_compiled`, `slug_absolute`, `content`, `announce`, `sort_order`, `active`, `price`, `old_price`, `sku`, `unlimited_count`, `currency_id`, `measure_id`, `date_added`, `date_modified`) VALUES
(1, 3, 0, '{"group":"4","values":[]}', 'ALPINESTARS Куртка T-GP PLUS R AIR JACKET', 'ALPINESTARS Куртка T-GP PLUS R AIR JACKET', 'ALPINESTARS Куртка T-GP PLUS R AIR JACKET', 'ALPINESTARS Куртка T-GP PLUS R AIR JACKETALPINESTARS Куртка T-GP PLUS R AIR JACKETALPINESTARS Куртка T-GP PLUS R AIR JACKETALPINESTARS Куртка T-GP PLUS R AIR JACKETALPINESTARS Куртка T-GP PLUS R AIR JACKETALPINESTARS Куртка T-GP PLUS R AIR JACKET', 'ALPINESTARS Куртка T-GP PLUS R AIR JACKET', 'alpinestars-kurtka-t-gp-plus-r-air-jacket', '', 0, '<p>Спортивная текстильная мотокуртка Alpinestars T-GP Plus R Air с улучшенной вентиляцией Внешний слой - полиэстер 450D/600D и обширные сетчатые вставки на груди и рукавах Светоотражающая отделка для улучшения видимости в ночное время Стрейч-вставки в области плеч и на рукавах для лучшей подвижности рук Съемная CE-сертифицированная защита локтей и плеч Alpinestars Bio ArmorОтсек для установки защиты спины (совместим с защитой Alpinestrs Bio Armor Back Protector)Регулировка обхвата талии и манжет на липучках Водонепроницаемый внутренний карман Мягкий воротник с 3D-сетчатой структурой Встроенная молния для соединения с мотобрюками Alpinestars</p>', 'Спортивная текстильная мотокуртка Alpinestars T-GP Plus R Air с улучшенной вентиляцией Внешний слой - полиэстер 450D/600D и обширные сетчатые вставки на груди и рукавах Светоотражающая отделка для улучшения видимости в ночное время Стрейч-вставки в области плеч  и на рукавах для лучшей подвижности рук Съемная CE-сертифицированная защита локтей и плеч Alpinestars Bio ArmorОтсек для установки защиты спины (совместим с защитой Alpinestrs Bio Armor Back Protector)Регулировка обхвата талии и манжет на липучках Водонепроницаемый внутренний карман Мягкий воротник с 3D-сетчатой структурой Встроенная молния для соединения с мотобрюками Alpinestars', 0, 1, 12495, 0, '3300614', 1, 1, 1, '2017-12-24 12:27:01', '2018-02-02 10:22:26'),
(4, 4, 0, '{"group":"4","values":[]}', 'ТЕСТ', 'ТЕСТ', 'ТЕСТ', '', 'ТЕСТ', 'test', '', 0, '', '', 0, 1, 1000, 0, '', 1, 1, 1, '2018-01-04 14:39:55', '2018-01-05 13:27:12'),
(5, 4, 0, '{"group":"4","values":[]}', 'TEST1222', 'TEST1', 'TEST1', '', 'TEST1', 'test1222', '', 0, '', '', 0, 1, 0, 0, '', 1, 1, 1, '2018-01-04 15:33:21', '2018-01-04 15:35:09'),
(6, 5, 0, '{"group":"4","values":[]}', 'NTTSDS', 'NTTSDS', 'NTTSDS', '', 'NTTSDS', 'nttsds', '', 0, '', '', 0, 1, 0, 0, '', 1, 1, 1, '2018-01-04 15:45:07', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `product_category`
--

CREATE TABLE IF NOT EXISTS `product_category` (
  `id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL,
  `sort_order` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `product_category`
--

INSERT INTO `product_category` (`id`, `category_id`, `object_model_id`, `sort_order`) VALUES
(1, 3, 1, 0),
(2, 2, 1, 0),
(7, 4, 4, 0),
(9, 4, 5, 0),
(10, 5, 6, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `product_category_full_slug`
--

CREATE TABLE IF NOT EXISTS `product_category_full_slug` (
  `id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `full_slug_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `product_discount`
--

CREATE TABLE IF NOT EXISTS `product_discount` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `discount_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `product_eav`
--

CREATE TABLE IF NOT EXISTS `product_eav` (
  `id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL,
  `property_group_id` int(10) unsigned NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `product_eav`
--

INSERT INTO `product_eav` (`id`, `object_model_id`, `property_group_id`, `key`, `value`, `sort_order`) VALUES
(1, 1, 4, 'cherno_bely', '2', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `product_listing_sort`
--

CREATE TABLE IF NOT EXISTS `product_listing_sort` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sort_field` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `asc_desc` enum('asc','desc') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'asc',
  `enabled` smallint(6) NOT NULL DEFAULT '1',
  `sort_order` int(10) unsigned DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `product_listing_sort`
--

INSERT INTO `product_listing_sort` (`id`, `name`, `sort_field`, `asc_desc`, `enabled`, `sort_order`) VALUES
(1, 'Popularity', 'product.sort_order', 'asc', 1, 0),
(2, 'Price 0-9', 'product.price', 'asc', 1, 1),
(3, 'Price 9-0', 'product.price', 'desc', 1, 2),
(4, 'Name', 'product.name', 'asc', 1, 3),
(5, 'Name', 'product.name', 'desc', 1, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `product_property`
--

CREATE TABLE IF NOT EXISTS `product_property` (
  `object_model_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `product_static_value_full_slug`
--

CREATE TABLE IF NOT EXISTS `product_static_value_full_slug` (
  `id` int(10) unsigned NOT NULL,
  `full_slug_id` int(10) unsigned NOT NULL,
  `property_static_value_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `property`
--

CREATE TABLE IF NOT EXISTS `property` (
  `id` int(10) unsigned NOT NULL,
  `property_group_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `value_type` enum('STRING','NUMBER') COLLATE utf8_unicode_ci DEFAULT 'STRING',
  `property_handler_id` int(10) unsigned NOT NULL,
  `has_static_values` tinyint(4) DEFAULT '0',
  `has_slugs_in_values` tinyint(4) DEFAULT '0',
  `is_eav` tinyint(4) DEFAULT '0',
  `is_column_type_stored` tinyint(4) DEFAULT '0',
  `multiple` tinyint(4) DEFAULT '0',
  `sort_order` int(11) DEFAULT '0',
  `handler_additional_params` text COLLATE utf8_unicode_ci NOT NULL,
  `display_only_on_depended_property_selected` tinyint(4) DEFAULT '0',
  `depends_on_property_id` int(11) DEFAULT '0',
  `depended_property_values` text COLLATE utf8_unicode_ci,
  `depends_on_category_group_id` int(11) DEFAULT '0',
  `hide_other_values_if_selected` tinyint(4) DEFAULT '0',
  `dont_filter` tinyint(1) NOT NULL DEFAULT '0',
  `mask` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alias` smallint(6) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `property`
--

INSERT INTO `property` (`id`, `property_group_id`, `name`, `key`, `value_type`, `property_handler_id`, `has_static_values`, `has_slugs_in_values`, `is_eav`, `is_column_type_stored`, `multiple`, `sort_order`, `handler_additional_params`, `display_only_on_depended_property_selected`, `depends_on_property_id`, `depended_property_values`, `depends_on_category_group_id`, `hide_other_values_if_selected`, `dont_filter`, `mask`, `alias`) VALUES
(7, 4, 'черно-белый', 'cherno_bely', 'STRING', 3, 0, 0, 0, 1, 0, 0, '{"interpret_as":"notinterpret","rules":[]}', 0, 0, '', 0, 1, 0, NULL, NULL),
(8, 4, 'черно-клубничный', 'cherno_klubnichny', 'STRING', 3, 0, 0, 0, 1, 0, 0, '{"interpret_as":"notinterpret","rules":["required"]}', 0, 0, '', 0, 0, 0, NULL, NULL),
(9, 5, 'S', 's', 'STRING', 2, 0, 0, 0, 0, 0, 0, '{"interpret_as":"notinterpret","rules":[]}', 0, 0, '', 0, 0, 0, NULL, NULL),
(10, 5, 'M', 'm', 'STRING', 2, 0, 0, 0, 0, 0, 0, '{"interpret_as":"notinterpret","rules":[]}', 0, 0, '', 0, 0, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `property_category`
--

CREATE TABLE IF NOT EXISTS `property_category` (
  `object_model_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `property_group`
--

CREATE TABLE IF NOT EXISTS `property_group` (
  `id` int(10) unsigned NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` int(11) DEFAULT '0',
  `is_internal` tinyint(4) DEFAULT '0',
  `hidden_group_title` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `property_group`
--

INSERT INTO `property_group` (`id`, `object_id`, `name`, `sort_order`, `is_internal`, `hidden_group_title`) VALUES
(4, 3, 'Цвета', 0, 0, 0),
(5, 3, 'Размеры', 0, 0, 0),
(6, 3, 'Артикул', 0, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `property_handler`
--

CREATE TABLE IF NOT EXISTS `property_handler` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `frontend_render_view` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `frontend_edit_view` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `backend_render_view` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `backend_edit_view` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handler_class_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `property_handler`
--

INSERT INTO `property_handler` (`id`, `name`, `frontend_render_view`, `frontend_edit_view`, `backend_render_view`, `backend_edit_view`, `handler_class_name`) VALUES
(1, 'Text', 'frontend-render', 'frontend-edit', 'backend-render', 'backend-edit', 'app\\properties\\handlers\\text\\TextProperty'),
(2, 'Select', 'frontend-render', 'frontend-edit', 'backend-render', 'backend-edit', 'app\\properties\\handlers\\select\\SelectProperty'),
(3, 'Checkbox', 'frontend-render', 'frontend-edit', 'backend-render', 'backend-edit', 'app\\properties\\handlers\\checkbox\\CheckboxProperty'),
(4, 'Text area', 'frontend-render', 'frontend-edit', 'backend-render', 'backend-edit', 'app\\properties\\handlers\\textArea\\TextAreaProperty'),
(5, 'File', 'frontend-render', 'frontend-edit', 'backend-render', 'backend-edit', 'app\\properties\\handlers\\fileInput\\FileInputProperty'),
(6, 'Hidden', 'frontend-render', 'frontend-edit', 'backend-render', 'backend-edit', 'app\\properties\\handlers\\hidden\\HiddenProperty'),
(7, 'Redactor', 'frontend-render', 'frontend-edit', 'backend-render', 'backend-edit', 'app\\properties\\handlers\\redactor\\RedactorProperty'),
(8, 'DatePicker', 'frontend-render', 'frontend-edit', 'backend-render', 'backend-edit', 'app\\properties\\handlers\\datepicker\\DatepickerProperty'),
(9, 'MaskedInput', 'frontend-render', 'frontend-edit', 'backend-render', 'backend-edit', 'app\\properties\\handlers\\maskedinput\\MaskedinputProperty'),
(10, 'Product relation', 'frontend-render', 'frontend-edit', 'backend-render', 'backend-edit', 'app\\properties\\handlers\\productRelation\\ProductRelationProperty'),
(11, 'Json editor', 'frontend-render', 'frontend-edit', 'backend-render', 'backend-edit', 'app\\properties\\handlers\\json\\JsonProperty');

-- --------------------------------------------------------

--
-- Структура таблицы `property_static_values`
--

CREATE TABLE IF NOT EXISTS `property_static_values` (
  `id` int(10) unsigned NOT NULL,
  `property_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` int(11) DEFAULT '0',
  `title_append` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dont_filter` tinyint(1) NOT NULL DEFAULT '0',
  `title_prepend` smallint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `property_static_values`
--

INSERT INTO `property_static_values` (`id`, `property_id`, `name`, `value`, `slug`, `sort_order`, `title_append`, `dont_filter`, `title_prepend`) VALUES
(1, 9, '1', '1', '1', 0, '', 0, 0),
(2, 7, 'Черный', 'Черный', 'cherny', 0, 'Черный', 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `rating_item`
--

CREATE TABLE IF NOT EXISTS `rating_item` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `rating_group` varchar(255) NOT NULL,
  `min_value` int(11) NOT NULL DEFAULT '0',
  `max_value` int(11) NOT NULL DEFAULT '5',
  `step_value` int(11) NOT NULL DEFAULT '1',
  `require_review` tinyint(1) DEFAULT '0',
  `allow_guest` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `rating_values`
--

CREATE TABLE IF NOT EXISTS `rating_values` (
  `id` int(11) NOT NULL,
  `rating_id` char(32) NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL,
  `rating_item_id` int(10) unsigned NOT NULL,
  `value` int(11) NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `related_product`
--

CREATE TABLE IF NOT EXISTS `related_product` (
  `product_id` int(10) unsigned NOT NULL,
  `related_product_id` int(10) unsigned NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `review`
--

CREATE TABLE IF NOT EXISTS `review` (
  `id` int(10) unsigned NOT NULL,
  `object_id` int(10) unsigned DEFAULT '0',
  `object_model_id` int(10) unsigned NOT NULL,
  `author_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `review_text` text COLLATE utf8_unicode_ci,
  `status` enum('NEW','APPROVED','NOT APPROVED') COLLATE utf8_unicode_ci DEFAULT 'NEW',
  `rating_id` char(32) CHARACTER SET utf8 DEFAULT NULL,
  `submission_id` int(10) unsigned NOT NULL,
  `parent_id` int(11) DEFAULT '0',
  `root_id` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `route`
--

CREATE TABLE IF NOT EXISTS `route` (
  `id` int(10) unsigned NOT NULL,
  `route` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url_template` text COLLATE utf8_unicode_ci,
  `object_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `route`
--

INSERT INTO `route` (`id`, `route`, `url_template`, `object_id`, `name`) VALUES
(1, 'shop/product/list', '[{"class":"app\\\\properties\\\\url\\\\StaticPart","static_part":"catalog","parameters":{"category_group_id":1}},{"class":"app\\\\properties\\\\url\\\\PartialCategoryPathPart","category_group_id":1}]', 3, ''),
(2, 'shop/product/show', '[{"class":"app\\\\properties\\\\url\\\\StaticPart","static_part":"catalog","parameters":{"category_group_id":1}},{"class":"app\\\\properties\\\\url\\\\FullCategoryPathPart","category_group_id":1},{"class":"app\\\\properties\\\\url\\\\ObjectSlugPart"}]', 3, '');

-- --------------------------------------------------------

--
-- Структура таблицы `seo_config`
--

CREATE TABLE IF NOT EXISTS `seo_config` (
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `seo_config`
--

INSERT INTO `seo_config` (`key`, `value`) VALUES
('robots.txt', 'User-agent: *\nDisallow: /cabinet\n');

-- --------------------------------------------------------

--
-- Структура таблицы `seo_counter`
--

CREATE TABLE IF NOT EXISTS `seo_counter` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `code` text COLLATE utf8_unicode_ci NOT NULL,
  `position` int(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `seo_meta`
--

CREATE TABLE IF NOT EXISTS `seo_meta` (
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `seo_redirect`
--

CREATE TABLE IF NOT EXISTS `seo_redirect` (
  `id` int(10) unsigned NOT NULL,
  `type` enum('STATIC','PREG') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'STATIC',
  `from` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `to` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `session`
--

CREATE TABLE IF NOT EXISTS `session` (
  `id` char(40) COLLATE utf8_unicode_ci NOT NULL,
  `expire` int(11) DEFAULT NULL,
  `data` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `shipping_discount`
--

CREATE TABLE IF NOT EXISTS `shipping_discount` (
  `id` int(11) NOT NULL,
  `shipping_option_id` int(11) NOT NULL,
  `discount_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `shipping_option`
--

CREATE TABLE IF NOT EXISTS `shipping_option` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `price_from` float DEFAULT '0',
  `price_to` float DEFAULT '0',
  `cost` float DEFAULT '0',
  `sort` int(11) DEFAULT '0',
  `active` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `shipping_option`
--

INSERT INTO `shipping_option` (`id`, `name`, `description`, `price_from`, `price_to`, `cost`, `sort`, `active`) VALUES
(1, 'Самовывоз', '', 0, 0, 0, 1, 1),
(2, 'Доставка почтой', '', 0, 0, 100, 2, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `sitemap`
--

CREATE TABLE IF NOT EXISTS `sitemap` (
  `uid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `slide`
--

CREATE TABLE IF NOT EXISTS `slide` (
  `id` int(11) NOT NULL,
  `slider_id` int(10) unsigned DEFAULT '0',
  `sort_order` int(10) unsigned DEFAULT '0',
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `link` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `custom_view_file` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `css_class` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `text` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `slide`
--

INSERT INTO `slide` (`id`, `slider_id`, `sort_order`, `image`, `link`, `custom_view_file`, `css_class`, `active`, `text`) VALUES
(1, 1, 1, 'http://st-1.dotplant.ru/img/dotplant-slider-demo/slide-1.jpg', '#1', '', '', 1, NULL),
(2, 1, 2, 'http://st-1.dotplant.ru/img/dotplant-slider-demo/slide-2.jpg', '#2', '', '', 1, NULL),
(3, 1, 3, 'http://st-1.dotplant.ru/img/dotplant-slider-demo/slide-3.jpg', '#3', '', '', 1, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `slider`
--

CREATE TABLE IF NOT EXISTS `slider` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `slider_handler_id` int(10) unsigned DEFAULT '0',
  `image_width` int(10) unsigned DEFAULT '300',
  `image_height` int(10) unsigned DEFAULT '300',
  `resize_big_images` tinyint(1) NOT NULL DEFAULT '1',
  `resize_small_images` tinyint(1) NOT NULL DEFAULT '0',
  `css_class` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `params` longtext COLLATE utf8_unicode_ci,
  `custom_slider_view_file` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `custom_slide_view_file` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `slider`
--

INSERT INTO `slider` (`id`, `name`, `slider_handler_id`, `image_width`, `image_height`, `resize_big_images`, `resize_small_images`, `css_class`, `params`, `custom_slider_view_file`, `custom_slide_view_file`) VALUES
(1, 'Example carousel', 1, 900, 350, 1, 0, '', NULL, '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `slider_handler`
--

CREATE TABLE IF NOT EXISTS `slider_handler` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `slider_widget` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `slider_edit_view_file` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `edit_model` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `slider_handler`
--

INSERT INTO `slider_handler` (`id`, `name`, `slider_widget`, `slider_edit_view_file`, `edit_model`) VALUES
(1, 'Bootstrap 3 carousel', 'app\\slider\\sliders\\bootstrap3\\Bootstrap3CarouselWidget', '@app/slider/sliders/bootstrap3/views/edit', 'app\\slider\\sliders\\bootstrap3\\models\\EditModel'),
(2, 'Slick', 'app\\slider\\sliders\\slick\\SlickCarouselWidget', '@app/slider/sliders/slick/views/edit', 'app\\slider\\sliders\\slick\\models\\EditModel');

-- --------------------------------------------------------

--
-- Структура таблицы `spam_checker`
--

CREATE TABLE IF NOT EXISTS `spam_checker` (
  `id` int(10) unsigned NOT NULL,
  `behavior` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `api_key` varchar(90) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author_field` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content_field` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `spam_checker`
--

INSERT INTO `spam_checker` (`id`, `behavior`, `api_key`, `name`, `author_field`, `content_field`) VALUES
(1, 'app\\behaviors\\spamchecker\\AkismetSpamChecker', NULL, 'Akismet', 'comment_author', 'comment_content');

-- --------------------------------------------------------

--
-- Структура таблицы `special_price_list`
--

CREATE TABLE IF NOT EXISTS `special_price_list` (
  `id` int(11) NOT NULL,
  `object_id` smallint(6) NOT NULL,
  `class` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `params` text,
  `type` enum('core','discount','delivery','tax','project') DEFAULT 'project',
  `handler` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `special_price_list`
--

INSERT INTO `special_price_list` (`id`, `object_id`, `class`, `active`, `sort_order`, `params`, `type`, `handler`) VALUES
(1, 3, 'app\\modules\\shop\\helpers\\PriceHandlers', 1, 5, NULL, 'core', 'getCurrencyPriceProduct'),
(2, 4, 'app\\modules\\shop\\helpers\\PriceHandlers', 1, 10, NULL, 'delivery', 'getDeliveryPriceOrder'),
(3, 3, 'app\\modules\\shop\\helpers\\PriceHandlers', 1, 15, NULL, 'discount', 'getDiscountPriceProduct'),
(4, 4, 'app\\modules\\shop\\helpers\\PriceHandlers', 1, 20, NULL, 'discount', 'getDiscountPriceOrder');

-- --------------------------------------------------------

--
-- Структура таблицы `special_price_object`
--

CREATE TABLE IF NOT EXISTS `special_price_object` (
  `id` int(11) NOT NULL,
  `special_price_list_id` int(11) NOT NULL,
  `object_model_id` int(11) NOT NULL,
  `price` float NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `special_price_object`
--

INSERT INTO `special_price_object` (`id`, `special_price_list_id`, `object_model_id`, `price`, `name`) VALUES
(1, 2, 1, 0, 'Самовывоз'),
(2, 2, 2, 0, 'Самовывоз'),
(3, 2, 3, 0, 'Самовывоз');

-- --------------------------------------------------------

--
-- Структура таблицы `submission`
--

CREATE TABLE IF NOT EXISTS `submission` (
  `id` int(10) unsigned NOT NULL,
  `form_id` int(10) unsigned NOT NULL,
  `date_received` datetime DEFAULT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `piwik_visitor_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `additional_information` longtext COLLATE utf8_unicode_ci,
  `date_viewed` datetime DEFAULT NULL,
  `date_processed` datetime DEFAULT NULL,
  `processed_by_user_id` int(10) unsigned DEFAULT NULL,
  `processed` tinyint(1) DEFAULT '0',
  `internal_comment` text COLLATE utf8_unicode_ci,
  `submission_referrer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `visitor_referrer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `visitor_landing` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `visit_start_date` datetime DEFAULT NULL,
  `form_fill_time` int(11) DEFAULT NULL,
  `spam` tinyint(1) unsigned DEFAULT '0',
  `is_deleted` tinyint(3) unsigned DEFAULT '0',
  `sending_status` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `submission_category`
--

CREATE TABLE IF NOT EXISTS `submission_category` (
  `id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `submission_eav`
--

CREATE TABLE IF NOT EXISTS `submission_eav` (
  `id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL,
  `property_group_id` int(10) unsigned NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `submission_property`
--

CREATE TABLE IF NOT EXISTS `submission_property` (
  `object_model_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `subscribe_email`
--

CREATE TABLE IF NOT EXISTS `subscribe_email` (
  `id` int(10) unsigned NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT '0',
  `last_notify` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `theme_active_widgets`
--

CREATE TABLE IF NOT EXISTS `theme_active_widgets` (
  `id` int(11) NOT NULL,
  `part_id` int(11) DEFAULT NULL,
  `widget_id` int(11) DEFAULT NULL,
  `variation_id` int(11) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `configuration_json` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `theme_active_widgets`
--

INSERT INTO `theme_active_widgets` (`id`, `part_id`, `widget_id`, `variation_id`, `sort_order`, `configuration_json`) VALUES
(1, 2, 1, 2, 0, NULL),
(2, 2, 1, 1, 0, NULL),
(3, 4, 3, 1, 0, NULL),
(4, 6, 3, 3, 0, NULL),
(5, 10, 8, 1, 0, NULL),
(6, 10, 8, 2, 0, NULL),
(7, 5, 4, 2, 0, NULL),
(14, 12, 4, 1, 0, '{"rootCategoryId":1,"type":"tree","activeClass":"","activateParents":"0","header":"","displayHeader":false}'),
(16, 12, 4, 2, 0, '{"rootCategoryId":1,"type":"tree","activeClass":"","activateParents":"0","header":"","displayHeader":false}');

-- --------------------------------------------------------

--
-- Структура таблицы `theme_parts`
--

CREATE TABLE IF NOT EXISTS `theme_parts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `global_visibility` tinyint(1) NOT NULL DEFAULT '1',
  `multiple_widgets` tinyint(1) NOT NULL DEFAULT '1',
  `is_cacheable` tinyint(1) NOT NULL DEFAULT '1',
  `cache_lifetime` int(11) NOT NULL DEFAULT '0',
  `cache_tags` text COLLATE utf8_unicode_ci,
  `cache_vary_by_session` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `theme_parts`
--

INSERT INTO `theme_parts` (`id`, `name`, `key`, `global_visibility`, `multiple_widgets`, `is_cacheable`, `cache_lifetime`, `cache_tags`, `cache_vary_by_session`) VALUES
(1, 'Pre-Header', 'pre-header', 1, 1, 1, 86400, '\\app\\widgets\\navigation\\models\\Navigation', 0),
(2, 'Шапка', 'header', 1, 0, 0, 0, '\\app\\widgets\\navigation\\models\\Navigation', 0),
(3, 'Post-Header', 'post-header', 1, 1, 1, 86400, '\\app\\widgets\\navigation\\models\\Navigation', 0),
(4, 'Перед контентом', 'before-content', 1, 1, 1, 0, NULL, 0),
(5, 'Левый сайдбар', 'left-sidebar', 1, 1, 0, 0, NULL, 0),
(6, 'Before inner-content', 'before-inner-content', 1, 1, 0, 0, NULL, 0),
(7, 'After inner-content', 'after-inner-content', 1, 1, 0, 0, NULL, 0),
(8, 'Правый сайдбар', 'right-sidebar', 1, 1, 0, 0, NULL, 0),
(9, 'Pre-footer', 'pre-footer', 1, 1, 1, 86400, NULL, 0),
(10, 'Футер', 'footer', 1, 1, 1, 86400, NULL, 0),
(11, 'Post-footer', 'post-footer', 1, 1, 1, 86400, NULL, 0),
(12, 'Категории выпадающий список', 'category-menu', 1, 1, 0, 0, '', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `theme_variation`
--

CREATE TABLE IF NOT EXISTS `theme_variation` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `by_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `by_route` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `matcher_class_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `exclusive` tinyint(1) NOT NULL DEFAULT '0',
  `omit_get_params` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `theme_variation`
--

INSERT INTO `theme_variation` (`id`, `name`, `by_url`, `by_route`, `matcher_class_name`, `exclusive`, `omit_get_params`) VALUES
(1, 'Главная страница', '/', NULL, NULL, 0, 0),
(2, 'Не главная страница', '/*', NULL, NULL, 0, 0),
(3, 'Список товаров', NULL, 'shop/product/list', NULL, 0, 0),
(4, 'Страница продукта (показать)', NULL, 'shop/product/show', NULL, 0, 0),
(5, 'Листинг контентных страниц', NULL, 'page/page/list', NULL, 0, 0),
(6, 'Контентная страница(показать)', NULL, 'page/page/show', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `theme_widgets`
--

CREATE TABLE IF NOT EXISTS `theme_widgets` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `widget` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `preview_image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `configuration_model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `configuration_view` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `configuration_json` text COLLATE utf8_unicode_ci,
  `is_cacheable` tinyint(1) NOT NULL DEFAULT '1',
  `cache_lifetime` int(11) NOT NULL DEFAULT '0',
  `cache_tags` text COLLATE utf8_unicode_ci,
  `cache_vary_by_session` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `theme_widgets`
--

INSERT INTO `theme_widgets` (`id`, `name`, `widget`, `preview_image`, `configuration_model`, `configuration_view`, `configuration_json`, `is_cacheable`, `cache_lifetime`, `cache_tags`, `cache_vary_by_session`) VALUES
(1, '1-row header with logo, nav and popup cart', 'app\\extensions\\DefaultTheme\\widgets\\OneRowHeaderWithCart\\Widget', NULL, 'app\\extensions\\DefaultTheme\\widgets\\OneRowHeaderWithCart\\ConfigurationModel', '@app/extensions/DefaultTheme/widgets/OneRowHeaderWithCart/views/_config.php', '{}', 1, 86400, NULL, 1),
(2, '1-row header with logo, nav', 'app\\extensions\\DefaultTheme\\widgets\\OneRowHeader\\Widget', NULL, 'app\\extensions\\DefaultTheme\\widgets\\OneRowHeader\\ConfigurationModel', '@app/extensions/DefaultTheme/widgets/OneRowHeader/views/_config.php', '{}', 1, 86400, NULL, 0),
(3, 'Слайдер', 'app\\extensions\\DefaultTheme\\widgets\\Slider\\Widget', NULL, 'app\\extensions\\DefaultTheme\\widgets\\Slider\\ConfigurationModel', '@app/extensions/DefaultTheme/widgets/Slider/views/_config.php', '{}', 1, 86400, NULL, 0),
(4, 'Список категорий', 'app\\extensions\\DefaultTheme\\widgets\\CategoriesList\\Widget', NULL, 'app\\extensions\\DefaultTheme\\widgets\\CategoriesList\\ConfigurationModel', '@app/extensions/DefaultTheme/widgets/CategoriesList/views/_config.php', '{}', 0, 0, 'app\\modules\\shop\\models\\Category', 0),
(5, 'Виджет фильтров', 'app\\extensions\\DefaultTheme\\widgets\\FilterSets\\Widget', NULL, 'app\\extensions\\DefaultTheme\\widgets\\FilterSets\\ConfigurationModel', '@app/extensions/DefaultTheme/widgets/FilterSets/views/_config.php', '{}', 0, 0, '', 0),
(6, 'Список страниц', 'app\\extensions\\DefaultTheme\\widgets\\PagesList\\Widget', NULL, 'app\\extensions\\DefaultTheme\\widgets\\PagesList\\ConfigurationModel', '@app/extensions/DefaultTheme/widgets/PagesList/views/_config.php', '{}', 1, 86400, 'app\\modules\\page\\models\\Page', 0),
(7, 'Блок контента', 'app\\extensions\\DefaultTheme\\widgets\\ContentBlock\\Widget', NULL, 'app\\extensions\\DefaultTheme\\widgets\\ContentBlock\\ConfigurationModel', '@app/extensions/DefaultTheme/widgets/ContentBlock/views/_config.php', '{}', 1, 86400, 'app\\modules\\page\\models\\Page', 0),
(8, 'Футер', 'app\\extensions\\DefaultTheme\\widgets\\Footer\\Widget', NULL, 'app\\extensions\\DefaultTheme\\widgets\\Footer\\ConfigurationModel', '@app/extensions/DefaultTheme/widgets/Footer/views/_config.php', '{}', 1, 0, '', 0),
(9, 'Навигация', 'app\\extensions\\DefaultTheme\\widgets\\Navigation\\Widget', NULL, 'app\\extensions\\DefaultTheme\\widgets\\Navigation\\ConfigurationModel', '@app/extensions/DefaultTheme/widgets/Navigation/views/_config.php', '{}', 1, 0, '', 0),
(10, 'Last Viewed Products', 'app\\extensions\\DefaultTheme\\widgets\\LastViewedProducts\\Widget', NULL, 'app\\extensions\\DefaultTheme\\widgets\\LastViewedProducts\\ConfigurationModel', '@app/extensions/DefaultTheme/widgets/LastViewedProducts/views/_config.php', '{}', 0, 0, '', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `theme_widget_applying`
--

CREATE TABLE IF NOT EXISTS `theme_widget_applying` (
  `id` int(11) NOT NULL,
  `widget_id` int(11) DEFAULT NULL,
  `part_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `theme_widget_applying`
--

INSERT INTO `theme_widget_applying` (`id`, `widget_id`, `part_id`) VALUES
(20, NULL, NULL),
(21, NULL, NULL),
(1, 1, 2),
(2, 2, 2),
(3, 3, 4),
(4, 3, 6),
(5, 4, 5),
(6, 4, 8),
(22, 4, 12),
(7, 5, 5),
(8, 5, 8),
(9, 6, 5),
(10, 6, 8),
(11, 7, 5),
(12, 7, 8),
(13, 8, 9),
(14, 8, 10),
(15, 8, 11),
(16, 9, 5),
(17, 9, 8),
(18, 10, 7),
(19, 10, 9);

-- --------------------------------------------------------

--
-- Структура таблицы `thumbnail`
--

CREATE TABLE IF NOT EXISTS `thumbnail` (
  `id` int(10) unsigned NOT NULL,
  `img_id` int(10) unsigned NOT NULL,
  `thumb_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `size_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `thumbnail`
--

INSERT INTO `thumbnail` (`id`, `img_id`, `thumb_path`, `size_id`) VALUES
(1, 1, 'thumbnail/11860c479a9df55cca1e2db59dfd6ff4-superman-symbol-superman-logo-80x80.jpg', 1),
(2, 2, 'thumbnail/e84d93de5ec534a4b6b0257e154cf85a-spider-man-logo-clipart-spider-man-logo-clipart-900-900-80x80.png', 1),
(3, 3, 'thumbnail/e316d0a7f474c8eb0e3766ae11319af1-80x80.jpeg', 1),
(4, 4, 'thumbnail/28be2c4a1e7094a49087bbce160719af-80x80.jpeg', 1),
(5, 5, 'thumbnail/6be68bfae46adc09ea3aa3809e2508d2-80x80.jpeg', 1),
(6, 7, 'thumbnail/28be2c4a1e7094a49087bbce160719af-80x80.jpeg', 1),
(7, 6, 'thumbnail/e316d0a7f474c8eb0e3766ae11319af1-80x80.jpeg', 1),
(8, 8, 'thumbnail/6be68bfae46adc09ea3aa3809e2508d2-80x80.jpeg', 1),
(9, 10, 'thumbnail/28be2c4a1e7094a49087bbce160719af-80x80.jpeg', 1),
(10, 9, 'thumbnail/e316d0a7f474c8eb0e3766ae11319af1-80x80.jpeg', 1),
(11, 11, 'thumbnail/6be68bfae46adc09ea3aa3809e2508d2-80x80.jpeg', 1),
(12, 4, 'thumbnail/28be2c4a1e7094a49087bbce160719af-140x140.jpeg', 2),
(13, 12, 'thumbnail/bez-imeni-80x80.jpg', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `thumbnail_size`
--

CREATE TABLE IF NOT EXISTS `thumbnail_size` (
  `id` int(10) unsigned NOT NULL,
  `width` int(10) unsigned NOT NULL,
  `height` int(10) unsigned NOT NULL,
  `default_watermark_id` int(10) unsigned DEFAULT NULL,
  `resize_mode` enum('inset','outbound','resize') COLLATE utf8_unicode_ci DEFAULT 'inset',
  `quality` tinyint(1) unsigned DEFAULT '90'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `thumbnail_size`
--

INSERT INTO `thumbnail_size` (`id`, `width`, `height`, `default_watermark_id`, `resize_mode`, `quality`) VALUES
(1, 80, 80, NULL, 'inset', 90),
(2, 140, 140, NULL, 'inset', 90);

-- --------------------------------------------------------

--
-- Структура таблицы `thumbnail_watermark`
--

CREATE TABLE IF NOT EXISTS `thumbnail_watermark` (
  `id` int(10) unsigned NOT NULL,
  `thumb_id` int(10) unsigned NOT NULL,
  `water_id` int(10) unsigned NOT NULL,
  `compiled_src` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(10) unsigned NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varbinary(32) NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` binary(43) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(3) unsigned DEFAULT '10',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username_is_temporary` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `user`
--

INSERT INTO `user` (`id`, `username`, `auth_key`, `password_hash`, `password_reset_token`, `email`, `status`, `create_time`, `update_time`, `first_name`, `last_name`, `username_is_temporary`) VALUES
(1, 'admin', '', '$2y$13$4yt0VeOGGZWpUlfRYr9LpeZ1ZTnUY4DD1N/1cK3GfIYpQe/LXG9HO', NULL, 'tsyuha77@gmail.com', 10, 1511873499, 1511873499, NULL, NULL, 0),
(2, 'test', 0x455a427379413379416e6b78693772684672345f6e5264697668735a6570454d, '$2y$13$X0oghE/bFt3O1zvmjly83e6dSaHb3Q3HnZ8FDTmb2AeOK/QFNHbA.', NULL, 'admin@isyms.ru', 10, 1514385722, 1514385722, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `user_category`
--

CREATE TABLE IF NOT EXISTS `user_category` (
  `id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `user_discount`
--

CREATE TABLE IF NOT EXISTS `user_discount` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `discount_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `user_eav`
--

CREATE TABLE IF NOT EXISTS `user_eav` (
  `id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL,
  `property_group_id` int(10) unsigned NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `user_property`
--

CREATE TABLE IF NOT EXISTS `user_property` (
  `object_model_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `user_service`
--

CREATE TABLE IF NOT EXISTS `user_service` (
  `id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `service_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `service_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `view`
--

CREATE TABLE IF NOT EXISTS `view` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `view` text COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `internal_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `view`
--

INSERT INTO `view` (`id`, `name`, `view`, `category`, `internal_name`) VALUES
(1, 'Default', 'default', 'app', 'default');

-- --------------------------------------------------------

--
-- Структура таблицы `view_object`
--

CREATE TABLE IF NOT EXISTS `view_object` (
  `id` int(10) unsigned NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `object_model_id` int(10) unsigned NOT NULL,
  `view_id` int(10) unsigned NOT NULL,
  `child_view_id` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `view_object`
--

INSERT INTO `view_object` (`id`, `object_id`, `object_model_id`, `view_id`, `child_view_id`) VALUES
(2, 3, 1, 1, 1),
(3, 2, 3, 1, 1),
(5, 2, 4, 1, 1),
(6, 3, 4, 1, 1),
(7, 2, 2, 1, 1),
(8, 3, 5, 1, 1),
(9, 2, 5, 1, 1),
(10, 3, 6, 1, 1),
(12, 2, 7, 1, 1),
(13, 1, 2, 1, 1),
(14, 1, 3, 1, 1),
(15, 1, 4, 1, 1),
(16, 1, 5, 1, 1),
(17, 1, 6, 1, 1),
(18, 1, 7, 1, 1),
(19, 1, 8, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `warehouse`
--

CREATE TABLE IF NOT EXISTS `warehouse` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `country_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `address` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `map_latitude` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `map_longitude` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `shipping_center` tinyint(1) NOT NULL DEFAULT '1',
  `issuing_center` tinyint(1) NOT NULL DEFAULT '1',
  `xml_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `warehouse`
--

INSERT INTO `warehouse` (`id`, `name`, `is_active`, `country_id`, `city_id`, `address`, `description`, `sort_order`, `map_latitude`, `map_longitude`, `shipping_center`, `issuing_center`, `xml_id`) VALUES
(1, 'Main warehouse', 1, 1, 1, 'Kremlin', NULL, 0, '', '', 1, 1, ''),
(2, 'Second warehouse', 1, 2, 3, 'The WallStreet hidden warehouse', NULL, 0, '', '', 1, 1, '');

-- --------------------------------------------------------

--
-- Структура таблицы `warehouse_email`
--

CREATE TABLE IF NOT EXISTS `warehouse_email` (
  `id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `warehouse_email`
--

INSERT INTO `warehouse_email` (`id`, `warehouse_id`, `sort_order`, `email`, `name`) VALUES
(1, 1, 0, 'moscow@example.com', 'Sales'),
(2, 2, 0, 'nyc@example.com', 'Sales');

-- --------------------------------------------------------

--
-- Структура таблицы `warehouse_openinghours`
--

CREATE TABLE IF NOT EXISTS `warehouse_openinghours` (
  `id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `monday` tinyint(1) NOT NULL DEFAULT '0',
  `tuesday` tinyint(1) NOT NULL DEFAULT '0',
  `wednesday` tinyint(1) NOT NULL DEFAULT '0',
  `thursday` tinyint(1) NOT NULL DEFAULT '0',
  `friday` tinyint(1) NOT NULL DEFAULT '0',
  `saturday` tinyint(1) NOT NULL DEFAULT '0',
  `sunday` tinyint(1) NOT NULL DEFAULT '0',
  `all_day` tinyint(1) NOT NULL DEFAULT '0',
  `opens` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `closes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `break_from` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `break_to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `warehouse_openinghours`
--

INSERT INTO `warehouse_openinghours` (`id`, `warehouse_id`, `sort_order`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday`, `saturday`, `sunday`, `all_day`, `opens`, `closes`, `break_from`, `break_to`) VALUES
(1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, '', '', '12:00', '13:00'),
(2, 2, 0, 1, 1, 1, 1, 0, 0, 1, 0, '9:00', '22:00', '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `warehouse_phone`
--

CREATE TABLE IF NOT EXISTS `warehouse_phone` (
  `id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `phone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `warehouse_phone`
--

INSERT INTO `warehouse_phone` (`id`, `warehouse_id`, `sort_order`, `phone`, `name`) VALUES
(1, 1, 0, '+7 (495) 123-45-67', 'Sales'),
(2, 2, 0, '+1 800 1-WAREHOUSE-1', 'Sales');

-- --------------------------------------------------------

--
-- Структура таблицы `warehouse_product`
--

CREATE TABLE IF NOT EXISTS `warehouse_product` (
  `id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `in_warehouse` float NOT NULL DEFAULT '0',
  `reserved_count` float NOT NULL DEFAULT '0',
  `sku` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `warehouse_product`
--

INSERT INTO `warehouse_product` (`id`, `warehouse_id`, `product_id`, `in_warehouse`, `reserved_count`, `sku`) VALUES
(1, 1, 1, 0, 0, ''),
(2, 2, 1, 0, 0, ''),
(3, 1, 2, 0, 0, ''),
(4, 2, 2, 0, 0, ''),
(5, 1, 3, 0, 0, ''),
(6, 2, 3, 0, 0, ''),
(7, 1, 4, 0, 0, ''),
(8, 2, 4, 0, 0, ''),
(9, 1, 5, 0, 0, ''),
(10, 2, 5, 0, 0, ''),
(11, 1, 6, 0, 0, ''),
(12, 2, 6, 0, 0, '');

-- --------------------------------------------------------

--
-- Структура таблицы `watermark`
--

CREATE TABLE IF NOT EXISTS `watermark` (
  `id` int(10) unsigned NOT NULL,
  `watermark_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `position` enum('TOP LEFT','TOP RIGHT','BOTTOM LEFT','BOTTOM RIGHT','CENTER') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'TOP LEFT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `wishlist`
--

CREATE TABLE IF NOT EXISTS `wishlist` (
  `id` int(11) NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wishlist_product`
--

CREATE TABLE IF NOT EXISTS `wishlist_product` (
  `id` int(11) NOT NULL,
  `wishlist_id` int(11) NOT NULL,
  `product_id` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `wysiwyg`
--

CREATE TABLE IF NOT EXISTS `wysiwyg` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `class_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `params` text COLLATE utf8_unicode_ci,
  `configuration_model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `configuration_view` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `wysiwyg`
--

INSERT INTO `wysiwyg` (`id`, `name`, `class_name`, `params`, `configuration_model`, `configuration_view`) VALUES
(1, 'Imperavi', 'vova07\\imperavi\\Widget', '{"settings":{"replaceDivs":false,"minHeight":200,"paragraphize":false,"pastePlainText":true,"buttonSource":true,"imageManagerJson":"/backend/dashboard/imperavi-images-get","plugins":["table","fontsize","fontfamily","fontcolor","video","imagemanager"],"replaceStyles":[],"replaceTags":[],"deniedTags":[],"removeEmpty":[],"imageUpload":"/backend/dashboard/imperavi-image-upload"}}', 'app\\modules\\core\\models\\WysiwygConfiguration\\Imperavi', '@app/modules/core/wysiwyg/imperavi-config.php'),
(2, 'Ace', 'devgroup\\ace\\Ace', '{"mode":"html","theme":"chrome","jsOptions":{"wrap":true},"htmlOptions":{"width":"100%","height":"200px"}}', NULL, NULL),
(3, 'Textarea', 'app\\widgets\\TextareaWidget', '{"htmlOptions":{"class":"form-control","style":"height: 200px;"}}', NULL, NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `addon`
--
ALTER TABLE `addon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `by_category` (`addon_category_id`),
  ADD FULLTEXT KEY `name` (`name`);

--
-- Индексы таблицы `addon_bindings`
--
ALTER TABLE `addon_bindings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addons4object` (`appliance_object_id`,`object_model_id`);

--
-- Индексы таблицы `addon_category`
--
ALTER TABLE `addon_category`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `api_service`
--
ALTER TABLE `api_service`
  ADD PRIMARY KEY (`service_id`);

--
-- Индексы таблицы `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD PRIMARY KEY (`item_name`,`user_id`),
  ADD KEY `rule_name` (`rule_name`);

--
-- Индексы таблицы `auth_item`
--
ALTER TABLE `auth_item`
  ADD PRIMARY KEY (`name`),
  ADD KEY `rule_name` (`rule_name`),
  ADD KEY `type` (`type`);

--
-- Индексы таблицы `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD PRIMARY KEY (`parent`,`child`),
  ADD KEY `child` (`child`);

--
-- Индексы таблицы `auth_rule`
--
ALTER TABLE `auth_rule`
  ADD PRIMARY KEY (`name`);

--
-- Индексы таблицы `backend_menu`
--
ALTER TABLE `backend_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-backendmenu-parent_id` (`parent_id`);

--
-- Индексы таблицы `backgroundtasks_notify_message`
--
ALTER TABLE `backgroundtasks_notify_message`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `backgroundtasks_task`
--
ALTER TABLE `backgroundtasks_task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Индексы таблицы `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-category-category_group_id` (`category_group_id`,`parent_id`),
  ADD KEY `ix-category-parent_id` (`parent_id`);

--
-- Индексы таблицы `category_discount`
--
ALTER TABLE `category_discount`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `category_eav`
--
ALTER TABLE `category_eav`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_model_id` (`object_model_id`);

--
-- Индексы таблицы `category_group`
--
ALTER TABLE `category_group`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `category_group_route_templates`
--
ALTER TABLE `category_group_route_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-category-group-route-templates-category_group_id-route_id` (`category_group_id`,`route_id`);

--
-- Индексы таблицы `category_property`
--
ALTER TABLE `category_property`
  ADD PRIMARY KEY (`object_model_id`);

--
-- Индексы таблицы `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_country` (`country_id`);

--
-- Индексы таблицы `commerceml_guid`
--
ALTER TABLE `commerceml_guid`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `configurable`
--
ALTER TABLE `configurable`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `content_block`
--
ALTER TABLE `content_block`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `content_block_group`
--
ALTER TABLE `content_block_group`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `content_decorators`
--
ALTER TABLE `content_decorators`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `contragent`
--
ALTER TABLE `contragent`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `contragent_eav`
--
ALTER TABLE `contragent_eav`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `currency_rate_provider`
--
ALTER TABLE `currency_rate_provider`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `customer_eav`
--
ALTER TABLE `customer_eav`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `data_export`
--
ALTER TABLE `data_export`
  ADD PRIMARY KEY (`user_id`,`object_id`);

--
-- Индексы таблицы `data_import`
--
ALTER TABLE `data_import`
  ADD PRIMARY KEY (`user_id`,`object_id`);

--
-- Индексы таблицы `delivery_information`
--
ALTER TABLE `delivery_information`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `discount`
--
ALTER TABLE `discount`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `discount_code`
--
ALTER TABLE `discount_code`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `discount_type`
--
ALTER TABLE `discount_type`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `dynagrid`
--
ALTER TABLE `dynagrid`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `dynagrid_dtl`
--
ALTER TABLE `dynagrid_dtl`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_dtl` (`name`,`category`,`dynagrid_id`);

--
-- Индексы таблицы `dynamic_content`
--
ALTER TABLE `dynamic_content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_route` (`object_id`,`route`(80));

--
-- Индексы таблицы `error_image`
--
ALTER TABLE `error_image`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `error_log`
--
ALTER TABLE `error_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `error_url`
--
ALTER TABLE `error_url`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `event_class_name` (`event_class_name`(50));

--
-- Индексы таблицы `event_handlers`
--
ALTER TABLE `event_handlers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `by_event_active` (`event_id`,`is_active`);

--
-- Индексы таблицы `extensions`
--
ALTER TABLE `extensions`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `extension_types`
--
ALTER TABLE `extension_types`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `filter_sets`
--
ALTER TABLE `filter_sets`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `form`
--
ALTER TABLE `form`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `form_eav`
--
ALTER TABLE `form_eav`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_model_id` (`object_model_id`);

--
-- Индексы таблицы `form_property`
--
ALTER TABLE `form_property`
  ADD PRIMARY KEY (`object_model_id`);

--
-- Индексы таблицы `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-image-object_id-object_model_id` (`object_id`,`object_model_id`),
  ADD KEY `ix-image-filename` (`filename`);

--
-- Индексы таблицы `layout`
--
ALTER TABLE `layout`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `link_anchor`
--
ALTER TABLE `link_anchor`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `link_anchor_binding`
--
ALTER TABLE `link_anchor_binding`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-link_anchor_id` (`link_anchor_id`);

--
-- Индексы таблицы `measure`
--
ALTER TABLE `measure`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `migration`
--
ALTER TABLE `migration`
  ADD PRIMARY KEY (`version`);

--
-- Индексы таблицы `model_anchor_index`
--
ALTER TABLE `model_anchor_index`
  ADD PRIMARY KEY (`model_name`);

--
-- Индексы таблицы `navigation`
--
ALTER TABLE `navigation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-navigation-parent_id` (`parent_id`);

--
-- Индексы таблицы `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `object`
--
ALTER TABLE `object`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-object-object_class` (`object_class`);

--
-- Индексы таблицы `object_property_group`
--
ALTER TABLE `object_property_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-object_property_group-object_id-object_model_id` (`object_id`,`object_model_id`);

--
-- Индексы таблицы `object_static_values`
--
ALTER TABLE `object_static_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-object-static-values-object_id-object_model_id` (`object_id`,`object_model_id`),
  ADD KEY `ix-object_static_values-property_static_value_id` (`property_static_value_id`);

--
-- Индексы таблицы `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq-order-hash` (`hash`),
  ADD KEY `ix-order-user_id` (`user_id`),
  ADD KEY `ix-order-manager_id` (`manager_id`);

--
-- Индексы таблицы `order_category`
--
ALTER TABLE `order_category`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `order_chat`
--
ALTER TABLE `order_chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-order_chat-order_id` (`order_id`);

--
-- Индексы таблицы `order_code`
--
ALTER TABLE `order_code`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `order_delivery_information`
--
ALTER TABLE `order_delivery_information`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `order_delivery_information_eav`
--
ALTER TABLE `order_delivery_information_eav`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `order_discount`
--
ALTER TABLE `order_discount`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `order_eav`
--
ALTER TABLE `order_eav`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_model_id` (`object_model_id`);

--
-- Индексы таблицы `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-order_item-order_id` (`order_id`);

--
-- Индексы таблицы `order_property`
--
ALTER TABLE `order_property`
  ADD PRIMARY KEY (`object_model_id`);

--
-- Индексы таблицы `order_stage`
--
ALTER TABLE `order_stage`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `order_stage_leaf`
--
ALTER TABLE `order_stage_leaf`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `order_transaction`
--
ALTER TABLE `order_transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-order_transaction-order_id` (`order_id`);

--
-- Индексы таблицы `page`
--
ALTER TABLE `page`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-page-slug_compiled-published` (`slug_compiled`,`published`),
  ADD KEY `ix-page-parent_id` (`parent_id`);

--
-- Индексы таблицы `page_category`
--
ALTER TABLE `page_category`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `page_eav`
--
ALTER TABLE `page_eav`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_model_id` (`object_model_id`);

--
-- Индексы таблицы `page_property`
--
ALTER TABLE `page_property`
  ADD PRIMARY KEY (`object_model_id`);

--
-- Индексы таблицы `payment_type`
--
ALTER TABLE `payment_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-payment_type-active` (`active`);

--
-- Индексы таблицы `prefiltered_pages`
--
ALTER TABLE `prefiltered_pages`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-product-active-slug` (`active`,`slug`),
  ADD KEY `ix-product-parent_id` (`parent_id`),
  ADD KEY `sku` (`sku`),
  ADD KEY `parent_active` (`parent_id`,`active`);

--
-- Индексы таблицы `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cat_omid` (`category_id`,`object_model_id`);

--
-- Индексы таблицы `product_category_full_slug`
--
ALTER TABLE `product_category_full_slug`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Индексы таблицы `product_discount`
--
ALTER TABLE `product_discount`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `product_eav`
--
ALTER TABLE `product_eav`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_model_id` (`object_model_id`);

--
-- Индексы таблицы `product_listing_sort`
--
ALTER TABLE `product_listing_sort`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `product_property`
--
ALTER TABLE `product_property`
  ADD PRIMARY KEY (`object_model_id`);

--
-- Индексы таблицы `product_static_value_full_slug`
--
ALTER TABLE `product_static_value_full_slug`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_static_value_id` (`property_static_value_id`);

--
-- Индексы таблицы `property`
--
ALTER TABLE `property`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-property-property_group_id` (`property_group_id`);

--
-- Индексы таблицы `property_category`
--
ALTER TABLE `property_category`
  ADD PRIMARY KEY (`object_model_id`);

--
-- Индексы таблицы `property_group`
--
ALTER TABLE `property_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-property_group-object_id` (`object_id`);

--
-- Индексы таблицы `property_handler`
--
ALTER TABLE `property_handler`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `property_static_values`
--
ALTER TABLE `property_static_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-property_static_values-property_id` (`property_id`);

--
-- Индексы таблицы `rating_item`
--
ALTER TABLE `rating_item`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `rating_values`
--
ALTER TABLE `rating_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-rating_values-rating_id` (`rating_id`),
  ADD KEY `ix-rating_values-object_id-object_model_id` (`object_id`,`object_model_id`);

--
-- Индексы таблицы `related_product`
--
ALTER TABLE `related_product`
  ADD PRIMARY KEY (`product_id`,`related_product_id`);

--
-- Индексы таблицы `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-review-object_id-object_model_id-status` (`object_id`,`object_model_id`,`status`);

--
-- Индексы таблицы `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `seo_config`
--
ALTER TABLE `seo_config`
  ADD PRIMARY KEY (`key`);

--
-- Индексы таблицы `seo_counter`
--
ALTER TABLE `seo_counter`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `seo_meta`
--
ALTER TABLE `seo_meta`
  ADD PRIMARY KEY (`key`);

--
-- Индексы таблицы `seo_redirect`
--
ALTER TABLE `seo_redirect`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `shipping_discount`
--
ALTER TABLE `shipping_discount`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `shipping_option`
--
ALTER TABLE `shipping_option`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-shipping_option-active` (`active`);

--
-- Индексы таблицы `sitemap`
--
ALTER TABLE `sitemap`
  ADD PRIMARY KEY (`uid`);

--
-- Индексы таблицы `slide`
--
ALTER TABLE `slide`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `slider`
--
ALTER TABLE `slider`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `slider_handler`
--
ALTER TABLE `slider_handler`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `spam_checker`
--
ALTER TABLE `spam_checker`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `special_price_list`
--
ALTER TABLE `special_price_list`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `special_price_object`
--
ALTER TABLE `special_price_object`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `submission`
--
ALTER TABLE `submission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission-form_id` (`form_id`);

--
-- Индексы таблицы `submission_category`
--
ALTER TABLE `submission_category`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `submission_eav`
--
ALTER TABLE `submission_eav`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_model_id` (`object_model_id`);

--
-- Индексы таблицы `submission_property`
--
ALTER TABLE `submission_property`
  ADD PRIMARY KEY (`object_model_id`);

--
-- Индексы таблицы `subscribe_email`
--
ALTER TABLE `subscribe_email`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `theme_active_widgets`
--
ALTER TABLE `theme_active_widgets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variation` (`variation_id`);

--
-- Индексы таблицы `theme_parts`
--
ALTER TABLE `theme_parts`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `theme_variation`
--
ALTER TABLE `theme_variation`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `theme_widgets`
--
ALTER TABLE `theme_widgets`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `theme_widget_applying`
--
ALTER TABLE `theme_widget_applying`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `widget_part` (`widget_id`,`part_id`);

--
-- Индексы таблицы `thumbnail`
--
ALTER TABLE `thumbnail`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `thumbnail_size`
--
ALTER TABLE `thumbnail_size`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `thumbnail_watermark`
--
ALTER TABLE `thumbnail_watermark`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq-user-username` (`username`);

--
-- Индексы таблицы `user_category`
--
ALTER TABLE `user_category`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `user_discount`
--
ALTER TABLE `user_discount`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `user_eav`
--
ALTER TABLE `user_eav`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_model_id` (`object_model_id`);

--
-- Индексы таблицы `user_property`
--
ALTER TABLE `user_property`
  ADD PRIMARY KEY (`object_model_id`);

--
-- Индексы таблицы `user_service`
--
ALTER TABLE `user_service`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq-user-service-service_type-service_id` (`service_type`,`service_id`),
  ADD KEY `ix-user_service-user_id` (`user_id`);

--
-- Индексы таблицы `view`
--
ALTER TABLE `view`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix-view-internal_name-category` (`internal_name`,`category`);

--
-- Индексы таблицы `view_object`
--
ALTER TABLE `view_object`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq-view_object-object_id-object_model_id` (`object_id`,`object_model_id`);

--
-- Индексы таблицы `warehouse`
--
ALTER TABLE `warehouse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wh_country` (`country_id`),
  ADD KEY `wh_city` (`city_id`);

--
-- Индексы таблицы `warehouse_email`
--
ALTER TABLE `warehouse_email`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wh_email` (`warehouse_id`);

--
-- Индексы таблицы `warehouse_openinghours`
--
ALTER TABLE `warehouse_openinghours`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wh_hours` (`warehouse_id`);

--
-- Индексы таблицы `warehouse_phone`
--
ALTER TABLE `warehouse_phone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wh_phone` (`warehouse_id`);

--
-- Индексы таблицы `warehouse_product`
--
ALTER TABLE `warehouse_product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wh_pr` (`warehouse_id`,`product_id`);

--
-- Индексы таблицы `watermark`
--
ALTER TABLE `watermark`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `wishlist_product`
--
ALTER TABLE `wishlist_product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix-wishlist_id-product_id` (`wishlist_id`,`product_id`),
  ADD KEY `wishlist_product_product_id` (`product_id`);

--
-- Индексы таблицы `wysiwyg`
--
ALTER TABLE `wysiwyg`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `addon`
--
ALTER TABLE `addon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `addon_bindings`
--
ALTER TABLE `addon_bindings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `addon_category`
--
ALTER TABLE `addon_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `backend_menu`
--
ALTER TABLE `backend_menu`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=53;
--
-- AUTO_INCREMENT для таблицы `backgroundtasks_notify_message`
--
ALTER TABLE `backgroundtasks_notify_message`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `backgroundtasks_task`
--
ALTER TABLE `backgroundtasks_task`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT для таблицы `category`
--
ALTER TABLE `category`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблицы `category_discount`
--
ALTER TABLE `category_discount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `category_eav`
--
ALTER TABLE `category_eav`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `category_group`
--
ALTER TABLE `category_group`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблицы `category_group_route_templates`
--
ALTER TABLE `category_group_route_templates`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `city`
--
ALTER TABLE `city`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `commerceml_guid`
--
ALTER TABLE `commerceml_guid`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `configurable`
--
ALTER TABLE `configurable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT для таблицы `content_block`
--
ALTER TABLE `content_block`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `content_block_group`
--
ALTER TABLE `content_block_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `content_decorators`
--
ALTER TABLE `content_decorators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `contragent`
--
ALTER TABLE `contragent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `contragent_eav`
--
ALTER TABLE `contragent_eav`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `country`
--
ALTER TABLE `country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `currency`
--
ALTER TABLE `currency`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `currency_rate_provider`
--
ALTER TABLE `currency_rate_provider`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `customer_eav`
--
ALTER TABLE `customer_eav`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `delivery_information`
--
ALTER TABLE `delivery_information`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `discount`
--
ALTER TABLE `discount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `discount_code`
--
ALTER TABLE `discount_code`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `discount_type`
--
ALTER TABLE `discount_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблицы `dynamic_content`
--
ALTER TABLE `dynamic_content`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `error_image`
--
ALTER TABLE `error_image`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `error_log`
--
ALTER TABLE `error_log`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `error_url`
--
ALTER TABLE `error_url`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT для таблицы `event_handlers`
--
ALTER TABLE `event_handlers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT для таблицы `extensions`
--
ALTER TABLE `extensions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `extension_types`
--
ALTER TABLE `extension_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблицы `filter_sets`
--
ALTER TABLE `filter_sets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `form`
--
ALTER TABLE `form`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `form_eav`
--
ALTER TABLE `form_eav`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `image`
--
ALTER TABLE `image`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT для таблицы `layout`
--
ALTER TABLE `layout`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `link_anchor`
--
ALTER TABLE `link_anchor`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `link_anchor_binding`
--
ALTER TABLE `link_anchor_binding`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `measure`
--
ALTER TABLE `measure`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `navigation`
--
ALTER TABLE `navigation`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT для таблицы `notification`
--
ALTER TABLE `notification`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `object`
--
ALTER TABLE `object`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT для таблицы `object_property_group`
--
ALTER TABLE `object_property_group`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT для таблицы `object_static_values`
--
ALTER TABLE `object_static_values`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблицы `order`
--
ALTER TABLE `order`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT для таблицы `order_category`
--
ALTER TABLE `order_category`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `order_chat`
--
ALTER TABLE `order_chat`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `order_code`
--
ALTER TABLE `order_code`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `order_delivery_information`
--
ALTER TABLE `order_delivery_information`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `order_delivery_information_eav`
--
ALTER TABLE `order_delivery_information_eav`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `order_discount`
--
ALTER TABLE `order_discount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `order_eav`
--
ALTER TABLE `order_eav`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `order_item`
--
ALTER TABLE `order_item`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=199;
--
-- AUTO_INCREMENT для таблицы `order_stage`
--
ALTER TABLE `order_stage`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблицы `order_stage_leaf`
--
ALTER TABLE `order_stage_leaf`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблицы `order_transaction`
--
ALTER TABLE `order_transaction`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `page`
--
ALTER TABLE `page`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT для таблицы `page_category`
--
ALTER TABLE `page_category`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `page_eav`
--
ALTER TABLE `page_eav`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `payment_type`
--
ALTER TABLE `payment_type`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT для таблицы `prefiltered_pages`
--
ALTER TABLE `prefiltered_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `product`
--
ALTER TABLE `product`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблицы `product_category`
--
ALTER TABLE `product_category`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT для таблицы `product_category_full_slug`
--
ALTER TABLE `product_category_full_slug`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `product_discount`
--
ALTER TABLE `product_discount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `product_eav`
--
ALTER TABLE `product_eav`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `product_listing_sort`
--
ALTER TABLE `product_listing_sort`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблицы `product_static_value_full_slug`
--
ALTER TABLE `product_static_value_full_slug`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `property`
--
ALTER TABLE `property`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT для таблицы `property_group`
--
ALTER TABLE `property_group`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблицы `property_handler`
--
ALTER TABLE `property_handler`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT для таблицы `property_static_values`
--
ALTER TABLE `property_static_values`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `rating_item`
--
ALTER TABLE `rating_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `rating_values`
--
ALTER TABLE `rating_values`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `review`
--
ALTER TABLE `review`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `route`
--
ALTER TABLE `route`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `seo_counter`
--
ALTER TABLE `seo_counter`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `seo_redirect`
--
ALTER TABLE `seo_redirect`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shipping_discount`
--
ALTER TABLE `shipping_discount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `shipping_option`
--
ALTER TABLE `shipping_option`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `slide`
--
ALTER TABLE `slide`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `slider`
--
ALTER TABLE `slider`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `slider_handler`
--
ALTER TABLE `slider_handler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `spam_checker`
--
ALTER TABLE `spam_checker`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `special_price_list`
--
ALTER TABLE `special_price_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблицы `special_price_object`
--
ALTER TABLE `special_price_object`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `submission`
--
ALTER TABLE `submission`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `submission_category`
--
ALTER TABLE `submission_category`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `submission_eav`
--
ALTER TABLE `submission_eav`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `subscribe_email`
--
ALTER TABLE `subscribe_email`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `theme_active_widgets`
--
ALTER TABLE `theme_active_widgets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT для таблицы `theme_parts`
--
ALTER TABLE `theme_parts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT для таблицы `theme_variation`
--
ALTER TABLE `theme_variation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблицы `theme_widgets`
--
ALTER TABLE `theme_widgets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT для таблицы `theme_widget_applying`
--
ALTER TABLE `theme_widget_applying`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT для таблицы `thumbnail`
--
ALTER TABLE `thumbnail`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT для таблицы `thumbnail_size`
--
ALTER TABLE `thumbnail_size`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `thumbnail_watermark`
--
ALTER TABLE `thumbnail_watermark`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `user_category`
--
ALTER TABLE `user_category`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `user_discount`
--
ALTER TABLE `user_discount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `user_eav`
--
ALTER TABLE `user_eav`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `user_service`
--
ALTER TABLE `user_service`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `view`
--
ALTER TABLE `view`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `view_object`
--
ALTER TABLE `view_object`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT для таблицы `warehouse`
--
ALTER TABLE `warehouse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `warehouse_email`
--
ALTER TABLE `warehouse_email`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `warehouse_openinghours`
--
ALTER TABLE `warehouse_openinghours`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `warehouse_phone`
--
ALTER TABLE `warehouse_phone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `warehouse_product`
--
ALTER TABLE `warehouse_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT для таблицы `watermark`
--
ALTER TABLE `watermark`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `wishlist_product`
--
ALTER TABLE `wishlist_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `wysiwyg`
--
ALTER TABLE `wysiwyg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `auth_assignment_ibfk_2` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `auth_item`
--
ALTER TABLE `auth_item`
  ADD CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `wishlist_product`
--
ALTER TABLE `wishlist_product`
  ADD CONSTRAINT `wishlist_product_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wishlist_product_wishlist_id` FOREIGN KEY (`wishlist_id`) REFERENCES `wishlist` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
