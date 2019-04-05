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
                        <i class="fa fa-align-justify"></i> Facturacion
                        <button type="button" @click="mostrarDetalle('facturacion','registrar')" v-show="listado==1" class="btn btn-secondary">
                            <i class="icon-plus"></i>&nbsp;Nuevo
                        </button>
                    </div>
                    <!-- Listado-->
                    <template v-if="listado==1">
                    <div class="card-body">
                        <div class="form-group">
                            <div class="row">
                                <!--
                                <div class="input-group">
                                    <select class="form-control col-md-3" v-model="criterio">
                                        <option value="tipo_comprobante">Tipo Comprobante</option>
                                        <option value="num_comprobante">Número Comprobante</option>
                                        <option value="fecha_hora">Fecha-Hora</option>
                                    </select>
                                    <input type="text" v-model="buscar" @keyup.enter="listarFacturacion(1,buscar,criterio)" class="form-control" placeholder="Texto a buscar">
                                    <button type="submit" @click="listarFacturacion(1,buscar,criterio)" class="btn btn-primary"><i class="fa fa-search"></i> Buscar</button>
                                </div>
                                -->
                                <div class="form-group col-md-3">
                                    <label class="float-left">N° factura</label>
                                    <div class="col-md-8 float-right">
                                        <input type="number" :min=0 class="form-control" v-model="numFacturaFiltro">
                                    </div>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="float-left">Estado</label>
                                    <div class="col-md-8 float-right">
                                        <select class="form-control" v-model="estadoFiltro">
                                            <option value="0">Todas</option>
                                            <option value="1">Activa</option>
                                            <option value="2">Registrada</option>
                                            <option value="3">Enviada</option>
                                            <option value="4">Anulada</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="" class="float-left">Tercero(*) </label>
                                    <div class="form-inline float-right">
                                        <input type="text" readonly style="max-width: 85px;" class="form-control" name="cuenta_fin" v-model="terceroFiltro">
                                        <button @click="abrirModalT('tercero_filtro')" style="min-width: 30px;" class="btn btn-primary form-control">...</button>
                                        <button @click="quitar(4)" style="min-width: 30px;" class="btn btn-danger form-control">
                                            <i class="icon-trash"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label class="float-left">Orden</label>
                                    <div class="col-md-8 float-right">
                                        <select v-model="ordenFiltro" class="form-control">
                                            <option value="num_factura">N° Factura</option>
                                            <option value="nom_tercero">Tercero</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <label class="float-left">Desde:</label>
                                    <div class="col-md-8 float-right">
                                        <input type="date" class="form-control" v-model="desdeFiltro">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label class="float-left">Hasta:</label>
                                    <div class="col-md-8 float-right">
                                        <input type="date" class="form-control" v-model="hastaFiltro">
                                    </div>
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="" class="float-left">Vendedor(*) </label>
                                    <div class="form-inline float-right">
                                        <input type="text" readonly style="max-width: 85px;" class="form-control" name="cuenta_fin" v-model="vendedorFiltro">
                                        <button @click="abrirModalT('vendedor_filtro')" style="min-width: 30px;" class="btn btn-primary form-control">...</button>
                                        <button @click="quitar(5)" style="min-width: 30px;" class="btn btn-danger form-control">
                                            <i class="icon-trash"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <button type="submit" @click="listarFacturacion(1,numFacturaFiltro,estadoFiltro,idTerceroFiltro,ordenFiltro,desdeFiltro,hastaFiltro,idVendedorFiltro)" class="btn btn-primary">
                                        <i class="fa fa-search"></i> Buscar
                                    </button>
                                </div>
                            </div>  
                        </div>
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped table-sm">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>N° factura</th>
                                        <th>Tercero</th>
                                        <th>Fecha</th>
                                        <th>Subtotal</th>
                                        <th>Descuento</th>
                                        <th>Iva</th>
                                        <th>Total</th>
                                        <th>Estado</th>
                                        <th>Opciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="facturacion in arrayFacturacion" :key="facturacion.id" style="text-align: right;">
                                        <td v-text="facturacion.id"></td>
                                        <td v-text="facturacion.num_factura"></td>
                                        <td v-text="facturacion.nom_tercero"></td>
                                        <td v-text="facturacion.fecha"></td>
                                        <td v-text="facturacion.subtotal"></td>
                                        <td v-text="facturacion.descuento"></td>
                                        <td v-text="facturacion.valor_iva"></td>
                                        <td v-text="facturacion.total"></td>
                                        <td v-if="facturacion.estado==1"><span>Activa</span></td>
                                        <td v-else-if="facturacion.estado==2"><span>Registrada</span></td>
                                        <td v-else-if="facturacion.estado==3"><span>Enviada</span></td>
                                        <td v-else-if="facturacion.estado==4"><span>Anulada</span></td>
                                        <td>
                                            <button type="button" @click="verIngreso(facturacion.id)" class="btn btn-success btn-sm">
                                                <i class="icon-eye"></i>
                                            </button>
                                            <template>
                                                <button type="button" @click="mostrarDetalle('facturacion','actualizar',facturacion)" class="btn btn-warning btn-sm" v-if="facturacion.estado!=3">
                                                    <i class="icon-pencil"></i>
                                                </button>
                                                <button type="button" class="btn btn-default btn-sm" v-else>
                                                    <i class="icon-pencil"></i>
                                                </button>
                                            </template>
                                            <!--
                                            <template v-if="facturacion.estado==1">
                                                <button type="button" class="btn btn-warning btn-sm" @click="cambiarEstadoFacturacion(facturacion.id,'registrar')">
                                                    <i class="fa fa-registered"></i>
                                                </button>
                                            </template>
                                            <template v-else-if="facturacion.estado==2">
                                                <button type="button" class="btn btn-primary btn-sm" @click="cambiarEstadoFacturacion(facturacion.id,'enviar')">
                                                    <i class="fa fa-share-square"></i>
                                                </button>
                                            </template>
                                            <template v-if="facturacion.estado==3">
                                                <button type="button" class="btn btn-default btn-sm">
                                                    <i class="fa fa-share-square"></i>
                                                </button>
                                            </template>
                                            -->
                                            <template>
                                                <button type="button" class="btn btn-danger btn-sm" @click="cambiarEstadoFacturacion(facturacion.id,'anular')" v-if="facturacion.estado!=4 && facturacion.estado!=3">
                                                    <i class="fa fa-eye-slash"></i>
                                                </button>
                                                <button type="button" class="btn btn-default btn-sm" v-else>
                                                    <i class="fa fa-eye-slash"></i>
                                                </button>
                                            </template>
                                        </td>
                                    </tr>                                
                                </tbody>
                            </table>
                        </div>
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
                    </template>
                    <!--Fin Listado-->
                    <!-- Detalle-->
                    <template v-else-if="listado==0">
                    <div class="card-body">
                        <div class="form-group row border">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Fecha</label>
                                    <input type="date" class="form-control" v-model="fecha">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>N° factura</label>
                                    <input type="number" disabled class="form-control" v-model="num_factura">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="">Tercero(*)</label>
                                    <div class="form-inline">
                                        <input type="text" readonly style="    max-width: 90px;" class="form-control" name="cuenta_fin" v-model="tercero">
                                        <button @click="abrirModalT('terceros')" style="    min-width: 30px;" class="btn btn-primary form-control">...</button>
                                        <button @click="quitar(3)" style="    min-width: 30px;" class="btn btn-danger form-control">
                                            <i class="icon-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Detalle</label>
                                    <input type="text" class="form-control" v-model="detalle">
                                </div>
                            </div>
                            <div class="row">
                                <div v-show="errorIngreso" class="form-group row div-error">
                                    <div class="text-center text-error">
                                        <div v-for="error in errorMostrarMsjIngreso" :key="error" v-text="error">

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3" v-if="estado">
                                <div class="form-group">
                                    <label>Estado</label>
                                    <select v-if="estado!=3" v-model="estado" class="form-control">
                                        <option value="1" v-if="estado==1" disabled selected>Creada</option>
                                        <option value="2">Registrada</option>
                                        <option value="3">Enviada</option>
                                        <option value="4">Anulada</option>
                                    </select>
                                    <input type="text" disabled v-else value="Enviada" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="form-group row border">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Artículo <span style="color:red;" v-show="idarticulo==0">(*Seleccione)</span></label>
                                    <div class="form-inline">
                                        <input type="text" class="form-control col-md-4" v-model="codigo" @keyup.enter="buscarArticulo()" placeholder="Ingrese artículo">
                                        <button @click="abrirModal()" class="btn btn-primary">...</button>
                                        <input type="text" readonly class="form-control col-md-4" v-model="articulo">
                                    </div>                                    
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Precio <span style="color:red;" v-show="precio==0">(*Ingrese)</span></label>
                                    <input type="number" value="0" step="any" class="form-control" v-model="precio">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Cantidad <span style="color:red;" v-show="cantidad==0">(*Ingrese)</span></label>
                                    <input type="number" value="0" class="form-control" v-model="cantidad">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Descuento <span style="color:red;" v-show="descuento==0">(*Ingrese)</span></label>
                                    <input type="number" value="0" class="form-control" v-model="descuento">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <button @click="agregarDetalle()" class="btn btn-success form-control btnagregar"><i class="icon-plus"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row border">
                            <div class="table-responsive col-md-12">
                                <table class="table table-bordered table-striped table-sm">
                                    <thead>
                                        <tr>
                                            <th>Opciones</th>
                                            <th>Artículo</th>
                                            <th>Precio</th>
                                            <th style="width: 9em;">Cantidad</th>
                                            <th style="width: 9em;">Descuento</th>
                                            <th>Iva</th>
                                            <th style="width: 9em;">Vr sin iva</th>
                                        </tr>
                                    </thead>
                                    <tbody v-if="arrayDetalle.length">
                                        <tr v-for="(detalle,index) in arrayDetalle" :key="detalle.id">
                                            <td>
                                                <button @click="eliminarDetalle(index)" type="button" class="btn btn-danger btn-sm">
                                                    <i class="icon-close"></i>
                                                </button>
                                            </td>
                                            <td v-text="detalle.articulo">
                                            </td>
                                            <td style="text-align: right;">
                                                $ {{detalle.precio}}
                                            </td>
                                            <td>
                                                <input v-model="detalle.cantidad" type="number" class="form-control" style="width: 9em; text-align: right;" :min="1" :max="detalle.stock">
                                            </td>
                                            <td>
                                                <input v-model="detalle.valor_descuento" type="number" value="0" class="form-control" style="width: 9em; text-align: right;" :min="0" :max="detalle.valor_subtotal">
                                            </td>
                                            <td style="text-align: right;">
                                                $ {{detalle.valor_iva=Math.round((detalle.precio*detalle.cantidad)-((detalle.precio*detalle.cantidad)/((detalle.iva/100)+1)))}}
                                            </td>
                                            <td style="text-align: right;">
                                                $ {{detalle.valor_subtotal=(detalle.precio*detalle.cantidad)-detalle.valor_iva-detalle.valor_descuento}}
                                            </td>
                                        </tr>
                                        <tr style="background-color: #CEECF5; text-align: right;">
                                            <td colspan="6" align="right"><strong>Total iva:</strong></td>
                                            <td>$ {{valor_iva=calcularTotalIva}}</td>
                                        </tr>
                                        <tr style="background-color: #CEECF5; text-align: right;">
                                            <td colspan="6" align="right"><strong>Total sin iva:</strong></td>
                                            <td>$ {{subtotal=calcularSubtotal}}</td>
                                        </tr>
                                        <tr style="background-color: #CEECF5; text-align: right;">
                                            <td colspan="6" align="right"><strong>Total Neto:</strong></td>
                                            <td>$ {{valor_final=calcularTotal}}</td>
                                        </tr>
                                        <tr style="background-color: #CEECF5; text-align: right;">
                                            <td colspan="6" align="right"><strong>Abono:</strong></td>
                                            <td><input v-model="abono" :min="0" :max="calcularTotal" type="number" class="form-control" style="width: 9em; text-align: right;"></td>
                                        </tr>
                                        <tr style="background-color: #CEECF5; text-align: right;">
                                            <td colspan="6" align="right"><strong>Saldo:</strong></td>
                                            <td>$ {{saldo=calcularSaldo}}</td>
                                        </tr>
                                    </tbody>
                                    <tbody v-else>
                                        <tr class="container-fluid">
                                            <td colspan="7">
                                                NO hay artículos agregados
                                            </td>
                                        </tr>
                                    </tbody>                                    
                                </table>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-12">
                                <button type="button" @click="ocultarDetalle()" class="btn btn-secondary">Cerrar</button>
                                <button type="button" class="btn btn-primary" v-if="tipoAccion2==1" @click="registrarFacturacion()">Registrar Factura</button>
                                <button type="button" v-else-if="tipoAccion2==2" class="btn btn-primary" @click="actualizarFacturacion()">Actualizar Factura</button>
                            </div>
                        </div>
                    </div>
                    </template>
                    <!-- Fin Detalle-->
                    <!-- Ver ingreso -->
                    <template v-else-if="listado==2">
                    <div class="card-body">
                        <div class="form-group row border">
                            <div class="col-md-9">
                                <div class="form-group">
                                    <label for="">Proveedor</label>
                                    <p v-text="proveedor"></p>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row border">
                            <div class="table-responsive col-md-12">
                                <table class="table table-bordered table-striped table-sm">
                                    <thead>
                                        <tr>
                                            <th>Artículo</th>
                                            <th>Precio</th>
                                            <th>Cantidad</th>
                                            <th>Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody v-if="arrayDetalle.length">
                                        <tr v-for="detalle in arrayDetalle" :key="detalle.id">
                                            <td v-text="detalle.articulo">
                                            </td>
                                            <td v-text="detalle.precio">
                                            </td>
                                            <td v-text="detalle.cantidad">
                                            </td>
                                            <td>
                                                {{detalle.precio*detalle.cantidad}}
                                            </td>
                                        </tr>
                                        <tr style="background-color: #CEECF5;">
                                            <td colspan="3" align="right"><strong>Total Neto:</strong></td>
                                            <td>$ {{total}}</td>
                                        </tr>
                                    </tbody>
                                    <tbody v-else>
                                        <tr>
                                            <td colspan="4">
                                                NO hay artículos agregados
                                            </td>
                                        </tr>
                                    </tbody>                                    
                                </table>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-12">
                                <button type="button" @click="ocultarDetalle()" class="btn btn-secondary">Cerrar</button>
                                
                            </div>
                        </div>
                    </div>
                    </template>
                    <!-- fin ver ingreso -->
                </div>
                <!-- Fin ejemplo de tabla Listado -->
            </div>
            <!--Inicio del modal agregar/actualizar-->
            <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" v-text="tituloModal"></h4>
                            <button type="button" class="close" @click="cerrarModal()" aria-label="Close">
                              <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group row">
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <select class="form-control col-md-3" v-model="criterioA">
                                        <option value="nombre">Nombre</option>
                                        <option value="descripcion">Descripción</option>
                                        <option value="codigo">Código</option>
                                        </select>
                                        <input type="text" v-model="buscarA" @keyup.enter="listarArticulo(buscarA,criterioA)" class="form-control" placeholder="Texto a buscar">
                                        <button type="submit" @click="listarArticulo(buscarA,criterioA)" class="btn btn-primary"><i class="fa fa-search"></i> Buscar</button>
                                    </div>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped table-sm">
                                    <thead>
                                        <tr>
                                            <th>Opciones</th>
                                            <th>Código</th>
                                            <th>Nombre</th>
                                            <th>Categoría</th>
                                            <th>Precio Venta</th>
                                            <th>Stock</th>
                                            <th>Estado</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="articulo in arrayArticulo" :key="articulo.id">
                                            <td>
                                                <button type="button" @click="agregarDetalleModal(articulo)" class="btn btn-success btn-sm">
                                                <i class="icon-check"></i>
                                                </button>
                                            </td>
                                            <td v-text="articulo.codigo"></td>
                                            <td v-text="articulo.nombre"></td>
                                            <td v-text="articulo.nombre_categoria"></td>
                                            <td v-text="articulo.precio_venta"></td>
                                            <td v-text="articulo.stock"></td>
                                            <td>
                                                <div v-if="articulo.condicion">
                                                    <span class="badge badge-success">Activo</span>
                                                </div>
                                                <div v-else>
                                                    <span class="badge badge-danger">Desactivado</span>
                                                </div>
                                                
                                            </td>
                                        </tr>                                
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" @click="cerrarModal()">Cerrar</button>
                            <button type="button" v-if="tipoAccion==1" class="btn btn-primary" @click="registrarPersona()">Guardar</button>
                            <button type="button" v-if="tipoAccion==2" class="btn btn-primary" @click="actualizarPersona()">Actualizar</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!--Fin del modal-->

            <!-- Modal busqueda tercero-->
                <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal2}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                    <div class="modal-dialog modal-primary modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title" v-text="tituloModal2"></h4>
                                <button type="button" class="close" @click="cerrarModalT()" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group row">
                                    <div style="max-width: 120px !important;" class="col-md-2   ">
                                        <label style='margin-top: 3px; '><b>Tercero</b></label>                                
                                    </div>
                                    <div class="col-md-3">
                                        <div class="input-group">
                                            <input type="text" class="form-control" name="cta_busq" v-model="terc_busq" @keyup="buscarTercero()">
                                        </div>
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped table-sm">
                                        
                                            <tr><th>Documento</th><th>Nombre</th><th style="    width: 35px;">-</th></tr>
                                        
                                            <tr v-for="tercero in arrayTerceros" :key="tercero.id">
                                                <td v-text="tercero.num_documento"></td>
                                                <td v-if="tercero.nombre && !tercero.nombre1">{{ tercero.nombre }}  </td>
                                                <td v-else>{{ tercero.nombre1 + ' ' + validarUnder(tercero.nombre2)+' '+tercero.apellido1+' '+validarUnder(tercero.apellido2) }} </td>
                                                <td>
                                                    <button type="button" style=" margin-right: -8px;" @click="cargarTercero(tercero)" class="btn btn-success btn-sm" title='Ver formato'>
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
            <!-- Fin Modal buscar proveedores -->
        </main>
</template>

<script>
    import vSelect from 'vue-select';
    export default {
        props : ['ruta'],
        data (){
            return {
                ingreso_id: 0,
                idproveedor:0,
                proveedor:'',
                nombre : '',
                tipo_comprobante : 'BOLETA',
                serie_comprobante : '',
                num_comprobante : '',
                impuesto: 0.18,
                total:0.0,
                totalImpuesto: 0.0,
                totalParcial: 0.0, 
                arrayIngreso : [],
                arrayProveedor: [],
                arrayDetalle : [],
                listado:1,
                modal : 0,
                tituloModal : '',
                tipoAccion : 0,
                tipoAccion2 : 0,
                tipoAccionModalTerceros : 0,
                errorIngreso : 0,
                errorMostrarMsjIngreso : [],
                pagination : {
                    'total' : 0,
                    'current_page' : 0,
                    'per_page' : 0,
                    'last_page' : 0,
                    'from' : 0,
                    'to' : 0,
                },
                offset : 3,
                criterio : 'num_comprobante',
                buscar : '',
                criterioA:'nombre',
                buscarA: '',
                arrayArticulo: [],
                idarticulo: 0,
                codigo: '',
                articulo: '',
                precio: 0,
                cantidad:0,

                // variables modal buscar tercero
                modal2 : '',
                tercero :'',
                id_tercero : '',
                tituloModal2 : '',
                buscar : '',   
                ctn_ban : 0,       
                tipo_cta : '',    
                cta_busq : '',  
                terc_busq : '',
                tipo_ingreso: '',
                arrayTerceros : [],

                cuenta_ini : '',
                id_cuenta_ini : '',
                cuenta_fin : '',
                id_cuenta_fin : '',

                // variables nuevas

                facturacion_id:0,
                num_factura:0,
                id_tercero_facturacion:0,
                tercero_facturacion:'',
                id_usuario:0,
                fec_edita:'',
                subtotal:0.0,
                valor_iva:0.0,
                total:0.0,
                abono:0.0,
                saldo:0.0,
                detalle:'',
                descuento:0.0,
                fec_registra:'',
                fec_envia:'',
                fec_anula:'',
                fecha : '',

                arrayFacturacion : [],

                iva:0,

                fechaActual: '',
                fechaHoraActual:'',

                estado: 0,
                cambiarEstado: 0,

                // Variables filtro
                numFacturaFiltro : '',
                estadoFiltro : '',
                idTerceroFiltro : '',
                terceroFiltro : '',
                desdeFiltro : '2019-01-01',
                hastaFiltro : '',
                ordenFiltro : '',
                idVendedorFiltro : '',
                vendedorFiltro : '',
                
            }
        },
        components: {
            vSelect
        },
        computed:{
            isActived: function(){
                return this.pagination.current_page;
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
            calcularSubtotal: function(){
                var resultado=0.0;
                for(var i=0;i<this.arrayDetalle.length;i++){
                    resultado=resultado+((this.arrayDetalle[i].precio*this.arrayDetalle[i].cantidad)-this.arrayDetalle[i].valor_descuento);
                }
                resultado = resultado-this.calcularTotalIva;
                return resultado;
            },
            calcularTotal: function(){
                var resultado=0.0;
                for(var i=0;i<this.arrayDetalle.length;i++){
                    resultado=resultado+((this.arrayDetalle[i].precio*this.arrayDetalle[i].cantidad)-this.arrayDetalle[i].valor_descuento)
                }
                return resultado;
            },
            calcularTotalIva: function(){
                var resultado=0.0;
                for(var i=0;i<this.arrayDetalle.length;i++){
                    resultado += this.arrayDetalle[i].valor_iva;
                }
                // resultado = this.total-resultado;
                resultado = Math.round(resultado);
                return resultado;
            },
            calcularSaldo: function(){
                var resultado=0.0;

                resultado=resultado+(this.calcularTotal-this.abono);
                
                return resultado;
            },
        },
        methods : {
            listarFacturacion (page,numFacturaFiltro,estadoFiltro,idTerceroFiltro,ordenFiltro,desdeFiltro,hastaFiltro,idVendedorFiltro){
                let me=this;

                var url= this.ruta +'/facturacion?page=' + page + '&numFacturaFiltro='+ numFacturaFiltro + '&estadoFiltro='+ estadoFiltro + '&idTerceroFiltro='+ idTerceroFiltro + '&ordenFiltro='+ ordenFiltro + '&desdeFiltro='+ desdeFiltro + '&hastaFiltro='+ hastaFiltro + '&idVendedorFiltro='+ idVendedorFiltro;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayFacturacion = respuesta.facturacion.data;
                    me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            listarDetalle(id_factura){
                let me=this;
                var url= this.ruta +'/detalle_facturacion/buscarDetalleFacturacion?id_factura=' + id_factura;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayDetalle = respuesta.detalles;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            selectProveedor(search,loading){
                let me=this;
                loading(true)

                var url= this.ruta +'/proveedor/selectProveedor?filtro='+search;
                axios.get(url).then(function (response) {
                    let respuesta = response.data;
                    q: search
                    me.arrayProveedor=respuesta.proveedores;
                    loading(false)
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            getDatosProveedor(val1){
                let me = this;
                me.loading = true;
                me.idproveedor = val1.id;
            },
            buscarArticulo(){
                let me=this;
                var url= this.ruta +'/articulo/buscarArticulo?filtro=' + me.codigo;

                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayArticulo = respuesta.articulos;

                    if (me.arrayArticulo.length>0){
                        me.articulo=me.arrayArticulo[0]['nombre'];
                        me.idarticulo=me.arrayArticulo[0]['id'];
                        me.cantidad=me.arrayArticulo[0]['stock'];
                        me.valorIvaDetalle=me.arrayArticulo[0]['iva'];
                    }
                    else{
                        me.articulo='No existe artículo';
                        me.idarticulo=0;
                        me.precio = 0;
                        me.cantidad = 0;
                    }
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            sugerirNumFactura(){
                let me=this;
                var url= this.ruta +'/facturacion/buscarNumFacturaSugerida';
                
                axios.get(url).then(function (response) {
                    var respuesta= response.data.facturacion;
                    
                    if(respuesta.length)
                    {
                        me.num_factura = parseInt(respuesta[0].num_factura)+1;
                    }
                    else
                    {
                        me.num_factura = 1;
                    }
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            cambiarEstadoFacturacion(id_factura, accion){
                let me=this;
                var cambiarEstado = '';

                switch(accion)
                {
                    case 'registrar':{
                        cambiarEstado = '2';
                        break;
                    };
                    case 'enviar':{
                        cambiarEstado = '3';
                        break;
                    };
                    case 'anular':{
                        cambiarEstado = '4';
                        break;
                    };
                }

                axios.put(this.ruta +'/facturacion/cambiarEstado',{
                    'estado': cambiarEstado,
                    'id': id_factura
                }).then(function (response) {
                    me.listarFacturacion(1,'','','','','','','');
                }).catch(function (error) {
                    console.log(error);
                });
            },
            cambiarPagina(page,buscar,criterio){
                let me = this;
                //Actualiza la página actual
                me.pagination.current_page = page;
                //Envia la petición para visualizar la data de esa página
                me.listarFacturacion(1,numFacturaFiltro,estadoFiltro,idTerceroFiltro,ordenFiltro,desdeFiltro,hastaFiltro,idVendedorFiltro);
            },
            encuentra(id){
                var sw=0;
                for(var i=0;i<this.arrayDetalle.length;i++){
                    if(this.arrayDetalle[i].idarticulo==id){
                        sw=true;
                    }
                }
                return sw;
            },
            eliminarDetalle(index){
                let me = this;
                me.arrayDetalle.splice(index, 1);
            },
            agregarDetalle(){
                let me=this;
                if(me.idarticulo==0 || me.cantidad==0 || me.precio==0){
                }
                else{
                    if(me.encuentra(me.idarticulo)){
                        swal({
                            type: 'error',
                            title: 'Error...',
                            text: 'Ese artículo ya se encuentra agregado!',
                            })
                    }
                    else{
                       me.arrayDetalle.push({
                            idarticulo: me.idarticulo,
                            articulo: me.articulo,
                            cantidad: me.cantidad,
                            descuento: me.descuento,
                            precio: me.precio,
                            iva: me.iva
                        });
                        me.codigo="";
                        me.idarticulo=0;
                        me.articulo="";
                        me.cantidad=0;
                        me.precio=0; 
                    }
                    
                }

                

            },
            agregarDetalleModal(data =[]){
                let me=this;
                
                if(me.encuentra(data['id'])){
                    swal({
                        type: 'error',
                        title: 'Error...',
                        text: 'Ese artículo ya se encuentra agregado!',
                        })
                }
                else{
                    me.arrayDetalle.push({
                        idarticulo: data['id'],
                        articulo: data['nombre'],
                        cantidad: 1,
                        valor_descuento: 0,
                        precio: data['precio_venta'],
                        iva: data['iva'],
                    }); 
                }
            },
            listarArticulo (buscar,criterio){
                let me=this;
                var url= this.ruta +'/articulo/listarArticulo?buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayArticulo = respuesta.articulos.data;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            registrarFacturacion(){
                // if (this.validarIngreso()){
                //     return;
                // }
                
                let me = this;
                
                for(var i=0; i<me.arrayDetalle.length; i++)
                {
                    me.descuento += parseFloat(me.arrayDetalle[i]['valor_descuento']);
                    me.iva += parseFloat(me.arrayDetalle[i]['valor_iva']);
                    me.subtotal += parseFloat(me.arrayDetalle[i]['valor_subtotal']);
                }
                me.total += parseFloat(me.subtotal)+parseFloat(me.iva);
                me.sugerirNumFactura();

                axios.post(this.ruta +'/facturacion/registrar',{
                    'num_factura': me.num_factura,
                    'id_tercero': me.id_tercero,
                    'fec_edita': null,
                    'usu_edita': null,
                    'subtotal': me.subtotal,
                    'valor_iva': me.iva,
                    'total': me.total,
                    'abono': me.abono,
                    'saldo': me.saldo,
                    'detalle': me.detalle,
                    'descuento': me.descuento,
                    'fec_registra': null,
                    'fec_envia': null,
                    'fec_anula': null,
                    'usu_registra': null,
                    'usu_envia': null,
                    'usu_anula': null,
                    'fecha': me.fecha,
                    'data': me.arrayDetalle
                }).then(function (response) {
                    me.listado=1;
                    me.arrayFacturacion=[];
                    me.listarFacturacion(1,'','','','','','','');
                    me.num_factura=0,
                    me.id_tercero=0,
                    me.tercero_facturacion='',
                    me.id_usuario=0,
                    me.fec_edita='',
                    me.subtotal=0.0,
                    me.valor_iva=0.0,
                    me.total=0.0,
                    me.abono=0.0,
                    me.saldo=0.0,
                    me.detalle='',
                    me.descuento=0.0,
                    me.fec_registra='',
                    me.fec_envia='',
                    me.fec_anula='',
                    me.fecha = '',
                    me.arrayDetalle=[];
                    me.arrayTerceros=[];
                }).catch(function (error) {
                    console.log(error);
                });
            },
            actualizarFacturacion(){
                // if (this.validarIngreso()){
                //     return;
                // }
                
                let me = this;
                me.subtotal = 0;
                me.iva = 0;
                me.descuento = 0;
                me.total = 0;
                for(var i=0; i<me.arrayDetalle.length; i++)
                {
                    me.descuento += parseFloat(me.arrayDetalle[i].valor_descuento);
                    me.iva += parseFloat(me.arrayDetalle[i].valor_iva);
                    me.subtotal += parseFloat(me.arrayDetalle[i].valor_subtotal);
                }
                
                me.total = parseFloat(me.subtotal)+parseFloat(me.iva);
                me.sugerirNumFactura();
                
                axios.put(this.ruta +'/facturacion/actualizar',{
                    'num_factura': me.num_factura,
                    'id_tercero': me.id_tercero,
                    'fec_edita': me.fechaHoraActual,
                    'subtotal': me.subtotal,
                    'valor_iva': me.iva,
                    'total': me.total,
                    'abono': me.abono,
                    'saldo': me.saldo,
                    'detalle': me.detalle,
                    'descuento': me.descuento,
                    'fec_registra': null,
                    'fec_envia': null,
                    'fec_anula': null,
                    'usu_registra': null,
                    'usu_envia': null,
                    'usu_anula': null,
                    'fecha': me.fecha,
                    'estado': me.estado,
                    'data': me.arrayDetalle,
                    'id' : me.facturacion_id
                }).then(function (response) {
                    me.ocultarDetalle();
                    me.listarFacturacion(1,'','','','','','','');
                }).catch(function (error) {
                    console.log(error);
                });
            },
            validarIngreso(){
                this.errorIngreso=0;
                this.errorMostrarMsjIngreso =[];

                if (this.idproveedor==0) this.errorMostrarMsjIngreso.push("Seleccione un Proveedor");
                if (this.tipo_comprobante==0) this.errorMostrarMsjIngreso.push("Seleccione el comprobante");
                if (!this.num_comprobante) this.errorMostrarMsjIngreso.push("Ingrese el número de comprobante");
                if (!this.impuesto) this.errorMostrarMsjIngreso.push("Ingrese el impuesto de compra");
                if (this.arrayDetalle.length<=0) this.errorMostrarMsjIngreso.push("Ingrese detalles");

                if (this.errorMostrarMsjIngreso.length) this.errorIngreso = 1;

                return this.errorIngreso;
            },
            mostrarDetalle(modelo, accion, data=[]){
                let me=this;
                me.listado=0;
                
                switch(modelo){
                    case 'facturacion':{
                        switch(accion){
                            case 'registrar':{
                                me.sugerirNumFactura();
                                me.tipoAccion2 = 1;
                                me.facturacion_id=0;
                                me.num_factura=0;
                                me.id_tercero=0;
                                me.tercero = '';
                                me.tercero_facturacion='';
                                me.fec_edita='';
                                me.subtotal=0.0;
                                me.valor_iva=0.0;
                                me.total=0.0;
                                me.abono=0.0;
                                me.saldo=0.0;
                                me.detalle='';
                                me.descuento=0.0;
                                me.fec_registra='';
                                me.fec_envia='';
                                me.fec_anula='';

                                me.arrayArticulo=[];
                                me.arrayDetalle=[];
                                me.arrayTerceros=[];
                                me.listarFacturacion(1,'','','','','','','');
                                break;
                            };
                            case 'actualizar':{
                                me.tipoAccion2 = 2;
                                me.facturacion_id=data['id'];
                                me.num_factura=data['num_factura'];
                                me.id_tercero=data['id_tercero'];
                                me.tercero_facturacion=data['nom_tercero'];
                                me.fec_edita=me.fechaHoraActual;
                                me.subtotal=data['subtotal'];
                                me.valor_iva=data['valor_iva'];
                                me.total=data['total'];
                                me.abono=data['abono'];
                                me.saldo=data['saldo'];
                                me.detalle=data['detalle'];
                                me.descuento=data['descuento'];
                                me.fec_registra=data['fec_registra'];
                                me.fec_envia=data['fec_envia'];
                                me.fec_anula=data['fec_anula'];
                                me.fecha =data['fecha'];
                                me.estado = data['estado'];
                                

                                me.arrayArticulo=[];
                                me.arrayTerceros=[];
                                me.arrayDetalle=[]
                                // me.listarFacturacion(1,'','','','','','','');
                                me.listarDetalle(data['id']);
                                break;
                            };
                        }
                    }
                }
            },
            ocultarDetalle(){
                this.listado=1;
                this.tipoAccion2=0;
                this.subtotal = 0;
                this.iva = 0;
            },
            verIngreso(id){
                let me=this;
                me.listado=2;
                
                //Obtener los datos del ingreso
                var arrayIngresoT=[];
                var url= this.ruta +'/ingreso/obtenerCabecera?id=' + id;
                
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    arrayIngresoT = respuesta.ingreso;

                    me.proveedor = arrayIngresoT[0]['nombre'];
                    me.tipo_comprobante=arrayIngresoT[0]['tipo_comprobante'];
                    me.serie_comprobante=arrayIngresoT[0]['serie_comprobante'];
                    me.num_comprobante=arrayIngresoT[0]['num_comprobante'];
                    me.impuesto=arrayIngresoT[0]['impuesto'];
                    me.total=arrayIngresoT[0]['total'];
                })
                .catch(function (error) {
                    console.log(error);
                });

                //Obtener los datos de los detalles 
                var urld= this.ruta +'/ingreso/obtenerDetalles?id=' + id;
                
                axios.get(urld).then(function (response) {
                    console.log(response);
                    var respuesta= response.data;
                    me.arrayDetalle = respuesta.detalles;
                })
                .catch(function (error) {
                    console.log(error);
                });               
            },
            cerrarModal(){
                this.modal=0;
                this.tituloModal='';
                this.buscar = '';
            }, 
            abrirModal(){               
                this.arrayArticulo=[];
                this.modal = 1;
                this.tituloModal = 'Seleccione uno o varios artículos';
            },
            desactivarIngreso(id){
               swal({
                title: 'Esta seguro de anular este ingreso?',
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

                    axios.put(this.ruta +'/ingreso/desactivar',{
                        'id': id
                    }).then(function (response) {
                        me.listarFacturacion(1,'','','','','','','');
                        swal(
                        'Anulado!',
                        'El ingreso ha sido anulado con éxito.',
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

            // funcion abrir modal proveedores
            abrirModalT(accion){               
                this.arrayTerceros=[];
                this.modal2 = 1;
                switch(accion){
                    case 'terceros':{
                        this.tituloModal2 = 'Seleccione un tercero';
                        this.tipoAccionModalTerceros = 1;
                        break;
                    }
                    case 'tercero_filtro':{
                        this.tituloModal2 = 'Seleccione un tercero para el filtro';
                        this.tipoAccionModalTerceros = 2;
                        break;
                    }
                    case 'vendedor_filtro':{
                        this.tituloModal2 = 'Seleccione un vendedor';
                        this.tipoAccionModalTerceros = 3;
                        break;
                    }
                }
            },
            cerrarModalT(){
                this.modal2=0;
                this.tituloModal2='';
                this.terc_busq = '';
            },
            cargarTercero(tercero){
                if(this.tipoAccionModalTerceros==1)
                {
                    this.tercero = tercero['num_documento'];
                    this.id_tercero = tercero['id'];
                }
                if(this.tipoAccionModalTerceros==2)
                {
                    this.terceroFiltro = tercero['num_documento'];
                    this.idTerceroFiltro = tercero['id'];
                }
                if(this.tipoAccionModalTerceros==3)
                {
                    this.vendedorFiltro = tercero['num_documento'];
                    this.idVendedorFiltro = tercero['id'];
                }

                this.cerrarModalT();
            },
            buscarTercero(){
                let me=this;
                var search = this.terc_busq;
                var url= this.ruta +'/cliente/selectCliente?filtro='+search;
                 axios.get(url).then(function (response) {
                    var respuesta = response.data;
                    me.arrayTerceros = respuesta.clientes;                    
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            validarUnder(valor)
            {
                if(valor == "undefined" || valor=="" || !valor)
                    return "";
                else
                    return valor;
            },
            quitar(opc){
                //alert(opc);
                if(opc==1){
                    this.id_cuenta_ini = '';
                    this.cuenta_ini = '';
                }
                if(opc==2){
                    this.id_cuenta_fin = '';
                    this.cuenta_fin = '';
                }
                if(opc==3){
                    this.id_tercero = '';
                    this.tercero = '';
                }
                if(opc==4){
                    this.idTerceroFiltro = '';
                    this.terceroFiltro = '';
                }
                if(opc==5){
                    this.idVendedorFiltro = '';
                    this.vendedorFiltro = '';
                }
            }
        },
        mounted() {
            let me= this;
            var d = new Date();
            
            
            var dd = d.getDate();
            var mm = d.getMonth()+1;
            var yyyy = d.getFullYear();
            var h = d.getHours();
            var min = d.getMinutes();
            var sec = d.getSeconds();
            
            if(dd<10){
                dd='0'+dd;
            } 
            if(mm<10){
                mm='0'+mm;
            } 
            d = yyyy+'-'+mm+'-'+dd;
            me.fechaActual = d;
            me.hastaFiltro = d;
            me.fecha = d;
            me.fechaHoraActual = d+' '+h+':'+min+':'+sec;

            me.listarFacturacion(1,me.numFacturaFiltro,me.estadoFiltro,me.idTerceroFiltro,me.ordenFiltro,me.desdeFiltro,me.hastaFiltro,me.idVendedorFiltro);
        }
    }
</script>
<style>    
    .modal-content{
        width: 100% !important;
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
    @media (min-width: 600px) {
        .btnagregar {
            margin-top: 2rem;
        }
    }

</style>
