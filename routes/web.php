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

        Route::post('/listar_permisos', 'PermisosController@listarPermisos');
        Route::get('/listar_permisos2', 'PermisosController@listarPermisos2');
        Route::post('/permisos', 'PermisosController@insertar');
    });

});

//Route::get('/home', 'HomeController@index')->name('home');
