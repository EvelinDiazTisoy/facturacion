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
                        <i class="fa fa-align-justify"></i> Facturación
                        <button type="button" @click="mostrarDetalle('facturacion','registrar')" class="btn btn-secondary">
                            <i class="icon-plus"></i>&nbsp;Nuevo
                        </button>
                    </div>
                    <template v-if="listado==1">
                        <div class="card-body">
                            <div class="form-group row">
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <select class="form-control col-md-3" v-model="criterio">
                                        <option value="nombre">Nombre</option>
                                        <option value="descripcion">Descripción</option>
                                        </select>
                                        <input type="text" v-model="buscar" @keyup.enter="listarFacturacion(1,buscar,criterio)" class="form-control" placeholder="Texto a buscar">
                                        <button type="submit" @click="listarFacturacion(1,buscar,criterio)" class="btn btn-primary"><i class="fa fa-search"></i> Buscar</button>
                                    </div>
                                </div>
                            </div>
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
                                        <th>Saldo</th>
                                        <th>Total</th>
                                        <th>Estado</th>
                                        <th>Opciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="facturacion in arrayFacturacion" :key="facturacion.id">
                                        <td v-text="facturacion.id"></td>
                                        <td v-text="facturacion.num_factura"></td>
                                        <td v-text="facturacion.id_tercero+' - '+facturacion.nom_tercero"></td>
                                        <td v-text="facturacion.fecha"></td>
                                        <td v-text="facturacion.subtotal" style="text-align: right"></td>
                                        <td v-text="facturacion.descuento" style="text-align: right"></td>
                                        <td v-text="facturacion.valor_iva" style="text-align: right"></td>
                                        <td v-text="facturacion.saldo" style="text-align: right"></td>
                                        <td v-text="facturacion.total" style="text-align: right"></td>
                                        <td>
                                            <div v-if="facturacion.estdo==0">
                                                <span class="badge badge-warning">Anulada</span>
                                            </div>
                                            <div v-else-if="facturacion.estado==1">
                                                <span class="badge badge-primary">Activa</span>
                                            </div>
                                            <div v-else-if="facturacion.estado==2">
                                                <span class="badge badge-success">Registrada</span>
                                            </div>
                                            <div v-else>
                                                <span class="badge badge-success">Enviada</span>
                                            </div>
                                            
                                        </td>
                                        <td>
                                            <button type="button" @click="mostrarDetalle('facturacion','actualizar',facturacion)" class="btn btn-warning btn-sm">
                                            <i class="icon-pencil"></i>
                                            </button> &nbsp;
                                            <template v-if="facturacion.condicion">
                                                <button type="button" class="btn btn-danger btn-sm" @click="desactivarCategoria(facturacion.id)">
                                                    <i class="icon-trash"></i>
                                                </button>
                                            </template>
                                            <template v-else>
                                                <button type="button" class="btn btn-info btn-sm" @click="activarCategoria(facturacion.id)">
                                                    <i class="icon-check"></i>
                                                </button>
                                            </template>
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
                    </template>
                    <template v-else-if="listado==0">
                        <div class="card-body">
                            <div class="form-group row border">
                                <div class="row col-md-12">
                                    <div class="form-group col-md-4">
                                        <label for="" class="col-md-5">Fecha(*)</label>
                                        <input type="date" class="form-control col-md-7" v-model="fecha">
                                        <!-- <div class="form-inline">
                                            <input type="text" readonly style="    max-width: 90px;" class="form-control" name="cuenta_fin" v-model="fecha">
                                            <button @click="abrirModalT()" style="    min-width: 30px;" class="btn btn-primary form-control">...</button>
                                            <button @click="quitar(3)" style="    min-width: 30px;" class="btn btn-danger form-control">
                                                <i class="icon-trash"></i>
                                            </button>
                                        </div> -->
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label class="col-md-5">Num factura(*)</label>
                                        <input type="number" class="form-control col-md-7" v-model="num_factura">
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label for="" class="col-md-5">Tercero(*)</label>
                                        <div class="form-inline">
                                            <input type="text" readonly style="    max-width: 90px;" class="form-control" name="cuenta_fin" v-model="tercero">
                                            <button @click="abrirModalT()" style="    min-width: 30px;" class="btn btn-primary form-control">...</button>
                                            <button @click="quitar(3)" style="    min-width: 30px;" class="btn btn-danger form-control">
                                                <i class="icon-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row border">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Artículo <span style="color:red;" v-show="idarticulo==0">(*Seleccione)</span></label>
                                        <div class="form-inline">
                                            <input type="text" class="form-control col-md-5" v-model="codigo" @keyup.enter="buscarArticulo()" placeholder="Ingrese artículo">
                                            <button @click="abrirModal()" class="btn btn-primary">...</button>
                                            <input type="text" readonly class="form-control col-md-4" v-model="articulo">
                                        </div>                                    
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label>Precio<!-- <span style="color:red;" v-show="precio==0">(*Ingrese)</span>--></label>
                                        <input type="number" value="0" step="any" disabled class="form-control" v-model="precio">
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label>Cantidad <span style="color:red;" v-show="cantidad==0">(*Ingrese)</span></label>
                                        <input type="number" value="0" class="form-control" v-model="cantidad">
                                        <label>Stock actual: <span v-text="stock"></span></label>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label>Descuento</label>
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
                                                <th>Cantidad</th>
                                                <th>Subtotal</th>
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
                                                <td>
                                                    <input v-model="detalle.valor_venta" type="number" value="3" class="form-control">
                                                </td>
                                                <td>
                                                    <input v-model="detalle.cantidad" type="number" value="2" class="form-control">
                                                </td>
                                                <td>
                                                    {{detalle.valor_venta*detalle.cantidad}}
                                                </td>
                                            </tr>
                                            <!--
                                            <tr style="background-color: #CEECF5;">
                                                <td colspan="4" align="right"><strong>Total Parcial:</strong></td>
                                                <td>$ {{totalParcial=(total-totalImpuesto).toFixed(2)}}</td>
                                            </tr>
                                            <tr style="background-color: #CEECF5;">
                                                <td colspan="4" align="right"><strong>Total Impuesto:</strong></td>
                                                <td>$ {{totalImpuesto=((total*impuesto)/(1+impuesto)).toFixed(2)}}</td>
                                            </tr>
                                            -->
                                            <tr style="background-color: #CEECF5;">
                                                <td colspan="4" align="right"><strong>Total Neto:</strong></td>
                                                <td>$ {{total=calcularTotal}}</td>
                                            </tr>
                                        </tbody>
                                        <tbody v-else>
                                            <tr>
                                                <td colspan="5">
                                                    NO hay artículos agregados
                                                </td>
                                            </tr>
                                        </tbody>                                    
                                    </table>
                                </div>
                            </div>
                            <div class="form-group row border">
                                <div class="row col-md-12">
                                    <div v-show="errorFacturacion" class="form-group row div-error">
                                        <div class="text-center text-error">
                                            <div v-for="error in errorMostrarMsjFacturacion" :key="error" v-text="error">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-12">
                                    <button type="button" @click="ocultarDetalle()" class="btn btn-secondary">Cerrar</button>
                                    <button type="button" class="btn btn-primary" v-if="tipoAccion==1" @click="registrarFacturacion()">Registrar Factura</button>
                                    <button type="button" class="btn btn-primary" v-else-if="tipoAccion==2" @click="actualizarFacturacion()">Actualizar Factura</button>
                                </div>
                            </div>
                        </div>
                    </template>
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
    export default {
        props : ['ruta'],
        data (){
            return {
                facturacion_id: 0,
                nombre : '',
                descripcion : '',
                arrayFacturacion : [],
                arrayFactura : [],
                modal : 0,
                tituloModal : '',
                tipoAccion : 0,
                errorFacturacion : 0,
                errorMostrarMsjFacturacion : [],
                pagination : {
                    'total' : 0,
                    'current_page' : 0,
                    'per_page' : 0,
                    'last_page' : 0,
                    'from' : 0,
                    'to' : 0,
                },
                offset : 10,
                criterio : 'nombre',
                buscar : '',

                listado:1,
                modal2 : '',
                num_factura:0,
                tercero :'',
                id_tercero : '',
                fec_edita:'',
                subtotal:0,
                valor_iva:0,
                total:0,
                abono:0,
                saldo:0,
                detalle:'',
                descuento:0,
                fec_registra:'',
                fec_envia:'',
                fec_anula:'',
                fecha:'',

                tituloModal2 : '',
                buscar : '',   
                ctn_ban : 0,       
                tipo_cta : '',    
                cta_busq : '',  
                terc_busq : '',
                arrayTerceros : [],
                arrayDetalle : [],

                criterioA:'nombre',
                buscarA: '',
                arrayArticulo: [],
                idarticulo: 0,
                codigo: '',
                articulo: '',
                precio: 0,
                cantidad:0,
                stock:0,

                fechaActual : '',
                factura_id : '',
                id_usu : ''
            }
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
            calcularTotal: function(){
                let me=this;
                var resultado=0.0;
                for(var i=0;i<this.arrayDetalle.length;i++){
                    resultado=resultado+(this.arrayDetalle[i].valor_venta*this.arrayDetalle[i].cantidad)
                }
                return resultado;
            }
        },
        methods : {
            mostrarDetalle(modelo, accion, data = []){
                let me=this;
                
                switch(modelo){
                    case "facturacion":
                    {
                        switch(accion){
                            case 'registrar':
                            {
                                me.listado=0;
                                me.tituloModal='Registrar Factura';
                                me.tipoAccion=1;
                                break;
                            }
                            case 'actualizar':
                            {
                                me.listado=0;
                                me.tituloModal='Actualizar Factura';
                                me.tipoAccion=2;
                                me.facturacion_id= data['id'];
                                me.buscarFacturacion();
                                break;
                            }
                        }
                    }
                }
            },
            ocultarDetalle(){
                this.listado=1;
            },
            listarFacturacion(page,buscar,criterio){
                let me=this;
                var url= this.ruta +'/facturacion?page=' + page + '&buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayFacturacion= respuesta.facturacion.data;
                    me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            buscarFacturacion(){
                let me=this;
                var url= this.ruta +'/facturacion/buscarFacturacion?filtro=' + me.facturacion_id;

                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayFactura = respuesta.facturacion;
                    me.num_factura=me.arrayFactura[0]['num_factura'];
                    me.tercero=me.arrayFactura[0]['nom_tercero'];
                    me.factura_id=me.arrayFactura[0]['id'];
                    me.id_usu = me.arrayFactura[0]['id_usuario']
                    me.listarArticulos();
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            listarArticulos(){
                let me=this;
                var url= this.ruta +'/detalle_facturacion/buscarDetalleFacturacion?id_factura=' + me.factura_id;

                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayDetalle = respuesta.detalle_facturacion;
                    
                    if (me.arrayArticulo.length>0){
                        me.articulo=me.arrayArticulo[0]['nombre'];
                        me.idarticulo=me.arrayArticulo[0]['id'];
                        me.precio=me.arrayArticulo[0]['precio_venta'];
                        me.stock=me.arrayArticulo[0]['stock'];
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
            buscarArticulo(){
                let me=this;
                var url= this.ruta +'/articulo/buscarArticulo?filtro=' + me.codigo;

                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayArticulo = respuesta.articulos;

                    if (me.arrayArticulo.length>0){
                        me.articulo=me.arrayArticulo[0]['nombre'];
                        me.idarticulo=me.arrayArticulo[0]['id'];
                        me.precio=me.arrayArticulo[0]['precio_venta'];
                        me.stock=me.arrayArticulo[0]['stock'];
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
            cambiarPagina(page,buscar,criterio){
                let me = this;
                //Actualiza la página actual
                me.pagination.current_page = page;
                //Envia la petición para visualizar la data de esa página
                me.listarFacturacion(page,buscar,criterio);
            },
            registrarFacturacion(){
                // if (this.validarIngreso()){
                //     return;
                // }
                
                let me = this;

                axios.post(this.ruta +'/facturacion/registrar',{
                    'num_factura': this.num_factura,
                    'id_tercero': this.id_tercero,
                    'subtotal': this.subtotal,
                    'valor_iva': this.valor_iva,
                    'total': this.total,
                    'abono': this.abono,
                    'saldo': this.saldo,
                    'detalle': this.detalle,
                    'descuento': this.descuento,
                    'fecha' : this.fecha,
                    'data': this.arrayDetalle
                }).then(function (response) {
                    me.listado=1;
                    me.listarFacturacion(1,'nombre','');
                    me.num_factura=0;
                    me.tercero ='';
                    me.id_tercero = '';
                    me.fec_edita='';
                    me.subtotal=0;
                    me.valor_iva=0;
                    me.total=0;
                    me.abono=0;
                    me.saldo=0;
                    me.detalle='';
                    me.descuento=0;
                    me.fec_registra='';
                    me.fec_envia='';
                    me.fec_anula='';
                    me.fecha='';
                    me.arrayTerceros=[];
                    me.arrayDetalle=[];
                }).catch(function (error) {
                    console.log(error);
                });
            },
            actualizarFacturacion(){
                // if (this.validarIngreso()){
                //     return;
                // }
                
                let me = this;

                axios.put(this.ruta +'/facturacion/actualizar',{
                    'num_factura': this.num_factura,
                    'id_tercero': this.id_tercero,
                    'fec_edita' : this.fechaActual,
                    'subtotal': this.subtotal,
                    'valor_iva': this.valor_iva,
                    'total': this.total,
                    'abono': this.abono,
                    'saldo': this.saldo,
                    'detalle': this.detalle,
                    'descuento': this.descuento,
                    'fecha' : this.fecha,
                    'id_usu' : this.id_usu,
                    'data': this.arrayDetalle
                }).then(function (response) {
                    me.listado=1;
                    me.listarFacturacion(1,'nombre','');
                    me.num_factura=0;
                    me.tercero ='';
                    me.id_tercero = '';
                    me.fec_edita='';
                    me.subtotal=0;
                    me.valor_iva=0;
                    me.total=0;
                    me.abono=0;
                    me.saldo=0;
                    me.detalle='';
                    me.descuento=0;
                    me.fec_registra='';
                    me.fec_envia='';
                    me.fec_anula='';
                    me.fecha='';
                    me.arrayTerceros=[];
                    me.arrayDetalle=[];
                }).catch(function (error) {
                    console.log(error);
                });
            },
            desactivarFacturacion(id){
               swal({
                title: 'Esta seguro de desactivar esta factura?',
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

                    axios.put(this.ruta +'/facturacion/desactivar',{
                        'id': id
                    }).then(function (response) {
                        me.listarFacturacion(1,'','nombre');
                        swal(
                        'Desactivado!',
                        'El registro ha sido desactivado con éxito.',
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
            activarFacturacion(id){
               swal({
                title: 'Esta seguro de activar esta factura?',
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

                    axios.put(this.ruta +'/facturacion/activar',{
                        'id': id
                    }).then(function (response) {
                        me.listarFacturacion(1,'','nombre');
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
            validarFacturacion(){
                this.errorFacturacion=0;
                this.errorMostrarMsjFacturacion =[];

                if (!this.nombre) this.errorMostrarMsjFacturacion.push("El nombre de la categoría no puede estar vacío.");

                if (this.errorMostrarMsjFacturacion.length) this.errorFacturacion = 1;

                return this.errorFacturacion;
            },
            cerrarModal(){
                this.modal=0;
                this.tituloModal='';
            },
            /*abrirModal(modelo, accion, data = []){
                switch(modelo){
                    case "facturacion":
                    {
                        switch(accion){
                            case 'registrar':
                            {
                                // this.modal = 1;
                                // this.tituloModal = 'Registrar Factura';
                                // this.nombre= '';
                                // this.descripcion = '';
                                // this.tipoAccion = 1;
                                this.listado=0;
                                break;
                            }
                            case 'actualizar':
                            {
                                //console.log(data);
                                this.modal=1;
                                this.tituloModal='Actualizar Factura';
                                this.tipoAccion=2;
                                this.categoria_id=data['id'];
                                this.nombre = data['nombre'];
                                this.descripcion= data['descripcion'];
                                break;
                            }
                        }
                    }
                }
            },*/
            abrirModal(){               
                this.arrayArticulo=[];
                this.modal = 1;
                this.tituloModal = 'Seleccione uno o varios artículos';
            },

            // funciones modal terceros
            abrirModalT(tipo_cta){               
                this.arrayTerceros=[];
                this.modal2 = 1;
                this.tipo_cta = tipo_cta;
                this.tituloModal = 'Seleccione un tercero';
            },
            cerrarModalT(){
                this.modal2=0;
                this.tituloModal2='';
                this.terc_busq = '';
            },
            cargarTercero(tercero){
                
                this.tercero = tercero['num_documento'];
                this.id_tercero = tercero['id'];                
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
            },

            // funciones de detalles articulos
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
                            precio: me.precio
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
                            precio: 1
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
            }
        },
        mounted() {
            var d = new Date();
            var h = '';
            
            
            var dd = d.getDate();
            var mm = d.getMonth()+1;
            var yyyy = d.getFullYear();
            var hh = d.getHours();
            var ms = d.getMinutes();
            var ss = d.getSeconds();

            if(dd<10){
                dd='0'+dd;
            } 
            if(mm<10){
                mm='0'+mm;
            } 
            if(hh<10){
                hh='0'+hh;
            }
            if(ms<10){
                ms='0'+ms;
            }
            if(ss<10){
                ss='0'+ss;
            }
            d = yyyy+'-'+mm+'-'+dd;
            h = hh+':'+ms+':'+ss;
            this.fechaActual = d+' '+h;
            this.fecha = d;

            this.listarFacturacion(1,this.buscar,this.criterio);
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
</style>
