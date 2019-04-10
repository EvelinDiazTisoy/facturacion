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
                        <i class="fa fa-align-justify"></i> Unidad de medida
                        <button type="button" @click="abrirModal('configuraciones','registrar')" class="btn btn-secondary">
                            <i class="icon-plus"></i>&nbsp;Nuevo
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="form-group row">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <select class="form-control col-md-3" v-model="criterio">
                                      <option value="nombre">Nombre</option>>
                                    </select>
                                    <input type="text" v-model="buscar" @keyup.enter="listarConfiguraciones(1,buscar,criterio)" class="form-control" placeholder="Texto a buscar">
                                    <button type="submit" @click="listarConfiguraciones(1,buscar,criterio)" class="btn btn-primary"><i class="fa fa-search"></i> Buscar</button>
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-striped table-sm">
                            <thead>
                                <tr>
                                    <th>Opciones</th>
                                    <th class="col-md-1">Lugar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="configuraciones in arrayConfiguraciones" :key="configuraciones.id">
                                    <td>
                                        <button type="button" @click="abrirModal('configuraciones','actualizar',configuraciones)" class="btn btn-warning btn-sm">
                                          <i class="icon-pencil"></i>
                                        </button> &nbsp;
                                    </td>
                                    <td v-text="configuraciones.lugar"></td>
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
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="text-input">Lugar</label>
                                    <div class="col-md-9">
                                        <input type="text" v-model="lugar" class="form-control" placeholder="Lugar de facturacion">
                                    </div>
                                </div>
                                <div v-show="errorConfiguracion" class="form-group row div-error">
                                    <div class="text-center text-error">
                                        <div v-for="error in errorMostrarMsjConfiguracion" :key="error" v-text="error">

                                        </div>
                                    </div>
                                </div>

                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" @click="cerrarModal()">Cerrar</button>
                            <button type="button" v-if="tipoAccion==1" class="btn btn-primary" @click="registrarConfiguracion()">Guardar</button>
                            <button type="button" v-if="tipoAccion==2" class="btn btn-primary" @click="actualizarConfiguracion()">Actualizar</button>
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
    export default {
        props : ['ruta'],
        data (){
            return {
                configuraciones_id: 0,
                lugar : '',
                arrayConfiguraciones : [],
                modal : 0,
                tituloModal : '',
                tipoAccion : 0,
                errorUndMedida : 0,
                errorMostrarMsjUndMedida : [],
                errorConfiguracion : 0,
                errorMostrarMsjConfiguracion : [],
                pagination : {
                    'total' : 0,
                    'current_page' : 0,
                    'per_page' : 0,
                    'last_page' : 0,
                    'from' : 0,
                    'to' : 0,
                },
                offset : 10,
                criterio : 'lugar',
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
            listarConfiguraciones (page,buscar,criterio){
                let me=this;
                var url= this.ruta +'/configuraciones?page=' + page + '&buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayConfiguraciones = respuesta.configuraciones.data;
                    me.pagination= respuesta.pagination;
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
                me.listarConfiguraciones(page,buscar,criterio);
            },
            registrarConfiguracion(){
                if (this.validarUndMedida()){
                    return;
                }
                
                let me = this;

                axios.post(this.ruta +'/configuraciones/registrar',{
                    'lugar': this.lugar,
                }).then(function (response) {
                    me.cerrarModal();
                    me.listarConfiguraciones(1,'','lugar');
                }).catch(function (error) {
                    console.log(error);
                });
            },
            actualizarConfiguracion(){
               if (this.validarUndMedida()){
                    return;
                }
                
                let me = this;

                axios.put(this.ruta +'/configuraciones/actualizar',{
                    'lugar': this.lugar,
                    'id': this.configuraciones_id
                }).then(function (response) {
                    me.cerrarModal();
                    me.listarConfiguraciones(1,'','');
                }).catch(function (error) {
                    console.log(error);
                }); 
            },
            validarUndMedida(){
                this.errorConfiguracion=0;
                this.errorMostrarMsjConfiguracion =[];

                if (!this.lugar) this.errorMostrarMsjConfiguracion.push("El nombre del lugar no puede estar vacío.");

                if (this.errorMostrarMsjConfiguracion.length) this.errorConfiguracion = 1;

                return this.errorConfiguracion;
            },
            selectConfiguraciones(){
                let me=this;
                var url= this.ruta + '/configuraciones/selectConfiguraciones';
                axios.get(url).then(function (response) {
                    //console.log(response);
                    var respuesta= response.data;
                    me.arrayConfiguraciones = respuesta.configuraciones;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            cerrarModal(){
                this.modal=0;
                this.tituloModal='';
                this.nombre='';
            },
            abrirModal(modelo, accion, data = []){
                switch(modelo){
                    case "configuraciones":
                    {
                        switch(accion){
                            case 'registrar':
                            {
                                this.modal = 1;
                                this.tituloModal = 'Registrar lugar';
                                this.lugar= '';
                                this.tipoAccion = 1;
                                break;
                            }
                            case 'actualizar':
                            {
                                //console.log(data);
                                this.modal=1;
                                this.tituloModal='Actualizar lugar';
                                this.tipoAccion=2;
                                this.configuraciones_id=data['id'];
                                this.lugar = data['lugar'];
                                break;
                            }
                        }
                    }
                }
            }
        },
        mounted() {
            this.listarConfiguraciones(1,this.buscar,this.criterio);
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
