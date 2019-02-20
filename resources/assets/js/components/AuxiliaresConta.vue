<template>
        <main class="main">
        <!-- Breadcrumb -->
       
        <div class="container-fluid">
            <!-- Ejemplo de tabla Listado -->
            <div class="card">
                
                <div class="card-body">
                   

                    <div style="    margin-bottom: -0.5em !important;" class="form-group row">
                        <div style="max-width: 120px !important; min-width: 100px;" class="col-md-1   ">
                            <label style='margin-top: 3px; '><b>Informe*</b></label>                                
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">                                                                  
                                <select class="form-control" v-model="id_informe">
                                    <option value="0" disabled>Seleccione</option>
                                    <option v-for="informe in arrayInformes" :key="informe.numero" :value="informe.numero" v-text="informe.nom_informe"></option>-
                                </select> 
                            </div>
                        </div>
                        <div class="col-md-1    ">
                            <label style='margin-top: 3px;'><b>Desde*</b></label>                                
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <input type="date" class="form-control" name="fecha_ini" v-model="fecha_ini">
                            </div>
                        </div>
                        <div class="col-md-1   ">
                            <label style='margin-top: 3px;'><b>Hasta*</b></label>                                
                        </div>
                        <div class="col-md-2">
                            <div class="form-group" >
                                <input type="date" class="form-control" name="fecha_fin" v-model="fecha_fin">
                            </div>
                        </div>
                    </div>
                    <div v-if="id_informe=='1'">
                        <div style="    margin-bottom: -0.5rem;" class="form-group row">
                            <div class="col-md-12">
                                <table border="0" cellpadding="2">
                                    <tr>
                                        <td><label ><b>Cta Inicial</b></label></td>
                                        <td>
                                            <div class="form-group" >
                                                <div class="form-inline">
                                                    <input type="text" readonly style="    max-width: 90px;" class="form-control" name="cuenta_ini" v-model="cuenta_ini">
                                                    <button @click="abrirModal(1)" style="    min-width: 30px;" class="btn btn-primary form-control">...</button>
                                                    <button @click="quitar(1)" style="    min-width: 30px;" class="btn btn-danger form-control">
                                                        <i class="icon-trash"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </td>
                                        <td><label ><b>Cta Final</b></label></td>
                                        <td>
                                            <div class="form-group" >
                                                <div class="form-inline">
                                                    <input type="text" readonly style="    max-width: 90px;" class="form-control" name="cuenta_fin" v-model="cuenta_fin">
                                                    <button @click="abrirModal(2)" style="    min-width: 30px;" class="btn btn-primary form-control">...</button>
                                                    <button @click="quitar(2)" style="    min-width: 30px;" class="btn btn-danger form-control">
                                                        <i class="icon-trash"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </td>
                                        <td><label ><b>Tercero</b></label></td>
                                        <td>
                                            <div class="form-group" >
                                                <div class="form-inline">
                                                    <input type="text" readonly style="    max-width: 90px;" class="form-control" name="cuenta_fin" v-model="tercero">
                                                    <button @click="abrirModalT()" style="    min-width: 30px;" class="btn btn-primary form-control">...</button>
                                                    <button @click="quitar(3)" style="    min-width: 30px;" class="btn btn-danger form-control">
                                                        <i class="icon-trash"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </td>
                                            <td><label ><b>Formato</b></label></td>
                                        <td>
                                            <div class="form-group" >
                                                <div class="form-inline">
                                                    <select style="float: left;" class="form-control" v-model="tipo_formato" id="tipo_formato_new">
                                                        <option value=""></option>
                                                        <option v-for="TipoFormato in arrayTiposFormatos" :key="TipoFormato.id" :value="TipoFormato.id" v-text="TipoFormato.nombre_formato"></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </td>
                                        <td><button @click="verAuxConSaldos()" style="margin-top: -18px; min-width: 30px;" class="btn btn-success form-control">Ver</button></td>
                                    </tr>
                                </table>
                            </div>
                            
                        </div>
                        <br>
                        <div class="form-group row">
                            <div class="col-md-12">                            
                                <center><button type="button" class="btn btn-danger btn-sm" @click="pdfFormato()">PDF</button></center>
                            </div>
                        </div> 
                        <div v-if="informe!=''">
                            <div class="table-responsive"  v-html="informe">
                            
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Fin ejemplo de tabla Listado -->
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
                                    <input type="text" class="form-control" name="cta_busq" v-model="cta_busq" @keyup="buscarCuenta()">
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped table-sm">
                                
                                    <tr><th>Codigo</th><th>Cuenta</th><th>-</th></tr>
                                
                                    <tr v-for="cuentas in arrayCuentas" :key="cuentas.id">
                                        <td v-text="cuentas.codigo"></td>
                                        <td v-text="cuentas.nombre"></td>
                                        <td>
                                            <button type="button" style=" margin-right: -8px;" @click="cargarCuenta(cuentas)" class="btn btn-success btn-sm" title='Ver formato'>
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
    </main>
</template>

<script>
    import VueBarcode from 'vue-barcode';
    export default {
        props : ['ruta'],
        data (){
            return {
                id_informe: 0,
                fecha_ini :'',
                fecha_fin : '', 
                mes: '',   
                cuenta_ini : '',
                id_cuenta_ini : '',
                cuenta_fin : '',
                id_cuenta_fin : '',
                tercero : '',
                id_tercero : '',
                id_comprobante: '',            
                arrayCuentas : [],     
                arrayInformes : [],
                arrayTerceros : [],
                arrayTiposFormatos : [],
                informe : [],
                tipo_formato : '',
                id_rercero : '',
                tituloModal : '',
                tituloModal2 : '',
                modal : '',
                modal2 : '',
                buscar : '',   
                ctn_ban : 0,       
                tipo_cta : '',    
                cta_busq : '',  
                terc_busq : '',  
            }
        },
        components: {
            
        
        },
        computed:{
           
            //Calcula los elementos de la paginación
            
        },
        methods : {
            listarInformes()
            {
                let me=this;
                var url=  this.ruta +'/info_auxiliares/selectInformes';
                axios.get(url).then(function (response) {
                     var respuesta= response;
                    //console.log(respuesta.informes);
                    me.arrayInformes = respuesta.data.informes;   
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            abrirModal(tipo_cta){               
                this.arrayCuentas=[];
                this.modal = 1;
                this.tipo_cta = tipo_cta;
                this.tituloModal = 'Seleccione una cuenta';
            },
            abrirModalT(tipo_cta){               
                this.arrayTerceros=[];
                this.modal2 = 1;
                this.tipo_cta = tipo_cta;
                this.tituloModal = 'Seleccione un tercero';
            },
            cerrarModal(){
                this.modal=0;
                this.tituloModal2='';
                this.tipo_cta = '';
                this.cta_busq = '';
            }, 
            cerrarModalT(){
                this.modal2=0;
                this.tituloModal2='';
                this.terc_busq = '';
            }, 
            buscarCuenta(){
                let me=this;            
                var url= this.ruta +'/planCuentas/selectCuentaInfo?busqueda=' + me.cta_busq;

                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayCuentas = respuesta.cuentas;

                    
                })
                .catch(function (error) {
                    console.log(error);
                });

            },
            cargarCuenta(cuenta){
                
                if(this.tipo_cta == "1")
                {
                    this.cuenta_ini = cuenta['codigo'];
                    this.id_cuenta_ini = cuenta['id'];
                }
                if(this.tipo_cta == "2")
                {
                    this.cuenta_fin = cuenta['codigo'];
                    this.id_cuenta_fin = cuenta['id'];
                }
                
                this.cerrarModal();
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
            
            verAuxConSaldos(){
                let me=this;
                var url= this.ruta +'/info_auxiliares/aux_con_saldos?id_tercero=' + me.id_rercero + '&cuenta_ini='+ me.cuenta_ini + '&cuenta_fin='+ me.cuenta_fin + '&cuenta_fin='+ me.cuenta_fin + '&id_cuenta_ini=' +me.id_cuenta_ini+ '&id_cuenta_fin=' + me.id_cuenta_fin+'&id_tercero=' + me.id_tercero + '&fecha_ini=' + me.fecha_ini + '&fecha_fin=' + me.fecha_fin + '&id_formato='+me.tipo_formato;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    console.log(response.data); 
                    me.informe = respuesta.html;                    
                })
                .catch(function (error) {
                    console.log(error);
                });
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
            
            pdfFormato(){
                let me=this;
                //window.open('http://localhost:8000/fab_Cilindros/listado_pdf?id_proyecto='+ me.id_proyecto + '&fecha_ini='+me.fecha_ini+'&fecha_fin='+me.fecha_fin);
                window.open( this.ruta +'/auxiliares_conta/id_informe?id_proyecto='+ me.id_proyecto + '&fecha_ini='+me.fecha_ini+'&fecha_fin='+me.fecha_fin);
            }, 

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
            var f = yyyy+'-'+mm+'-'+'01';
            d = yyyy+'-'+mm+'-'+dd;
            this.fecha_fin = d;
            this.fecha_ini = f;
            this.selectTipoFormato();
            this.listarInformes();
        }
    }
</script>
<style>    
    .form-control{
        max-height: 30px !important;
        padding: 0.1rem 0.1rem !important;
    }
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
