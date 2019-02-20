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
                            <label style='margin-top: 3px;'><b>Estado*</b></label>                                
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <select class="form-control" name="estado" v-model="estado_cil">
                                    <option value="">Todos</option>
                                    <option value="vencidos">Vencidos</option>
                                    <option value="por_vencer">Por Vencer</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="col-md-1">
                            <button title="Ver" type="button" class="btn btn-primary btn-sm" @click="listarCilindros()">
                                Ver
                            </button>
                        </div>
                    </div>
                    
                    <table class="table table-bordered table-striped table-sm">
                        <thead>
                            <tr>
                                <th>Muestra</th>
                                <th>Detalle</th>
                                <th>Proyecto</th>                                
                                <th>Fecha Rotura</th>                                                                
                                <th>Estado</th> 
                            </tr>
                            
                        </thead>
                        <tbody>
                            <tr v-for="c in arrayCilindros" :key="c.id">
                                
                                <td >{{c.id }}</td>
                                <td v-text="c.descripcion"></td>
                                <td v-text="c.id_proyecto+' - '+c.nom_proyecto"></td>                                
                                <td v-text="c.fec_muestra"></td>                                
                                <td>
                                    <div v-if="c.estado_cil=='Vencido'">
                                        <span class="badge badge-danger">Vencido</span>
                                    </div>
                                    <div v-else>
                                        <span class="badge badge-success">Por Vencer</span>
                                        
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
                estado_cil: '',      
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
                
                var url= this.ruta +'/fab_Cilindros/listado_info2?id_proyecto=' + me.id_proyecto + '&estado='+ me.estado_cil;
                axios.get(url).then(function (response) {
                    var respuesta= response;
                      console.log(respuesta.data.cilindros);
                    me.arrayCilindros = respuesta.data.cilindros;   
                })
                .catch(function (error) {
                    console.log(error);
                });           

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
                window.open(this.ruta +'/fab_Cilindros/listado_pdf?id_proyecto='+ me.id_proyecto + '&fecha_ini='+me.fecha_ini+'&fecha_fin='+me.fecha_fin);
            }, 
        },
        mounted() {
            
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
