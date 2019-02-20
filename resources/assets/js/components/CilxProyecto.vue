<template>
        <main class="main">
        <!-- Breadcrumb -->
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/">Escritorio</a></li>
        </ol>
        <div class="container-fluid">
            <!-- Ejemplo de tabla Listado -->
            <div class="card">
                
                <div class="card-body">
                    <div class="form-group row">
                        <div class="col-md-1   ">
                            <label style='margin-top: 3px;'><b>Proyecto*</b></label>                                
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">                                                                  
                                <select class="form-control" v-model="id_proyecto">
                                    <option value="0" disabled>Seleccione</option>
                                    <option v-for="proyecto in arrayProyectos" :key="proyecto.id" :value="proyecto.id" v-text="proyecto.nom_proyecto"></option>
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
                        <div class="col-md-1">
                            <button title="Ver" type="button" class="btn btn-primary btn-sm" @click="listarCilindros()">
                                Ver
                            </button>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12">                            
                            <center><button type="button" class="btn btn-danger btn-sm" @click="pdfFormato()">PDF</button></center>
                        </div>
                    </div> 
                    <table class="table table-bordered table-striped table-sm">
                        <thead>
                            <tr>
                                <th rowspan="2">Cod. Cilindro</th>
                                <th rowspan="2">Fecha Fundición</th>
                                <th rowspan="2">Fecha Rotura</th>
                                <th rowspan="2">Edad</th>
                                <th rowspan="2">Localización</th>
                                <th rowspan="2">No. Muestra</th>
                                <th rowspan="2">Diametro</th>
                                <th rowspan="2">Carga Máxima</th>
                                <th colspan="2">Resistencia conseguida</th>
                                <th rowspan="2">Res. de Diseño [PSI]</th>
                                <th rowspan="2">%</th>
                                <th rowspan="2">Estado</th>
                            </tr>
                            <tr><th>[KG/CM<sup>2</sup>]</th><th>[PSI]</th></tr>
                        </thead>
                        <tbody>
                            <tr v-for="cilindro in arrayCilindros" :key="cilindro.id">
                                
                                <td >{{ 'C'+cilindro.cliente+'-'+cilindro.id_proyecto+'-E'+cilindro.id }}</td>
                                <td v-text="cilindro.fecha_cilindro"></td>
                                <td v-text="cilindro.fecha"></td>
                                <td v-text="cilindro.edad"></td>
                                <td v-text="cilindro.descripcion"></td><td v-text="cilindro.nom_cilindro"></td><td v-text="cilindro.diametro"></td>
                                <td v-text="cilindro.res_cilindro"></td><td v-text="cilindro.val_res_kg"></td><td v-text="cilindro.val_resis"></td><td v-text="cilindro.resist_dise"></td><td v-text="cilindro.porcent_resist+'%'"></td>
                                <td>  
                                    <div v-if="cilindro.por_fallar">
                                        <span class="badge badge-danger">Por Fallar</span>
                                    </div>
                                    <div v-else>
                                        <span class="badge badge-success">Fallado</span>
                                        
                                    </div>
                                    
                                </td>
                            </tr>                                
                        </tbody>
                    </table>                        
                </div>
            </div>
            <!-- Fin ejemplo de tabla Listado -->
        </div>
        
    </main>
</template>

<script>
    import VueBarcode from 'vue-barcode';
    export default {
        props : ['ruta'],
        data (){
            return {
                id_proyecto: 0,
                fecha_ini :'',
                fecha_fin : '',                
                arrayCilindros : [],     
                arrayProyectos : [],
                buscar : '',                
            }
        },
        components: {
            'barcode': VueBarcode
        
        },
        computed:{
           
            //Calcula los elementos de la paginación
            
        },
        methods : {
            listarCilindros (){
                let me=this;
                if(me.id_proyecto == '')
                {
                    alert("Seleccione el proyecto");
                }
                else{
                    if(me.fecha_ini==''||me.fecha_fin==''){
                        alert("Debe seleccionar las fechas de busqueda");
                    }    
                    else{
                        var url= this.ruta +'/fab_Cilindros/listado_info?id_proyecto=' + me.id_proyecto + '&fecha_ini='+ me.fecha_ini + '&fecha_fin='+ me.fecha_fin;
                        axios.get(url).then(function (response) {
                            var respuesta= response;
                            //console.log(respuesta.data.cilindros);
                            me.arrayCilindros = respuesta.data.cilindros;   
                        })
                        .catch(function (error) {
                            console.log(error);
                        });
                    }
                }

            },
            listarProyectos(){
                let me=this;
                var url= this.ruta +'/fab_Cilindros/list_proyectos';
                axios.get(url).then(function (response) {
                     var respuesta= response;
                    //console.log(respuesta.data.muestras);
                    me.arrayProyectos = respuesta.data.proyectos;   
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
           pdfFormato(){
                let me=this;
                //window.open('http://localhost:8000/fab_Cilindros/listado_pdf?id_proyecto='+ me.id_proyecto + '&fecha_ini='+me.fecha_ini+'&fecha_fin='+me.fecha_fin);
                window.open(this.ruta +'/fab_Cilindros/ejemplo?id_proyecto='+ me.id_proyecto + '&fecha_ini='+me.fecha_ini+'&fecha_fin='+me.fecha_fin);
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
            this.listarProyectos();
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
