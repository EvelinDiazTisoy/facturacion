-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-04-2019 a las 23:47:20
-- Versión del servidor: 10.1.30-MariaDB
-- Versión de PHP: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbsistemalaravel2`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_resets_table', 1),
(2, '2018_02_01_171225_create_categorias_table', 1),
(4, '2018_02_27_143638_create_personas_table', 1),
(5, '2018_03_06_024616_create_proveedores_table', 1),
(6, '2018_03_13_133425_create_roles_table', 1),
(7, '2018_03_14_000000_create_users_table', 1),
(8, '2018_04_08_140106_create_ingresos_table', 1),
(9, '2018_04_08_140532_create_detalle_ingresos_table', 1),
(10, '2018_04_22_212328_create_ventas_table', 1),
(11, '2018_04_22_212558_create_detalle_ventas_table', 1),
(12, '2018_05_28_214019_create_plan_cuentas', 2),
(13, '2018_06_07_080701_create_conf_formatos_table', 3),
(14, '2018_05_26_001854_create_notifications_table', 4),
(15, '2018_08_07_050645_create_teachers_table', 5),
(16, '2019_02_12_163951_create_presentacion_table', 5),
(17, '2019_02_12_204208_create_und_medida_table', 6),
(18, '2019_02_12_213902_create_concentraciones_table', 7),
(22, '2018_02_22_235257_create_articulos_table', 9),
(23, '2019_02_20_142907_create_stock_table', 10),
(24, '2019_03_19_201039_create_facturacion_table', 11),
(25, '2019_03_20_141427_create_detalle_facturacion_table', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` int(10) UNSIGNED NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_id`, `notifiable_type`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('40b21c90-a1fd-4564-b582-3fe0fa1386bc', 'App\\Notifications\\NotifyAdmin', 1, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":1,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":0,\"msj\":\"Ingresos\"}}}', NULL, '2018-07-17 04:51:13', '2018-07-17 04:51:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_documento` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_documento` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(70) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `regimen` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `representante` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sexo` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fec_nac` date DEFAULT NULL,
  `reside` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_persona` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre1` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre2` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apellido1` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apellido2` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `digito_verif` int(11) NOT NULL DEFAULT '0',
  `entidad` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_verif` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`id`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `created_at`, `updated_at`, `regimen`, `representante`, `sexo`, `fec_nac`, `reside`, `tipo_persona`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `digito_verif`, `entidad`, `num_verif`) VALUES
(1, '\'\'', 'CC', '1123201184', 'ccc', '3214', 'ccmonpan@hotmail.com', '2018-08-01 05:00:00', '2018-08-01 05:00:00', '', '', '', '0000-00-00', '', 'Natural', 'Cristhiam', 'Camilo', 'Monsalve', '', 0, '', ''),
(2, 'Jessica Murcia', 'NIT', '33333', 'lllllll', '34444', 'cccc@jjjj.com', '2018-07-08 02:02:10', '2018-07-11 10:37:16', '', '', '', '0000-00-00', '', '', 'Jessica', '', 'Murcia', '', 0, '', ''),
(3, 'Domenick', 'CE', '1123', 'kkkkk', '9999', 'cjcjc@ssss.com', '2018-07-08 12:20:52', '2018-07-11 10:37:10', '', '', '', '0000-00-00', '', '', '', '', '', '', 0, '', ''),
(4, 'Provedor1', 'CC', '90088777', '87788', '32222', 'cccccc@jjj.com', '2018-07-09 23:07:14', '2018-07-11 10:36:52', '', '', '', '0000-00-00', '', '', '', '', '', '', 0, '', ''),
(5, 'Rifas x', 'NIT', '908888', 'sdfosdfoi', '454545', 'lsdfskdjf@dsfdsf.xom', '2018-07-11 11:22:21', '2018-09-21 12:44:12', 'Comun', 'lsdfskdjf@dsfdsf.xom', 'Otro', '2018-07-01', 'asdfasdf ad fasd fasdf asf4', 'Juridica', NULL, NULL, NULL, NULL, 0, NULL, ''),
(6, '\'\'', 'CC', '45998888', 'jflasdjf aljsd flajsdf l', '3495959', 'htm@hot.com', '2018-08-04 07:49:37', '2018-08-04 07:49:37', 'Comun', NULL, 'Femenino', NULL, 'asdfasdfadsf', 'Natural', 'Marlon', '', 'Monsalve', '', 0, '', ''),
(7, NULL, 'CC', '3839', 'jkjk', '777', 'lues@gg.com', '2018-08-04 08:04:37', '2018-08-04 08:04:37', 'Comun', NULL, 'Masculino', NULL, 'dfsdfsdf', 'Natural', 'Luis', '', 'Monsalve', '', 0, '', ''),
(8, 'Ismael', 'CC', '1085288369', 'barrio el jardin', '3203313824', 'fanfano312@hotmail.com', '2018-08-11 07:38:58', '2018-08-22 02:50:23', 'Simplificado', 'fanfano312@hotmail.com', 'Masculino', '1991-04-27', 'mocoa', 'Natural', 'ismael', NULL, 'cardenas', NULL, 0, '', ''),
(9, 'Fabian', 'CC', '123', '123', '123', 'sss', '2018-08-22 20:04:53', '2018-08-22 20:04:53', 'Simplificado', NULL, 'Femenino', '2001-04-18', 'xxxx', 'Natural', 'Oscar', 'Fabian', 'Franco', 'Pantoja', 0, '', ''),
(10, NULL, 'CC', '121212', NULL, NULL, NULL, '2018-08-31 01:51:06', '2018-08-31 01:51:06', 'Simplificado', NULL, 'Masculino', NULL, 'wwwww', 'Natural', 'Pepito', '', 'perez', '', 0, '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `descripcion`, `condicion`) VALUES
(1, 'Administrador', 'Administradores de área', 1),
(2, 'Vendedor', 'Vendedor área venta', 1),
(3, 'Almacenero', 'Almacenero área compras', 1),
(4, 'Contador', 'Contador', 1),
(5, 'Aux Contable', 'Auxiliar de Contabilidad', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `usuario` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `idrol` int(10) UNSIGNED NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `password`, `condicion`, `idrol`, `remember_token`) VALUES
(1, 'cristhiam', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'NuJfvvrzGOhDaRRpJvSn6OBpQgFyqgyKlZa3H9KKSKHWuaQWJddPlNlz6Fiu'),
(9, 'fabian', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'wo8sErJvqxHw6lqjANBc726TFZ77DUE4FjoCr8shrQh3weAFc5OU99HVPQJH');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_id_notifiable_type_index` (`notifiable_id`,`notifiable_type`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_nombre_unique` (`nombre`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`),
  ADD KEY `users_id_foreign` (`id`),
  ADD KEY `users_idrol_foreign` (`idrol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_id_foreign` FOREIGN KEY (`id`) REFERENCES `personas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_idrol_foreign` FOREIGN KEY (`idrol`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
