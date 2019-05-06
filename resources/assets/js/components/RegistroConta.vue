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
                    <i style="float: left;" class="fa fa-align-justify"></i> 
                        <span style="float: left;">Plan Cuentas </span>
                    
                    <button style="float: left;" type="button" @click="mostrarDetalle()" class="btn btn-secondary" >
                        <i class="icon-plus"></i>&nbsp;Nuevo
                    </button>
                    <label style="float: left;" for="text-input">Tipo Formato</label>
                    <select style="float: left;" class="form-control col-md-3" v-model="tipo_formato_new" id="tipo_formato_new"
                    @change="cambiar_tipo_f()">
                        
                        <option v-for="TipoFormato in arrayTiposFormatos" :key="TipoFormato.id" :value="TipoFormato.id" v-text="TipoFormato.nombre_formato"></option>
                    </select> 
                    
                </div>

                <template v-if="listado==1">
                    <div class="card-body">
                        <!-- filtros -->
                        <div class="form-group row">
                            <div class="col-md-1">
                                
                                    <label>Año</label>
                                    <select class="form-control" v-model="anio" style="max-width:120px; min-width: 80px !important;" >
                                        <option value="2015">2015</option>
                                        <option value="2016">2016</option>
                                        <option value="2017">2017</option>
                                        <option value="2018">2018</option>
                                        <option value="2019">2019</option>
                                        <option value="2020">2020</option>
                                        <option value="2021">2021</option>
                                        <option value="2022">2022</option>
                                    </select>
                                
                            </div>
                            <div class="col-md-2">
                                <label>Mes</label>
                                <select class="form-control" v-model="mes" style="max-width:120px">
                                    <option value="01">Enero</option>
                                    <option value="02">Febrero</option>
                                    <option value="03">Marzo</option>
                                    <option value="04">Abril</option>
                                    <option value="05">Mayo</option>
                                    <option value="06">Junio</option>
                                    <option value="07">Julio</option>
                                    <option value="08">Agosto</option>
                                    <option value="09">Septiembre</option>
                                    <option value="10">Octubre</option>
                                    <option value="11">Noviembre</option>
                                    <option value="12">Diciembre</option>
                                </select>
                            </div>
                            <div class="col-md-3">                                
                                <label for="text-input">Tipo Formato</label>
                                <select class="form-control" v-model="tipo_formato_busq">
                                    <option value="0" >Seleccione</option>
                                    <option v-for="TipoFormato in arrayTiposFormatos" :key="TipoFormato.id" :value="TipoFormato.id" v-text="TipoFormato.nombre_formato"></option>
                                </select>      
                            </div>
                            <div class="col-md-2">
                                <label>Criterio</label>
                                <select class="form-control " v-model="criterio">
                                    <option value="tercero">Documento Tercero</option>
                                    <option value="nom_tercero">Nombre Tercero</option>
                                    <option value="numero">Numero</option>
                                    <option value="dia">Dia</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label>Valor</label>
                                <input type="text" v-model="valor" class="form-control" placeholder="Valor a buscar">
                            </div>
                            <div class="col-md-2">                                  
                                <button type="submit" class="btn btn-primary" @click="listarRegistros(1)" >
                                    <i class="fa fa-search"></i> Buscar
                                </button>
                            </div>
                        </div>         
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped table-sm">
                                <thead>
                                    <tr>
                                        <th>Fecha</th>
                                        <th>Formato</th>
                                        <th>Numero</th>
                                        <th>Detalle</th>
                                        <th>Tecero</th>
                                        <th>Nombre</th>                                        
                                        <th>Debe</th>
                                        <th>Haber</th>
                                        <th>Estado</th>
                                        <th>Opciones</th>                                        
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="registro in arrayRegistros" :key="registro.id">
                                        <td v-text="registro.fecha"></td>
                                        <td v-text="registro.nombre_formato"></td>
                                        <td v-text="registro.numero"></td>
                                        <td v-text="registro.detalle"></td>
                                        <td v-text="registro.num_documento"></td>
                                        <td v-if="registro.nombre&& !registro.nombre1">{{ registro.nombre + 'fuck '+registro.nombre1}}</td>
                                        <td v-else> 
                                            {{ registro.nombre1+" "+registro.nombre2+" "+registro.apellido1+" "+registro.apellido2 }}
                                        </td>
                                        <td v-text="registro.debes"></td>
                                        <td v-text="registro.haberes"></td>
                                        
                                        <td >
                                            <template v-if="registro.condicion== 1 && registro.cerrado==0 ">
                                                <span class="badge badge-warning">
                                                    Abierto
                                                </span>
                                            </template>
                                            <template v-if="registro.condicion== 1 && registro.cerrado==1 ">
                                                <span class="badge badge-success">
                                                    Cerrado
                                                </span>
                                            </template>
                                            <template v-if="registro.condicion== 0">
                                                <span class="badge badge-danger">
                                                    Anulado
                                                </span>
                                            </template>
                                        </td>
                                        <td style="width:178px !important">
                                            
                                            <button type="button" style=" margin-right: -8px;" @click="verFormato(registro.id)" class="btn btn-success btn-sm" title='Ver formato'>
                                                <i class="icon-eye"></i>
                                            </button> &nbsp;
                                            <button v-if="registro.condicion ==1 " type="button" style=" margin-right: -8px;" @click="editarFormato(registro.id)" class="btn btn-success btn-sm" title='Ver formato'>
                                                <i class="icon-pencil"></i>
                                            </button> &nbsp;
                                             <button type="button" @click="pdfFormato(registro.id)" class="btn btn-info btn-sm">
                                                <i class="icon-doc"></i>
                                             </button>
                                            <template v-if="registro.condicion ==1 && registro.cerrado==0">
                                                <button type="button" @click="cerrarFormato(registro.id)" class="btn btn-warning  btn-sm" title='Ver formato'>
                                                    <i class="icon-lock"></i>
                                                </button>
                                            </template>
                                            <template v-if="registro.condicion == 1 && registro.cerrado==0">
                                                <button type="button" class="btn btn-danger btn-sm" @click="anularFormato(registro.id)">
                                                    <i class="icon-trash"></i>
                                                </button>
                                            </template>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div> 
                        <nav><!-- PAGINACION -->    
                            <ul class="pagination">
                                <li class="page-item" v-if="pagination.current_page > 1">
                                    <a class="page-link" href="#" @click.prevent="cambiarPagina(pagination.current_page - 1)">Ant</a>
                                </li>
                                <li class="page-item" v-for="page in pagesNumber" :key="page" :class="[page == isActived ? 'active' : '']">
                                    <a class="page-link" href="#" @click.prevent="cambiarPagina(page)" v-text="page"></a>
                                </li>
                                <li class="page-item" v-if="pagination.current_page < pagination.last_page">
                                    <a class="page-link" href="#" @click.prevent="cambiarPagina(pagination.current_page + 1)">Sig</a>
                                </li>
                            </ul>
                        </nav>              
                    </div>
                </template>
                <!-- modal para agregar registro-->
                <template v-else-if="listado==0">
                    <div class="card-body">                        
                        <div class="form-group row border">
                            <div class="col-md-1">
                                <label><b>Fecha*</b></label>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">                                    
                                    <input type="date" class="form-control" v-model="fecha">
                                </div>
                            </div>
                            <div class="col-md-1">
                                <label><b>Numero</b></label>
                            </div>
                            <!--<div class="col-md-1">
                                {{ numero }}
                            </div><div class="col-md-1">
                                <label><b>Tercero*</b></label>
                            </div>
                            <div class="col-md-6" id="div_select_sup">
                                <v-select
                                        id="selectCliente"
                                        :on-search="selectCliente"
                                        label="nom_y_ced"
                                        :options="arrayCliente"
                                        placeholder="Buscar Tercero..."
                                        :onChange="getDatosCliente"                                        
                                    >

                                    </v-select>
                            </div>-->
                            <div class="form-group col-md-8">
                                <label for="" class="float-left col-md-2">Tercero(*) </label>
                                <div class="form-inline float-right col-md-10">
                                    <input type="text" readonly style="max-width: 482px;" class="form-control col-md-10" name="cuenta_fin" v-model="tercero">
                                    <button @click="abrirModalTerceros('tercero_filtro')" style="min-width: 30px;" class="btn btn-primary form-control">...</button>
                                    <button @click="quitar(4)" style="min-width: 30px;" class="btn btn-danger form-control">
                                        <i class="icon-trash"></i>
                                    </button>
                                </div>
                            </div>
                        
                            <div class="col-md-1">
                                <label><b>Detalle*</b></label>
                            </div>
                            <div class="col-md-11">
                                <input type="text" class="form-control" v-model="detalle"><br>
                            </div>


                            <div class="form-group row" v-if="tipo_f_nom!='Cuentas'">
                                <div style="    margin-left: 22px;" class="col-md-1">
                                    <label><b>Forma Pago*</b></label>
                                </div>
                                <div class="col-md-2">
                                    <select v-model="forma_pago" class="form-control">
                                        <option value="">NA</option>
                                        <option value="Efectivo">Efectivo</option>
                                        <option value="Cheque">Cheque</option>
                                        <option value="Transferencia">Transferencia</option>                                    
                                    </select>
                                </div>
                                <div class="col-md-1">
                                    <label><b>Fuente</b></label>
                                </div>
                                <div class="col-md-3">
                                    <select v-model="banco" class="form-control">
                                        <option value="">NA</option>                                    
                                        <option v-for="fuente in arrayFuentes" :key="fuente.id" :value="fuente.id" v-text="fuente.nombre"></option>
                                    </select>
                                    
                                   
                                </div>
                                <div class="col-md-1">
                                    <label><b>Cheque</b></label>
                                </div>
                                <div class="col-md-1">
                                    <input type="text" class="form-control" v-model="cheque">
                                </div>
                                <div class="col-md-1" title="Buscar documento">                            
                                    <button @click="abrirModal2()" class="btn btn-primary">Afectar Documentos</button>
                                </div>
                                <br><br>
                            </div>
                            
                        </div>
                        <!-- listado de errores-->
                        <div class="col-md-12">
                            <div v-show="errorFormato" class="form-group row div-error">
                                <div class="text-center text-error">
                                    <div v-for="error in errorMostrarMsjFormato" :key="error" v-text="error">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- FORM CARGAR CUENTAS-->
                        <div class="form-group row border">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Cuenta <span style="color:red;" v-show="id_cuenta==''">(*Seleccione)</span></label>
                                    <div class="form-inline">
                                        <input type="text" class="form-control" v-model="codigo" @keyup.enter="buscarCuenta()" placeholder="Ingrese Cuenta">
                                        <button @click="abrirModal()" class="btn btn-primary">...</button>
                                        <input type="text" readonly class="form-control" v-model="cuenta">
                                    </div>                                    
                                </div>
                            </div>
                            <div style=" min-width:140px" class="col-md-1">
                                <div class="form-group">
                                    <label>Debito </label>
                                    <input type="number" value="0" step="any" class="form-control" v-model="debito" id="debito"
                                    @focus="limpia_debito()" @blur="cero_debito()">
                                </div>
                            </div>
                            <div style="min-width:140px" class="col-md-1">
                                <div class="form-group">
                                    <label>Credito </label>
                                    <input type="number" value="0" class="form-control" v-model="credito" id="credito" @focus="limpia_credito()" @blur="cero_credito()">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Tercero</label>
                                    <div class="form-inline">                                        
                                         <v-select
                                            id = "tercero_detalle_id"   name = "tercero_detalle_id"
                                            style="min-width: 300px;"
                                            :on-search="selectClienteDetalle"
                                            label="nom_y_ced"                                            
                                            :options="arrayCliente_detalle"
                                            placeholder="Buscar Tercero..."
                                            :onChange="getDatosCliente_detalle"                                        
                                        >
                                        </v-select>
                                        
                                    </div>
                                </div>
                            </div>
                           
                            <div class="col-md-1">
                                <div class="form-group">
                                    <button @click="agregarCuenta()" class="btn btn-success form-control btnagregar"><i class="icon-plus"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row border">
                            <div class="table-responsive col-md-12">
                                <table class="table table-bordered table-striped table-sm">
                                    <thead>
                                        <tr>
                                            <th>Cuenta</th>
                                            <th>Debito</th>
                                            <th>Credito</th>
                                            <th>Tercero</th>
                                            <th>Documento</th>
                                            <th>Opciones</th>
                                        </tr>
                                    </thead>
                                    <tbody v-if="arrayDetalle.length">
                                        <tr v-for="(detalle,index) in arrayDetalle" :key="detalle.id">
                                            <td v-text="detalle.num_cuenta"></td>
                                            <td style="text-align: right;" v-text="detalle.debito"></td>
                                            <td style="text-align: right;" v-text="detalle.credito"></td>
                                            <td v-text="detalle.doc_tercero"></td>
                                            <td v-text="detalle.doc_afecta_long"></td>
                                            <td>
                                                <button @click="eliminarDetalle(index)" type="button" class="btn btn-danger btn-sm">
                                                    <i class="icon-close"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #CEECF5;">
                                            <td align="right"><strong>Total Debitos:</strong></td>
                                            <td style="text-align: right;">$ {{ debitos=calcularDebitos }}</td>
                                            <td style="text-align: right;">$ {{ creditos=calcularCreditos }}</td>
                                            <td align="right"><strong>Diferencia:</strong></td>
                                            <td style="text-align: right;">$ {{ diferencia=calcularDiferencia}}</td>
                                        </tr>
                                    </tbody>
                                    <tbody v-else>
                                        <tr>
                                            <td colspan="6">
                                                NO hay detalles agregados
                                            </td>
                                        </tr>
                                    </tbody> 
                                </table>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-12">
                                <button type="button" @click="ocultarDetalle()" class="btn btn-secondary">Cerrar</button>
                                <button v-if="editar==0" type="button" class="btn btn-primary" @click="registrarFormato()">Registrar Formato</button>
                                <button v-if="editar==1" type="button" class="btn btn-primary" @click="actualizarFormato()">Actualizar Formato</button>
                            </div>
                        </div>
                    </div>
                </template>
            </div>
        </div>
        <!-- Modal busqueda cuentas-->
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

        <!-- Modal busqueda afectados-->
        <div class="modal fade" tabindex="-1" :class="{'mostrar' : modal2}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
            <div class="modal-dialog modal-primary modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" v-text="tituloModal"></h4>
                        <button type="button" class="close" @click="cerrarModal2()" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group row">
                            <div style="max-width: 120px !important;" class="col-md-1   ">
                                <label style='margin-top: 3px; '><b>Cuenta:</b></label>
                            </div>
                            <div v-if="arrayFuentes[banco]"  class="col-md-4 ">
                                {{ arrayFuentes[banco].nombre }}
                            </div>
                            <div v-else>0.00</div>
                            <div  class="col-md-4   ">
                                <label style='margin-top: 3px; '><b>Saldo:</b>$ {{ saldo }}</label>
                            </div>
                            
                        </div>
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped table-sm">
                                
                                    <tr><th>-</th><th>Formato</th><th>Numero</th><th>Fecha</th><th>Detalle</th><th>Valor</th></tr>
                                
                                    <tr v-for="afectados in arrayAfectadosBusq" :key="afectados.id_afectado">
                                        <td>
                                            <input type="checkbox" v-model="arrayChecksAfecst[afectados.id_afectado]">
                                        </td> 
                                        <td v-text="afectados.nombre_formato"></td>
                                        <td v-text="afectados.numero"></td>
                                        <td v-text="afectados.fecha"></td>
                                        <td v-text="afectados.detalle"></td>
                                        <td >                                            
                                            <input type="number" style="max-width: 135px; text-align: right;" class="form-control" :id="'input_afect_'+afectados.id_afectado" v-model="arrayValsAfecst[afectados.id_afectado]" :max="afectados.haber"
                                            @keyup="validar_inputs(afectados.id_afectado)">
                                        </td>                                        
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;" colspan="5"><b>Total</b></td>
                                        <td style="text-align: right;">$ {{ var_totalAfects=totalAfects }}</td>
                                    </tr>
                            </table>                            
                            
                        </div>
                        <div class="form-group row">
                            <div class="col-md-12">
                                <button type="button" @click="cerrarModal2()" class="btn btn-secondary">Cerrar</button>
                                
                                <button type="button" class="btn btn-primary" @click="CargarDocs()">Cargar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal busqueda tercero-->
            <div class="modal fade" tabindex="-1" :class="{'mostrar' : modalTerceros}" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-primary modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" v-text="titulomodalTerceros"></h4>
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
import vSelect from 'vue-select';
export default {
    props : ['ruta'],
    data (){
        return {
            registro_id: 0,
            id_tercero: ''   ,
            id_tercero_det: '',            
            doc_tercero: '',
            anio: '2019',
            listado: 1,
            editar: 0,
            fecha: '',
            tipo_formato_busq: '',
            tipo_formato_new: '',
            numero: '',
            detalle: '',
            forma_pago: '',
            banco: '',
            cheque: '',
            cuenta: '',
            credito: 0,
            debito: 0,
            naturaleza: '',
            tipo: '',
            tercero_det: '',
            tercero_det_aux: '',
            id_cuenta: '',
            doc_cuenta: '',
            mes: new Date(),
            criterio: '',
            valor: '',
            codigo: 0, 
            subtotal: 0,
            total: 0,
            vr_impuesto: 0,
            doc_afecta: 0,            
            arrayCliente: [],            
            arrayCliente_detalle: [],
            arrayTiposFormatos: [],
            doc_afecta_long: '',
            arrayFuentes: [],
            arrayRegistros: [],
            arrayCuentas: [],
            arrayCuentasBusq: [],
            arrayDetalle: [],
            arrayAfectados: [],
            arrayAfectadosBusq: [],
            arrayAfectadosOrg: [],
            arrayValsAfecst: [],
            arrayValsAfecstOrg: [],
            totalValsAfecst: 0,
            arrayChecksAfecst: [],
            arrayAuxChecksAfecst: [],
            arrayAuxValsAfecst: [],
            arrayAfectadosBusqData : [],
            errorFormato: 0,
            errorMostrarMsjFormato: [], 
            checkedAfectados : [],
            modal: 0,
            modal2: 0,
            debitos: 0.0,
            creditos: 0.0,
            diferencia: 0.0,
            pagination : {
                'total' : 0,
                'current_page' : 0,
                'per_page' : 0,
                'last_page' : 0,
                'from' : 0,
                'to' : 0,
            },
            offset : 3,
            tituloModal : '',
            tipoAccion : 0,
            cta_busq: '',
            aux_nom_y_ced : '',
            tipo_f_nom : '',
            saldo: '',
            suma_deuda: '',
            var_totalAfects:'',

            // variables terceros
            idTerceroFiltro : '',
            terceroFiltro : '',
            tipoAccionModalTerceros : 0,
            arrayTerceros : [],
            titulomodalTerceros : '',
            modalTerceros : 0,
            tercero : '',
            tercero_id : '',
            terc_busq : '',
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
        calcularDebitos: function(){
            var debitos=0.0;    
            for(var i=0;i<this.arrayDetalle.length;i++){    
                if(this.arrayDetalle[i].debito&&this.arrayDetalle[i].debito!=0){            
                    debitos=parseFloat(debitos)+parseFloat(this.arrayDetalle[i].debito);     
                }
            }
            debitos = parseFloat(debitos).toFixed(2);
            return debitos;
        },
        calcularCreditos: function(){
            var creditos=0.0;
            for(var i=0;i<this.arrayDetalle.length;i++){    
                creditos=parseFloat(creditos)+parseFloat(this.arrayDetalle[i].credito); 
            }
            creditos = parseFloat(creditos).toFixed(2);
            return creditos;
        },
        calcularDiferencia: function(){
            var diferencia = this.debitos - this.creditos;
        
            return diferencia;
        },
        totalAfects: function(){
            
            var totalA=0;     
           // console.log('aca1 '+this.arrayChecksAfecst);     
            for(var i=0;i<this.arrayChecksAfecst.length;i++){    
                //totalA=; 
                
                if(this.arrayChecksAfecst[i]){
                    if(this.arrayValsAfecst[i]>this.arrayValsAfecstOrg[i]){
                        this.arrayValsAfecst[i] = this.arrayValsAfecstOrg[i];
                       // totalA = parseFloat(this.arrayValsAfecstOrg[i]) + parseFloat(totalA);
                    }
                    else
                        totalA = parseFloat(this.arrayValsAfecst[i]) + parseFloat(totalA);
                }
            }
            /*
            this.arrayChecksAfecst.forEach(function(datos, indice) {
                //if(datos)   this.var_totalAfects = this.arrayValsAfecst[indice];
                //if(datos) console.log(this.arrayValsAfecst[indice]);
                console.log("indice = "+indice+" datos="+datos+" totalA="+totalA);
            });*/
            return totalA;
          
        }
    },
    methods : {
        limpia_debito(){    
            if(this.debito=='0')    this.debito='';
        },
        cero_debito(){
            if(this.debito==''||this.debito<=0)    this.debito='0';
        },
        limpia_credito(){
            if(this.credito=='0')    this.credito='';
        },
        cero_credito(){
            if(this.credito==''||this.credito<=0)    this.credito='0';
        },
        validar_inputs(id){
            
            let me=this;
            var aux_val = $("#input_afect_"+id).val();
            
            var num1=aux_val;
            var num2=me.arrayValsAfecstOrg[id];
            //console.log("llegaaa num1="+num1+" num2="+num2+" sssss");
            if(num1&&num1>num2){
                //console.log("llegaaa "+num2+" sssss");
                me.arrayValsAfecst[id] = num2;
                $("#input_afect_"+id).val(num2);
            }
            
            if(aux_val<0){me.arrayValsAfecst[id]=0;} 
            
        },
        listarRegistros(page)
        {
            let me=this;
            var url=this.ruta +'/formatos?page=' + page + '&anio=' +me.anio+ '&mes=' +me.mes + '&tipo_formato=' +me.tipo_formato_busq+ '&criterio=' +me.criterio+ '&valor=' +me.valor;         
            // console.log(url)   ;
            
            axios.get(url).then(function (response) {
                //console.log(response.registros.data);
                var respuesta= response.data;
                me.arrayRegistros = respuesta.registros.data;
                me.pagination= respuesta.pagination;
            })
            .catch(function (error) {
                console.log(error);
            });
        },
        selectCliente(search,loading){
            let me=this;
            loading(true)

            var url= this.ruta +'/cliente/selectCliente?filtro='+search;
            axios.get(url).then(function (response) {
                let respuesta = response.data;
                q: search
                me.arrayCliente=respuesta.clientes;
                //console.log(response.data.clientes)
                loading(false)
            })
            .catch(function (error) {
                console.log(error);
            });
        },
        quitar_tercero(){
            let me = this;
             me.tercero_det_aux = '';
        },
        getDatosCliente(val1){
            let me = this;
            me.loading = true;
            if(val1){
                me.id_tercero = val1.id;
                me.doc_tercero = val1.num_documento;
                me.aux_nom_y_ced = val1.nom_y_ced;
            }
            else{
                me.id_tercero = "";
            }
            //console.log("pasa");
        },
        selectClienteDetalle(search,loading){
            let me=this;
            loading(true)

            var url= this.ruta +'/cliente/selectCliente?filtro='+search;
            axios.get(url).then(function (response) {
                let respuesta = response.data;
                q: search
                me.arrayCliente_detalle=respuesta.clientes;
                loading(false)
            })
            .catch(function (error) {
                console.log(error);
            });

            
        },        
        getDatosCliente_detalle(val1){
            //console.log(val1);
            let me = this;
            me.loading = true;
            if(val1)
            {
                me.id_tercero_det = val1.id; 
                me.tercero_det_aux = val1.num_documento;
            }
            else{
                me.id_tercero_det = '';
            }
        },
        selectTipoFormato(){ 
            let me=this;
            var url= this.ruta +'/conf_formatos/get_tipos_formatos';
            axios.get(url).then(function (response) {
                //console.log(response);
                var respuesta= response.data;
                me.arrayTiposFormatos = respuesta.conf_formatos;
            })
            .catch(function (error) {
                console.log(error);
            });
        },
        selectFuentes(){ 
            let me=this;
            var url= this.ruta +'/cuentas/get_fuentes';
            axios.get(url).then(function (response) {
                //console.log(response);
                var respuesta= response.data;
                me.arrayFuentes = respuesta.fuentes;
            })
            .catch(function (error) {
                console.log(error);
            });
        },
        getNumeroNext(){
            let me = this;
            if(me.formato)
            {
                var url = this.ruta +'/formatos/numero_next?tipo_formato='+me.tipo_formato_new;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.numero = respuesta.numero;
                })
                .catch(function (error) {
                    console.log(error);
                });
            }
        },
        cerrarModal(){
            this.modal=0;
            this.tituloModal='';
        },        
        buscarCuenta(){
            let me=this;            
            var url= this.ruta +'/planCuentas/selectCuenta2?filtro=' + me.codigo;

            axios.get(url).then(function (response) {
                var respuesta= response.data;
                me.arrayCuentas = respuesta.cuentas;

                if (me.arrayCuentas.length>0){
                    me.codigo=me.arrayCuentas[0]['codigo'];
                    me.id_cuenta=me.arrayCuentas[0]['id'];
                    me.cuenta=me.arrayCuentas[0]['nombre'];
                    me.naturaleza=me.arrayCuentas[0]['naturaleza'];
                    if(me.naturaleza=="Debito"){
                        $( "#debito" ).focus();
                        $( "#debito" ).val('');
                        //$("#credito").prop('disabled', true);
                    }
                    else{
                        $( "#credito" ).focus();
                        $( "#credito" ).val('');
                    }
                    me.tipo=me.arrayCuentas[0]['tipo'];
                    
                 //   me.id_tercero_det=me.id_tercero;
                 //   me.tercero_det_aux = me.doc_tercero;
                    if(me.id_tercero_det == '' ){
                        me.arrayCliente_detalle = me.arrayCliente;
                        me.id_tercero_det =  me.id_tercero;
                        me.tercero_det_aux = me.doc_tercero;
                        var mylist = document.getElementById("tercero_detalle_id");                           
                        var listitems= mylist.getElementsByClassName("form-control");
                        //var aux1 = $('#tercero_detalle_id').children('input').attr("placeholder", "Type your answer here");
                        //listitems[0].attr("placeholder", "Type your answer here");
                        var aux11 = $("#tercero_detalle_id").children().children().attr("placeholder", me.aux_nom_y_ced);
                        //$("#tercero_detalle_id").first().append( "<span class='selected-tag'>Luis  Monsalve  - 3839<!----></span>");
                        //aux11.append( "<span class='selected-tag'>Luis  Monsalve  - 3839<!----></span>");
                        //console.log(aux11[0]);  
                       /* var url= '/cliente/selectCliente?filtro='+me.doc_tercero;
                        axios.get(url).then(function (response2) {
                            let respuesta2 = response2.data;
                            //q: search
                            me.arrayCliente_detalle=respuesta2.clientes;
                            me.loading = true;
                            me.id_tercero_det = me.id_tercero;
                            me.tercero_det_aux = me.doc_tercero;
                            //selectCliente                        
                            var mylist = document.getElementById("selectCliente");
                            var listitems2 = mylist.getElementsByClassName("selected-tag");
                            
                            var mylist = document.getElementById("tercero_detalle_id");
                            var listitems= mylist.getElementsByClassName("form-control");
                            
                            
                            var aux_carga_det = listitems2[0].innerHTML.split("<!---->");
                            listitems[0].value = aux_carga_det[0];
                            //console.log(aux_carga_det[0]);                                                
                        })
                        .catch(function (error) {
                            console.log(error);
                        });*/
                    }
                   
                }
                else{
                    me.cuenta='No existe la cuenta';
                    me.id_cuenta='';
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
            me.listarRegistros(page);
        },
        agregarCuenta(){
            let me=this;
            if(me.id_tercero=='')
            {
                swal({  type: 'error',  title: 'Error...',
                    text: 'Debe seleccionar un tercero para el documento!!!',
                })
            }
            else if((me.debito=='' && me.credito=='') || (me.debito<='0' && me.credito<='0') || me.id_cuenta == ''){
                swal({  type: 'error',  title: 'Error...',
                    text: 'Debe seleccionar la cuenta y/o registrar los valores!!!',
                })
            }   
            else
            {
                if(!me.debito) me.debito='0';
                if(!me.credito) me.credito='0';
                 me.arrayDetalle.push({
                   
                    id_cuenta: me.id_cuenta,
                    num_cuenta: me.codigo,
                    debito: me.debito,
                    credito: me.credito,
                    id_tercero: me.id_tercero_det,
                    doc_tercero: me.tercero_det_aux,
                    nom_cuenta : me.cuenta,
                    documento : '',
                    doc_externo: '',
                    doc_afecta_long:'',
                });
                me.debito = 0;
                me.credito = 0;
                me.id_cuenta = '';
                me.cuenta = '';
                me.codigo = '';
                me.id_tercero_det = '';
                me.tercero_det_aux = '';            
                me.diferencia = parseFloat(me.debito) - parseFloat(me.credito);

                var mylist = document.getElementById("tercero_detalle_id");
                var listitems= mylist.getElementsByClassName("form-control");
                listitems[0].value = '';
            }
            
        },
        eliminarDetalle(index){
            swal({
                title: 'Esta seguro de eliminar este registro?',
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
                    me.arrayDetalle.splice(index, 1);
                } else if (
                    // Read more about handling dismissals
                    result.dismiss === swal.DismissReason.cancel
                ) {
                    
                }
            }) 
            
        },
        mostrarDetalle(){
            let me=this;
            if(me.tipo_formato_new == '')
            {
               swal({  type: 'error',  title: 'Error...',
                    text: 'Debe seleccionar un tipo de formato!!!',
                })
                $( "#tipo_formato_new" ).focus();
            }
            else{
                
                 me.listado=0;
                $('#tipo_formato_new').attr('readonly', true);
                $('#tipo_formato_new').attr('disabled', true);
                
            }
        },
        ocultarDetalle(){                   
            this.listado=1;
            this.editar=0;
            this.arrayDetalle = null;
            this.arrayDetalle = [];
            this.detalle='';
            $('#tipo_formato_new').attr('readonly', false);
            $('#tipo_formato_new').attr('disabled', false);
        },
        registrarFormato(){

            if (this.validarFormato()){
                return;
            }
            let me = this;
            this.getNumeroNext();
            axios.post(this.ruta +'/formatos/registrar',{
                'id_tercero': this.id_tercero,
                'formato': this.tipo_formato_new,
                'fecha' : this.fecha,
                'subtotal' : this.subtotal,
                'total' : this.total,
                'impuesto' : this.impuesto,
                'debitos' : this.debitos,
                'creditos' : this.creditos,
                'detalle' : this.detalle,
                'banco' : this.banco,
                'forma_pago' : this.forma_pago,
                'num_cheque' : this.num_cheque,
                'data': this.arrayDetalle,
                'afectados' : this.arrayAfectados,
                'numero' : this.numero,
                'doc_afecta_long' : this.doc_afecta_long
                
            }).then(function (response) {
                me.listado=1;
                me.listarRegistros(1);
                me.registro_id= 0;
                me.id_tercero= ''   ;
                me.id_tercero_det= '';            
                me.doc_tercero= '';
                me.anio= '2018';
                me.listado= 1;
                me.fecha= '';
                me.tipo_formato_busq= '';
                me.tipo_formato_new= '';
                me.numero= '';
                me.detalle= '';
                me.forma_pago= '';
                me.banco= '';
                me.cheque= '';
                me.doc_afecta_long = '';
                me.cuenta= '';
                me.credito= 0;
                me.debito= 0;
                me.naturaleza= '';
                me.tipo= '';
                me.tercero_det= '';
                me.tercero_det_aux= '';
                me.id_cuenta= '';
                me.doc_cuenta= '';
                me.mes= new Date();
                me.valor= '';
                me.codigo= 0; 
                me.subtotal= 0;
                me.total= 0;
                me.vr_impuesto= 0;
                me.doc_afecta= 0;            
                me.arrayCliente= [];            
                me.arrayCliente_detalle= [];                
                me.arrayRegistros= [];
                me.arrayCuentas= [];
                me.arrayDetalle= [];
                me.arrayAfectados= [];
                me.arrayAuxChecksAfecst = [];   me.arrayChecksAfecst = [];  me.arrayValsAfecst=[];  me.arrayAuxValsAfecst=[];
                $('#tipo_formato_new').attr('readonly', false);
                $('#tipo_formato_new').attr('disabled', false);
                //window.open(this.ruta +'/formatos/pdf/'+ response.data.id + ',' + '_blank');

            }).catch(function (error) {
                console.log(error);
            });  
            $('#tipo_formato_new').attr('readonly', false);
        },
        validarFormato(){
            let me=this;
            me.errorFormato = 0;
            me.errorMostrarMsjFormato = [];
            var cuent;

            if(me.id_tercero=='')   me.errorMostrarMsjFormato.push("Seleccione un Tercero");
            if(me.fecha == '')   me.errorMostrarMsjFormato.push("Seleccione una fecha");
            if(me.detalle == '')   me.errorMostrarMsjFormato.push("Digite el detalle");
            if(me.forma_pago == '' && me.tipo_f_nom !='Cuentas')   me.errorMostrarMsjFormato.push("Selecione la forma de pago");
            if(me.forma_pago == 'Cheque' && me.cheque == "" )   me.errorMostrarMsjFormato.push("Debe digitar el numero de cheque");
            if(me.arrayDetalle.length==0) me.errorMostrarMsjFormato.push("Debe haber cuentas registrados");
            //if(me.diferencia != 0 )   me.errorMostrarMsjFormato.push("Selecione la forma de pago");

            if (me.errorMostrarMsjFormato.length) me.errorFormato = 1;
            return me.errorFormato;
        },
        anularFormato(id_formato){
            swal({
                title: 'Esta seguro de anular este formato?',
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

                    axios.put(this.ruta +'/formatos/desactivar',{
                        'id': id_formato,
                    }).then(function (response) {
                        me.listarRegistros(1);
                        swal(
                        'Anulado!',
                        'El formato ha sido anuado con éxito.',
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
        cerrarFormato(id_formato){
            swal({
                title: 'Esta seguro de cerrar este formato?',
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

                    axios.put(this.ruta +'/formatos/cerrar',{
                        'id': id_formato,
                    }).then(function (response) {
                        me.listarRegistros(1);
                        swal(
                        'Cerrado!',
                        'El formato ha sido cerrado con éxito.',
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
        verFormato(id){
            let me=this;
            me.listado=2;
            
            //Obtener los datos del ingreso
            var arrayFormatosT=[];
            var url= this.ruta +'/formatos/obtenerCabecera?id=' + id;
            
            axios.get(url).then(function (response) {
                var respuesta= response.data;
                arrayVentaT = respuesta.venta;

                me.cliente = arrayVentaT[0]['nombre'];
                me.tipo_comprobante=arrayVentaT[0]['tipo_comprobante'];
                me.serie_comprobante=arrayVentaT[0]['serie_comprobante'];
                me.num_comprobante=arrayVentaT[0]['num_comprobante'];
                me.impuesto=arrayVentaT[0]['impuesto'];
                me.total=arrayVentaT[0]['total'];
            })
            .catch(function (error) {
                console.log(error);
            });

            //Obtener los datos de los detalles 
            var urld= this.ruta +'/formatos/obtenerDetalles?id=' + id;
            
            axios.get(urld).then(function (response) {
                console.log(response);
                var respuesta= response.data;
                me.arrayDetalle = respuesta.detalles;
            })
            .catch(function (error) {
                console.log(error);
            });               
        },
        selectCliente2(id){
            let me=this;
            //console.
            var url= this.ruta +'/cliente/selectCliente2?id='+id;
            axios.get(url).then(function (response) {
                let respuesta = response.data;
                //q: search
                me.arrayCliente=respuesta.clientes;
                //me.id_tercero = id;

                var auxiliar = document;
                var mylist = auxiliar.getElementById('selectCliente');
                var listitems= mylist.getElementsByClassName("form-control");
                //console.log(me.arrayCliente[0]['nombre']);
                
                if(me.arrayCliente[0]['nombre']&&me.arrayCliente[0]['nombre']!=''){
                    listitems[0].value= me.arrayCliente[0]['nombre']+" - "+me.arrayCliente[0]['num_documento'];
                }else{ 
                    listitems[0].value = me.arrayCliente[0]['nombre1']+" "+me.arrayCliente[0]['nombre2']+" "+me.arrayCliente[0]['apellido1']+" "+" - "+me.arrayCliente[0]['apellido2']+" "+me.arrayCliente[0]['num_documento'];
                }
                //console.log (listitems[0]);
            })
            .catch(function (error) {
                console.log(error);
            });
        },
        editarFormato(id){
            let me=this;
            me.listado=0;
            me.editar = 1;
            me.registro_id = id;
            //Obtener los datos del ingreso
            var arrayFormatosT=[];
            var url= this.ruta +'/formatos/obtenerCabecera?id=' + id;
            
            axios.get(url).then(function (response) {
                var respuesta= response.data;
                var AuxFormato = respuesta.formato;
                //console.log(AuxFormato[0]['formato']);
                me.fecha = AuxFormato[0]['fecha'];
                me.id_tercero = AuxFormato[0]['id_persona'],
                me.tipo_formato_new = AuxFormato[0]['formato'],                
                me.subtotal = AuxFormato[0]['subtotal'],
                me.total = AuxFormato[0]['total'],
                me.impuesto = AuxFormato[0]['impuesto'],
                me.debitos = AuxFormato[0]['debes'],
                me.creditos = AuxFormato[0]['haberes'],
                me.detalle = AuxFormato[0]['detalle'],
                me.banco = AuxFormato[0]['banco'],
                me.forma_pago = AuxFormato[0]['forma_pago'],
                me.num_cheque = AuxFormato[0]['num_cheque'],
                
                //me.arrayAfectados = AuxFormato[0]['fecha'],
                me.numero = AuxFormato[0]['numero'],
                me.doc_afecta_long = AuxFormato[0]['doc_afecta_long'],
                me.cambiar_tipo_f();
                me.selectCliente2(me.id_tercero);
            })
            .catch(function (error) {
                console.log(error);
            });

            //Obtener los datos de los detalles 
            var urld= this.ruta +'/formatos/obtenerDetalles?id=' + id;
            
            axios.get(urld).then(function (response) {
                
                var respuesta= response.data;
                //console.log(response.data.detalles);
                me.arrayDetalle = response.data.detalles;
            })
            .catch(function (error) {
                console.log(error);
            });   
        },
        actualizarFormato(){
            if (this.validarFormato()){
                return;
            }
            let me = this;
            this.getNumeroNext();
            axios.put(this.ruta +'/formatos/actualizar',{
                'id' : this.registro_id,
                'id_tercero': this.id_tercero,
                'formato': this.tipo_formato_new,
                'fecha' : this.fecha,
                'subtotal' : this.subtotal,
                'total' : this.total,
                'impuesto' : this.impuesto,
                'debitos' : this.debitos,
                'creditos' : this.creditos,
                'detalle' : this.detalle,
                'banco' : this.banco,
                'forma_pago' : this.forma_pago,
                'num_cheque' : this.num_cheque,
                'data': this.arrayDetalle,
                'afectados' : this.arrayAfectados,
                'numero' : this.numero,
                'doc_afecta_long' : this.doc_afecta_long
            }).then(function (response) {
                me.listado=1;     
                window.open(this.ruta +'/formatos/pdf/'+ me.registro_id + ',' + '_blank');           
                me.registro_id= 0;
                me.id_tercero= ''   ;
                me.id_tercero_det= '';            
                me.doc_tercero= '';
                me.anio= '2018';
                me.listado= 1;
                me.fecha= '';
                me.tipo_formato_busq= '';
                me.tipo_formato_new= '';
                me.numero= '';
                me.detalle= '';
                me.forma_pago= '';
                me.banco= '';
                me.cheque= '';
                me.doc_afecta_long = '';
                me.cuenta= '';
                me.credito= 0;
                me.debito= 0;
                me.naturaleza= '';
                me.tipo= '';
                me.tercero_det= '';
                me.tercero_det_aux= '';
                me.id_cuenta= '';
                me.doc_cuenta= '';
                var d = new Date();
                var n = d.getMonth() +1;
                if(n < 10){ n = '0'+n;}
                
                me.mes= n;
                me.valor= '';
                me.codigo= 0; 
                me.subtotal= 0;
                me.total= 0;
                me.vr_impuesto= 0;
                me.doc_afecta= 0;            
                me.arrayCliente= [];            
                me.arrayCliente_detalle= [];                
                me.arrayRegistros= [];
                me.arrayCuentas= [];
                me.arrayDetalle= [];
                me.arrayAfectados= [];
                me.arrayAuxChecksAfecst = [];   me.arrayChecksAfecst = [];  me.arrayValsAfecst=[];  me.arrayAuxValsAfecst=[];
                me.listarRegistros(1);
                

            }).catch(function (error) {
                console.log(error);
            });
        },
        pdfFormato(id){
            window.open(this.ruta +'/formatos/pdf/'+ id + ',' + '_blank');
        },    
        cargarCuentaB(cuenta){
            let me=this;  
            me.codigo= cuenta['codigo'];
            me.id_cuenta= cuenta['id'];
            me.cuenta= cuenta['nombre'];
            me.naturaleza=cuenta['naturaleza'];
            if(me.naturaleza=="Debito"){
                $( "#debito" ).focus();
                $( "#debito" ).val('');
                //$("#credito").prop('disabled', true);
            }
            else{
                $( "#credito" ).focus();
                $( "#credito" ).val('');
            }
            me.tipo=cuenta['tipo'];
            if(me.id_tercero_det == '' ){
                me.arrayCliente_detalle = me.arrayCliente;
                me.id_tercero_det =  me.id_tercero;
                me.tercero_det_aux = me.num_documento
                var mylist = document.getElementById("tercero_detalle_id");                           
                var listitems= mylist.getElementsByClassName("form-control");
                //var aux1 = $('#tercero_detalle_id').children('input').attr("placeholder", "Type your answer here");
                //listitems[0].attr("placeholder", "Type your answer here");
                var aux11 = $("#tercero_detalle_id").children().children().attr("placeholder", me.aux_nom_y_ced);
                //$("#tercero_detalle_id").first().append( "<span class='selected-tag'>Luis  Monsalve  - 3839<!----></span>");
                //aux11.append( "<span class='selected-tag'>Luis  Monsalve  - 3839<!----></span>");
                //console.log(aux11[0]);  
                /* var url= '/cliente/selectCliente?filtro='+me.doc_tercero;
                axios.get(url).then(function (response2) {
                    let respuesta2 = response2.data;
                    //q: search
                    me.arrayCliente_detalle=respuesta2.clientes;
                    me.loading = true;
                    me.id_tercero_det = me.id_tercero;
                    me.tercero_det_aux = me.doc_tercero;
                    //selectCliente                        
                    var mylist = document.getElementById("selectCliente");
                    var listitems2 = mylist.getElementsByClassName("selected-tag");
                    
                    var mylist = document.getElementById("tercero_detalle_id");
                    var listitems= mylist.getElementsByClassName("form-control");
                    
                    
                    var aux_carga_det = listitems2[0].innerHTML.split("<!---->");
                    listitems[0].value = aux_carga_det[0];
                    //console.log(aux_carga_det[0]);                                                
                })
                .catch(function (error) {
                    console.log(error);
                });*/
            }
            this.cerrarModal();
        },
        abrirModal(){               
            this.arrayCuentasBusq=[];
            this.modal = 1;            
            this.tituloModal = 'Seleccione una cuenta';
            this.cta_busq = '';
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
        cerrarModal(){
            this.modal=0;
            this.tituloModal='';
            this.tipo_cta = '';
            this.cta_busq = '';
        }, 
        cambiar_tipo_f(){
                        
            let me=this;            
            if(me.tipo_formato_new!='')
            {
                var url= this.ruta +'/conf_formatos/get_filt_tipo?id_formato=' + me.tipo_formato_new;

                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.tipo_f_nom = respuesta.tipo;

                    
                })
                .catch(function (error) {
                    console.log(error);
                });
            }
            else{
                me.tipo_f_nom = '';
            }
        },
        get_saldo(id_cuenta){
            let me=this; 
            var url= this.ruta +'/cuentas/saldo?id_cuenta=' + me.banco;
             axios.get(url).then(function (response) {
                var respuesta= response.data;
                me.saldo = respuesta.saldo;                                   
            })
            .catch(function (error) {
                console.log(error);
            });
        },
        CargarDocs(){
            let me=this;
            
            me.arrayAuxChecksAfecst = me.arrayChecksAfecst;
            me.arrayAuxValsAfecst = me.arrayValsAfecst;
            var auxiliar = document;
            var mylist = auxiliar.getElementById('selectCliente');
            var listitems= mylist.getElementsByClassName("form-control");
            var aux_ingresar_c="";
            var aux_saldo=0;
            listitems[0].readOnly = true;
            for(var i=0;i<me.arrayChecksAfecst.length;i++){    
                if(me.arrayChecksAfecst[i]){
                    //console.log(me.arrayChecksAfecst[i]);
                    aux_saldo=0; //id_cuenta
                    
                    aux_saldo = parseFloat(me.arrayValsAfecstOrg[i])-parseFloat(me.arrayValsAfecst[i]);
                    //console.log('aux_saldo='+aux_saldo);                    
                    me.arrayDetalle.push({credito: 0, debito: me.arrayValsAfecst[i], doc_afecta_long: me.arrayAfectadosBusqData[i].numero, doc_externo: me.arrayAfectadosBusqData[i].doc_externo, id_tercero: me.arrayAfectadosBusqData[i].tercero, id_cuenta:me.arrayAfectadosBusqData[i].cuenta, doc_tercero: me.doc_tercero, num_cuenta:me.arrayAfectadosBusqData[i].num_cuenta, saldo_cuent: aux_saldo,  id_afectado: me.arrayAfectadosBusqData[i].id_afectado });
                }
            }
            me.cerrarModal2(); 
           // console.log(listitems);

        },
        get_x_afectar(){
            //console.log("llega");
            let me=this; 
            //if(me.arrayValsAfecst.length<=0){
                me.arrayValsAfecst = [];
                me.arrayValsAfecstOrg = [];
                me.arrayChecksAfecst = [];
                me.arrayAfectadosBusqData = [];
                me.arrayAfectadosBusq = [];

                var url= this.ruta +'/cuentas/get_x_afectar?id_tercero=' + me.id_tercero;
                var resultado = [];
                
                axios.get(url).then(function (response) {
                    //arrayAfectadosBusq
                    var respuesta= response.data;
                    resultado = respuesta.afectados                
                    //console.log(resultado);                                        
                    resultado
                    me.arrayAfectadosBusq=resultado;
                                    
                    var id_datos_aux = '';
                
                    resultado.forEach(function(datos) {
                        //console.log(datos.id_cuenta);
                        id_datos_aux = datos.id_afectado;
                        me.arrayAfectadosBusqData[datos.id_afectado] = datos;
                        me.arrayValsAfecst[datos.id_afectado] = parseFloat(datos.saldo_cuent);
                        me.arrayValsAfecstOrg[datos.id_afectado] = parseFloat(datos.saldo_cuent);
                        //me.arrayChecksAfecst[datos.id_afectado] = parseFloat(datos.saldo_cuent );
                    });

                  
                    
                /*      .forEach(function(datos) {
                        if(datos.id_cuenta){
                        // console.log("datos.id_cuenta="+datos.id_cuenta);
                            me.arrayValsAfecst[datos.id_cuenta] = datos.haber;
                            me.arrayValsAfecstOrg[datos.id_cuenta] = datos.haber;
                            me.arrayChecksAfecst[datos.id_cuenta] = 0;
                        }                    
                    });*/
                })
                .catch(function (error) {
                    console.log(error);
                    return "";
                });
           // }
           //console.log(me.arrayAuxChecksAfecst);
            
        },
        abrirModal2(){               
            if(this.banco == "")
             swal({  type: 'error',  title: 'Error...',
                    text: 'Debe seleccionar la fuente del pago para realizar la afectación!!!',
                })
            else{
                if(this.id_tercero==""){
                     swal({  type: 'error',  title: 'Error...',
                        text: 'Debe seleccionar un tercero para realizar la afectación!!!',
                    })
                }
                else{
                    this.arrayAfectadosBusq='';
                    this.modal2 = 1;            
                    this.tituloModal = 'Seleccione los documentos a afectar';       
                    this.saldo = this.get_saldo(this.banco);
                    this.get_x_afectar();
                    //this.arrayAfectadosBusq = 
                    //console.log("aux="+aux);
                    //console.log(this.arrayFuentes);
                }
            }
        },
        cerrarModal2(){
            this.modal2=0;
            this.tituloModal='';            
        }, 
        formatPrice(value) {
            let val = (value/1).toFixed(2).replace('.', ',')
            return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")
        },

        
        // funciones terceros
        abrirModalTerceros(accion){
            let me=this;
            me.arrayTerceros=[];
            me.modalTerceros = 1;
            me.titulomodalTerceros = 'Seleccione un tercero';
            me.tipoAccionModalTerceros = 1;
        },
        cerrarModalT(){
            let me=this;
            me.modalTerceros=0;
            me.titulomodalTerceros='';
            me.terc_busq = '';
        },
        cargarTercero(tercero){
            this.tercero = tercero['num_documento'];
            this.tercero_id = tercero['id'];
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
            this.tercero_id = '';
            this.tercero = '';
        }
    },
    mounted() {
        var d = new Date();
        var n = d.getMonth() +1;
        if(n < 10){ n = '0'+n;}
        this.mes= n;
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
        //console.log(d);
        this.listarRegistros(1);
        this.selectTipoFormato();
        this.selectFuentes();
        this.getNumeroNext();
    },
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
    @media (min-width: 600px) {
        .btnagregar {
            margin-top: 2rem;
        }
    }
    .table-sm td {
        padding: 1px !important; }
    .selected-tag{
        max-width: 228px !important;
        margin-right: -52px !important;
        float: inherit !important;
    }
     
</style>