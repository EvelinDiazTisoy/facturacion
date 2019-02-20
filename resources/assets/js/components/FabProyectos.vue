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
                    <i class="fa fa-align-justify"></i> Proyectos
                    
                </div>
                <template v-if="listado==1">
                    <div class="card-body">
                        <div class="form-group row">
                            <div class="col-md-7">
                                <div class="input-group">
                                    <select class="form-control col-md-5" v-model="criterio">
                                        <option value="nom_proyecto">Nombre Proyecto</option>
                                        <option value="id">Numero Proyecto</option>                                    
                                    </select>
                                    <input type="text" v-model="buscar" @keyup.enter="listarProyecto(1,buscar,criterio)" class="form-control" placeholder="Texto a buscar">
                                    <button type="submit" @click="listarProyecto(1,buscar,criterio)" class="btn btn-primary"><i class="fa fa-search"></i> Buscar</button>
                                </div>                               
                            </div>
                            <div class="col-md-5">
                                <div class="input-group">
                                    <button type="button" @click="nuevoProyecto()" class="btn btn-secondary">
                                        <i class="icon-plus"></i>&nbsp;Nuevo
                                    </button>
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-striped table-sm">
                            <thead>
                                <tr>
                                    <th>Numero</th>
                                    <th>Proyecto</th>
                                    <th>Cliente</th>
                                    <th>Fecha</th>
                                    <th>Estado</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="proyecto in arrayProyectos" :key="proyecto.id">
                                    
                                    <td v-text="proyecto.id"></td>
                                    <td v-text="proyecto.nom_proyecto"></td>
                                    <td v-if="proyecto.nombre" >
                                        {{ proyecto.num_documento +" - "+proyecto.nombre }}
                                    </td>
                                    <td v-else>
                                        {{ proyecto.num_documento +" - "+proyecto.nombre1 + " "+ proyecto.nombre2+" "+proyecto.apellido1+" "+proyecto.apellido2 }}
                                    </td>
                                    <td v-text="proyecto.fecha"></td>
                                    
                                    <td>
                                        <div v-if="proyecto.condicion==1">
                                            <span class="badge badge-warning">Por fallar</span>
                                        </div>
                                        <div v-if="proyecto.condicion==0">
                                            <span class="badge badge-danger">Cancelado</span>
                                        </div>    
                                        <div v-if="proyecto.condicion==2">
                                            <span class="badge badge-success">Finalizado</span>
                                        </div>                                
                                    </td>
                                    <td>
                                        <button type="button" @click="editarPoryecto(proyecto)" class="btn btn-warning btn-sm">
                                            <i class="icon-pencil"></i>
                                        </button> &nbsp;
                                        <template v-if="proyecto.condicion==1">
                                            <button type="button" class="btn btn-danger btn-sm" @click="desactivarProyecto(proyecto.id)">
                                                <i class="icon-trash"></i>
                                            </button>
                                        </template>
                                        <template v-if="proyecto.condicion==0">
                                            <button type="button" class="btn btn-info btn-sm" @click="activarProyecto(proyecto.id)">
                                                <i class="icon-check"></i>
                                            </button>
                                        </template>
                                        <template v-if="proyecto.condicion==1">
                                            <button title="Registro de Muestras"
                                                type="button" class="btn btn-success btn-sm" @click="registrarMuestras(proyecto.id,proyecto.nom_proyecto)">
                                                <i class="icon-calendar"></i>
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
                <template v-if="listado==0">
                    <div class="card-body">                        
                        <div class="form-group row border">
                            <div class="col-md-2    ">
                                <label style='margin-top: 3px;'><b>Proyecto*</b></label>                                
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">                                    
                                    <input type="text" class="form-control" v-model="nom_proyecto">
                                </div>
                            </div>
                            <div class="col-md-1 ">
                                <label style='margin-top: 3px;'><b>Fecha*</b></label>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">                                    
                                    <input type="date" class="form-control" v-model="fecha">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <label><b>Cliente*</b></label>
                            </div>
                            <div style="    margin-bottom: 4px;" class="col-md-6" id="div_select_sup">
                                <v-select
                                        id="selectCliente"
                                        :on-search="selectCliente"
                                        label="nom_y_ced"
                                        :options="arrayCliente"
                                        placeholder="Buscar Cliente..."
                                        :onChange="getDatosCliente"                                        
                                    >
                                </v-select>
                            </div>
                            <div class="col-md-4">
                            </div> 
                            <div class="col-md-12">
                                <div v-show="errorFabProyectos" class="form-group row div-error">
                                    <div class="text-center text-error">
                                        <div v-for="error in errorMostrarMsjFabProyectos" :key="error" v-text="error">

                                        </div>
                                    </div>
                                </div>
                            </div>                           
                        </div>
                        
                        <div class="form-group row">
                            <div class="col-md-12">
                                <button type="button" @click="ocultarNew()" class="btn btn-secondary">Cancelar</button>
                                <button v-if="editar==0" type="button" class="btn btn-primary" @click="registrarProyecto()">Registrar Proyecto</button>
                                <button v-if="editar==1" type="button" class="btn btn-primary" @click="actualizarProyecto()">Actualizar Proyecto</button>
                            </div>
                        </div>
                    </div>
                </template>
                <template v-if="listado==2">
                    <div class="card-body">
                        <div class="form-group row ">
                            <div class="col-md-12">
                                <h4 class="modal-title">Muestras Proyecto : {{ nom_proyecto }}</h4> 
                            </div>
                            <div class="col-md-12">
                                <button type="button" @click="ocultarNew()" class="btn btn-secondary">Regresar</button>
                                <button type="button" @click="nuevaMuestra()" class="btn btn-primary">
                                    <i class="icon-plus"></i>&nbsp;Nueva Muestra
                                </button>
                                <button type="button" @click="avance()" class="btn btn-success">Avance</button>
                            </div>
                            
                        </div>
                        <table style="    font-size: 12px !important;" class="table table-bordered table-striped table-sm">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>leyenda</th>
                                    <th>Resistencia a Diseño</th>
                                    <th>Diametro Cilindro</th>
                                    <th>Fecha Entrada</th>
                                    <th>Fecha Toma</th>
                                    <th>Estado</th>
                                    <th>Opciones</th>                                    
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="muestra in arrayMuestras" :key="muestra.id">                          
                                    <td v-text="muestra.num_muestra"></td>
                                    <td v-text="muestra.leyenda"></td>
                                    <td v-text="muestra.resist_dise">{{ muestra.resist_dise+" "+muestra.medida_resistencia }}</td>
                                    <td v-text="muestra.diametro_cilindro"></td>
                                    <td v-text="muestra.fec_entra"></td>
                                    <td v-text="muestra.fec_muestra"></td>
                                     <td>
                                        <div v-if="muestra.condicion==1&& muestra.por_fallar==0">
                                            <span class="badge badge-success">Activo</span>
                                        </div>
                                        <div v-if="muestra.condicion==0">
                                            <span class="badge badge-danger">Desactivado</span>
                                        </div>   
                                        <div v-if="muestra.por_fallar==1">
                                            <span class="badge badge-warning">Por Fallar</span>
                                        </div>                                     
                                    </td>
                                    <td>
                                        <button v-if="muestra.condicion==1" type="button" @click="editarMuestra(muestra)" class="btn btn-warning btn-sm"><i class="icon-pencil"></i>
                                        </button> &nbsp;
                                        <button v-if="muestra.condicion==1" title="Registro de Muestras"
                                            type="button" class="btn btn-success btn-sm" @click="cilindros(muestra.id,muestra.fec_muestra)">
                                            <i class="icon-list"></i>
                                        </button>
                                        <template v-if="muestra.condicion==1">
                                            <button type="button" class="btn btn-danger btn-sm" @click="desactivarMuestra(muestra.id)">
                                                <i class="icon-trash"></i>
                                            </button>
                                        </template>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        
                    </div>
                </template>
                <template v-if="listado==3">
                    <div class="card-body">                        
                        <div class="form-group row border">
                            <div class="col-md-2    ">
                                <label style='margin-top: 3px;'><b>Leyenda*</b></label>                                
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">                                    
                                    <input type="text" class="form-control" v-model="leyenda">
                                </div>
                            </div>
                            <div class="col-md-1    "></div>
                            <div class="col-md-2    ">
                                <label style='margin-top: 3px;'><b>Resistencia*</b></label>                                
                            </div>
                            
                            <div class="col-md-2">
                                <div class="form-group">                                    
                                    <input type="number" class="form-control" v-model="resist_dise">
                                </div>
                            </div>
                            <div class="col-md-3    "></div>
                            
                            <div class="col-md-2    ">
                                <label style='margin-top: 3px;'><b>Und Resistencia*</b></label>                                
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">                                    
                                    <select class="form-control" v-model="medida_resistencia">
                                        <option value="PSI">PSI</option>
                                        <option value=" kg/cm2"> kg/cm2</option>                                    
                                        <option value="MPa">MPa</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-1    "></div>
                            <div class="col-md-2    ">
                                <label style='margin-top: 3px;'><b>Diametro Cilindro*</b></label>                                
                            </div>
                            
                            <div class="col-md-2">
                                <div class="form-group">                                    
                                    <input type="number" class="form-control" v-model="diametro_cilindro">
                                </div>
                            </div>
                            <div class="col-md-3    "></div>
                            <div class="col-md-2 ">
                                <label style='margin-top: 3px;'><b>Fecha de Entrada*</b></label> 
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">                                    
                                    <input type="date" class="form-control" v-model="fec_entra">
                                </div>
                            </div>
                            <div class="col-md-2 ">
                                <label style='margin-top: 3px;'><b>Fecha de Toma*</b></label> 
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">                                    
                                    <input type="date" class="form-control" v-model="fec_muestra">
                                </div>
                            </div>
                            
                            <div class="col-md-2">
                            </div> 
                            <div class="col-md-2">
                                <label style='margin-top: 3px;'><b>Descripcion</b></label>
                            </div>
                            <div class="col-md-10">
                                <div class="form-group">                                    
                                    <input type="text" class="form-control" v-model="descripcion">
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div v-show="errorFabMuestras" class="form-group row div-error">
                                    <div class="text-center text-error">
                                        <div v-for="error in errorMostrarMsjFabMuestras" :key="error" v-text="error">

                                        </div>
                                    </div>
                                </div>
                            </div>                           
                        </div>
                        
                        <div class="form-group row">
                            <div class="col-md-12">
                                <button type="button" @click="ocultarNewMuestra()" class="btn btn-secondary">Cancelar</button>
                                <button v-if="editar_muestra==0" type="button" class="btn btn-primary" @click="guardarMuestra()">Registrar Muestra</button>
                                <button v-if="editar_muestra==1" type="button" class="btn btn-primary" @click="actualizarMuestra()">Actualizar Muestra</button>
                            </div>
                        </div>
                    </div>
                </template>
                <template v-if="listado==4">
                    <div class="card-body">
                        <div class="form-group row ">
                            <div class="col-md-12">
                                <h4 class="modal-title">Avance : {{ nom_proyecto }}</h4> 
                            </div>
                            <div class="col-md-12">
                                <button type="button" @click="regresar_muestras()" class="btn btn-secondary">Regresar</button>
                                
                            </div>
                            
                        </div>
                        <table style="    font-size: 12px !important;" class="table table-bordered table-striped table-sm"
                        id="tabla_a">
                            <tr align="center">
                                <td rowspan='2'><span style='writing-mode: vertical-lr;transform: rotate(180deg);'># Cilindros</span></td> 
                                <td rowspan='2'>Descripción</td><td :colspan="num_cols_a">RESULTADO A COMPRESION (PSI)</td>
                            </tr>
                            <tr id="cabeza_a" align="center"></tr>
                            
                        </table>
                    </div>
                </template>
            </div>                  
        </div>
        <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal}" role="dialog" aria-labelledby="myModalLabel" style="display: none; overflow: visible !important;" aria-hidden="true">
            <div style="    position: fixed;top: 110px; left: 20em;" class="modal-dialog modal-primary modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" v-text="tituloModal"></h4>
                        <button type="button" class="close" @click="cerrarModal()" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group row">
                            <div class="col-md-12">
                                <table border='0'>
                                    <tr>
                                        <td><label ><b>Fecha Toma:</b></label></td>
                                        <td><label>{{ aux_fec_muestra }}</label>&nbsp;&nbsp;&nbsp;</td>
                                        <td><label ><b>No. de Cilindros</b></label></td>
                                        <td>
                                            <select style=" margin-right: 10px; max-width: 60px; position: relative;margin-top: 11px;" class="form-control" v-model="num_cilindros" >        
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                            </select> 
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <label ><b>Dias</b></label>
                                        </td>
                                        <td>
                                            <input v-on:change="calcularFecha()" type="number" max="45" min="1" 
                                            style=" margin-right: 10px; max-width: 60px; position: relative;margin-top: 11px;"
                                            class="form-control" v-model="dias">
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <label ><b>Fecha a los dias:</b></label>
                                        </td>
                                        <td>
                                            <label>{{ fecha_cilindro }}</label>
                                        </td>
                                        <td>
                                            <button v-if="editar_cilindro==0" title="Agregar Cilindros" type="button" class="btn btn-success btn-sm" @click="guardarCilindro()">
                                                Agregar Cilindro
                                            </button>
                                            <button v-if="editar_cilindro==1" title="Agregar Cilindros" type="button" class="btn btn-primary btn-sm"
                                            @click="actualizarCilindro()">
                                                Actualizar Cilindro
                                            </button>
                                            <button title="Agregar Cilindros" type="button" class="btn btn-warning btn-sm"
                                            @click="cancelar_cilindro()">
                                                Cancelar
                                            </button>   
                                        </td> 
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="col-md-12">
                                <div v-show="errorFabCilindros" class="form-group row div-error">
                                    <div class="text-center text-error">
                                        <div v-for="error in errorMostrarMsjFabCilindros" :key="error" v-text="error">

                                        </div>
                                    </div>
                                </div>
                            </div>
                        <div style="    margin-top: -20px !important;" class="form-group row">
                            <div class="col-md-12">
                                <table border="1">
                                    <tr>
                                        <th v-if="num_cilindros>=1"><b># Cilindro1</b></th>
                                        <th v-if="num_cilindros>=1">R #1</th>
                                        <th v-if="num_cilindros>=2"><b># Cilindro2</b></th>
                                        <th v-if="num_cilindros>=2">R #2</th>
                                        <th v-if="num_cilindros>=3"><b># Cilindro3</b></th>
                                        <th v-if="num_cilindros>=3">R #3</th>
                                        <th v-if="num_cilindros>=4"><b># Cilindro4</b></th>
                                        <th v-if="num_cilindros>=4">R #4</th>
                                        <th v-if="num_cilindros>=5"><b># Cilindro5</b></th>
                                        <th v-if="num_cilindros>=5">R #5</th>
                                        <th v-if="num_cilindros>=6"><b># Cilindro6</b></th>
                                        <th v-if="num_cilindros>=6">R #6</th>
                                    </tr>
                                    <tr>
                                        <td v-if="num_cilindros>=1">
                                            <input style="max-width: 100px;" type="text" class="form-control" v-model="nom_cilindro">
                                        </td>
                                        <td v-if="num_cilindros>=1">
                                            <input type="number" style="max-width: 90px;" class="form-control" v-model="res_cilindro">
                                        </td>
                                        <td v-if="num_cilindros>=2">
                                            <input style="max-width: 100px;" type="text" class="form-control" v-model="nom_cilindro2">
                                        </td>
                                        <td v-if="num_cilindros>=2">
                                            <input type="number" style="max-width: 90px;" class="form-control" v-model="res_cilindro2">
                                        </td>
                                        <td v-if="num_cilindros>=3">
                                            <input style="max-width: 100px;" type="text" class="form-control" v-model="nom_cilindro3">
                                        </td>
                                        <td v-if="num_cilindros>=3">
                                            <input type="number" style="max-width: 90px;" class="form-control" v-model="res_cilindro3">
                                        </td>
                                        <td v-if="num_cilindros>=4">
                                            <input style="max-width: 100px;" type="text" class="form-control" v-model="nom_cilindro4">
                                        </td>
                                        <td v-if="num_cilindros>=4">
                                            <input type="number" style="max-width: 90px;" class="form-control" v-model="res_cilindro4">
                                        </td>
                                        <td v-if="num_cilindros>=5">
                                            <input style="max-width: 100px;" type="text" class="form-control" v-model="nom_cilindro5">
                                        </td>
                                        <td v-if="num_cilindros>=5">
                                            <input type="number" style="max-width: 90px;" class="form-control" v-model="res_cilindro5">
                                        </td>
                                        <td v-if="num_cilindros>=6">
                                            <input style="max-width: 100px;" type="text" class="form-control" v-model="nom_cilindro6">
                                        </td>
                                        <td v-if="num_cilindros>=6">
                                            <input type="number" style="max-width: 90px;" class="form-control" v-model="res_cilindro6">
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                       
                        <div class="table-responsive">                           
                                
                                    <!--<tr v-for="arrayCilindro in arrayCilindros" >-->
                            <div class="form-group row">
                                <div class="col-md-12" v-for="(arrayCilindro, index) in arrayCilindros" >
                                    <b><center>A {{ index }} Dias {{ arrayCilindro[0] }}</center></b>
                                    <!--<center>A {{ arrayCilindro }} Dias</center>-->
                                    <table style="font-size: 12px !important;" class="table table-bordered table-striped table-sm">
                                        <tr>
                                            <th style="width: 90px !important;" >Fecha Rotura</th>
                                            <th style="width: 90px !important;"># Cilindro</th>
                                            <th style="width: 80px !important;">R #1</th>
                                            <th v-if=" arrayCilindro[1].nom_cilindro2 " style="width: 90px !important;">
                                                # Cilindro</th>
                                            <th v-if=" arrayCilindro[1].nom_cilindro2 " style="width: 90px !important;">
                                                R # 2</th>
                                            <th v-if=" arrayCilindro[1].nom_cilindro3 " style="width: 90px !important;">
                                                # Cilindro</th>
                                            <th v-if=" arrayCilindro[1].nom_cilindro3 " style="width: 90px !important;">
                                                R # 3</th>
                                            <th v-if=" arrayCilindro[1].nom_cilindro4 " style="width: 90px !important;">
                                                # Cilindro</th>
                                            <th v-if=" arrayCilindro[1].nom_cilindro4 " style="width: 90px !important;">
                                                R # 4</th>
                                            <th v-if=" arrayCilindro[1].nom_cilindro5 " style="width: 90px !important;">
                                                # Cilindro</th>
                                            <th v-if=" arrayCilindro[1].nom_cilindro5 " style="width: 90px !important;">
                                                R # 5</th>
                                            <th v-if=" arrayCilindro[1].nom_cilindro6 " style="width: 90px !important;">
                                                # Cilindro</th>
                                            <th v-if=" arrayCilindro[1].nom_cilindro6 " style="width: 90px !important;">
                                                R # 6</th>
                                            <th rowspan="2">
                                                <button style="float: right; position: relative;top: 0.2em; right: 0.5em;"
                                                class="btn btn-success btn-sm" title="Editar Cilindro" @click="editarCilindro(arrayCilindro[1])"> <i class="icon-pencil"></i></button>
                                            </th>
                                        </tr>
                                        <tr>
                                            <td>{{ arrayCilindro[1].fecha_cilindro }}</td>

                                            <!-- cilindro1-->
                                            <td>{{ arrayCilindro[1].nom_cilindro }}</td>                                    
                                            <td v-if="arrayCilindro[1].res_cilindro">
                                                {{ arrayCilindro[1].res_cilindro }}
                                            </td>
                                            <td v-if="!arrayCilindro[1].res_cilindro" style="background-color: red;"> - </td> 
                                            <!-- cilindro2-->
                                            <td v-if="arrayCilindro[1].nom_cilindro2">
                                                {{ arrayCilindro[1].nom_cilindro2 }} 
                                            </td>
                                            
                                            <td v-if="arrayCilindro[1].nom_cilindro2 && arrayCilindro[1].res_cilindro2">
                                                {{ arrayCilindro[1].res_cilindro2 }} 
                                            </td>                    

                                            <td v-if="arrayCilindro[1].nom_cilindro2 && !arrayCilindro[1].res_cilindro2" style="background-color: red;"> - </td>                        
                                            
                                            <!-- cilindro3-->
                                            <td v-if="arrayCilindro[1].nom_cilindro3">
                                                {{ arrayCilindro[1].nom_cilindro3 }} 
                                            </td>
                                            
                                            <td v-if="arrayCilindro[1].nom_cilindro3 && arrayCilindro[1].res_cilindro3">
                                                {{ arrayCilindro[1].res_cilindro3 }} 
                                            </td>                    

                                            <td v-if="arrayCilindro[1].nom_cilindro3 && !arrayCilindro[1].res_cilindro3" style="background-color: red;"> - </td> 

                                           
                                        </tr>
                                    </table> 
                                </div>
                                
                            </div>                            
                        </div>
                    </div> 
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" @click="cerrarModal()">Cerrar</button>
                        
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
    </main>                   
</template>

<script>
    import vSelect from 'vue-select';
    export default {
        props : ['ruta'],
        data (){
            return {
                
                id_proyecto: 0,
                nom_proyecto : '',
                nom_completo : '',
                id_tercero: '',
                doc_tercero: '',
                listado: 1,
                descripcion : '',
                fecha: '',
                arrayProyectos : [],
                arrayCliente: [],
                modal : 0,
                editar : 0,
                editar_muestra: '',
                editar_cilindro: 0,
                tituloModal : '',
                tipoAccion : 0,
                errorFabProyectos : 0,
                errorFabMuestras: 0,
                errorFabCilindros: 0,
                errorMostrarMsjFabProyectos : [],
                errorMostrarMsjFabMuestras : [],
                errorMostrarMsjFabCilindros : [],
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
                tituloModal: '',
                leyenda: '',
                num_muestra: '',
                arrayMuestras: [],
                arrayCilindros: [],
                encab_a: [],
                arrayLista_a: [],
                fecha_toma_cilindro: '',
                fec_toma:'',
                fec_entra:'',
                fec_muestra: '',
                id_muestra: '',
                nom_cilindro: '',
                res_cilindro:'',                
                nom_cilindro2: '',
                res_cilindro2:'',
                nom_cilindro3: '',
                res_cilindro3:'',
                nom_cilindro4: '',
                res_cilindro4:'',
                nom_cilindro5: '',
                res_cilindro5:'',
                nom_cilindro6: '',
                res_cilindro6:'',
                aux_fec_muestra: '',
                num_cilindros: 1,
                medida_resistencia: '',
                dias: '',
                diametro_cilindro:'',
                resist_dise:'',
                fecha_cilindro: '',
                id_cilindro: '',
                condicion:'',
                condicion_muestra:'',
                condicion_cilindro:'',
                tabla_avance: '',
                num_cols_a:'2',

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
            
        },
        methods : {
            padNumber(number) {
                var string  = '' + number;
                string      = string.length < 2 ? '0' + string : string;
                return string;
            },
            listarProyecto(page,buscar,criterio){
                let me=this;
                var url= this.ruta +'/fab_proyectos?page=' + page + '&buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayProyectos = respuesta.proyectos.data;
                    me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            getDatosCliente(val1){
                let me = this;
                me.loading = true;
                if(val1){
                    me.id_tercero = val1.id;
                    me.doc_tercero = val1.num_documento;
                    //me.nom_completo = val1.
                }
                else{
                    me.id_tercero = "";
                }
                //console.log("pasa");
            },
            nuevoProyecto(){
                let me=this;                
                me.listado=0;                
            },
            nuevaMuestra(){
                let me=this;                
                me.listado=3;
            },
            ocultarNew(){
                let me=this;                
                me.listado=1;
                me.editar=0;
                me.listarMuestras(me.id_proyecto);
            },
            ocultarNewMuestra(){
                let me=this;                
                me.listado=2;
                me.editar_muestra=0;
                me.aux_fec_muestra='';
            },
            cambiarPagina(page,buscar,criterio){
                let me = this;
                //Actualiza la página actual
                me.pagination.current_page = page;
                //Envia la petición para visualizar la data de esa página
                me.listarProyecto(page,buscar,criterio);
            },
            selectCliente(search,loading){
                let me=this;
                loading(true)

                var url= this.ruta +'/cliente/selectCliente?filtro='+search;
                axios.get(url).then(function (response) {
                    let respuesta = response.data;
                    q: search
                    me.arrayCliente=respuesta.clientes;
                    loading(false)
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            registrarProyecto(){
                if (this.validarProyecto()){
                    return;
                }
                
                let me = this;

                axios.post(this.ruta +'/fab_proyectos/registrar',{                    
                    'nom_proyecto': this.nom_proyecto,
                    'cliente': this.id_tercero,
                    'fecha': this.fecha                    
                }).then(function (response) {
                    me.listado=1;
                    me.id_tercero='';
                    me.nom_proyecto='';
                    me.listarProyecto(1,'','nom_proyecto');
                }).catch(function (error) {
                    console.log(error);
                }); 
            },
            actualizarProyecto(){
               if (this.validarProyecto()){ return; }
                
                let me = this;

                axios.put(this.ruta +'/fab_proyectos/actualizar',{
                    'nom_proyecto': this.nom_proyecto,
                    'cliente': this.id_tercero,
                    'fecha': this.fecha,
                    'id': this.id_proyecto
                }).then(function (response) {
                    me.cerrarModal();
                    me.listado=1;
                    me.id_tercero='';
                    me.nom_proyecto='';
                    me.id_proyecto = '';
                    me.listarProyecto(1,'','nom_proyecto');
                }).catch(function (error) {
                    console.log(error);
                }); 
            },
            validarProyecto(){
                this.errorFabProyectos=0;
                this.errorMostrarMsjFabProyectos =[];

                if (this.nom_proyecto==0) this.errorMostrarMsjFabProyectos.push("Debe digitar el nombre del proyecto.");
                if (!this.id_tercero) this.errorMostrarMsjFabProyectos.push("Debe seleccionar el Cliente.");
                if (!this.fecha) this.errorMostrarMsjFabProyectos.push("Debe seleccionar la fecha");
                
                if (this.errorMostrarMsjFabProyectos.length) this.errorFabProyectos = 1;

                return this.errorFabProyectos;
            },
            desactivarProyecto(id){
                swal({
                    title: 'Esta seguro de desactivar este proyecto?',
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

                        axios.put(this.ruta +'/fab_proyectos/desactivar',{
                            'id': id
                        }).then(function (response) {
                            me.listarProyecto(1,'','nom_proyecto');
                            swal(
                            'Desactivado!',
                            'El proyecto ha sido desactivado con éxito.',
                            'success'
                            )
                        }).catch(function (error) {
                            console.log(error);
                        });
                        
                        
                    } else if ( result.dismiss === swal.DismissReason.cancel) 
                    { }
                }) 
            },
            desactivarMuestra(id){
                swal({
                    title: 'Esta seguro de eliminar esta muestra?',
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

                        axios.put(this.ruta +'/fab_muestras/desactivar',{
                            'id': id
                        }).then(function (response) {
                            me.listarMuestras(me.id_proyecto);
                            swal(
                            'Desactivado!',
                            'La muestra ha sido eliminada con éxito.',
                            'success'
                            )
                        }).catch(function (error) {
                            console.log(error);
                        });
                        
                        
                    } else if ( result.dismiss === swal.DismissReason.cancel) 
                    { }
                }) 
            },
            selectCliente2(id,nombre_cliente){
                let me=this;
                //console.
                var url= this.ruta +'/cliente/selectCliente?filtro=';
                axios.get(url).then(function (response) {
                    let respuesta = response.data;
                    //q: search
                    me.arrayCliente=respuesta.clientes;
                    me.id_tercero = id;

                    var auxiliar = document;
                    var mylist = auxiliar.getElementById('selectCliente');
                    var listitems= mylist.getElementsByClassName("form-control");
                    if(me.arrayCliente[id]['nombre']){
                        listitems[0].value= me.arrayCliente[id]['nombre']+" - "+me.arrayCliente[id]['num_documento'];
                    }else{ 
                        listitems[0].value = me.arrayCliente[id]['nombre1']+" "+me.arrayCliente[id]['nombre2']+" "+me.arrayCliente[id]['apellido1']+" "+" - "+me.arrayCliente[id]['apellido2']+" "+me.arrayCliente[id]['num_documento'];
                    }
                    //console.log (listitems[0]);
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            editarPoryecto(data){
                let me = this;
                me.listado=0;
                me.editar=1;           

                me.id_tercero=data['id'];
                me.nom_proyecto=data['nom_proyecto'];
                me.fecha=data['fecha'];
                //me.nombre = data['nombre'];                
                console.log(data);
                this.selectCliente2(me.id_tercero,data['nombre']);
                
                //listitems= mylist.getElementsByClassName("form-control");
                //var mylist = document.getElementById("#div_select_sup").value;
                

               //
            },
            activarProyecto(id){
               swal({
                title: 'Esta seguro de activar este proyecto?',
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

                    axios.put(this.ruta +'/fab_proyectos/activar',{
                        'id': id
                    }).then(function (response) {
                        me.listarProyecto(1,'','nom_proyecto');
                        swal(
                        'Activado!',
                        'El proyecto ha sido activado con éxito.',
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
            listarMuestras(id){
                //console.log("id muesra = " + id);
                let me=this;
                var url= this.ruta +'/fab_muestras?id=' + id;
                axios.get(url).then(function (response) {
                    //console.log(response.data);
                    var respuesta= response;
                    //console.log(respuesta.data.muestras);
                    me.arrayMuestras = respuesta.data.muestras;                    
                })
                .catch(function (error) {
                    console.log(error);
                });
                me.aux_fec_muestra='';
            },
            registrarMuestras(id,nombre){
                let me=this;                
                me.listado=2;
                me.nom_proyecto = nombre;
                me.id_proyecto = id;
                me.editar_muestra = 0;
                this.listarMuestras(id);

            },
            validarMuestra(){
                this.errorFabMuestras=0;
                this.errorMostrarMsjFabMuestras =[];

                if (!this.leyenda) this.errorMostrarMsjFabMuestras.push("Debe digitar la leyenda de la muestra.");                
                if (!this.diametro_cilindro) this.errorMostrarMsjFabMuestras.push("Debe digitar el diamentro del cilindro");
                if (!this.resist_dise) this.errorMostrarMsjFabMuestras.push("Debe digitar la resistencia a diseño.");
                if (!this.fec_entra) this.errorMostrarMsjFabMuestras.push("Debe seleccionar la fecha de entrada.");
                if (!this.fec_muestra) this.errorMostrarMsjFabMuestras.push("Debe seleccionar la fecha de toma.");
                if (this.errorMostrarMsjFabMuestras.length) this.errorFabMuestras = 1;

                return this.errorFabProyectos;
            },
            guardarMuestra(){
                if (this.validarMuestra()){
                    return;
                }                
               // console.log("llega por aca");
                let me = this;
                 
                
                axios.post(this.ruta +'/fab_muestras/registrar',{                    
                    'id_proyecto' : this.id_proyecto,
                    'leyenda': this.leyenda,
                    'resist_dise': this.resist_dise,
                    'diametro_cilindro': this.diametro_cilindro,
                    'fec_entra' : this.fec_entra,
                    'fec_muestra' : this.fec_muestra,
                    'medida_resistencia' : this.medida_resistencia,
                    'descripcion' : this.descripcion

                }).then(function (response) {
                   
                    me.leyenda='';
                    me.resist_dise='';
                    me.diametro_cilindro='';
                    me.fec_entra='';
                    me.fec_muestra='';
                    me.medida_resistencia='';
                    me.descripcion='';
                    me.listado=2;
                    me.listarMuestras(me.id_proyecto);
                }).catch(function (error) {
                    console.log("fallo");
                });                 
                me.listarMuestras(me.id_proyecto);
            },
            cerrarModal(){
                let me=this;
                this.modal=0;
                this.aux_fec_muestra = '';
                this.tituloModal='';
                this.id_muestra='';
                this.editar_cilindro='';
                me.num_cilindros=1
                me.dias=1;
                me.nom_cilindro="";
                me.res_cilindro="";
                me.nom_cilindro2="";
                me.res_cilindro2="";
                me.nom_cilindro3="";
                me.res_cilindro3="";
                me.nom_cilindro4="";
                me.res_cilindro4="";
                me.nom_cilindro5="";
                me.res_cilindro5="";
                me.nom_cilindro6="";
                me.res_cilindro6="";
                me.listarMuestras(me.id_proyecto);
            },
            listar_cilindros(id_muestra){
                let me=this;
                var url=this.ruta +'/fab_Cilindros?id=' + me.id_proyecto + '&id_muestra='+id_muestra;
                axios.get(url).then(function (response) {
                    //console.log(response.data);
                    var respuesta= response;
                    //console.log(respuesta.data.muestras);
                    me.arrayCilindros = respuesta.data.cilindros;                    
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            cilindros(id,fecha_muestra){
                let me=this;    
                this.arrayCilindros=[];
                this.tituloModal = 'Cilindros';
                this.modal = 1;  
                this.listar_cilindros(id);
                this.aux_fec_muestra = fecha_muestra;
                this.dias=1;
                this.id_muestra=id;
                this.calcularFecha();
            },
            cancelar_cilindro(){
                let me=this; 
                me.id_cilindro = '';
                me.num_cilindros=1
                me.dias=1;
                me.editar_cilindro=0;
                
                me.nom_cilindro="";
                me.res_cilindro="";
                me.nom_cilindro2="";
                me.res_cilindro2="";
                me.nom_cilindro3="";
                me.res_cilindro3="";
                me.nom_cilindro4="";
                me.res_cilindro4="";
                me.nom_cilindro5="";
                me.res_cilindro5="";
                me.nom_cilindro6="";
                me.res_cilindro6="";
                me.descripcion="";
            },
            avance(){
                let me=this;                
                //me.listado=4;   
                //var tds ="";
                var id_proyecto = me.id_proyecto;
                window.open(this.ruta +'/fab_proyectos/avance?id='+ id_proyecto  );
                /*
                var url= '/fab_proyectos/avance?id=' + me.id_proyecto ;
                axios.get(url).then(function (response) {
                    //console.log(response.data);
                    var respuesta= response;
                    var lis = respuesta.data.cabeza;
                    //console.log(respuesta.data.muestras);
                    //me.tabla_avance = respuesta.data.avance;  
                    me.num_cols_a =    respuesta.data.NumCols; 
                    var lista_a =  respuesta.data.cils;
                    lis.forEach(element => {
                        $("#cabeza_a").append("<td>"+element+"</td>");
                       //console.log (element)  ;
                    });
                    lista_a.forEach(element => {
                        tds="";
                        element.datos.forEach(elemt=>{
                            tds = tds +"<td>"+elemt+"</td>";
                        });
                        $("#tabla_a").append("<tr><td>"+element.n_cils+"</td><td>"+element.descrip+"</td>"+tds+"</tr>");
                        
                    });
                    //console.log (me.num_cols_a)  
                })
                .catch(function (error) {
                    console.log(error);
                });*/
            },
            regresar_muestras(){
                let me=this;                
                //$("#tabla_a").html(""); 
                $("#tabla_a").html("<tr align='center'><td rowspan='2'><span style='writing-mode: vertical-lr;transform: rotate(180deg);'># Cilindros</span></td><td rowspan='2'>Descripción</td><td :colspan='num_cols_a'>RESULTADO A COMPRESION (PSI)</td></tr><tr id='cabeza_a' align='center'></tr>");
                $("#tabla_a").hide();
                 listarMuestras(me.id_proyecto);
                
            },
            editarCilindro(cilindro)
            {
                //console.log(cilindro); 
                let me=this;                
                me.listado=2;               
                me.editar_cilindro = 1;
                me.id_cilindro = cilindro.id;
                me.num_cilindros=cilindro.num_cilindros;
                me.dias=cilindro.dias;
                me.nom_cilindro=cilindro.nom_cilindro;
                me.res_cilindro=cilindro.res_cilindro;
                me.nom_cilindro2=cilindro.nom_cilindro2;
                me.res_cilindro2=cilindro.res_cilindro2;
                me.nom_cilindro3=cilindro.nom_cilindro3;
                me.res_cilindro3=cilindro.res_cilindro3;
                me.nom_cilindro4=cilindro.nom_cilindro4;
                me.res_cilindro4=cilindro.res_cilindro4;
                me.nom_cilindro5=cilindro.nom_cilindro5;
                me.res_cilindro5=cilindro.res_cilindro5;
                me.nom_cilindro6=cilindro.nom_cilindro6;
                me.res_cilindro6=cilindro.res_cilindro6;
                me.descripcion=cilindro.descripcion;
                me.calcularFecha();
            },
            editarMuestra(muestra_e){
                let me = this;
                me.editar_muestra = 1;
                me.listado=3;
                me.id_muestra = muestra_e.id;
                me.leyenda = muestra_e.leyenda;
                me.resist_dise = muestra_e.resist_dise;
                me.medida_resistencia = muestra_e.medida_resistencia;
                me.diametro_cilindro = muestra_e.diametro_cilindro;
                me.fec_entra = muestra_e.fec_entra;
                me.fec_muestra = muestra_e.fec_muestra;
                me.descripcion = muestra_e.descripcion;
            },
            actualizarMuestra(){
                if (this.validarMuestra()){
                    return;
                }
                
                let me = this;
                axios.post(this.ruta +'/fab_muestras/actualizar',{                    
                    'id_proyecto' : this.id_proyecto,
                    'id' : this.id_muestra,
                    'leyenda': this.leyenda,
                    'resist_dise': this.resist_dise,
                    'diametro_cilindro': this.diametro_cilindro,
                    'fec_entra' : this.fec_entra,
                    'fec_muestra' : this.fec_muestra,
                    'medida_resistencia' : this.medida_resistencia,
                    'descripcion' : this.descripcion
                    
                    
                }).then(function (response) {
                    me.leyenda='';
                    me.id_muestra = '';
                    me.resist_dise='';
                    me.diametro_cilindro='';
                    me.fec_entra='';
                    me.fec_muestra='';
                    me.medida_resistencia='';
                    me.descripcion='';
                    me.listado=2;
                    me.listarMuestras(me.id_proyecto);
                }).catch(function (error) {
                    console.log(error);
                }); 
            },
            actualizarCilindro(){
                let me=this;
                
                if (this.validarCilindro()){ return;}

                axios.put(this.ruta +'/fab_Cilindros/actualizar_cilindro',{                    
                    'id_proyecto' : this.id_proyecto,
                    'id_muestra': this.id_muestra,
                    'id' : this.id_cilindro,
                    'dias' : this.dias,
                    'fecha_cilindro' : this.fecha_cilindro,
                    'num_cilindros': this.num_cilindros,
                    'nom_cilindro': this.nom_cilindro,
                    'res_cilindro' : this.res_cilindro,
                    'nom_cilindro2': this.nom_cilindro2,
                    'res_cilindro2' : this.res_cilindro2,
                    'nom_cilindro3': this.nom_cilindro3,
                    'res_cilindro3' : this.res_cilindro3,
                    'nom_cilindro4': this.nom_cilindro4,
                    'res_cilindro4' : this.res_cilindro4,
                    'nom_cilindro5': this.nom_cilindro5,
                    'res_cilindro5' : this.res_cilindro5,
                    'nom_cilindro6': this.nom_cilindro6,
                    'res_cilindro6' : this.res_cilindro6,

                }).then(function (response) {
                                      
                    me.num_cilindros=1
                    me.dias=1;
                    me.nom_cilindro="";
                    me.res_cilindro="";
                    me.nom_cilindro2="";
                    me.res_cilindro2="";
                    me.nom_cilindro3="";
                    me.res_cilindro3="";
                    me.nom_cilindro4="";
                    me.res_cilindro4="";
                    me.nom_cilindro5="";
                    me.res_cilindro5="";
                    me.nom_cilindro6="";
                    me.res_cilindro6="";
                    me.editar_cilindro=0;
                    me.descripcion="";
                    me.listar_cilindros(me.id_muestra);
                }).catch(function (error) {
                    console.log(error);
                });     

            },
            calcularFecha(){
                
                var aux_dias = parseInt(this.dias);
                var ayudante = "x";
                
                if(this.aux_fec_muestra)
                {
                    var myDate      = new Date(this.aux_fec_muestra);
                    var next_date = new Date(myDate.setDate(myDate.getDate() + aux_dias));
                    ayudante = next_date.getUTCFullYear() + '-' + this.padNumber(next_date.getUTCMonth() + 1) + '-' + this.padNumber(next_date.getUTCDate())
                   
                }
                console.log("ayudante = "+ayudante);
                
                this.fecha_cilindro = ayudante;
            },
            validarCilindro(){
                let me=this;
                me.errorFabCilindros=0;
                me.errorMostrarMsjFabCilindros =[];
                if(me.num_cilindros>=1){
                    if(me.nom_cilindro=="") 
                        this.errorMostrarMsjFabCilindros.push("Debe digitar la leyenda de todos los cilindros.");
                }
                if(me.num_cilindros>=2){
                    if(me.nom_cilindro2=="") 
                        this.errorMostrarMsjFabCilindros.push("Debe digitar la leyenda de todos los cilindros.");
                }
                if(me.num_cilindros>=3){
                    if(me.nom_cilindro3=="") 
                        this.errorMostrarMsjFabCilindros.push("Debe digitar la leyenda de todos los cilindros.");
                }
                if(me.num_cilindros>=4){
                    if(me.nom_cilindro4=="") 
                        this.errorMostrarMsjFabCilindros.push("Debe digitar la leyenda de todos los cilindros.");
                }
                if(me.num_cilindros>=5){
                    if(me.nom_cilindro5=="") 
                        this.errorMostrarMsjFabCilindros.push("Debe digitar la leyenda de todos los cilindros.");
                }
                if(me.num_cilindros>=6){
                    if(me.nom_cilindro6=="") 
                        this.errorMostrarMsjFabCilindros.push("Debe digitar la leyenda de todos los cilindros.");
                }

                if (this.errorMostrarMsjFabCilindros.length) this.errorFabCilindros = 1;

                return this.errorFabCilindros;
            },
            guardarCilindro(){
                let me=this;
                 if (this.validarCilindro()){
                    return;
                }
                axios.post(this.ruta +'/fab_Cilindros/registrar',{                    
                    'id_proyecto' : this.id_proyecto,
                    'id_muestra': this.id_muestra,
                    'dias' : this.dias,
                    'fecha_cilindro' : this.fecha_cilindro,
                    'num_cilindros': this.num_cilindros,
                    'nom_cilindro': this.nom_cilindro,
                    'res_cilindro' : this.res_cilindro,
                    'nom_cilindro2': this.nom_cilindro2,
                    'res_cilindro2' : this.res_cilindro2,
                    'nom_cilindro3': this.nom_cilindro3,
                    'res_cilindro3' : this.res_cilindro3,
                    'nom_cilindro4': this.nom_cilindro4,
                    'res_cilindro4' : this.res_cilindro4,
                    'nom_cilindro5': this.nom_cilindro5,
                    'res_cilindro5' : this.res_cilindro5,
                    'nom_cilindro6': this.nom_cilindro6,
                    'res_cilindro6' : this.res_cilindro6,

                }).then(function (response) {
                                      
                    me.num_cilindros=1
                    me.dias=1;
                    me.nom_cilindro="";
                    me.res_cilindro="";
                    me.nom_cilindro2="";
                    me.res_cilindro2="";
                    me.nom_cilindro3="";
                    me.res_cilindro3="";
                    me.nom_cilindro4="";
                    me.res_cilindro4="";
                    me.nom_cilindro5="";
                    me.res_cilindro5="";
                    me.nom_cilindro6="";
                    me.res_cilindro6="";
                    me.descripcion="";
                    me.listar_cilindros(me.id_muestra);
                }).catch(function (error) {
                    console.log(error);
                });                 
                //me.listarMuestras(me.id_proyecto);
                //me.arrayCilindros.push(me.dias);
                
                //console.log(me.arrayCilindros);
                /*arrayCilindros.forEach(element => {
                    
                });*/
                //me.arrayCilindros[me.dias].push({dias:me.dias});

            }
        },
        
        mounted() {
            var d = new Date();
            
            
            var dd = d.getDate();
            var mm = d.getMonth()+1;
            var yyyy = d.getFullYear();
            if(dd<10){
                dd='0'+dd;
            } 
            if(mm<10){
                mm='0'+mm;
            } 
            d = yyyy+'-'+mm+'-'+dd;
            this.fecha = d;
            this.listarProyecto(1,this.buscar,this.criterio); 
        }
    }
</script>
<style>    
    .modal-content{
        width: 100% !important;
        /*position: absolute !important;*/
        min-width: 1000px;
        left: -6em;
        top: 2em;
    }
    .mostrar{
        display: list-item !important;
        opacity: 1 !important;
        position: fixed !important;
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
    .form-group{
        margin-top: 3px;
    }
</style>
