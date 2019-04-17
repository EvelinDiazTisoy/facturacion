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
                        <i class="fa fa-align-justify"></i> Roles
                        <button type="button" @click="abrirModal('roles','registrar')" class="btn btn-secondary">
                            <i class="icon-plus"></i>&nbsp;Nuevo
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="form-group row">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <select class="form-control col-md-3" v-model="criterio">
                                      <option value="nombre">Nombre</option>
                                    </select>
                                    <input type="text" v-model="buscar" @keyup.enter="listarRol(1,buscar,criterio)" class="form-control" placeholder="Texto a buscar">
                                    <button type="submit" @click="listarRol(1,buscar,criterio)" class="btn btn-primary"><i class="fa fa-search"></i> Buscar</button>
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-striped table-sm">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="rol in arrayRol" :key="rol.id">
                                    
                                    <td v-text="rol.nombre"></td>
                                    <td>
                                        <div v-if="rol.estado">
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
                                        <label class="col-md-3 form-control-label" for="text-input">Nombre (*)</label>
                                        <div class="col-md-9">
                                            <input type="text" v-model="nombre" class="form-control" placeholder="Nombre del rol">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label" for="text-input">Modulo</label>
                                        <div class="col-md-9">
                                            <select v-model="id_modulo" class="form-control">
                                                <option value="0">--Seleccione</option>
                                                <option ></option>
                                            </select>                                    
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" @click="cerrarModal()">Cerrar</button>
                                <button type="button" v-if="tipoAccion==1" class="btn btn-primary" @click="registrarRol()">Guardar</button>
                                <button type="button" v-if="tipoAccion==2" class="btn btn-primary" @click="actualizarRol()">Actualizar</button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!--Fin del modal-->
            </div>
        </main>
</template>

<script>
    export default {
        props : ['ruta'],
        data (){
            return {
                rol_id: 0,
                nombre : '',
                id_modulo: 0,
                lectura : 0,
                escritura: 0,
                edicion : 0,
                imprimir : 0,
                arrayRol : [],
                errorRol : [],
                errorMostrarMsjRol : [],
                modal : 0,
                tituloModal : '',
                tipoAccion : 0,
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
            listarRol (page,buscar,criterio){
                let me=this;
                var url= this.ruta+'/rol?page=' + page + '&buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayRol = respuesta.roles.data;
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
                me.listarRol(page,buscar,criterio);
            },
            registrarRol(){
                if (this.validarRol()){
                    return;
                }
                
                let me = this;

                axios.post(this.ruta +'/cliente/registrar',{
                    'nombre': this.nombre,
                    'id_rol': this.id_rol,
                    'lectura': this.lectura,
                    'escritura': this.escritura,
                    'edicion': this.edicion,
                    'anular': this.anular,
                    'imprimir': this.imprimir
                }).then(function (response) {
                    me.cerrarModal();
                    me.listarRol(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                });
            },
            actualizarRol(){
               if (this.validarRol()){
                    return;
                }
                
                let me = this;

                axios.put(this.ruta +'/cliente/actualizar',{
                    'nombre': this.nombre,
                    'id_rol': this.id_rol,
                    'lectura': this.lectura,
                    'escritura': this.escritura,
                    'edicion': this.edicion,
                    'anular': this.anular,
                    'imprimir': this.imprimir,
                    'id': this.rol_id
                }).then(function (response) {
                    me.cerrarModal();
                    me.listarRol(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                }); 
            },            
            validarRol(){
                this.errorRol=0;
                this.errorMostrarMsjRol =[];

                if (!this.nombre) this.errorMostrarMsjRol.push("El nombre de la Rol no puede estar vacío.");

                if (this.errorMostrarMsjRol.length) this.errorRol = 1;

                return this.errorRol;
            },
            cerrarModal(){
                this.modal=0;
                this.tituloModal='';
                this.tipoAccion = 0;
                this.nombre = '';
                this.id_modulo = 0;
                this.lectura = 0;
                this.escritura = 0;
                this.edicion = 0;
                this.anular = 0;
                this.imprimir = 0;
            },
            abrirModal(modelo, accion, data = []){
                switch(modelo){
                    case "roles":
                    {
                        switch(accion){
                            case 'registrar':
                            {
                                this.modal = 1;
                                this.tituloModal = 'Registrar rol';
                                this.tipoAccion = 1;
                                this.nombre= '';
                                this.id_modulo = 0;
                                this.lectura = 0;
                                this.escritura = 0;
                                this.edicion = 0;
                                this.anular = 0;
                                this.imprimir = 0;
                                break;
                            }
                            case 'actualizar':
                            {
                                //console.log(data);
                                this.modal=1;
                                this.tituloModal='Actualizar Cliente';
                                this.tipoAccion=2;
                                this.nombre = data['nombre'];
                                this.id_modulo = data['id_modulo'];
                                this.lectura = data['lectura'];
                                this.escritura = data['escritura'];
                                this.edicion = data['edicion'];
                                this.anular = data['anular'];
                                this.imprimir = data['imprimir'];
                                this.rol_id = data['id'];
                                break;
                            }
                        }
                    }
                }
            }
        },
        mounted() {
            this.listarRol(1,this.buscar,this.criterio);
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
