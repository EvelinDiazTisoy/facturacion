-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-07-2019 a las 16:27:00
-- Versión del servidor: 10.1.40-MariaDB
-- Versión de PHP: 7.3.5

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
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE `actividades` (
  `id` int(10) UNSIGNED NOT NULL,
  `actividad` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipoActividad` enum('Planear','Hacer','Verificar','Actuar','Corregir') COLLATE utf8mb4_unicode_ci NOT NULL,
  `ene` tinyint(1) NOT NULL DEFAULT '3',
  `feb` tinyint(1) NOT NULL DEFAULT '3',
  `mar` tinyint(1) NOT NULL DEFAULT '3',
  `abr` tinyint(1) NOT NULL DEFAULT '3',
  `may` tinyint(1) NOT NULL DEFAULT '3',
  `jun` tinyint(1) NOT NULL DEFAULT '3',
  `jul` tinyint(1) NOT NULL DEFAULT '3',
  `ago` tinyint(1) NOT NULL DEFAULT '3',
  `sep` tinyint(1) NOT NULL DEFAULT '3',
  `oct` tinyint(1) NOT NULL DEFAULT '3',
  `nov` tinyint(1) NOT NULL DEFAULT '3',
  `dic` tinyint(1) NOT NULL DEFAULT '3',
  `diaMesLimite` tinyint(3) UNSIGNED NOT NULL,
  `ponderacion` smallint(5) UNSIGNED NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_planAsoc_planes_accion` int(10) UNSIGNED DEFAULT NULL,
  `fk_id_planes_accion` int(10) UNSIGNED NOT NULL,
  `fk_id_procesos` int(10) UNSIGNED NOT NULL,
  `fk_id_proyectos` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `fk_usuActualiza_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `actividades`
--

INSERT INTO `actividades` (`id`, `actividad`, `tipoActividad`, `ene`, `feb`, `mar`, `abr`, `may`, `jun`, `jul`, `ago`, `sep`, `oct`, `nov`, `dic`, `diaMesLimite`, `ponderacion`, `estado`, `fk_id_empresas`, `fk_planAsoc_planes_accion`, `fk_id_planes_accion`, `fk_id_procesos`, `fk_id_proyectos`, `fk_usuCrea_users`, `fk_usuActualiza_users`, `created_at`, `updated_at`) VALUES
(1, 'Mi primera actividad', 'Corregir', 0, 3, 3, 3, 3, 0, 3, 3, 3, 0, 3, 3, 11, 0, 1, 1, NULL, 1, 3, 4, 1, 1, '2019-05-23 10:54:15', '2019-05-24 08:33:58'),
(2, 'Segunda actividad final', 'Hacer', 3, 3, 0, 3, 0, 3, 3, 3, 0, 3, 3, 0, 10, 0, 1, 1, NULL, 1, 3, 4, 1, 1, '2019-05-24 01:50:45', '2019-05-24 08:32:12'),
(3, 'Actividad de prueba', 'Corregir', 3, 3, 3, 3, 0, 3, 3, 3, 3, 3, 3, 3, 7, 0, 1, 1, NULL, 1, 3, 4, 1, 1, '2019-05-25 09:47:55', '2019-05-25 09:47:55'),
(4, 'Documentar procesos e informes finales', 'Planear', 0, 0, 3, 0, 0, 3, 3, 3, 0, 3, 3, 3, 6, 0, 1, 1, NULL, 2, 3, 5, 1, 1, '2019-05-28 19:03:43', '2019-05-28 19:05:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos_procesos`
--

CREATE TABLE `archivos_procesos` (
  `id` int(10) UNSIGNED NOT NULL,
  `archivo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `versionamiento` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ruta` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fk_id_carpetas_procesos` int(10) UNSIGNED NOT NULL,
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `fk_usuActualiza_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `archivos_procesos`
--

INSERT INTO `archivos_procesos` (`id`, `archivo`, `codigo`, `versionamiento`, `ruta`, `descripcion`, `estado`, `fk_id_carpetas_procesos`, `fk_id_empresas`, `fk_usuCrea_users`, `fk_usuActualiza_users`, `created_at`, `updated_at`) VALUES
(1, 'Archivo de prueba', '1', '1', '1_empresa/ZZZkgm6USdTOG27NPgrkBkP5Jeq77RMEccghukXe.pdf', NULL, 1, 2, 1, 1, 1, '2019-05-28 02:20:39', '2019-05-28 02:20:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idcategoria` int(10) UNSIGNED NOT NULL,
  `idcategoria2` int(11) NOT NULL,
  `codigo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cod_invima` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lote` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fec_vence` date NOT NULL,
  `minimo` int(11) NOT NULL,
  `tipo_articulo` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `iva` int(11) NOT NULL,
  `id_und_medida` int(11) DEFAULT NULL,
  `id_concentracion` int(11) DEFAULT NULL,
  `id_presentacion` int(11) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`id`, `idcategoria`, `idcategoria2`, `codigo`, `nombre`, `precio_venta`, `stock`, `descripcion`, `cod_invima`, `lote`, `fec_vence`, `minimo`, `tipo_articulo`, `iva`, `id_und_medida`, `id_concentracion`, `id_presentacion`, `id_usuario`, `id_empresa`, `condicion`, `created_at`, `updated_at`) VALUES
(1, 5, 1, '90202', 'Articulo 1', '1000.00', 100, 'faljfl', 'afjlk', NULL, '2019-05-30', 1, '2', 0, NULL, NULL, NULL, 1, 1, 1, '2019-05-30 20:04:19', '2019-06-01 01:15:21'),
(2, 3, 1, '9203902', 'Articulo 2', '500.00', 50, 'ajlkjf', 'ajflkj', 'aslfjl', '2019-05-30', 1, '1', 0, 1, NULL, NULL, 1, 1, 1, '2019-05-30 20:06:27', '2019-05-31 22:25:18');

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
(3, 'Banco 3', 1, 1, 1, '2019-05-23 19:31:17', '2019-05-28 22:29:26'),
(4, 'Banco 2', 2, 1, 1, '2019-05-23 19:31:06', '2019-05-23 19:31:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargos`
--

CREATE TABLE `cargos` (
  `id` int(10) UNSIGNED NOT NULL,
  `cargo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `fk_usuActualiza_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cargos`
--

INSERT INTO `cargos` (`id`, `cargo`, `descripcion`, `estado`, `fk_id_empresas`, `fk_usuCrea_users`, `fk_usuActualiza_users`, `created_at`, `updated_at`) VALUES
(1, 'Mensajero', 'Mensajería de la empresa', 1, 1, 1, 1, '2019-05-15 18:44:20', '2019-05-28 01:58:34'),
(2, 'Gerente', 'Gerente de oficinas', 0, 1, 1, 1, '2019-05-15 18:45:01', '2019-05-28 01:42:56'),
(3, 'Asistente de secretario actualizado', 'Gestión documental y de procedimientos de riesgo', 1, 1, 1, 1, '2019-05-28 01:38:21', '2019-05-28 01:38:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carpetas_procesos`
--

CREATE TABLE `carpetas_procesos` (
  `id` int(10) UNSIGNED NOT NULL,
  `carpeta` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_id_procesos` int(10) UNSIGNED NOT NULL,
  `fk_id_tipos_carpetas` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `fk_usuActualiza_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `carpetas_procesos`
--

INSERT INTO `carpetas_procesos` (`id`, `carpeta`, `descripcion`, `estado`, `fk_id_empresas`, `fk_id_procesos`, `fk_id_tipos_carpetas`, `fk_usuCrea_users`, `fk_usuActualiza_users`, `created_at`, `updated_at`) VALUES
(1, 'Mi Primera carpeta', 'Primera descripcion.\nInician las pruebas', 1, 1, 3, 3, 1, 1, '2019-05-07 08:16:41', '2019-05-21 00:55:38'),
(2, 'El mejor folder actualizado', 'Este folder contendrá documentos escenciales', 1, 1, 4, 4, 1, 1, '2019-05-27 21:15:48', '2019-05-28 01:54:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `idCuentaProductos` int(11) DEFAULT NULL,
  `idCuentaSalidaProductos` int(11) DEFAULT NULL,
  `idCuentaSaldosIniciales` int(11) DEFAULT NULL,
  `idCuentaDonaciones` int(11) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `id_empresa` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `idCuentaProductos`, `idCuentaSalidaProductos`, `idCuentaSaldosIniciales`, `idCuentaDonaciones`, `condicion`, `id_empresa`, `created_at`, `updated_at`) VALUES
(1, 'Categoria 1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 1, 2, 3, 4, 1, 1, '2019-05-22 20:49:33', '2019-05-31 02:58:52'),
(2, 'Categoria 2', 'Categoria 2 empresa 1', NULL, NULL, NULL, NULL, 1, 1, '2019-05-22 22:28:41', '2019-05-28 01:21:22'),
(3, 'Categoria 3', 'Categoria 3', NULL, NULL, NULL, NULL, 1, 1, '2019-05-23 18:24:52', '2019-05-27 19:45:57'),
(4, 'Categoria 2', 'Categoria 2 empresa 2', NULL, NULL, NULL, NULL, 1, 2, '2019-05-22 22:28:41', '2019-05-22 22:28:41'),
(5, 'Categoria 1 desde articulos', 'ldjfldjaflkj', 1, 15, 8, 21, 1, 1, '2019-06-01 00:56:03', '2019-06-01 00:56:03'),
(6, 'Categoria 2 desde articulo', 'ljlkjlkjlkk', 1, 9, 4, 5, 1, 1, '2019-06-01 01:02:36', '2019-06-04 20:08:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias2`
--

CREATE TABLE `categorias2` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `id_empresa` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias2`
--

INSERT INTO `categorias2` (`id`, `nombre`, `descripcion`, `condicion`, `id_empresa`, `created_at`, `updated_at`) VALUES
(1, 'Categoria2 1', 'jjjjjjjjjjjjjjjjjjjjjjjjjjjk', 1, 1, '2019-05-22 20:49:33', '2019-06-04 20:11:35'),
(2, 'Categoria2 2', 'Categoria 2 empresa 1', 1, 1, '2019-05-22 22:28:41', '2019-05-28 01:21:22'),
(3, 'Categoria2 3', 'Categoria 3', 0, 1, '2019-05-23 18:24:52', '2019-05-29 03:12:05'),
(4, 'Categoria2 2', 'Categoria 2 empresa 2', 1, 2, '2019-05-22 22:28:41', '2019-05-22 22:28:41');

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
(3, 'Cobrador 1', NULL, 1, NULL, 1, 1, 1, '2019-05-20 19:53:08', '2019-05-28 22:26:47'),
(4, 'Vendedor 2', NULL, 1, 1, NULL, 2, 1, '2019-05-20 19:52:52', '2019-05-20 19:52:52');

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

--
-- Volcado de datos para la tabla `concentraciones`
--

INSERT INTO `concentraciones` (`id`, `nombre`, `estado`, `id_empresa`, `usu_crea`, `created_at`, `updated_at`) VALUES
(1, '1%', 1, 1, 1, '2019-02-13 02:57:52', '2019-05-28 02:31:28'),
(2, '16%', 1, 1, 1, '2019-02-13 02:58:22', '2019-02-13 02:58:54'),
(3, '8gr', 1, 1, 1, '2019-02-13 02:59:03', '2019-02-13 02:59:03'),
(4, 'Nueva concentración', 1, 2, 1, '2019-02-15 02:19:04', '2019-02-15 02:19:04');

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
  `id_empresa` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `usu_crea` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `con_tarifarios`
--

INSERT INTO `con_tarifarios` (`id`, `nombre`, `descripcion`, `id_empresa`, `estado`, `usu_crea`, `created_at`, `updated_at`) VALUES
(1, 'Tarifario 1', 'Descripcion tarifario 1', 1, 1, 1, '2019-05-30 20:04:57', '2019-05-30 20:04:57'),
(2, 'Tarifario 2', 'Tarifario 2', 1, 1, 1, '2019-05-31 19:19:27', '2019-05-31 19:19:27'),
(3, 'Tarifario 3', 'lajflkjl', 1, 1, 1, '2019-05-31 19:44:54', '2019-05-31 20:00:00');

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
-- Estructura de tabla para la tabla `detalle_egresos`
--

CREATE TABLE `detalle_egresos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idegreso` int(10) UNSIGNED NOT NULL,
  `idarticulo` int(10) UNSIGNED NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(11,2) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_egresos`
--

INSERT INTO `detalle_egresos` (`id`, `idegreso`, `idarticulo`, `cantidad`, `precio`, `id_usuario`) VALUES
(1, 1, 2, 50, '1.00', 1),
(2, 2, 1, 6, '1.00', 1);

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

--
-- Volcado de datos para la tabla `detalle_facturacion`
--

INSERT INTO `detalle_facturacion` (`id`, `id_factura`, `id_producto`, `valor_venta`, `cantidad`, `valor_iva`, `valor_descuento`, `porcentaje_iva`, `valor_subtotal`, `valor_final`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1000.00, 1, 38.00, 0.00, 4.00, 962.00, 1000.00, '2019-05-27 21:26:31', '2019-05-27 21:26:31'),
(2, 1, 2, 1000.00, 1, 38.00, 0.00, 4.00, 962.00, 1000.00, '2019-05-27 21:26:31', '2019-05-27 21:26:31'),
(3, 2, 2, 1000.00, 1, 38.00, 0.00, 4.00, 962.00, 1000.00, '2019-05-27 21:27:10', '2019-05-27 21:27:10');

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
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_ingresos`
--

INSERT INTO `detalle_ingresos` (`id`, `idingreso`, `idarticulo`, `cantidad`, `precio`, `id_usuario`) VALUES
(1, 2, 1, 5, '1.00', 1),
(2, 2, 2, 10, '1.00', 1),
(3, 3, 1, 1, '1.00', 1);

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
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `egresos`
--

INSERT INTO `egresos` (`id`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `tipo_egreso`, `fecha_hora`, `impuesto`, `total`, `estado`, `id_empresa`, `created_at`, `updated_at`) VALUES
(1, 11, 1, NULL, NULL, NULL, 'Egreso', '2019-05-27 00:00:00', NULL, '50.00', 'Registrado', 1, '2019-05-27 19:24:22', '2019-05-27 19:24:22'),
(2, 6, 1, NULL, NULL, NULL, 'Egreso empresa 2', '2019-05-27 00:00:00', NULL, '6.00', 'Registrado', 1, '2019-05-28 01:07:21', '2019-05-28 01:07:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id` int(10) UNSIGNED NOT NULL,
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
  `usu_crea` int(10) UNSIGNED NOT NULL,
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
  `id_empresa` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `facturacion`
--

INSERT INTO `facturacion` (`id`, `num_factura`, `id_tercero`, `id_usuario`, `fec_crea`, `fec_edita`, `usu_edita`, `subtotal`, `valor_iva`, `total`, `abono`, `saldo`, `detalle`, `descuento`, `lugar`, `fec_registra`, `fec_envia`, `fec_anula`, `usu_registra`, `usu_envia`, `usu_anula`, `fecha`, `id_empresa`, `estado`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 1, '2019-05-27 11:26:31', NULL, NULL, 1924.00, 76.00, 2000.00, 0.00, 2000.00, 'akkfk', 0.00, 2, NULL, NULL, NULL, NULL, NULL, NULL, '2019-05-27', 1, 1, '2019-05-27 21:26:31', '2019-05-27 21:26:31'),
(2, NULL, 11, 1, '2019-05-27 11:27:10', NULL, NULL, 962.00, 38.00, 1000.00, 0.00, 1000.00, 'akfjdak', 0.00, 3, NULL, NULL, NULL, NULL, NULL, NULL, '2019-05-27', 2, 1, '2019-05-27 21:27:10', '2019-05-27 21:27:10');

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
-- Estructura de tabla para la tabla `indicadores`
--

CREATE TABLE `indicadores` (
  `id` int(10) UNSIGNED NOT NULL,
  `indicador` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta` tinyint(4) NOT NULL,
  `acumulativo` tinyint(1) NOT NULL,
  `definicion` enum('ESTRUCTURA','PROCESO','RESULTADO') COLLATE utf8mb4_unicode_ci NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_id_objetivos` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `fk_usuActualiza_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `indicadores`
--

INSERT INTO `indicadores` (`id`, `indicador`, `descripcion`, `meta`, `acumulativo`, `definicion`, `observaciones`, `estado`, `fk_id_empresas`, `fk_id_objetivos`, `fk_usuCrea_users`, `fk_usuActualiza_users`, `created_at`, `updated_at`) VALUES
(1, 'Primer indicador para el objetivo', 'Descripción generica', 60, 0, 'PROCESO', 'Observación de prueba', 1, 1, 1, 1, 1, '2019-06-11 04:58:40', '2019-06-11 04:58:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indicadores_actividades`
--

CREATE TABLE `indicadores_actividades` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_id_actividades` int(10) UNSIGNED NOT NULL,
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_id_indicadores` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `indicadores_actividades`
--

INSERT INTO `indicadores_actividades` (`id`, `fk_id_actividades`, `fk_id_empresas`, `fk_id_indicadores`, `fk_usuCrea_users`, `created_at`, `updated_at`) VALUES
(5, 3, 1, 1, 1, NULL, NULL),
(9, 1, 1, 1, 1, NULL, NULL);

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
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ingresos`
--

INSERT INTO `ingresos` (`id`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `tipo_ingreso`, `fecha_hora`, `impuesto`, `total`, `estado`, `id_empresa`, `created_at`, `updated_at`) VALUES
(2, 7, 1, NULL, NULL, NULL, 'Ingreso', '2019-05-27 00:00:00', NULL, '15.00', 'Registrado', 1, '2019-05-27 19:12:03', '2019-05-27 19:12:03'),
(3, 7, 1, NULL, NULL, NULL, 'Ingreso empresa 2', '2019-05-27 00:00:00', NULL, '1.00', 'Registrado', 1, '2019-05-28 01:02:31', '2019-05-28 01:02:31');

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
(7, '2018_03_14_000000_create_users_table', 1),
(8, '2019_05_01_002344_create_procesos_table', 2),
(9, '2019_05_01_040853_create_tipos_carpetas_table', 2),
(10, '2019_05_01_041953_create_carpetas_procesos_table', 2),
(11, '2019_05_01_042402_create_archivos_procesos_table', 2),
(12, '2019_05_10_163434_create_proyectos_table', 2),
(13, '2019_05_10_163435_create_procesos_proyectos_table', 2),
(14, '2019_05_10_220115_create_cargos_table', 2),
(15, '2019_05_10_222504_create_usuarios_proyectos_table', 2),
(16, '2019_05_15_210628_create_planes_accion_table', 2),
(17, '2019_05_15_210629_create_planes_accion_proyectos_table', 2),
(18, '2019_05_21_141206_create_actividades_table', 2),
(19, '2019_05_21_150709_create_usuarios_actividades_table', 2),
(20, '2019_05_29_151315_create_objetivos_table', 3),
(21, '2019_05_29_165407_create_indicadores_table', 3),
(22, '2019_06_05_141541_create_indicadores_actividades_table', 3);

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
(13, 'Gestion Administrativa', 'Para gestionar procesos', 1, 1, 'GA.vue', 13, 1, 'icon-cup', 'gestionAdmin', NULL, '2019-05-04 01:22:46', '2019-05-04 01:22:46'),
(14, 'Procesos', 'Para gestionar los procesos con sus carpetas y archivos', 1, 1, 'Proceso.vue', 14, 2, 'icon-refresh', 'proceso', 13, '2019-05-04 01:27:01', '2019-05-04 01:27:01'),
(15, 'Proyectos', 'Configuración de proyectos', 1, 1, 'ConfProyectos.vue', 15, 2, 'icon-book-open', 'conf_proyectos', 13, '2019-05-13 09:04:19', '2019-05-13 09:04:19'),
(16, 'Cargos', NULL, 1, 1, 'Cargo.vue', 16, 2, 'fa fa-id-badge', 'cargo', 13, '2019-05-15 09:55:53', '2019-05-16 01:20:00'),
(17, 'Planes de acción', 'Planes de acción transversales por proyecto', 1, 1, 'PlanAccion.vue', 17, 2, 'icon-note', 'plan_accion', 13, '2019-05-18 01:09:22', '2019-05-18 01:12:29'),
(18, 'Bancos', NULL, 1, 1, 'Bancos.vue', 18, 2, 'icon-bag', 'bancos', 5, '2019-05-28 03:17:42', '2019-05-28 03:17:42'),
(19, 'Almacen', NULL, 1, 1, 'Almacen.vue', 19, 1, 'icon-bag', 'almacen', NULL, '2019-05-28 03:18:57', '2019-05-28 03:18:57'),
(20, 'Articulos', NULL, 1, 1, 'Articulo.vue', 20, 2, 'icon-bag', 'articulo', 19, '2019-05-28 03:20:41', '2019-05-28 03:20:41'),
(21, 'Categorias', NULL, 1, 1, 'Categoria.vue', 21, 2, 'icon-bag', 'categoria', 19, '2019-05-28 03:21:54', '2019-05-28 03:21:54'),
(22, 'Cliente', NULL, 1, 1, 'Cliente.vue', 22, 2, 'icon-bag', 'cliente', 19, '2019-05-28 03:22:23', '2019-05-28 03:22:23'),
(23, 'Concentración', NULL, 1, 1, 'Concentracion.vue', 23, 2, 'icon-bag', 'concentracion', 19, '2019-05-28 03:23:17', '2019-05-28 03:23:17'),
(24, 'Egreso', NULL, 1, 1, 'Egreso.vue', 24, 2, 'icon-bag', 'egreso', 19, '2019-05-28 03:27:17', '2019-05-28 03:27:17'),
(25, 'Facturación', NULL, 1, 1, 'Facturacion.vue', 25, 2, 'icon-bag', 'facturacion', 19, '2019-05-28 03:27:50', '2019-05-28 03:27:50'),
(26, 'Ingresos', NULL, 1, 1, 'Ingresos.vue', 26, 2, 'icon-bag', 'ingreso', 19, '2019-05-28 03:28:44', '2019-05-28 03:28:44'),
(27, 'Presentación', NULL, 1, 1, 'Presentacion.vue', 27, 2, 'icon-bag', 'presentacion', 19, '2019-05-28 03:29:15', '2019-05-28 03:29:15'),
(28, 'Stock', NULL, 1, 1, 'Stock.vue', 28, 2, 'icon-bag', 'stock', 19, '2019-05-28 03:29:43', '2019-05-28 03:29:43'),
(29, 'Unidad de medida', NULL, 1, 1, 'UndMedida.vue', 29, 2, 'icon-bag', 'und_medida', 19, '2019-05-28 03:30:25', '2019-05-28 03:30:25'),
(30, 'Ingresos', NULL, 1, 1, 'Ingreso.vue', 30, 2, 'icon-bag', 'ingreso', 19, '2019-05-28 19:16:46', '2019-05-28 19:16:46'),
(31, 'Objetivos/Indicadores', 'Configura/Gestiona objetivos y sus indicadores', 1, 1, 'ConfIndicadores.vue', 31, 2, 'fa fa-dot-circle-o', 'conf_indicadores', 13, '2019-05-30 22:19:59', '2019-06-11 04:43:42'),
(32, 'Categorias 2', NULL, 1, 1, 'Categoria2.vue', 32, 2, 'icon-bag', 'categoria2', 19, '2019-06-04 18:48:10', '2019-06-04 20:10:41');

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
(24, 12, 2, 1, 1, NULL),
(25, 13, 1, 1, 1, '2019-05-03 15:34:00'),
(26, 14, 1, 1, 1, '2019-05-03 15:33:52'),
(27, 14, 2, 1, 1, '2019-05-12 23:05:42'),
(28, 15, 1, 1, 1, '2019-05-14 23:57:23'),
(29, 15, 2, 1, 1, '2019-05-17 15:10:47'),
(30, 16, 1, 1, 1, '2019-05-17 15:10:47'),
(31, 16, 2, 1, 1, '2019-05-17 15:10:47'),
(32, 17, 1, 1, 1, '2019-05-17 15:10:47'),
(33, 17, 2, 1, 1, '2019-05-17 15:10:47'),
(34, 18, 1, 1, 1, '2019-05-17 15:10:47'),
(35, 18, 2, 1, 1, '2019-05-17 15:10:47'),
(36, 19, 1, 1, 1, '2019-05-17 15:10:47'),
(37, 19, 2, 1, 1, '2019-05-17 15:10:47'),
(38, 20, 1, 1, 1, '2019-05-17 15:10:47'),
(39, 20, 2, 1, 1, '2019-05-17 15:10:47'),
(40, 21, 1, 1, 1, NULL),
(41, 21, 2, 1, 1, NULL),
(42, 22, 1, 1, 1, NULL),
(43, 22, 2, 1, 1, NULL),
(44, 23, 1, 1, 1, NULL),
(45, 23, 2, 1, 1, NULL),
(46, 24, 1, 1, 1, NULL),
(47, 24, 2, 1, 1, NULL),
(48, 25, 1, 1, 1, NULL),
(49, 25, 2, 1, 1, NULL),
(50, 30, 1, 1, 1, NULL),
(51, 30, 2, 1, 1, NULL),
(52, 31, 1, 1, 1, '2019-05-30 12:23:49'),
(53, 31, 2, 1, 1, '2019-05-30 12:23:49'),
(54, 26, 1, 1, 1, '2019-05-17 15:10:47'),
(55, 26, 2, 1, 1, '2019-05-17 15:10:47'),
(56, 27, 1, 1, 1, NULL),
(57, 27, 2, 1, 1, NULL),
(58, 28, 1, 1, 1, NULL),
(59, 28, 2, 1, 1, NULL),
(60, 29, 1, 1, 1, NULL),
(61, 29, 2, 1, 1, NULL),
(62, 32, 1, 1, 1, NULL),
(63, 32, 2, 1, 1, NULL);

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
(203, 11, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(204, 17, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(205, 21, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(206, 23, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(207, 3, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(208, 2, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(209, 7, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(210, 19, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(211, 15, 9, 0, 0, 0, 0, 1, 1, '2019-05-20 11:04:10'),
(212, 25, 1, 0, 0, 0, 0, 0, 1, '2019-05-03 15:35:54'),
(214, 27, 1, 1, 1, 1, 1, 1, 1, '2019-05-17 15:11:33'),
(216, 29, 1, 1, 1, 1, 1, 1, 1, '2019-05-17 15:11:33'),
(217, 36, 1, 0, 0, 0, 0, 0, 1, '2019-05-28 08:50:54'),
(253, 36, 11, 0, 0, 0, 0, 0, 1, '2019-05-28 08:52:06'),
(260, 9, 11, 0, 0, 0, 0, 0, 1, '2019-05-28 08:52:06'),
(266, 1, 11, 0, 0, 0, 0, 0, 1, '2019-05-28 08:52:06'),
(271, 13, 11, 0, 0, 0, 0, 0, 1, '2019-05-28 08:52:06'),
(296, 38, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(297, 40, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(298, 42, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(299, 44, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(300, 46, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(301, 48, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(302, 50, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(303, 34, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(304, 11, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(305, 17, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(306, 21, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(307, 23, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(308, 3, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(309, 2, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(310, 7, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(311, 19, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(312, 15, 11, 0, 0, 0, 0, 1, 1, '2019-05-28 09:19:22'),
(340, 38, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(341, 62, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(342, 40, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(343, 42, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(344, 44, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(345, 46, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(346, 48, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(347, 50, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(348, 54, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(349, 56, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(350, 58, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(351, 60, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(352, 34, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(353, 11, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(354, 17, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(355, 21, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(356, 23, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(357, 3, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(358, 2, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(359, 7, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(360, 19, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(361, 30, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(362, 52, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(363, 32, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(364, 26, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(365, 28, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27'),
(366, 15, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 09:20:27');

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
(6, 'Novedad 6', 'jlkgjlskj', 'novedad6', 11, 1, 1, 1, '2019-05-21 21:07:26', '2019-05-21 21:07:26'),
(7, 'Novedad 1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'https://www.youtube.com/', 12, 1, 1, 1, '2019-05-28 18:56:50', '2019-05-28 18:56:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objetivos`
--

CREATE TABLE `objetivos` (
  `id` int(10) UNSIGNED NOT NULL,
  `objetivo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `clasificacion` enum('HSE','CALIDAD') COLLATE utf8mb4_unicode_ci NOT NULL,
  `anio` smallint(5) UNSIGNED NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_respons_users` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `fk_usuActualiza_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `objetivos`
--

INSERT INTO `objetivos` (`id`, `objetivo`, `descripcion`, `clasificacion`, `anio`, `estado`, `fk_id_empresas`, `fk_respons_users`, `fk_usuCrea_users`, `fk_usuActualiza_users`, `created_at`, `updated_at`) VALUES
(1, 'Mi primer objetivo actualizado', 'Primera descripcion en el objetivo', 'CALIDAD', 2019, 1, 1, 2, 1, 1, '2019-06-11 04:56:40', '2019-06-11 04:57:12');

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
  `id_empresa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`id`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono1`, `telefono2`, `celular`, `email`, `email2`, `created_at`, `updated_at`, `regimen`, `representante`, `sexo`, `fec_nac`, `reside`, `tipo_persona`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `digito_verif`, `entidad`, `num_verif`, `autoretenedor`, `declarante`, `cliente`, `proveedor`, `id_vendedor`, `id_zona`, `plazo_pago`, `bloquear`, `cupo_credito`, `retenedor_fuente`, `retenedor_iva`, `excluido_iva`, `autoretefuente`, `autoreteiva`, `autoreteica`, `id_empresa`) VALUES
(1, 'Cristhiam', 'CEDULA', '1123201184', 'ccc', NULL, NULL, NULL, 'ccmonpan@hotmail.com', NULL, '2018-08-01 05:00:00', '2019-05-22 01:05:37', '', '', '', '0000-00-00', '', 'Natural', 'Cristhiam', 'Camilo', 'Monsalve', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(2, 'Jessica Murcia', 'NIT', '33333', 'lllllll', '34444', NULL, NULL, 'cccc@jjjj.com', NULL, '2018-07-08 02:02:10', '2018-07-11 10:37:16', '', '', '', '0000-00-00', '', '', 'Jessica', '', 'Murcia', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(3, 'Domenick', 'CE', '1123', 'kkkkk', '9999', NULL, NULL, 'cjcjc@ssss.com', NULL, '2018-07-08 12:20:52', '2018-07-11 10:37:10', '', '', '', '0000-00-00', '', '', '', '', '', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(4, 'Provedor1', 'CC', '90088777', '87788', '32222', NULL, NULL, 'cccccc@jjj.com', NULL, '2018-07-09 23:07:14', '2018-07-11 10:36:52', '', '', '', '0000-00-00', '', '', '', '', '', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(5, 'Rifas x', 'NIT', '908888', 'sdfosdfoi', '454545', NULL, NULL, 'lsdfskdjf@dsfdsf.xom', NULL, '2018-07-11 11:22:21', '2018-09-21 12:44:12', 'Comun', 'lsdfskdjf@dsfdsf.xom', 'Otro', '2018-07-01', 'asdfasdf ad fasd fasdf asf4', 'Juridica', NULL, NULL, NULL, NULL, 0, NULL, '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(6, '\'\'', 'CC', '45998888', 'jflasdjf aljsd flajsdf l', '3495959', NULL, NULL, 'htm@hot.com', NULL, '2018-08-04 07:49:37', '2018-08-04 07:49:37', 'Comun', NULL, 'Femenino', NULL, 'asdfasdfadsf', 'Natural', 'Marlon', '', 'Monsalve', '', 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(7, NULL, 'CC', '3839', 'jkjk', '777', NULL, NULL, 'lues@gg.com', NULL, '2018-08-04 08:04:37', '2018-08-04 08:04:37', 'Comun', NULL, 'Masculino', NULL, 'dfsdfsdf', 'Natural', 'Luis', '', 'Monsalve', '', 0, '', '', 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(8, 'Ismael', 'CC', '1085288369', 'barrio el jardin', '3203313824', NULL, NULL, 'fanfano312@hotmail.com', NULL, '2018-08-11 07:38:58', '2018-08-22 02:50:23', 'Simplificado', 'fanfano312@hotmail.com', 'Masculino', '1991-04-27', 'mocoa', 'Natural', 'ismael', NULL, 'cardenas', NULL, 0, '', '', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(9, 'Fabian', 'CC', '123', '123', '123', NULL, NULL, 'sss', NULL, '2018-08-22 20:04:53', '2018-08-22 20:04:53', 'Simplificado', NULL, 'Femenino', '2001-04-18', 'xxxx', 'Natural', 'Oscar', 'Fabian', 'Franco', 'Pantoja', 0, '', '', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(10, NULL, 'CC', '121212', NULL, NULL, NULL, NULL, NULL, NULL, '2018-08-31 01:51:06', '2019-05-20 22:05:43', 'Simplificado', NULL, 'Masculino', NULL, 'wwwww', 'Natural', 'Pepito', NULL, 'perez', NULL, 0, NULL, '', 2, 2, NULL, NULL, 2, 2, 13, 0, 1, 1, 0, 0, 0, 0, 0, 1),
(11, NULL, 'CC', '1123314444', 'Lagos', '3209086389', NULL, NULL, 'bianeydiaz2013@gmail.com', NULL, '2019-05-20 22:12:06', '2019-05-21 01:16:45', 'Simplificado', 'bianeydiaz2013@gmail.com', 'Femenino', '1997-02-21', 'ajlkjfl', 'Natural', 'Evelin', 'Bianey', 'Diaz', 'Tisoy', 0, 'Fractal', '', 1, 1, 1, 0, 2, 3, 31, NULL, 1, 1, 1, 1, 1, 1, 1, 1),
(12, 'Carlos Perez', 'CEDULA', '1124861370', 'B/ Kennedy', '3132235067', NULL, NULL, 'persan10@outlook.com', NULL, '2019-05-27 19:50:58', '2019-05-27 19:50:58', '', NULL, '', NULL, '', '', NULL, NULL, NULL, NULL, 0, 'Fractal', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planes_accion`
--

CREATE TABLE `planes_accion` (
  `id` int(10) UNSIGNED NOT NULL,
  `planAccion` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `anio` smallint(5) UNSIGNED NOT NULL,
  `puntaje` smallint(5) UNSIGNED NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_id_procesos` int(10) UNSIGNED NOT NULL,
  `fk_respons_users` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `fk_usuActualiza_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `planes_accion`
--

INSERT INTO `planes_accion` (`id`, `planAccion`, `anio`, `puntaje`, `estado`, `fk_id_empresas`, `fk_id_procesos`, `fk_respons_users`, `fk_usuCrea_users`, `fk_usuActualiza_users`, `created_at`, `updated_at`) VALUES
(1, 'Primer plan de acción semiactualizado', 2021, 93, 1, 1, 3, 11, 1, 1, '2019-05-19 09:33:53', '2019-05-31 03:50:16'),
(2, 'El plan principal', 2019, 91, 1, 1, 3, 1, 1, 1, '2019-05-28 03:35:00', '2019-06-01 22:24:25'),
(3, 'Plan para pruebas de correo', 2019, 49, 1, 1, 4, 11, 1, 1, '2019-05-31 03:54:01', '2019-05-31 03:54:01'),
(4, 'PLAN DE PRUEBA', 2019, 50, 1, 1, 3, 1, 1, 1, '2019-06-01 22:40:10', '2019-06-01 22:40:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planes_accion_proyectos`
--

CREATE TABLE `planes_accion_proyectos` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_id_planes_accion` int(10) UNSIGNED NOT NULL,
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_id_proyectos` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `planes_accion_proyectos`
--

INSERT INTO `planes_accion_proyectos` (`id`, `fk_id_planes_accion`, `fk_id_empresas`, `fk_id_proyectos`, `fk_usuCrea_users`, `created_at`, `updated_at`) VALUES
(22, 1, 1, 4, 1, NULL, NULL),
(23, 1, 1, 1, 1, NULL, NULL),
(24, 3, 1, 5, 1, NULL, NULL),
(42, 2, 1, 5, 1, NULL, NULL),
(44, 4, 1, 4, 1, NULL, NULL),
(45, 4, 1, 2, 1, NULL, NULL),
(46, 4, 1, 3, 1, NULL, NULL);

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
  `id_tercero` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `plan_cuentas`
--

INSERT INTO `plan_cuentas` (`id`, `codigo`, `nombre`, `naturaleza`, `tipo`, `corriente`, `banco`, `diferido`, `tercero`, `niif`, `id_empresa`, `condicion`, `created_at`, `updated_at`, `anio`, `id_cuenta_cierre`, `evitar_saldo_negativo`, `id_tercero`) VALUES
(1, '1', 'ACTIVOS', 'Debito', 'Titulo', 0, 0, 0, NULL, '1', 1, 1, NULL, '2019-05-28 19:59:35', 2018, 19, 0, 11),
(2, '2', 'PASIVOS', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '2', 1, 1, '2018-06-16 20:43:36', '2018-06-16 20:43:36', 2018, NULL, 0, NULL),
(3, '3', 'PATRIMONIO', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '3', 1, 1, '2018-06-16 20:47:30', '2018-06-16 20:47:30', 2018, NULL, 0, NULL),
(4, '110505', 'CAJA GENERAL', 'Debito', 'Detalle', 0, 1, NULL, NULL, '110505', 1, 1, '2018-07-09 21:32:18', '2018-08-30 00:07:34', 2018, NULL, 0, NULL),
(5, '11', 'DISPONIBLE', 'Debito', 'Titulo', 0, 0, NULL, NULL, '11', 1, 1, '2018-07-17 10:24:40', '2019-05-22 01:01:29', 2018, 1, 0, NULL),
(6, '1105', 'CAJA', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1105', 1, 1, '2018-07-17 10:25:18', '2018-07-17 10:31:04', 2018, NULL, 0, NULL),
(8, '110515', 'CAJAS MENORES', 'Debito', 'Detalle', 1, 0, NULL, NULL, '110515', 1, 1, '2018-07-17 10:27:02', '2018-07-17 10:31:19', 2018, NULL, 0, NULL),
(9, '1110', 'BANCOS', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1110', 1, 1, '2018-07-17 10:28:08', '2018-07-17 10:31:23', 2018, NULL, 0, NULL),
(11, '111005', 'MONEDA NACIONAL - BANCOS', 'Debito', 'Detalle', 1, 1, NULL, NULL, '111005', 1, 1, '2018-07-17 10:29:49', '2018-08-30 00:06:54', 2018, NULL, 0, NULL),
(12, '1115', 'REMESAS EN TRANSITO', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1115', 1, 1, '2018-07-17 10:30:17', '2018-07-17 10:32:51', 2018, NULL, 0, NULL),
(13, '111505', 'MONEDA NACIONAL', 'Debito', 'Detalle', 1, 0, NULL, NULL, '111505', 1, 1, '2018-07-17 10:30:52', '2018-07-17 10:31:36', 2018, NULL, 0, NULL),
(14, '1120', 'CUENTAS DE AHORRO', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '1120', 1, 1, '2018-07-17 10:33:44', '2018-07-17 10:33:44', 2018, NULL, 0, NULL),
(15, '112005', 'BANCOS', 'Debito', 'Detalle', 1, 0, NULL, NULL, '112005', 1, 1, '2018-07-17 10:34:41', '2018-07-17 10:34:41', 2018, NULL, 0, NULL),
(16, '12', 'INVERSIONES', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '12', 1, 1, '2018-07-17 10:38:46', '2018-07-17 10:38:46', 2018, NULL, 0, NULL),
(17, '5', 'GASTOS', 'Debito', 'Titulo', 0, 0, NULL, NULL, '5', 1, 1, '2018-08-29 23:58:50', '2018-08-29 23:58:50', 2018, NULL, 0, NULL),
(18, '51', 'OPERACIONES DE ADMINISTRACION', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '51', 1, 1, '2018-08-29 23:59:19', '2018-08-29 23:59:19', 2018, NULL, 0, NULL),
(19, '5110', 'HONORARIOS', 'Debito', 'Titulo', NULL, 0, NULL, NULL, '5110', 1, 1, '2018-08-30 00:00:01', '2018-08-30 00:00:01', 2018, NULL, 0, NULL),
(20, '511095', 'OTROS HONORARIOS', 'Debito', 'Detalle', NULL, 0, NULL, NULL, '511095', 1, 1, '2018-08-30 00:00:49', '2018-08-30 00:00:49', 2018, NULL, 0, NULL),
(21, '23', 'CUENTAS POR PAGAR', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '23', 1, 1, '2018-08-30 00:20:37', '2018-08-30 00:20:37', 2018, NULL, 0, NULL),
(22, '2335', 'COSTOS Y GASTOS POR PAGAR', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '2335', 1, 1, '2018-08-30 00:21:11', '2018-08-30 00:21:11', 2018, NULL, 0, NULL),
(23, '233525', 'HONORARIOS', 'Credito', 'Detalle', NULL, 0, NULL, NULL, '233525', 1, 1, '2018-08-30 00:21:42', '2018-08-30 00:21:42', 2018, NULL, 0, NULL),
(24, '2365', 'RETENCION EN LA FUENTE', 'Credito', 'Titulo', NULL, 0, NULL, NULL, '2365', 2, 1, '2018-08-30 00:22:35', '2018-08-30 00:22:35', 2018, NULL, 0, NULL),
(25, '236515', 'HONORARIOS (RTE FTE)', 'Credito', 'Detalle', NULL, 0, NULL, NULL, '236515', 2, 1, '2018-08-30 00:24:18', '2018-08-30 00:24:18', 2018, NULL, 0, NULL),
(26, '23652501', 'RETENCION EN SERVICIOS DECLARANTE', 'Credito', 'Detalle', NULL, 0, NULL, NULL, '23652501', 1, 1, '2019-05-15 05:42:36', '2019-05-15 05:42:36', 2019, NULL, 0, NULL);

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
(13, 1, 2, 1, '2019-05-28 19:59:36', '2019-05-28 19:59:36'),
(14, 1, 3, 1, '2019-05-28 19:59:36', '2019-05-28 19:59:36');

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

--
-- Volcado de datos para la tabla `presentacion`
--

INSERT INTO `presentacion` (`id`, `nombre`, `estado`, `id_empresa`, `usu_crea`, `created_at`, `updated_at`) VALUES
(1, 'Presentación 1', 1, 1, 1, NULL, NULL),
(2, 'Presentación 3', 1, 1, 1, NULL, '2019-02-13 01:40:48'),
(3, 'Presentación 2', 1, 1, 1, '2019-02-13 01:41:13', '2019-02-13 01:41:13'),
(6, '444444444444', 1, 2, 1, '2019-02-15 02:33:25', '2019-05-28 02:06:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `procesos`
--

CREATE TABLE `procesos` (
  `id` int(10) UNSIGNED NOT NULL,
  `proceso` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipoProceso` enum('HSE','CALIDAD') COLLATE utf8mb4_unicode_ci NOT NULL,
  `observacion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `fk_usuActualiza_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `procesos`
--

INSERT INTO `procesos` (`id`, `proceso`, `tipoProceso`, `observacion`, `estado`, `fk_id_empresas`, `fk_usuCrea_users`, `fk_usuActualiza_users`, `created_at`, `updated_at`) VALUES
(1, 'EL PRIMER PROCESO', 'CALIDAD', '', 1, 1, 11, 1, '2019-05-03 14:18:40', '2019-05-03 14:18:42'),
(2, 'My first process', 'CALIDAD', 'Ninguna', 0, 1, 1, 1, '2019-05-04 02:04:37', '2019-05-28 01:39:58'),
(3, 'El ultimo proceso', 'HSE', 'Tabulacion de resultados', 1, 1, 1, 1, '2019-05-04 03:46:07', '2019-05-27 21:15:07'),
(4, 'El mejor proceso actualizado', 'HSE', 'Este proceso se ha actualizado', 1, 1, 1, 1, '2019-05-27 21:13:40', '2019-05-27 21:14:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `procesos_proyectos`
--

CREATE TABLE `procesos_proyectos` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_id_procesos` int(10) UNSIGNED NOT NULL,
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_id_proyectos` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `procesos_proyectos`
--

INSERT INTO `procesos_proyectos` (`id`, `fk_id_procesos`, `fk_id_empresas`, `fk_id_proyectos`, `fk_usuCrea_users`, `created_at`, `updated_at`) VALUES
(1, 3, 1, 4, 1, NULL, NULL),
(4, 4, 1, 5, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_tarifarios`
--

CREATE TABLE `productos_tarifarios` (
  `id` int(11) NOT NULL,
  `id_tarifario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `valor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `productos_tarifarios`
--

INSERT INTO `productos_tarifarios` (`id`, `id_tarifario`, `id_producto`, `valor`) VALUES
(13, 1, 2, 0),
(14, 2, 2, 2),
(15, 3, 2, 50),
(16, 1, 1, 100),
(17, 2, 1, 1),
(18, 3, 1, 100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos`
--

CREATE TABLE `proyectos` (
  `id` int(10) UNSIGNED NOT NULL,
  `proyecto` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correoProductOwner` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_respons_users` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `fk_usuActualiza_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proyectos`
--

INSERT INTO `proyectos` (`id`, `proyecto`, `descripcion`, `correoProductOwner`, `estado`, `fk_id_empresas`, `fk_respons_users`, `fk_usuCrea_users`, `fk_usuActualiza_users`, `created_at`, `updated_at`) VALUES
(1, 'Proyecto primario actualizado', 'Actualizacion de prueba', 'fab_enter@gulp.com', 1, 1, 9, 1, 1, '2019-05-13 21:44:12', '2019-05-28 01:54:19'),
(2, 'Otro proyecto mas', 'Ninguna', 'cris@enterprise.com', 1, 1, 1, 1, 1, '2019-05-14 00:35:50', '2019-05-28 01:39:27'),
(3, 'Mi proyecto de prueba', 'Nada', 'elcorreo@empresa.com', 2, 1, 9, 1, 1, '2019-05-14 00:36:18', '2019-05-15 22:30:05'),
(4, 'El mini proyecto', 'Alguna descripcion generica y convincente', 'fbn@elcorre.com', 2, 1, 9, 1, 1, '2019-05-14 22:26:55', '2019-05-15 22:30:19'),
(5, 'Proyecto remoto actualizado', 'Creado para gestion', 'anon@net@mail.com', 0, 1, 11, 1, 1, '2019-05-28 00:59:38', '2019-05-28 01:57:47');

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
(3, 'ACTIVOS INGRESO', 1, 'Debito', 0, 0, 1, 2, 4, 1, 1, 1, '2019-05-11 00:18:52', '2019-05-28 21:33:17');

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
(208, 1, 19, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(209, 1, 20, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(210, 1, 32, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(211, 1, 21, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(212, 1, 22, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(213, 1, 23, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(214, 1, 24, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(215, 1, 25, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(216, 1, 26, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(217, 1, 30, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(218, 1, 27, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(219, 1, 28, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(220, 1, 29, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(221, 1, 5, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(222, 1, 18, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(223, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(224, 1, 9, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(225, 1, 11, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(226, 1, 12, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(227, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(228, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(229, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(230, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(231, 1, 10, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(232, 1, 13, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(233, 1, 16, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(234, 1, 31, 1, 0, 0, 0, 0, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(235, 1, 17, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(236, 1, 14, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(237, 1, 15, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(238, 1, 7, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35'),
(239, 1, 8, 1, 1, 1, 1, 1, 1, 1, 1, '2019-06-04 18:59:35', '2019-06-04 18:59:35');

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

--
-- Volcado de datos para la tabla `stock`
--

INSERT INTO `stock` (`id`, `id_producto`, `id_facturacion`, `id_usuario`, `fec_crea`, `cantidad`, `tipo_movimiento`, `sumatoria`, `condicion`, `id_empresa`, `created_at`, `updated_at`) VALUES
(1, 1, 0, 1, '2019-05-27 13:40:58', 100, 1, 100.00, 1, 1, '2019-05-27 18:40:58', '2019-05-27 18:40:58'),
(2, 2, NULL, 1, '2019-05-27 13:46:48', 100, 1, 100.00, 1, 1, '2019-05-27 18:46:48', '2019-05-27 18:46:48'),
(3, 3, NULL, 1, '2019-05-27 13:49:30', 100, 1, 100.00, 1, 1, '2019-05-27 18:49:30', '2019-05-27 18:49:30'),
(4, 1, NULL, 1, '2019-05-27 14:12:03', 5, 2, 0.00, 1, 1, '2019-05-27 19:12:03', '2019-05-27 19:12:03'),
(5, 2, NULL, 1, '2019-05-27 14:12:03', 10, 2, 0.00, 1, 1, '2019-05-27 19:12:03', '2019-05-27 19:12:03'),
(6, 2, NULL, 1, '2019-05-27 14:24:22', 50, 3, 0.00, 1, 1, '2019-05-27 19:24:22', '2019-05-27 19:24:22'),
(7, 1, 1, 1, '2019-05-27 16:26:31', 1, 4, 0.00, 1, 1, '2019-05-27 21:26:31', '2019-05-27 21:26:31'),
(8, 2, 1, 1, '2019-05-27 16:26:31', 1, 4, 0.00, 1, 1, '2019-05-27 21:26:31', '2019-05-27 21:26:31'),
(9, 2, 2, 1, '2019-05-27 16:27:10', 1, 4, 0.00, 1, 1, '2019-05-27 21:27:10', '2019-05-27 21:27:10'),
(10, 1, NULL, 1, '2019-05-27 20:02:31', 1, 2, 0.00, 1, 1, '2019-05-28 01:02:31', '2019-05-28 01:02:31'),
(11, 1, NULL, 1, '2019-05-27 20:07:22', 6, 3, 0.00, 1, 1, '2019-05-28 01:07:22', '2019-05-28 01:07:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_carpetas`
--

CREATE TABLE `tipos_carpetas` (
  `id` int(10) UNSIGNED NOT NULL,
  `tipoCarpeta` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipos_carpetas`
--

INSERT INTO `tipos_carpetas` (`id`, `tipoCarpeta`, `estado`, `fk_id_empresas`, `fk_usuCrea_users`, `created_at`, `updated_at`) VALUES
(1, 'Tipo carpeta 1', 1, 1, 1, NULL, NULL),
(2, 'Tipo carpeta 2', 1, 1, 1, NULL, NULL),
(3, 'Tipo carpeta 3', 1, 1, 1, NULL, NULL),
(4, 'Tipo carpeta 4', 1, 1, 1, NULL, NULL),
(5, 'Tipo carpeta 5', 1, 1, 1, NULL, NULL);

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

--
-- Volcado de datos para la tabla `und_medidas`
--

INSERT INTO `und_medidas` (`id`, `nombre`, `estado`, `id_empresa`, `usu_crea`, `created_at`, `updated_at`) VALUES
(1, 'Unidad 1', 1, 1, 1, NULL, '2019-05-28 02:22:51'),
(2, 'Unidad 2', 1, 1, 1, NULL, NULL),
(3, 'Unidad 3', 1, 2, 1, '2019-02-13 02:00:08', '2019-05-27 19:42:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `usuario` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_completo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `idrol` int(10) UNSIGNED NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `empresas_id` int(10) UNSIGNED NOT NULL,
  `personas_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre_completo`, `password`, `condicion`, `idrol`, `remember_token`, `empresas_id`, `personas_id`) VALUES
(1, 'cristhiam', 'cristhiam camilo monsalve', '$2y$10$uINPVrLKmyXN4/5/0ScOJOVpxtPwUcBcxxQMBQdiI14KQbl6I/Bqu', 1, 1, '1wy55IBLzn0CnyD7xs6duS7ao8rLjBbfCs5SHLEW0DcVMe5JcrtJqf1dJ5aw', 1, 1),
(2, 'jessica', 'jessica murcia', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'M7JgIZYa1SfrgoD3GAQy53NSngaceRtHydF3OSnE2I6TB5MlGfJBsDc7f63e', 1, 2),
(8, 'ismael', 'ismael cardenas', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'wo8sErJvqxHw6lqjANBc726TFZ77DUE4FjoCr8shrQh3weAFc5OU99HVPQJH', 1, 8),
(9, 'fabian', 'oscar fabian franco', '$2a$04$sFjAmm8DXjqbVqFSljmMmOj2EMwEFJpodtSBx61eCq5c4CM4pCI8a', 1, 1, 'hf8naR2ipDSJscD6wr54QRQLtBPQIEDetSPQRFJim6e7xDVyaFVVgwIKh61O', 2, 9),
(11, 'charles', 'carlos alberto perez', '$2y$10$t4jdsejOj3Y/xunrOP8Zb.JV0ibzsBTL9g8/KY9u1RN.RTHVTuTgi', 1, 83, 'cA6gXCeDrJYOyVBLCdVZMUm64QMpmtzpAElyvQ0rpsoO8fVtsw24dZsWjiTZ', 1, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_actividades`
--

CREATE TABLE `usuarios_actividades` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_id_actividades` int(10) UNSIGNED NOT NULL,
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_id_users` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios_actividades`
--

INSERT INTO `usuarios_actividades` (`id`, `fk_id_actividades`, `fk_id_empresas`, `fk_id_users`, `fk_usuCrea_users`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 11, 1, NULL, NULL),
(2, 1, 1, 1, 1, NULL, NULL),
(3, 3, 1, 11, 1, NULL, NULL),
(10, 4, 1, 8, 1, NULL, NULL),
(11, 4, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_proyectos`
--

CREATE TABLE `usuarios_proyectos` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_id_empresas` int(10) UNSIGNED NOT NULL,
  `fk_id_proyectos` int(10) UNSIGNED NOT NULL,
  `fk_usuAsoc_users` int(10) UNSIGNED NOT NULL,
  `fk_usuCrea_users` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios_proyectos`
--

INSERT INTO `usuarios_proyectos` (`id`, `fk_id_empresas`, `fk_id_proyectos`, `fk_usuAsoc_users`, `fk_usuCrea_users`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 11, 1, NULL, NULL),
(2, 1, 3, 1, 1, NULL, NULL),
(3, 1, 1, 1, 1, NULL, NULL),
(4, 1, 4, 11, 1, NULL, NULL),
(7, 1, 5, 9, 1, NULL, NULL);

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
-- Indices de la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_empresas` (`fk_id_empresas`),
  ADD KEY `fk_planAsoc_planes_accion` (`fk_planAsoc_planes_accion`),
  ADD KEY `fk_id_planes_accion` (`fk_id_planes_accion`),
  ADD KEY `fk_id_procesos` (`fk_id_procesos`),
  ADD KEY `fk_id_proyectos` (`fk_id_proyectos`),
  ADD KEY `fk_usuCrea_users` (`fk_usuCrea_users`),
  ADD KEY `fk_usuActualiza_users` (`fk_usuActualiza_users`);

--
-- Indices de la tabla `archivos_procesos`
--
ALTER TABLE `archivos_procesos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_carpetas_procesos` (`fk_id_carpetas_procesos`),
  ADD KEY `fk_id_empresas` (`fk_id_empresas`),
  ADD KEY `fk_usuCrea_users` (`fk_usuCrea_users`);

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `articulos_nombre_unique` (`nombre`),
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
-- Indices de la tabla `cargos`
--
ALTER TABLE `cargos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_empresas` (`fk_id_empresas`),
  ADD KEY `fk_usuCrea_users` (`fk_usuCrea_users`),
  ADD KEY `fk_usuActualiza_users` (`fk_usuActualiza_users`);

--
-- Indices de la tabla `carpetas_procesos`
--
ALTER TABLE `carpetas_procesos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_empresas` (`fk_id_empresas`),
  ADD KEY `fk_id_procesos` (`fk_id_procesos`),
  ADD KEY `fk_id_tipos_carpetas` (`fk_id_tipos_carpetas`),
  ADD KEY `fk_usuCrea_users` (`fk_usuCrea_users`),
  ADD KEY `fk_usuActualiza_users` (`fk_usuActualiza_users`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `categorias2`
--
ALTER TABLE `categorias2`
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
  ADD PRIMARY KEY (`id`),
  ADD KEY `usu_crea` (`usu_crea`);

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
-- Indices de la tabla `indicadores`
--
ALTER TABLE `indicadores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `indicadores_fk_id_empresas_foreign` (`fk_id_empresas`),
  ADD KEY `indicadores_fk_id_objetivos_foreign` (`fk_id_objetivos`),
  ADD KEY `indicadores_fk_usucrea_users_foreign` (`fk_usuCrea_users`),
  ADD KEY `indicadores_fk_usuactualiza_users_foreign` (`fk_usuActualiza_users`);

--
-- Indices de la tabla `indicadores_actividades`
--
ALTER TABLE `indicadores_actividades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `indicadores_actividades_fk_id_actividades_foreign` (`fk_id_actividades`),
  ADD KEY `indicadores_actividades_fk_id_empresas_foreign` (`fk_id_empresas`),
  ADD KEY `indicadores_actividades_fk_id_indicadores_foreign` (`fk_id_indicadores`),
  ADD KEY `indicadores_actividades_fk_usucrea_users_foreign` (`fk_usuCrea_users`);

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
-- Indices de la tabla `objetivos`
--
ALTER TABLE `objetivos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `objetivos_fk_id_empresas_foreign` (`fk_id_empresas`),
  ADD KEY `objetivos_fk_respons_users_foreign` (`fk_respons_users`),
  ADD KEY `objetivos_fk_usucrea_users_foreign` (`fk_usuCrea_users`),
  ADD KEY `objetivos_fk_usuactualiza_users_foreign` (`fk_usuActualiza_users`);

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
-- Indices de la tabla `planes_accion`
--
ALTER TABLE `planes_accion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_empresas` (`fk_id_empresas`),
  ADD KEY `fk_id_procesos` (`fk_id_procesos`),
  ADD KEY `fk_respons_users` (`fk_respons_users`),
  ADD KEY `fk_usuCrea_users` (`fk_usuCrea_users`),
  ADD KEY `fk_usuActualiza_users` (`fk_usuActualiza_users`);

--
-- Indices de la tabla `planes_accion_proyectos`
--
ALTER TABLE `planes_accion_proyectos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_planes_accion` (`fk_id_planes_accion`),
  ADD KEY `fk_id_empresas` (`fk_id_empresas`),
  ADD KEY `fk_id_proyectos` (`fk_id_proyectos`),
  ADD KEY `fk_usuCrea_users` (`fk_usuCrea_users`);

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
-- Indices de la tabla `procesos`
--
ALTER TABLE `procesos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_empresas` (`fk_id_empresas`),
  ADD KEY `fk_usuCrea_users` (`fk_usuCrea_users`),
  ADD KEY `fk_usuActualiza_users` (`fk_usuActualiza_users`);

--
-- Indices de la tabla `procesos_proyectos`
--
ALTER TABLE `procesos_proyectos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_procesos` (`fk_id_procesos`),
  ADD KEY `fk_id_empresas` (`fk_id_empresas`),
  ADD KEY `fk_id_proyectos` (`fk_id_proyectos`),
  ADD KEY `fk_usuCrea_users` (`fk_usuCrea_users`);

--
-- Indices de la tabla `productos_tarifarios`
--
ALTER TABLE `productos_tarifarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_empresas` (`fk_id_empresas`),
  ADD KEY `fk_respons_users` (`fk_respons_users`),
  ADD KEY `fk_usuCrea_users` (`fk_usuCrea_users`),
  ADD KEY `fk_usuActualiza_users` (`fk_usuActualiza_users`);

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
-- Indices de la tabla `tipos_carpetas`
--
ALTER TABLE `tipos_carpetas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_empresas` (`fk_id_empresas`),
  ADD KEY `fk_usuCrea_users` (`fk_usuCrea_users`);

--
-- Indices de la tabla `und_medidas`
--
ALTER TABLE `und_medidas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`),
  ADD KEY `users_id_foreign` (`id`),
  ADD KEY `users_idrol_foreign` (`idrol`),
  ADD KEY `empresas_id` (`empresas_id`),
  ADD KEY `personas_id` (`personas_id`);

--
-- Indices de la tabla `usuarios_actividades`
--
ALTER TABLE `usuarios_actividades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_actividades` (`fk_id_actividades`),
  ADD KEY `fk_id_empresas` (`fk_id_empresas`),
  ADD KEY `fk_id_users` (`fk_id_users`),
  ADD KEY `fk_usuCrea_users` (`fk_usuCrea_users`);

--
-- Indices de la tabla `usuarios_proyectos`
--
ALTER TABLE `usuarios_proyectos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_empresas` (`fk_id_empresas`),
  ADD KEY `fk_id_proyectos` (`fk_id_proyectos`),
  ADD KEY `fk_usuAsoc_users` (`fk_usuAsoc_users`),
  ADD KEY `fk_usuCrea_users` (`fk_usuCrea_users`);

--
-- Indices de la tabla `zona`
--
ALTER TABLE `zona`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividades`
--
ALTER TABLE `actividades`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `archivos_procesos`
--
ALTER TABLE `archivos_procesos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `bancos`
--
ALTER TABLE `bancos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cargos`
--
ALTER TABLE `cargos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `carpetas_procesos`
--
ALTER TABLE `carpetas_procesos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `categorias2`
--
ALTER TABLE `categorias2`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `colaboradores`
--
ALTER TABLE `colaboradores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `concentraciones`
--
ALTER TABLE `concentraciones`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `conf_formatos`
--
ALTER TABLE `conf_formatos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `con_tarifarios`
--
ALTER TABLE `con_tarifarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de la tabla `detalle_egresos`
--
ALTER TABLE `detalle_egresos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `detalle_facturacion`
--
ALTER TABLE `detalle_facturacion`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalle_ingresos`
--
ALTER TABLE `detalle_ingresos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `docs_formatos`
--
ALTER TABLE `docs_formatos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `egresos`
--
ALTER TABLE `egresos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `facturacion`
--
ALTER TABLE `facturacion`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `formatos`
--
ALTER TABLE `formatos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `indicadores`
--
ALTER TABLE `indicadores`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `indicadores_actividades`
--
ALTER TABLE `indicadores_actividades`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `informes_contables`
--
ALTER TABLE `informes_contables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ingresos`
--
ALTER TABLE `ingresos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `modulos_empresas`
--
ALTER TABLE `modulos_empresas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT de la tabla `modulos_empresas_usuarios`
--
ALTER TABLE `modulos_empresas_usuarios`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=367;

--
-- AUTO_INCREMENT de la tabla `novedades`
--
ALTER TABLE `novedades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `objetivos`
--
ALTER TABLE `objetivos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `planes_accion`
--
ALTER TABLE `planes_accion`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `planes_accion_proyectos`
--
ALTER TABLE `planes_accion_proyectos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `procesos`
--
ALTER TABLE `procesos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `procesos_proyectos`
--
ALTER TABLE `procesos_proyectos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `productos_tarifarios`
--
ALTER TABLE `productos_tarifarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=240;

--
-- AUTO_INCREMENT de la tabla `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tipos_carpetas`
--
ALTER TABLE `tipos_carpetas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `und_medidas`
--
ALTER TABLE `und_medidas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios_actividades`
--
ALTER TABLE `usuarios_actividades`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `usuarios_proyectos`
--
ALTER TABLE `usuarios_proyectos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `zona`
--
ALTER TABLE `zona`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD CONSTRAINT `actividades_ibfk_1` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `actividades_ibfk_2` FOREIGN KEY (`fk_planAsoc_planes_accion`) REFERENCES `planes_accion` (`id`),
  ADD CONSTRAINT `actividades_ibfk_3` FOREIGN KEY (`fk_id_planes_accion`) REFERENCES `planes_accion` (`id`),
  ADD CONSTRAINT `actividades_ibfk_4` FOREIGN KEY (`fk_id_procesos`) REFERENCES `procesos` (`id`),
  ADD CONSTRAINT `actividades_ibfk_5` FOREIGN KEY (`fk_id_proyectos`) REFERENCES `proyectos` (`id`),
  ADD CONSTRAINT `actividades_ibfk_6` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `actividades_ibfk_7` FOREIGN KEY (`fk_usuActualiza_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `archivos_procesos`
--
ALTER TABLE `archivos_procesos`
  ADD CONSTRAINT `archivos_procesos_ibfk_1` FOREIGN KEY (`fk_id_carpetas_procesos`) REFERENCES `carpetas_procesos` (`id`),
  ADD CONSTRAINT `archivos_procesos_ibfk_2` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `archivos_procesos_ibfk_3` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `cargos`
--
ALTER TABLE `cargos`
  ADD CONSTRAINT `cargos_ibfk_1` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `cargos_ibfk_2` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `cargos_ibfk_3` FOREIGN KEY (`fk_usuActualiza_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `carpetas_procesos`
--
ALTER TABLE `carpetas_procesos`
  ADD CONSTRAINT `carpetas_procesos_ibfk_1` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `carpetas_procesos_ibfk_2` FOREIGN KEY (`fk_id_procesos`) REFERENCES `procesos` (`id`),
  ADD CONSTRAINT `carpetas_procesos_ibfk_3` FOREIGN KEY (`fk_id_tipos_carpetas`) REFERENCES `tipos_carpetas` (`id`),
  ADD CONSTRAINT `carpetas_procesos_ibfk_4` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `carpetas_procesos_ibfk_5` FOREIGN KEY (`fk_usuActualiza_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD CONSTRAINT `empresas_ibfk_1` FOREIGN KEY (`usu_crea`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `indicadores`
--
ALTER TABLE `indicadores`
  ADD CONSTRAINT `indicadores_fk_id_empresas_foreign` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `indicadores_fk_id_objetivos_foreign` FOREIGN KEY (`fk_id_objetivos`) REFERENCES `objetivos` (`id`),
  ADD CONSTRAINT `indicadores_fk_usuactualiza_users_foreign` FOREIGN KEY (`fk_usuActualiza_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `indicadores_fk_usucrea_users_foreign` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `indicadores_actividades`
--
ALTER TABLE `indicadores_actividades`
  ADD CONSTRAINT `indicadores_actividades_fk_id_actividades_foreign` FOREIGN KEY (`fk_id_actividades`) REFERENCES `actividades` (`id`),
  ADD CONSTRAINT `indicadores_actividades_fk_id_empresas_foreign` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `indicadores_actividades_fk_id_indicadores_foreign` FOREIGN KEY (`fk_id_indicadores`) REFERENCES `indicadores` (`id`),
  ADD CONSTRAINT `indicadores_actividades_fk_usucrea_users_foreign` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD CONSTRAINT `modulos_usu_crea_foreign` FOREIGN KEY (`usu_crea`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `modulos_empresas`
--
ALTER TABLE `modulos_empresas`
  ADD CONSTRAINT `modulos_empresas_ibfk_1` FOREIGN KEY (`usu_crea`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `modulos_empresas_ibfk_2` FOREIGN KEY (`modulos_id`) REFERENCES `modulos` (`id`),
  ADD CONSTRAINT `modulos_empresas_ibfk_3` FOREIGN KEY (`empresas_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `modulos_empresas_usuarios`
--
ALTER TABLE `modulos_empresas_usuarios`
  ADD CONSTRAINT `modulos_empresas_usuarios_ibfk_1` FOREIGN KEY (`usu_crea`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `modulos_empresas_usuarios_ibfk_2` FOREIGN KEY (`modulos_empresas_id`) REFERENCES `modulos_empresas` (`id`),
  ADD CONSTRAINT `modulos_empresas_usuarios_ibfk_3` FOREIGN KEY (`usuarios_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `objetivos`
--
ALTER TABLE `objetivos`
  ADD CONSTRAINT `objetivos_fk_id_empresas_foreign` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `objetivos_fk_respons_users_foreign` FOREIGN KEY (`fk_respons_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `objetivos_fk_usuactualiza_users_foreign` FOREIGN KEY (`fk_usuActualiza_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `objetivos_fk_usucrea_users_foreign` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `planes_accion`
--
ALTER TABLE `planes_accion`
  ADD CONSTRAINT `planes_accion_ibfk_1` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `planes_accion_ibfk_2` FOREIGN KEY (`fk_id_procesos`) REFERENCES `procesos` (`id`),
  ADD CONSTRAINT `planes_accion_ibfk_3` FOREIGN KEY (`fk_respons_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `planes_accion_ibfk_4` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `planes_accion_ibfk_5` FOREIGN KEY (`fk_usuActualiza_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `planes_accion_proyectos`
--
ALTER TABLE `planes_accion_proyectos`
  ADD CONSTRAINT `planes_accion_proyectos_ibfk_1` FOREIGN KEY (`fk_id_planes_accion`) REFERENCES `planes_accion` (`id`),
  ADD CONSTRAINT `planes_accion_proyectos_ibfk_2` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `planes_accion_proyectos_ibfk_3` FOREIGN KEY (`fk_id_proyectos`) REFERENCES `proyectos` (`id`),
  ADD CONSTRAINT `planes_accion_proyectos_ibfk_4` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `procesos`
--
ALTER TABLE `procesos`
  ADD CONSTRAINT `procesos_ibfk_1` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `procesos_ibfk_2` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `procesos_ibfk_3` FOREIGN KEY (`fk_usuActualiza_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `procesos_proyectos`
--
ALTER TABLE `procesos_proyectos`
  ADD CONSTRAINT `procesos_proyectos_ibfk_1` FOREIGN KEY (`fk_id_procesos`) REFERENCES `procesos` (`id`),
  ADD CONSTRAINT `procesos_proyectos_ibfk_2` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `procesos_proyectos_ibfk_3` FOREIGN KEY (`fk_id_proyectos`) REFERENCES `proyectos` (`id`),
  ADD CONSTRAINT `procesos_proyectos_ibfk_4` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD CONSTRAINT `proyectos_ibfk_1` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `proyectos_ibfk_2` FOREIGN KEY (`fk_respons_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `proyectos_ibfk_3` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `proyectos_ibfk_4` FOREIGN KEY (`fk_usuActualiza_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `roles_permisos`
--
ALTER TABLE `roles_permisos`
  ADD CONSTRAINT `roles_permisos_ibfk_1` FOREIGN KEY (`usu_crea`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `tipos_carpetas`
--
ALTER TABLE `tipos_carpetas`
  ADD CONSTRAINT `tipos_carpetas_ibfk_1` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `tipos_carpetas_ibfk_2` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`empresas_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`personas_id`) REFERENCES `personas` (`id`),
  ADD CONSTRAINT `users_idrol_foreign` FOREIGN KEY (`idrol`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `usuarios_actividades`
--
ALTER TABLE `usuarios_actividades`
  ADD CONSTRAINT `usuarios_actividades_ibfk_1` FOREIGN KEY (`fk_id_actividades`) REFERENCES `actividades` (`id`),
  ADD CONSTRAINT `usuarios_actividades_ibfk_2` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `usuarios_actividades_ibfk_3` FOREIGN KEY (`fk_id_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `usuarios_actividades_ibfk_4` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `usuarios_proyectos`
--
ALTER TABLE `usuarios_proyectos`
  ADD CONSTRAINT `usuarios_proyectos_ibfk_1` FOREIGN KEY (`fk_id_empresas`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `usuarios_proyectos_ibfk_2` FOREIGN KEY (`fk_id_proyectos`) REFERENCES `proyectos` (`id`),
  ADD CONSTRAINT `usuarios_proyectos_ibfk_3` FOREIGN KEY (`fk_usuAsoc_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `usuarios_proyectos_ibfk_4` FOREIGN KEY (`fk_usuCrea_users`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
