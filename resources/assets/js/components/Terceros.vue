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
                        <button v-if="permisosUser.crear" type="button" @click="abrirModal('persona','registrar')" class="btn btn-primary">
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
                                      <option value="nombre">Nombre</option>
                                      <option value="num_documento">Documento</option>
                                      <option value="email">Email</option>
                                      <option value="telefono1">Teléfono</option>
                                    </select>
                                    <select v-else disabled class="form-control col-md-3" v-model="criterio">
                                    </select>

                                    <input v-if="permisosUser.leer" type="text" v-model="buscar" @keyup.enter="listarPersona(1,buscar,criterio)" class="form-control" placeholder="Texto a buscar">
                                    <input v-else disabled type="text" v-model="buscar" class="form-control" placeholder="Texto a buscar">

                                    <button v-if="permisosUser.leer" type="submit" @click="listarPersona(1,buscar,criterio)" class="btn btn-primary"><i class="fa fa-search"></i> Buscar</button>
                                    <button v-else type="button" class="btn btn-secondary"><i class="fa fa-search"></i> Buscar</button>
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
                                    <td v-text="persona.telefono1"></td>
                                    <td v-text="persona.email"></td>
                                    <td>
                                        <button v-if="permisosUser.actualizar" type="button" @click="abrirModal('persona','actualizar',persona)" class="btn btn-warning btn-sm">
                                          <i class="icon-pencil"></i>
                                        </button>
                                        <button v-else type="button" class="btn btn-secondary btn-sm">
                                          <i class="icon-pencil"></i>
                                        </button>

                                        <button v-if="permisosUser.leer" type="button" @click="abrirModal('persona','novedades',persona)" class="btn btn-info btn-sm">
                                          <i class="fa fa-align-justify"></i>
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
                                    <label class="form-control-label col-md-2" for="text-input">Dig. Verificación</label>
                                    <div  class="col-md-1">
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

                                    <label class="col-md-2 form-control-label" for="text-input">Departamento</label>
                                    <div class="col-md-2">
                                        <select v-model="departamento" @change="listarMunicipios(departamento)" class="form-control">
                                            <option v-for="departamento in arrayDepartamentos" :key="departamento.id" :value="departamento.id" v-text="departamento.nombre"></option>
                                        </select>                                        
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

                                    <label class="col-md-2 form-control-label" for="text-input">Municipio</label>
                                    <div class="col-md-2">
                                        <select v-model="municipio" class="form-control">
                                            <option v-for="municipio in arrayMunicipios" :key="municipio.id" :value="municipio.id" v-text="municipio.nombre"></option>
                                        </select>                                        
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
                                    <label class="col-md-1 form-control-label" for="number-input">Teléfono 1</label>
                                    <div class="col-md-2">
                                        <input type="number" id="telefono1" v-model="telefono1" onkeydown="javascript: return event.keyCode == 69 ? false : true" class="form-control" placeholder="Teléfono 1">
                                    </div>
                                </div>

                                <!--<div class="form-group row">
                                    <label class="col-md-1 form-control-label" for="number-input">Teléfono 2</label>
                                    <div class="col-md-2">
                                        <input type="number" id="telefono2" v-model="telefono2" onkeydown="javascript: return event.keyCode == 69 ? false : true" class="form-control" placeholder="Teléfono 2">
                                    </div>
                                    <label class="col-md-1 form-control-label" for="number-input">Celular</label>
                                    <div class="col-md-2">
                                        <input type="number" id="celular" v-model="celular" onkeydown="javascript: return event.keyCode == 69 ? false : true" class="form-control" placeholder="Celular">
                                    </div>
                                    <div class="col-md-3">
                                    </div>
                                </div>-->

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
                                <div class="form-group row">
                                    <label class="col-md-2 form-control-label" for="text-input">Autoretenedor</label>
                                    <div class="col-md-2">
                                        <select class="form-control" v-model="autoretenedor">
                                            <option value="">Seleccione</option>
                                            <option value="1">Autoretenedor</option>
                                            <option value="2">No autoretenedor</option>
                                        </select>
                                    </div>

                                    <label class="col-md-2 form-control-label" for="text-input">Declarante</label>
                                    <div class="col-md-2">
                                        <select class="form-control" v-model="declarante">
                                            <option value="">Seleccione</option>
                                            <option value="1">Declarante</option>
                                            <option value="2">No declarante</option>
                                        </select>
                                    </div>

                                    <div class="col-md-2">
                                        <label class="form-control-label col-md-9 float-left">Cliente</label>
                                        <div class="col-md-3 float-right">
                                            <input type="checkbox" class="form-control" v-model="cliente">
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-control-label col-md-9 float-left">Proveedor</label>
                                        <div class="col-md-3 float-right">
                                            <input type="checkbox" class="form-control" v-model="proveedor">
                                        </div>
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
                            <button v-if="cliente" type="button" class="btn btn-info" @click="abrirModal('persona','cliente')">Cliente</button>
                            <button v-else type="button" class="btn btn-secondary">Cliente</button>

                            <button v-if="proveedor" type="button" class="btn btn-info" @click="abrirModal('persona','proveedor')">Proveedor</button>
                            <button v-else type="button" class="btn btn-secondary">Proveedor</button>

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

            <!--Inicio del modal agregar/actualizar-->
            <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal2}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary modal-lg" role="document" style="max-width: 1000px !important">
                    <div class="modal-content" >
                        <div class="modal-header">
                            <h4 class="modal-title" v-text="tituloModal"></h4>
                            <button type="button" class="close" @click="modal2=0; tipoAccion2=0" aria-label="Close">
                              <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
                                
                                <div class="form-group row" v-if="tipoAccion2==1">
                                    <div class="col-md-4">
                                        <label class="form-control-label col-md-3 float-left">Vendedor</label>
                                        <div class="col-md-9 float-right">
                                            <select class="form-control" v-model="id_vendedor">
                                                <option>Seleccione</option>
                                                <option v-for="vendedor in arrayVendedores" :key="vendedor.id" :value="vendedor.id" v-text="vendedor.colaborador"></option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-control-label col-md-3 float-left">Zona</label>
                                        <div class="col-md-9 float-right">
                                            <select class="form-control" v-model="id_zona">
                                                <option>Seleccione</option>
                                                <option v-for="zona in arrayZonas" :key="zona.id" :value="zona.id" v-text="zona.zona"></option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-control-label col-md-3 float-left">Plazo pago</label>
                                        <div class="col-md-9 float-right">
                                            <input type="number" class="form-control" v-model="plazo_pago">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row" v-if="tipoAccion2==1">
                                    <div class="col-md-2">
                                        <label class="form-control-label col-md-9 float-left">Cupo credito</label>
                                        <div class="col-md-3 float-right">
                                            <input type="checkbox" class="form-control" v-model="cupo_credito">
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-control-label col-md-9 float-left">Retenedor fuente</label>
                                        <div class="col-md-3 float-right">
                                            <input type="checkbox" class="form-control" v-model="retenedor_fuente">
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-control-label col-md-9 float-left">Retenedor iva</label>
                                        <div class="col-md-3 float-right">
                                            <input type="checkbox" class="form-control" v-model="retenedor_iva">
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-control-label col-md-9 float-left">Excluido iva</label>
                                        <div class="col-md-3 float-right">
                                            <input type="checkbox" class="form-control" v-model="excluido_iva">
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row" v-if="tipoAccion2==2">
                                    
                                    <div class="col-md-6">
                                        <label class="form-control-label col-md-4 float-left">Bancos</label>
                                        <div class="col-md-8 float-right">
                                            <select class="form-control" v-model="id_banco">
                                                <option v-for="banco in arrayBancos" :key="banco.id" :value="banco.id" v-text="banco.nombre"></option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-control-label col-md-4 float-left">N° cuenta</label>
                                        <div class="col-md-8 float-right">
                                            <input type="text" class="form-control" v-model="num_cuenta_banco">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row" v-if="tipoAccion2==2">
                                    <div class="col-md-6">
                                        <label class="form-control-label col-md-4 float-left">Tipo cuenta</label>
                                        <div class="col-md-8 float-right">
                                            <select class="form-control" v-model="tipo_cuenta">
                                                <option value="Corriente">Corriente</option>
                                                <option value="Ahorros">Ahorros</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-control-label col-md-4 float-left">Representante cuenta</label>
                                        <div class="col-md-8 float-right">
                                            <input type="text" class="form-control" v-model="representante_cuenta">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row" v-if="tipoAccion2==2">
                                    <div class="col-md-6">
                                        <label class="form-control-label col-md-4 float-left">Nacional</label>
                                        <div class="col-md-8 float-right">
                                            <input type="radio" class="form-control" value="Nacional" v-model="tipo_nacionalidad">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-control-label col-md-4 float-left">Extranjero</label>
                                        <div class="col-md-8 float-right">
                                            <input type="radio" class="form-control" value="Extranjero" v-model="tipo_nacionalidad">
                                        </div>
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
                            <button type="button" class="btn btn-secondary" @click="modal2=0; tipoAccion2=0">Cerrar</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!--Fin del modal-->

            <!-- Modal de novedades -->
            <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal3}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary modal-lg" role="document" style="max-width: 800px !important">
                    <div class="modal-content" >
                        <div class="modal-header">
                            <h4 class="modal-title" v-text="tituloModal3"></h4>
                            <button v-if="permisosUser.crear && tipoAccion3==0" type="button" @click="tipoAccion3=1" class="btn btn-default float-left">
                                <i class="icon-plus"></i>&nbsp;Nuevo
                            </button>

                            <button type="button" class="close" @click="cerrarModal3()" aria-label="Close">
                              <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="" method="post" enctype="multipart/form-data" class="form-horizontal" v-if="tipoAccion3==1">
                                <div class="form-group row">
                                    <div class="col-md-12">
                                        <label class="form-control-label col-md-1 flota-left">Nombre</label>
                                        <div class="col-md-11 float-right">
                                            <input type="text" class="form-control float-right" v-model="novedad" style="width: 96%;">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label class="form-control-label col-md-3 flota-left">Observacion</label>
                                        <div class="col-md-9 float-right">
                                            <textarea class="form-control" v-model="observacionNovedad"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label class="form-control-label col-md-3 flota-left">Link</label>
                                        <div class="col-md-9 float-right">
                                            <input type="text" class="form-control" v-model="link">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row bordered">
                                    <div class="form-group col-md-6">
                                        <button v-if="tipoAccion3==1" type="button" class="btn btn-secondary float-right" @click="tipoAccion3=0">Cerrar</button>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <button v-if="tipoAccion3==1" type="button" class="btn btn-primary float-left" @click="registrarNovedad()">Guardar</button>
                                    </div>
                                </div>
                            </form>
                            <!--<ul>
                                <li v-for="novedades in arrayNovedades" :key="novedades.id" v-text="novedades.nombre"></li>
                            </ul>-->
                            <table class="table table-bordered table-striped table-sm" style="display: block;border: none;overflow-y: auto;height: 30em;">
                                <thead>
                                    <th style="width: 28%;">Nombre</th>
                                    <th style="width: 45%; max-width: 45%;">Observacion</th>
                                    <th>Link</th>
                                    <th style="width: 10%;">Opciones</th>
                                </thead>
                                <tbody v-if="arrayNovedades.length">
                                    <tr v-for="novedades in arrayNovedades" :key="novedades.id">
                                        <td v-text="novedades.nombre"></td>
                                        <td><p v-text="novedades.observacion" style="max-height: 6em !important;overflow-y: auto;"></p></td>
                                        <td><a :href="novedades.link" target="_blank" class="icon-link"></a></td>
                                        <td>
                                            <button type="button" class="btn btn-danger btn-sm" @click="eliminarNovedad(novedades.id)">
                                                <i class="icon-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                                <tbody v-else>
                                    <tr><td colspan="4">No hay novedades regitradas</td></tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" @click="cerrarModal3()">Cerrar</button>
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
        props : ['ruta', 'permisosUser'],
        data (){
            return {
                persona_id: 0,
                nombre : '',
                tipo_documento : 'DNI',
                num_documento : '',
                direccion : '',
                telefono1 : '',
                telefono2 : '',
                celular : '',
                email : '',
                email2 : '',
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
                autoretenedor: '',
                declarante : '',
                cliente : '',
                proveedor : '',
                id_vendedor : '',
                id_zona : '',
                plazo_pago : '',
                bloquear : '',
                cupo_credito : '',
                retenedor_fuente : '',
                retenedor_iva : '',
                excluido_iva : '',
                autoretefuente : '',
                autoreteiva : '',
                autoreteica : '',
                id_banco : 0,
                num_cuenta_banco : '',
                tipo_cuenta : '',
                representante_cuenta : '',
                tipo_nacionalidad : '',

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
                buscar : '',

                modal2 : 0,
                tipoAccion2 : 0,

                arrayVendedores : [],
                arrayZonas : [],
                arrayBancos : [],

                modal3 : 0,
                tipoAccion3 : 0,
                tituloModal3 : '',
                novedad : '',
                observacionNovedad : '',
                link : '',
                arrayNovedades : [],

                departamento : '',
                municipio : '',
                arrayDepartamentos : [],
                arrayMunicipios : [],
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
            listarVendedores(page,buscar,criterio){
                let me=this;
                var url=  this.ruta +'/colaboradores/selectColaboradorVendedor';
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayVendedores = respuesta.colaboradores;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            listarZonas(page,buscar,criterio){
                let me=this;
                var url=  this.ruta +'/zona/selectZona';
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayZonas = respuesta.zona;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            listarNovedades(id){
                let me=this;
                var url=  this.ruta +'/novedades/listarNovedades?id='+id;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayNovedades = respuesta.novedades;
                    // me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            listarBancos(){
                let me=this;
                var url=  this.ruta +'/bancos/selectBancos';
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayBancos = respuesta.bancos;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            listarDepartamentos(){
                let me=this;
                var url=  this.ruta +'/departamentos';
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayDepartamentos = respuesta.departamentos;
                    // me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            listarMunicipios(id){
                let me=this;
                var url=  this.ruta +'/municipios/listarMunicipios?id='+id;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayMunicipios = respuesta.municipios;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            validar_e()
            {
                let me = this; 
                var aux;
                aux= $("#telefono1").val();
                
               // me.telefono1 = '123';
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
                    'telefono1' : this.telefono1,
                    'telefono2' : this.telefono2,
                    'celular' : this.celular,
                    'email' : this.email,
                    'email' : this.email2,
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
                    'autoretenedor' : this.autoretenedor,
                    'declarante' : this.declarante,
                    'cliente' : this.cliente,
                    'proveedor' : this.proveedor,
                    'id_vendedor' : this.id_vendedor,
                    'id_zona' : this.id_zona,
                    'plazo_pago' : this.plazo_pago,
                    'bloquear' : this.bloquear,
                    'cupo_credito' : this.cupo_credito,
                    'retenedor_fuente' : this.retenedor_fuente,
                    'retenedor_iva' : this.retenedor_iva,
                    'excluido_iva' : this.excluido_iva,
                    'autoretefuente' : this.autoretefuente,
                    'autoreteiva' : this.autoreteiva,
                    'autoreteica' : this.autoreteica,
                    'id_banco' : this.id_banco,
                    'num_cuenta_banco' : this.num_cuenta_banco,
                    'tipo_cuenta' : this.tipo_cuenta,
                    'representante_cuenta' : this.representante_cuenta,
                    'tipo_nacionalidad' : this.tipo_nacionalidad,
                    'departamento' : this.departamento,
                    'municipio' : this.municipio,
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
                    'telefono1' : this.telefono1,
                    'telefono2' : this.telefono2,
                    'celular' : this.celular,
                    'email' : this.email,
                    'email2' : this.email2,
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
                    'autoretenedor' : this.autoretenedor,
                    'declarante' : this.declarante,
                    'cliente' : this.cliente,
                    'proveedor' : this.proveedor,
                    'id_vendedor' : this.id_vendedor,
                    'id_zona' : this.id_zona,
                    'plazo_pago' : this.plazo_pago,
                    'bloquear' : this.bloquear,
                    'cupo_credito' : this.cupo_credito,
                    'retenedor_fuente' : this.retenedor_fuente,
                    'retenedor_iva' : this.retenedor_iva,
                    'excluido_iva' : this.excluido_iva,
                    'autoretefuente' : this.autoretefuente,
                    'autoreteiva' : this.autoreteiva,
                    'autoreteica' : this.autoreteica,
                    'id_banco' : this.id_banco,
                    'num_cuenta_banco' : this.num_cuenta_banco,
                    'tipo_cuenta' : this.tipo_cuenta,
                    'representante_cuenta' : this.representante_cuenta,
                    'tipo_nacionalidad' : this.tipo_nacionalidad,
                    'departamento' : this.departamento,
                    'municipio' : this.municipio,
                }).then(function (response) {
                    me.cerrarModal();
                    me.listarPersona(1,'','nombre');
                    me.num_verif="";
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
            registrarNovedad(){
                // if (this.validarPersona()){
                //     return;
                // }
                
                let me = this;

                axios.post( this.ruta +'/novedades/registrar',{
                    'id_tercero' : this.persona_id,
                    'nombre': this.novedad,
                    'observacion' : this.observacionNovedad,
                    'link' : this.link,
                }).then(function (response) {
                    me.tipoAccion3=0;
                    me.listarNovedades(me.persona_id);
                }).catch(function (error) {
                    console.log(error); 
                });
            },
            eliminarNovedad(id){
                let me = this;

                axios.put( this.ruta +'/novedades/eliminarNovedad',{
                    'id': id,
                }).then(function (response) {
                    me.listarNovedades(me.persona_id);
                }).catch(function (error) {
                    console.log(error); 
                });
            },
            cerrarModal3(){
                this.modal3=0;
                this.tituloModal3='';
                this.tipoAccion3=0;
                this.novedad='';
                this.observacionNovedad='';
                this.link='';
                this.tipoAccion3=0;
            }, 
            cerrarModal(){
                this.modal=0;
                this.tituloModal='';
                this.nombre='';
                this.tipo_documento='CC';
                this.num_documento='';
                this.direccion='';
                this.telefono1='';
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
                this.apellido2= '',
                this.autoretenedor= '',
                this.declarante='',

                this.tipoAccion2 = 0;
                this.departamento = '';
                this.municipio = '';
            },  
            abrirModal(modelo, accion, data = []){
                this.listarVendedores();
                this.listarZonas();
                this.listarBancos();
                this.listarDepartamentos();
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
                                this.telefono1='';
                                this.email='';
                                this.autoretenedor='';
                                this.declarante='';
                                this.cliente = '';
                                this.id_vendedor = '';
                                this.id_zona = '';
                                this.plazo_pago = '';
                                this.bloquear = '';
                                this.cupo_credito = '';
                                this.retenedor_fuente = '';
                                this.retenedor_iva = '';
                                this.excluido_iva = '';
                                this.autoretefuente = '';
                                this.autoreteiva = '';
                                this.autoreteica = '';
                                this.id_banco = 0;
                                this.num_cuenta_banco = '';
                                this.tipo_cuenta = '';
                                this.representante_cuenta = '';
                                this.tipo_nacionalidad = '';
                                this.departamento = '';
                                this.municipio = '';

                                this.tipoAccion = 1;
                                break;
                            }
                            case 'actualizar':
                            {
                                // console.log(data);
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
                                this.telefono1 = data['telefono1'];
                                this.email = data['email'];
                                this.sexo =data['sexo'];
                                this.regimen =data['regimen'];
                                this.fec_nac =data['fec_nac'];
                                this.reside =data['reside'];
                                this.representante =data['email'];
                                this.entidad =data['entidad'];
                                this.digito_verif =data['digito_verif'];
                                this.num_verif =data['num_verif'];
                                this.autoretenedor = data['autoretenedor'];
                                this.declarante = data['declarante'];
                                this.cliente = data['cliente'];
                                this.proveedor = data['proveedor'];
                                this.id_vendedor = data['id_vendedor'];
                                this.id_zona = data['id_zona'];
                                this.plazo_pago = data['plazo_pago'];
                                this.bloquear = data['bloquear'];
                                this.cupo_credito = data['cupo_credito'];
                                this.retenedor_fuente = data['retenedor_fuente'];
                                this.retenedor_iva = data['retenedor_iva'];
                                this.excluido_iva = data['excluido_iva'];
                                this.autoretefuente = data['autoretefuente'];
                                this.autoreteiva = data['autoreteiva'];
                                this.autoreteica = data['autoreteica'];
                                this.id_banco = data['id_banco'];
                                this.num_cuenta_banco = data['num_cuenta_banco'];
                                this.tipo_cuenta = data['tipo_cuenta'];
                                this.representante_cuenta = data['representante_cuenta'];
                                this.tipo_nacionalidad = data['tipo_nacionalidad'];
                                this.departamento = data['departamento'];
                                this.municipio = data['municipio'];

                                this.listarMunicipios(this.departamento);
                                
                                break;
                            }
                            case 'cliente':{
                                this.modal2=1;
                                this.tituloModal2='Información adicional Cliente';
                                this.tipoAccion2 = 1;
                                break;
                            }
                            case 'proveedor': {
                                this.modal2=1;
                                this.tituloModal2='Información adicional Cliente';
                                this.tipoAccion2 = 2;
                                break;
                            }
                            case 'novedades':{
                                this.modal3 = 1;
                                this.tituloModal3 = 'Novedades';
                                this.persona_id=data['id'];
                                this.listarNovedades(data['id']);
                            }
                        }
                        break;
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
