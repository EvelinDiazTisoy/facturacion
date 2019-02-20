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
                        <i class="fa fa-align-justify"></i> Plan Cuentas
                        <button type="button" @click="abrirModal('planCuentas','registrar')" class="btn btn-secondary">
                            <i class="icon-plus"></i>&nbsp;Nuevo
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="form-group row">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <select class="form-control col-md-3" v-model="criterio">
                                      <option value="codigo">Codigo</option>
                                      <option value="nombre">Nombre</option>
                                    </select>
                                    <input type="text" v-model="buscar" @keyup.enter="listarPlanCuentas(1,buscar,criterio)" class="form-control" placeholder="Texto a buscar">
                                    <button type="submit" @click="listarPlanCuentas(1,buscar,criterio)" class="btn btn-primary"><i class="fa fa-search"></i> Buscar</button>
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-striped table-sm">
                            <thead>
                                <tr>
                                    <th>Codigo</th>
                                    <th>Nombre</th>                                   
                                    <th>Estado</th>
                                    <th>Editar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="cuenta in arrayPlanCuentas" :key="cuenta.id">
                                    
                                    <td v-text="cuenta.codigo"></td>
                                    <td v-text="cuenta.nombre"></td>
                                    <td>
                                        <div v-if="cuenta.condicion">
                                            <span class="badge badge-success">Activa</span>
                                        </div>
                                        <div v-else>
                                            <span class="badge badge-danger">Inactiva</span>
                                        </div>
                                        
                                    </td>
                                    <td>
                                        <button type="button" @click="abrirModal('planCuentas','actualizar',cuenta)" class="btn btn-warning btn-sm">
                                          <i class="icon-pencil"></i>
                                        </button> &nbsp;                                        
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
                            <h4 class="modal-title" >Detalles Cuenta</h4>
                            <button type="button" class="close" @click="cerrarModal()" aria-label="Close">
                              <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
                                <div class="form-group row">
                                    <label class="col-md-2 form-control-label" for="text-input">Codigo</label>
                                    <div class="col-md-2">
                                        <input type="text" v-model="codigo" class="form-control" placeholder="Codigo">
                                        
                                    </div>
                                
                                    <label class="col-md-2 form-control-label" for="text-input">Nombre</label>
                                    <div class="col-md-6">
                                        <input type="text" v-model="nombre" class="form-control" placeholder="Nombre Cuenta">                                       
                                    </div>
                                </div>
                                <div class="form-group row">

                                    <label class="col-md-2 form-control-label" for="text-input">Año</label>
                                    <div class="col-md-2">
                                        <input type="number" v-model="anio" min='2015' max="2025" class="form-control" placeholder="Año">
                                    </div>

                                    <label class="col-md-2 form-control-label" for="text-input">NIIF</label>
                                    <div class="col-md-6">
                                        <input type="text" v-model="niif" class="form-control" placeholder="NIIF">
                                    </div>                           
                                    
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-2 form-control-label" for="text-input">naturaleza</label>
                                    <div class="col-md-4">
                                        
                                        <select v-model="naturaleza" class="form-control" placeholder="Naturaleza">
                                            <option value="Credito">Credito</option>
                                            <option value="Debito">Debito</option>
                                        </select>
                                    </div>
                                
                                    <label class="col-md-2 form-control-label" for="text-input">Tipo</label>
                                    <div class="col-md-4">
                                        <select v-model="tipo" class="form-control" placeholder="Tipo">
                                            <option value="Detalle">Detalle</option>
                                            <option value="Titulo">Titulo</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-2 form-control-label" for="text-input">corriente</label>
                                    <div class="col-md-1">                                        
                                        <input type="checkbox" v-model="corriente" class="form-control">
                                    </div>
                                
                                    <label class="col-md-2 form-control-label" for="text-input">Banco</label>
                                     <div class="col-md-1">                                        
                                        <input type="checkbox" v-model="banco" class="form-control">
                                    </div>        
                                    <label class="col-md-2 form-control-label" for="text-input">Tercero</label>
                                    <div class="col-md-1">                                        
                                        <input type="checkbox" v-model="tercero" class="form-control">
                                    </div>
                                    <label class="col-md-1 form-control-label" for="text-input">Estado</label>
                                    <div class="col-md-2">
                                        <select v-model="condicion" class="form-control" placeholder="Estado">
                                            <option value="1">Activa</option>
                                            <option value="0">Inactiva</option>
                                        </select>
                                    </div>
                                </div>                                
                                
                                <div v-show="errorPlanCuentas" class="form-group row div-error">
                                    <div class="text-center text-error">
                                        <div v-for="error in errorMostrarMsjPlanCuentas" :key="error" v-text="error">

                                        </div>
                                    </div>
                                </div>

                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" @click="cerrarModal()">Cerrar</button>
                            <button type="button" v-if="tipoAccion==1" class="btn btn-primary" @click="registrarPlanCuentas()">Guardar</button>
                            <button type="button" v-if="tipoAccion==2" class="btn btn-primary" @click="actualizarPlanCuentas()">Actualizar</button>
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
                cuenta_id: 0,
                nombre : '',
                codigo : '',
                naturaleza : '',
                tipo : '',
                corriente : '',
                banco : '',
                diferido : '',
                tercero : '',
                niif : '',
                anio : '',
                condicion : '',
                arrayPlanCuentas : [],
                modal : 0,
                tituloModal : '',
                tipoAccion : 0,
                errorPlanCuentas : 0,
                errorMostrarMsjPlanCuentas : [],
                pagination : {
                    'total' : 0,
                    'current_page' : 0,
                    'per_page' : 0,
                    'last_page' : 0,
                    'from' : 0,
                    'to' : 0,
                },
                offset : 20,
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
            listarPlanCuentas (page,buscar,criterio){
                let me=this;
                var url= this.ruta +'/planCuentas?page=' + page + '&buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayPlanCuentas = respuesta.planCuentas.data;
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
                me.listarPlanCuentas(page,buscar,criterio);
            },
            registrarPlanCuentas(){
                if (this.validarPlanCuentas()){
                    return;
                }
                
                let me = this;

                axios.post(this.ruta +'/planCuentas/registrar',{
                    'nombre': this.nombre,
                    'codigo': this.codigo,
                    'naturaleza': this.naturaleza,
                    'tipo': this.tipo,
                    'corriente': this.corriente,
                    'diferido': this.diferido,
                    'niif': this.niif,
                    'condicion': this.condicion,
                    'anio': this.anio,
                    'banco': this.banco

                }).then(function (response) {
                    me.cerrarModal();
                    me.listarPlanCuentas(1,'','codigo');
                }).catch(function (error) {
                    console.log(error);
                });
            },
            actualizarPlanCuentas(){
               if (this.validarPlanCuentas()){
                    return;
                }
                
                let me = this;

                axios.put(this.ruta +'/planCuentas/actualizar',{
                    'nombre': this.nombre,
                    'codigo': this.codigo,
                    'naturaleza': this.naturaleza,
                    'tipo': this.tipo,
                    'corriente': this.corriente,
                    'diferido': this.diferido,
                    'niif': this.niif, 
                    'condicion': this.condicion,
                    'banco': this.banco,
                    'anio': this.anio,
                    'id': this.cuenta_id
                }).then(function (response) {
                    me.cerrarModal();
                    me.listarPlanCuentas(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                }); 
            },
            
            validarPlanCuentas(){
                this.errorPlanCuentas=0;
                this.errorMostrarMsjPlanCuentas =[];

                if (!this.nombre) this.errorMostrarMsjPlanCuentas.push("El nombre de la cuenta no puede estar vacío.");
                if (!this.codigo) this.errorMostrarMsjPlanCuentas.push("El codigo de la cuenta no puede estar vacío.");
                if (!this.anio) this.errorMostrarMsjPlanCuentas.push("El año de la cuenta no puede estar vacío.");
                if (!this.naturaleza) this.errorMostrarMsjPlanCuentas.push("La naturalzeza de la cuenta no puede estar vacía.");
                if (!this.tipo) this.errorMostrarMsjPlanCuentas.push("El tipo de la cuenta no puede estar vacío.");
                if (!this.condicion) this.errorMostrarMsjPlanCuentas.push("El estado de la cuenta no puede estar vacío.");
                if (this.errorMostrarMsjPlanCuentas.length) this.errorPlanCuentas = 1;

                return this.errorPlanCuentas;
            },
            cerrarModal(){
                this.modal=0;
                //this.tituloModal='';
                this.naturaleza='';
                this.tipo='';
                this.corriente='';
                this.diferido='';
                this.niif='';
                this.condicion='';
                this.nombre='';
                this.codigo='';
                this.banco='';
                this.tercero='';
                this.anio='';
            },
            abrirModal(modelo, accion, data = []){
                switch(modelo){
                    case "planCuentas":
                    {
                        switch(accion){
                            case 'registrar':
                            {
                                this.modal = 1;
                                this.tituloModal = 'Registrar Plan cuentas';
                                this.tituloModal='';
                                this.naturaleza='';
                                this.tipo='';
                                this.corriente='';
                                this.diferido='';
                                this.niif='';
                                this.condicion='';
                                this.anio
                                this.tipoAccion = 1;
                                break;
                            }
                            case 'actualizar':
                            {
                                //console.log(data);
                                this.modal=1;
                                this.tituloModal = 'Actualizar categoría';
                                this.tipoAccion = 2;
                                this.cuenta_id = data['id'];
                                this.nombre = data['nombre'];
                                this.codigo = data['codigo'];
                                this.naturaleza = data['naturaleza'];
                                this.tipo = data['tipo'];
                                this.corriente = data['corriente'];
                                this.diferido = data['diferido'];
                                this.niif = data['niif'];
                                this.banco = data['banco'];
                                this.condicion = data['condicion'];
                                this.anio = data['anio'];
                                break;
                            }
                        }
                    }
                }
            }
        },
        mounted() {
            this.listarPlanCuentas(1,this.buscar,this.criterio);
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
