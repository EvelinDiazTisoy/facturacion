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
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="rol in arrayNombresRoles" :key="rol.nombre">
                                    <td v-text="rol.nombre"></td>
                                    <td>
                                        <div v-if="rol.estado">
                                            <span class="badge badge-success">Activo</span>
                                        </div>
                                        <div v-else>
                                            <span class="badge badge-danger">Desactivado</span>
                                        </div>
                                    </td>
                                    <td>
                                        <button type="button" @click="abrirModal('roles','actualizar',rol)" class="btn btn-warning btn-sm">
                                          <i class="icon-pencil"></i>
                                        </button>

                                        <template v-if="rol.estado">
                                            <button type="button" class="btn btn-danger btn-sm" @click="desactivarRol(rol.nombre)">
                                                <i class="icon-trash"></i>
                                            </button>
                                        </template>
                                        <template v-else>
                                            <button type="button" class="btn btn-info btn-sm" @click="activarRol(rol.nombre)">
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
                                        <table class="table table-bordered table-striped table-sm col-md-11">
                                            <thead>
                                                <tr>
                                                    <th>Modulo</th>
                                                    <th>Ver</th>
                                                    <th>Crear</th>
                                                    <th>Editar</th>
                                                    <th>Anular</th>
                                                    <th>Imprimir</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr v-for="modulo in arrayModulos" :key="modulo.id">
                                                    <td v-if="modulo.tipo==1" v-text="modulo.nombre" style="background: #c2cfd6;"></td>
                                                    <td  v-if="modulo.tipo==1" style="background: #c2cfd6;"><input type="checkbox" v-model="modulo.lectura"></td>
                                                    <td  v-if="modulo.tipo==1" style="background: #c2cfd6;"><input type="checkbox" v-model="modulo.escritura"></td>
                                                    <td  v-if="modulo.tipo==1" style="background: #c2cfd6;"><input type="checkbox" v-model="modulo.edicion"></td>
                                                    <td  v-if="modulo.tipo==1" style="background: #c2cfd6;"><input type="checkbox" v-model="modulo.anular"></td>
                                                    <td  v-if="modulo.tipo==1" style="background: #c2cfd6;"><input type="checkbox" v-model="modulo.imprimir"></td>
                                                    
                                                    <td v-if="modulo.tipo==2" v-text="modulo.nombre" style="padding-left: 1em; background: #ffffff;"></td>
                                                    <td  v-if="modulo.tipo==2" style="background: #ffffff;"><input type="checkbox" v-model="modulo.lectura"></td>
                                                    <td  v-if="modulo.tipo==2" style="background: #ffffff;"><input type="checkbox" v-model="modulo.escritura"></td>
                                                    <td  v-if="modulo.tipo==2" style="background: #ffffff;"><input type="checkbox" v-model="modulo.edicion"></td>
                                                    <td  v-if="modulo.tipo==2" style="background: #ffffff;"><input type="checkbox" v-model="modulo.anular"></td>
                                                    <td  v-if="modulo.tipo==2" style="background: #ffffff;"><input type="checkbox" v-model="modulo.imprimir"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </form>
                            </div>
                            <div v-show="errorRol" class="form-group row div-error">
                                <div class="text-center text-error">
                                    <div v-for="error in errorMostrarMsjRol" :key="error" v-text="error">

                                    </div>
                                </div>
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
                validarNombre : '',
                id_modulo: 0,
                lectura : 0,
                escritura: 0,
                edicion : 0,
                imprimir : 0,
                arrayRol : [],
                arrayModulos: [],
                arrayNombresRoles:[],
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
                    me.arrayRol = respuesta.roles;
                    me.pagination= respuesta.pagination;
                    me.arrayNombresRoles = respuesta.roles2.data;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            listarModulos(page,buscar,criterio){
                let me=this;
                var url= this.ruta+'/modulo' ;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayModulos = respuesta.modulos;
                    // me.pagination= respuesta.pagination;
                    
                    if(me.tipoAccion==2)
                    {
                        for(var p=0; p<me.arrayRol.length; p++)
                        {
                            if(me.arrayRol[p]['nombre'] == me.nombre)
                            {
                                for(var m=0; m<me.arrayModulos.length; m++)
                                {
                                    if(me.arrayModulos[m]['id']==me.arrayRol[p]['id_modulo'])
                                    {
                                        me.arrayModulos[m].lectura = me.arrayRol[p]['lectura'];
                                        me.arrayModulos[m].escritura = me.arrayRol[p]['escritura'];
                                        me.arrayModulos[m].edicion = me.arrayRol[p]['edicion'];
                                        me.arrayModulos[m].anular = me.arrayRol[p]['anular'];
                                        me.arrayModulos[m].imprimir = me.arrayRol[p]['imprimir'];
                                    }
                                }
                            }
                        }
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
                me.listarRol(page,buscar,criterio);
            },
            registrarRol(){
                if (this.validarRol()){
                    return;
                }
                
                let me = this;

                axios.post(this.ruta +'/rol/registrar',{
                    'nombre': this.nombre,
                    'id_modulo': this.id_modulo,
                    'lectura': this.lectura,
                    'escritura': this.escritura,
                    'edicion': this.edicion,
                    'anular': this.anular,
                    'imprimir': this.imprimir,
                    'modulos' : this.arrayModulos
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

                axios.put(this.ruta +'/rol/actualizar',{
                    'nombre': this.nombre,
                    'nombreAnterior': this.validarNombre,
                    'id_modulo': this.id_modulo,
                    'lectura': this.lectura,
                    'escritura': this.escritura,
                    'edicion': this.edicion,
                    'anular': this.anular,
                    'imprimir': this.imprimir,
                    'modulos' : this.arrayModulos,
                    'id': this.rol_id
                }).then(function (response) {
                    me.cerrarModal();
                    me.listarRol(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                });
            },            
            validarRol(){
                let me = this;
                me.errorRol=0;
                me.errorMostrarMsjRol =[];

                if (!me.nombre) me.errorMostrarMsjRol.push("El nombre de la Rol no puede estar vacío.");
                console.log(me.tipoAccion);
                for(var r=0; r<me.arrayNombresRoles.length; r++)
                {
                    if(me.tipoAccion==1 && me.arrayNombresRoles[r]['nombre']==me.nombre) me.errorMostrarMsjRol.push("El nombre del rol ya se encuentra registrado");

                    if(me.tipoAccion==2 && me.validarNombre!=me.nombre && me.nombre==me.arrayNombresRoles[r]['nombre']) me.errorMostrarMsjRol.push("El nombre del rol ya se encuentra registrado");
                }

                if (me.errorMostrarMsjRol.length) me.errorRol = 1;

                return me.errorRol;
            },
            desactivarRol(nombre){
               swal({
                title: 'Esta seguro de desactivar este rol?',
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

                    axios.put(this.ruta +'/rol/desactivar',{
                        'nombre': nombre
                    }).then(function (response) {
                        me.listarRol(1,'','nombre');
                        swal(
                        'Desactivado!',
                        'El rol ha sido desactivado con éxito.',
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
            activarRol(nombre){
               swal({
                title: 'Esta seguro de activar este rol?',
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

                    axios.put(this.ruta +'/rol/activar',{
                        'nombre': nombre
                    }).then(function (response) {
                        me.listarModulo('','nombre');
                        swal(
                        'Activado!',
                        'El rol ha sido activado con éxito.',
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
                this.rol_id = 0;
                this.errorRol = 0;
                this.errorMostrarMsjRol = [];
                this.arrayModulos = [];
            },
            abrirModal(modelo, accion, data = []){
                let me = this;
                switch(modelo){
                    case "roles":
                    {
                        this.listarModulos();
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
                                this.validarNombre = data['nombre'];
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
