-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-05-2019 a las 22:09:09
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
-- Estructura de tabla para la tabla `colaboradores`
--

CREATE TABLE `colaboradores` (
  `id` int(11) NOT NULL,
  `colaborador` varchar(250) NOT NULL,
  `observacion` text,
  `estado` int(11) NOT NULL DEFAULT '1',
  `vendedor` tinyint(1) DEFAULT NULL,
  `cobrador` tinyint(1) DEFAULT NULL,
  `id_empresa` int(11) NOT NULL,
  `usu_crea` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `colaboradores`
--

INSERT INTO `colaboradores` (`id`, `colaborador`, `observacion`, `estado`, `vendedor`, `cobrador`, `id_empresa`, `usu_crea`, `created_at`, `updated_at`) VALUES
(1, 'Vendedor 1', 'lajflkaj', 1, 1, 0, 1, 1, '2019-05-20 19:34:32', '2019-05-20 19:52:59'),
(2, 'Vendedor 2', NULL, 1, 1, NULL, 1, 1, '2019-05-20 19:52:52', '2019-05-20 19:52:52'),
(3, 'Cobrador 1', NULL, 1, NULL, 1, 1, 1, '2019-05-20 19:53:08', '2019-05-20 19:53:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conf_formatos`
--

CREATE TABLE `conf_formatos` (
  `id` int(10) UNSIGNED NOT NULL,
  `tipo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `retencion` tinyint(1) DEFAULT NULL,
  `no_inicio` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cierre` tinyint(1) DEFAULT NULL,
  `acarreo` tinyint(1) DEFAULT NULL,
  `depreciacion` tinyint(1) DEFAULT NULL,
  `fiscal` tinyint(1) DEFAULT NULL,
  `niif` tinyint(1) DEFAULT NULL,
  `id_empresa` int(11) NOT NULL,
  `nombre_formato` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `conf_formatos`
--

INSERT INTO `conf_formatos` (`id`, `tipo`, `retencion`, `no_inicio`, `cierre`, `acarreo`, `depreciacion`, `fiscal`, `niif`, `id_empresa`, `nombre_formato`, `condicion`, `created_at`, `updated_at`) VALUES
(1, 'Ingreso', 0, '00001', 0, 0, 0, NULL, 0, 1, 'Recibo de Caja', 1, NULL, '2019-05-06 20:05:27'),
(2, 'Egreso', NULL, '0001', 0, 0, NULL, NULL, NULL, 1, 'Comprobante de Egreso', 1, '2018-06-15 17:37:17', '2018-06-15 17:38:45'),
(3, 'Contables', 1, '0001', 1, 1, NULL, 1, NULL, 1, 'Nota Contable', 1, '2018-07-26 02:58:24', '2018-07-26 02:58:24'),
(4, 'Cuentas', 1, '0001', 1, 1, NULL, 1, NULL, 1, 'Cuentas x Pagar', 1, '2018-08-29 23:55:47', '2018-08-29 23:55:47'),
(5, 'Cuentas', 1, '0001', 1, 1, NULL, 1, NULL, 2, 'Cuentas x Pagar', 1, '2018-08-29 23:55:47', '2018-08-29 23:55:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `id` int(11) NOT NULL,
  `id_formato` int(11) NOT NULL,
  `numero` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `tercero` int(11) NOT NULL,
  `debe` double NOT NULL,
  `haber` double NOT NULL,
  `centro_costos` int(11) DEFAULT NULL,
  `doc_externo` int(11) DEFAULT NULL,
  `detalle` text COLLATE utf8_spanish_ci NOT NULL,
  `fecha` date NOT NULL,
  `base_graba` double DEFAULT NULL,
  `usuario` int(11) NOT NULL,
  `cerrado` int(11) NOT NULL DEFAULT '0',
  `condicion` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuenta` int(11) NOT NULL,
  `num_cuenta` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `doc_afecta_long` varchar(150) COLLATE utf8_spanish_ci DEFAULT '''''',
  `saldo_cuent` double DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`id`, `id_formato`, `numero`, `tercero`, `debe`, `haber`, `centro_costos`, `doc_externo`, `detalle`, `fecha`, `base_graba`, `usuario`, `cerrado`, `condicion`, `created_at`, `updated_at`, `cuenta`, `num_cuenta`, `doc_afecta_long`, `saldo_cuent`) VALUES
(2, 7, '0004', 1, 100, 0, NULL, 2, '100.00', '2018-07-15', NULL, 1, 0, 1, '2018-07-17 00:27:38', '2018-07-15 12:12:22', 4, '110505', '0004', NULL),
(3, 14, '5', 2, 500, 0, NULL, NULL, '500.00', '2018-07-25', NULL, 1, 0, 1, '2018-07-26 03:43:11', '2018-07-26 03:43:11', 4, '110505', '\'\'', NULL),
(4, 14, '5', 2, 0, 250, NULL, NULL, '500.00', '2018-07-25', NULL, 1, 0, 1, '2018-07-26 03:43:11', '2018-07-26 03:43:11', 13, '111505', '\'\'', NULL),
(5, 15, '00004', 3, 100, 0, NULL, NULL, '100.00', '2018-07-27', NULL, 1, 0, 1, '2018-07-28 01:31:30', '2018-07-28 01:31:30', 4, '110505', '\'\'', NULL),
(10, 16, '00006', 2, 1000, 0, NULL, NULL, 'prueba prueba 111 prueba', '2018-08-03', NULL, 1, 0, 1, '2018-08-16 02:21:53', '2018-08-16 02:21:53', 4, '110505', '\'\'', NULL),
(11, 16, '00006', 2, 0, 1000, NULL, NULL, 'prueba prueba 111 prueba', '2018-08-03', NULL, 1, 0, 1, '2018-08-16 02:21:53', '2018-08-16 02:21:53', 11, '111005', '\'\'', NULL),
(14, 17, '00001', 1, 0, 1000000, NULL, 14, 'pago honorarios', '2018-08-29', NULL, 1, 0, 1, '2018-10-04 06:04:24', '2018-10-04 11:04:24', 23, '233525', '00001', 200000),
(15, 17, '00001', 1, 1000000, 0, NULL, NULL, 'pago honorarios', '2018-08-29', NULL, 1, 0, 1, '2018-08-30 01:02:18', '2018-08-30 01:02:18', 20, '511095', '\'\'', NULL),
(18, 18, '00002', 1, 0, 500000, NULL, 18, 'pago2', '2018-09-02', NULL, 1, 0, 1, '2018-10-04 06:04:24', '2018-10-04 11:04:24', 23, '233525', '00002', 0),
(19, 18, '00002', 1, 500000, 0, NULL, NULL, 'pago2', '2018-09-02', NULL, 1, 0, 1, '2018-09-21 16:17:10', '2018-09-21 16:17:10', 20, '511095', '\'\'', NULL),
(24, 24, '00006', 1, 800000, 0, NULL, 14, 'sfdsdf', '2018-10-04', NULL, 1, 0, 1, '2018-10-04 11:04:24', '2018-10-04 11:04:24', 23, '233525', '00001', 0),
(25, 24, '00006', 1, 500000, 0, NULL, 18, 'sfdsdf', '2018-10-04', NULL, 1, 0, 1, '2018-10-04 11:04:24', '2018-10-04 11:04:24', 23, '233525', '00002', 0),
(26, 24, '00006', 1, 0, 500000, NULL, NULL, 'sfdsdf', '2018-10-04', NULL, 1, 0, 1, '2018-10-04 11:04:24', '2018-10-04 11:04:24', 4, '110505', NULL, 0),
(27, 25, '00007', 1, 100, 0, NULL, NULL, 'sdfasdf', '2018-10-17', NULL, 1, 0, 1, '2018-10-18 00:25:08', '2018-10-18 00:25:08', 4, '110505', NULL, 0),
(28, 26, '00008', 1, 100, 0, NULL, NULL, 'asdfad', '2018-10-17', NULL, 1, 0, 1, '2018-10-18 00:27:55', '2018-10-18 00:27:55', 4, '110505', NULL, 0),
(29, 27, '00003', 9, 0, 10000, NULL, NULL, 'sdfasdf', '2018-11-02', NULL, 1, 0, 1, '2018-11-02 21:10:48', '2018-11-02 21:10:48', 25, '236515', NULL, 0),
(30, 28, '00004', 9, 0, 2000, NULL, NULL, 'csdfsfa', '2018-11-02', NULL, 1, 0, 1, '2018-11-02 21:27:07', '2018-11-02 21:27:07', 25, '236515', NULL, 0),
(31, 29, '00005', 1, 0, 4000, NULL, NULL, 'iiiii', '2018-11-02', NULL, 1, 0, 1, '2018-11-02 21:39:53', '2018-11-02 21:39:53', 23, '233525', NULL, 4000),
(32, 30, '00005', 1, 233333, 0, NULL, NULL, 'ddfdfd', '2019-05-01', NULL, 1, 0, 1, '2019-05-02 05:48:57', '2019-05-02 05:48:57', 4, '110505', NULL, 0),
(39, 38, '00009', 9, 10, 9, NULL, NULL, 'jjaf', '2019-05-07', NULL, 1, 0, 1, '2019-05-08 01:58:31', '2019-05-08 01:58:31', 1, '1', NULL, 0),
(40, 37, '00007', 7, 3, 7, NULL, NULL, 'jjj', '2019-05-07', NULL, 1, 0, 1, '2019-05-08 01:58:46', '2019-05-08 01:58:46', 23, '233525', NULL, 0),
(41, 44, '00009', 7, 4, 3, NULL, NULL, 'kjnsasjsind', '2019-05-08', NULL, 1, 0, 1, '2019-05-08 20:20:14', '2019-05-08 20:20:14', 4, '110505', NULL, 0),
(50, 45, '00010', 7, 1000, 300, NULL, NULL, 'Detalle', '2019-05-08', NULL, 1, 0, 1, '2019-05-17 01:48:17', '2019-05-17 01:48:17', 1, '1', NULL, 0),
(51, 45, '00010', 7, 4000, 500, NULL, NULL, 'Detalle', '2019-05-08', NULL, 1, 0, 1, '2019-05-17 01:48:17', '2019-05-17 01:48:17', 4, '110505', NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `logo` varchar(250) NOT NULL,
  `repre_legal` varchar(250) NOT NULL,
  `nit` varchar(50) NOT NULL,
  `direccion` varchar(250) NOT NULL,
  `res_fact_elect` varchar(250) NOT NULL,
  `res_fact_pos` varchar(250) NOT NULL,
  `correo` varchar(250) NOT NULL,
  `celular` varchar(250) NOT NULL,
  `telefono` varchar(250) NOT NULL,
  `usu_crea` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id`, `nombre`, `logo`, `repre_legal`, `nit`, `direccion`, `res_fact_elect`, `res_fact_pos`, `correo`, `celular`, `telefono`, `usu_crea`, `created_at`, `updated_at`) VALUES
(1, 'Empresa 1', 'logo2.jpg', 'repre1', '11111111-0', 'direccion 1', '73892147983798', '39817o47389798', 'empresa1@gmail.com', '300000000', '4222222', 1, '2019-05-08 21:18:09', '2019-05-10 03:42:00'),
(2, 'Empresa 2', 'logo2.jpg', 'repre2', '2222', 'direccion 2', '4314312', '314312', 'aofijdoifj@gmial.com', '40958029', '390180192', 9, '2019-05-08 21:18:09', '2019-05-10 03:41:23'),
(4, 'Empresa 3', 'logo3.jpg', 'Repre', '9879799798', '', '87878787', '78878787', '7878787', '7879877', '7878787', 1, '2019-05-10 02:05:19', '2019-05-10 03:41:39'),
(5, 'Empresa 4', 'logo4.jpg', 'ldajflkj', '999', '', '9', '9', '9', '9', '9', 1, '2019-05-10 02:30:07', '2019-05-10 03:41:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formatos`
--

CREATE TABLE `formatos` (
  `id` int(11) NOT NULL,
  `numero` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `formato` int(11) NOT NULL,
  `tercero` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `detalle` text COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `condicion` int(11) NOT NULL DEFAULT '1',
  `usuario` int(11) NOT NULL,
  `subtotal` double DEFAULT NULL,
  `impuesto` double DEFAULT NULL,
  `vr_impuesto` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `debes` double NOT NULL DEFAULT '0',
  `haberes` double NOT NULL DEFAULT '0',
  `doc_afecta` int(11) DEFAULT NULL,
  `banco` int(11) DEFAULT NULL,
  `forma_pago` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `num_cheque` int(11) DEFAULT NULL,
  `cerrado` int(11) DEFAULT '0',
  `doc_afecta_long` varchar(390) COLLATE utf8_spanish_ci DEFAULT NULL,
  `id_empresa` int(11) NOT NULL,
  `id_retencion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `formatos`
--

INSERT INTO `formatos` (`id`, `numero`, `formato`, `tercero`, `fecha`, `detalle`, `created_at`, `updated_at`, `condicion`, `usuario`, `subtotal`, `impuesto`, `vr_impuesto`, `total`, `debes`, `haberes`, `doc_afecta`, `banco`, `forma_pago`, `num_cheque`, `cerrado`, `doc_afecta_long`, `id_empresa`, `id_retencion`) VALUES
(2, '0002', 1, 1, '2018-06-25', 'dddddd', '2019-05-06 16:04:58', '2018-06-26 07:07:23', 1, 1, 0, NULL, NULL, 0, 0, 0, NULL, 0, '', NULL, 0, '', 1, 0),
(3, '0003', 1, 1, '2018-07-04', 'xxxx', '2019-05-06 16:04:58', '2018-07-16 22:14:24', 0, 1, 1000, NULL, NULL, 1000, 1000, 0, NULL, 0, '', NULL, 0, '', 1, 0),
(7, '0004', 2, 1, '2018-07-15', '100.00', '2019-05-06 16:04:58', '2018-07-16 22:50:13', 1, 1, 0, NULL, NULL, 0, 100, 0, NULL, NULL, 'Efectivo', NULL, 1, '', 1, 0),
(14, '5', 3, 2, '2018-07-25', 'prueba', '2019-05-06 16:04:58', '2018-07-25 22:43:11', 1, 1, 0, NULL, NULL, 0, 500, 250, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, 0),
(15, '00004', 1, 3, '2018-07-27', '100.00', '2019-05-06 16:04:58', '2018-07-27 20:31:30', 1, 1, 0, NULL, NULL, 0, 100, 0, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, 0),
(16, '00006', 3, 1, '2018-08-03', 'prueba prueba 111 prueba', '2019-05-06 16:04:58', '2018-08-15 21:21:53', 1, 1, 0, NULL, NULL, 0, 1000, 1000, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, 0),
(17, '00001', 4, 1, '2018-08-29', 'pago honorarios', '2019-05-06 16:04:58', '2018-08-29 20:02:18', 1, 1, 0, NULL, NULL, 0, 1000000, 1000000, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, 0),
(18, '00002', 4, 1, '2018-09-02', 'pago2', '2019-05-06 16:04:58', '2018-09-21 11:17:09', 1, 1, 0, NULL, NULL, 0, 500000, 500000, NULL, NULL, NULL, NULL, 0, NULL, 1, 0),
(20, '00005', 2, 1, '2018-09-30', 'sfasdf', '2019-05-06 16:04:58', '2018-10-02 00:45:33', 0, 1, 0, NULL, NULL, 0, 1300000, 0, NULL, 4, 'Efectivo', NULL, 0, NULL, 1, 0),
(24, '00006', 2, 1, '2018-10-04', 'sfdsdf', '2019-05-06 16:04:58', '2018-10-04 06:04:24', 1, 1, 0, NULL, NULL, 0, 1300000, 500000, NULL, 4, 'Efectivo', NULL, 0, NULL, 1, 0),
(25, '00007', 2, 1, '2018-10-17', 'sdfasdf', '2019-05-06 16:04:58', '2018-10-17 19:25:08', 1, 1, 0, NULL, NULL, 0, 100, 0, NULL, 4, 'Efectivo', NULL, 0, NULL, 1, 0),
(26, '00008', 2, 1, '2018-10-17', 'asdfad', '2019-05-06 16:05:47', '2018-10-17 19:27:55', 1, 1, 0, NULL, NULL, 0, 100, 0, NULL, 4, 'Efectivo', NULL, 0, NULL, 2, 0),
(27, '00003', 4, 9, '2018-11-02', 'sdfasdf', '2019-05-06 16:05:43', '2018-11-02 16:10:48', 1, 1, 0, NULL, NULL, 0, 0, 10000, NULL, NULL, NULL, NULL, 0, NULL, 2, 0),
(28, '00004', 4, 9, '2018-11-02', 'csdfsfa', '2019-05-06 16:05:41', '2018-11-02 16:27:07', 1, 1, 0, NULL, NULL, 0, 0, 2000, NULL, 4, NULL, NULL, 0, NULL, 2, 0),
(29, '00005', 4, 1, '2018-11-02', 'iiiii', '2019-05-06 16:05:37', '2018-11-02 16:39:53', 1, 1, 0, NULL, NULL, 0, 0, 4000, NULL, NULL, 'Efectivo', NULL, 0, NULL, 2, 0),
(30, '00005', 1, 1, '2019-05-01', 'ddfdfd', '2019-05-06 16:09:50', '2019-05-02 00:48:57', 1, 1, 0, NULL, NULL, 0, 233333, 0, NULL, NULL, 'Efectivo', NULL, 0, NULL, 2, 0),
(37, '00007', 1, 7, '2019-05-07', 'jjj', '2019-05-07 20:58:46', '2019-05-07 20:58:46', 1, 1, 0, NULL, NULL, 0, 3, 7, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, 0),
(38, '00009', 3, 9, '2019-05-07', 'jjaf', '2019-05-08 14:56:14', '2019-05-07 20:58:31', 1, 1, 0, NULL, NULL, 0, 10, 9, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, 0),
(44, '00009', 2, 7, '2019-05-08', 'kjnsasjsind', '2019-05-08 20:20:14', '2019-05-08 15:20:14', 1, 1, 0, NULL, NULL, 0, 4, 3, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, 0),
(45, '00010', 1, 1, '2019-05-08', 'Detalle', '2019-05-16 20:49:30', '2019-05-16 20:48:17', 1, 1, 0, NULL, NULL, 0, 5000, 800, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `informes_contables`
--

CREATE TABLE `informes_contables` (
  `id` int(11) NOT NULL,
  `nom_informe` varchar(300) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_informe` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `condicion` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `numero` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `informes_contables`
--

INSERT INTO `informes_contables` (`id`, `nom_informe`, `tipo_informe`, `condicion`, `created_at`, `updated_at`, `numero`) VALUES
(1, 'Auxiliar con Saldos', 'Auxiliares', 1, '2018-08-15 20:52:35', '2018-08-15 20:52:35', 1),
(2, 'Auxiliar x Comprobantes', 'Auxiliares', 1, '2018-08-15 21:08:06', '2018-08-15 21:08:06', 2);

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
(1, 'Contabilidad', NULL, 1, 1, 'Contabilidad.vue', 1, 1, 'icon-bag', 'contabilidad', NULL, '2019-05-03 21:29:57', '2019-05-03 21:29:57'),
(2, 'Plan de cuentas', NULL, 1, 1, 'PlanCuentas.vue', 2, 2, 'icon-bag', 'plancuentas', 1, '2019-05-03 21:30:50', '2019-05-03 21:30:50'),
(3, 'ConFormatos', NULL, 1, 1, 'ConFormatos.vue', 3, 2, 'icon-bag', 'conformatos', 1, '2019-05-03 21:31:25', '2019-05-06 19:03:19'),
(4, 'Registros', NULL, 1, 1, 'RegistroConta.vue', 4, 2, 'icon-bag', 'registroconta', 1, '2019-05-06 20:37:00', '2019-05-06 20:37:00'),
(5, 'Configuraciones', NULL, 1, 1, 'Config.vue', 5, 1, 'icon-bag', 'config', NULL, '2019-05-09 01:42:10', '2019-05-09 01:42:10'),
(6, 'General', NULL, 1, 1, 'ConfigGenerales.vue', 6, 2, 'icon-bag', 'configgenerales', 5, '2019-05-09 01:43:03', '2019-05-09 01:43:03'),
(7, 'Informes Contables', NULL, 1, 1, 'InformesContables.vue', 7, 1, 'icon-bag', 'infomescontables', NULL, '2019-05-10 20:28:06', '2019-05-10 20:28:06'),
(8, 'Auxiliares', NULL, 1, 1, 'AuxiliaresConta.vue', 8, 2, 'icon-bag', 'auxiliares_conta', 7, '2019-05-10 20:28:37', '2019-05-10 20:34:46'),
(9, 'Retenciones', NULL, 1, 1, 'Retenciones.vue', 9, 2, 'icon-bag', 'retenciones', 5, '2019-05-10 21:34:16', '2019-05-10 21:34:16'),
(10, 'Terceros', NULL, 1, 1, 'Terceros.vue', 10, 2, 'icon-bag', 'terceros', 1, '2019-05-14 02:30:45', '2019-05-14 02:31:04'),
(11, 'Vendedores', NULL, 1, 1, 'Colaboradores.vue', 11, 2, 'icon-bag', 'colaboradores', 5, '2019-05-20 19:00:29', '2019-05-20 19:00:29'),
(12, 'Zonas', NULL, 1, 1, 'Zona.vue', 12, 2, 'icon-bag', 'zona', 5, '2019-05-20 21:03:05', '2019-05-20 21:03:05');

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
(4, 1, 2, 1, 1, NULL),
(5, 2, 2, 1, 1, NULL),
(6, 3, 2, 1, 1, NULL),
(7, 4, 1, 1, 1, NULL),
(8, 4, 2, 1, 1, NULL),
(9, 5, 1, 1, 1, NULL),
(10, 5, 2, 1, 1, NULL),
(11, 6, 1, 1, 1, NULL),
(12, 6, 2, 1, 1, NULL),
(13, 7, 1, 1, 1, NULL),
(14, 7, 2, 1, 1, NULL),
(15, 8, 1, 1, 1, NULL),
(16, 8, 2, 1, 1, NULL),
(17, 9, 1, 1, 1, NULL),
(18, 9, 2, 1, 1, NULL),
(19, 10, 1, 1, 1, NULL),
(20, 10, 2, 1, 1, NULL),
(21, 11, 1, 1, 1, NULL),
(22, 11, 2, 1, 1, NULL),
(23, 12, 1, 1, 1, NULL),
(24, 12, 2, 1, 1, NULL);

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
(1, 1, 1, 0, 0, 0, 0, 0, 1, '2019-05-03 11:49:07'),
(8, 4, 1, 0, 0, 0, 0, 0, 1, '2019-05-03 11:49:07'),
(9, 5, 1, 1, 1, 1, 1, 1, 1, '2019-05-03 15:51:21'),
(10, 6, 1, 1, 1, 1, 1, 1, 1, '2019-05-03 15:51:21'),
(15, 8, 1, 1, 1, 1, 1, 1, 1, '2019-05-03 17:21:06'),
(18, 4, 9, 0, 0, 0, 0, 0, 9, '2019-05-06 09:54:09'),
(21, 1, 9, 0, 0, 0, 0, 0, 1, '2019-05-06 10:38:27'),
(95, 9, 1, 0, 0, 0, 0, 0, 1, '2019-05-08 15:48:32'),
(100, 9, 9, 0, 0, 0, 0, 0, 1, '2019-05-08 15:48:45'),
(109, 10, 9, 0, 0, 0, 0, 0, 9, '2019-05-09 17:27:49'),
(118, 13, 1, 0, 0, 0, 0, 0, 1, '2019-05-10 10:30:27'),
(124, 13, 9, 0, 0, 0, 0, 0, 1, '2019-05-10 10:30:38'),
(149, 14, 9, 0, 0, 0, 0, 0, 9, '2019-05-13 10:18:38'),
(171, 12, 9, 0, 0, 0, 0, 1, 9, '2019-05-16 14:44:58'),
(172, 18, 9, 0, 1, 0, 0, 1, 9, '2019-05-16 14:44:58'),
(173, 6, 9, 0, 0, 0, 0, 1, 9, '2019-05-16 14:44:58'),
(174, 5, 9, 0, 0, 0, 0, 1, 9, '2019-05-16 14:44:58'),
(175, 8, 9, 0, 0, 0, 0, 1, 9, '2019-05-16 14:44:58'),
(176, 20, 9, 0, 0, 0, 0, 1, 9, '2019-05-16 14:44:58'),
(177, 16, 9, 0, 0, 0, 0, 1, 9, '2019-05-16 14:44:58'),
(194, 11, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 11:04:05'),
(195, 17, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 11:04:05'),
(196, 21, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 11:04:05'),
(197, 23, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 11:04:05'),
(198, 3, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 11:04:05'),
(199, 2, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 11:04:05'),
(200, 7, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 11:04:05'),
(201, 19, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 11:04:05'),
(202, 15, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 11:04:05'),
(203, 11, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(204, 17, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(205, 21, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(206, 23, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(207, 3, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(208, 2, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(209, 7, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(210, 19, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(211, 15, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10');

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
-- Estructura de tabla para la tabla `novedades`
--

CREATE TABLE `novedades` (
  `id` int(11) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `observacion` text,
  `link` varchar(250) NOT NULL,
  `id_tercero` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `usu_crea` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `novedades`
--

INSERT INTO `novedades` (`id`, `nombre`, `observacion`, `link`, `id_tercero`, `id_empresa`, `usu_crea`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'Novedad 1', 'jklajsklk', 'kljkljlk', 11, 1, 1, 1, '2019-05-21 20:01:52', '2019-05-21 20:01:52'),
(2, 'Novedad 2', NULL, 'jlpjlpj', 11, 1, 1, 1, '2019-05-21 21:03:20', '2019-05-21 21:03:20'),
(3, 'Novedad 3', NULL, 'jaslkfjladsjflak', 11, 1, 1, 1, '2019-05-21 21:05:01', '2019-05-21 21:05:01'),
(4, 'Novedad 4', NULL, 'jjjjj', 11, 1, 1, 1, '2019-05-21 21:06:21', '2019-05-21 21:06:21'),
(5, 'Novedad 5', NULL, 'jjjjj', 11, 1, 1, 1, '2019-05-21 21:06:33', '2019-05-21 21:06:33'),
(6, 'Novedad 6', 'jlkgjlskj', 'novedad6', 11, 1, 1, 1, '2019-05-21 21:07:26', '2019-05-21 21:07:26');

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
  `telefono1` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono2` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `celular` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email2` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `num_verif` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `autoretenedor` int(11) NOT NULL,
  `declarante` int(11) NOT NULL,
  `cliente` tinyint(1) DEFAULT NULL,
  `proveedor` tinyint(1) DEFAULT NULL,
  `id_vendedor` int(11) DEFAULT NULL,
  `id_zona` int(11) DEFAULT NULL,
  `plazo_pago` int(11) DEFAULT NULL,
  `bloquear` tinyint(1) DEFAULT NULL,
  `cupo_credito` tinyint(1) DEFAULT NULL,
  `retenedor_fuente` tinyint(1) DEFAULT NULL,
  `retenedor_iva` tinyint(1) DEFAULT NULL,
  `excluido_iva` int(11) DEFAULT NULL,
  `autoretefuente` tinyint(1) DEFAULT NULL,
  `autoreteiva` tinyint(1) DEFAULT NULL,
  `autoreteica` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`id`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono1`, `telefono2`, `celular`, `email`, `email2`, `created_at`, `updated_at`, `regimen`, `representante`, `sexo`, `fec_nac`, `reside`, `tipo_persona`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `digito_verif`, `entidad`, `num_verif`, `autoretenedor`, `declarante`, `cliente`, `proveedor`, `id_vendedor`, `id_zona`, `plazo_pago`, `bloquear`, `cupo_credito`, `retenedor_fuente`, `retenedor_iva`, `excluido_iva`, `autoretefuente`, `autoreteiva`, `autoreteica`) VALUES
(1, 'Cristhiam', 'CEDULA', '1123201184', 'ccc', NULL, NULL, NULL, 'ccmonpan@hotmail.com', NULL, '2018-08-01 05:00:00', '2019-05-22 01:05:37', '', '', '', '0000-00-00', '', 'Natural', 'Cristhiam', 'Camilo', 'Monsalve', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'Jessica Murcia', 'NIT', '33333', 'lllllll', '34444', NULL, NULL, 'cccc@jjjj.com', NULL, '2018-07-08 02:02:10', '2018-07-11 10:37:16', '', '', '', '0000-00-00', '', '', 'Jessica', '', 'Murcia', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'Domenick', 'CE', '1123', 'kkkkk', '9999', NULL, NULL, 'cjcjc@ssss.com', NULL, '2018-07-08 12:20:52', '2018-07-11 10:37:10', '', '', '', '0000-00-00', '', '', '', '', '', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'Provedor1', 'CC', '90088777', '87788', '32222', NULL, NULL, 'cccccc@jjj.com', NULL, '2018-07-09 23:07:14', '2018-07-11 10:36:52', '', '', '', '0000-00-00', '', '', '', '', '', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'Rifas x', 'NIT', '908888', 'sdfosdfoi', '454545', NULL, NULL, 'lsdfskdjf@dsfdsf.xom', NULL, '2018-07-11 11:22:21', '2018-09-21 12:44:12', 'Comun', 'lsdfskdjf@dsfdsf.xom', 'Otro', '2018-07-01', 'asdfasdf ad fasd fasdf asf4', 'Juridica', NULL, NULL, NULL, NULL, 0, NULL, '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, '\'\'', 'CC', '45998888', 'jflasdjf aljsd flajsdf l', '3495959', NULL, NULL, 'htm@hot.com', NULL, '2018-08-04 07:49:37', '2018-08-04 07:49:37', 'Comun', NULL, 'Femenino', NULL, 'asdfasdfadsf', 'Natural', 'Marlon', '', 'Monsalve', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, NULL, 'CC', '3839', 'jkjk', '777', NULL, NULL, 'lues@gg.com', NULL, '2018-08-04 08:04:37', '2018-08-04 08:04:37', 'Comun', NULL, 'Masculino', NULL, 'dfsdfsdf', 'Natural', 'Luis', '', 'Monsalve', '', 0, '', '', 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'Ismael', 'CC', '1085288369', 'barrio el jardin', '3203313824', NULL, NULL, 'fanfano312@hotmail.com', NULL, '2018-08-11 07:38:58', '2018-08-22 02:50:23', 'Simplificado', 'fanfano312@hotmail.com', 'Masculino', '1991-04-27', 'mocoa', 'Natural', 'ismael', NULL, 'cardenas', NULL, 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'Fabian', 'CC', '123', '123', '123', NULL, NULL, 'sss', NULL, '2018-08-22 20:04:53', '2018-08-22 20:04:53', 'Simplificado', NULL, 'Femenino', '2001-04-18', 'xxxx', 'Natural', 'Oscar', 'Fabian', 'Franco', 'Pantoja', 0, '', '', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, NULL, 'CC', '121212', NULL, NULL, NULL, NULL, NULL, NULL, '2018-08-31 01:51:06', '2019-05-20 22:05:43', 'Simplificado', NULL, 'Masculino', NULL, 'wwwww', 'Natural', 'Pepito', NULL, 'perez', NULL, 0, NULL, '', 2, 2, NULL, NULL, 2, 2, 13, 0, 1, 1, 0, 0, 0, 0, 0),
(11, NULL, 'CC', '1123314444', 'Lagos', '3209086389', NULL, NULL, 'bianeydiaz2013@gmail.com', NULL, '2019-05-20 22:12:06', '2019-05-21 01:16:45', 'Simplificado', 'bianeydiaz2013@gmail.com', 'Femenino', '1997-02-21', 'ajlkjfl', 'Natural', 'Evelin', 'Bianey', 'Diaz', 'Tisoy', 0, 'Fractal', '', 1, 1, 1, 0, 2, 3, 31, NULL, 1, 1, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan_cuentas`
--

CREATE TABLE `plan_cuentas` (
  `id` int(10) UNSIGNED NOT NULL,
  `codigo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `naturaleza` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `corriente` int(11) DEFAULT '0',
  `banco` int(11) DEFAULT '0',
  `diferido` tinyint(1) DEFAULT '0',
  `tercero` tinyint(1) DEFAULT NULL,
  `niif` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `anio` int(11) DEFAULT NULL,
  `id_cuenta_cierre` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `plan_cuentas`
--

INSERT INTO `plan_cuentas` (`id`, `codigo`, `nombre`, `naturaleza`, `tipo`, `corriente`, `banco`, `diferido`, `tercero`, `niif`, `id_empresa`, `condicion`, `created_at`, `updated_at`, `anio`, `id_cuenta_cierre`) VALUES
(1, '1', 'ACTIVOS', 'Debito', 'Titulo', 0, 0, 0, NULL, '1', 1, 1, NULL, '2019-05-04 01:53:07', 2018, 14),
(2, '2', 'PASIVOS', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '2', 1, 1, '2018-06-16 20:43:36', '2018-06-16 20:43:36', 2018, NULL),
(3, '3', 'PATRIMONIO', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '3', 1, 1, '2018-06-16 20:47:30', '2018-06-16 20:47:30', 2018, NULL),
(4, '110505', 'CAJA GENERAL', 'Debito', 'Detalle', 0, 1, NULL, NULL, '110505', 1, 1, '2018-07-09 21:32:18', '2018-08-30 00:07:34', 2018, NULL),
(5, '11', 'DISPONIBLE', 'Debito', 'Titulo', 0, 0, NULL, NULL, '11', 1, 1, '2018-07-17 10:24:40', '2019-05-22 01:01:29', 2018, 1),
(6, '1105', 'CAJA', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1105', 1, 1, '2018-07-17 10:25:18', '2018-07-17 10:31:04', 2018, NULL),
(8, '110515', 'CAJAS MENORES', 'Debito', 'Detalle', 1, 0, NULL, NULL, '110515', 1, 1, '2018-07-17 10:27:02', '2018-07-17 10:31:19', 2018, NULL),
(9, '1110', 'BANCOS', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1110', 1, 1, '2018-07-17 10:28:08', '2018-07-17 10:31:23', 2018, NULL),
(11, '111005', 'MONEDA NACIONAL - BANCOS', 'Debito', 'Detalle', 1, 1, NULL, NULL, '111005', 1, 1, '2018-07-17 10:29:49', '2018-08-30 00:06:54', 2018, NULL),
(12, '1115', 'REMESAS EN TRANSITO', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1115', 1, 1, '2018-07-17 10:30:17', '2018-07-17 10:32:51', 2018, NULL),
(13, '111505', 'MONEDA NACIONAL', 'Debito', 'Detalle', 1, 0, NULL, NULL, '111505', 1, 1, '2018-07-17 10:30:52', '2018-07-17 10:31:36', 2018, NULL),
(14, '1120', 'CUENTAS DE AHORRO', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1120', 1, 1, '2018-07-17 10:33:44', '2018-07-17 10:33:44', 2018, NULL),
(15, '112005', 'BANCOS', 'Debito', 'Detalle', 1, 0, NULL, NULL, '112005', 1, 1, '2018-07-17 10:34:41', '2018-07-17 10:34:41', 2018, NULL),
(16, '12', 'INVERSIONES', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '12', 1, 1, '2018-07-17 10:38:46', '2018-07-17 10:38:46', 2018, NULL),
(17, '5', 'GASTOS', 'Debito', 'Titulo', 0, 0, NULL, NULL, '5', 1, 1, '2018-08-29 23:58:50', '2018-08-29 23:58:50', 2018, NULL),
(18, '51', 'OPERACIONES DE ADMINISTRACION', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '51', 1, 1, '2018-08-29 23:59:19', '2018-08-29 23:59:19', 2018, NULL),
(19, '5110', 'HONORARIOS', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '5110', 1, 1, '2018-08-30 00:00:01', '2018-08-30 00:00:01', 2018, NULL),
(20, '511095', 'OTROS HONORARIOS', 'Debito', 'Detalle', NULL, 0, NULL, NULL, '511095', 1, 1, '2018-08-30 00:00:49', '2018-08-30 00:00:49', 2018, NULL),
(21, '23', 'CUENTAS POR PAGAR', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '23', 1, 1, '2018-08-30 00:20:37', '2018-08-30 00:20:37', 2018, NULL),
(22, '2335', 'COSTOS Y GASTOS POR PAGAR', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '2335', 1, 1, '2018-08-30 00:21:11', '2018-08-30 00:21:11', 2018, NULL),
(23, '233525', 'HONORARIOS', 'Credito', 'Detalle', NULL, 0, NULL, NULL, '233525', 1, 1, '2018-08-30 00:21:42', '2018-08-30 00:21:42', 2018, NULL),
(24, '2365', 'RETENCION EN LA FUENTE', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '2365', 2, 1, '2018-08-30 00:22:35', '2018-08-30 00:22:35', 2018, NULL),
(25, '236515', 'HONORARIOS (RTE FTE)', 'Credito', 'Detalle', NULL, 0, NULL, NULL, '236515', 2, 1, '2018-08-30 00:24:18', '2018-08-30 00:24:18', 2018, NULL),
(26, '23652501', 'RETENCION EN SERVICIOS DECLARANTE', 'Credito', 'Detalle', NULL, 0, NULL, NULL, '23652501', 1, 1, '2019-05-15 05:42:36', '2019-05-15 05:42:36', 2019, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `retenciones`
--

CREATE TABLE `retenciones` (
  `id` int(11) NOT NULL,
  `retencion` varchar(250) NOT NULL,
  `cuenta` int(11) NOT NULL,
  `tipo_cuenta` varchar(250) NOT NULL,
  `autoretenedor` int(11) NOT NULL,
  `declarante` int(11) NOT NULL,
  `monto_base` double NOT NULL,
  `tipo_mov` int(11) NOT NULL,
  `porcentaje` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `usu_crea` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `retenciones`
--

INSERT INTO `retenciones` (`id`, `retencion`, `cuenta`, `tipo_cuenta`, `autoretenedor`, `declarante`, `monto_base`, `tipo_mov`, `porcentaje`, `id_empresa`, `estado`, `usu_crea`, `created_at`, `updated_at`) VALUES
(1, 'CAJA EGRESOS', 6, 'Debito', 1, 1, 1000, 1, 10, 1, 1, 1, '2019-05-10 16:57:03', '2019-05-17 01:12:38'),
(2, 'PASIVOS EGRESO', 2, 'Credito', 2, 2, 4, 1, 6, 1, 1, 1, '2019-05-11 00:18:52', '2019-05-17 01:11:38'),
(3, 'ACTIVOS INGRESO', 1, 'Debito', 0, 0, 1, 2, 4, 1, 1, 1, '2019-05-11 00:18:52', '2019-05-17 01:11:18');

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

--
-- Volcado de datos para la tabla `roles_permisos`
--

INSERT INTO `roles_permisos` (`id`, `id_rol`, `id_modulo`, `id_empresa`, `lectura`, `escritura`, `edicion`, `anular`, `imprimir`, `usu_crea`, `estado`, `created_at`, `updated_at`) VALUES
(45, 1, 5, 1, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 19:00:45', '2019-05-20 19:00:45'),
(46, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 19:00:45', '2019-05-20 19:00:45'),
(47, 1, 9, 1, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 19:00:45', '2019-05-20 19:00:45'),
(48, 1, 11, 1, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 19:00:45', '2019-05-20 19:00:45'),
(49, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 19:00:45', '2019-05-20 19:00:45'),
(50, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 19:00:45', '2019-05-20 19:00:45'),
(51, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 19:00:45', '2019-05-20 19:00:45'),
(52, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 19:00:45', '2019-05-20 19:00:45'),
(53, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 19:00:45', '2019-05-20 19:00:45'),
(54, 1, 7, 1, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 19:00:45', '2019-05-20 19:00:45'),
(55, 1, 8, 1, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 19:00:45', '2019-05-20 19:00:45');

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
(1, 'cristhiam', '$2y$10$uINPVrLKmyXN4/5/0ScOJOVpxtPwUcBcxxQMBQdiI14KQbl6I/Bqu', 1, 1, 'RXouviOBSZojW1hWcrHGVBPRZl7FoXTprkzkAiiJY5cnV5NnUFZFyP8Itka4', 1),
(9, 'fabian', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'hf8naR2ipDSJscD6wr54QRQLtBPQIEDetSPQRFJim6e7xDVyaFVVgwIKh61O', 2),
(8, 'ismael', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'wo8sErJvqxHw6lqjANBc726TFZ77DUE4FjoCr8shrQh3weAFc5OU99HVPQJH', 1),
(2, 'jessica', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'M7JgIZYa1SfrgoD3GAQy53NSngaceRtHydF3OSnE2I6TB5MlGfJBsDc7f63e', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zona`
--

CREATE TABLE `zona` (
  `id` int(11) NOT NULL,
  `zona` varchar(250) NOT NULL,
  `observacion` text,
  `estado` int(11) NOT NULL DEFAULT '1',
  `id_empresa` int(11) NOT NULL,
  `usu_crea` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `zona`
--

INSERT INTO `zona` (`id`, `zona`, `observacion`, `estado`, `id_empresa`, `usu_crea`, `created_at`, `updated_at`) VALUES
(1, 'Zona 1', 'lajflkaj', 1, 1, 1, '2019-05-20 19:34:32', '2019-05-20 19:52:59'),
(2, 'Zona 2', NULL, 1, 1, 1, '2019-05-20 19:52:52', '2019-05-20 19:52:52'),
(3, 'Zona 3', 'ksksksksks', 1, 1, 1, '2019-05-20 19:53:08', '2019-05-20 21:08:47');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `colaboradores`
--
ALTER TABLE `colaboradores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `conf_formatos`
--
ALTER TABLE `conf_formatos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_formato` (`id_formato`),
  ADD KEY `tercero` (`tercero`),
  ADD KEY `centro_costos` (`centro_costos`),
  ADD KEY `doc_externo` (`doc_externo`),
  ADD KEY `usuario` (`usuario`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `formatos`
--
ALTER TABLE `formatos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `formato` (`formato`),
  ADD KEY `tercero` (`tercero`),
  ADD KEY `usuario` (`usuario`);

--
-- Indices de la tabla `informes_contables`
--
ALTER TABLE `informes_contables`
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
-- Indices de la tabla `novedades`
--
ALTER TABLE `novedades`
  ADD PRIMARY KEY (`id`);

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
-- Indices de la tabla `plan_cuentas`
--
ALTER TABLE `plan_cuentas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `retenciones`
--
ALTER TABLE `retenciones`
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
-- Indices de la tabla `zona`
--
ALTER TABLE `zona`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `colaboradores`
--
ALTER TABLE `colaboradores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `conf_formatos`
--
ALTER TABLE `conf_formatos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `formatos`
--
ALTER TABLE `formatos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `informes_contables`
--
ALTER TABLE `informes_contables`
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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `modulos_empresas`
--
ALTER TABLE `modulos_empresas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `modulos_empresas_usuarios`
--
ALTER TABLE `modulos_empresas_usuarios`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;

--
-- AUTO_INCREMENT de la tabla `novedades`
--
ALTER TABLE `novedades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `plan_cuentas`
--
ALTER TABLE `plan_cuentas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `retenciones`
--
ALTER TABLE `retenciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT de la tabla `roles_permisos`
--
ALTER TABLE `roles_permisos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT de la tabla `zona`
--
ALTER TABLE `zona`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
