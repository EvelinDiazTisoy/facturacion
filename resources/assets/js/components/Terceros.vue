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
                        <i class="fa fa-align-justify"></i> Terceros
                        <button type="button" @click="abrirModal('persona','registrar')" class="btn btn-secondary">
                            <i class="icon-plus"></i>&nbsp;Nuevo
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="form-group row">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <select class="form-control col-md-3" v-model="criterio">
                                      <option value="nombre">Nombre</option>
                                      <option value="num_documento">Documento</option>
                                      <option value="email">Email</option>
                                      <option value="telefono">Teléfono</option>
                                    </select>
                                    <input type="text" v-model="buscar" @keyup.enter="listarPersona(1,buscar,criterio)" class="form-control" placeholder="Texto a buscar">
                                    <button type="submit" @click="listarPersona(1,buscar,criterio)" class="btn btn-primary"><i class="fa fa-search"></i> Buscar</button>
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-striped table-sm">
                            <thead>
                                <tr>                                    
                                    <th>Nombre</th>
                                    <th>Tipo Documento</th>
                                    <th>Número</th>
                                    <th>Dirección</th>
                                    <th>Teléfono</th>
                                    <th>Email</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="persona in arrayPersona" :key="persona.id">
                                    
                                    <td v-if="persona.nombre&& !persona.nombre1">{{persona.nombre}}</td>
                                    <td v-else> 
                                        {{persona.nombre1+" "+persona.nombre2+" "+persona.apellido1+" "+persona.apellido2 }}
                                    </td>
                                    <td v-text="persona.tipo_documento"></td>
                                    <td v-text="persona.num_documento"></td>
                                    <td v-text="persona.direccion"></td>
                                    <td v-text="persona.telefono"></td>
                                    <td v-text="persona.email"></td>
                                    <td>
                                        <button type="button" @click="abrirModal('persona','actualizar',persona)" class="btn btn-warning btn-sm">
                                          <i class="icon-pencil"></i>
                                        </button>
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
                <div class="modal-dialog modal-primary modal-lg" role="document" style="max-width: 1000px !important">
                    <div class="modal-content" >
                        <div class="modal-header">
                            <h4 class="modal-title" v-text="tituloModal"></h4>
                            <button type="button" class="close" @click="cerrarModal()" aria-label="Close">
                              <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
                                <div class="form-group row">
                                    <label class="form-control-label col-md-2" for="text-input">Tipo Persona (*)</label>
                                    <div class="col-md-4">
                                        
                                        <select v-model="tipo_persona" class="form-control" >
                                            <option value="Natural">Natural</option>
                                            <option value="Juridica">Jurídica</option>
                                        </select>
                                    </div>
                                    <label v-if="tipo_persona!='Natural'" class="form-control-label col-md-2" for="text-input">Dig. Verificación</label>
                                    <div  v-if="tipo_persona!='Natural'" class="col-md-1">
                                        <input type="checkbox" style="margin-left: -70px;" v-model="digito_verif" class="form-control">
                                    </div>
                                </div>
                                <div class="form-group row" v-if="tipo_persona !='Natural'">
                                    <label class="col-md-2 form-control-label" for="text-input">Razon Social (*)</label>
                                    <div class="col-md-10">
                                        <input type="text" v-model="nombre" class="form-control" placeholder="Nombre de la entidad">                                        
                                    </div>
                                </div>
                                <div class="form-group row" v-if="tipo_persona =='Natural'">
                                    <label class="col-md-2 form-control-label" for="text-input">1° Nombre (*)</label>
                                    <div class="col-md-2">
                                        <input type="text" v-model="nombre1" class="form-control" placeholder="1° Nombre">                                        
                                    </div>
                                    <label class="col-md-2 form-control-label" for="text-input">2° Nombre</label>
                                    <div class="col-md-2">
                                        <input type="text" v-model="nombre2" class="form-control" placeholder="2° Nombre">                                        
                                    </div>
                                </div>
                                <div class="form-group row" v-if="tipo_persona =='Natural'">
                                    <label class="col-md-2 form-control-label" for="text-input">1° Apellido (*)</label>
                                    <div class="col-md-2">
                                        <input type="text" v-model="apellido1" class="form-control" placeholder="1° Apellido">                                        
                                    </div>
                                    <label class="col-md-2 form-control-label" for="text-input">2° Apellido</label>
                                    <div class="col-md-2">
                                        <input type="text" v-model="apellido2" class="form-control" placeholder="2° Apellido">                                        
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-2 form-control-label" for="text-input">Tipo Documento</label>
                                    <div class="col-md-3">
                                        <select v-model="tipo_documento" class="form-control">
                                            <option value="CC">Cedula de Ciudadania</option>
                                            <option value="NIT">NIT</option>
                                            <option value="CE">Cedula de Extrangeria</option>
                                            <option value="NA">Otro</option>
                                        </select>                                    
                                    </div>
                                    <label class="col-md-1 form-control-label" for="text-input">Documento</label>
                                    <div class="col-md-3">
                                        <input type="text" v-model="num_documento" class="form-control" placeholder="Número de documento">
                                    </div>
                                    <label v-if="digito_verif==1" class="col-md-1 form-control-label" for="text-input">-</label>
                                    
                                    <div v-if="digito_verif==1" class="col-md-1">
                                        <input type="number" style="margin-left: -4em;" class="form-control" v-model="num_verif" max="1">
                                    </div>
                                </div>
                               
                                <div class="form-group row">
                                    <label class="col-md-2 form-control-label" for="text-input">Dirección</label>
                                    <div class="col-md-3">
                                        <input type="text" v-model="direccion" class="form-control" placeholder="Dirección">
                                    </div>
                                    <label class="col-md-1 form-control-label" for="email-input">Email</label>
                                    <div class="col-md-3">
                                        <input type="email" v-model="email" class="form-control" placeholder="Email">
                                    </div>
                                    <label class="col-md-1 form-control-label" for="text-input">Regimen</label>
                                    <div class="col-md-2">
                                        <select v-model="regimen" class="form-control">
                                            <option value="Comun">Común</option>
                                            <option value="Simplificado">Simplificado</option>
                                            <option value="CE">Gran Contribuyente</option>                                            
                                        </select>                                    
                                    </div>

                                </div>
                                <div class="form-group row">
                                    <label class="col-md-2 form-control-label" for="text-input">Genero</label>
                                    <div class="col-md-3">
                                        <select v-model="sexo" class="form-control">
                                            <option value="Femenino">Femenino</option>
                                            <option value="Masculino">Masculino</option>
                                            <option value="Otro">Otro</option>                                            
                                        </select>                                    
                                    </div>
                                    <label class="col-md-1 form-control-label" for="date-input">Fec. Nacimiento</label>
                                    <div class="col-md-3">
                                        <input type="date" v-model="fec_nac" class="form-control" placeholder="Fecha Nacimento">
                                    </div>
                                    <label class="col-md-1 form-control-label" for="number-input">Teléfono</label>
                                    <div class="col-md-2">
                                        <input type="number" id="telefono" v-model="telefono" onkeydown="javascript: return event.keyCode == 69 ? false : true" class="form-control" placeholder="Teléfono">
                                    </div>
                                </div>

                                <div class="form-group row"  >
                                    <label class="col-md-2 form-control-label" for="text-input">Ubicación</label>
                                    <div class="col-md-4">
                                        <input type="text" v-model="reside" class="form-control" placeholder="Ubicacion">
                                    </div>
                                      
                                    <label v-if="tipo_persona !='Natural'" class="col-md-1 form-control-label" for="text-input">Rep. Legal</label>
                                    <div v-if="tipo_persona !='Natural'" class="col-md-5">
                                        <input type="text" v-model="representante" class="form-control" placeholder="Representante">
                                    </div>
                                    
                                    <label v-if="tipo_persona =='Natural'" class="col-md-1 form-control-label" for="text-input">Empresa</label>
                                    <div v-if="tipo_persona =='Natural'" class="col-md-5">
                                        <input type="text" v-model="entidad" class="form-control" placeholder="Empresa">
                                    </div>
                                </div>
                                
                                <div v-show="errorPersona" class="form-group row div-error">
                                    <div class="text-center text-error">
                                        <div v-for="error in errorMostrarMsjPersona" :key="error" v-text="error">

                                        </div>
                                    </div>
                                </div>

                            </form>
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
        </main>
</template>

<script>
    export default {
        props : ['ruta'],
        data (){
            return {
                persona_id: 0,
                nombre : '',
                tipo_documento : 'DNI',
                num_documento : '',
                direccion : '',
                telefono : '',
                email : '',
                sexo: '',
                regimen: '',
                fec_nac: '',
                reside: '',
                tipo_persona: 'Natural',
                representante: '',
                nombre1: '',
                nombre2: '',
                apellido1: '',
                apellido2: '',
                arrayPersona : [],
                modal : 0,
                tituloModal : '',
                tipoAccion : 0,
                entidad: '',
                digito_verif: '',
                num_verif: '',
                errorPersona : 0,
                errorMostrarMsjPersona : [],
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
            listarPersona (page,buscar,criterio){
                let me=this;
                var url=  this.ruta +'/cliente?page=' + page + '&buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayPersona = respuesta.personas.data;
                    me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            validar_e()
            {
                let me = this; 
                var aux;
                aux= $("#telefono").val();
                
               // me.telefono = '123';
                //console.log(aux);
            },
            cambiarPagina(page,buscar,criterio){
                let me = this;
                //Actualiza la página actual
                me.pagination.current_page = page;
                //Envia la petición para visualizar la data de esa página
                me.listarPersona(page,buscar,criterio);
            },
            registrarPersona(){
                if (this.validarPersona()){
                    return;
                }
                
                let me = this;

                axios.post( this.ruta +'/cliente/registrar',{
                    'nombre': this.nombre,
                    'tipo_documento': this.tipo_documento,
                    'num_documento' : this.num_documento,
                    'direccion' : this.direccion,
                    'telefono' : this.telefono,
                    'email' : this.email,
                    'sexo': this.sexo,
                    'regimen': this.regimen,
                    'fec_nac': this.fec_nac,
                    'reside': this.reside,
                    'representante': this.representante,
                    'tipo_persona' : this.tipo_persona,
                    'nombre1' : this.nombre1,
                    'nombre2' : this.nombre2,
                    'apellido1' : this.apellido1,
                    'apellido2' : this.apellido2,
                    'digito_verif' : this.digito_verif,
                    'entidad' : this.entidad,
                    'num_verif' : this.num_verif,
                }).then(function (response) {
                    me.cerrarModal();
                    me.listarPersona(1,'','nombre');
                }).catch(function (error) {
                    console.log(error); 
                });
            },
            actualizarPersona(){
               if (this.validarPersona()){
                    return;
                }
                
                let me = this;

                axios.put( this.ruta +'/cliente/actualizar',{
                    'nombre': this.nombre,
                    'tipo_documento': this.tipo_documento,
                    'num_documento' : this.num_documento,
                    'direccion' : this.direccion,
                    'telefono' : this.telefono,
                    'email' : this.email,
                    'sexo': this.sexo,
                    'regimen': this.regimen,
                    'fec_nac': this.fec_nac,
                    'reside': this.reside,
                    'representante': this.representante,
                    'id': this.persona_id,
                    'tipo_persona' : this.tipo_persona,
                    'nombre1' : this.nombre1,
                    'nombre2' : this.nombre2,
                    'apellido1' : this.apellido1,
                    'apellido2' : this.apellido2,
                    'digito_verif' : this.digito_verif,
                    'entidad' : this.entidad,
                    'num_verif' : this.num_verif,
                }).then(function (response) {
                    me.cerrarModal();
                    me.listarPersona(1,'','nombre');
                    this.num_verif="";
                }).catch(function (error) {
                    console.log(error);
                }); 
            },            
            validarPersona(){
                this.errorPersona=0;
                this.errorMostrarMsjPersona =[];

                if (this.tipo_persona=='Natural'&&(this.nombre1==''||this.apellido1=='')){
                    this.errorMostrarMsjPersona.push("El nombre de la persona no puede estar vacío.");
                    this.nombre = '';
                }
                if(this.tipo_persona=='Juridica'&&this.nombre==''){
                    this.errorMostrarMsjPersona.push("El nombre de la entidad no puede estar vacío.");
                    this.nombre1 = ''; this.nombre2 = ''; this.apellido1 = ''; this.apellido2= '';
                }
                if(this.num_documento==''){
                    this.errorMostrarMsjPersona.push("Digite el numero de documento.");
                }
                if (this.errorMostrarMsjPersona.length) this.errorPersona = 1;

                return this.errorPersona;
            },
            cerrarModal(){
                this.modal=0;
                this.tituloModal='';
                this.nombre='';
                this.tipo_documento='CC';
                this.num_documento='';
                this.direccion='';
                this.telefono='';
                this.email='';
                this.errorPersona=0;
                this.sexo ='';
                this.regimen ='';
                this.fec_nac ='';
                this.reside ='';
                this.representante ='';
                this.tipo_persona = 'Natural';
                this.nombre1= '',
                this.nombre2= '',
                this.apellido1= '',
                this.apellido2= ''
            },  
            abrirModal(modelo, accion, data = []){
                switch(modelo){
                    case "persona":
                    {
                        switch(accion){
                            case 'registrar':
                            {
                                this.modal = 1;
                                this.tituloModal = 'Registrar Tercero';
                                this.nombre= '';
                                this.tipo_documento='CC';
                                this.num_documento='';
                                this.direccion='';
                                this.telefono='';
                                this.email='';
                                this.tipoAccion = 1;
                                break;
                            }
                            case 'actualizar':
                            {
                                //console.log(data);
                                this.modal=1;
                                this.tituloModal='Actualizar Cliente';
                                this.tipoAccion=2;
                                this.persona_id=data['id'];
                                this.nombre = data['nombre'];
                                this.nombre1 = data['nombre1'];
                                this.nombre2 = data['nombre2'];
                                this.apellido1 = data['apellido1'];
                                this.apellido2 = data['apellido2'];
                                this.tipo_persona = data['tipo_persona'];
                                this.tipo_documento = data['tipo_documento'];
                                this.num_documento = data['num_documento'];
                                this.direccion = data['direccion'];
                                this.telefono = data['telefono'];
                                this.email = data['email'];
                                this.sexo =data['sexo'];
                                this.regimen =data['regimen'];
                                this.fec_nac =data['fec_nac'];
                                this.reside =data['reside'];
                                this.representante =data['email'];
                                this.entidad =data['entidad'];
                                this.digito_verif =data['digito_verif'];
                                this.num_verif =data['num_verif'];
                                
                                break;
                            }
                        }
                    }
                }
            }
        },
        mounted() {
            this.listarPersona(1,this.buscar,this.criterio);
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
