-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-05-2019 a las 19:31:20
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 7.3.4

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
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id`, `nombre`) VALUES
(1, 'Empresa 1'),
(2, 'Empresa 2');

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
(4, '2018_02_27_143638_create_personas_table', 1),
(6, '2018_03_13_133425_create_roles_table', 1),
(7, '2018_03_14_000000_create_users_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

CREATE TABLE `modulos` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `usu_crea` int(10) UNSIGNED NOT NULL,
  `componente` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `menu` int(11) DEFAULT NULL,
  `tipo` int(11) NOT NULL,
  `icono` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `template` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `padre` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `modulos`
--

INSERT INTO `modulos` (`id`, `nombre`, `descripcion`, `estado`, `usu_crea`, `componente`, `menu`, `tipo`, `icono`, `template`, `padre`, `created_at`, `updated_at`) VALUES
(1, 'Acceso', NULL, 1, 1, 'Acceso.vue', 1, 1, 'icon-people', 'n/a', NULL, NULL, NULL),
(2, 'Usuarios', NULL, 1, 1, 'User.vue', 2, 2, 'icon-user', 'user', 1, NULL, NULL),
(3, 'Roles', NULL, 1, 1, 'Rol.vue', 3, 2, 'icon-user-following', 'rol', 1, NULL, NULL),
(4, 'Modulos', NULL, 1, 1, 'Modulo.vue', 4, 2, 'icon-user-following', 'modulo', 1, NULL, NULL),
(7, 'Terceros', NULL, 1, 1, 'Terceros.vue', 5, 1, 'icon-pencil', 'terceros', NULL, '2019-05-02 22:07:57', '2019-05-02 22:07:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos_empresas`
--

CREATE TABLE `modulos_empresas` (
  `id` int(10) UNSIGNED NOT NULL,
  `modulos_id` int(10) UNSIGNED DEFAULT NULL,
  `empresas_id` int(10) UNSIGNED DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `usu_crea` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `modulos_empresas`
--

INSERT INTO `modulos_empresas` (`id`, `modulos_id`, `empresas_id`, `estado`, `usu_crea`, `created_at`) VALUES
(1, 1, 1, 1, 1, NULL),
(2, 2, 1, 1, 1, NULL),
(3, 3, 1, 1, 1, NULL),
(4, 4, 1, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos_empresas_usuarios`
--

CREATE TABLE `modulos_empresas_usuarios` (
  `id` int(10) UNSIGNED NOT NULL,
  `modulos_empresas_id` int(10) UNSIGNED DEFAULT NULL,
  `usuarios_id` int(10) UNSIGNED DEFAULT NULL,
  `crear` tinyint(1) DEFAULT '0',
  `leer` tinyint(1) DEFAULT '0',
  `actualizar` tinyint(1) DEFAULT '0',
  `anular` tinyint(1) DEFAULT '0',
  `imprimir` tinyint(1) DEFAULT '0',
  `usu_crea` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `modulos_empresas_usuarios`
--

INSERT INTO `modulos_empresas_usuarios` (`id`, `modulos_empresas_id`, `usuarios_id`, `crear`, `leer`, `actualizar`, `anular`, `imprimir`, `usu_crea`, `created_at`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1, 1, '2019-05-02 11:28:40'),
(2, 2, 1, 1, 1, 1, 1, 1, 1, '2019-05-02 11:28:40'),
(3, 3, 1, 1, 1, 1, 1, 1, 1, '2019-05-02 11:28:40'),
(4, 4, 1, 1, 1, 1, 1, 1, 1, '2019-05-02 11:28:40');

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
  `nombre` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `usu_crea` int(10) UNSIGNED NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `id_empresa`, `usu_crea`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'Administrador', 1, 0, 1, NULL, NULL),
(2, 'Vendedor', 1, 0, 1, NULL, NULL),
(3, 'Almacenero', 1, 0, 1, NULL, NULL),
(4, 'Contador', 1, 0, 1, NULL, NULL),
(5, 'Aux Contable', 1, 0, 1, NULL, NULL),
(83, 'Rol 1', 1, 1, 1, '2019-04-25 20:39:50', '2019-05-02 18:32:22'),
(84, 'Rol 2', 1, 9, 1, '2019-05-02 18:15:26', '2019-05-02 19:44:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_permisos`
--

CREATE TABLE `roles_permisos` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_rol` int(11) NOT NULL,
  `id_modulo` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `lectura` tinyint(1) NOT NULL DEFAULT '0',
  `escritura` tinyint(1) NOT NULL DEFAULT '0',
  `edicion` tinyint(1) NOT NULL DEFAULT '0',
  `anular` tinyint(1) NOT NULL DEFAULT '0',
  `imprimir` tinyint(1) NOT NULL DEFAULT '0',
  `usu_crea` int(10) UNSIGNED NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `empresas_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `password`, `condicion`, `idrol`, `remember_token`, `empresas_id`) VALUES
(1, 'cristhiam', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'Luavv2EqZt5otwxL9SAEBMb004qKj7djjMat3MTfGNGM6H2DIkHpoy9w2TXg', 1),
(9, 'fabian', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'qJq0vLgVI61dqqs3Ukq4SfMxXDRrLLY59wWU8KIUZFTUlGnmBHGsoIsKdxQl', 1),
(8, 'ismael', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'wo8sErJvqxHw6lqjANBc726TFZ77DUE4FjoCr8shrQh3weAFc5OU99HVPQJH', 1),
(2, 'jessica', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'M7JgIZYa1SfrgoD3GAQy53NSngaceRtHydF3OSnE2I6TB5MlGfJBsDc7f63e', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menu` (`menu`),
  ADD KEY `modulos_usu_crea_foreign` (`usu_crea`),
  ADD KEY `padre` (`padre`);

--
-- Indices de la tabla `modulos_empresas`
--
ALTER TABLE `modulos_empresas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usu_crea` (`usu_crea`),
  ADD KEY `empresas_id` (`empresas_id`),
  ADD KEY `modulos_id` (`modulos_id`);

--
-- Indices de la tabla `modulos_empresas_usuarios`
--
ALTER TABLE `modulos_empresas_usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `modulos_empresas_id` (`modulos_empresas_id`),
  ADD KEY `usuario_id` (`usuarios_id`),
  ADD KEY `usu_crea` (`usu_crea`);

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
  ADD KEY `usu_crea` (`usu_crea`);

--
-- Indices de la tabla `roles_permisos`
--
ALTER TABLE `roles_permisos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_modulo` (`id_modulo`),
  ADD KEY `usu_crea` (`usu_crea`),
  ADD KEY `id_modulo_2` (`id_modulo`),
  ADD KEY `id_rol` (`id_rol`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`),
  ADD KEY `users_id_foreign` (`id`),
  ADD KEY `users_idrol_foreign` (`idrol`),
  ADD KEY `empresas_id` (`empresas_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `modulos_empresas`
--
ALTER TABLE `modulos_empresas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `modulos_empresas_usuarios`
--
ALTER TABLE `modulos_empresas_usuarios`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT de la tabla `roles_permisos`
--
ALTER TABLE `roles_permisos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD CONSTRAINT `modulos_usu_crea_foreign` FOREIGN KEY (`usu_crea`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `modulos_empresas`
--
ALTER TABLE `modulos_empresas`
  ADD CONSTRAINT `modulos_empresas_ibfk_1` FOREIGN KEY (`usu_crea`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `modulos_empresas_usuarios`
--
ALTER TABLE `modulos_empresas_usuarios`
  ADD CONSTRAINT `modulos_empresas_usuarios_ibfk_1` FOREIGN KEY (`usu_crea`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `roles_permisos`
--
ALTER TABLE `roles_permisos`
  ADD CONSTRAINT `roles_permisos_ibfk_1` FOREIGN KEY (`usu_crea`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`empresas_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `users_id_foreign` FOREIGN KEY (`id`) REFERENCES `personas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_idrol_foreign` FOREIGN KEY (`idrol`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
