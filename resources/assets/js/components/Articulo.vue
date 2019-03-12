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
                        <button type="button" @click="abrirModal('articulo','registrar')" class="btn btn-secondary">
                            <i class="icon-plus"></i>&nbsp;Nuevo
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="form-group row">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <select class="form-control col-md-3" v-model="criterio">
                                      <option value="nombre">Nombre</option>
                                      <option value="descripcion">Descripción</option>
                                    </select>
                                    <input type="text" v-model="buscar" @keyup.enter="listarArticulo(1,buscar,criterio)" class="form-control" placeholder="Texto a buscar">
                                    <button type="submit" @click="listarArticulo(1,buscar,criterio)" class="btn btn-primary"><i class="fa fa-search"></i> Buscar</button>
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-striped table-sm">
                            <thead>
                                <tr>
                                    <th>Opciones</th>
                                    <th>Código</th>
                                    <th>Nombre</th>
                                    <th>Categoría</th>
                                    <th>Precio Venta</th>
                                    <th>Stock</th>
                                    <th>Descripción</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="articulo in arrayArticulo" :key="articulo.id">
                                    <td>
                                        <button type="button" @click="abrirModal('articulo','actualizar',articulo)" class="btn btn-warning btn-sm">
                                          <i class="icon-pencil"></i>
                                        </button> &nbsp;
                                        <template v-if="articulo.condicion">
                                            <button type="button" class="btn btn-danger btn-sm" @click="desactivarArticulo(articulo.id)">
                                                <i class="icon-trash"></i>
                                            </button>
                                        </template>
                                        <template v-else>
                                            <button type="button" class="btn btn-info btn-sm" @click="activarArticulo(articulo.id)">
                                                <i class="icon-check"></i>
                                            </button>
                                        </template>
                                    </td>
                                    <td v-text="articulo.codigo"></td>
                                    <td v-text="articulo.nombre"></td>
                                    <td v-text="articulo.nombre_categoria"></td>
                                    <td v-text="articulo.precio_venta"></td>
                                    <td v-text="articulo.stock"></td>
                                    <td v-text="articulo.descripcion"></td>
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
                            <form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="form-control-label col-md-3 float-left" for="text-input">Categoría</label>
                                    <div class="col-md-9 float-right">
                                        <select class="form-control col-md-10 float-left" v-model="idcategoria">
                                            <option value="0" disabled>Seleccione</option>
                                            <option v-for="categoria in arrayCategoria" :key="categoria.id" :value="categoria.id" v-text="categoria.nombre"></option>
                                        </select>
                                        <span class="btn btn-primary form-control col-md-2 float-right" @click="abrirModalCrear('categoria')"><i class="fa fa-plus-circle"></i></span>
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Nombre</label>
                                    <div class="col-md-9 float-right">
                                        <input type="text" v-model="nombre" class="form-control" placeholder="Nombre de artículo">
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
                                        <input type="number" v-model="precio_venta" class="form-control" placeholder="">                                        
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Stock</label>
                                    <div class="col-md-9 float-right">
                                        <input type="number" v-model="stock" class="form-control" placeholder="">
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
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Lote</label>
                                    <div class="col-md-9 float-right">
                                        <input type="text" v-model="lote" class="form-control" placeholder="">                                        
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Fec. vence</label>
                                    <div class="col-md-9 float-right">
                                        <input type="date" v-model="fec_vence" class="form-control" placeholder="">                                        
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Cant. minima</label>
                                    <div class="col-md-9 float-right">
                                        <input type="text" v-model="minimo" class="form-control" placeholder="">                                        
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="form-control-label col-md-3 float-left" for="text-input">Tipo artículo</label>
                                    <div class="col-md-9 float-right">
                                        <select class="form-control" v-model="tipo_articulo">
                                            <option value="0" disabled>Seleccione</option>
                                            <option value="1">Fisico</option>
                                            <option value="2">Virtual</option>
                                            <option value="3">Servicio</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Iva</label>
                                    <div class="col-md-9 float-right">
                                        <input type="number" min="0" max="100" v-model="iva" class="form-control" placeholder="">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Und. medida</label>
                                    <div class="col-md-9 float-right">
                                        <select class="form-control col-md-10 float-left" v-model="id_und_medida">
                                            <option value="0" disabled>Seleccione</option>
                                            <option v-for="id_und_medida in arrayUndMedida" :key="id_und_medida.id" :value="id_und_medida.id" v-text="id_und_medida.nombre"></option>
                                        </select> 
                                        <span class="btn btn-primary col-md-2 float-right" @click="abrirModalCrear('und_medida')"><i class="fa fa-plus-circle"></i></span>
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Concentración</label>
                                    <div class="col-md-9 float-right">
                                        <select class="form-control col-md-10 float-left" v-model="id_concentracion">
                                            <option value="0" disabled>Seleccione</option>
                                            <option v-for="id_concentracion in arrayConcentracion" :key="id_concentracion.id" :value="id_concentracion.id" v-text="id_concentracion.nombre"></option>
                                        </select> 
                                        <span class="btn btn-primary col-md-2 float-right" @click="abrirModalCrear('concentracion')"><i class="fa fa-plus-circle"></i></span>
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
                                    <div class="col-md-9 float-right">
                                        <select class="form-control col-md-10 float-left" v-model="id_presentacion">
                                            <option value="0" disabled>Seleccione</option>
                                            <option v-for="id_presentacion in arrayPresentacion" :key="id_presentacion.id" :value="id_presentacion.id" v-text="id_presentacion.nombre"></option>
                                        </select> 
                                        <span class="btn btn-primary col-md-2 float-right" @click="abrirModalCrear('presentacion')"><i class="fa fa-plus-circle"></i></span>
                                    </div>                   
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="email-input">Descripción</label>
                                    <div class="col-md-9 float-right">
                                        <input type="text" v-model="descripcion" class="form-control" placeholder="Ingrese descripción">
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
                            </div>        
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="col-md-3 form-control-label float-left" for="text-input">Código</label>
                                    <div class="col-md-9 float-right">
                                        <input type="text" v-model="codigo" class="form-control" placeholder="Código de barras"> 
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <!-- <barcode :value="codigo" :options="{ format: 'EAN-13' }" >Generando código de barras...</barcode> -->
                                </div>
                            </div>
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
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!--Fin del modal-->
        </main>
</template>

<script>
    import VueBarcode from 'vue-barcode';
    export default {
        props : ['ruta'],
        data (){
            return {
                articulo_id: 0,
                idcategoria : 0,
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
                tipo_movimiento : 1,


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
                offset : 3,
                criterio : 'nombre',
                buscar : '',
                arrayCategoria :[],
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
            }
        },
        components: {
        'barcode': VueBarcode
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

            }
        },
        methods : {
            listarArticulo (page,buscar,criterio){
                let me=this;
                var url= this.ruta + '/articulo?page=' + page + '&buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayArticulo = respuesta.articulos.data;
                    me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            selectCategoria(){
                let me=this;
                var url= this.ruta + '/categoria/selectCategoria';
                axios.get(url).then(function (response) {
                    //console.log(response);
                    var respuesta= response.data;
                    me.arrayCategoria = respuesta.categorias;
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
                    me.selectCategoria();
                    me.selectUndMedida();
                    me.selectConcentracion();
                    me.selectPresentacion();
                }).catch(function (error) {
                    console.log(error);
                });
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
            registrarArticulo(){
                if (this.validarArticulo()){
                    return;
                }
                
                let me = this;

                axios.post(this.ruta + '/articulo/registrar',{
                    'idcategoria': this.idcategoria,
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
                    'tipo_movimiento' : 1,
                }).then(function (response) {
                    me.idArticuloStock = $respone['id'];
                    me.cantidadStock = $response['stock'];
                    me.tipoMovimientoStock = 1;
                    me.sumatoria = $response['stock'];
                    me.registrarStock();
                    me.cerrarModal();
                    me.listarArticulo(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                });
            },
            registrarStock(){
                if (this.validarArticulo()){
                    return;
                }
                
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
            actualizarArticulo(){
               if (this.validarArticulo()){
                    return;
                }
                
                let me = this;

                axios.put( this.ruta + '/articulo/actualizar',{
                    'idcategoria': this.idcategoria,
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
                    'id': this.articulo_id
                }).then(function (response) {
                    me.cerrarModal();
                    me.listarArticulo(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                }); 
            },
            desactivarArticulo(id){
                swal({
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
               swal({
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

                if (this.idcategoria==0) this.errorMostrarMsjArticulo.push("Seleccione una categoría.");
                if (!this.nombre) this.errorMostrarMsjArticulo.push("El nombre del artículo no puede estar vacío.");
                if (!this.stock) this.errorMostrarMsjArticulo.push("El stock del artículo debe ser un número y no puede estar vacío.");
                if (!this.precio_venta) this.errorMostrarMsjArticulo.push("El precio venta del artículo debe ser un número y no puede estar vacío.");

                if (this.errorMostrarMsjArticulo.length) this.errorArticulo = 1;

                return this.errorArticulo;
            },
            cerrarModal(){
                this.modal=0;
                this.tituloModal='';
                this.idcategoria= 0;
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
                this.minimo = '';
                this.tipo_articulo = '',
                this.iva = 0;
                this.errorArticulo=0;
                
                this.idArticuloStock = 0;
                this.cantidadStock = 0;
                this.sumatoria = 0;
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
                                this.iva=0;
                                this.descripcion = '';
                                this.tipoAccion = 1;
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
                                this.iva=data['iva'];
                                this.descripcion= data['descripcion'];
                                break;
                            }
                        }
                        this.selectCategoria();
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
                    case "categoria":
                    {   this.modalCrear = 1;
                        this.tituloModalCrear = 'Categoria';
                        this.nombre_crear= '';
                        this.descripcion_crear = '';
                        this.tipoAccionCrear = 1;
                        break;
                    }
                    case "und_medida":
                    {   this.modalCrear = 2;
                        this.tituloModalCrear = 'Und. medida';
                        this.nombre_crear= '';
                        this.descripcion_crear = '';
                        this.tipoAccionCrear = 1;
                        break;
                    }
                    case "concentracion":
                    {   this.modalCrear = 3;
                        this.tituloModalCrear = 'Concentración';
                        this.nombre_crear= '';
                        this.descripcion_crear = '';
                        this.tipoAccionCrear = 1;
                        break;
                    }
                    case "presentacion":
                    {   this.modalCrear = 4;
                        this.tituloModalCrear = 'Presentación';
                        this.nombre_crear= '';
                        this.descripcion_crear = '';
                        this.tipoAccionCrear = 1;
                        break;
                    }
                }
            }
        },
        mounted() {
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
</style>
