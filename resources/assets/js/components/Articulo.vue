<template>
            <main class="main">
            <!-- Breadcrumb -->
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Escritorio</a></li>
            </ol>
            <div class="container-fluid">
                <!-- Ejemplo de tabla Listado -->
                <div class="card">
                    <div class="card-header">
                        <i class="fa fa-align-justify"></i> Artículos
                        <button v-if="permisosUser.crear" type="button" @click="abrirModal('articulo','registrar')" class="btn btn-primary">
                            <i class="icon-plus"></i>&nbsp;Nuevo
                        </button>
                        <button v-else type="button" class="btn btn-secondary">
                            <i class="icon-plus"></i>&nbsp;Nuevo
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="form-group row">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <input v-if="permisosUser.leer" type="text" v-model="buscar" @keyup="listarArticulo(1,buscar,criterio)" class="form-control" placeholder="Texto a buscar">
                                    <input v-else disabled type="text" class="form-control" placeholder="Texto a buscar">

                                    <!--<button v-if="permisosUser.leer" type="submit" @click="listarArticulo(1,buscar,criterio)" class="btn btn-primary"><i class="fa fa-search"></i> Buscar</button>
                                    <button v-else type="submit" class="btn btn-secondary"><i class="fa fa-search"></i> Buscar</button>-->
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-striped table-sm">
                            <thead>
                                <tr>
                                    <th>IMG</th>
                                    <th>Código</th>
                                    <th>Nombre</th>
                                    <th>Categoría</th>
                                    <th>Precio Venta</th>
                                    <th>Stock</th>
                                    <th>Descripción</th>
                                    <th>Tipo</th>
                                    <th>Estado</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody v-if="permisosUser.leer">
                                <tr v-for="articulo in arrayArticulo" :key="articulo.id">
                                    <td>
                                        <img v-if="`${articulo.img}`!='default.png'" :src="`${ruta}/img_productos/${articulo.id_empresa}_empresa/${articulo.img}`" height="40" width="40">

                                        <img v-else :src="`${ruta}/img_productos/${articulo.img}`" height="40" width="40">
                                    </td>
                                    <td v-text="articulo.codigo"></td>
                                    <!--<td v-text="articulo.nombre"></td>-->
                                    <td>
                                        <span v-text="articulo.nombre"></span>
                                        <span v-if="articulo.id_presentacion!=null" v-text="' - '+articulo.nom_presentacion"></span>
                                        <span v-else> - N/A presentacion</span>
                                        <span v-if="articulo.talla!=null && articulo.talla!='' && articulo.talla!='null'" v-text="' - '+articulo.talla"></span>
                                        <span v-else> - N/A talla</span>
                                    </td>
                                    <td v-text="articulo.nombre_categoria"></td>
                                    <td v-text="articulo.precio_venta"></td>
                                    <td v-text="articulo.stock"></td>
                                    <td v-text="articulo.descripcion"></td>
                                    <td>
                                        <div v-if="articulo.tipo_articulo==1">
                                            <span>Suministro</span>
                                        </div>
                                        <div v-else-if="articulo.tipo_articulo==2">
                                            <span>Servicio</span>
                                        </div>
                                        <div v-else-if="articulo.tipo_articulo==3">
                                            <span>Producto simple</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div v-if="articulo.condicion">
                                            <span class="badge badge-success">Activo</span>
                                        </div>
                                        <div v-else>
                                            <span class="badge badge-danger">Desactivado</span>
                                        </div>
                                    </td>
                                    <td>
                                        <template>
                                            <button v-if="permisosUser.actualizar && articulo.condicion" type="button" @click="abrirModal('articulo','actualizar',articulo)" class="btn btn-warning btn-sm">
                                                <i class="icon-pencil"></i>
                                            </button>
                                            <button v-else type="button" class="btn btn-secondary btn-sm">
                                                <i class="icon-pencil"></i>
                                            </button>
                                        </template>

                                        <template v-if="permisosUser.anular">
                                            <button v-if="articulo.condicion" type="button" class="btn btn-danger btn-sm" @click="desactivarArticulo(articulo.id)">
                                                <i class="icon-trash"></i>
                                            </button>
                                            <button v-else type="button" class="btn btn-info btn-sm" @click="activarArticulo(articulo.id)">
                                                <i class="icon-check"></i>
                                            </button>
                                        </template>
                                        <template v-else>
                                            <button v-if="articulo.condicion" type="button" class="btn btn-secondary btn-sm">
                                                <i class="icon-trash"></i>
                                            </button>
                                            <button v-else type="button" class="btn btn-secondary btn-sm">
                                                <i class="icon-check"></i>
                                            </button>
                                        </template>

                                        <template>
                                            <button type="button" class="btn btn-info btn-sm" @click="abrirModalStock('ver', articulo.id)" >
                                                <i class="fa fa-archive"></i>
                                            </button>
                                        </template>
                                        
                                        <template>
                                            <button v-if="permisosUser.actualizar && articulo.condicion" @click="abrirModal('articulo','productos_asociados',articulo)" type="button" class="btn btn-success btn-sm">
                                                <i class="fa fa-align-justify"></i>
                                            </button>
                                            <button v-else type="button" class="btn btn-secondary btn-sm">
                                                <i class="fa fa-align-justify"></i>
                                            </button>
                                        </template>
                                    </td>
                                </tr>                                
                            </tbody>
                            <tbody v-else>
                                <tr><td colspan="9">No hay registros para mostrar</td></tr>
                            </tbody>
                        </table>
                        <nav>
                            <ul class="pagination">
                                <li class="page-item" v-if="pagination.current_page > 1">
                                    <a class="page-link" href="#" @click.prevent="cambiarPagina(pagination.current_page - 1,buscar,criterio)">Ant</a>
                                </li>
                                <li class="page-item" v-for="page in pagesNumber" :key="page" :class="[page == isActived ? 'active' : '']">
                                    <a class="page-link" href="#" @click.prevent="cambiarPagina(page,buscar,criterio)" v-text="page"></a>
                                </li>
                                <li class="page-item" v-if="pagination.current_page < pagination.last_page">
                                    <a class="page-link" href="#" @click.prevent="cambiarPagina(pagination.current_page + 1,buscar,criterio)">Sig</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <!-- Fin ejemplo de tabla Listado -->
            </div>
            <!--Inicio del modal agregar/actualizar-->
            <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal==1}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" v-text="tituloModal"></h4>
                            <button type="button" class="close" @click="cerrarModal()" aria-label="Close">
                              <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label class="col-md-1 form-control-label float-left" for="text-input">Nombre</label>
                                    <div class="col-md-11 float-right">
                                        <input type="text" v-model="nombre" class="form-control float-right" placeholder="Nombre de artículo" style="width: 95.7% !important;">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="form-control-label col-md-3 float-left" for="text-input">Modelo contable</label>
                                    <div class="col-md-9 float-right form-inline">
                                        <select class="form-control col-md-10 float-left custom-select" v-model="idcategoria">
                                            <option value="0" disabled>Seleccione</option>
                                            <option v-for="categoria in arrayCategoria" :key="categoria.id" :value="categoria.id" v-text="categoria.nombre"></option>
                                        </select>
                                        <span class="btn btn-primary form-control col-md-2 float-right" @click="abrirModalCrear('modelo_contable')"><i class="fa fa-plus-circle"></i></span>
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="form-control-label col-md-3 float-left" for="text-input">Centro de costos</label>
                                    <div class="col-md-9 float-right form-inline">
                                        <select class="form-control col-md-10 float-left custom-select" v-model="idcategoria2">
                                            <option value="0" disabled>Seleccione</option>
                                            <option v-for="categoria in arrayCategoria2" :key="categoria.id" :value="categoria.id" v-text="categoria.nombre"></option>
                                        </select>
                                        <span class="btn btn-primary form-control col-md-2 float-right" @click="abrirModalCrear('categoria2')"><i class="fa fa-plus-circle"></i></span>
                                    </div>
                                </div>
                                <div style="display:none;" :class="{'col-md-12 mostrar-crear' : modalCrear==1}">
                                    <div class="col-md-10 float-left">
                                        <div class="form-group col-md-6 float-left">
                                            <span v-text="tituloModalCrear" class="form-control-label col-md-4 float-left"></span>
                                            <input type="text" class="form-control col-md-8 float-right" v-model="nombre_crear">
                                        </div>
                                        <div class="col-md-6 float-left">
                                            <span class="form-control-label col-md-4 float-left">Descripción</span>
                                            <input type="text" class="form-control col-md-8 float-right" v-model="descripcion_crear">
                                        </div>
                                    </div>
                                    <div class="col-md-2 float-right">
                                        <button type="button" class="btn btn-primary" @click="crearExtras('categoria')"><i class="fa fa-save"></i></button>
                                        <button type="button" class="btn btn-secondary" @click="cerrarModalCrear()"><i class="fa fa-times-circle"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Precio Venta</label>
                                    <div class="col-md-9 float-right">
                                        <input type="number" v-model="precio_venta" :min="1" @blur="(function(){
                                            if(precio_venta<1) precio_venta=1;})" class="form-control" placeholder="">                                        
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label v-if="tipo_articulo!=2" class="col-md-3 form-control-label float-left" for="text-input">Stock</label>
                                    <div v-if="tipo_articulo!=2" class="col-md-9 float-right">
                                        <input type="number" v-model="stock" :min="1" @blur="(function(){
                                            if(stock<1) stock=1;})" class="form-control" placeholder="">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Cod. invima</label>
                                    <div class="col-md-9 float-right">
                                        <input type="text" v-model="cod_invima" class="form-control" placeholder="Código invima">
                                    </div>
                                </div>
                                <div class="form-group col-md-6" v-if="tipo_articulo==1 || tipo_articulo==3">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Lote</label>
                                    <div class="col-md-9 float-right">
                                        <input type="text" v-model="lote" class="form-control" placeholder="">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6" v-if="tipo_articulo!=2 && tipo_articulo!=3">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Fec. vence</label>
                                    <div class="col-md-9 float-right">
                                        <input type="date" v-model="fec_vence" class="form-control" placeholder="">                                        
                                    </div>
                                </div>
                                <div class="form-group col-md-6" v-else>
                                </div>
                                <div v-if="tipo_articulo!=2" class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Cant. minima</label>
                                    <div class="col-md-9 float-right">
                                        <input type="number" v-model="minimo" :min="1" @blur="(function(){
                                            if(minimo<1) minimo=1;})" class="form-control" placeholder="">
                                    </div>
                                </div>
                                <div v-else class="form-group col-md-6">
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="form-control-label col-md-3 float-left" for="text-input">Tipo artículo</label>
                                    <div class="col-md-9 float-right">
                                        <select class="form-control custom-select" v-model="tipo_articulo">
                                            <option value="0" disabled>Seleccione</option>
                                            <option value="1">Suministro</option>
                                            <option value="2">Servicio</option>
                                            <option value="3">Producto simple</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-md-6" v-if="tipo_articulo!=2">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Talla</label>
                                    <div class="col-md-9 float-right">
                                        <input type="text" v-model="talla" class="form-control" placeholder="Talla del producto"> 
                                    </div>
                                </div>
                                <div class="form-group col-md-6" v-else>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6" v-if="tipo_articulo==1 || tipo_articulo==3">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Und. medida</label>
                                    <div class="col-md-9 float-right form-inline">
                                        <select class="form-control col-md-10 float-left custom-select" v-model="id_und_medida">
                                            <option value="0" disabled>Seleccione</option>
                                            <option v-for="id_und_medida in arrayUndMedida" :key="id_und_medida.id" :value="id_und_medida.id" v-text="id_und_medida.nombre"></option>
                                        </select> 
                                        <span class="btn btn-primary col-md-2 float-right" @click="abrirModalCrear('und_medida')"><i class="fa fa-plus-circle"></i></span>
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="email-input">Descripción</label>
                                    <div class="col-md-9 float-right">
                                        <input type="text" v-model="descripcion" class="form-control" placeholder="Ingrese descripción">
                                    </div>
                                </div>
                                <div style="display:none;" :class="{'form-group col-md-12 mostrar-crear' : modalCrear==2}">
                                    <div class="col-md-10 float-left">
                                        <span class="col-md-3 form-control-label float-left" v-text="tituloModalCrear"></span>
                                        <input type="text" class="form-control col-md-9 float-right" v-model="nombre_crear">
                                    </div>
                                    <div class="col-md-2 float-right">
                                        <button type="button" class="btn btn-primary" @click="crearExtras('und_medida')"><i class="fa fa-save"></i></button>
                                        <button type="button" class="btn btn-secondary" @click="cerrarModalCrear()"><i class="fa fa-times-circle"></i></button>
                                    </div>
                                </div>
                                <div style="display:none;" :class="{'form-group col-md-12 mostrar-crear' : modalCrear==3}">
                                    <div class="col-md-10 float-left">
                                        <span class="col-md-3 form-control-label float-left" v-text="tituloModalCrear"></span>
                                        <input type="text" class="col-md-9 form-control float-right" v-model="nombre_crear">
                                    </div>
                                    <div class="col-md-2 float-right">
                                        <button type="button" class="btn btn-primary" @click="crearExtras('concentracion')"><i class="fa fa-save"></i></button>
                                        <button type="button" class="btn btn-secondary" @click="cerrarModalCrear()"><i class="fa fa-times-circle"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Presentación</label>
                                    <div class="col-md-9 float-right form-inline">
                                        <select class="form-control col-md-10 float-left custom-select" v-model="id_presentacion">
                                            <option value="0" disabled>Seleccione</option>
                                            <option v-for="id_presentacion in arrayPresentacion" :key="id_presentacion.id" :value="id_presentacion.id" v-text="id_presentacion.nombre"></option>
                                        </select> 
                                        <span class="btn btn-primary col-md-2 float-right" @click="abrirModalCrear('presentacion')"><i class="fa fa-plus-circle"></i></span>
                                    </div>                   
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Código</label>
                                    <div class="col-md-9 float-right">
                                        <input type="text" v-model="codigo" class="form-control" placeholder="Código de barras"> 
                                    </div>

                                    <!--<label class="col-md-3 form-control-label float-left" for="text-input">Concentración</label>
                                    <div class="col-md-9 float-right">
                                        <select class="form-control col-md-10 float-left" v-model="id_concentracion">
                                            <option value="0" disabled>Seleccione</option>
                                            <option v-for="id_concentracion in arrayConcentracion" :key="id_concentracion.id" :value="id_concentracion.id" v-text="id_concentracion.nombre"></option>
                                        </select> 
                                        <span class="btn btn-primary col-md-2 float-right" @click="abrirModalCrear('concentracion')"><i class="fa fa-plus-circle"></i></span>
                                    </div>-->
                                </div>
                                <div style="display:none;" :class="{'form-group col-md-12 mostrar-crear' : modalCrear==4}">
                                    <div class="col-md-10 float-left">
                                        <span class="col-md-3 form-control-label float-left" v-text="tituloModalCrear"></span>
                                        <input type="text" class="col-md-9 form-control-label float-right" v-model="nombre_crear">
                                    </div>
                                    <div class="col-md-2 float-right">
                                        <button type="button" class="btn btn-primary" @click="crearExtras('presentacion')"><i class="fa fa-save"></i></button>
                                        <button type="button" class="btn btn-secondary" @click="cerrarModalCrear()"><i class="fa fa-times-circle"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="col-md-3 form-control-label float-left">Imagen</label>
                                    <div class="col-md-9 float-right">
                                        <input type="file" id="img" name="img" ref="inputFileImg"  @change="cargarImg" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                </div>
                            </div>
                            <!--<div class="row">
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Código</label>
                                    <div class="col-md-9 float-right">
                                        <input type="text" v-model="codigo" class="form-control" placeholder="Código de barras"> 
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <barcode :value="codigo" :options="{ format: 'EAN-13' }" >Generando código de barras...</barcode>
                                </div>
                            </div>-->
                                <div v-show="errorArticulo" class="form-group row div-error">
                                    <div class="text-center text-error">
                                        <div v-for="error in errorMostrarMsjArticulo" :key="error" v-text="error">

                                        </div>
                                    </div>
                                </div>

                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" @click="cerrarModal()">Cerrar</button>
                            <button type="button" v-if="tipoAccion==1" class="btn btn-primary" @click="registrarArticulo()">Guardar</button>
                            <button type="button" v-if="tipoAccion==2" class="btn btn-primary" @click="actualizarArticulo()">Actualizar</button>
                            
                            <button type="button" class="btn btn-success" @click="abrirModal('articulo','tarifarios')">Tarifarios</button>
                            <button type="button" class="btn btn-success" @click="abrirModal('articulo','iva')">Config IVA</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!--Fin del modal-->

            <!-- Inicio modal stock -->
            <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal2}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" v-text="tituloModalStock"></h4>
                            <button type="button" class="close" @click="cerrarModalStock()" aria-label="Close">
                              <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="container">
                                <div class="row">
                                    <div class="form-group col-md-5">
                                        <label class="col-md-4 float-left">Fec. Inicia</label>
                                        <div class="col-md-8 float-right">
                                            <input type="date" class="form-control" v-model="fecIni">
                                        </div>
                                    </div>
                                    <div class="col-md-5">
                                        <label class="col-md-4 float-left">Fec. Finaliza</label>
                                        <div class="col-md-8 float-right">
                                            <input type="date" class="form-control" v-model="fecFin">
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" @click="listarStock(1,idArticuloStock)" class="btn btn-primary">
                                            <i class="fa fa-search"></i> Buscar
                                        </button>
                                    </div>
                                </div>
                                <div class="row">
                                    <table class="table table-bordered table-striped table-sm">
                                        <thead>
                                            <tr>
                                                <th>Fec. crea</th>
                                                <th>Ingreso</th>
                                                <th>Egreso</th>
                                                <th>Cantidad</th>
                                                <th>Sumatoria</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr v-for="stock in arrayStock" :key="stock.id">
                                                <td v-text="stock.fec_crea"></td>
                                                
                                                <td v-if="stock.tipo_movimiento==1 || stock.tipo_movimiento==2" v-text="stock.cantidad"></td>
                                                <td v-else>0</td>

                                                <td v-if="stock.tipo_movimiento==3 || stock.tipo_movimiento==4" v-text="stock.cantidad"></td>
                                                <td v-else>0</td>

                                                <td v-text="stock.cantidad"></td>
                                                <td v-text="stock.sumatoria"></td>
                                            </tr>                                
                                        </tbody>
                                    </table>
                                    <nav>
                                        <ul class="pagination">
                                            <li class="page-item" v-if="pagination_stock.current_page_stock > 1">
                                                <a class="page-link" href="#" @click.prevent="cambiarPaginaStock(pagination_stock.current_page_stock - 1,idArticuloStock)">Ant</a>
                                            </li>
                                            <li class="page-item" v-for="page_stock in pagesNumberStock" :key="page_stock" :class="[page_stock == isActived ? 'active' : '']">
                                                <a class="page-link" href="#" @click.prevent="cambiarPaginaStock(page_stock,idArticuloStock)" v-text="page_stock"></a>
                                            </li>
                                            <li class="page-item" v-if="pagination_stock.current_page_stock < pagination_stock.last_page_stock">
                                                <a class="page-link" href="#" @click.prevent="cambiarPaginaStock(pagination_stock.current_page_stock + 1,idArticuloStock)">Sig</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" @click="cerrarModalStock()">Cerrar</button>
                            <button type="button" v-if="tipoAccion==1" class="btn btn-primary" @click="registrarArticulo()">Guardar</button>
                            <button type="button" v-if="tipoAccion==2" class="btn btn-primary" @click="actualizarArticulo()">Actualizar</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- Fin modal stock -->

            <!-- Inicio modal tarifarios -->
            <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal3}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary modal-lg" role="document">
                    <div class="modal-content" style="width:80% !important;margin-left: 22% !important;">
                        <div class="modal-header">
                            <h4 class="modal-title" v-text="tituloModal3"></h4>
                            <button type="button" class="close" @click="cerrarModalTarifario()" aria-label="Close">
                              <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="container">
                                <div class="row">
                                    <table class="table table-bordered table-striped table-sm">
                                        <thead>
                                            <tr>
                                                <th>Nombre</th>
                                                <th class="col-md-3">Valor</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr v-for="(tarifario, index) in arrayTarifarios" :key="tarifario.index">
                                                <td v-text="tarifario.nombre"></td>
                                                <td style="text-align: right;">
                                                    <input type="number" v-if="tipoAccionModal3==2" style="text-align: right;" v-model="tarifario.valor" :min="1" @blur="(function(){if(tarifario.valor<1) tarifario.valor=1;})">
                                                    <span v-if="tipoAccionModal3==1" v-text="tarifario.valor"></span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" @click="cerrarModalTarifario()">Cerrar</button>
                            <button type="button"  v-if="tipoAccionModal3==2" class="btn btn-primary" @click="tipoAccionModal3=1, modal3=0">Guardar</button>
                            <button type="button"  v-if="tipoAccionModal3==1" class="btn btn-success" @click="tipoAccionModal3=2">Editar</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- Fin modal tarifarios -->

            <!--MODALES CREAR CATETORIA 1 Y CUENTAS-->
            <!--Inicio del modal agregar/actualizar-->
            <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal4}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" v-text="tituloModal4"></h4>
                            <button type="button" class="close" @click="cerrarModal4()" aria-label="Close">
                              <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
                                <div class="form-group row">
                                    <div class="col-md-12">
                                        <label class="col-md-1 form-control-label float-left" for="text-input">Nombre</label>
                                        <div class="col-md-11 float-right">
                                            <input type="text" v-model="nombreModeloContable" class="form-control float-right" style="width: 96%;" placeholder="Nombre de categoría">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-md-12">
                                        <label class="col-md-1 form-control-label float-left" for="email-input">Descripción</label>
                                        <div class="col-md-11 float-right">
                                            <textarea v-model="descripcionModeloContable" class="form-control float-right" style="width: 96%;"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="form-group col-md-6">
                                        <label class="col-md-3 form-control-label float-left">Cuenta Producto <span style="color:red;" v-show="idCuentaProductos==''">(*Seleccione)</span></label>
                                        <div class="form-inline col-md-9 float-right">
                                            <input type="text" readonly class="form-control" style="width: 85%;" v-model="cuentaProductos">
                                            <button type="button" @click="abrirModalCuentas('productos')" class="btn btn-primary">...</button>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label class="col-md-3 form-control-label float-left">Cuenta Salida <span style="color:red;" v-show="idCuentaSalidaProductos==''">(*Seleccione)</span></label>
                                        <div class="form-inline col-md-9 float-right">
                                            <input type="text" readonly class="form-control" style="width: 85%;" v-model="cuentaSalidaProductos">
                                            <button type="button" @click="abrirModalCuentas('salida_productos')" class="btn btn-primary">...</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="form-group col-md-6">
                                        <label class="col-md-3 form-control-label float-left">Saldos iniciales <span style="color:red;" v-show="idCuentaSaldosIniciales==''">(*Seleccione)</span></label>
                                        <div class="form-inline col-md-9 float-right">
                                            <input type="text" readonly class="form-control" style="width: 85%;" v-model="cuentaSaldosIniciales">
                                            <button type="button" @click="abrirModalCuentas('saldos_iniciales')" class="btn btn-primary">...</button>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label class="col-md-3 form-control-label float-left">Cuenta Donaciones <span style="color:red;" v-show="idCuentaDonaciones==''">(*Seleccione)</span></label>
                                        <div class="form-inline col-md-9 float-right">
                                            <input type="text" readonly class="form-control" style="width: 85%;" v-model="cuentaDonaciones">
                                            <button type="button" @click="abrirModalCuentas('donaciones')" class="btn btn-primary">...</button>
                                        </div>
                                    </div>
                                </div>
                                <div v-show="errorArticulo" class="form-group row div-error">
                                    <div class="text-center text-error">
                                        <div v-for="error in errorMostrarMsjCategoria" :key="error" v-text="error">

                                        </div>
                                    </div>
                                </div>

                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" @click="cerrarModal4()">Cerrar</button>
                            <button type="button" class="btn btn-primary" @click="registrarModeloContable()">Guardar</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!--Fin del modal-->

            <!-- Modal busqueda cuentas-->
            <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal5}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" v-text="tituloModal5"></h4>
                            <button type="button" class="close" @click="cerrarModalCuentas()" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group row">
                                <div style="max-width: 120px !important;" class="col-md-2   ">
                                    <label style='margin-top: 3px; '><b>Cuenta</b></label>                                
                                </div>
                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="cta_busq" v-model="cta_busq" @keyup="buscarCuentaB()">
                                    </div>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped table-sm">
                                    
                                        <tr><th>Codigo</th><th>Cuenta</th><th>-</th></tr>
                                    
                                        <tr v-for="cuentas in arrayCuentasBusq" :key="cuentas.id">
                                            <td v-text="cuentas.codigo"></td>
                                            <td v-text="cuentas.nombre"></td>
                                            <td>
                                                <button type="button" style=" margin-right: -8px;" @click="cargarCuentaB(cuentas, tipoCuenta)" class="btn btn-success btn-sm" title='Ver formato'>
                                                    <i class="icon-check"></i>
                                                </button>
                                            </td>
                                        </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Fin del modal-->

            <!-- Modal productos asociados-->
            <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal6}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary modal-lg" role="document">
                    <div class="modal-content" style="width: 750px !important;">
                        <div class="modal-header">
                            <h4 class="modal-title" v-text="tituloModal6"></h4>
                            <button v-if="tipoAccion6==0" @click="tipoAccion6=1" class="btn btn-default">Nuevo</button>
                            <button type="button" class="close" @click="cerrarModal6()" aria-label="Close">
                              <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form v-if="tipoAccion6==1" action="" method="post" enctype="multipart/form-data" class="form-horizontal">
                                <div class="form-group row">
                                    <div class="col-md-6">
                                        <label class="col-md-3 form-control-label float-left" for="text-input">Presentación</label>
                                        <div class="col-md-9 float-right form-inline">
                                            <select class="form-control col-md-10 float-left custom-select" v-model="idPresentacionAsociada">
                                                <option value="0" disabled>Seleccione</option>
                                                <option v-for="id_presentacion in arrayPresentacion" :key="id_presentacion.id" :value="id_presentacion.id" v-text="id_presentacion.nombre"></option>
                                            </select> 
                                            <span class="btn btn-primary col-md-2 float-right" @click="abrirModalCrear('presentacion')"><i class="fa fa-plus-circle"></i></span>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="col-md-3 form-control-label float-left" for="text-input">Unidades</label>
                                        <div class="col-md-9 float-right form-inline">
                                            <input type="number" v-model="unidadesPresentacionAsociada" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <div style="display:none;" :class="{'form-group col-md-12 mostrar-crear' : modalCrear==4}">
                                    <div class="col-md-10 float-left">
                                        <span class="col-md-3 form-control-label float-left" v-text="tituloModalCrear"></span>
                                        <input type="text" class="col-md-9 form-control-label float-right" v-model="nombre_crear">
                                    </div>
                                    <div class="col-md-2 float-right">
                                        <button type="button" class="btn btn-primary" @click="crearExtras('presentacion')"><i class="fa fa-save"></i></button>
                                        <button type="button" class="btn btn-secondary" @click="cerrarModalCrear()"><i class="fa fa-times-circle"></i></button>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-md-12">
                                        <table class="table table-bordered table-striped table-sm">
                                            <thead>
                                                <tr>
                                                    <th>Nombre</th>
                                                    <th class="col-md-3">Valor</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr v-for="tarifario in arrayTarifarios" :key="tarifario.id">
                                                    <td v-text="tarifario.nombre"></td>
                                                    <td style="text-align: right;"><input type="number" style="text-align: right;" v-model="tarifario.valor"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-md-12">
                                        <button type="button" class="btn btn-secondary" @click="tipoAccion6=0">Cerrar</button>
                                        <button type="button" class="btn btn-primary" @click="registrarProductosAsociados()">Guardar</button>
                                    </div>
                                </div>
                                <div v-show="errorArticulo" class="form-group row div-error">
                                    <div class="text-center text-error">
                                        <div v-for="error in errorMostrarMsjCategoria" :key="error" v-text="error">
                                        </div>
                                    </div>
                                </div>

                            </form>

                            <div v-if="tipoAccion6==0">
                                <table class="table table-bordered table-striped table-sm">
                                    <thead>
                                        <tr>
                                            <th>Código</th>
                                            <th>Nombre</th>
                                            <th>Presentación</th>
                                            <th class="col-md-3">Unidades</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="presentacionAsociada in arrayPresentacionesAsociadas" :key="presentacionAsociada.id">
                                            <td v-text="presentacionAsociada.codigo_articulo"></td>
                                            <td v-text="presentacionAsociada.nom_articulo"></td>
                                            <td v-text="presentacionAsociada.nom_presentacion"></td>
                                            <td v-text="presentacionAsociada.unidades"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" @click="cerrarModal6()">Cerrar</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
            </div>
            <!--Fin del modal-->
            
            <!-- Modal iva-->
            <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal7}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary modal-lg" role="document">
                    <div class="modal-content" style="width:100% !important;margin-left: 15% !important;">
                        <div class="modal-header">
                            <h4 class="modal-title" v-text="tituloModal7"></h4>
                        </div>
                        <div class="modal-body">
                            <form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
                                <div class="form-group row">
                                    <div class="col-md-6">
                                        <label class="col-md-3 form-control-label float-left" for="text-input">Iva compras</label>
                                        <div class="col-md-9 float-right form-inline">
                                            <select class="form-control custom-select col-md-12" v-model="idIvaCompra">
                                                <option v-for="ivaCompra in arrayIvaCompra" :key="ivaCompra.id" :value="ivaCompra.id" v-text="ivaCompra.nombre"></option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="col-md-3 form-control-label float-left" for="text-input">Iva Ventas</label>
                                        <div class="col-md-9 float-right form-inline">
                                            <select class="form-control custom-select col-md-12" v-model="idIvaVenta">
                                                <option v-for="ivaVenta in arrayIvaVenta" :key="ivaVenta.id" :value="ivaVenta.id" v-text="ivaVenta.nombre"></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-md-6">
                                        <label class="col-md-3 form-control-label float-left" for="text-input">Iva devolución compras</label>
                                        <div class="col-md-9 float-right form-inline">
                                            <select class="form-control custom-select col-md-12" v-model="idIvaDevolucionCompra">
                                                <option v-for="ivaDevCompra in arrayIvaDevolucionesCompra" :key="ivaDevCompra.id" :value="ivaDevCompra.id" v-text="ivaDevCompra.nombre"></option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="col-md-3 form-control-label float-left" for="text-input">Iva devolución Ventas</label>
                                        <div class="col-md-9 float-right form-inline">
                                            <select class="form-control custom-select col-md-12" v-model="idIvaDevolucionVenta">
                                                <option v-for="ivaDevVenta in arrayIvaDevolucionesVenta" :key="ivaDevVenta.id" :value="ivaDevVenta.id" v-text="ivaDevVenta.nombre"></option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </form>

                            <!--<div v-if="tipoAccion7==0">
                                <table class="table table-bordered table-striped table-sm">
                                    <thead>
                                        <tr>
                                            <th>Tipo</th>
                                            <th>Nombre</th>
                                            <th>%</th>
                                            <th class="col-md-1">Opciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="iva_producto in arrayIvaProducto" :key="iva_producto.id">
                                            <td v-text="iva_producto.tipo"></td>
                                            <td v-if="iva_producto.id_iva!=0" v-text="iva_producto.nom_iva"></td>
                                            <td v-else>N/A</td>
                                            <td v-if="iva_producto.id_iva!=0" v-text="iva_producto.porcentaje_iva"></td>
                                            <td v-else>N/A</td>
                                            <td>
                                                <button type="button" class="btn btn-danger btn-xs" @click="eliminarIvaProducto(iva_producto.id)"><i class="icon-trash"></i></button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>-->
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" @click="cerrarModal7()">Cerrar</button>
                            <button type="button" class="btn btn-primary" @click="modal7=0">Guardar</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
            </div>
            <!--Fin del modal-->
        </main>
</template>

<script>
    import VueBarcode from 'vue-barcode';
    export default {
        props : ['ruta','permisosUser'],
        data (){
            return {
                articulo_id: 0,
                idcategoria : 0,
                idcategoria2 : 0,
                nombre_categoria : '',
                codigo : '',
                nombre : '',
                precio_venta : 0,
                stock : 0,
                cod_invima : '',
                lote : '',
                fec_vence : '',
                id_und_medida : '',
                id_concentracion : '',
                id_presentacion : '',
                nombre_und_medida : '',
                nombre_concentracion : '',
                nombre_presentacion : '',
                minimo : 0,
                tipo_articulo : '',
                iva : 0,
                descripcion : '',
                talla : '',
                tipo_movimiento : 1,
                img: '',
                arrayImg: '',


                arrayArticulo : [],
                modal : 0,
                tituloModal : '',
                tipoAccion : 0,
                errorArticulo : 0,
                errorMostrarMsjArticulo : [],
                pagination : {
                    'total' : 0,
                    'current_page' : 0,
                    'per_page' : 0,
                    'last_page' : 0,
                    'from' : 0,
                    'to' : 0,
                },
                pagination_stock : {
                    'total_stock' : 0,
                    'current_page_stock' : 0,
                    'per_page_stock' : 0,
                    'last_page_stock' : 0,
                    'from_stock' : 0,
                    'to_stock' : 0,
                },
                offset : 3,
                offset2 : 3,
                criterio : 'nombre',
                buscar : '',
                arrayCategoria :[],
                arrayCategoria2 :[],
                arrayUndMedida :[],
                arrayConcentracion :[],
                arrayPresentacion :[],

                /* Variables para crear categorias, unidades de medida, concentracion, presentacion */
                nombre_crear : '',
                descripcion_crear : '',
                modalCrear : 0,
                tituloModalCrear : '',
                tipoAccionCrear : 0,
                errorCrear : 0,
                errorMostrarMsjCrear : [],

                // variables para el stock
                idArticuloStock : 0,
                cantidadStock : 0,
                tipoMovimientoStock : 0,
                sumatoria : 0,

                // variables modal stock
                arrayStock : [],
                modal2 : 0,
                tituloModalStock : '',
                tipoAccionStock : 0,
                errorStock : 0,
                errorMostrarMsjStock : [],

                // variables filtro modal stock
                fecIni : '2019-01-01',
                fecActual : '',
                fecFin : '',

                // variables del modal 'tarifarios'
                modal3 : 0,
                tituloModal3 : '',
                tipoAccionModal3 : 1,
                arrayTarifarios : [],
                errorTarifario : 0,

                // variables modal crear categorias 1
                modal4 : 0,
                tituloModal4 : '',
                nombreModeloContable : '',
                descripcionModeloContable : '',
                errorArticulo : '',
                errorMostrarMsjCategoria : [],
                // variables de cuentas de producto, salida de productos, saldos iniciales y donaciones. Ctegorias1
                modal5 : 0,
                tituloModal5 : '',
                tipoCuenta : '',
                cta_busq : '',
                arrayCuentasBusq : [],

                idCuentaProductos: 0,
                cuentaProductos : '',
                codCuentaProductos : '',

                idCuentaSalidaProductos: 0,
                cuentaSalidaProductos: '',
                codCuentaSalidaProductos: '',

                idCuentaSaldosIniciales: 0,
                cuentaSaldosIniciales: '',
                codCuentaSaldosIniciales: '',

                idCuentaDonaciones: 0,
                cuentaDonaciones: '',
                codCuentaDonaciones: '',

                // variables del modal de productos asociados
                modal6 : 0,
                tituloModal6 : '',
                tipoAccion6 : 0,
                idProductoPresentacionAsociada : 0,
                unidadesPresentacionAsociada : 0,
                idPresentacionAsociada : 0,
                arrayPresentacionesAsociadas : [],

                // variables de modal ivas
                modal7 : 0,
                tituloModal7 : '',
                tipoAccion7 : 0,
                idIvaCompra : 0,
                idIvaVenta : 0,
                idIvaDevolucionCompra : 0,
                idIvaDevolucionVenta : 0,
                arrayIvas : [],
                arrayIvaProducto : [],
                arrayIvaCompra : [],
                arrayIvaVenta : [],
                arrayIvaDevolucionesCompra : [],
                arrayIvaDevolucionesVenta : [],
                errorIva : 0,
            }
        },
        components: {
        'barcode': VueBarcode
        },
        computed:{
            isActived: function(){
                return this.pagination.current_page;
                return this.pagination_stock.current_page_stock;
            },
            //Calcula los elementos de la paginación
            pagesNumber: function() {
                if(!this.pagination.to) {
                    return [];
                }
                
                var from = this.pagination.current_page - this.offset; 
                if(from < 1) {
                    from = 1;
                }

                var to = from + (this.offset * 2); 
                if(to >= this.pagination.last_page){
                    to = this.pagination.last_page;
                }  

                var pagesArray = [];
                while(from <= to) {
                    pagesArray.push(from);
                    from++;
                }
                return pagesArray;             

            },

            pagesNumberStock: function() {
                if(!this.pagination_stock.to_stock) {
                    return [];
                }
                
                var from_stock = this.pagination_stock.current_page_stock - this.offset2; 
                if(from_stock < 1) {
                    from_stock = 1;
                }

                var to_stock = from_stock + (this.offset2 * 2); 
                if(to_stock >= this.pagination_stock.last_page_stock){
                    to_stock = this.pagination_stock.last_page_stock;
                }  

                var pagesArrayStock = [];
                while(from_stock <= to_stock) {
                    pagesArrayStock.push(from_stock);
                    from_stock++;
                }
                return pagesArrayStock;             

            }
        },
        methods : {
            listarArticulo (page,buscar,criterio){
                let me=this;
                var url= this.ruta + '/articulo/?page=' + page + '&buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayArticulo = respuesta.articulos.data;
                    me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            listarStock(page_stock,id_articulo){
                let me=this;
                this.arrayStock = [];
                
                var url= this.ruta + '/stock?page='+page_stock+'&id_articulo='+id_articulo+'&fecIni='+this.fecIni+'&fecFin='+this.fecFin;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayStock = respuesta.stock.data;
                    me.pagination_stock= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            listarTarifarios(id){
                let me=this;
                var url= this.ruta + '/con_tarifario/selectConTarifario?id_producto='+id;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayTarifarios = respuesta.tarifario;
                    // me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            listarPresentacionesAsociadas(id, id_presentacion){
                let me=this;
                var url= this.ruta + '/productos_asociados/selectProductoAsociado?id_producto='+id;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayPresentacionesAsociadas = respuesta.productos_asociados;
                    // me.pagination= respuesta.pagination;

                    var indices = [];

                    for(var i=0; i<me.arrayPresentacion.length; i++)
                    {
                        if(me.arrayPresentacion[i]['id']==id_presentacion)
                        {
                            indices.push({
                                indice: i,
                            });
                        }

                        me.arrayPresentacionesAsociadas.forEach(function(dato2){
                            if(me.arrayPresentacion[i]['id']==dato2['id_presentacion'])
                            {
                                indices.push({
                                    indice: i,
                                });
                            }
                        });
                    }

                    indices.forEach(function(dato){
                        me.arrayPresentacion.splice(dato['indice'],1);
                    });
                    console.log(me.arrayPresentacion);

                    /*me.arrayPresentacion.forEach(function(dato, index){
                        if(dato['id']==id_presentacion)
                        {
                            indices.push({
                                indice: index,
                            });
                            me.arrayPresentacion.splice(dato);
                        }

                        me.arrayPresentacionesAsociadas.forEach(function(dato2){
                            if(dato['id']==dato2['id_presentacion'])
                            {
                                indices.push({
                                    indice: index,
                                });
                            }
                        });
                    });
                    
                    if(indices.length)
                    {
                        indices.forEach(function(indice){
                            me.arrayPresentacion.splice(indice['indice']);
                            console.log('splice: '+indice['indice']);
                        });
                    }
                    else
                    {
                        console.log('nada');
                    }*/
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            selectModeloContable(){
                let me=this;
                var url= this.ruta + '/modelo_contable/selectModeloContable';
                axios.get(url).then(function (response) {
                    //console.log(response);
                    var respuesta= response.data;
                    me.arrayCategoria = respuesta.modelo_contable;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            selectCategoria2(){
                let me=this;
                var url= this.ruta + '/categoria/selectCategoria';
                axios.get(url).then(function (response) {
                    //console.log(response);
                    var respuesta= response.data;
                    me.arrayCategoria2 = respuesta.categorias;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            selectUndMedida(){
                let me=this;
                var url= this.ruta + '/und_medida/selectUndMedida';
                axios.get(url).then(function (response) {
                    //console.log(response);
                    var respuesta= response.data;
                    me.arrayUndMedida = respuesta.unidades;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            selectConcentracion(){
                let me=this;
                var url= this.ruta + '/concentracion/selectConcentracion';
                axios.get(url).then(function (response) {
                    //console.log(response);
                    var respuesta= response.data;
                    me.arrayConcentracion = respuesta.concentracion;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            selectPresentacion(){
                let me=this;
                var url= this.ruta + '/presentacion/selectPresentacion';
                axios.get(url).then(function (response) {
                    //console.log(response);
                    var respuesta= response.data;
                    me.arrayPresentacion = respuesta.presentacion;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            listarIvas(){
                let me=this;
                var url= this.ruta + '/iva';
                axios.get(url).then(function (response) {
                    //console.log(response);
                    var respuesta= response.data;
                    me.arrayIvas = respuesta.iva.data;
                    
                    me.arrayIvaCompra = respuesta.ivaCompra;
                    me.arrayIvaVenta = respuesta.ivaVenta;
                    me.arrayIvaDevolucionesCompra = respuesta.ivaDevolucionCompra;
                    me.arrayIvaDevolucionesVenta = respuesta.ivaDevolucionVenta;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            selectIvaProducto(id){
                let me=this;
                var url= this.ruta + '/iva_producto/selectIvaProducto?id_producto='+id;
                axios.get(url).then(function (response) {
                    //console.log(response);
                    var respuesta= response.data;
                    me.arrayIvaProducto = respuesta.iva_producto;

                    for(var i=0; i<me.arrayIvaProducto.length; i++)
                    {
                        if(me.arrayIvaProducto[i]['tipo_iva'] == 'compras')
                        {
                            me.idIvaCompra = me.arrayIvaProducto[i]['id_iva'];
                        }
                        if(me.arrayIvaProducto[i]['tipo_iva'] == 'ventas')
                        {
                            me.idIvaVenta = me.arrayIvaProducto[i]['id_iva'];
                        }
                        if(me.arrayIvaProducto[i]['tipo_iva'] == 'devoluciones_compras')
                        {
                            me.idIvaDevolucionCompra = me.arrayIvaProducto[i]['id_iva'];
                        }
                        if(me.arrayIvaProducto[i]['tipo_iva'] == 'devoluciones_ventas')
                        {
                            me.idIvaDevolucionVenta = me.arrayIvaProducto[i]['id_iva'];
                        }
                    }

                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            eliminarIvaProducto(id){
                let me=this;

                axios.put( this.ruta + '/iva_producto/eliminarIvaProducto',{
                    'id': id
                }).then(function (response) {
                    me.selectIvaProducto(me.articulo_id);
                }).catch(function (error) {
                    console.log(error);
                }); 
            },
            crearExtras(nombre){
                if (this.validarExtras()){
                    return;
                }
                
                let me = this;

                axios.post(this.ruta +'/'+nombre+'/registrar',{
                    'nombre': this.nombre_crear,
                    'descripcion': this.descripcion_crear
                }).then(function (response) {
                    me.cerrarModalCrear();
                    me.selectModeloContable();
                    me.selectCategoria2();
                    me.selectUndMedida();
                    me.selectConcentracion();
                    me.selectPresentacion();
                }).catch(function (error) {
                    console.log(error);
                });
            },
            cargarImg(event){
                let me=this;
                me.arrayImg = event.target.files[0];
                // console.log(me.arrayImg);
                // console.log(me.arrayImg['file'][1]);
            },
            validarExtras(){
                this.errorCrear=0;
                this.errorMostrarMsjCrear =[];

                if (!this.nombre_crear) this.errorMostrarMsjCrear.push("El nombre no puede estar vacío.");

                if (this.errorMostrarMsjCrear.length) this.errorCrear = 1;

                return this.errorCrear;
            },
            cambiarPagina(page,buscar,criterio){
                let me = this;
                //Actualiza la página actual
                me.pagination.current_page = page;
                //Envia la petición para visualizar la data de esa página
                me.listarArticulo(page,buscar,criterio);
            },
            cambiarPaginaStock(page_stock,id_articulo){
                let me = this;
                //Actualiza la página actual
                me.pagination_stock.current_page_stock = page_stock;
                //Envia la petición para visualizar la data de esa página
                me.listarStock(page_stock,id_articulo);
            },
            /*registrarArticulo(){
                if (this.validarArticulo()){
                    return;
                }
                
                let me = this;

                axios.post(this.ruta + '/articulo/registrar',{
                    'idcategoria': this.idcategoria,
                    'idcategoria2': this.idcategoria2,
                    'nombre' : this.nombre,
                    'codigo': this.codigo,
                    'precio_venta': this.precio_venta,
                    'stock': this.stock,
                    'cod_invima': this.cod_invima,
                    'lote': this.lote,
                    'fec_vence': this.fec_vence,
                    'id_und_medida': this.id_und_medida,
                    'id_concentracion': this.id_concentracion,
                    'id_presentacion': this.id_presentacion,
                    'minimo': this.minimo,
                    'tipo_articulo': this.tipo_articulo,
                    'iva': this.iva,
                    'descripcion': this.descripcion,
                    'talla': this.talla,
                    'arrayTarifarios': this.arrayTarifarios,
                    'tipo_movimiento' : 1,
                }).then(function (response) {
                    me.idArticuloStock = response['id'];
                    me.cantidadStock = response['stock'];
                    me.tipoMovimientoStock = 1;
                    me.sumatoria = response['stock'];
                    // me.registrarStock();
                    me.cerrarModal();
                    me.listarArticulo(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                });
            },*/
            registrarArticulo(){
                if (this.validarArticulo()){
                    return;
                }
                
                let me = this;
                var data = new FormData();
                data.append('idcategoria', this.idcategoria);
                data.append('idcategoria2', this.idcategoria2);
                data.append('nombre', this.nombre);
                data.append('codigo', this.codigo);
                data.append('precio_venta', this.precio_venta);
                data.append('stock', this.stock);
                data.append('cod_invima', this.cod_invima);
                data.append('lote', this.lote);
                data.append('fec_vence', this.fec_vence);
                data.append('id_und_medida', this.id_und_medida);
                data.append('id_concentracion', this.id_concentracion);
                data.append('id_presentacion', this.id_presentacion);
                data.append('minimo', this.minimo);
                data.append('tipo_articulo', this.tipo_articulo);
                data.append('iva', this.iva);
                data.append('descripcion', this.descripcion);
                data.append('talla', this.talla);
                data.append('arrayTarifarios', JSON.stringify(this.arrayTarifarios));
                data.append('idIvaCompra', this.idIvaCompra);
                data.append('idIvaVenta', this.idIvaVenta);
                data.append('idIvaDevolucionCompra', this.idIvaDevolucionCompra);
                data.append('idIvaDevolucionVenta', this.idIvaDevolucionVenta);
                data.append('tipo_movimiento', 1);
                data.append('img', this.arrayImg);

                axios.post(this.ruta +'/articulo/registrar', data,{
                    headers:{'Content-Type':'multipart/form-data'}
                }).then(function (response) {
                    me.idArticuloStock = response['id'];
                    me.cantidadStock = response['stock'];
                    me.tipoMovimientoStock = 1;
                    me.sumatoria = response['stock'];
                    // me.registrarStock();
                    me.cerrarModal();
                    me.listarArticulo(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                });
            },
            registrarStock(){
                // if (this.validarArticulo()){
                //     return;
                // }
                
                let me = this;

                axios.post(this.ruta + '/stock/registrar',{
                    'id_producto': this.idArticuloStock,
                    'cantidad' : this.cantidadStock,
                    'tipo_movimiento': this.tipoMovimientoStock,
                    'sumatoria': this.sumatoria
                }).then(function (response) {

                }).catch(function (error) {
                    console.log(error);
                });
            },
            registrarIvaProducto(){
                // if (this.validarArticulo()){
                //     return;
                // }
                
                let me = this;

                axios.post(this.ruta + '/iva_producto/registrar',{
                    'id_producto' : this.articulo_id,
                    'idIvaCompra' : this.idIvaCompra,
                    'idIvaVenta' : this.idIvaVenta,
                    'idIvaDevolucionCompra' : this.idIvaDevolucionCompra,
                    'idIvaDevolucionVenta' : this.idIvaDevolucionVenta,
                }).then(function (response) {
                    me.selectIvaProducto(me.articulo_id);
                    me.tipoAccion7=0;
                }).catch(function (error) {
                    console.log(error);
                });
            },
            actualizarArticulo(){
                // if (this.validarConcentracion()){
                //     return;
                // }

                let me = this;
                
                var data2 = new FormData();
                data2.append('idcategoria', this.idcategoria);
                data2.append('idcategoria2', this.idcategoria2);
                data2.append('nombre', this.nombre);
                data2.append('codigo', this.codigo);
                data2.append('precio_venta', this.precio_venta);
                data2.append('stock', this.stock);
                data2.append('cod_invima', this.cod_invima);
                data2.append('lote', this.lote);
                data2.append('fec_vence', this.fec_vence);
                data2.append('id_und_medida', this.id_und_medida);
                data2.append('id_concentracion', this.id_concentracion);
                data2.append('id_presentacion', this.id_presentacion);
                data2.append('minimo', this.minimo);
                data2.append('tipo_articulo', this.tipo_articulo);
                data2.append('iva', this.iva);
                data2.append('descripcion', this.descripcion);
                data2.append('talla', this.talla);
                data2.append('arrayTarifarios', JSON.stringify(this.arrayTarifarios));
                data2.append('idIvaCompra', this.idIvaCompra);
                data2.append('idIvaVenta', this.idIvaVenta);
                data2.append('idIvaDevolucionCompra', this.idIvaDevolucionCompra);
                data2.append('idIvaDevolucionVenta', this.idIvaDevolucionVenta);
                data2.append('img', this.arrayImg);
                data2.append('id', this.articulo_id);

                axios.post(this.ruta +'/articulo/actualizar', data2,{
                    headers:{'Content-Type':'multipart/form-data'},
                }).then(function (response) {
                    me.cerrarModal();
                    me.listarArticulo(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                });
            },
            desactivarArticulo(id){
                Swal.fire({
                    title: 'Esta seguro de desactivar este artículo?',
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Aceptar!',
                    cancelButtonText: 'Cancelar',
                    confirmButtonClass: 'btn btn-success',
                    cancelButtonClass: 'btn btn-danger',
                    buttonsStyling: false,
                    reverseButtons: true
                }).then((result) => 
                {
                    if (result.value) {
                        let me = this;

                        axios.put( this.ruta + '/articulo/desactivar',{
                            'id': id
                        }).then(function (response) {
                            me.listarArticulo(1,'','nombre');
                            swal(
                            'Desactivado!',
                            'El registro ha sido desactivado con éxito.',
                            'success'
                            )
                        }).catch(function (error) {
                            console.log(error);
                        });
                        
                        
                    } else if ( result.dismiss === swal.DismissReason.cancel) 
                    { }
                }) 
            },
            activarArticulo(id){
               Swal.fire({
                title: 'Esta seguro de activar este artículo?',
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Aceptar!',
                cancelButtonText: 'Cancelar',
                confirmButtonClass: 'btn btn-success',
                cancelButtonClass: 'btn btn-danger',
                buttonsStyling: false,
                reverseButtons: true
                }).then((result) => {
                if (result.value) {
                    let me = this;

                    axios.put( this.ruta + '/articulo/activar',{
                        'id': id
                    }).then(function (response) {
                        me.listarArticulo(1,'','nombre');
                        swal(
                        'Activado!',
                        'El registro ha sido activado con éxito.',
                        'success'
                        )
                    }).catch(function (error) {
                        console.log(error);
                    });
                    
                    
                } else if (
                    // Read more about handling dismissals
                    result.dismiss === swal.DismissReason.cancel
                ) {
                    
                }
                }) 
            },
            validarArticulo(){
                this.errorArticulo=0;
                this.errorMostrarMsjArticulo =[];

                if (!this.nombre) this.errorMostrarMsjArticulo.push("El nombre del artículo no puede estar vacío.");
                if (this.idcategoria==0) this.errorMostrarMsjArticulo.push("Seleccione un modelo contable.");
                if (this.idcategoria2==0) this.errorMostrarMsjArticulo.push("Seleccione una categoría.");
                if (!this.precio_venta || this.precio_venta<=0) this.errorMostrarMsjArticulo.push("El precio de venta debe ser mayor a '0'.");
                
                if(!this.tipo_articulo) this.errorMostrarMsjArticulo.push('Seleccione el tipo de producto');

                if(this.tipo_articulo==1){
                    if (!this.stock || this.stock<=0) this.errorMostrarMsjArticulo.push("El stock del artículo debe ser mayor a '0'.");
                    if(!this.cod_invima) this.errorMostrarMsjArticulo.push('Ingrese el codigo invima');
                    if(!this.lote) this.errorMostrarMsjArticulo.push('Ingrese el lote del producto');
                    if(!this.fec_vence) this.errorMostrarMsjArticulo.push('Ingrese la fecha de vencimiento');
                    if(this.minimo<=0) this.errorMostrarMsjArticulo.push("La cantidad minima debe ser mayor a '0'.");
                    if(!this.talla) this.errorMostrarMsjArticulo.push('Ingrese la talla del producto');
                    if(this.und_medida==0) this.errorMostrarMsjArticulo.push('Seleccione la unidad de medida del producto');
                }

                if(this.tipo_articulo==2){
                    if(!this.cod_invima) this.errorMostrarMsjArticulo.push('Ingrese el codigo invima');
                }

                if(this.tipo_articulo==3){
                    if (!this.stock || this.stock<=0) this.errorMostrarMsjArticulo.push("El stock del artículo debe ser mayor a '0'.");
                    if(!this.cod_invima) this.errorMostrarMsjArticulo.push('Ingrese el codigo invima');
                    if(!this.lote) this.errorMostrarMsjArticulo.push('Ingrese el lote del producto');
                    if(this.minimo<=0) this.errorMostrarMsjArticulo.push("La cantidad minima debe ser mayor a '0'.");
                    if(!this.talla) this.errorMostrarMsjArticulo.push('Ingrese la talla del producto');
                    if(this.und_medida==0) this.errorMostrarMsjArticulo.push('Seleccione la unidad de medida del producto');
                }

                if(!this.id_presentacion) this.errorMostrarMsjArticulo.push('Seleccione la presentacion del producto');
                if(!this.codigo) this.errorMostrarMsjArticulo.push('Ingrese el codigo de barras del producto');
                if(this.tipoAccion==1 && this.$refs.inputFileImg.value=='') this.errorMostrarMsjArticulo.push('Seleccione una imagen para el producto');

                this.errorTarifario = 0;
                for(var i=0; i<this.arrayTarifarios.length; i++)
                {
                    if(!this.arrayTarifarios[i].valor || this.arrayTarifarios[i].valor=='' || this.arrayTarifarios.valor=='undefined')
                    {
                        this.errorTarifario = 1;
                    }
                }

                if(this.errorTarifario==1) this.errorMostrarMsjArticulo.push('Debe asignar valores a todos los tarifarios del producto');

                if(this.idIvaCompra==0 || this.idIvaVenta==0 || this.idIvaDevolucionCompra==0 || this.idIvaDevolucionVenta==0) this.errorMostrarMsjArticulo.push('Debe asignar valores a todos los Ivas del producto');

                if (this.errorMostrarMsjArticulo.length) this.errorArticulo = 1;

                return this.errorArticulo;
            },
            cerrarModal(){
                this.modal=0;
                this.tituloModal='';
                this.idcategoria= 0;
                this.idcategoria2= 0;
                this.nombreModeloContable=''
                this.nombre_categoria = '';
                this.codigo = '';
                this.nombre = '';
                this.precio_venta = 0;
                this.stock = 0;
                this.cod_invima = '';
                this.lote = '';
                this.fec_vence = '';
                this.nombre_und_medida = '';
                this.nombre_concentracion = '';
                this.nombre_presentacion = '';
                this.descripcion = '';
                this.descripcionModeloContable = '';
                this.minimo = '';
                this.tipo_articulo = '',
                this.iva = 0;
                this.talla = '';
                this.img = '';
                this.arrayImg = [];
                this.$refs.inputFileImg.value = '';
                this.errorArticulo=0;
                
                this.idArticuloStock = 0;
                this.cantidadStock = 0;
                this.sumatoria = 0;

                this.arrayTarifarios = [];
                this.arrayCategoria = [];
                this.arrayCategoria2 = [];
                this.arrayConcentracion = [];
                this.arrayPresentacion = [];
                this.arrayUndMedida =[];

                this.idProductoPresentacionAsociada = 0;
                this.unidadesPresentacionAsociada = 0;
                this.idPresentacionAsociada = 0;

                this.idIvaCompra = 0;
                this.idIvaVenta = 0;
                this.idIvaDevolucionCompra = 0;
                this.idIvaDevolucionVenta = 0;

                this.arrayIvaCompra = [];
                this.arrayIvaVenta = [];
                this.arrayIvaDevolucionesCompra = [];
                this.arrayIvaDevolucionesVenta = [];
            },
            abrirModal(modelo, accion, data = []){
                switch(modelo){
                    case "articulo":
                    {
                        switch(accion){
                            case 'registrar':
                            {
                                this.modal = 1;
                                this.tituloModal = 'Registrar Artículo';
                                this.idcategoria=0;
                                this.codigo='';
                                this.nombre= '';
                                this.precio_venta=0;
                                this.stock=0;
                                this.cod_invima='';
                                this.lote='';
                                this.fec_vence='';
                                this.id_und_medida='';
                                this.id_concentracion='';
                                this.id_presentacion='';
                                this.minimo='';
                                this.tipo_articulo='';
                                this.descripcion = '';
                                this.talla = '';
                                this.tipoAccion = 1;
                                this.listarTarifarios('');
                                break;
                            }
                            case 'actualizar':
                            {
                                // console.log(data);
                                this.modal=1;
                                this.tituloModal='Actualizar Artículo';
                                this.tipoAccion=2;
                                this.articulo_id=data['id'];
                                this.idcategoria=data['idcategoria'];
                                this.idcategoria2=data['idcategoria2'];
                                this.codigo=data['codigo'];
                                this.nombre = data['nombre'];
                                this.stock=data['stock'];
                                this.precio_venta=data['precio_venta'];
                                this.cod_invima=data['cod_invima'];
                                this.lote=data['lote'];
                                this.fec_vence=data['fec_vence'];
                                this.id_und_medida=data['id_und_medida'];
                                this.id_concentracion=data['id_concentracion'];
                                this.id_presentacion=data['id_presentacion'];
                                this.minimo=data['minimo'];
                                this.tipo_articulo=data['tipo_articulo'];
                                this.descripcion= data['descripcion'];
                                this.talla = data['talla'];
                                this.selectIvaProducto(this.articulo_id);
                                this.listarTarifarios(data['id']);
                                break;
                            }
                            case 'tarifarios':
                            {
                                this.modal3 = 1;
                                this.tituloModal3 = 'Tarifarios';
                                break;
                            }
                            case 'productos_asociados':
                            {
                                this.modal6 = 1;
                                this.tituloModal6 = 'Presentación asociados';
                                this.idProductoPresentacionAsociada = data['id'];
                                this.listarTarifarios('');
                                this.selectPresentacion();
                                this.listarPresentacionesAsociadas(data['id'],data['id_presentacion']);
                                break;
                            }
                            case 'iva':
                            {
                                this.modal7 = 1;
                                this.tituloModal7 = 'Configurar ivas';
                                this.listarIvas();
                                // this.selectIvaProducto(this.articulo_id);
                                break;
                            }
                            case 'iva_registrar':
                            {
                                this.tipoAccion7 = 1;
                                
                                for(var i=0; i<this.arrayIvaProducto.length; i++)
                                {
                                    if(this.arrayIvaProducto[i]['tipo_iva'] == 'compras')
                                    {
                                        this.idIvaCompra = this.arrayIvaProducto[i]['id_iva'];
                                    }
                                    if(this.arrayIvaProducto[i]['tipo_iva'] == 'ventas')
                                    {
                                        this.idIvaVenta = this.arrayIvaProducto[i]['id_iva'];
                                    }
                                    if(this.arrayIvaProducto[i]['tipo_iva'] == 'devoluciones_compras')
                                    {
                                        this.idIvaDevolucionCompra = this.arrayIvaProducto[i]['id_iva'];
                                    }
                                    if(this.arrayIvaProducto[i]['tipo_iva'] == 'devoluciones_ventas')
                                    {
                                        this.idIvaDevolucionVenta = this.arrayIvaProducto[i]['id_iva'];
                                    }
                                }
                                // console.log('compra: '+this.idIvaCompra+' venta: '+this.idIvaVenta+' dev compras: '+this.idIvaDevolucionCompra+' dev ventas: '+this.idIvaDevolucionVenta);
                                break;
                            }
                        }
                        this.selectModeloContable();
                        this.selectCategoria2();
                        this.selectUndMedida();
                        this.selectConcentracion();
                        this.selectPresentacion();
                    }
                }
                
            },
            cerrarModalCrear(){
                this.modalCrear=0;
                this.tituloModalCrear='';
                this.nombre_crear = '';
                this.descripcion_crear = '';
		        this.errorCrear=0;
            },
            abrirModalCrear(accion2){
                
                switch(accion2){
                    case "modelo_contable":
                    {   
                        this.modal4 = 1;
                        this.tituloModal4 = 'Crear Modelo Contable';
                        break;
                    }
                    case "categoria2":
                    {   
                        this.modalCrear = 1;
                        this.tituloModalCrear = 'Categoria';
                        this.nombre_crear= '';
                        this.descripcion_crear = '';
                        this.tipoAccionCrear = 1;
                        break;
                    }
                    case "und_medida":
                    {   
                        this.modalCrear = 2;
                        this.tituloModalCrear = 'Und. medida';
                        this.nombre_crear= '';
                        this.descripcion_crear = '';
                        this.tipoAccionCrear = 1;
                        break;
                    }
                    case "concentracion":
                    {   
                        this.modalCrear = 3;
                        this.tituloModalCrear = 'Concentración';
                        this.nombre_crear= '';
                        this.descripcion_crear = '';
                        this.tipoAccionCrear = 1;
                        break;
                    }
                    case "presentacion":
                    {   
                        this.modalCrear = 4;
                        this.tituloModalCrear = 'Presentación';
                        this.nombre_crear= '';
                        this.descripcion_crear = '';
                        this.tipoAccionCrear = 1;
                        break;
                    }
                }
            },
            cerrarModal4(){
                this.modal4 = 0;
                this.tituloModal4 = '';
                this.idCuentaProductos = 0;
                this.cuentaProductos = '';
                this.codCuentaProductos = '';
                this.idCuentaSalidaProductos = 0;
                this.cuentaSalidaProductos = '';
                this.codCuentaSalidaProductos = '';
                this.idCuentaSaldosIniciales = 0;
                this.cuentaSaldosIniciales = '';
                this.codCuentaSaldosIniciales = '';
                this.idCuentaDonaciones = 0;
                this.cuentaDonaciones = '';
                this.codCuentaDonaciones = '';
            },
            cerrarModal6(){
                this.modal6 = 0;
                this.tituloModal6 = 0;
                this.idProductoPresentacionAsociada = 0;
                this.unidadesPresentacionAsociada = 0;
                this.idPresentacionAsociada = 0;
                this.arrayPresentacionesAsociadas = [];
                this.arrayTarifarios = [];
            },
            cerrarModal7(){
                this.modal7 = 0;
                this.tituloModal7 = 0;
                this.arrayIvas = [];
                this.ivaCompra = 0;
                this.ivaVenta = 0;
                this.ivaDevCompra = 0;
                this.ivaDevVenta = 0;
            },
            cerrarModalCrear7(){
                this.tipoAccion7=0;
                this.ivaCompra=0;
                this.ivaVenta=0;
                this.ivaDevCompra=0;
                this.ivaDevVenta=0;
            },
            cerrarModalStock(){
                this.modal2=0;
                this.tituloModalStock='';
                this.idArticuloStock = 0;
                // console.log('cerrar: '+this.idArticuloStock);
                this.arrayStock = [];
                this.fecIni = '2019-01-01';
                this.fecFin = this.fecActual;
		        this.errorStock=0;
            },
            cerrarModalTarifario(){
                this.modal3=0;
                this.tituloModal3='';
                this.tipoAccionModal3=1
            },
            abrirModalStock(accion, data=[]){
                switch(accion){
                    case "ver":
                    {   
                        this.modal2 = 1;
                        this.tituloModalStock = 'Lista de stock';
                        this.tipoAccionStock = 1;
                        this.idArticuloStock = data;
                        // console.log('abrir: '+this.idArticuloStock); 
                        this.listarStock(1,data);
                        break;
                    }
                    case "registrar":
                    {   this.modal2 = 2;
                        this.tituloModalStock = 'Registrar Stock';
                        this.tipoAccionStock = 1;
                        break;
                    }
                }
            },
            cerrarModalCuentas(){
                this.modal5=0;
                this.tituloModal5='';
                this.cta_busq='';
                this.arrayCuentasBusq=[];
                this.tipoCuenta = '';
            },
            abrirModalCuentas(modelo){
                this.modal5 = 1;
                switch(modelo)
                {
                    case 'productos':{
                        this.tituloModal5 = 'Cuenta para productos';
                        this.tipoCuenta = 'productos';
                        break;
                    }
                    case 'salida_productos':{
                        this.tituloModal5 = 'Cuenta de salida de productos';
                        this.tipoCuenta = 'salida_productos';
                        break;
                    }
                    case 'saldos_iniciales':{
                        this.tituloModal5 = 'Cuenta de saldos iniciales';
                        this.tipoCuenta = 'saldos_iniciales';
                        break;
                    }
                    case 'donaciones':{
                        this.tituloModal5 = 'Cuenta para donaciones';
                        this.tipoCuenta = 'donaciones';
                        break;
                    }
                }
            },
            buscarCuentaB(){
                let me=this;            
                var url= this.ruta +'/planCuentas/selectCuentaInfo?busqueda=' + me.cta_busq;

                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayCuentasBusq = respuesta.cuentas;
                })
                .catch(function (error) {
                    console.log(error);
                });

            },
            cargarCuentaB(cuenta, tipoCuenta){
                let me=this;
                switch(tipoCuenta)
                {
                    case 'productos':{
                        me.idCuentaProductos = cuenta['id'];
                        me.cuentaProductos = cuenta['nombre'];
                        me.codCuentaProductos = cuenta['codigo'];
                        break;
                    }
                    case 'salida_productos':{
                        me.idCuentaSalidaProductos = cuenta['id'];
                        me.cuentaSalidaProductos = cuenta['nombre'];
                        me.codCuentaSalidaProductos = cuenta['codigo'];
                        break;
                    }
                    case 'saldos_iniciales':{
                        me.idCuentaSaldosIniciales = cuenta['id'];
                        me.cuentaSaldosIniciales = cuenta['nombre'];
                        me.codCuentaSaldosIniciales = cuenta['codigo'];
                        break;
                    }
                    case 'donaciones':{
                        me.idCuentaDonaciones = cuenta['id'];
                        me.cuentaDonaciones = cuenta['nombre'];
                        me.codCuentaDonaciones = cuenta['codigo'];
                        break;
                    }
                }
                me.cerrarModalCuentas();
            },
            registrarModeloContable(){
                // if (this.validarCategoria()){
                //     return;
                // }
                
                let me = this;

                axios.post(this.ruta +'/modelo_contable/registrar',{
                    'nombre': this.nombreModeloContable,
                    'descripcion': this.descripcionModeloContable,
                    'idCuentaProductos': this.idCuentaProductos,
                    'idCuentaSalidaProductos': this.idCuentaSalidaProductos,
                    'idCuentaSaldosIniciales': this.idCuentaSaldosIniciales,
                    'idCuentaDonaciones': this.idCuentaDonaciones,
                }).then(function (response) {
                    me.cerrarModal4();
                    me.selectModeloContable();
                }).catch(function (error) {
                    console.log(error);
                });
            },
            registrarProductosAsociados(){
                
                let me = this;

                axios.post(this.ruta +'/productos_asociados/registrar',{
                    'id_presentacion': this.idPresentacionAsociada,
                    'id_producto': this.idProductoPresentacionAsociada,
                    'unidades': this.unidadesPresentacionAsociada,
                    'arrayTarifarios': this.arrayTarifarios,
                }).then(function (response) {
                    me.tipoAccion6=0;
                    me.selectPresentacion();
                    me.listarPresentacionesAsociadas(me.idProductoPresentacionAsociada);
                }).catch(function (error) {
                    console.log(error);
                });
            },
        },
        mounted() {
            var d = new Date();
            
            
            var dd = d.getDate();
            var mm = d.getMonth()+1;
            var yyyy = d.getFullYear();
            if(dd<10){
                dd='0'+dd;
            } 
            if(mm<10){
                mm='0'+mm;
            } 
            d = yyyy+'-'+mm+'-'+dd;
            this.fecFin = d;
            this.fecActual = d;

            this.listarArticulo(1,this.buscar,this.criterio);
        }
    }
</script>
<style>    
    .modal-content{
        width: 130% !important;
        position: absolute !important;
    }
    .mostrar{
        display: list-item !important;
        opacity: 1 !important;
        position: absolute !important;
        background-color: #3c29297a !important;
    }
    .div-error{
        display: flex;
        justify-content: center;
    }
    .text-error{
        color: red !important;
        font-weight: bold;
    }

    .mostrar-crear{
        display: inline !important;
    }
    .modal-content2{
        width: 130% !important;
        position: absolute !important;
    }
</style>
