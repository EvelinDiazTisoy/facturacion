-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-08-2019 a las 22:43:03
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
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idcategoria` int(10) UNSIGNED NOT NULL,
  `idcategoria2` int(11) NOT NULL,
  `codigo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `descripcion` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cod_invima` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lote` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fec_vence` date DEFAULT NULL,
  `minimo` int(11) DEFAULT NULL,
  `tipo_articulo` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `iva` int(11) NOT NULL,
  `talla` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_und_medida` int(11) DEFAULT NULL,
  `id_concentracion` int(11) DEFAULT NULL,
  `id_presentacion` int(11) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `img` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bancos`
--

CREATE TABLE `bancos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `usu_crea` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `bancos`
--

INSERT INTO `bancos` (`id`, `nombre`, `id_empresa`, `usu_crea`, `estado`, `created_at`, `updated_at`) VALUES
(1, 'Banco 1', 1, 1, 1, '2019-05-23 19:30:03', '2019-05-23 19:30:50'),
(2, 'Banco 2', 1, 1, 1, '2019-05-23 19:31:06', '2019-05-23 19:31:06'),
(3, 'Banco 3', 2, 1, 0, '2019-05-23 19:31:17', '2019-05-28 21:55:04'),
(4, 'Banco 2', 2, 1, 1, '2019-05-23 19:31:06', '2019-05-23 19:31:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajas`
--

CREATE TABLE `cajas` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `id_empresa` int(11) NOT NULL,
  `usu_crea` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajas_cierres`
--

CREATE TABLE `cajas_cierres` (
  `id` int(11) NOT NULL,
  `id_caja` int(11) NOT NULL,
  `vr_inicial` int(11) NOT NULL,
  `obs_inicial` text,
  `vr_gastos` int(11) DEFAULT NULL,
  `obs_gastos` text,
  `vr_software` int(11) NOT NULL,
  `vr_final` int(11) DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `usu_crea` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `id_empresa` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(2, 'Vendedor 2', NULL, 1, 1, NULL, 1, 1, '2019-05-20 19:52:52', '2019-05-28 22:21:51'),
(3, 'Cobrador 1', NULL, 1, NULL, 1, 2, 1, '2019-05-20 19:53:08', '2019-05-20 19:53:08'),
(4, 'Vendedor 2', NULL, 0, 1, NULL, 2, 1, '2019-05-20 19:52:52', '2019-05-20 19:52:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `concentraciones`
--

CREATE TABLE `concentraciones` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `id_empresa` int(11) NOT NULL,
  `usu_crea` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Estructura de tabla para la tabla `con_tarifarios`
--

CREATE TABLE `con_tarifarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `descripcion` text,
  `favorito` tinyint(1) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `usu_crea` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `con_tarifarios`
--

INSERT INTO `con_tarifarios` (`id`, `nombre`, `descripcion`, `favorito`, `id_empresa`, `estado`, `usu_crea`, `created_at`, `updated_at`) VALUES
(1, 'Tarifario 1', 'Descripcion tarifario 1', 0, 1, 1, 1, '2019-05-30 20:04:57', '2019-07-18 21:36:53'),
(2, 'Tarifario 2', 'Tarifario 2', 1, 1, 1, 1, '2019-05-31 19:19:27', '2019-07-18 21:36:53'),
(3, 'Tarifario 3', 'lajflkjl', 0, 1, 1, 1, '2019-05-31 19:44:54', '2019-07-18 21:36:53'),
(4, 'Tarifario 1', 'Descripcion tarifario 1', 0, 2, 1, 1, '2019-05-30 20:04:57', '2019-05-30 20:04:57'),
(5, 'Tarifario 2', 'Tarifario 2', 0, 2, 1, 1, '2019-05-31 19:19:27', '2019-05-31 19:19:27'),
(6, 'Tarifario 3', 'lajflkjl', 0, 2, 0, 1, '2019-05-31 19:44:54', '2019-05-31 20:00:00');

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
  `detalle` text COLLATE utf8_spanish_ci,
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
(54, 45, '00010', 7, 1000, 300, NULL, NULL, 'Detalle', '2019-05-08', NULL, 1, 0, 1, '2019-05-28 20:33:09', '2019-05-28 20:33:09', 1, '1', NULL, 0),
(55, 45, '00010', 7, 4000, 500, NULL, NULL, 'Detalle', '2019-05-08', NULL, 1, 0, 1, '2019-05-28 20:33:09', '2019-05-28 20:33:09', 4, '110505', NULL, 0),
(56, 23, '00001', 11, 1, 0, NULL, 1, '', '2019-06-07', NULL, 1, 0, 1, '2019-06-10 19:10:13', '2019-06-10 19:10:13', 1, '', '\'\'', 0),
(57, 25, '00001', -1, 0, 1, NULL, 1, '', '2019-06-07', NULL, 1, 0, 1, '2019-06-10 19:57:47', '2019-06-10 19:57:47', 8, '', '\'\'', 0),
(58, 29, '00001', 11, 1, 0, NULL, 1, '', '2019-06-07', NULL, 1, 0, 1, '2019-06-18 02:55:05', '2019-06-18 02:55:05', 1, '', '\'\'', 0),
(59, 31, '00001', 11, 1, 0, NULL, 1, '', '2019-06-07', NULL, 1, 0, 1, '2019-06-18 03:05:38', '2019-06-18 03:05:38', 1, '', '\'\'', 0),
(60, 32, '00001', 7, 1000, 0, NULL, 1, '', '2019-06-07', NULL, 1, 0, 1, '2019-06-21 21:41:28', '2019-06-21 21:41:28', 1, '', '\'\'', 0),
(61, 33, '00001', 11, 1000, 0, NULL, 1, '', '2019-06-07', NULL, 1, 0, 1, '2019-06-27 18:52:40', '2019-06-27 18:52:40', 9, '', '\'\'', 0),
(62, 34, '00001', 9, 1000, 0, NULL, 1, '', '2019-06-07', NULL, 1, 0, 1, '2019-06-27 18:53:57', '2019-06-27 18:53:57', 9, '', '\'\'', 0),
(69, 48, '00006', 11, 1000, 0, NULL, 33, 'Editado', '2019-06-07', NULL, 1, 0, 1, '2019-07-03 02:09:13', '2019-07-03 02:09:13', 1, '1', '\"', NULL),
(70, 48, '00006', 11, 1500, 0, NULL, 33, 'Editado', '2019-06-07', NULL, 1, 0, 1, '2019-07-03 02:09:13', '2019-07-03 02:09:13', 4, '110505', '\"', NULL),
(71, 8, '00001', 11, 1000, 0, NULL, 1, '', '2019-06-07', NULL, 1, 0, 1, '2019-07-04 21:34:12', '2019-07-04 21:34:12', 15, '', '\'\'', 0),
(72, 52, '00010', 11, 500, 190, NULL, 8, 'Detalle', '2019-07-04', NULL, 1, 0, 1, '2019-07-05 01:35:46', '2019-07-05 01:35:46', 9, '1110', '\"', NULL),
(73, 52, '00010', 11, 1000, 160, NULL, 8, 'Detalle', '2019-07-04', NULL, 1, 0, 1, '2019-07-05 01:35:46', '2019-07-05 01:35:46', 15, '112005', '\"', NULL),
(74, 54, '00011', 11, 1, 0, NULL, 5, NULL, '0000-00-00', NULL, 1, 0, 1, '2019-07-05 01:55:40', '2019-07-05 01:55:40', 9, '1110', '\"', NULL),
(75, 34, '00001', 11, 1000, 0, NULL, 1, NULL, '2019-06-07', NULL, 1, 0, 1, '2019-07-05 03:00:43', '2019-07-05 03:00:43', 1, '', '\'\'', 0),
(76, 9, '00001', 11, 1000, 0, NULL, 1, NULL, '2019-06-07', NULL, 1, 0, 1, '2019-07-05 03:01:58', '2019-07-05 03:01:58', 15, '', '\'\'', 0),
(77, 36, '00001', 11, 1800, 0, NULL, 1, NULL, '2019-06-07', NULL, 1, 0, 1, '2019-08-06 20:56:14', '2019-08-06 20:56:14', 2, '', '\'\'', 0),
(78, 41, '00001', 11, 1900, 0, NULL, 1, NULL, '2019-06-07', NULL, 1, 0, 1, '2019-08-07 02:38:18', '2019-08-07 02:38:18', 11, '', '\'\'', 0),
(79, 58, '00010', 11, 447, 1900, NULL, 41, NULL, '2019-08-06', NULL, 1, 0, 1, '2019-08-08 19:38:38', '2019-08-08 19:38:38', 2, '2', '\"', NULL),
(80, 59, '00011', 11, 288, 1800, NULL, 36, 'flasfj', '2019-08-06', NULL, 1, 0, 1, '2019-08-08 19:38:46', '2019-08-08 19:38:46', 2, '2', '\"', NULL),
(81, 60, '00012', 11, 138, 1000, NULL, 34, 'Detalle', '2019-07-04', NULL, 1, 0, 1, '2019-08-08 19:48:20', '2019-08-08 19:48:20', 1, '1', '\"', NULL),
(82, 60, '00012', 11, 0, 1000, NULL, 34, 'Detalle', '2019-07-04', NULL, 1, 0, 1, '2019-08-08 19:48:20', '2019-08-08 19:48:20', 4, '110505', '\"', NULL),
(83, 42, '00001', 11, 3000, 0, NULL, 1, NULL, '2019-06-07', NULL, 1, 0, 1, '2019-08-08 22:30:18', '2019-08-08 22:30:18', 11, '', '\'\'', 0),
(84, 61, '00012', 11, 1000, 3862, NULL, 9, NULL, '2019-07-04', NULL, 1, 0, 1, '2019-08-09 06:38:10', '2019-08-09 06:38:10', 15, '112005', '\"', NULL),
(85, 11, '00001', 7, 1000, 0, NULL, 1, NULL, '2019-06-07', NULL, 1, 0, 1, '2019-08-09 06:51:15', '2019-08-09 06:51:15', 9, '', '\'\'', 0),
(86, 43, '00001', 8, 1000, 0, NULL, 1, NULL, '2019-06-07', NULL, 1, 0, 1, '2019-08-13 21:43:33', '2019-08-13 21:43:33', 1, '', '\'\'', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `codigo` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`id`, `nombre`, `codigo`) VALUES
(1, 'Antioquia', 5),
(2, 'Atlantico', 8),
(3, 'D. C. Santa Fe de Bogotá', 11),
(4, 'Bolivar', 13),
(5, 'Boyaca', 15),
(6, 'Caldas', 17),
(7, 'Caqueta', 18),
(8, 'Cauca', 19),
(9, 'Cesar', 20),
(10, 'Cordova', 23),
(11, 'Cundinamarca', 25),
(12, 'Choco', 27),
(13, 'Huila', 41),
(14, 'La Guajira', 44),
(15, 'Magdalena', 47),
(16, 'Meta', 50),
(17, 'Nariño', 52),
(18, 'Norte de Santander', 54),
(19, 'Quindio', 63),
(20, 'Risaralda', 66),
(21, 'Santander', 68),
(22, 'Sucre', 70),
(23, 'Tolima', 73),
(24, 'Valle', 76),
(25, 'Arauca', 81),
(26, 'Casanare', 85),
(27, 'Putumayo', 86),
(28, 'San Andres', 88),
(29, 'Amazonas', 91),
(30, 'Guainia', 94),
(31, 'Guaviare', 95),
(32, 'Vaupes', 97),
(33, 'Vichada', 99);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_egresos`
--

CREATE TABLE `detalle_egresos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idegreso` int(10) UNSIGNED NOT NULL,
  `idarticulo` int(10) UNSIGNED NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(11,2) NOT NULL,
  `vr_iva` int(11) NOT NULL,
  `precio_total` int(11) NOT NULL,
  `porcentaje_iva` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Disparadores `detalle_egresos`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockEgreso` AFTER INSERT ON `detalle_egresos` FOR EACH ROW BEGIN
 UPDATE articulos SET stock = stock - NEW.cantidad 
 WHERE articulos.id = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_facturacion`
--

CREATE TABLE `detalle_facturacion` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_factura` int(10) UNSIGNED NOT NULL,
  `id_producto` int(10) UNSIGNED NOT NULL,
  `padre` int(11) DEFAULT NULL,
  `valor_venta` double(15,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `valor_iva` double(15,2) NOT NULL,
  `valor_descuento` double(15,2) NOT NULL,
  `porcentaje_iva` double(15,2) NOT NULL,
  `valor_subtotal` double(15,2) NOT NULL,
  `valor_final` double(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ingresos`
--

CREATE TABLE `detalle_ingresos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idingreso` int(10) UNSIGNED NOT NULL,
  `idarticulo` int(10) UNSIGNED NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(11,2) NOT NULL,
  `vr_iva` int(11) NOT NULL,
  `precio_total` int(11) NOT NULL,
  `porcentaje_iva` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Disparadores `detalle_ingresos`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockIngreso` AFTER INSERT ON `detalle_ingresos` FOR EACH ROW BEGIN
 UPDATE articulos SET stock = stock + NEW.cantidad 
 WHERE articulos.id = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docs_formatos`
--

CREATE TABLE `docs_formatos` (
  `id` int(11) NOT NULL,
  `id_formato` int(11) NOT NULL,
  `nombre` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `detalle` text COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ruta` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `egresos`
--

CREATE TABLE `egresos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idproveedor` int(10) UNSIGNED NOT NULL,
  `idusuario` int(10) UNSIGNED NOT NULL,
  `tipo_comprobante` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serie_comprobante` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_comprobante` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_egreso` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) DEFAULT NULL,
  `total` decimal(11,2) NOT NULL,
  `forma_pago` int(11) DEFAULT NULL,
  `flete` double DEFAULT NULL,
  `fecha_egreso` date DEFAULT NULL,
  `detalle` text COLLATE utf8mb4_unicode_ci,
  `saldo_parcial` tinyint(1) DEFAULT NULL,
  `iva_incluido` tinyint(1) DEFAULT NULL,
  `valor_iva` int(11) NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Estructura de tabla para la tabla `evidencias_egresos`
--

CREATE TABLE `evidencias_egresos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `observacion` text,
  `link` varchar(250) NOT NULL,
  `id_egreso` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `usu_crea` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evidencias_ingresos`
--

CREATE TABLE `evidencias_ingresos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `observacion` text,
  `link` varchar(250) NOT NULL,
  `id_ingreso` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `usu_crea` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturacion`
--

CREATE TABLE `facturacion` (
  `id` int(10) UNSIGNED NOT NULL,
  `num_factura` int(11) DEFAULT NULL,
  `id_tercero` int(10) UNSIGNED NOT NULL,
  `id_usuario` int(10) UNSIGNED NOT NULL,
  `fec_crea` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_edita` datetime DEFAULT NULL,
  `usu_edita` int(11) DEFAULT NULL,
  `subtotal` double(15,2) NOT NULL,
  `valor_iva` double(15,2) NOT NULL,
  `total` double(15,2) NOT NULL,
  `abono` double(15,2) NOT NULL,
  `saldo` double(15,2) NOT NULL,
  `detalle` text COLLATE utf8mb4_unicode_ci,
  `descuento` double(15,2) NOT NULL,
  `lugar` int(11) NOT NULL,
  `fec_registra` datetime DEFAULT NULL,
  `fec_envia` datetime DEFAULT NULL,
  `fec_anula` datetime DEFAULT NULL,
  `usu_registra` int(10) UNSIGNED DEFAULT NULL,
  `usu_envia` int(10) UNSIGNED DEFAULT NULL,
  `usu_anula` int(10) UNSIGNED DEFAULT NULL,
  `fecha` date NOT NULL,
  `id_tarifario` int(11) NOT NULL,
  `id_cierre_caja` int(11) DEFAULT NULL,
  `id_empresa` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `detalle` text COLLATE utf8_spanish_ci,
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
  `doc_externo` int(11) DEFAULT NULL,
  `tipo_doc_externo` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `doc_afecta` int(11) DEFAULT NULL,
  `banco` int(11) DEFAULT NULL,
  `forma_pago` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `num_cheque` int(11) DEFAULT NULL,
  `cerrado` int(11) DEFAULT '0',
  `doc_afecta_long` varchar(390) COLLATE utf8_spanish_ci DEFAULT NULL,
  `id_empresa` int(11) NOT NULL,
  `id_retencion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `formatos`
--

INSERT INTO `formatos` (`id`, `numero`, `formato`, `tercero`, `fecha`, `detalle`, `created_at`, `updated_at`, `condicion`, `usuario`, `subtotal`, `impuesto`, `vr_impuesto`, `total`, `debes`, `haberes`, `doc_externo`, `tipo_doc_externo`, `doc_afecta`, `banco`, `forma_pago`, `num_cheque`, `cerrado`, `doc_afecta_long`, `id_empresa`, `id_retencion`) VALUES
(2, '0002', 1, 1, '2018-06-25', 'dddddd', '2019-06-28 20:45:37', '2018-06-26 07:07:23', 1, 1, 0, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, '', NULL, 0, '', 1, NULL),
(3, '0003', 1, 1, '2018-07-04', 'xxxx', '2019-06-28 20:45:37', '2018-07-16 22:14:24', 0, 1, 1000, NULL, NULL, 1000, 1000, 0, NULL, NULL, NULL, 0, '', NULL, 0, '', 1, NULL),
(7, '0004', 2, 1, '2018-07-15', '100.00', '2019-06-28 20:45:37', '2018-07-16 22:50:13', 1, 1, 0, NULL, NULL, 0, 100, 0, NULL, NULL, NULL, NULL, 'Efectivo', NULL, 1, '', 1, NULL),
(14, '0005', 3, 2, '2018-07-25', 'prueba', '2019-06-28 20:45:37', '2018-07-25 22:43:11', 1, 1, 0, NULL, NULL, 0, 500, 250, NULL, NULL, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, NULL),
(15, '00004', 1, 3, '2018-07-27', '100.00', '2019-06-28 20:45:37', '2018-07-27 20:31:30', 1, 1, 0, NULL, NULL, 0, 100, 0, NULL, NULL, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, NULL),
(16, '00006', 3, 1, '2018-08-03', 'prueba prueba 111 prueba', '2019-06-28 20:45:37', '2018-08-15 21:21:53', 1, 1, 0, NULL, NULL, 0, 1000, 1000, NULL, NULL, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, NULL),
(17, '00001', 4, 1, '2018-08-29', 'pago honorarios', '2019-06-28 20:45:37', '2018-08-29 20:02:18', 1, 1, 0, NULL, NULL, 0, 1000000, 1000000, NULL, NULL, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, NULL),
(18, '00002', 4, 1, '2018-09-02', 'pago2', '2019-06-28 20:45:37', '2018-09-21 11:17:09', 1, 1, 0, NULL, NULL, 0, 500000, 500000, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL),
(20, '00005', 2, 1, '2018-09-30', 'sfasdf', '2019-06-28 20:45:37', '2018-10-02 00:45:33', 0, 1, 0, NULL, NULL, 0, 1300000, 0, NULL, NULL, NULL, 4, 'Efectivo', NULL, 0, NULL, 1, NULL),
(24, '00006', 2, 1, '2018-10-04', 'sfdsdf', '2019-06-28 20:45:37', '2018-10-04 06:04:24', 1, 1, 0, NULL, NULL, 0, 1300000, 500000, NULL, NULL, NULL, 4, 'Efectivo', NULL, 0, NULL, 1, NULL),
(25, '00007', 2, 1, '2018-10-17', 'sdfasdf', '2019-06-28 20:45:37', '2018-10-17 19:25:08', 1, 1, 0, NULL, NULL, 0, 100, 0, NULL, NULL, NULL, 4, 'Efectivo', NULL, 0, NULL, 1, NULL),
(26, '00008', 2, 1, '2018-10-17', 'asdfad', '2019-06-28 20:45:37', '2018-10-17 19:27:55', 1, 1, 0, NULL, NULL, 0, 100, 0, NULL, NULL, NULL, 4, 'Efectivo', NULL, 0, NULL, 2, NULL),
(27, '00003', 4, 9, '2018-11-02', 'sdfasdf', '2019-06-28 20:45:37', '2018-11-02 16:10:48', 1, 1, 0, NULL, NULL, 0, 0, 10000, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2, NULL),
(28, '00004', 4, 9, '2018-11-02', 'csdfsfa', '2019-06-28 20:45:37', '2018-11-02 16:27:07', 1, 1, 0, NULL, NULL, 0, 0, 2000, NULL, NULL, NULL, 4, NULL, NULL, 0, NULL, 2, NULL),
(29, '00005', 4, 1, '2018-11-02', 'iiiii', '2019-06-28 20:45:37', '2018-11-02 16:39:53', 1, 1, 0, NULL, NULL, 0, 0, 4000, NULL, NULL, NULL, NULL, 'Efectivo', NULL, 0, NULL, 2, NULL),
(30, '00005', 1, 1, '2019-05-01', 'ddfdfd', '2019-06-28 20:45:37', '2019-05-02 00:48:57', 1, 1, 0, NULL, NULL, 0, 233333, 0, NULL, NULL, NULL, NULL, 'Efectivo', NULL, 0, NULL, 2, NULL),
(37, '00007', 1, 7, '2019-05-07', 'jjj', '2019-06-28 20:45:37', '2019-05-07 20:58:46', 1, 1, 0, NULL, NULL, 0, 3, 7, NULL, NULL, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, NULL),
(38, '00009', 3, 9, '2019-05-07', 'jjaf', '2019-06-28 20:45:37', '2019-05-07 20:58:31', 1, 1, 0, NULL, NULL, 0, 10, 9, NULL, NULL, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, NULL),
(44, '00009', 2, 7, '2019-05-08', 'kjnsasjsind', '2019-06-28 20:45:37', '2019-05-08 15:20:14', 1, 1, 0, NULL, NULL, 0, 4, 3, NULL, NULL, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, NULL),
(45, '00010', 1, 1, '2019-05-08', 'Detalle', '2019-05-28 15:33:09', '2019-05-28 15:33:09', 1, 1, 0, NULL, NULL, 0, 5000, 800, NULL, NULL, NULL, NULL, 'Efectivo', NULL, 0, NULL, 1, 1),
(48, '00006', 4, 11, '2019-06-07', 'Editado', '2019-07-03 02:09:12', '2019-07-03 02:09:12', 1, 1, 3000, NULL, 510, 3510, 3510, 3510, 33, 'Compras', NULL, NULL, '', NULL, 0, NULL, 1, NULL),
(52, '00010', 3, 11, '2019-07-04', 'Detalle', '2019-07-05 01:35:46', '2019-07-05 01:35:46', 1, 1, 2000, NULL, 350, 2350, 2350, 2350, 8, 'Compras', NULL, NULL, '', NULL, 0, NULL, 1, NULL),
(54, '00011', 3, 11, '0000-00-00', NULL, '2019-07-05 01:55:40', '2019-07-05 01:55:40', 1, 1, 2, NULL, 0, 2, 2, 2, 5, 'Compras', NULL, NULL, '', NULL, 0, NULL, 1, NULL),
(55, '00007', 4, 11, '2019-07-04', 'Detalle', '2019-07-30 02:22:00', '2019-07-30 02:22:00', 1, 1, 862, NULL, 138, 1000, 1000, 1000, 34, 'Compras', NULL, NULL, '', NULL, 0, NULL, 1, NULL),
(56, '00008', 4, 11, '2019-07-04', 'Detalle', '2019-08-06 02:07:32', '2019-08-06 02:07:32', 1, 1, 862, NULL, 138, 1000, 1000, 1000, 34, 'Compras', NULL, NULL, '', NULL, 0, NULL, 1, NULL),
(57, '00009', 4, 11, '2019-08-06', NULL, '2019-08-08 19:37:25', '2019-08-08 19:37:25', 1, 1, 2353, NULL, 447, 2800, 2800, 2800, 41, 'Compras', NULL, NULL, '', NULL, 0, NULL, 1, NULL),
(58, '00010', 4, 11, '2019-08-06', NULL, '2019-08-08 19:38:38', '2019-08-08 19:38:38', 1, 1, 2353, NULL, 447, 2800, 2800, 2800, 41, 'Compras', NULL, NULL, '', NULL, 0, NULL, 1, NULL),
(59, '00011', 4, 11, '2019-08-06', 'flasfj', '2019-08-08 19:38:46', '2019-08-08 19:38:46', 1, 1, 1512, NULL, 288, 1800, 1800, 1800, 36, 'Compras', NULL, NULL, '', NULL, 0, NULL, 1, NULL),
(60, '00012', 4, 11, '2019-07-04', 'Detalle', '2019-08-08 19:48:20', '2019-08-08 19:48:20', 1, 1, 862, NULL, 138, 1000, 1000, 1000, 34, 'Compras', NULL, NULL, '', NULL, 0, NULL, 1, NULL),
(61, '00012', 3, 11, '2019-07-04', NULL, '2019-08-09 06:38:10', '2019-08-09 06:38:10', 1, 1, 24138, NULL, 3862, 28000, 28000, 28000, 9, 'Compras', NULL, NULL, '', NULL, 0, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formatos_procesos`
--

CREATE TABLE `formatos_procesos` (
  `id` int(11) NOT NULL,
  `idFormatoCompras` int(11) NOT NULL,
  `idFormatoVentas` int(11) NOT NULL,
  `idFormatoSalidas` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `usu_crea` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `formatos_procesos`
--

INSERT INTO `formatos_procesos` (`id`, `idFormatoCompras`, `idFormatoVentas`, `idFormatoSalidas`, `id_empresa`, `usu_crea`, `created_at`, `updated_at`) VALUES
(10, 4, 1, 3, 1, 1, '2019-07-04 22:15:48', '2019-07-04 22:15:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `informes_contables`
--

CREATE TABLE `informes_contables` (
  `id` int(11) NOT NULL,
  `nom_informe` varchar(300) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_informe` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `condicion` int(11) NOT NULL DEFAULT '1',
  `id_empresa` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `numero` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `informes_contables`
--

INSERT INTO `informes_contables` (`id`, `nom_informe`, `tipo_informe`, `condicion`, `id_empresa`, `created_at`, `updated_at`, `numero`) VALUES
(1, 'Auxiliar con Saldos', 'Auxiliares', 1, 1, '2019-05-27 16:24:52', '2018-08-15 20:52:35', 1),
(2, 'Auxiliar x Comprobantes', 'Auxiliares', 1, 1, '2019-05-27 16:24:55', '2018-08-15 21:08:06', 2),
(3, 'Auxiliar x Comprobantes', 'Auxiliares', 1, 2, '2019-05-27 16:24:55', '2018-08-15 21:08:06', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingresos`
--

CREATE TABLE `ingresos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idproveedor` int(10) UNSIGNED NOT NULL,
  `idusuario` int(10) UNSIGNED NOT NULL,
  `tipo_comprobante` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serie_comprobante` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_comprobante` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_ingreso` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) DEFAULT NULL,
  `total` decimal(11,2) NOT NULL,
  `forma_pago` int(11) DEFAULT NULL,
  `flete` double NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `detalle` text COLLATE utf8mb4_unicode_ci,
  `saldo_parcial` tinyint(1) DEFAULT NULL,
  `iva_incluido` tinyint(1) DEFAULT NULL,
  `valor_iva` int(11) NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `iva`
--

CREATE TABLE `iva` (
  `id` int(11) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `porcentaje` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `usu_crea` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Estructura de tabla para la tabla `modelo_contable`
--

CREATE TABLE `modelo_contable` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `idCuentaProductos` int(11) DEFAULT NULL,
  `idCuentaSalidaProductos` int(11) DEFAULT NULL,
  `idCuentaSaldosIniciales` int(11) DEFAULT NULL,
  `idCuentaDonaciones` int(11) DEFAULT NULL,
  `idCuentaDevolucionesVentas` int(11) DEFAULT NULL,
  `idCuentaDevolucionesCompras` int(11) DEFAULT NULL,
  `idCuentaImpuestoConsumoVentas` int(11) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `id_empresa` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(12, 'Zonas', NULL, 1, 1, 'Zona.vue', 12, 2, 'icon-bag', 'zona', 5, '2019-05-20 21:03:05', '2019-05-20 21:03:05'),
(13, 'Bancos', NULL, 1, 1, 'Bancos.vue', 13, 2, 'icon-bag', 'bancos', 5, '2019-05-23 19:12:00', '2019-05-23 19:12:00'),
(14, 'Facturacion', NULL, 1, 1, 'Facturacion.vue', 14, 2, 'icon-bag', 'facturacion', 16, '2019-05-24 19:48:01', '2019-05-25 01:39:10'),
(15, 'Articulos', NULL, 1, 1, 'Articulo.vue', 15, 2, 'icon-bag', 'articulo', 16, '2019-05-24 20:46:47', '2019-05-25 01:20:25'),
(16, 'Almacen', NULL, 1, 1, 'Almacen.vue', 16, 1, 'icon-bag', 'almacen', NULL, '2019-05-25 01:20:13', '2019-05-25 01:20:13'),
(17, 'Compras', NULL, 1, 1, 'Ingresos.vue', 17, 2, 'icon-bag', 'ingreso', 16, '2019-05-25 01:21:08', '2019-06-18 20:02:40'),
(18, 'Egresos', NULL, 1, 1, 'Egresos.vue', 18, 2, 'icon-bag', 'egreso', 16, '2019-05-25 01:38:49', '2019-05-25 03:28:40'),
(19, 'Stock', NULL, 1, 1, 'Stock.vue', 19, 2, 'icon-bag', 'stock', 16, '2019-05-25 01:40:38', '2019-05-25 01:40:38'),
(20, 'Cliente', NULL, 1, 1, 'Cliente.vue', 20, 2, 'icon-bag', 'cliente', 16, '2019-05-25 01:41:46', '2019-05-25 01:41:46'),
(21, 'Modelo Contable', NULL, 1, 1, 'ModeloContable.vue', 21, 2, 'icon-bag', 'modelo_contable', 16, '2019-05-25 01:58:05', '2019-08-09 19:42:22'),
(22, 'Presentación', NULL, 1, 1, 'Prenstacion.vue', 22, 2, 'icon-bag', 'presentacion', 16, '2019-05-25 02:27:08', '2019-05-25 02:27:08'),
(23, 'Unidad de medida', NULL, 1, 1, 'UndMedida.vue', 23, 2, 'icon-bag', 'und_medida', 16, '2019-05-25 02:43:50', '2019-05-25 02:43:50'),
(24, 'Concentracion', NULL, 1, 1, 'Concentracion.vue', 24, 2, 'icon-bag', 'concentracion', 16, '2019-05-25 02:44:33', '2019-05-25 02:44:33'),
(25, 'Categorias', NULL, 1, 1, 'Categoria.vue', 25, 2, 'icon-bag', 'categoria', 16, '2019-05-29 02:58:29', '2019-08-09 19:42:33'),
(26, 'Conf. Tarifarios', NULL, 1, 1, 'ConTarifario.vue', 26, 2, 'icon-bag', 'con_tarifario', 5, '2019-05-29 19:06:49', '2019-07-17 01:34:18'),
(27, 'Iva', NULL, 1, 1, 'Iva.vue', 27, 2, 'icon-bag', 'iva', 5, '2019-06-12 19:07:49', '2019-06-12 19:07:49'),
(28, 'Formatos x proceso', NULL, 1, 1, 'FormatoProceso.vue', 28, 2, 'icon-bag', 'formato_procesos', 5, '2019-06-25 18:45:11', '2019-06-25 18:45:11'),
(29, 'Cajas', NULL, 1, 1, 'Cajas.vue', 29, 2, 'icon-bag', 'cajas', 5, '2019-07-26 18:21:36', '2019-07-26 18:21:36'),
(30, 'Cierres X cajas', NULL, 1, 1, 'CierresXCaja.vue', 30, 2, 'icon-bag', 'cierrescaja', 16, '2019-07-26 22:03:58', '2019-07-26 22:07:29');

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
(2, 2, 1, 0, 1, NULL),
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
(24, 12, 2, 1, 1, NULL),
(25, 13, 1, 1, 1, NULL),
(26, 13, 2, 1, 1, NULL),
(27, 14, 1, 1, 1, NULL),
(28, 14, 2, 1, 1, NULL),
(29, 15, 1, 1, 1, NULL),
(30, 15, 2, 1, 1, NULL),
(31, 16, 1, 1, 1, NULL),
(32, 16, 2, 1, 1, NULL),
(33, 17, 1, 1, 1, NULL),
(34, 17, 2, 1, 1, NULL),
(35, 18, 1, 1, 1, NULL),
(36, 18, 2, 1, 1, NULL),
(37, 19, 1, 1, 1, NULL),
(38, 19, 2, 1, 1, NULL),
(39, 20, 1, 1, 1, NULL),
(40, 20, 2, 1, 1, NULL),
(41, 21, 1, 1, 1, NULL),
(42, 21, 2, 1, 1, NULL),
(43, 22, 1, 1, 1, NULL),
(44, 23, 2, 1, 1, NULL),
(45, 24, 1, 1, 1, NULL),
(46, 24, 2, 1, 1, NULL),
(47, 25, 1, 1, 1, NULL),
(48, 25, 2, 1, 1, NULL),
(49, 23, 1, 1, 1, NULL),
(50, 22, 2, 1, 1, NULL),
(53, 26, 1, 1, 1, NULL),
(54, 26, 2, 1, 1, NULL),
(55, 27, 1, 1, 1, NULL),
(56, 27, 2, 1, 1, NULL),
(57, 28, 1, 1, 1, NULL),
(58, 28, 2, 1, 1, NULL),
(59, 29, 1, 1, 1, NULL),
(60, 29, 2, 1, 1, NULL),
(61, 30, 1, 1, 1, NULL),
(62, 30, 2, 1, 1, NULL);

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
(199, 2, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 11:04:05'),
(208, 2, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(282, 31, 1, 0, 0, 0, 0, 0, 1, '2019-05-24 17:10:26'),
(301, 31, 9, 0, 0, 0, 0, 0, 1, '2019-05-24 17:10:45'),
(360, 51, 1, 1, 1, 1, 1, 1, 1, '2019-05-28 17:00:48'),
(381, 51, 9, 0, 0, 0, 0, 1, 1, '2019-05-28 17:01:06'),
(442, 32, 9, 0, 0, 0, 0, 0, 9, '2019-06-04 10:33:11'),
(575, 30, 9, 1, 1, 1, 1, 1, 9, '2019-06-04 12:12:36'),
(576, 42, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(577, 48, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(578, 40, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(579, 46, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(580, 36, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(581, 28, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(582, 34, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(583, 50, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(584, 38, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(585, 44, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(586, 26, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(587, 54, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(588, 12, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(589, 18, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(590, 22, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(591, 24, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(592, 6, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(593, 5, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(594, 8, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(595, 20, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(596, 16, 9, 0, 0, 0, 0, 1, 9, '2019-06-04 12:12:36'),
(685, 29, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(686, 41, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(687, 47, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(688, 39, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(689, 33, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(690, 45, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(691, 35, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(692, 27, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(693, 43, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(694, 37, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(695, 49, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(696, 25, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(697, 53, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(698, 57, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(699, 11, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(700, 55, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(701, 17, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(702, 21, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(703, 23, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(704, 3, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(705, 7, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(706, 19, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(707, 15, 9, 0, 0, 0, 0, 1, 1, '2019-06-25 08:46:56'),
(732, 29, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(733, 41, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(734, 47, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(735, 39, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(736, 33, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(737, 45, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(738, 35, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(739, 27, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(740, 43, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(741, 37, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(742, 49, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(743, 25, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(744, 59, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(745, 61, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(746, 53, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(747, 57, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(748, 11, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(749, 55, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(750, 17, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(751, 21, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(752, 23, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(753, 3, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(754, 7, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(755, 19, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01'),
(756, 15, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 12:06:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipios`
--

CREATE TABLE `municipios` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `codigo` int(11) NOT NULL,
  `id_departamento` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `municipios`
--

INSERT INTO `municipios` (`id`, `nombre`, `codigo`, `id_departamento`) VALUES
(1, 'MEDELLIN', 1, 1),
(2, 'ABEJORRAL', 2, 1),
(3, 'ABRIAQUI', 4, 1),
(4, 'ALEJANDRIA', 21, 1),
(5, 'AMAGA', 30, 1),
(6, 'AMALFI', 31, 1),
(7, 'ANDES', 34, 1),
(8, 'ANGELOPOLIS', 36, 1),
(9, 'ANGOSTURA', 38, 1),
(10, 'ANORI', 40, 1),
(11, 'ANTIOQUIA', 42, 1),
(12, 'ANZA', 44, 1),
(13, 'APARTADO', 45, 1),
(14, 'ARBOLETES', 51, 1),
(15, 'ARGELIA', 55, 1),
(16, 'ARMENIA', 59, 1),
(17, 'BARBOSA', 79, 1),
(18, 'BELMIRA', 86, 1),
(19, 'BELLO', 88, 1),
(20, 'BETANIA', 91, 1),
(21, 'BETULIA', 93, 1),
(22, 'BOLIVAR', 101, 1),
(23, 'BRICEÑO', 107, 1),
(24, 'BURITICA', 113, 1),
(25, 'CACERES', 120, 1),
(26, 'CAICEDO', 125, 1),
(27, 'CALDAS', 129, 1),
(28, 'CAMPAMENTO', 134, 1),
(29, 'CAÑASGORDAS', 138, 1),
(30, 'CARACOLI', 142, 1),
(31, 'CARAMANTA', 145, 1),
(32, 'CAREPA', 147, 1),
(33, 'CARMEN DE VIBORAL', 148, 1),
(34, 'CAROLINA', 150, 1),
(35, 'CAUCASIA', 154, 1),
(36, 'CHIGORODO', 172, 1),
(37, 'CISNEROS', 190, 1),
(38, 'COCORNA', 197, 1),
(39, 'CONCEPCION', 206, 1),
(40, 'CONCORDIA', 209, 1),
(41, 'COPACABANA', 212, 1),
(42, 'DABEIBA', 234, 1),
(43, 'DON MATIAS', 237, 1),
(44, 'EBEJICO', 240, 1),
(45, 'EL BAGRE', 250, 1),
(46, 'ENTRERRIOS', 264, 1),
(47, 'ENVIGADO', 266, 1),
(48, 'FREDONIA', 282, 1),
(49, 'FRONTINO', 284, 1),
(50, 'GIRALDO', 306, 1),
(51, 'GIRARDOTA', 308, 1),
(52, 'GOMEZ PLATA', 310, 1),
(53, 'GRANADA', 313, 1),
(54, 'GUADALUPE', 315, 1),
(55, 'GUARNE', 318, 1),
(56, 'GUATAPE', 321, 1),
(57, 'HELICONIA', 347, 1),
(58, 'HISPANIA', 353, 1),
(59, 'ITAGUI', 360, 1),
(60, 'ITUANGO', 361, 1),
(61, 'JARDIN', 364, 1),
(62, 'JERICO', 368, 1),
(63, 'LA CEJA', 376, 1),
(64, 'LA ESTRELLA', 380, 1),
(65, 'LA PINTADA', 390, 1),
(66, 'LA UNION', 400, 1),
(67, 'LIBORINA', 411, 1),
(68, 'MACEO', 425, 1),
(69, 'MARINILLA', 440, 1),
(70, 'MONTEBELLO', 467, 1),
(71, 'MURINDO', 475, 1),
(72, 'MUTATA', 480, 1),
(73, 'NARIÑO', 483, 1),
(74, 'NECOCLI', 490, 1),
(75, 'NECHI', 495, 1),
(76, 'OLAYA', 501, 1),
(77, 'PEÑOL', 541, 1),
(78, 'PEQUE', 543, 1),
(79, 'PUEBLORRICO', 576, 1),
(80, 'PUERTO BERRIO', 579, 1),
(81, 'PUERTO NARE (LA MAGDALENA)', 585, 1),
(82, 'PUERTO TRIUNFO', 591, 1),
(83, 'REMEDIOS', 604, 1),
(84, 'RETIRO', 607, 1),
(85, 'RIONEGRO', 615, 1),
(86, 'SABANALARGA', 628, 1),
(87, 'SABANETA', 631, 1),
(88, 'SALGAR', 642, 1),
(89, 'SAN ANDRES', 647, 1),
(90, 'SAN CARLOS', 649, 1),
(91, 'SAN FRANCISCO', 652, 1),
(92, 'SAN JERONIMO', 656, 1),
(93, 'SAN JOSE DE LA MONTAÑA', 658, 1),
(94, 'SAN JUAN DE URABA', 659, 1),
(95, 'SAN LUIS', 660, 1),
(96, 'SAN PEDRO', 664, 1),
(97, 'SAN PEDRO DE URABA', 665, 1),
(98, 'SAN RAFAEL', 667, 1),
(99, 'SAN ROQUE', 670, 1),
(100, 'SAN VICENTE', 674, 1),
(101, 'SANTA BARBARA', 679, 1),
(102, 'SANTA ROSA DE OSOS', 686, 1),
(103, 'SANTO DOMINGO', 690, 1),
(104, 'SANTUARIO', 697, 1),
(105, 'SEGOVIA', 736, 1),
(106, 'SONSON', 756, 1),
(107, 'SOPETRAN', 761, 1),
(108, 'TAMESIS', 789, 1),
(109, 'TARAZA', 790, 1),
(110, 'TARSO', 792, 1),
(111, 'TITIRIBI', 809, 1),
(112, 'TOLEDO', 819, 1),
(113, 'TURBO', 837, 1),
(114, 'URAMITA', 842, 1),
(115, 'URRAO', 847, 1),
(116, 'VALDIVIA', 854, 1),
(117, 'VALPARAISO', 856, 1),
(118, 'VEGACHI', 858, 1),
(119, 'VENECIA', 861, 1),
(120, 'VIGIA DEL FUERTE', 873, 1),
(121, 'YALI', 885, 1),
(122, 'YARUMAL', 887, 1),
(123, 'YOLOMBO', 890, 1),
(124, 'YONDO', 893, 1),
(125, 'ZARAGOZA', 895, 1),
(126, 'BARRANQUILLA (DISTRITO ESPECIAL INDUSTRIAL Y PORTUARIO DE BARRANQUILLA)', 1, 2),
(127, 'BARANOA', 78, 2),
(128, 'CAMPO DE LA CRUZ', 137, 2),
(129, 'CANDELARIA', 141, 2),
(130, 'GALAPA', 296, 2),
(131, 'JUAN DE ACOSTA', 372, 2),
(132, 'LURUACO', 421, 2),
(133, 'MALAMBO', 433, 2),
(134, 'MANATI', 436, 2),
(135, 'PALMAR DE VARELA', 520, 2),
(136, 'PIOJO', 549, 2),
(137, 'POLO NUEVO', 558, 2),
(138, 'PONEDERA', 560, 2),
(139, 'PUERTO COLOMBIA', 573, 2),
(140, 'REPELON', 606, 2),
(141, 'SABANAGRANDE', 634, 2),
(142, 'SABANALARGA', 638, 2),
(143, 'SANTA LUCIA', 675, 2),
(144, 'SANTO TOMAS', 685, 2),
(145, 'SOLEDAD', 758, 2),
(146, 'SUAN', 770, 2),
(147, 'TUBARA', 832, 2),
(148, 'USIACURI', 849, 2),
(149, 'Santa Fe de Bogotá', 1, 3),
(150, 'USAQUEN', 1, 3),
(151, 'CHAPINERO', 2, 3),
(152, 'SANTA FE', 3, 3),
(153, 'SAN CRISTOBAL', 4, 3),
(154, 'USME', 5, 3),
(155, 'TUNJUELITO', 6, 3),
(156, 'BOSA', 7, 3),
(157, 'KENNEDY', 8, 3),
(158, 'FONTIBON', 9, 3),
(159, 'ENGATIVA', 10, 3),
(160, 'SUBA', 11, 3),
(161, 'BARRIOS UNIDOS', 12, 3),
(162, 'TEUSAQUILLO', 13, 3),
(163, 'MARTIRES', 14, 3),
(164, 'ANTONIO NARIÑO', 15, 3),
(165, 'PUENTE ARANDA', 16, 3),
(166, 'CANDELARIA', 17, 3),
(167, 'RAFAEL URIBE', 18, 3),
(168, 'CIUDAD BOLIVAR', 19, 3),
(169, 'SUMAPAZ', 20, 3),
(170, 'CARTAGENA (DISTRITO TURISTICO Y CULTURAL DE CARTAGENA)', 1, 4),
(171, 'ACHI', 6, 4),
(172, 'ALTOS DEL ROSARIO', 30, 4),
(173, 'ARENAL', 42, 4),
(174, 'ARJONA', 52, 4),
(175, 'ARROYOHONDO', 62, 4),
(176, 'BARRANCO DE LOBA', 74, 4),
(177, 'CALAMAR', 140, 4),
(178, 'CANTAGALLO', 160, 4),
(179, 'CICUCO', 188, 4),
(180, 'CORDOBA', 212, 4),
(181, 'CLEMENCIA', 222, 4),
(182, 'EL CARMEN DE BOLIVAR', 244, 4),
(183, 'EL GUAMO', 248, 4),
(184, 'EL PEÑON', 268, 4),
(185, 'HATILLO DE LOBA', 300, 4),
(186, 'MAGANGUE', 430, 4),
(187, 'MAHATES', 433, 4),
(188, 'MARGARITA', 440, 4),
(189, 'MARIA LA BAJA', 442, 4),
(190, 'MONTECRISTO', 458, 4),
(191, 'MOMPOS', 468, 4),
(192, 'MORALES', 473, 4),
(193, 'PINILLOS', 549, 4),
(194, 'REGIDOR', 580, 4),
(195, 'RIO VIEJO', 600, 4),
(196, 'SAN CRISTOBAL', 620, 4),
(197, 'SAN ESTANISLAO', 647, 4),
(198, 'SAN FERNANDO', 650, 4),
(199, 'SAN JACINTO', 654, 4),
(200, 'SAN JACINTO DEL CAUCA', 655, 4),
(201, 'SAN JUAN NEPOMUCENO', 657, 4),
(202, 'SAN MARTIN DE LOBA', 667, 4),
(203, 'SAN PABLO', 670, 4),
(204, 'SANTA CATALINA', 673, 4),
(205, 'SANTA ROSA', 683, 4),
(206, 'SANTA ROSA DEL SUR', 688, 4),
(207, 'SIMITI', 744, 4),
(208, 'SOPLAVIENTO', 760, 4),
(209, 'TALAIGUA NUEVO', 780, 4),
(210, 'TIQUISIO (PUERTO RICO)', 810, 4),
(211, 'TURBACO', 836, 4),
(212, 'TURBANA', 838, 4),
(213, 'VILLANUEVA', 873, 4),
(214, 'ZAMBRANO', 894, 4),
(215, 'TUNJA', 1, 5),
(216, 'ALMEIDA', 22, 5),
(217, 'AQUITANIA', 47, 5),
(218, 'ARCABUCO', 51, 5),
(219, 'BELEN', 87, 5),
(220, 'BERBEO', 90, 5),
(221, 'BETEITIVA', 92, 5),
(222, 'BOAVITA', 97, 5),
(223, 'BOYACA', 104, 5),
(224, 'BRICEÑO', 106, 5),
(225, 'BUENAVISTA', 109, 5),
(226, 'BUSBANZA', 114, 5),
(227, 'CALDAS', 131, 5),
(228, 'CAMPOHERMOSO', 135, 5),
(229, 'CERINZA', 162, 5),
(230, 'CHINAVITA', 172, 5),
(231, 'CHIQUINQUIRA', 176, 5),
(232, 'CHISCAS', 180, 5),
(233, 'CHITA', 183, 5),
(234, 'CHITARAQUE', 185, 5),
(235, 'CHIVATA', 187, 5),
(236, 'CIENEGA', 189, 5),
(237, 'COMBITA', 204, 5),
(238, 'COPER', 212, 5),
(239, 'CORRALES', 215, 5),
(240, 'COVARACHIA', 218, 5),
(241, 'CUBARA', 223, 5),
(242, 'CUCAITA', 224, 5),
(243, 'CUITIVA', 226, 5),
(244, 'CHIQUIZA', 232, 5),
(245, 'CHIVOR', 236, 5),
(246, 'DUITAMA', 238, 5),
(247, 'EL COCUY', 244, 5),
(248, 'EL ESPINO', 248, 5),
(249, 'FIRAVITOBA', 272, 5),
(250, 'FLORESTA', 276, 5),
(251, 'GACHANTIVA', 293, 5),
(252, 'GAMEZA', 296, 5),
(253, 'GARAGOA', 299, 5),
(254, 'GUACAMAYAS', 317, 5),
(255, 'GUATEQUE', 322, 5),
(256, 'GUAYATA', 325, 5),
(257, 'GUICAN', 332, 5),
(258, 'IZA', 362, 5),
(259, 'JENESANO', 367, 5),
(260, 'JERICO', 368, 5),
(261, 'LABRANZAGRANDE', 377, 5),
(262, 'LA CAPILLA', 380, 5),
(263, 'LA VICTORIA', 401, 5),
(264, 'LA UVITA', 403, 5),
(265, 'VILLA DE LEIVA', 407, 5),
(266, 'MACANAL', 425, 5),
(267, 'MARIPI', 442, 5),
(268, 'MIRAFLORES', 455, 5),
(269, 'MONGUA', 464, 5),
(270, 'MONGUI', 466, 5),
(271, 'MONIQUIRA', 469, 5),
(272, 'MOTAVITA', 476, 5),
(273, 'MUZO', 480, 5),
(274, 'NOBSA', 491, 5),
(275, 'NUEVO COLON', 494, 5),
(276, 'OICATA', 500, 5),
(277, 'OTANCHE', 507, 5),
(278, 'PACHAVITA', 511, 5),
(279, 'PAEZ', 514, 5),
(280, 'PAIPA', 516, 5),
(281, 'PAJARITO', 518, 5),
(282, 'PANQUEBA', 522, 5),
(283, 'PAUNA', 531, 5),
(284, 'PAYA', 533, 5),
(285, 'PAZ DEL RIO', 537, 5),
(286, 'PESCA', 542, 5),
(287, 'PISBA', 550, 5),
(288, 'PUERTO BOYACA', 572, 5),
(289, 'QUIPAMA', 580, 5),
(290, 'RAMIRIQUI', 599, 5),
(291, 'RAQUIRA', 600, 5),
(292, 'RONDON', 621, 5),
(293, 'SABOYA', 632, 5),
(294, 'SACHICA', 638, 5),
(295, 'SAMACA', 646, 5),
(296, 'SAN EDUARDO', 660, 5),
(297, 'SAN JOSE DE PARE', 664, 5),
(298, 'SAN LUIS DE GACENO', 667, 5),
(299, 'SAN MATEO', 673, 5),
(300, 'SAN MIGUEL DE SEMA', 676, 5),
(301, 'SAN PABLO DE BORBUR', 681, 5),
(302, 'SANTANA', 686, 5),
(303, 'SANTA MARIA', 690, 5),
(304, 'SANTA ROSA DE VITERBO', 693, 5),
(305, 'SANTA SOFIA', 696, 5),
(306, 'SATIVANORTE', 720, 5),
(307, 'SATIVASUR', 723, 5),
(308, 'SIACHOQUE', 740, 5),
(309, 'SOATA', 753, 5),
(310, 'SOCOTA', 755, 5),
(311, 'SOCHA', 757, 5),
(312, 'SOGAMOSO', 759, 5),
(313, 'SOMONDOCO', 761, 5),
(314, 'SORA', 762, 5),
(315, 'SOTAQUIRA', 763, 5),
(316, 'SORACA', 764, 5),
(317, 'SUSACON', 774, 5),
(318, 'SUTAMARCHAN', 776, 5),
(319, 'SUTATENZA', 778, 5),
(320, 'TASCO', 790, 5),
(321, 'TENZA', 798, 5),
(322, 'TIBANA', 804, 5),
(323, 'TIBASOSA', 806, 5),
(324, 'TINJACA', 808, 5),
(325, 'TIPACOQUE', 810, 5),
(326, 'TOCA', 814, 5),
(327, 'TOGUI', 816, 5),
(328, 'TOPAGA', 820, 5),
(329, 'TOTA', 822, 5),
(330, 'TUNUNGUA', 832, 5),
(331, 'TURMEQUE', 835, 5),
(332, 'TUTA', 837, 5),
(333, 'TUTASA', 839, 5),
(334, 'UMBITA', 842, 5),
(335, 'VENTAQUEMADA', 861, 5),
(336, 'VIRACACHA', 879, 5),
(337, 'ZETAQUIRA', 897, 5),
(338, 'MANIZALES', 1, 6),
(339, 'AGUADAS', 13, 6),
(340, 'ANSERMA', 42, 6),
(341, 'ARANZAZU', 50, 6),
(342, 'BELALCAZAR', 88, 6),
(343, 'CHINCHINA', 174, 6),
(344, 'FILADELFIA', 272, 6),
(345, 'LA DORADA', 380, 6),
(346, 'LA MERCED', 388, 6),
(347, 'MANZANARES', 433, 6),
(348, 'MARMATO', 442, 6),
(349, 'MARQUETALIA', 444, 6),
(350, 'MARULANDA', 446, 6),
(351, 'NEIRA', 486, 6),
(352, 'NORCASIA', 495, 6),
(353, 'PACORA', 513, 6),
(354, 'PALESTINA', 524, 6),
(355, 'PENSILVANIA', 541, 6),
(356, 'RIOSUCIO', 614, 6),
(357, 'RISARALDA', 616, 6),
(358, 'SALAMINA', 653, 6),
(359, 'SAMANA', 662, 6),
(360, 'SAN JOSE', 665, 6),
(361, 'SUPIA', 777, 6),
(362, 'VICTORIA', 867, 6),
(363, 'VILLAMARIA', 873, 6),
(364, 'VITERBO', 877, 6),
(365, 'FLORENCIA', 1, 7),
(366, 'ALBANIA', 29, 7),
(367, 'BELEN DE LOS ANDAQUIES', 94, 7),
(368, 'CARTAGENA DEL CHAIRA', 150, 7),
(369, 'CURILLO', 205, 7),
(370, 'EL DONCELLO', 247, 7),
(371, 'EL PAUJIL', 256, 7),
(372, 'LA MONTAÑITA', 410, 7),
(373, 'MILAN', 460, 7),
(374, 'MORELIA', 479, 7),
(375, 'PUERTO RICO', 592, 7),
(376, 'SAN JOSE DE FRAGUA', 610, 7),
(377, 'SAN VICENTE DEL CAGUAN', 753, 7),
(378, 'SOLANO', 756, 7),
(379, 'SOLITA', 785, 7),
(380, 'VALPARAISO', 860, 7),
(381, 'POPAYAN', 1, 8),
(382, 'ALMAGUER', 22, 8),
(383, 'ARGELIA', 50, 8),
(384, 'BALBOA', 75, 8),
(385, 'BOLIVAR', 100, 8),
(386, 'BUENOS AIRES', 110, 8),
(387, 'CAJIBIO', 130, 8),
(388, 'CALDONO', 137, 8),
(389, 'CALOTO', 142, 8),
(390, 'CORINTO', 212, 8),
(391, 'EL TAMBO', 256, 8),
(392, 'FLORENCIA', 290, 8),
(393, 'GUAPI', 318, 8),
(394, 'INZA', 355, 8),
(395, 'JAMBALO', 364, 8),
(396, 'LA SIERRA', 392, 8),
(397, 'LA VEGA', 397, 8),
(398, 'LOPEZ (MICAY)', 418, 8),
(399, 'MERCADERES', 450, 8),
(400, 'MIRANDA', 455, 8),
(401, 'MORALES', 473, 8),
(402, 'PADILLA', 513, 8),
(403, 'PAEZ (BELALCAZAR)', 517, 8),
(404, 'PATIA (EL BORDO)', 532, 8),
(405, 'PIAMONTE', 533, 8),
(406, 'PIENDAMO', 548, 8),
(407, 'PUERTO TEJADA', 573, 8),
(408, 'PURACE (COCONUCO)', 585, 8),
(409, 'ROSAS', 622, 8),
(410, 'SAN SEBASTIAN', 693, 8),
(411, 'SANTANDER DE QUILICHAO', 698, 8),
(412, 'SANTA ROSA', 701, 8),
(413, 'SILVIA', 743, 8),
(414, 'SOTARA (PAISPAMBA)', 760, 8),
(415, 'SUAREZ', 780, 8),
(416, 'TIMBIO', 807, 8),
(417, 'TIMBIQUI', 809, 8),
(418, 'TORIBIO', 821, 8),
(419, 'TOTORO', 824, 8),
(420, 'VILLARICA', 845, 8),
(421, 'VALLEDUPAR', 1, 9),
(422, 'AGUACHICA', 11, 9),
(423, 'AGUSTIN CODAZZI', 13, 9),
(424, 'ASTREA', 32, 9),
(425, 'BECERRIL', 45, 9),
(426, 'BOSCONIA', 60, 9),
(427, 'CHIMICHAGUA', 175, 9),
(428, 'CHIRIGUANA', 178, 9),
(429, 'CURUMANI', 228, 9),
(430, 'EL COPEY', 238, 9),
(431, 'EL PASO', 250, 9),
(432, 'GAMARRA', 295, 9),
(433, 'GONZALEZ', 310, 9),
(434, 'LA GLORIA', 383, 9),
(435, 'LA JAGUA IBIRICO', 400, 9),
(436, 'MANAURE (BALCON DEL CESAR)', 443, 9),
(437, 'PAILITAS', 517, 9),
(438, 'PELAYA', 550, 9),
(439, 'PUEBLO BELLO', 570, 9),
(440, 'RIO DE ORO', 614, 9),
(441, 'LA PAZ (ROBLES)', 621, 9),
(442, 'SAN ALBERTO', 710, 9),
(443, 'SAN DIEGO', 750, 9),
(444, 'SAN MARTIN', 770, 9),
(445, 'TAMALAMEQUE', 787, 9),
(446, 'MONTERIA', 1, 10),
(447, 'AYAPEL', 68, 10),
(448, 'BUENAVISTA', 79, 10),
(449, 'CANALETE', 90, 10),
(450, 'CERETE', 162, 10),
(451, 'CHIMA', 168, 10),
(452, 'CHINU', 182, 10),
(453, 'CIENAGA DE ORO', 189, 10),
(454, 'COTORRA', 300, 10),
(455, 'LA APARTADA', 350, 10),
(456, 'LORICA', 417, 10),
(457, 'LOS CORDOBAS', 419, 10),
(458, 'MOMIL', 464, 10),
(459, 'MONTELIBANO', 466, 10),
(460, 'MOÑITOS', 500, 10),
(461, 'PLANETA RICA', 555, 10),
(462, 'PUEBLO NUEVO', 570, 10),
(463, 'PUERTO ESCONDIDO', 574, 10),
(464, 'PUERTO LIBERTADOR', 580, 10),
(465, 'PURISIMA', 586, 10),
(466, 'SAHAGUN', 660, 10),
(467, 'SAN ANDRES SOTAVENTO', 670, 10),
(468, 'SAN ANTERO', 672, 10),
(469, 'SAN BERNARDO DEL VIENTO', 675, 10),
(470, 'SAN CARLOS', 678, 10),
(471, 'SAN PELAYO', 686, 10),
(472, 'TIERRALTA', 807, 10),
(473, 'VALENCIA', 855, 10),
(474, 'AGUA DE DIOS', 1, 11),
(475, 'ALBAN', 19, 11),
(476, 'ANAPOIMA', 35, 11),
(477, 'ANOLAIMA', 40, 11),
(478, 'ARBELAEZ', 53, 11),
(479, 'BELTRAN', 86, 11),
(480, 'BITUIMA', 95, 11),
(481, 'BOJACA', 99, 11),
(482, 'CABRERA', 120, 11),
(483, 'CACHIPAY', 123, 11),
(484, 'CAJICA', 126, 11),
(485, 'CAPARRAPI', 148, 11),
(486, 'CAQUEZA', 151, 11),
(487, 'CARMEN DE CARUPA', 154, 11),
(488, 'CHAGUANI', 168, 11),
(489, 'CHIA', 175, 11),
(490, 'CHIPAQUE', 178, 11),
(491, 'CHOACHI', 181, 11),
(492, 'CHOCONTA', 183, 11),
(493, 'COGUA', 200, 11),
(494, 'COTA', 214, 11),
(495, 'CUCUNUBA', 224, 11),
(496, 'EL COLEGIO', 245, 11),
(497, 'EL PEÑON', 258, 11),
(498, 'EL ROSAL', 260, 11),
(499, 'FACATATIVA', 269, 11),
(500, 'FOMEQUE', 279, 11),
(501, 'FOSCA', 281, 11),
(502, 'FUNZA', 286, 11),
(503, 'FUQUENE', 288, 11),
(504, 'FUSAGASUGA', 290, 11),
(505, 'GACHALA', 293, 11),
(506, 'GACHANCIPA', 295, 11),
(507, 'GACHETA', 297, 11),
(508, 'GAMA', 299, 11),
(509, 'GIRARDOT', 307, 11),
(510, 'GRANADA', 312, 11),
(511, 'GUACHETA', 317, 11),
(512, 'GUADUAS', 320, 11),
(513, 'GUASCA', 322, 11),
(514, 'GUATAQUI', 324, 11),
(515, 'GUATAVITA', 326, 11),
(516, 'GUAYABAL DE SIQUIMA', 328, 11),
(517, 'GUAYABETAL', 335, 11),
(518, 'GUTIERREZ', 339, 11),
(519, 'JERUSALEN', 368, 11),
(520, 'JUNIN', 372, 11),
(521, 'LA CALERA', 377, 11),
(522, 'LA MESA', 386, 11),
(523, 'LA PALMA', 394, 11),
(524, 'LA PEÑA', 398, 11),
(525, 'LA VEGA', 402, 11),
(526, 'LENGUAZAQUE', 407, 11),
(527, 'MACHETA', 426, 11),
(528, 'MADRID', 430, 11),
(529, 'MANTA', 436, 11),
(530, 'MEDINA', 438, 11),
(531, 'MOSQUERA', 473, 11),
(532, 'NARIÑO', 483, 11),
(533, 'NEMOCON', 486, 11),
(534, 'NILO', 488, 11),
(535, 'NIMAIMA', 489, 11),
(536, 'NOCAIMA', 491, 11),
(537, 'VENECIA (OSPINA PEREZ)', 506, 11),
(538, 'PACHO', 513, 11),
(539, 'PAIME', 518, 11),
(540, 'PANDI', 524, 11),
(541, 'PARATEBUENO', 530, 11),
(542, 'PASCA', 535, 11),
(543, 'PUERTO SALGAR', 572, 11),
(544, 'PULI', 580, 11),
(545, 'QUEBRADANEGRA', 592, 11),
(546, 'QUETAME', 594, 11),
(547, 'QUIPILE', 596, 11),
(548, 'APULO (RAFAEL REYES)', 599, 11),
(549, 'RICAURTE', 612, 11),
(550, 'SAN ANTONIO DEL TEQUENDAMA', 645, 11),
(551, 'SAN BERNARDO', 649, 11),
(552, 'SAN CAYETANO', 653, 11),
(553, 'SAN FRANCISCO', 658, 11),
(554, 'SAN JUAN DE RIOSECO', 662, 11),
(555, 'SASAIMA', 718, 11),
(556, 'SESQUILE', 736, 11),
(557, 'SIBATE', 740, 11),
(558, 'SILVANIA', 743, 11),
(559, 'SIMIJACA', 745, 11),
(560, 'SOACHA', 754, 11),
(561, 'SOPO', 758, 11),
(562, 'SUBACHOQUE', 769, 11),
(563, 'SUESCA', 772, 11),
(564, 'SUPATA', 777, 11),
(565, 'SUSA', 779, 11),
(566, 'SUTATAUSA', 781, 11),
(567, 'TABIO', 785, 11),
(568, 'TAUSA', 793, 11),
(569, 'TENA', 797, 11),
(570, 'TENJO', 799, 11),
(571, 'TIBACUY', 805, 11),
(572, 'TIBIRITA', 807, 11),
(573, 'TOCAIMA', 815, 11),
(574, 'TOCANCIPA', 817, 11),
(575, 'TOPAIPI', 823, 11),
(576, 'UBALA', 839, 11),
(577, 'UBAQUE', 841, 11),
(578, 'UBATE', 843, 11),
(579, 'UNE', 845, 11),
(580, 'UTICA', 851, 11),
(581, 'VERGARA', 862, 11),
(582, 'VIANI', 867, 11),
(583, 'VILLAGOMEZ', 871, 11),
(584, 'VILLAPINZON', 873, 11),
(585, 'VILLETA', 875, 11),
(586, 'VIOTA', 878, 11),
(587, 'YACOPI', 885, 11),
(588, 'ZIPACON', 898, 11),
(589, 'ZIPAQUIRA', 899, 11),
(590, 'QUIBDO (SAN FRANCISCO DE QUIBDO)', 1, 12),
(591, 'ACANDI', 6, 12),
(592, 'ALTO BAUDO (PIE DE PATO)', 25, 12),
(593, 'ATRATO', 50, 12),
(594, 'BAGADO', 73, 12),
(595, 'BAHIA SOLANO (MUTIS)', 75, 12),
(596, 'BAJO BAUDO (PIZARRO)', 77, 12),
(597, 'BOJAYA (BELLAVISTA)', 99, 12),
(598, 'CANTON DE SAN PABLO (MANAGRU)', 135, 12),
(599, 'CONDOTO', 205, 12),
(600, 'EL CARMEN DE ATRATO', 245, 12),
(601, 'LITORAL DEL BAJO SAN JUAN (SANTA GENOVEVA DE DOCORDO)', 250, 12),
(602, 'ISTMINA', 361, 12),
(603, 'JURADO', 372, 12),
(604, 'LLORO', 413, 12),
(605, 'MEDIO ATRATO', 425, 12),
(606, 'MEDIO BAUDO', 430, 12),
(607, 'NOVITA', 491, 12),
(608, 'NUQUI', 495, 12),
(609, 'RIOQUITO', 600, 12),
(610, 'RIOSUCIO', 615, 12),
(611, 'SAN JOSE DEL PALMAR', 660, 12),
(612, 'SIPI', 745, 12),
(613, 'TADO', 787, 12),
(614, 'UNGUIA', 800, 12),
(615, 'UNION PANAMERICANA', 810, 12),
(616, 'NEIVA', 1, 13),
(617, 'ACEVEDO', 6, 13),
(618, 'AGRADO', 13, 13),
(619, 'AIPE', 16, 13),
(620, 'ALGECIRAS', 20, 13),
(621, 'ALTAMIRA', 26, 13),
(622, 'BARAYA', 78, 13),
(623, 'CAMPOALEGRE', 132, 13),
(624, 'COLOMBIA', 206, 13),
(625, 'ELIAS', 244, 13),
(626, 'GARZON', 298, 13),
(627, 'GIGANTE', 306, 13),
(628, 'GUADALUPE', 319, 13),
(629, 'HOBO', 349, 13),
(630, 'IQUIRA', 357, 13),
(631, 'ISNOS (SAN JOSE DE ISNOS)', 359, 13),
(632, 'LA ARGENTINA', 378, 13),
(633, 'LA PLATA', 396, 13),
(634, 'NATAGA', 483, 13),
(635, 'OPORAPA', 503, 13),
(636, 'PAICOL', 518, 13),
(637, 'PALERMO', 524, 13),
(638, 'PALESTINA', 530, 13),
(639, 'PITAL', 548, 13),
(640, 'PITALITO', 551, 13),
(641, 'RIVERA', 615, 13),
(642, 'SALADOBLANCO', 660, 13),
(643, 'SAN AGUSTIN', 668, 13),
(644, 'SANTA MARIA', 676, 13),
(645, 'SUAZA', 770, 13),
(646, 'TARQUI', 791, 13),
(647, 'TESALIA', 797, 13),
(648, 'TELLO', 799, 13),
(649, 'TERUEL', 801, 13),
(650, 'TIMANA', 807, 13),
(651, 'VILLAVIEJA', 872, 13),
(652, 'YAGUARA', 885, 13),
(653, 'RIOHACHA', 1, 14),
(654, 'BARRANCAS', 78, 14),
(655, 'DIBULLA', 90, 14),
(656, 'DISTRACCION', 98, 14),
(657, 'EL MOLINO', 110, 14),
(658, 'FONSECA', 279, 14),
(659, 'HATONUEVO', 378, 14),
(660, 'LA JAGUA DEL PILAR', 420, 14),
(661, 'MAICAO', 430, 14),
(662, 'MANAURE', 560, 14),
(663, 'SAN JUAN DEL CESAR', 650, 14),
(664, 'URIBIA', 847, 14),
(665, 'URUMITA', 855, 14),
(666, 'VILLANUEVA', 874, 14),
(667, 'SANTA MARTA (DISTRITO TURISTICO CULTURAL E HISTORICO DE SANTA MARTA)', 1, 15),
(668, 'ALGARROBO', 30, 15),
(669, 'ARACATACA', 53, 15),
(670, 'ARIGUANI (EL DIFICIL)', 58, 15),
(671, 'CERRO SAN ANTONIO', 161, 15),
(672, 'CHIVOLO', 170, 15),
(673, 'CIENAGA', 189, 15),
(674, 'CONCORDIA', 205, 15),
(675, 'EL BANCO', 245, 15),
(676, 'EL PIÑON', 258, 15),
(677, 'EL RETEN', 268, 15),
(678, 'FUNDACION', 288, 15),
(679, 'GUAMAL', 318, 15),
(680, 'PEDRAZA', 541, 15),
(681, 'PIJIÑO DEL CARMEN (PIJIÑO)', 545, 15),
(682, 'PIVIJAY', 551, 15),
(683, 'PLATO', 555, 15),
(684, 'PUEBLOVIEJO', 570, 15),
(685, 'REMOLINO', 605, 15),
(686, 'SABANAS DE SAN ANGEL', 660, 15),
(687, 'SALAMINA', 675, 15),
(688, 'SAN SEBASTIAN DE BUENAVISTA', 692, 15),
(689, 'SAN ZENON', 703, 15),
(690, 'SANTA ANA', 707, 15),
(691, 'SITIONUEVO', 745, 15),
(692, 'TENERIFE', 798, 15),
(693, 'VILLAVICENCIO', 1, 16),
(694, 'ACACIAS', 6, 16),
(695, 'BARRANCA DE UPIA', 110, 16),
(696, 'CABUYARO', 124, 16),
(697, 'CASTILLA LA NUEVA', 150, 16),
(698, 'SAN LUIS DE CUBARRAL', 223, 16),
(699, 'CUMARAL', 226, 16),
(700, 'EL CALVARIO', 245, 16),
(701, 'EL CASTILLO', 251, 16),
(702, 'EL DORADO', 270, 16),
(703, 'FUENTE DE ORO', 287, 16),
(704, 'GRANADA', 313, 16),
(705, 'GUAMAL', 318, 16),
(706, 'MAPIRIPAN', 325, 16),
(707, 'MESETAS', 330, 16),
(708, 'LA MACARENA', 350, 16),
(709, 'LA URIBE', 370, 16),
(710, 'LEJANIAS', 400, 16),
(711, 'PUERTO CONCORDIA', 450, 16),
(712, 'PUERTO GAITAN', 568, 16),
(713, 'PUERTO LOPEZ', 573, 16),
(714, 'PUERTO LLERAS', 577, 16),
(715, 'PUERTO RICO', 590, 16),
(716, 'RESTREPO', 606, 16),
(717, 'SAN CARLOS DE GUAROA', 680, 16),
(718, 'SAN JUAN DE ARAMA', 683, 16),
(719, 'SAN JUANITO', 686, 16),
(720, 'SAN MARTIN', 689, 16),
(721, 'VISTAHERMOSA', 711, 16),
(722, 'PASTO (SAN JUAN DE PASTO)', 1, 17),
(723, 'ALBAN (SAN JOSE)', 19, 17),
(724, 'ALDANA', 22, 17),
(725, 'ANCUYA', 36, 17),
(726, 'ARBOLEDA (BERRUECOS)', 51, 17),
(727, 'BARBACOAS', 79, 17),
(728, 'BELEN', 83, 17),
(729, 'BUESACO', 110, 17),
(730, 'COLON (GENOVA)', 203, 17),
(731, 'CONSACA', 207, 17),
(732, 'CONTADERO', 210, 17),
(733, 'CORDOBA', 215, 17),
(734, 'CUASPUD (CARLOSAMA)', 224, 17),
(735, 'CUMBAL', 227, 17),
(736, 'CUMBITARA', 233, 17),
(737, 'CHACHAGUI', 240, 17),
(738, 'EL CHARCO', 250, 17),
(739, 'EL PEÑOL', 254, 17),
(740, 'EL ROSARIO', 256, 17),
(741, 'EL TABLON', 258, 17),
(742, 'EL TAMBO', 260, 17),
(743, 'FUNES', 287, 17),
(744, 'GUACHUCAL', 317, 17),
(745, 'GUAITARILLA', 320, 17),
(746, 'GUALMATAN', 323, 17),
(747, 'ILES', 352, 17),
(748, 'IMUES', 354, 17),
(749, 'IPIALES', 356, 17),
(750, 'LA CRUZ', 378, 17),
(751, 'LA FLORIDA', 381, 17),
(752, 'LA LLANADA', 385, 17),
(753, 'LA TOLA', 390, 17),
(754, 'LA UNION', 399, 17),
(755, 'LEIVA', 405, 17),
(756, 'LINARES', 411, 17),
(757, 'LOS ANDES (SOTOMAYOR)', 418, 17),
(758, 'MAGUI (PAYAN)', 427, 17),
(759, 'MALLAMA (PIEDRANCHA)', 435, 17),
(760, 'MOSQUERA', 473, 17),
(761, 'OLAYA HERRERA (BOCAS DE SATINGA)', 490, 17),
(762, 'OSPINA', 506, 17),
(763, 'FRANCISCO PIZARRO (SALAHONDA)', 520, 17),
(764, 'POLICARPA', 540, 17),
(765, 'POTOSI', 560, 17),
(766, 'PROVIDENCIA', 565, 17),
(767, 'PUERRES', 573, 17),
(768, 'PUPIALES', 585, 17),
(769, 'RICAURTE', 612, 17),
(770, 'ROBERTO PAYAN (SAN JOSE)', 621, 17),
(771, 'SAMANIEGO', 678, 17),
(772, 'SANDONA', 683, 17),
(773, 'SAN BERNARDO', 685, 17),
(774, 'SAN LORENZO', 687, 17),
(775, 'SAN PABLO', 693, 17),
(776, 'SAN PEDRO DE CARTAGO', 694, 17),
(777, 'SANTA BARBARA (ISCUANDE)', 696, 17),
(778, 'SANTA CRUZ (GUACHAVES)', 699, 17),
(779, 'SAPUYES', 720, 17),
(780, 'TAMINANGO', 786, 17),
(781, 'TANGUA', 788, 17),
(782, 'TUMACO', 835, 17),
(783, 'TUQUERRES', 838, 17),
(784, 'YACUANQUER', 885, 17),
(785, 'CUCUTA', 1, 18),
(786, 'ABREGO', 3, 18),
(787, 'ARBOLEDAS', 51, 18),
(788, 'BOCHALEMA', 99, 18),
(789, 'BUCARASICA', 109, 18),
(790, 'CACOTA', 125, 18),
(791, 'CACHIRA', 128, 18),
(792, 'CHINACOTA', 172, 18),
(793, 'CHITAGA', 174, 18),
(794, 'CONVENCION', 206, 18),
(795, 'CUCUTILLA', 223, 18),
(796, 'DURANIA', 239, 18),
(797, 'EL CARMEN', 245, 18),
(798, 'EL TARRA', 250, 18),
(799, 'EL ZULIA', 261, 18),
(800, 'GRAMALOTE', 313, 18),
(801, 'HACARI', 344, 18),
(802, 'HERRAN', 347, 18),
(803, 'LABATECA', 377, 18),
(804, 'LA ESPERANZA', 385, 18),
(805, 'LA PLAYA', 398, 18),
(806, 'LOS PATIOS', 405, 18),
(807, 'LOURDES', 418, 18),
(808, 'MUTISCUA', 480, 18),
(809, 'OCAÑA', 498, 18),
(810, 'PAMPLONA', 518, 18),
(811, 'PAMPLONITA', 520, 18),
(812, 'PUERTO SANTANDER', 553, 18),
(813, 'RAGONVALIA', 599, 18),
(814, 'SALAZAR', 660, 18),
(815, 'SAN CALIXTO', 670, 18),
(816, 'SAN CAYETANO', 673, 18),
(817, 'SANTIAGO', 680, 18),
(818, 'SARDINATA', 720, 18),
(819, 'SILOS', 743, 18),
(820, 'TEORAMA', 800, 18),
(821, 'TIBU', 810, 18),
(822, 'TOLEDO', 820, 18),
(823, 'VILLACARO', 871, 18),
(824, 'VILLA DEL ROSARIO', 874, 18),
(825, 'ARMENIA', 1, 19),
(826, 'BUENAVISTA', 111, 19),
(827, 'CALARCA', 130, 19),
(828, 'CIRCASIA', 190, 19),
(829, 'CORDOBA', 212, 19),
(830, 'FILANDIA', 272, 19),
(831, 'GENOVA', 302, 19),
(832, 'LA TEBAIDA', 401, 19),
(833, 'MONTENEGRO', 470, 19),
(834, 'PIJAO', 548, 19),
(835, 'QUIMBAYA', 594, 19),
(836, 'SALENTO', 690, 19),
(837, 'PEREIRA', 1, 20),
(838, 'APIA', 45, 20),
(839, 'BALBOA', 75, 20),
(840, 'BELEN DE UMBRIA', 88, 20),
(841, 'DOS QUEBRADAS', 170, 20),
(842, 'GUATICA', 318, 20),
(843, 'LA CELIA', 383, 20),
(844, 'LA VIRGINIA', 400, 20),
(845, 'MARSELLA', 440, 20),
(846, 'MISTRATO', 456, 20),
(847, 'PUEBLO RICO', 572, 20),
(848, 'QUINCHIA', 594, 20),
(849, 'SANTA ROSA DE CABAL', 682, 20),
(850, 'SANTUARIO', 687, 20),
(851, 'BUCARAMANGA', 1, 21),
(852, 'AGUADA', 13, 21),
(853, 'ALBANIA', 20, 21),
(854, 'ARATOCA', 51, 21),
(855, 'BARBOSA', 77, 21),
(856, 'BARICHARA', 79, 21),
(857, 'BARRANCABERMEJA', 81, 21),
(858, 'BETULIA', 92, 21),
(859, 'BOLIVAR', 101, 21),
(860, 'CABRERA', 121, 21),
(861, 'CALIFORNIA', 132, 21),
(862, 'CAPITANEJO', 147, 21),
(863, 'CARCASI', 152, 21),
(864, 'CEPITA', 160, 21),
(865, 'CERRITO', 162, 21),
(866, 'CHARALA', 167, 21),
(867, 'CHARTA', 169, 21),
(868, 'CHIMA', 176, 21),
(869, 'CHIPATA', 179, 21),
(870, 'CIMITARRA', 190, 21),
(871, 'CONCEPCION', 207, 21),
(872, 'CONFINES', 209, 21),
(873, 'CONTRATACION', 211, 21),
(874, 'COROMORO', 217, 21),
(875, 'CURITI', 229, 21),
(876, 'EL CARMEN DE CHUCURY', 235, 21),
(877, 'EL GUACAMAYO', 245, 21),
(878, 'EL PEÑON', 250, 21),
(879, 'EL PLAYON', 255, 21),
(880, 'ENCINO', 264, 21),
(881, 'ENCISO', 266, 21),
(882, 'FLORIAN', 271, 21),
(883, 'FLORIDABLANCA', 276, 21),
(884, 'GALAN', 296, 21),
(885, 'GAMBITA', 298, 21),
(886, 'GIRON', 307, 21),
(887, 'GUACA', 318, 21),
(888, 'GUADALUPE', 320, 21),
(889, 'GUAPOTA', 322, 21),
(890, 'GUAVATA', 324, 21),
(891, 'GUEPSA', 327, 21),
(892, 'HATO', 344, 21),
(893, 'JESUS MARIA', 368, 21),
(894, 'JORDAN', 370, 21),
(895, 'LA BELLEZA', 377, 21),
(896, 'LANDAZURI', 385, 21),
(897, 'LA PAZ', 397, 21),
(898, 'LEBRIJA', 406, 21),
(899, 'LOS SANTOS', 418, 21),
(900, 'MACARAVITA', 425, 21),
(901, 'MALAGA', 432, 21),
(902, 'MATANZA', 444, 21),
(903, 'MOGOTES', 464, 21),
(904, 'MOLAGAVITA', 468, 21),
(905, 'OCAMONTE', 498, 21),
(906, 'OIBA', 500, 21),
(907, 'ONZAGA', 502, 21),
(908, 'PALMAR', 522, 21),
(909, 'PALMAS DEL SOCORRO', 524, 21),
(910, 'PARAMO', 533, 21),
(911, 'PIEDECUESTA', 547, 21),
(912, 'PINCHOTE', 549, 21),
(913, 'PUENTE NACIONAL', 572, 21),
(914, 'PUERTO PARRA', 573, 21),
(915, 'PUERTO WILCHES', 575, 21),
(916, 'RIONEGRO', 615, 21),
(917, 'SABANA DE TORRES', 655, 21),
(918, 'SAN ANDRES', 669, 21),
(919, 'SAN BENITO', 673, 21),
(920, 'SAN GIL', 679, 21),
(921, 'SAN JOAQUIN', 682, 21),
(922, 'SAN JOSE DE MIRANDA', 684, 21),
(923, 'SAN MIGUEL', 686, 21),
(924, 'SAN VICENTE DE CHUCURI', 689, 21),
(925, 'SANTA BARBARA', 705, 21),
(926, 'SANTA HELENA DEL OPON', 720, 21),
(927, 'SIMACOTA', 745, 21),
(928, 'SOCORRO', 755, 21),
(929, 'SUAITA', 770, 21),
(930, 'SUCRE', 773, 21),
(931, 'SURATA', 780, 21),
(932, 'TONA', 820, 21),
(933, 'VALLE SAN JOSE', 855, 21),
(934, 'VELEZ', 861, 21),
(935, 'VETAS', 867, 21),
(936, 'VILLANUEVA', 872, 21),
(937, 'ZAPATOCA', 895, 21),
(938, 'SINCELEJO', 1, 22),
(939, 'BUENAVISTA', 110, 22),
(940, 'CAIMITO', 124, 22),
(941, 'COLOSO (RICAURTE)', 204, 22),
(942, 'COROZAL', 215, 22),
(943, 'CHALAN', 230, 22),
(944, 'GALERAS (NUEVA GRANADA)', 235, 22),
(945, 'GUARANDA', 265, 22),
(946, 'LA UNION', 400, 22),
(947, 'LOS PALMITOS', 418, 22),
(948, 'MAJAGUAL', 429, 22),
(949, 'MORROA', 473, 22),
(950, 'OVEJAS', 508, 22),
(951, 'PALMITO', 523, 22),
(952, 'SAMPUES', 670, 22),
(953, 'SAN BENITO ABAD', 678, 22),
(954, 'SAN JUAN DE BETULIA', 702, 22),
(955, 'SAN MARCOS', 708, 22),
(956, 'SAN ONOFRE', 713, 22),
(957, 'SAN PEDRO', 717, 22),
(958, 'SINCE', 742, 22),
(959, 'SUCRE', 771, 22),
(960, 'TOLU', 820, 22),
(961, 'TOLUVIEJO', 823, 22),
(962, 'IBAGUE', 1, 23),
(963, 'ALPUJARRA', 24, 23),
(964, 'ALVARADO', 26, 23),
(965, 'AMBALEMA', 30, 23),
(966, 'ANZOATEGUI', 43, 23),
(967, 'ARMERO (GUAYABAL)', 55, 23),
(968, 'ATACO', 67, 23),
(969, 'CAJAMARCA', 124, 23),
(970, 'CARMEN APICALA', 148, 23),
(971, 'CASABIANCA', 152, 23),
(972, 'CHAPARRAL', 168, 23),
(973, 'COELLO', 200, 23),
(974, 'COYAIMA', 217, 23),
(975, 'CUNDAY', 226, 23),
(976, 'DOLORES', 236, 23),
(977, 'ESPINAL', 268, 23),
(978, 'FALAN', 270, 23),
(979, 'FLANDES', 275, 23),
(980, 'FRESNO', 283, 23),
(981, 'GUAMO', 319, 23),
(982, 'HERVEO', 347, 23),
(983, 'HONDA', 349, 23),
(984, 'ICONONZO', 352, 23),
(985, 'LERIDA', 408, 23),
(986, 'LIBANO', 411, 23),
(987, 'MARIQUITA', 443, 23),
(988, 'MELGAR', 449, 23),
(989, 'MURILLO', 461, 23),
(990, 'NATAGAIMA', 483, 23),
(991, 'ORTEGA', 504, 23),
(992, 'PALOCABILDO', 520, 23),
(993, 'PIEDRAS', 547, 23),
(994, 'PLANADAS', 555, 23),
(995, 'PRADO', 563, 23),
(996, 'PURIFICACION', 585, 23),
(997, 'RIOBLANCO', 616, 23),
(998, 'RONCESVALLES', 622, 23),
(999, 'ROVIRA', 624, 23),
(1000, 'SALDAÑA', 671, 23),
(1001, 'SAN ANTONIO', 675, 23),
(1002, 'SAN LUIS', 678, 23),
(1003, 'SANTA ISABEL', 686, 23),
(1004, 'SUAREZ', 770, 23),
(1005, 'VALLE DE SAN JUAN', 854, 23),
(1006, 'VENADILLO', 861, 23),
(1007, 'VILLAHERMOSA', 870, 23),
(1008, 'VILLARRICA', 873, 23),
(1009, 'CALI (SANTIAGO DE CALI)', 1, 24),
(1010, 'ALCALA', 20, 24),
(1011, 'ANDALUCIA', 36, 24),
(1012, 'ANSERMANUEVO', 41, 24),
(1013, 'ARGELIA', 54, 24),
(1014, 'BOLIVAR', 100, 24),
(1015, 'BUENAVENTURA', 109, 24),
(1016, 'BUGA', 111, 24),
(1017, 'BUGALAGRANDE', 113, 24),
(1018, 'CAICEDONIA', 122, 24),
(1019, 'CALIMA (DARIEN)', 126, 24),
(1020, 'CANDELARIA', 130, 24),
(1021, 'CARTAGO', 147, 24),
(1022, 'DAGUA', 233, 24),
(1023, 'EL AGUILA', 243, 24),
(1024, 'EL CAIRO', 246, 24),
(1025, 'EL CERRITO', 248, 24),
(1026, 'EL DOVIO', 250, 24),
(1027, 'FLORIDA', 275, 24),
(1028, 'GINEBRA', 306, 24),
(1029, 'GUACARI', 318, 24),
(1030, 'JAMUNDI', 364, 24),
(1031, 'LA CUMBRE', 377, 24),
(1032, 'LA UNION', 400, 24),
(1033, 'LA VICTORIA', 403, 24),
(1034, 'OBANDO', 497, 24),
(1035, 'PALMIRA', 520, 24),
(1036, 'PRADERA', 563, 24),
(1037, 'RESTREPO', 606, 24),
(1038, 'RIOFRIO', 616, 24),
(1039, 'ROLDANILLO', 622, 24),
(1040, 'SAN PEDRO', 670, 24),
(1041, 'SEVILLA', 736, 24),
(1042, 'TORO', 823, 24),
(1043, 'TRUJILLO', 828, 24),
(1044, 'TULUA', 834, 24),
(1045, 'ULLOA', 845, 24),
(1046, 'VERSALLES', 863, 24),
(1047, 'VIJES', 869, 24),
(1048, 'YOTOCO', 890, 24),
(1049, 'YUMBO', 892, 24),
(1050, 'ZARZAL', 895, 24),
(1051, 'ARAUCA', 1, 25),
(1052, 'ARAUQUITA', 65, 25),
(1053, 'CRAVO NORTE', 220, 25),
(1054, 'FORTUL', 300, 25),
(1055, 'PUERTO RONDON', 591, 25),
(1056, 'SARAVENA', 736, 25),
(1057, 'TAME', 794, 25),
(1058, 'YOPAL', 1, 26),
(1059, 'AGUAZUL', 10, 26),
(1060, 'CHAMEZA', 15, 26),
(1061, 'HATO COROZAL', 125, 26),
(1062, 'LA SALINA', 136, 26),
(1063, 'MANI', 139, 26),
(1064, 'MONTERREY', 162, 26),
(1065, 'NUNCHIA', 225, 26),
(1066, 'OROCUE', 230, 26),
(1067, 'PAZ DE ARIPORO', 250, 26),
(1068, 'PORE', 263, 26),
(1069, 'RECETOR', 279, 26),
(1070, 'SABANALARGA', 300, 26),
(1071, 'SACAMA', 315, 26),
(1072, 'SAN LUIS DE PALENQUE', 325, 26),
(1073, 'TAMARA', 400, 26),
(1074, 'TAURAMENA', 410, 26),
(1075, 'TRINIDAD', 430, 26),
(1076, 'VILLANUEVA', 440, 26),
(1077, 'MOCOA', 1, 27),
(1078, 'COLON', 219, 27),
(1079, 'ORITO', 320, 27),
(1080, 'PUERTO ASIS', 568, 27),
(1081, 'PUERTO CAICEDO', 569, 27),
(1082, 'PUERTO GUZMAN', 571, 27),
(1083, 'PUERTO LEGUIZAMO', 573, 27),
(1084, 'SIBUNDOY', 749, 27),
(1085, 'SAN FRANCISCO', 755, 27),
(1086, 'SAN MIGUEL (LA DORADA)', 757, 27),
(1087, 'SANTIAGO', 760, 27),
(1088, 'LA HORMIGA (VALLE DEL GUAMUEZ)', 865, 27),
(1089, 'VILLAGARZON', 885, 27),
(1090, 'SAN ANDRES', 1, 28),
(1091, 'PROVIDENCIA', 564, 28),
(1092, 'LETICIA', 1, 29),
(1093, 'EL ENCANTO', 263, 29),
(1094, 'LA CHORRERA', 405, 29),
(1095, 'LA PEDRERA', 407, 29),
(1096, 'LA VICTORIA', 430, 29),
(1097, 'MIRITI-PARANA', 460, 29),
(1098, 'PUERTO ALEGRIA', 530, 29),
(1099, 'PUERTO ARICA', 536, 29),
(1100, 'PUERTO NARIÑO', 540, 29),
(1101, 'PUERTO SANTANDER', 669, 29),
(1102, 'TARAPACA', 798, 29),
(1103, 'PUERTO INIRIDA', 1, 30),
(1104, 'BARRANCO MINAS', 343, 30),
(1105, 'SAN FELIPE', 883, 30),
(1106, 'PUERTO COLOMBIA', 884, 30),
(1107, 'LA GUADALUPE', 885, 30),
(1108, 'CACAHUAL', 886, 30),
(1109, 'PANA PANA (CAMPO ALEGRE)', 887, 30),
(1110, 'MORICHAL (MORICHAL NUEVO)', 888, 30),
(1111, 'SAN JOSE DEL GUAVIARE', 1, 31),
(1112, 'CALAMAR', 15, 31),
(1113, 'EL RETORNO', 25, 31),
(1114, 'MIRAFLORES', 200, 31),
(1115, 'MITU', 1, 32),
(1116, 'CARURU', 161, 32),
(1117, 'PACOA', 511, 32),
(1118, 'TARAIRA', 666, 32),
(1119, 'PAPUNAUA (MORICHAL)', 777, 32),
(1120, 'YAVARATE', 889, 32),
(1121, 'PUERTO CARREÑO', 1, 33),
(1122, 'LA PRIMAVERA', 524, 33),
(1123, 'SANTA RITA', 572, 33),
(1124, 'SANTA ROSALIA', 666, 33),
(1125, 'SAN JOSE DE OCUNE', 760, 33),
(1126, 'CUMARIBO', 773, 33);

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
(1, 'Novedad 1', 'Yalfjalkfj', 'https://www.youtube.com/', 11, 1, 1, 1, '2019-05-23 21:15:26', '2019-05-23 21:15:26'),
(2, 'Novedad 2', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'https://www.mercadolibre.com.co/', 11, 1, 1, 1, '2019-05-23 21:35:21', '2019-05-23 21:35:21'),
(3, 'Novedad 3', 'Yalfjalkfj', 'https://www.youtube.com/', 11, 1, 1, 1, '2019-05-23 21:15:26', '2019-05-23 21:15:26'),
(5, 'Novedad 5', 'Yalfjalkfj', 'https://www.youtube.com/', 11, 1, 1, 1, '2019-05-23 21:15:26', '2019-05-23 21:15:26'),
(7, 'Novedad 7', 'Yalfjalkfj', 'https://www.youtube.com/', 11, 1, 1, 1, '2019-05-23 21:15:26', '2019-05-23 21:15:26'),
(8, 'Novedad 8', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'https://www.mercadolibre.com.co/', 11, 1, 1, 1, '2019-05-23 21:35:21', '2019-05-23 21:35:21'),
(9, 'Novedad 9', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'https://www.mercadolibre.com.co/', 11, 1, 1, 1, '2019-05-23 21:35:21', '2019-05-23 21:35:21'),
(10, 'Novedad 10', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'https://www.mercadolibre.com.co/', 11, 1, 1, 1, '2019-05-23 21:35:21', '2019-05-23 21:35:21');

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
  `autoreteica` tinyint(1) DEFAULT NULL,
  `id_banco` int(11) DEFAULT NULL,
  `num_cuenta_banco` int(11) DEFAULT NULL,
  `tipo_cuenta` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `representante_cuenta` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_nacionalidad` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `departamento` int(11) NOT NULL,
  `municipio` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`id`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono1`, `telefono2`, `celular`, `email`, `email2`, `created_at`, `updated_at`, `regimen`, `representante`, `sexo`, `fec_nac`, `reside`, `tipo_persona`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `digito_verif`, `entidad`, `num_verif`, `autoretenedor`, `declarante`, `cliente`, `proveedor`, `id_vendedor`, `id_zona`, `plazo_pago`, `bloquear`, `cupo_credito`, `retenedor_fuente`, `retenedor_iva`, `excluido_iva`, `autoretefuente`, `autoreteiva`, `autoreteica`, `id_banco`, `num_cuenta_banco`, `tipo_cuenta`, `representante_cuenta`, `tipo_nacionalidad`, `departamento`, `municipio`, `id_empresa`) VALUES
(1, 'Cristhiam', 'CEDULA', '1123201184', 'ccc', NULL, NULL, NULL, 'ccmonpan@hotmail.com', NULL, '2018-08-01 05:00:00', '2019-05-22 01:05:37', '', '', '', '0000-00-00', '', 'Natural', 'Cristhiam', 'Camilo', 'Monsalve', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', 0, 0, 1),
(2, 'Jessica Murcia', 'NIT', '33333', 'lllllll', '34444', NULL, NULL, 'cccc@jjjj.com', NULL, '2018-07-08 02:02:10', '2018-07-11 10:37:16', '', '', '', '0000-00-00', '', '', 'Jessica', '', 'Murcia', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', 0, 0, 1),
(3, 'Domenick', 'CE', '1123', 'kkkkk', '9999', NULL, NULL, 'cjcjc@ssss.com', NULL, '2018-07-08 12:20:52', '2018-07-11 10:37:10', '', '', '', '0000-00-00', '', '', '', '', '', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', 0, 0, 1),
(4, 'Provedor1', 'CC', '90088777', '87788', '32222', NULL, NULL, 'cccccc@jjj.com', NULL, '2018-07-09 23:07:14', '2018-07-11 10:36:52', '', '', '', '0000-00-00', '', '', '', '', '', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', 0, 0, 1),
(5, 'Rifas x', 'NIT', '908888', 'sdfosdfoi', '454545', NULL, NULL, 'lsdfskdjf@dsfdsf.xom', NULL, '2018-07-11 11:22:21', '2018-09-21 12:44:12', 'Comun', 'lsdfskdjf@dsfdsf.xom', 'Otro', '2018-07-01', 'asdfasdf ad fasd fasdf asf4', 'Juridica', NULL, NULL, NULL, NULL, 0, NULL, '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', 0, 0, 2),
(6, '\'\'', 'CC', '45998888', 'jflasdjf aljsd flajsdf l', '3495959', NULL, NULL, 'htm@hot.com', NULL, '2018-08-04 07:49:37', '2018-08-04 07:49:37', 'Comun', NULL, 'Femenino', NULL, 'asdfasdfadsf', 'Natural', 'Marlon', '', 'Monsalve', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', 0, 0, 2),
(7, NULL, 'CC', '3839', 'jkjk', '777', NULL, NULL, 'lues@gg.com', NULL, '2018-08-04 08:04:37', '2018-08-04 08:04:37', 'Comun', NULL, 'Masculino', NULL, 'dfsdfsdf', 'Natural', 'Luis', '', 'Monsalve', '', 0, '', '', 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', 0, 0, 1),
(8, 'Ismael', 'CC', '1085288369', 'barrio el jardin', '3203313824', NULL, NULL, 'fanfano312@hotmail.com', NULL, '2018-08-11 07:38:58', '2018-08-22 02:50:23', 'Simplificado', 'fanfano312@hotmail.com', 'Masculino', '1991-04-27', 'mocoa', 'Natural', 'ismael', NULL, 'cardenas', NULL, 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', 0, 0, 1),
(9, 'Fabian', 'CC', '123', '123', '123', NULL, NULL, 'sss', NULL, '2018-08-22 20:04:53', '2018-08-22 20:04:53', 'Simplificado', NULL, 'Femenino', '2001-04-18', 'xxxx', 'Natural', 'Oscar', 'Fabian', 'Franco', 'Pantoja', 0, '', '', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', 0, 0, 1),
(10, NULL, 'CC', '121212', NULL, NULL, NULL, NULL, NULL, NULL, '2018-08-31 01:51:06', '2019-05-20 22:05:43', 'Simplificado', NULL, 'Masculino', NULL, 'wwwww', 'Natural', 'Pepito', NULL, 'perez', NULL, 0, NULL, '', 2, 2, NULL, NULL, 2, 2, 13, 0, 1, 1, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, '0', 0, 0, 1),
(11, 'Evelin', 'CC', '1123314444', 'Lagos', NULL, NULL, NULL, 'bianeydiaz2013@gmail.com', NULL, '2019-05-20 22:12:06', '2019-08-06 02:21:59', '', NULL, '', NULL, '', '', NULL, NULL, NULL, NULL, 0, NULL, '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 0, 0, 1);

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
  `id_cuenta_cierre` int(11) DEFAULT NULL,
  `evitar_saldo_negativo` tinyint(1) NOT NULL,
  `id_tercero` int(11) DEFAULT NULL,
  `tipo_cuenta` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `plan_cuentas`
--

INSERT INTO `plan_cuentas` (`id`, `codigo`, `nombre`, `naturaleza`, `tipo`, `corriente`, `banco`, `diferido`, `tercero`, `niif`, `id_empresa`, `condicion`, `created_at`, `updated_at`, `anio`, `id_cuenta_cierre`, `evitar_saldo_negativo`, `id_tercero`, `tipo_cuenta`) VALUES
(1, '1', 'ACTIVOS', 'Debito', 'Titulo', 0, 0, 0, NULL, '1', 1, 1, NULL, '2019-06-26 02:17:58', 2018, 19, 0, 11, 'Cuenta compra'),
(2, '2', 'PASIVOS', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '2', 1, 1, '2018-06-16 20:43:36', '2018-06-16 20:43:36', 2018, NULL, 0, NULL, NULL),
(3, '3', 'PATRIMONIO', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '3', 1, 1, '2018-06-16 20:47:30', '2018-06-16 20:47:30', 2018, NULL, 0, NULL, NULL),
(4, '110505', 'CAJA GENERAL', 'Debito', 'Detalle', 0, 1, NULL, NULL, '110505', 1, 1, '2018-07-09 21:32:18', '2019-06-18 01:22:14', 2018, NULL, 0, NULL, 'Cuenta compra'),
(5, '11', 'DISPONIBLE', 'Debito', 'Titulo', 0, 0, NULL, NULL, '11', 1, 1, '2018-07-17 10:24:40', '2019-06-18 01:20:49', 2018, 1, 0, NULL, 'Cuenta compra'),
(6, '1105', 'CAJA', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1105', 1, 1, '2018-07-17 10:25:18', '2018-07-17 10:31:04', 2018, NULL, 0, NULL, NULL),
(8, '110515', 'CAJAS MENORES', 'Debito', 'Detalle', 1, 0, NULL, NULL, '110515', 1, 1, '2018-07-17 10:27:02', '2019-07-04 21:32:45', 2018, NULL, 0, NULL, 'Cuenta salida almacen'),
(9, '1110', 'BANCOS', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1110', 1, 1, '2018-07-17 10:28:08', '2019-07-04 21:30:31', 2018, NULL, 0, NULL, 'Cuenta salida almacen'),
(11, '111005', 'MONEDA NACIONAL - BANCOS', 'Debito', 'Detalle', 1, 1, NULL, NULL, '111005', 1, 1, '2018-07-17 10:29:49', '2018-08-30 00:06:54', 2018, NULL, 0, NULL, NULL),
(12, '1115', 'REMESAS EN TRANSITO', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1115', 1, 1, '2018-07-17 10:30:17', '2018-07-17 10:32:51', 2018, NULL, 0, NULL, NULL),
(13, '111505', 'MONEDA NACIONAL', 'Debito', 'Detalle', 1, 0, NULL, NULL, '111505', 1, 1, '2018-07-17 10:30:52', '2019-07-04 21:32:41', 2018, NULL, 0, NULL, 'Cuenta salida almacen'),
(14, '1120', 'CUENTAS DE AHORRO', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1120', 1, 1, '2018-07-17 10:33:44', '2018-07-17 10:33:44', 2018, NULL, 0, NULL, NULL),
(15, '112005', 'BANCOS', 'Debito', 'Detalle', 1, 0, NULL, NULL, '112005', 1, 1, '2018-07-17 10:34:41', '2018-07-17 10:34:41', 2018, NULL, 0, NULL, NULL),
(16, '12', 'INVERSIONES', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '12', 1, 1, '2018-07-17 10:38:46', '2018-07-17 10:38:46', 2018, NULL, 0, NULL, NULL),
(17, '5', 'GASTOS', 'Debito', 'Titulo', 0, 0, NULL, NULL, '5', 1, 1, '2018-08-29 23:58:50', '2018-08-29 23:58:50', 2018, NULL, 0, NULL, NULL),
(18, '51', 'OPERACIONES DE ADMINISTRACION', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '51', 1, 1, '2018-08-29 23:59:19', '2018-08-29 23:59:19', 2018, NULL, 0, NULL, NULL),
(19, '5110', 'HONORARIOS', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '5110', 1, 1, '2018-08-30 00:00:01', '2018-08-30 00:00:01', 2018, NULL, 0, NULL, NULL),
(20, '511095', 'OTROS HONORARIOS', 'Debito', 'Detalle', NULL, 0, NULL, NULL, '511095', 1, 1, '2018-08-30 00:00:49', '2018-08-30 00:00:49', 2018, NULL, 0, NULL, NULL),
(21, '23', 'CUENTAS POR PAGAR', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '23', 1, 1, '2018-08-30 00:20:37', '2018-08-30 00:20:37', 2018, NULL, 0, NULL, NULL),
(22, '2335', 'COSTOS Y GASTOS POR PAGAR', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '2335', 1, 1, '2018-08-30 00:21:11', '2018-08-30 00:21:11', 2018, NULL, 0, NULL, NULL),
(23, '233525', 'HONORARIOS', 'Credito', 'Detalle', NULL, 0, NULL, NULL, '233525', 1, 1, '2018-08-30 00:21:42', '2018-08-30 00:21:42', 2018, NULL, 0, NULL, NULL),
(24, '2365', 'RETENCION EN LA FUENTE', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '2365', 2, 1, '2018-08-30 00:22:35', '2018-08-30 00:22:35', 2018, NULL, 0, NULL, NULL),
(25, '236515', 'HONORARIOS (RTE FTE)', 'Credito', 'Detalle', NULL, 0, NULL, NULL, '236515', 2, 1, '2018-08-30 00:24:18', '2018-08-30 00:24:18', 2018, NULL, 0, NULL, NULL),
(26, '23652501', 'RETENCION EN SERVICIOS DECLARANTE', 'Credito', 'Detalle', NULL, 0, NULL, NULL, '23652501', 1, 1, '2019-05-15 05:42:36', '2019-05-15 05:42:36', 2019, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan_cuentas_categorias`
--

CREATE TABLE `plan_cuentas_categorias` (
  `id` int(11) NOT NULL,
  `id_plan_cuentas` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `usu_crea` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `plan_cuentas_categorias`
--

INSERT INTO `plan_cuentas_categorias` (`id`, `id_plan_cuentas`, `id_categoria`, `usu_crea`, `created_at`, `updated_at`) VALUES
(13, 1, 2, 1, '2019-06-26 02:17:58', '2019-06-26 02:17:58'),
(14, 1, 3, 1, '2019-06-26 02:17:58', '2019-06-26 02:17:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presentacion`
--

CREATE TABLE `presentacion` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `id_empresa` int(11) NOT NULL,
  `usu_crea` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_asociados`
--

CREATE TABLE `productos_asociados` (
  `id` int(11) NOT NULL,
  `id_presentacion` int(11) NOT NULL,
  `unidades` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `usu_crea` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_iva`
--

CREATE TABLE `productos_iva` (
  `id` int(11) NOT NULL,
  `id_iva` int(11) NOT NULL,
  `tipo_iva` varchar(50) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `usu_crea` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_tarifarios`
--

CREATE TABLE `productos_tarifarios` (
  `id` int(11) NOT NULL,
  `id_tarifario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `valor` int(11) NOT NULL,
  `asociado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(3, 'ACTIVOS INGRESO', 1, 'Debito', 0, 0, 1, 2, 4, 1, 1, 1, '2019-05-11 00:18:52', '2019-05-17 01:11:18'),
(4, 'ACTIVOS INGRESOnjkjknkj', 1, 'Debito', 0, 0, 1, 2, 4, 2, 1, 1, '2019-05-11 00:18:52', '2019-05-17 01:11:18');

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
(84, 'Rol 2', 2, 9, 1, '2019-05-02 18:15:26', '2019-05-02 19:44:10');

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
(309, 1, 16, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:26', '2019-07-26 22:04:26'),
(310, 1, 15, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:26', '2019-07-26 22:04:26'),
(311, 1, 21, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:26', '2019-07-26 22:04:26'),
(312, 1, 25, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:26', '2019-07-26 22:04:26'),
(313, 1, 20, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:26', '2019-07-26 22:04:26'),
(314, 1, 17, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(315, 1, 24, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(316, 1, 18, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(317, 1, 14, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(318, 1, 22, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(319, 1, 19, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(320, 1, 23, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(321, 1, 5, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(322, 1, 13, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(323, 1, 29, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(324, 1, 30, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(325, 1, 26, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(326, 1, 28, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(327, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(328, 1, 27, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(329, 1, 9, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(330, 1, 11, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(331, 1, 12, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(332, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(333, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(334, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(335, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(336, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(337, 1, 7, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27'),
(338, 1, 8, 1, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 22:04:27', '2019-07-26 22:04:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock`
--

CREATE TABLE `stock` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_producto` int(10) UNSIGNED NOT NULL,
  `id_facturacion` int(11) DEFAULT NULL,
  `id_usuario` int(10) UNSIGNED NOT NULL,
  `fec_crea` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cantidad` int(11) NOT NULL,
  `tipo_movimiento` int(11) NOT NULL,
  `sumatoria` double(15,2) NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `id_empresa` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `und_medidas`
--

CREATE TABLE `und_medidas` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `id_empresa` int(11) NOT NULL,
  `usu_crea` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
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
(1, 'cristhiam', '$2y$10$uINPVrLKmyXN4/5/0ScOJOVpxtPwUcBcxxQMBQdiI14KQbl6I/Bqu', 1, 1, 'ufKecV9OK8QYHzkCAM7kBpwiRFKBP7ez9lTODZbWaixNLaOxFTycI2aYgMk0', 1),
(9, 'fabian', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'DzQkQzGW65CdQbUwclj62zg3eLdMln0DkUnPfT2KM94bpVaYeWdIqzKLxeFh', 2),
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
(3, 'Zona 3', 'ksksksksks', 1, 1, 1, '2019-05-20 19:53:08', '2019-05-28 21:46:19'),
(4, 'Zona 2', NULL, 1, 2, 1, '2019-05-20 19:52:52', '2019-05-20 19:52:52');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `articulos_idcategoria_foreign` (`idcategoria`),
  ADD KEY `id_und_media` (`id_und_medida`),
  ADD KEY `id_concentracion` (`id_concentracion`),
  ADD KEY `id_presentacion` (`id_presentacion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `bancos`
--
ALTER TABLE `bancos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cajas`
--
ALTER TABLE `cajas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cajas_cierres`
--
ALTER TABLE `cajas_cierres`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `colaboradores`
--
ALTER TABLE `colaboradores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `concentraciones`
--
ALTER TABLE `concentraciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `conf_formatos`
--
ALTER TABLE `conf_formatos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `con_tarifarios`
--
ALTER TABLE `con_tarifarios`
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
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_egresos`
--
ALTER TABLE `detalle_egresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_ingresos_idingreso_foreign` (`idegreso`),
  ADD KEY `detalle_ingresos_idarticulo_foreign` (`idarticulo`);

--
-- Indices de la tabla `detalle_facturacion`
--
ALTER TABLE `detalle_facturacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_facturacion_id_factura_foreign` (`id_factura`),
  ADD KEY `detalle_facturacion_id_producto_foreign` (`id_producto`);

--
-- Indices de la tabla `detalle_ingresos`
--
ALTER TABLE `detalle_ingresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_ingresos_idingreso_foreign` (`idingreso`),
  ADD KEY `detalle_ingresos_idarticulo_foreign` (`idarticulo`);

--
-- Indices de la tabla `docs_formatos`
--
ALTER TABLE `docs_formatos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_formato` (`id_formato`);

--
-- Indices de la tabla `egresos`
--
ALTER TABLE `egresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ingresos_idproveedor_foreign` (`idproveedor`),
  ADD KEY `ingresos_idusuario_foreign` (`idusuario`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `evidencias_egresos`
--
ALTER TABLE `evidencias_egresos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `evidencias_ingresos`
--
ALTER TABLE `evidencias_ingresos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `facturacion`
--
ALTER TABLE `facturacion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `facturacion_num_factura_unique` (`num_factura`),
  ADD KEY `facturacion_id_tercero_foreign` (`id_tercero`),
  ADD KEY `facturacion_id_usuario_foreign` (`id_usuario`),
  ADD KEY `facturacion_usu_registra_foreign` (`usu_registra`),
  ADD KEY `facturacion_usu_envia_foreign` (`usu_envia`),
  ADD KEY `facturacion_usu_anula_foreign` (`usu_anula`);

--
-- Indices de la tabla `formatos`
--
ALTER TABLE `formatos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `formato` (`formato`),
  ADD KEY `tercero` (`tercero`),
  ADD KEY `usuario` (`usuario`);

--
-- Indices de la tabla `formatos_procesos`
--
ALTER TABLE `formatos_procesos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `informes_contables`
--
ALTER TABLE `informes_contables`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ingresos`
--
ALTER TABLE `ingresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ingresos_idproveedor_foreign` (`idproveedor`),
  ADD KEY `ingresos_idusuario_foreign` (`idusuario`);

--
-- Indices de la tabla `iva`
--
ALTER TABLE `iva`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `modelo_contable`
--
ALTER TABLE `modelo_contable`
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
-- Indices de la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departamento_id` (`id_departamento`);

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
-- Indices de la tabla `plan_cuentas_categorias`
--
ALTER TABLE `plan_cuentas_categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `presentacion`
--
ALTER TABLE `presentacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos_asociados`
--
ALTER TABLE `productos_asociados`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos_iva`
--
ALTER TABLE `productos_iva`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos_tarifarios`
--
ALTER TABLE `productos_tarifarios`
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
-- Indices de la tabla `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_id_producto_foreign` (`id_producto`),
  ADD KEY `stock_id_usuario_foreign` (`id_usuario`);

--
-- Indices de la tabla `und_medidas`
--
ALTER TABLE `und_medidas`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `bancos`
--
ALTER TABLE `bancos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cajas`
--
ALTER TABLE `cajas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cajas_cierres`
--
ALTER TABLE `cajas_cierres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `colaboradores`
--
ALTER TABLE `colaboradores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `concentraciones`
--
ALTER TABLE `concentraciones`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `conf_formatos`
--
ALTER TABLE `conf_formatos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `con_tarifarios`
--
ALTER TABLE `con_tarifarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `detalle_egresos`
--
ALTER TABLE `detalle_egresos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_facturacion`
--
ALTER TABLE `detalle_facturacion`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_ingresos`
--
ALTER TABLE `detalle_ingresos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `docs_formatos`
--
ALTER TABLE `docs_formatos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `egresos`
--
ALTER TABLE `egresos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `evidencias_egresos`
--
ALTER TABLE `evidencias_egresos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evidencias_ingresos`
--
ALTER TABLE `evidencias_ingresos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `facturacion`
--
ALTER TABLE `facturacion`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `formatos`
--
ALTER TABLE `formatos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT de la tabla `formatos_procesos`
--
ALTER TABLE `formatos_procesos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `informes_contables`
--
ALTER TABLE `informes_contables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ingresos`
--
ALTER TABLE `ingresos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `iva`
--
ALTER TABLE `iva`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `modelo_contable`
--
ALTER TABLE `modelo_contable`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `modulos_empresas`
--
ALTER TABLE `modulos_empresas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT de la tabla `modulos_empresas_usuarios`
--
ALTER TABLE `modulos_empresas_usuarios`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=757;

--
-- AUTO_INCREMENT de la tabla `municipios`
--
ALTER TABLE `municipios`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1127;

--
-- AUTO_INCREMENT de la tabla `novedades`
--
ALTER TABLE `novedades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
-- AUTO_INCREMENT de la tabla `plan_cuentas_categorias`
--
ALTER TABLE `plan_cuentas_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `presentacion`
--
ALTER TABLE `presentacion`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos_asociados`
--
ALTER TABLE `productos_asociados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos_iva`
--
ALTER TABLE `productos_iva`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos_tarifarios`
--
ALTER TABLE `productos_tarifarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `retenciones`
--
ALTER TABLE `retenciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT de la tabla `roles_permisos`
--
ALTER TABLE `roles_permisos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=339;

--
-- AUTO_INCREMENT de la tabla `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `und_medidas`
--
ALTER TABLE `und_medidas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `zona`
--
ALTER TABLE `zona`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
-- Filtros para la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD CONSTRAINT `municipios_ibfk_1` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id`);

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
