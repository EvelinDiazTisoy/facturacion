<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\FabCilindros;
use App\FabMuestras;
use App\Empresa;
use Illuminate\Support\Facades\DB;

class FabCilindrosController extends Controller
{
    public function index(Request $request){
        $id = $request->id;
        $id_muestra = $request->id_muestra;
            
        $cons="SELECT * from fab_cilindros WHERE id_proyecto = $id and id_muestra = $id_muestra and condicion = 1 order by dias ASC, fecha_cilindro, id ";
       //echo $cons;
        $cilindros = DB::select($cons);
        $aux_cilindros = array();
        foreach($cilindros as $cil)
        {
            //$aux_cilindros = 
            if(!isset($aux_cilindros[$cil->dias]))
            {
                $aux_cilindros[$cil->dias][0] = $cil->fecha_cilindro;
                $aux_cilindros[$cil->dias][1] = $cil;
            }
            //$aux_cilindros[$cil->dias][0]=$cil->fecha_cilindro;
            //$aux_cilindros[$cil->dias][$cil->id]=$cil;
           // echo $cil->res_cilindro." xxxx<br>";
        }
        //print_r($aux_cilindros); exit;
        return ['cilindros' => $aux_cilindros];
    }
    public function calc_resis($prom,$diametro,$resistencia){
        $pi = pi(); 
        $V1=$prom* 101.97;  $V2=2.54*$diametro; $V3=$V2*$V2;    $con_pi=($pi/4)*$V3;                                
        $V4=$V1/$con_pi;    $V5 =$V4/0.07;  $V5=round($V5,0);
        $Val2 = ($V5/$resistencia)*100; $Val2 = round($Val2,0);

        return $V5;
    }
    public function listado_info(Request $request){
        
        $id_proyecto = $request->id_proyecto;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;
        $arrayCilindros = array();

        $cons="SELECT fab_cilindros.id,fab_proyectos.cliente,fab_proyectos.id as id_proyecto,fecha_cilindro,fab_proyectos.fecha, DATEDIFF(fecha_cilindro , fab_muestras.fec_muestra) as edad,fab_muestras.descripcion,nom_cilindro,diametro_cilindro as diametro, fab_muestras.por_fallar,resist_dise, nom_cilindro,nom_cilindro2,nom_cilindro3,nom_cilindro4,nom_cilindro5,nom_cilindro6, res_cilindro, res_cilindro2, res_cilindro3, res_cilindro4, res_cilindro5, res_cilindro6,num_cilindros
        from fab_cilindros,fab_muestras,fab_proyectos WHERE fab_cilindros.id_muestra = fab_muestras.id and fab_cilindros.id_proyecto= fab_proyectos.id and  fab_cilindros.id_proyecto = $id_proyecto  and fecha_cilindro >='$fecha_ini' and fecha_cilindro<='$fecha_fin' and fab_cilindros.condicion = 1 ORDER BY fecha_cilindro desc, id desc ";

        $cilindros = DB::select($cons);
       
        foreach($cilindros as $c){
            
            //echo " ss ".$c->descripcion;
            $resist=0; $diametro = $c->diametro;
            if($c->res_cilindro)
                $resist = $c->res_cilindro;
            $resist_dise = $c->resist_dise;
            
            $resist = $this->calc_resis($resist,$diametro,$resist_dise);
            //echo "resist=$resist  ";
            $porcent_resist=0;
            $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
            $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);
            
            $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id, "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro, "res_cilindro" => $c->res_cilindro, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist, "val_res_kg" => $val_res_kg);
            
            if($c->num_cilindros>1){

                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro2)
                    $resist = $c->res_cilindro2;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;  
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".2", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro2, "res_cilindro" => $c->res_cilindro2, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
            if($c->num_cilindros>2){
                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro3)
                    $resist = $c->res_cilindro3;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".3", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro3, "res_cilindro" => $c->res_cilindro3, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
            if($c->num_cilindros>3){
                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro4)
                    $resist = $c->res_cilindro4;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".4", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro4, "res_cilindro" => $c->res_cilindro4, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
            if($c->num_cilindros>4){
                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro5)
                    $resist = $c->res_cilindro5;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".5", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro5, "res_cilindro" => $c->res_cilindro5, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
            if($c->num_cilindros>5){
                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro6)
                    $resist = $c->res_cilindro6;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".6", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro6, "res_cilindro" => $c->res_cilindro6, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
        }
        //print_r($arrayCilindros);
        return ['cilindros' => $arrayCilindros];
    }

    public function listado_pdf(Request $request){
        
        $id_proyecto = $request->id_proyecto;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;
        $id_cliente=""; $Nom_proyecto = "";
        $cons="SELECT fab_cilindros.id,fab_proyectos.cliente,fab_proyectos.id as id_proyecto,fecha_cilindro,fab_proyectos.fecha, DATEDIFF(fecha_cilindro , fab_muestras.fec_muestra) as edad,fab_muestras.descripcion,nom_cilindro,diametro_cilindro as diametro, fab_muestras.por_fallar,resist_dise, nom_cilindro,nom_cilindro2,nom_cilindro3,nom_cilindro4,nom_cilindro5,nom_cilindro6, res_cilindro, res_cilindro2, res_cilindro3, res_cilindro4, res_cilindro5, res_cilindro6,num_cilindros,nom_proyecto
        from fab_cilindros,fab_muestras,fab_proyectos WHERE fab_cilindros.id_muestra = fab_muestras.id and fab_cilindros.id_proyecto= fab_proyectos.id and  fab_cilindros.id_proyecto = $id_proyecto  and fecha_cilindro >='$fecha_ini' and fecha_cilindro<='$fecha_fin' and fab_cilindros.condicion = 1 ORDER BY fecha_cilindro desc, id desc ";

        $cilindros = DB::select($cons);
        $arrayCilindros = array();
        foreach($cilindros as $c){
            $id_cliente = $c->cliente;
            $Nom_proyecto = $c->nom_proyecto;
            //echo " ss ".$c->descripcion;
            $resist=0; $diametro = $c->diametro;
            if($c->res_cilindro)
                $resist = $c->res_cilindro;
            $resist_dise = $c->resist_dise;
            
            $resist = $this->calc_resis($resist,$diametro,$resist_dise);
            //echo "resist=$resist  ";
            $porcent_resist=0;
            $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
            $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);
            
            $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id, "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro, "res_cilindro" => $c->res_cilindro, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist, "val_res_kg" => $val_res_kg);
            
            if($c->num_cilindros>1){

                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro2)
                    $resist = $c->res_cilindro2;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;  
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".2", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro2, "res_cilindro" => $c->res_cilindro2, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
            if($c->num_cilindros>2){
                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro3)
                    $resist = $c->res_cilindro3;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".3", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro3, "res_cilindro" => $c->res_cilindro3, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
            if($c->num_cilindros>3){
                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro4)
                    $resist = $c->res_cilindro4;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".4", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro4, "res_cilindro" => $c->res_cilindro4, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
            if($c->num_cilindros>4){
                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro5)
                    $resist = $c->res_cilindro5;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".5", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro5, "res_cilindro" => $c->res_cilindro5, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
            if($c->num_cilindros>5){
                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro6)
                    $resist = $c->res_cilindro6;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".6", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro6, "res_cilindro" => $c->res_cilindro6, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
        }
       
        //return ['cilindros' => $arrayCilindros];
        
        //return ['cilindros'=>$cilindros];
        $cons="SELECT * from empresa ";
       //echo $cons;
        $Empresa = DB::select($cons);
        $emp = array();
        $emp = $Empresa[0];
        $Nom_cliente="";
        if($id_cliente)
        {
            $cons="SELECT nombre,nombre1,nombre2,apellido1,apellido2 from personas where id = $id_cliente ";
            //echo $cons;
            $persona = DB::select($cons);
            if($persona[0]->nombre!=''){ 
                $Nom_cliente = $persona[0]->nombre;
            } 
            else { 
                $Nom_cliente = $persona[0]->nombre1." ".$persona[0]->nombre2." ".$persona[0]->apellido1." ".$persona[0]->apellido2 ;
            }
        }
        
        $AuxArrayCilindros['datos_empresa'] = $emp;
        //print_r($AuxArrayCilindros['datos_empresa']); exit;
        $AuxArrayCilindros['global_id_proyecto'] = $id_proyecto;
        $AuxArrayCilindros['global_nom_proyecto'] = $Nom_proyecto;
        $AuxArrayCilindros['global_nom_cliente'] = $Nom_cliente;
        $AuxArrayCilindros['cilindros'] = $arrayCilindros;
        
        $pdf = \PDF::loadView('pdf.fab_reporte',['datos'=>$AuxArrayCilindros]);
        return view('pdf.fab_reporte', ['datos' => $AuxArrayCilindros]);
        //return $pdf->download('informe_cilindros.pdf');
    }
    
    public function listado_info2(Request $request){
        
        $id_proyecto="and fab_cilindros.id_proyecto !=-1";
        
        if($request->id_proyecto)
            $id_proyecto = "and fab_cilindros.id_proyecto=".$request->id_proyecto;     

        

        $fecha = date('Y-m-j');
        $fec_actual = strtotime ( '-1 day' , strtotime ( $fecha ) ) ;
        $nuevafecha = strtotime ( '+2 day' , strtotime ( $fecha ) ) ;

        $nuevafecha = date ( 'Y-m-j' , $nuevafecha );

        $condicion="and (fecha_cilindro >'$fec_actual' or fecha_cilindro>='$nuevafecha')";
        if($request->estado=="vencidos"){
            $condicion = " and fecha_cilindro >'$fec_actual'";
        }
        elseif($request->estado=="por_vencer"){
            $condicion = " and fecha_cilindro >='$nuevafecha' and fecha_cilindro<$fec_actual"; 
        }

        $cons="SELECT fab_muestras.id, fab_proyectos.id as id_proyecto, nom_proyecto, fec_muestra, nombre, nombre1, nombre2, apellido1, apellido2, descripcion, CASE WHEN fecha_cilindro > '$fec_actual' THEN 'Vencido' WHEN fecha_cilindro >= '$nuevafecha' and fecha_cilindro<$fec_actual THEN 'Por Vencer'        ELSE '' END AS estado_cil from fab_cilindros,fab_muestras,fab_proyectos, personas WHERE fab_cilindros.id_muestra = fab_muestras.id and fab_cilindros.id_proyecto = fab_proyectos.id and fab_proyectos.cliente = personas.id $id_proyecto  $condicion and fab_muestras.por_fallar=1 and fab_cilindros.condicion = 1 ORDER BY fecha_cilindro desc, id desc ";

        $cilindros = DB::select($cons);

       
        
       // echo "$cons  ----   nuevafecha:".$nuevafecha;

        //print_r($cilindros);
        
        //return ['cilindros'=>$cilindros];
        //$pdf = \PDF::loadView('pdf.fab_reporte',['cilindros'=>$cilindros]);
        return ['cilindros' => $cilindros];
        //return $pdf->download('informe_cilindros.pdf');
    }
    
    public function list_proyectos(Request $request)
    {
        $cons="select id,nom_proyecto from fab_proyectos where condicion != 0 order by nom_proyecto";
        $proyectos = DB::select($cons);
        return ['proyectos' => $proyectos];

        
    }
    
    public function ejemplo(Request $request)
    {
        $id_proyecto = $request->id_proyecto;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;
        $id_cliente=""; $Nom_proyecto = "";
        $cons="SELECT fab_cilindros.id,fab_proyectos.cliente,fab_proyectos.id as id_proyecto,fecha_cilindro,fab_proyectos.fecha, DATEDIFF(fecha_cilindro , fab_muestras.fec_muestra) as edad,fab_muestras.descripcion,nom_cilindro,diametro_cilindro as diametro, fab_muestras.por_fallar,resist_dise, nom_cilindro,nom_cilindro2,nom_cilindro3,nom_cilindro4,nom_cilindro5,nom_cilindro6, res_cilindro, res_cilindro2, res_cilindro3, res_cilindro4, res_cilindro5, res_cilindro6,num_cilindros,nom_proyecto
        from fab_cilindros,fab_muestras,fab_proyectos WHERE fab_cilindros.id_muestra = fab_muestras.id and fab_cilindros.id_proyecto= fab_proyectos.id and  fab_cilindros.id_proyecto = $id_proyecto  and fecha_cilindro >='$fecha_ini' and fecha_cilindro<='$fecha_fin' and fab_cilindros.condicion = 1 ORDER BY fecha_cilindro desc, id desc ";

        $cilindros = DB::select($cons);
        $arrayCilindros = array();
        foreach($cilindros as $c){
            $id_cliente = $c->cliente;
            $Nom_proyecto = $c->nom_proyecto;
            //echo " ss ".$c->descripcion;
            $resist=0; $diametro = $c->diametro;
            if($c->res_cilindro)
                $resist = $c->res_cilindro;
            $resist_dise = $c->resist_dise;
            
            $resist = $this->calc_resis($resist,$diametro,$resist_dise);
            //echo "resist=$resist  ";
            $porcent_resist=0;
            $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
            $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);
            
            $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id, "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro, "res_cilindro" => $c->res_cilindro, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist, "val_res_kg" => $val_res_kg);
            
            if($c->num_cilindros>1){

                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro2)
                    $resist = $c->res_cilindro2;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;  
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".2", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro2, "res_cilindro" => $c->res_cilindro2, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
            if($c->num_cilindros>2){
                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro3)
                    $resist = $c->res_cilindro3;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".3", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro3, "res_cilindro" => $c->res_cilindro3, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
            if($c->num_cilindros>3){
                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro4)
                    $resist = $c->res_cilindro4;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".4", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro4, "res_cilindro" => $c->res_cilindro4, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
            if($c->num_cilindros>4){
                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro5)
                    $resist = $c->res_cilindro5;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".5", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro5, "res_cilindro" => $c->res_cilindro5, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
            if($c->num_cilindros>5){
                $resist=0; $diametro = $c->diametro;
                if($c->res_cilindro6)
                    $resist = $c->res_cilindro6;
                $resist_dise = $c->resist_dise;
                
                $resist = $this->calc_resis($resist,$diametro,$resist_dise);
                //echo "resist=$resist  ";
                $porcent_resist=0;
                $porcent_resist = ($resist/$resist_dise)*100; $porcent_resist = round($porcent_resist,0);
                $val_res_kg=0;  $val_res_kg = $resist*0.07; $val_res_kg = round($val_res_kg,0);

                $arrayCilindros[] = array("descripcion" => $c->descripcion, "id"=>$c->id.".6", "cliente" => $c->cliente, "id_proyecto" => $c->id_proyecto, "fecha_cilindro" => $c->fecha_cilindro, "fecha" => $c->fecha, "edad" => $c->edad, "descripcion"=> $c->descripcion, "nom_cilindro"=> $c->nom_cilindro6, "res_cilindro" => $c->res_cilindro6, "diametro"=> $c->diametro, "resist_dise"=> $c->resist_dise, "val_resis"=>$resist, "porcent_resist" => $porcent_resist , "val_res_kg" => $val_res_kg);
            }
        }

        $cons="SELECT * from empresa ";
       //echo $cons;
        $Empresa = DB::select($cons);
        $emp = array();
        $emp = $Empresa[0];
        $Nom_cliente="";
        if($id_cliente)
        {
            $cons="SELECT nombre,nombre1,nombre2,apellido1,apellido2 from personas where id = $id_cliente ";
            //echo $cons;
            $persona = DB::select($cons);
            if($persona[0]->nombre!=''){ 
                $Nom_cliente = $persona[0]->nombre;
            } 
            else { 
                $Nom_cliente = $persona[0]->nombre1." ".$persona[0]->nombre2." ".$persona[0]->apellido1." ".$persona[0]->apellido2 ;
            }
        }
        
        $AuxArrayCilindros['datos_empresa'] = $emp;
        //print_r($AuxArrayCilindros['datos_empresa']); exit;
        $AuxArrayCilindros['global_id_proyecto'] = $id_proyecto;
        $AuxArrayCilindros['global_nom_proyecto'] = $Nom_proyecto;
        $AuxArrayCilindros['global_nom_cliente'] = $Nom_cliente;
        $AuxArrayCilindros['cilindros'] = $arrayCilindros;
        $pdf = \PDF::loadView('pdf.ejemplo',['datos'=>$AuxArrayCilindros, 'emp'=>$emp]);
        return $pdf->download('ejemplo.pdf');
    }

    public function store(Request $request){
        //if (!$request->ajax() return redirect('/');

        $ban_fallar = 0;
        $cilindro = new FabCilindros();
        $cilindro->id_proyecto = $request->id_proyecto;
        $cilindro->id_muestra = $request->id_muestra;

        $cilindro->num_cilindros = $request->num_cilindros;
        $cilindro->dias = $request->dias;
        $cilindro->fecha_cilindro = $request->fecha_cilindro;
        
        $cilindro->nom_cilindro = $request->nom_cilindro;
        $cilindro->res_cilindro = $request->res_cilindro; 
        $cilindro->nom_cilindro2 = $request->nom_cilindro2;
        $cilindro->res_cilindro2 = $request->res_cilindro2; 
        $cilindro->nom_cilindro3 = $request->nom_cilindro3;
        $cilindro->res_cilindro3 = $request->res_cilindro3; 
        $cilindro->nom_cilindro4 = $request->nom_cilindro4;
        $cilindro->res_cilindro4 = $request->res_cilindro4; 
        $cilindro->nom_cilindro5 = $request->nom_cilindro5;
        $cilindro->res_cilindro5 = $request->res_cilindro5; 
        $cilindro->nom_cilindro6 = $request->nom_cilindro6;
        $cilindro->res_cilindro6 = $request->res_cilindro6;     
        if(!$request->res_cilindro) { $ban_fallar = 1; }
        if($request->num_cilindros>=2 && !$request->res_cilindro2) { $ban_fallar = 1; }
        if($request->num_cilindros>=3 && !$request->res_cilindro3) { $ban_fallar = 1; }
        if($request->num_cilindros>=4 && !$request->res_cilindro4) { $ban_fallar = 1; }
        if($request->num_cilindros>=5 && !$request->res_cilindro5) { $ban_fallar = 1; }
        if($request->num_cilindros>=6 && !$request->res_cilindro6) { $ban_fallar = 1; }
        
        $muestra = FabMuestras::findOrFail($request->id_muestra);

        if($ban_fallar==1)        
            $muestra->por_fallar = '1';
        else
        $muestra->por_fallar = '0';

        $muestra->save();
       // $cilindro->condicion = '1';
        $cilindro->save();
    }

    public function update(Request $request){
        $ban_fallar = 0;
        //if (!$request->ajax()) return redirect('/');
        $cilindro = FabCilindros::findOrFail($request->id);
        
        $cilindro->id_proyecto = $request->id_proyecto;
        $cilindro->id_muestra = $request->id_muestra;

        $cilindro->num_cilindros = $request->num_cilindros;
        $cilindro->dias = $request->dias;
        $cilindro->fecha_cilindro = $request->fecha_cilindro;
        
        $cilindro->nom_cilindro = $request->nom_cilindro;
        $cilindro->res_cilindro = $request->res_cilindro; 
        $cilindro->nom_cilindro2 = $request->nom_cilindro2;
        $cilindro->res_cilindro2 = $request->res_cilindro2; 
        $cilindro->nom_cilindro3 = $request->nom_cilindro3;
        $cilindro->res_cilindro3 = $request->res_cilindro3; 
        $cilindro->nom_cilindro4 = $request->nom_cilindro4;
        $cilindro->res_cilindro4 = $request->res_cilindro4; 
        $cilindro->nom_cilindro5 = $request->nom_cilindro5;
        $cilindro->res_cilindro5 = $request->res_cilindro5; 
        $cilindro->nom_cilindro6 = $request->nom_cilindro6;
        $cilindro->res_cilindro6 = $request->res_cilindro6;     
        if(!$request->res_cilindro) { $ban_fallar = 1; }
        if($request->num_cilindros>=2 && !$request->res_cilindro2) { $ban_fallar = 1; }
        if($request->num_cilindros>=3 && !$request->res_cilindro3) { $ban_fallar = 1; }
        if($request->num_cilindros>=4 && !$request->res_cilindro4) { $ban_fallar = 1; }
        if($request->num_cilindros>=5 && !$request->res_cilindro5) { $ban_fallar = 1; }
        if($request->num_cilindros>=6 && !$request->res_cilindro6) { $ban_fallar = 1; }
        
        
        $muestra = FabMuestras::findOrFail($request->id_muestra);
        
        if($ban_fallar==1)        
            $muestra->por_fallar = '1';
        else
        $muestra->por_fallar = '0';

        $muestra->save();
       // $cilindro->condicion = '1';
        $cilindro->save();
    }

    public function update_cilindro(Request $request){
        $ban_fallar = 0;
       
        //echo "llega =".$request->id;
        //if (!$request->ajax()) return redirect('/');
        
        $cilindro = FabCilindros::findOrFail($request->id);
        
        $cilindro->id_proyecto = $request->id_proyecto;
        $cilindro->id_muestra = $request->id_muestra;

        $cilindro->num_cilindros = $request->num_cilindros;
        $cilindro->dias = $request->dias;
        $cilindro->fecha_cilindro = $request->fecha_cilindro;
        
        $cilindro->nom_cilindro = $request->nom_cilindro;
        $cilindro->res_cilindro = $request->res_cilindro; 
        $cilindro->nom_cilindro2 = $request->nom_cilindro2;
        $cilindro->res_cilindro2 = $request->res_cilindro2; 
        $cilindro->nom_cilindro3 = $request->nom_cilindro3;
        $cilindro->res_cilindro3 = $request->res_cilindro3; 
        $cilindro->nom_cilindro4 = $request->nom_cilindro4;
        $cilindro->res_cilindro4 = $request->res_cilindro4; 
        $cilindro->nom_cilindro5 = $request->nom_cilindro5;
        $cilindro->res_cilindro5 = $request->res_cilindro5; 
        $cilindro->nom_cilindro6 = $request->nom_cilindro6;
        $cilindro->res_cilindro6 = $request->res_cilindro6;     
        if(!$request->res_cilindro) { $ban_fallar = 1; }
        if($request->num_cilindros>=2 && !$request->res_cilindro2) { $ban_fallar = 1; }
        if($request->num_cilindros>=3 && !$request->res_cilindro3) { $ban_fallar = 1; }
        if($request->num_cilindros>=4 && !$request->res_cilindro4) { $ban_fallar = 1; }
        if($request->num_cilindros>=5 && !$request->res_cilindro5) { $ban_fallar = 1; }
        if($request->num_cilindros>=6 && !$request->res_cilindro6) { $ban_fallar = 1; }
        
        $muestra = FabMuestras::findOrFail($request->id_muestra);

        if($ban_fallar==1)        
            $muestra->por_fallar = '1';
        else
        $muestra->por_fallar = '0';

        $muestra->save();
       // $cilindro->condicion = '1';
        $cilindro->save();
    }
}
