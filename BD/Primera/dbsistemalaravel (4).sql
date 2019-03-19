-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 04, 2019 at 08:54 PM
-- Server version: 10.1.29-MariaDB
-- PHP Version: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbsistemalaravel`
--

-- --------------------------------------------------------

--
-- Table structure for table `articulos`
--

CREATE TABLE `articulos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idcategoria` int(10) UNSIGNED NOT NULL,
  `codigo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `articulos`
--

INSERT INTO `articulos` (`id`, `idcategoria`, `codigo`, `nombre`, `precio_venta`, `stock`, `descripcion`, `condicion`, `created_at`, `updated_at`) VALUES
(1, 1, '123', 'xxxx', '2000.00', 20, 'xxxxxxxxx', 1, '2018-07-08 01:44:45', '2018-07-08 01:44:45'),
(2, 1, '234', 'Articulo1', '4000.00', 90, 'Art 1', 1, '2018-07-09 23:06:14', '2018-07-09 23:06:14');

-- --------------------------------------------------------

--
-- Table structure for table `categorias`
--

CREATE TABLE `categorias` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `condicion`, `created_at`, `updated_at`) VALUES
(1, 'dd', 'ddd', 1, '2018-05-30 03:38:16', '2018-05-30 03:38:16'),
(2, 'eee', 'www', 1, '2018-06-07 12:03:56', '2018-06-07 12:03:56'),
(3, 'sfdsf', 'ssss', 0, '2018-07-16 22:26:27', '2018-07-16 22:26:33');

-- --------------------------------------------------------

--
-- Table structure for table `conf_formatos`
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
  `nombre_formato` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `conf_formatos`
--

INSERT INTO `conf_formatos` (`id`, `tipo`, `retencion`, `no_inicio`, `cierre`, `acarreo`, `depreciacion`, `fiscal`, `niif`, `nombre_formato`, `condicion`, `created_at`, `updated_at`) VALUES
(1, 'Ingreso', 0, '00001', 0, 0, 0, 1, 0, 'Recibo de Caja', 1, NULL, NULL),
(2, 'Egreso', NULL, '0001', 0, 0, NULL, NULL, NULL, 'Comprobante de Egreso', 1, '2018-06-15 17:37:17', '2018-06-15 17:38:45'),
(3, 'Contables', 1, '0001', 1, 1, NULL, 1, NULL, 'Nota Contable', 1, '2018-07-26 02:58:24', '2018-07-26 02:58:24'),
(4, 'Cuentas', 1, '0001', 1, 1, NULL, 1, NULL, 'Cuentas x Pagar', 1, '2018-08-29 23:55:47', '2018-08-29 23:55:47');

-- --------------------------------------------------------

--
-- Table structure for table `cuentas`
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
-- Dumping data for table `cuentas`
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
(31, 29, '00005', 1, 0, 4000, NULL, NULL, 'iiiii', '2018-11-02', NULL, 1, 0, 1, '2018-11-02 21:39:53', '2018-11-02 21:39:53', 23, '233525', NULL, 4000);

-- --------------------------------------------------------

--
-- Table structure for table `detalle_ingresos`
--

CREATE TABLE `detalle_ingresos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idingreso` int(10) UNSIGNED NOT NULL,
  `idarticulo` int(10) UNSIGNED NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `detalle_ingresos`
--

INSERT INTO `detalle_ingresos` (`id`, `idingreso`, `idarticulo`, `cantidad`, `precio`) VALUES
(1, 1, 2, 2, '6000.00');

-- --------------------------------------------------------

--
-- Table structure for table `detalle_ventas`
--

CREATE TABLE `detalle_ventas` (
  `id` int(10) UNSIGNED NOT NULL,
  `idventa` int(10) UNSIGNED NOT NULL,
  `idarticulo` int(10) UNSIGNED NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `detalle_ventas`
--

INSERT INTO `detalle_ventas` (`id`, `idventa`, `idarticulo`, `cantidad`, `precio`, `descuento`) VALUES
(2, 2, 1, 1, '2000.00', '0.00');

-- --------------------------------------------------------

--
-- Table structure for table `docs_formatos`
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
-- Table structure for table `empresa`
--

CREATE TABLE `empresa` (
  `id` int(11) NOT NULL,
  `nom_compania` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(300) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_id` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `identificacion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `ciudad` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `departamento` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `rep_legal` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `empresa`
--

INSERT INTO `empresa` (`id`, `nom_compania`, `direccion`, `tipo_id`, `identificacion`, `ciudad`, `departamento`, `telefono`, `rep_legal`, `created_at`, `updated_at`) VALUES
(1, 'BASALTO INGENIERIA S.A.S', 'Nueva Vía Panamericana, Kilometro 12 - Buesaquillo Alto', 'NIT', '900760937 - 0', 'San Juan de Pasto', 'Nariño', '317 432 5562 - 320 331 3824 - 315 554 9508 - 322 503 9727', 'OSCAR FABIAN FRANCO PANTOJA', '2018-08-15 00:39:36', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `fab_cilindros`
--

CREATE TABLE `fab_cilindros` (
  `id` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `id_muestra` int(11) NOT NULL,
  `nom_cilindro` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `res_cilindro` double DEFAULT NULL,
  `dias` int(11) NOT NULL,
  `fecha_cilindro` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `condicion` int(11) NOT NULL DEFAULT '1',
  `nom_cilindro2` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `res_cilindro2` double DEFAULT NULL,
  `nom_cilindro3` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `res_cilindro3` double DEFAULT NULL,
  `nom_cilindro4` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `res_cilindro4` double DEFAULT NULL,
  `nom_cilindro5` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `res_cilindro5` double DEFAULT NULL,
  `nom_cilindro6` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `res_cilindro6` double DEFAULT NULL,
  `num_cilindros` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `fab_cilindros`
--

INSERT INTO `fab_cilindros` (`id`, `id_proyecto`, `id_muestra`, `nom_cilindro`, `res_cilindro`, `dias`, `fecha_cilindro`, `created_at`, `updated_at`, `condicion`, `nom_cilindro2`, `res_cilindro2`, `nom_cilindro3`, `res_cilindro3`, `nom_cilindro4`, `res_cilindro4`, `nom_cilindro5`, `res_cilindro5`, `nom_cilindro6`, `res_cilindro6`, `num_cilindros`) VALUES
(1, 3, 2, '1', 392.1, 7, '2018-05-18', '2018-08-10 01:04:12', '2018-08-10 06:04:12', 1, '2', 366.4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2),
(2, 3, 2, '3', 485.6, 14, '2018-05-25', '2018-08-10 01:04:16', '2018-08-10 06:04:16', 1, '4', 503.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2),
(3, 3, 2, '7', 506.2, 28, '2018-06-08', '2018-08-10 01:04:18', '2018-08-10 06:04:18', 1, '8', 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2),
(4, 3, 3, '12', 480, 7, '2018-05-18', '2018-08-11 00:55:24', '2018-08-11 05:55:24', 1, '13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2),
(5, 5, 12, '1', 345.76, 7, '2018-08-16', '2018-08-11 03:21:00', '2018-08-11 08:21:00', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(6, 5, 12, '2', 456.87, 28, '2018-09-06', '2018-08-11 03:21:03', '2018-08-11 08:21:03', 1, '3', 462.98, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2),
(7, 6, 13, 'cil1', 401, 28, '2018-08-22', '2018-09-13 21:05:36', '2018-09-13 21:05:36', 1, 'cil2', 400, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `fab_muestras`
--

CREATE TABLE `fab_muestras` (
  `id` int(11) NOT NULL,
  `num_muestra` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `leyenda` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `resist_dise` double NOT NULL,
  `diametro_cilindro` double NOT NULL,
  `fec_entra` date NOT NULL,
  `fec_muestra` date NOT NULL,
  `condicion` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_proyecto` int(11) NOT NULL,
  `medida_resistencia` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descripcion` varchar(500) COLLATE utf8_spanish_ci DEFAULT NULL,
  `por_fallar` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `fab_muestras`
--

INSERT INTO `fab_muestras` (`id`, `num_muestra`, `leyenda`, `resist_dise`, `diametro_cilindro`, `fec_entra`, `fec_muestra`, `condicion`, `created_at`, `updated_at`, `id_proyecto`, `medida_resistencia`, `descripcion`, `por_fallar`) VALUES
(2, '1', '1-6', 3500, 6, '2018-05-19', '2018-05-11', 1, '2018-08-03 07:09:09', '2018-08-03 12:09:09', 3, 'PSI', 'xxx', 0),
(3, '2', '9-14', 3500, 6, '2018-05-19', '2018-05-11', 1, '2018-08-11 01:57:37', '2018-08-11 06:57:37', 3, 'PSI', 'Torre c', 1),
(4, '3', '17-22', 3500, 6, '2018-05-19', '2018-05-12', 1, '2018-07-28 11:32:01', '2018-07-28 11:32:01', 3, 'PSI', NULL, 1),
(5, '4', '25-30', 3500, 6, '2018-05-19', '2018-05-12', 0, '2018-07-28 15:07:52', '2018-07-28 20:07:52', 3, 'PSI', NULL, 1),
(6, '5', '25-30', 3500, 6, '2018-05-19', '2018-05-12', 1, '2018-07-28 20:43:02', '2018-07-28 20:43:02', 3, 'PSI', NULL, 1),
(7, '6', '33-38', 3500, 6, '2018-05-26', '2018-05-19', 1, '2018-07-30 01:18:10', '2018-07-30 06:16:24', 3, 'PSI', NULL, 1),
(8, '7', '41-46', 3500, 6, '2018-05-26', '2018-05-21', 1, '2018-07-30 06:18:39', '2018-07-30 06:18:39', 3, 'PSI', NULL, 1),
(9, '8', '49-54', 3500, 6, '2018-05-26', '2018-05-22', 1, '2018-07-30 06:19:55', '2018-07-30 06:19:55', 3, 'PSI', NULL, 1),
(10, '1', '234', 400, 6, '2018-08-10', '2018-08-11', 0, '2018-08-11 03:11:29', '2018-08-11 08:11:29', 5, 'PSI', 'fasdfasdf', 1),
(11, '2', '234', 400, 6, '2018-08-10', '2018-08-11', 0, '2018-08-11 03:10:58', '2018-08-11 08:10:58', 5, 'PSI', 'fasdfasdf', 1),
(12, '3', '1-4', 4000, 6, '2018-08-10', '2018-08-09', 1, '2018-08-11 03:20:46', '2018-08-11 08:20:46', 5, 'PSI', 'CAISSON ESTRIBO SUR PUENTE AV COLOMBIA', 0),
(13, '1', 'muestra1', 3000, 6, '2018-08-01', '2018-07-25', 1, '2018-09-13 16:05:36', '2018-09-13 21:05:36', 6, 'PSI', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fab_proyectos`
--

CREATE TABLE `fab_proyectos` (
  `id` int(11) NOT NULL,
  `nom_proyecto` varchar(350) COLLATE utf8_spanish_ci NOT NULL,
  `cliente` int(11) NOT NULL,
  `condicion` int(11) NOT NULL DEFAULT '1',
  `fecha` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ubicacion` varchar(500) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `fab_proyectos`
--

INSERT INTO `fab_proyectos` (`id`, `nom_proyecto`, `cliente`, `condicion`, `fecha`, `created_at`, `updated_at`, `ubicacion`) VALUES
(1, 'Proyecto 1', 2, 1, '2018-07-01', '2018-07-22 03:30:23', '2018-07-22 03:30:23', ''),
(2, 'Proyecto 2', 1, 1, '2018-07-23', '2018-07-23 16:35:11', '2018-07-23 21:35:11', ''),
(3, 'Proyecto 3', 3, 1, '2018-07-23', '2018-07-24 00:08:41', '2018-07-24 00:08:41', ''),
(4, 'xxxx', 2, 1, '2018-07-30', '2018-07-31 07:31:36', '2018-07-31 07:31:36', ''),
(5, 'interventoria mocoa', 8, 1, '2018-08-10', '2018-08-11 07:39:35', '2018-08-11 07:39:35', ''),
(6, 'Testing', 1, 1, '2018-09-13', '2018-09-13 21:31:43', '2018-09-13 20:59:43', 'ssssseee fwrwerw e'),
(7, 'asdfasdf', 3, 1, '2018-09-13', '2018-09-14 01:14:06', '2018-09-14 01:14:06', 'ssss'),
(8, 'asdfasdf', 3, 1, '2018-09-13', '2018-09-14 01:44:38', '2018-09-14 01:44:38', 'ssss hh'),
(9, 'asdfasdf', 3, 1, '2018-09-13', '2018-09-14 01:44:57', '2018-09-14 01:44:57', 'ssss  dddddd'),
(10, 'Testing', 1, 1, '2018-09-13', '2018-09-14 01:45:53', '2018-09-14 01:45:53', 'aewras rva asdf asdf asdf'),
(11, 'Testing', 1, 1, '2018-09-13', '2018-09-13 20:54:01', '2018-09-14 01:54:01', 'hola');

-- --------------------------------------------------------

--
-- Table structure for table `formatos`
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
  `doc_afecta_long` varchar(390) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `formatos`
--

INSERT INTO `formatos` (`id`, `numero`, `formato`, `tercero`, `fecha`, `detalle`, `created_at`, `updated_at`, `condicion`, `usuario`, `subtotal`, `impuesto`, `vr_impuesto`, `total`, `debes`, `haberes`, `doc_afecta`, `banco`, `forma_pago`, `num_cheque`, `cerrado`, `doc_afecta_long`) VALUES
(2, '0002', 1, 1, '2018-06-25', 'dddddd', '2018-07-07 20:35:11', '2018-06-26 07:07:23', 1, 1, 0, NULL, NULL, 0, 0, 0, NULL, 0, '', NULL, 0, ''),
(3, '0003', 1, 1, '2018-07-04', 'xxxx', '2018-07-16 17:14:24', '2018-07-16 22:14:24', 0, 1, 1000, NULL, NULL, 1000, 1000, 0, NULL, 0, '', NULL, 0, ''),
(7, '0004', 2, 1, '2018-07-15', '100.00', '2018-07-16 17:50:13', '2018-07-16 22:50:13', 1, 1, 0, NULL, NULL, 0, 100, 0, NULL, NULL, 'Efectivo', NULL, 1, ''),
(14, '5', 3, 2, '2018-07-25', 'prueba', '2018-07-28 20:36:30', '2018-07-25 22:43:11', 1, 1, 0, NULL, NULL, 0, 500, 250, NULL, NULL, 'Efectivo', NULL, 0, NULL),
(15, '00004', 1, 3, '2018-07-27', '100.00', '2018-07-28 01:31:30', '2018-07-27 20:31:30', 1, 1, 0, NULL, NULL, 0, 100, 0, NULL, NULL, 'Efectivo', NULL, 0, NULL),
(16, '00006', 3, 1, '2018-08-03', 'prueba prueba 111 prueba', '2018-08-15 21:21:53', '2018-08-15 21:21:53', 1, 1, 0, NULL, NULL, 0, 1000, 1000, NULL, NULL, 'Efectivo', NULL, 0, NULL),
(17, '00001', 4, 1, '2018-08-29', 'pago honorarios', '2018-08-29 20:02:18', '2018-08-29 20:02:18', 1, 1, 0, NULL, NULL, 0, 1000000, 1000000, NULL, NULL, 'Efectivo', NULL, 0, NULL),
(18, '00002', 4, 1, '2018-09-02', 'pago2', '2018-09-21 11:17:09', '2018-09-21 11:17:09', 1, 1, 0, NULL, NULL, 0, 500000, 500000, NULL, NULL, NULL, NULL, 0, NULL),
(20, '00005', 2, 1, '2018-09-30', 'sfasdf', '2018-10-01 19:45:33', '2018-10-02 00:45:33', 0, 1, 0, NULL, NULL, 0, 1300000, 0, NULL, 4, 'Efectivo', NULL, 0, NULL),
(24, '00006', 2, 1, '2018-10-04', 'sfdsdf', '2018-10-04 11:04:24', '2018-10-04 06:04:24', 1, 1, 0, NULL, NULL, 0, 1300000, 500000, NULL, 4, 'Efectivo', NULL, 0, NULL),
(25, '00007', 2, 1, '2018-10-17', 'sdfasdf', '2018-10-18 00:25:08', '2018-10-17 19:25:08', 1, 1, 0, NULL, NULL, 0, 100, 0, NULL, 4, 'Efectivo', NULL, 0, NULL),
(26, '00008', 2, 1, '2018-10-17', 'asdfad', '2018-10-18 00:27:55', '2018-10-17 19:27:55', 1, 1, 0, NULL, NULL, 0, 100, 0, NULL, 4, 'Efectivo', NULL, 0, NULL),
(27, '00003', 4, 9, '2018-11-02', 'sdfasdf', '2018-11-02 21:10:48', '2018-11-02 16:10:48', 1, 1, 0, NULL, NULL, 0, 0, 10000, NULL, NULL, NULL, NULL, 0, NULL),
(28, '00004', 4, 9, '2018-11-02', 'csdfsfa', '2018-11-02 21:27:07', '2018-11-02 16:27:07', 1, 1, 0, NULL, NULL, 0, 0, 2000, NULL, 4, NULL, NULL, 0, NULL),
(29, '00005', 4, 1, '2018-11-02', 'iiiii', '2018-11-02 21:39:53', '2018-11-02 16:39:53', 1, 1, 0, NULL, NULL, 0, 0, 4000, NULL, NULL, 'Efectivo', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `informes_contables`
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
-- Dumping data for table `informes_contables`
--

INSERT INTO `informes_contables` (`id`, `nom_informe`, `tipo_informe`, `condicion`, `created_at`, `updated_at`, `numero`) VALUES
(1, 'Auxiliar con Saldos', 'Auxiliares', 1, '2018-08-15 20:52:35', '2018-08-15 20:52:35', 1),
(2, 'Auxiliar x Comprobantes', 'Auxiliares', 1, '2018-08-15 21:08:06', '2018-08-15 21:08:06', 2);

-- --------------------------------------------------------

--
-- Table structure for table `ingresos`
--

CREATE TABLE `ingresos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idproveedor` int(10) UNSIGNED NOT NULL,
  `idusuario` int(10) UNSIGNED NOT NULL,
  `tipo_comprobante` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serie_comprobante` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_comprobante` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total` decimal(11,2) NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ingresos`
--

INSERT INTO `ingresos` (`id`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total`, `estado`, `created_at`, `updated_at`) VALUES
(1, 4, 1, 'BOLETA', 'zzz', '8989', '2018-07-09 00:00:00', '0.00', '12000.00', 'Registrado', '2018-07-09 23:12:42', '2018-07-09 23:12:42');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_resets_table', 1),
(2, '2018_02_01_171225_create_categorias_table', 1),
(3, '2018_02_22_235257_create_articulos_table', 1),
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
(14, '2018_05_26_001854_create_notifications_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
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
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_id`, `notifiable_type`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('40b21c90-a1fd-4564-b582-3fe0fa1386bc', 'App\\Notifications\\NotifyAdmin', 1, 'App\\User', '{\"datos\":{\"ventas\":{\"numero\":1,\"msj\":\"Ventas\"},\"ingresos\":{\"numero\":0,\"msj\":\"Ingresos\"}}}', NULL, '2018-07-17 04:51:13', '2018-07-17 04:51:13');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personas`
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
-- Dumping data for table `personas`
--

INSERT INTO `personas` (`id`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `created_at`, `updated_at`, `regimen`, `representante`, `sexo`, `fec_nac`, `reside`, `tipo_persona`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `digito_verif`, `entidad`, `num_verif`) VALUES
(1, '\'\'', 'CC', '1123201184', 'ccc', '3214', 'ccmonpan@hotmail.com', '2018-08-01 05:00:00', '2018-08-01 05:00:00', '', '', '', '0000-00-00', '', 'Natural', 'Cristhiam', 'Camilo', 'Monsalve', '', 0, '', ''),
(2, 'Jessica Murcia', 'NIT', '33333', 'lllllll', '34444', 'cccc@jjjj.com', '2018-07-08 02:02:10', '2018-07-11 10:37:16', '', '', '', '0000-00-00', '', '', '', '', '', '', 0, '', ''),
(3, 'Domenick', 'CE', '1123', 'kkkkk', '9999', 'cjcjc@ssss.com', '2018-07-08 12:20:52', '2018-07-11 10:37:10', '', '', '', '0000-00-00', '', '', '', '', '', '', 0, '', ''),
(4, 'Provedor1', 'CC', '90088777', '87788', '32222', 'cccccc@jjj.com', '2018-07-09 23:07:14', '2018-07-11 10:36:52', '', '', '', '0000-00-00', '', '', '', '', '', '', 0, '', ''),
(5, 'Rifas x', 'NIT', '908888', 'sdfosdfoi', '454545', 'lsdfskdjf@dsfdsf.xom', '2018-07-11 11:22:21', '2018-09-21 12:44:12', 'Comun', 'lsdfskdjf@dsfdsf.xom', 'Otro', '2018-07-01', 'asdfasdf ad fasd fasdf asf4', 'Juridica', NULL, NULL, NULL, NULL, 0, NULL, ''),
(6, '\'\'', 'CC', '45998888', 'jflasdjf aljsd flajsdf l', '3495959', 'htm@hot.com', '2018-08-04 07:49:37', '2018-08-04 07:49:37', 'Comun', NULL, 'Femenino', NULL, 'asdfasdfadsf', 'Natural', 'Marlon', '', 'Monsalve', '', 0, '', ''),
(7, NULL, 'CC', '3839', 'jkjk', '777', 'lues@gg.com', '2018-08-04 08:04:37', '2018-08-04 08:04:37', 'Comun', NULL, 'Masculino', NULL, 'dfsdfsdf', 'Natural', 'Luis', '', 'Monsalve', '', 0, '', ''),
(8, NULL, 'CC', '1085288369', 'barrio el jardin', '3203313824', 'fanfano312@hotmail.com', '2018-08-11 07:38:58', '2018-08-22 02:50:23', 'Simplificado', 'fanfano312@hotmail.com', 'Masculino', '1991-04-27', 'mocoa', 'Natural', 'ismael', NULL, 'cardenas', NULL, 0, '', ''),
(9, NULL, 'CC', '123', '123', '123', 'sss', '2018-08-22 20:04:53', '2018-08-22 20:04:53', 'Simplificado', NULL, 'Femenino', '2001-04-18', 'xxxx', 'Natural', 'Oscar', 'Fabian', 'Franco', 'Pantoja', 0, '', ''),
(10, NULL, 'CC', '121212', NULL, NULL, NULL, '2018-08-31 01:51:06', '2018-08-31 01:51:06', 'Simplificado', NULL, 'Masculino', NULL, 'wwwww', 'Natural', 'Pepito', '', 'perez', '', 0, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `plan_cuentas`
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
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `anio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plan_cuentas`
--

INSERT INTO `plan_cuentas` (`id`, `codigo`, `nombre`, `naturaleza`, `tipo`, `corriente`, `banco`, `diferido`, `tercero`, `niif`, `condicion`, `created_at`, `updated_at`, `anio`) VALUES
(1, '1', 'ACTIVOS', 'Debito', 'Titulo', 0, 0, 0, NULL, '1', 1, NULL, '2018-06-16 18:33:51', 2018),
(2, '2', 'PASIVOS', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '2', 1, '2018-06-16 20:43:36', '2018-06-16 20:43:36', 2018),
(3, '3', 'PATRIMONIO', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '3', 1, '2018-06-16 20:47:30', '2018-06-16 20:47:30', 2018),
(4, '110505', 'CAJA GENERAL', 'Debito', 'Detalle', 0, 1, NULL, NULL, '110505', 1, '2018-07-09 21:32:18', '2018-08-30 00:07:34', 2018),
(5, '11', 'DISPONIBLE', 'Debito', 'Titulo', 0, 0, NULL, NULL, '11', 1, '2018-07-17 10:24:40', '2018-07-17 10:31:01', 2018),
(6, '1105', 'CAJA', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1105', 1, '2018-07-17 10:25:18', '2018-07-17 10:31:04', 2018),
(8, '110515', 'CAJAS MENORES', 'Debito', 'Detalle', 1, 0, NULL, NULL, '110515', 1, '2018-07-17 10:27:02', '2018-07-17 10:31:19', 2018),
(9, '1110', 'BANCOS', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1110', 1, '2018-07-17 10:28:08', '2018-07-17 10:31:23', 2018),
(11, '111005', 'MONEDA NACIONAL - BANCOS', 'Debito', 'Detalle', 1, 1, NULL, NULL, '111005', 1, '2018-07-17 10:29:49', '2018-08-30 00:06:54', 2018),
(12, '1115', 'REMESAS EN TRANSITO', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1115', 1, '2018-07-17 10:30:17', '2018-07-17 10:32:51', 2018),
(13, '111505', 'MONEDA NACIONAL', 'Debito', 'Detalle', 1, 0, NULL, NULL, '111505', 1, '2018-07-17 10:30:52', '2018-07-17 10:31:36', 2018),
(14, '1120', 'CUENTAS DE AHORRO', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1120', 1, '2018-07-17 10:33:44', '2018-07-17 10:33:44', 2018),
(15, '112005', 'BANCOS', 'Debito', 'Detalle', 1, 0, NULL, NULL, '112005', 1, '2018-07-17 10:34:41', '2018-07-17 10:34:41', 2018),
(16, '12', 'INVERSIONES', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '12', 1, '2018-07-17 10:38:46', '2018-07-17 10:38:46', 2018),
(17, '5', 'GASTOS', 'Debito', 'Titulo', 0, 0, NULL, NULL, '5', 1, '2018-08-29 23:58:50', '2018-08-29 23:58:50', 2018),
(18, '51', 'OPERACIONES DE ADMINISTRACION', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '51', 1, '2018-08-29 23:59:19', '2018-08-29 23:59:19', 2018),
(19, '5110', 'HONORARIOS', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '5110', 1, '2018-08-30 00:00:01', '2018-08-30 00:00:01', 2018),
(20, '511095', 'OTROS HONORARIOS', 'Debito', 'Detalle', NULL, 0, NULL, NULL, '511095', 1, '2018-08-30 00:00:49', '2018-08-30 00:00:49', 2018),
(21, '23', 'CUENTAS POR PAGAR', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '23', 1, '2018-08-30 00:20:37', '2018-08-30 00:20:37', 2018),
(22, '2335', 'COSTOS Y GASTOS POR PAGAR', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '2335', 1, '2018-08-30 00:21:11', '2018-08-30 00:21:11', 2018),
(23, '233525', 'HONORARIOS', 'Credito', 'Detalle', NULL, 0, NULL, NULL, '233525', 1, '2018-08-30 00:21:42', '2018-08-30 00:21:42', 2018),
(24, '2365', 'RETENCION EN LA FUENTE', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '2365', 1, '2018-08-30 00:22:35', '2018-08-30 00:22:35', 2018),
(25, '236515', 'HONORARIOS (RTE FTE)', 'Credito', 'Detalle', NULL, 0, NULL, NULL, '236515', 1, '2018-08-30 00:24:18', '2018-08-30 00:24:18', 2018);

-- --------------------------------------------------------

--
-- Table structure for table `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(10) UNSIGNED NOT NULL,
  `contacto` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono_contacto` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `proveedores`
--

INSERT INTO `proveedores` (`id`, `contacto`, `telefono_contacto`) VALUES
(4, 'hkhkjhk', '7979798');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `descripcion`, `condicion`) VALUES
(1, 'Administrador', 'Administradores de área', 1),
(2, 'Vendedor', 'Vendedor área venta', 1),
(3, 'Almacenero', 'Almacenero área compras', 1),
(4, 'Contador', 'Contador', 1),
(5, 'Aux Contable', 'Auxiliar de Contabilidad', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
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
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `usuario`, `password`, `condicion`, `idrol`, `remember_token`) VALUES
(1, 'cristhiam', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'I5B6LDdETcqdbWlcsi5MXw5uvdWv0GZGlnzLi3szFF6JlwdVE1IRvVrsD2Iu');

-- --------------------------------------------------------

--
-- Table structure for table `ventas`
--

CREATE TABLE `ventas` (
  `id` int(10) UNSIGNED NOT NULL,
  `idcliente` int(10) UNSIGNED NOT NULL,
  `idusuario` int(10) UNSIGNED NOT NULL,
  `tipo_comprobante` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serie_comprobante` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_comprobante` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total` decimal(11,2) NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ventas`
--

INSERT INTO `ventas` (`id`, `idcliente`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total`, `estado`, `created_at`, `updated_at`) VALUES
(2, 2, 1, 'FACTURA', '777s', '888x', '2018-07-16 00:00:00', '0.18', '2000.00', 'Registrado', '2018-07-17 04:51:13', '2018-07-17 04:51:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `articulos_nombre_unique` (`nombre`),
  ADD KEY `articulos_idcategoria_foreign` (`idcategoria`);

--
-- Indexes for table `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conf_formatos`
--
ALTER TABLE `conf_formatos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_formato` (`id_formato`),
  ADD KEY `tercero` (`tercero`),
  ADD KEY `centro_costos` (`centro_costos`),
  ADD KEY `doc_externo` (`doc_externo`),
  ADD KEY `usuario` (`usuario`);

--
-- Indexes for table `detalle_ingresos`
--
ALTER TABLE `detalle_ingresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_ingresos_idingreso_foreign` (`idingreso`),
  ADD KEY `detalle_ingresos_idarticulo_foreign` (`idarticulo`);

--
-- Indexes for table `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_ventas_idventa_foreign` (`idventa`),
  ADD KEY `detalle_ventas_idarticulo_foreign` (`idarticulo`);

--
-- Indexes for table `docs_formatos`
--
ALTER TABLE `docs_formatos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_formato` (`id_formato`);

--
-- Indexes for table `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fab_cilindros`
--
ALTER TABLE `fab_cilindros`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fab_muestras`
--
ALTER TABLE `fab_muestras`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fab_proyectos`
--
ALTER TABLE `fab_proyectos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `formatos`
--
ALTER TABLE `formatos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `formato` (`formato`),
  ADD KEY `tercero` (`tercero`),
  ADD KEY `usuario` (`usuario`);

--
-- Indexes for table `informes_contables`
--
ALTER TABLE `informes_contables`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ingresos`
--
ALTER TABLE `ingresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ingresos_idproveedor_foreign` (`idproveedor`),
  ADD KEY `ingresos_idusuario_foreign` (`idusuario`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_id_notifiable_type_index` (`notifiable_id`,`notifiable_type`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `plan_cuentas`
--
ALTER TABLE `plan_cuentas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proveedores`
--
ALTER TABLE `proveedores`
  ADD KEY `proveedores_id_foreign` (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_nombre_unique` (`nombre`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`),
  ADD KEY `users_id_foreign` (`id`),
  ADD KEY `users_idrol_foreign` (`idrol`);

--
-- Indexes for table `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ventas_idcliente_foreign` (`idcliente`),
  ADD KEY `ventas_idusuario_foreign` (`idusuario`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articulos`
--
ALTER TABLE `articulos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `conf_formatos`
--
ALTER TABLE `conf_formatos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `detalle_ingresos`
--
ALTER TABLE `detalle_ingresos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `docs_formatos`
--
ALTER TABLE `docs_formatos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `fab_cilindros`
--
ALTER TABLE `fab_cilindros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `fab_muestras`
--
ALTER TABLE `fab_muestras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `fab_proyectos`
--
ALTER TABLE `fab_proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `formatos`
--
ALTER TABLE `formatos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `informes_contables`
--
ALTER TABLE `informes_contables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ingresos`
--
ALTER TABLE `ingresos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `plan_cuentas`
--
ALTER TABLE `plan_cuentas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `articulos`
--
ALTER TABLE `articulos`
  ADD CONSTRAINT `articulos_idcategoria_foreign` FOREIGN KEY (`idcategoria`) REFERENCES `categorias` (`id`);

--
-- Constraints for table `detalle_ingresos`
--
ALTER TABLE `detalle_ingresos`
  ADD CONSTRAINT `detalle_ingresos_idarticulo_foreign` FOREIGN KEY (`idarticulo`) REFERENCES `articulos` (`id`),
  ADD CONSTRAINT `detalle_ingresos_idingreso_foreign` FOREIGN KEY (`idingreso`) REFERENCES `ingresos` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD CONSTRAINT `detalle_ventas_idarticulo_foreign` FOREIGN KEY (`idarticulo`) REFERENCES `articulos` (`id`),
  ADD CONSTRAINT `detalle_ventas_idventa_foreign` FOREIGN KEY (`idventa`) REFERENCES `ventas` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ingresos`
--
ALTER TABLE `ingresos`
  ADD CONSTRAINT `ingresos_idproveedor_foreign` FOREIGN KEY (`idproveedor`) REFERENCES `proveedores` (`id`),
  ADD CONSTRAINT `ingresos_idusuario_foreign` FOREIGN KEY (`idusuario`) REFERENCES `users` (`id`);

--
-- Constraints for table `proveedores`
--
ALTER TABLE `proveedores`
  ADD CONSTRAINT `proveedores_id_foreign` FOREIGN KEY (`id`) REFERENCES `personas` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_id_foreign` FOREIGN KEY (`id`) REFERENCES `personas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_idrol_foreign` FOREIGN KEY (`idrol`) REFERENCES `roles` (`id`);

--
-- Constraints for table `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_idcliente_foreign` FOREIGN KEY (`idcliente`) REFERENCES `personas` (`id`),
  ADD CONSTRAINT `ventas_idusuario_foreign` FOREIGN KEY (`idusuario`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
