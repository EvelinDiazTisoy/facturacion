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
                        <i class="fa fa-align-justify"></i> Retenciones
                        <button v-if="permisosUser.crear" type="button" @click="abrirModal('retenciones','registrar')" class="btn btn-primary" title="Nuevo">
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
                                    <select v-if="permisosUser.leer" class="form-control col-md-3" v-model="criterio">
                                      <option value="retencion">Nombre</option>
                                    </select>
                                    <select v-else disabled class="form-control col-md-3" v-model="criterio">
                                    </select>

                                    <input v-if="permisosUser.leer" type="text" v-model="buscar" @keyup.enter="listarRetenciones(1,buscar,criterio)" class="form-control" placeholder="Texto a buscar">
                                    <input v-else disabled type="text" v-model="buscar" class="form-control" placeholder="Texto a buscar">

                                    <button v-if="permisosUser.leer" type="submit" @click="listarRetenciones(1,buscar,criterio)" class="btn btn-primary" title="Buscar"><i class="fa fa-search"></i> Buscar</button>
                                    <button v-else type="submit" class="btn btn-secondary"><i class="fa fa-search"></i> Buscar</button>
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-striped table-sm">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Cuenta</th>
                                    <th>Autoretenedor</th>
                                    <th>Declarante</th>
                                    <th>Monto base</th>
                                    <th>Tipo movimiento</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody v-if="permisosUser.leer">
                                <tr v-for="retencion in arrayRetenciones" :key="retencion.id">
                                    <td v-text="retencion.retencion"></td>
                                    <td v-text="retencion.cuenta"></td>

                                    <td v-if="retencion.autoretenedor==1">Autoretenedor</td>
                                    <td v-else-if="retencion.autoretenedor==2">No autoretenedor</td>
                                    <td v-else-if="retencion.autoretenedor==0">Ambos</td>

                                    <td v-if="retencion.declarante==1">Declarante</td>
                                    <td v-else-if="retencion.declarante==2">No declarante</td>
                                    <td v-else-if="retencion.declarante==0">Ambos</td>

                                    <td v-text="retencion.monto_base"></td>

                                    <td v-if="retencion.tipo_mov==1">Gasto</td>
                                    <td v-else-if="retencion.tipo_mov==2">Ingreso</td>
                                    <td v-else-if="retencion.tipo_mov==0">Ambos</td>
                                    <td>
                                        <template>
                                            <button v-if="permisosUser.actualizar && retencion.estado==1" type="button" @click="abrirModal('retenciones','actualizar',retencion)" class="btn btn-warning btn-sm" title="Buscar">
                                            <i class="icon-pencil"></i>
                                            </button>
                                            <button v-else type="button" class="btn btn-secondary btn-sm">
                                            <i class="icon-pencil"></i>
                                            </button>
                                        </template>

                                        <template v-if="retencion.estado">
                                            <button v-if="permisosUser.anular" type="button" class="btn btn-danger btn-sm" @click="desactivarRetencion(retencion.id)" title="Desactivar">
                                                <i class="icon-trash"></i>
                                            </button>
                                            <button v-else type="button" class="btn btn-secondary btn-sm">
                                                <i class="icon-trash"></i>
                                            </button>
                                        </template>
                                        <template v-else>
                                            <button v-if="permisosUser.anular" type="button" class="btn btn-info btn-sm" @click="activarRetencion(retencion.id)" title="Activar">
                                                <i class="icon-check"></i>
                                            </button>
                                            <button v-else type="button" class="btn btn-secondary btn-sm">
                                                <i class="icon-check"></i>
                                            </button>
                                        </template>
                                    </td>
                                </tr>                                
                            </tbody>
                            <tbody v-else>
                                <tr colspan="7">Nada para mostrar</tr>
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
                            <button type="button" class="close" @click="cerrarModal('retenciones')" aria-label="Close">
                              <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
                                <div class="row">
                                    <div class="form-group col-md-12">
                                        <label class="col-md-1 form-control-label float-left" for="text-input">Nombre</label>
                                        <div class="col-md-11 float-right">
                                            <input type="text" v-model="retencion" style="width: 96%;" class="form-control float-right" placeholder="Nombre de la empresa">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label class="col-md-3 form-control-label float-left">Cuenta <span style="color:red;" v-show="cuenta==''">(*Seleccione)</span></label>
                                        <div class="form-inline col-md-9 float-right">
                                            <input type="text" readonly class="form-control" style="width: 85%;" v-model="cuenta">
                                            <button type="button" @click="abrirModal('retenciones','buscar')" class="btn btn-primary">...</button>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label class="col-md-3 form-control-label float-left">Autoretenedor</label>
                                        <div class="col-md-9 float-right">
                                            <select v-model="autoretenedor" class="form-control">
                                                <option value="">Seleccione</option>
                                                <option value="1">Autoretenedor</option>
                                                <option value="2">No autoretenedor</option>
                                                <option value="0">Ambos</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label class="col-md-3 form-control-label float-left">Declarante</label>
                                        <div class="col-md-9 float-right">
                                            <select v-model="declarante" class="form-control">
                                                <option value="">Seleccione</option>
                                                <option value="1">Declarante</option>
                                                <option value="2">No declarante</option>
                                                <option value="0">Ambos</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label class="col-md-3 form-control-label float-left">Monto base</label>
                                        <div class="col-md-9 float-right">
                                            <input type="number" v-model.boolean="monto_base" step="0.00" :min="0.00" @blur="function(){if(monto_base<0) monto_base=0;}" class="form-control">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label class="col-md-3 form-control-label float-left">Tipo movimiento</label>
                                        <div class="col-md-9 float-right">
                                            <select v-model="tipo_mov" class="form-control">
                                                <option value="">Seleccione</option>
                                                <option value="1">Gasto</option>
                                                <option value="2">Ingreso</option>
                                                <option value="0">Ambos</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                    </div>
                                </div>




                                <div v-show="errorRetencion" class="form-group row div-error">
                                    <div class="text-center text-error">
                                        <div v-for="error in errorMostrarMsjRetencion" :key="error" v-text="error">

                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" @click="cerrarModal('retenciones')">Cerrar</button>
                            <button type="button" v-if="tipoAccion==1" class="btn btn-primary" @click="registrarRetencion()">Guardar</button>
                            <button type="button" v-if="tipoAccion==2" class="btn btn-primary" @click="actualizarConcentracion()">Actualizar</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!--Fin del modal-->

            <!-- Modal busqueda cuentas-->
            <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal2}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" v-text="tituloModal2"></h4>
                            <button type="button" class="close" @click="cerrarModal('cuentas')" aria-label="Close">
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
                                                <button type="button" style=" margin-right: -8px;" @click="cargarCuentaB(cuentas)" class="btn btn-success btn-sm" title='Ver formato'>
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
        </main>
</template>

<script>
    export default {
        props : ['ruta', 'permisosUser'],
        data (){
            return {
                concentracion_id: 0,
                nombre : '',
                arrayConcentracion : [],

                retencion_id: 0,
                retencion: '',
                id_cuenta : '',
                codigo_cuenta : '',
                cuenta: '',
                autoretenedor: '',
                declarante: '',
                monto_base: '0,00',
                tipo_mov: '',
                arrayRetenciones: [],

                modal : 0,
                tituloModal : '',

                modal2 : 0,
                tituloModal2 : '',
                cta_busq : '',
                arrayCuentasBusq : [],

                tipoAccion : 0,
                errorRetencion : 0,
                errorMostrarMsjRetencion : [],
                pagination : {
                    'total' : 0,
                    'current_page' : 0,
                    'per_page' : 0,
                    'last_page' : 0,
                    'from' : 0,
                    'to' : 0,
                },
                offset : 10,
                criterio : 'retencion',
                buscar : ''
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

            }
        },
        methods : {
            listarRetenciones (page,buscar,criterio){
                let me=this;
                var url= this.ruta +'/retenciones?page=' + page + '&buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayRetenciones = respuesta.retenciones.data;
                    me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
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
            cargarCuentaB(cuenta){
                let me=this;
                me.codigo_cuenta= cuenta['codigo'];
                me.id_cuenta= cuenta['id'];
                me.cuenta= cuenta['nombre'];
                this.cerrarModal('cuentas');
            },
            cambiarPagina(page,buscar,criterio){
                let me = this;
                //Actualiza la página actual
                me.pagination.current_page = page;
                //Envia la petición para visualizar la data de esa página
                me.listarRetenciones(page,buscar,criterio);
            },
            registrarRetencion(){
                // if (this.validarConcentracion()){
                //     return;
                // }
                
                let me = this;

                axios.post(this.ruta +'/retenciones/registrar',{
                    'retencion': this.retencion,
                    'cuenta': this.id_cuenta,
                    'autoretenedor': this.autoretenedor,
                    'declarante': this.declarante,
                    'monto_base': this.monto_base,
                    'tipo_mov': this.tipo_mov,
                }).then(function (response) {
                    me.cerrarModal('retenciones');
                    me.listarRetenciones(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                });
            },
            actualizarConcentracion(){
                // if (this.validarConcentracion()){
                //     return;
                // }
                
                let me = this;

                axios.put(this.ruta +'/retenciones/actualizar',{
                    'retencion': this.retencion,
                    'cuenta': this.id_cuenta,
                    'autoretenedor': this.autoretenedor,
                    'declarante': this.declarante,
                    'monto_base': this.monto_base,
                    'tipo_mov': this.tipo_mov,
                    'id': this.retencion_id
                }).then(function (response) {
                    me.cerrarModal('retenciones');
                    me.listarRetenciones(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                }); 
            },
            validarConcentracion(){
                this.errorConcentracion=0;
                this.errorMostrarMsjConcentracion =[];

                if (!this.nombre) this.errorMostrarMsjConcentracion.push("El nombre de la presentación no puede estar vacío.");

                if (this.errorMostrarMsjConcentracion.length) this.errorConcentracion = 1;

                return this.errorConcentracion;
            },
            desactivarRetencion(id){
               swal({
                title: 'Esta seguro de desactivar esta retención?',
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

                    axios.put(this.ruta +'/retenciones/desactivar',{
                        'id': id
                    }).then(function (response) {
                        me.listarRetenciones(1,'','nombre');
                        swal(
                        'Desactivado!',
                        'La retención ha sido desactivada con éxito.',
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
            activarRetencion(id){
               swal({
                title: 'Esta seguro de activar esta retención?',
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

                    axios.put(this.ruta +'/retenciones/activar',{
                        'id': id
                    }).then(function (response) {
                        me.listarRetenciones(1,'','nombre');
                        swal(
                        'Activado!',
                        'La retención ha sido activada con éxito.',
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
            cerrarModal(modelo){
                switch(modelo)
                {
                    case 'retenciones':{
                        this.modal=0;
                        this.tituloModal='';
                        this.retencion='';
                        this.autoretenedor='';
                        this.declarante='';
                        this.monto_base='';
                        this.tipo_mov='';
                        break;
                    }
                    case 'cuentas':{
                        this.modal2=0;
                        this.tituloModal2='';
                        this.cta_busq='';
                        this.arrayCuentasBusq=[];
                        break;
                    }
                }
            },
            abrirModal(modelo, accion, data = []){
                switch(modelo){
                    case "retenciones":
                    {
                        switch(accion){
                            case 'registrar':
                            {
                                this.modal = 1;
                                this.tituloModal = 'Registrar retencion';
                                this.retencion = '';
                                this.id_cuenta = '';
                                this.codigo_cuenta = '';
                                this.cuenta = '';
                                this.autoretenedor = '';
                                this.declarante = '';
                                this.monto_base = '';
                                this.tipo_mov = '';
                                this.tipoAccion = 1;
                                break;
                            }
                            case 'actualizar':
                            {
                                //console.log(data);
                                this.modal=1;
                                this.tituloModal='Actualizar Concentracion';
                                this.tipoAccion=2;
                                this.retencion_id=data['id'];
                                this.retencion = data['retencion'];
                                this.id_cuenta = data['id_cuenta'];
                                this.codigo_cuenta = data['codigo_cuenta'];
                                this.cuenta = data['cuenta'];
                                this.autoretenedor = data['autoretenedor'];
                                this.declarante = data['declarante'];
                                this.monto_base = data['monto_base'];
                                this.tipo_mov = data['tipo_mov'];
                                break;
                            }
                            case 'buscar':
                            {
                                this.modal2 = 1;
                                this.tituloModal2 = 'Seleccione una cuenta';
                                break;
                            }
                        }
                    }
                }
            }
        },
        mounted() {
            this.listarRetenciones(1,this.buscar,this.criterio);
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
