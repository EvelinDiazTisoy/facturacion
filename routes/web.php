<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::group(['middleware'=>['guest']],function(){
    Route::get('/','Auth\LoginController@showLoginForm');
    Route::post('/login', 'Auth\LoginController@login')->name('login');
    Route::get('/login', 'Auth\LoginController@login')->name('login');;
});
Route::group(['middleware'=>['auth']],function(){
    
    Route::post('/logout', 'Auth\LoginController@logout')->name('logout');
    
    
    Route::get('/main', function () {
        return view('contenido/contenido');
    })->name('main');

    /*Route::group(['middleware' => ['Almacenero']], function () {
        Route::get('/categoria', 'CategoriaController@index');
        Route::post('/categoria/registrar', 'CategoriaController@store');
        Route::put('/categoria/actualizar', 'CategoriaController@update');
        Route::put('/categoria/desactivar', 'CategoriaController@desactivar');
        Route::put('/categoria/activar', 'CategoriaController@activar');
        Route::get('/categoria/selectCategoria', 'CategoriaController@selectCategoria');

        Route::get('/articulo', 'ArticuloController@index');
        Route::post('/articulo/registrar', 'ArticuloController@store');
        Route::put('/articulo/actualizar', 'ArticuloController@update');
        Route::put('/articulo/desactivar', 'ArticuloController@desactivar');
        Route::put('/articulo/activar', 'ArticuloController@activar');
        Route::get('/articulo/buscarArticulo', 'ArticuloController@buscarArticulo');
        Route::get('/articulo/listarArticulo', 'ArticuloController@listarArticulo');

        Route::get('/proveedor', 'ProveedorController@index');
        Route::post('/proveedor/registrar', 'ProveedorController@store');
        Route::put('/proveedor/actualizar', 'ProveedorController@update');
        Route::get('/proveedor/selectProveedor', 'ProveedorController@selectProveedor');

        Route::get('/ingreso', 'IngresoController@index');
        Route::post('/ingreso/registrar', 'IngresoController@store');
        Route::put('/ingreso/desactivar', 'IngresoController@desactivar');
        Route::get('/ingreso/obtenerCabecera', 'IngresoController@obtenerCabecera');
        Route::get('/ingreso/obtenerDetalles', 'IngresoController@obtenerDetalles');

        Route::get('/egreso', 'EgresoController@index');
        Route::post('/egreso/registrar', 'EgresoController@store');
        Route::put('/egreso/desactivar', 'EgresoController@desactivar');
        Route::get('/egreso/obtenerCabecera', 'EgresoController@obtenerCabecera');
        Route::get('/egreso/obtenerDetalles', 'EgresoController@obtenerDetalles');

    });

    Route::group(['middleware' => ['Vendedor']], function () {
        Route::get('/cliente', 'ClienteController@index');
        Route::post('/cliente/registrar', 'ClienteController@store');
        Route::put('/cliente/actualizar', 'ClienteController@update');
        Route::get('/cliente/selectCliente', 'ClienteController@selectCliente');
 
        Route::get('/articulo/buscarArticuloVenta', 'ArticuloController@buscarArticuloVenta');
        Route::get('/articulo/listarArticuloVenta', 'ArticuloController@listarArticuloVenta');

        Route::get('/venta', 'VentaController@index');
        Route::post('/venta/registrar', 'VentaController@store');
        Route::put('/venta/desactivar', 'VentaController@desactivar');
        Route::get('/venta/obtenerCabecera', 'VentaController@obtenerCabecera');
        Route::get('/venta/obtenerDetalles', 'VentaController@obtenerDetalles');
    });*/

    Route::group(['middleware' => ['Administrador']], function () {
        
        //Route::get('/login', 'Auth\LoginController@login');

        // Route::get('/categoria', 'CategoriaController@index');
        // Route::post('/categoria/registrar', 'CategoriaController@store');
        // Route::put('/categoria/actualizar', 'CategoriaController@update');
        // Route::put('/categoria/desactivar', 'CategoriaController@desactivar');
        // Route::put('/categoria/activar', 'CategoriaController@activar');
        // Route::get('/categoria/selectCategoria', 'CategoriaController@selectCategoria');

        Route::get('/rol', 'RolController@index');
        Route::post('rol/registrar', 'RolController@store');
        Route::put('rol/actualizar', 'RolController@update');
        Route::put('/rol/desactivar', 'RolController@desactivar');
        Route::put('/rol/activar', 'RolController@activar');
        Route::get('/rol/permisos', 'RolController@listarPermisos');
        Route::get('/rol/selectRol', 'RolController@selectRol');

        Route::get('/configgenerales', 'ConfigGeneralesController@index');
        Route::post('configgenerales/registrar', 'ConfigGeneralesController@store');
        Route::post('configgenerales/actualizar', 'ConfigGeneralesController@update');
        Route::put('/configgenerales/desactivar', 'ConfigGeneralesController@desactivar');
        Route::put('/configgenerales/activar', 'ConfigGeneralesController@activar');
        Route::get('/configgenerales/permisos', 'ConfigGeneralesController@listarPermisos');
        Route::get('/configgenerales/selectRol', 'ConfigGeneralesController@selectRol');
        
        Route::get('/modulo', 'ModuloController@index');
        Route::post('/modulo/registrar', 'ModuloController@store');
        Route::put('/modulo/cambiarHijos', 'ModuloController@cambiarHijos');
        Route::get('/modulo/selectPadre', 'ModuloController@selectPadre');
        Route::put('/modulo/actualizar', 'ModuloController@update');
        Route::put('/modulo/desactivar', 'ModuloController@desactivar');
        Route::put('/modulo/desactivarHijos', 'ModuloController@desactivarHijos');
        Route::put('/modulo/activar', 'ModuloController@activar');
        Route::put('/modulo/activarHijos', 'ModuloController@activarHijos');

        Route::get('/cliente', 'ClienteController@index');
        Route::post('/cliente/registrar', 'ClienteController@store');
        Route::put('/cliente/actualizar', 'ClienteController@update');
        Route::get('/cliente/selectCliente', 'ClienteController@selectCliente');
        
        Route::get('/user', 'UserController@index');
        Route::post('/user/registrar', 'UserController@store');
        Route::put('/user/actualizar', 'UserController@update');
        Route::put('/user/desactivar', 'UserController@desactivar');
        Route::put('/user/activar', 'UserController@activar');

        Route::post('/permisos', 'PermisosController@insertar');
        Route::post('/listar_permisos', 'PermisosController@listarPermisos');
        Route::get('/listar_permisos2', 'PermisosController@listarPermisos2');
        Route::get('/permisos/listarPermisosLogueado', 'PermisosController@listarPermisosLogueado');
        Route::get('/permisos/recargarPermisos', 'PermisosController@recargarPermisos');

        // Rutas del plan de cuentas, informe auxiliares, retenciones y de formatos
        Route::get('/info_auxiliares/selectInformes', 'InfAuxiliaresController@selectInformes');
        Route::get('/info_auxiliares/aux_con_saldos', 'InfAuxiliaresController@AuxConSaldos');
        Route::get('/info_auxiliares', 'InfAuxiliaresController@index');

        Route::get('/retenciones', 'RetencionesController@index');        
        Route::post('/retenciones/registrar', 'RetencionesController@store');        
        Route::put('/retenciones/actualizar', 'RetencionesController@update');
        Route::put('/retenciones/desactivar', 'RetencionesController@desactivar');
        Route::put('/retenciones/activar', 'RetencionesController@activar');

        Route::get('/planCuentas', 'PlanCuentas@index');        
        Route::post('/planCuentas/registrar', 'PlanCuentas@store');        
        Route::put('/planCuentas/actualizar', 'PlanCuentas@update');
        Route::get('/planCuentas/selectCuenta', 'PlanCuentas@selectCuenta');
        Route::get('/planCuentas/selectCuenta2', 'PlanCuentas@selectCuenta2');
        Route::get('/planCuentas/selectCuentaInfo', 'PlanCuentas@selectCuentaInfo');
        Route::put('/planCuentas/desactivar', 'PlanCuentas@desactivar');
        Route::put('/planCuentas/activar', 'PlanCuentas@activar');

        Route::get('/conf_formatos', 'Conf_formatosController@index');
        Route::post('/conf_formatos/registrar', 'Conf_formatosController@store');
        Route::put('/conf_formatos/actualizar', 'Conf_formatosController@update');
        Route::get('/conf_formatos/get_tipos_formatos', 'Conf_formatosController@get_tipos_formatos');
        Route::get('/conf_formatos/get_filt_tipo', 'Conf_formatosController@get_filt_tipo');

        Route::get('/formatos','FormatoController@index');
        Route::post('/formatos/registrar','FormatoController@store');
        Route::get('/formatos/numero_next','FormatoController@numero_next');
        Route::put('/formatos/desactivar', 'FormatoController@desactivar');
        Route::put('/formatos/cerrar', 'FormatoController@cerrar');
        Route::get('/formatos/obtenerCabecera', 'FormatoController@obtenerCabecera');
        Route::get('/formatos/obtenerDetalles', 'FormatoController@obtenerDetalles');
        Route::get('/formatos/pdf/{id}','FormatoController@pdf')->name('formato_pdf');
        Route::put('/formatos/actualizar', 'FormatoController@update');

        Route::get('/cuentas/saldo', 'CuentasController@saldo');
        Route::get('/cuentas/get_fuentes', 'CuentasController@get_fuentes');
        Route::get('/cuentas/get_x_afectar', 'CuentasController@get_x_afectar');
    });

});

//Route::get('/home', 'HomeController@index')->name('home');
