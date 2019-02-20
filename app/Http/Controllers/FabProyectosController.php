<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\FabProyectos;
use App\FabMuestras;
use App\FabCilindros;
use Illuminate\Support\Facades\DB;

class FabProyectosController extends Controller
{
    public function index(Request $request)
    {
        //if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        
        if ($buscar==''){
            $proyectos = FabProyectos::join('personas','fab_proyectos.cliente','=','personas.id')
            ->select('fab_proyectos.id','fab_proyectos.cliente','fab_proyectos.nom_proyecto','fab_proyectos.condicion','fab_proyectos.fecha','personas.nombre','personas.num_documento','personas.nombre1','personas.nombre2', 'personas.apellido1','personas.apellido2','personas.tipo_persona')
            ->orderBy('fab_proyectos.id', 'desc')->paginate(10);
        }
        else{
            $proyectos = FabProyectos::join('personas','fab_proyectos.cliente','=','personas.id')
            ->select('fab_proyectos.id','fab_proyectos.cliente','fab_proyectos.nom_proyecto','fab_proyectos.condicion','fab_proyectos.fecha','personas.nombre','personas.num_documento','personas.nombre1','personas.nombre2', 'personas.apellido1','personas.apellido2','personas.tipo_persona')
            ->where('fab_proyectos.'.$criterio, 'like', '%'. $buscar . '%')
            ->orderBy('fab_proyectos.id', 'desc')->paginate(10);
        }
        

        return [
            'pagination' => [
                'total'        => $proyectos->total(),
                'current_page' => $proyectos->currentPage(),
                'per_page'     => $proyectos->perPage(),
                'last_page'    => $proyectos->lastPage(),
                'from'         => $proyectos->firstItem(),
                'to'           => $proyectos->lastItem(),
            ],
            'proyectos' => $proyectos
        ];
    }
    public function avance(Request $request){
        $id_proyecto = $request->id;
        $listado = array();
        $listado_cil = array(); $list_muestra=array();
        $cons="SELECT id,descripcion,diametro_cilindro,resist_dise FROM fab_muestras WHERE id_proyecto = $id_proyecto and condicion=1
        ORDER BY fec_muestra ASC, id ASC";
       // echo "$cons<br>";
        $muestras = DB::select($cons);        
        $ban1=0;    $pi = pi();  $Aux3="";   $Aux4="";   $list_encab = array(); $encab=""; $cabeza=array();
        foreach($muestras as $muestra){
            $cilindro = array();
            $id_muestra = $muestra->id;
            $diametro = $muestra->diametro_cilindro;
            $resist_dise = $muestra->resist_dise;
           // print_r($muestra);
            //echo "id_muestra=".$id_muestra;
            $listado[$muestra->id][0] = $muestra->descripcion;
            $cons2="SELECT * FROM fab_cilindros where condicion=1 and id_muestra = $id_muestra
            ORDER BY dias ASC";
            //echo $cons."<br>";
            $cilindros = DB::select($cons2);
            $ban=0;
           // $Aux4 = "<td>".$muestra->descripcion."</td>";
            $Aux3="";
            $sum_cilindros=0;
            $listado_cil=array();
            $cont=0;
            foreach($cilindros as $cilindro){
                
                
                $suma=$cilindro->res_cilindro;
                $sum_cilindros += $cilindro->num_cilindros;
                if($cilindro->num_cilindros>=2) $suma+=$cilindro->res_cilindro2;                
                if($cilindro->num_cilindros>=3) $suma+=$cilindro->res_cilindro3;                
                if($cilindro->num_cilindros>=4) $suma+=$cilindro->res_cilindro4;
                if($cilindro->num_cilindros>=5) $suma+=$cilindro->res_cilindro5;
                if($cilindro->num_cilindros>=6) $suma+=$cilindro->res_cilindro6;

                $prom = $suma/$cilindro->num_cilindros;
                $V1=$prom* 101.97;  $V2=2.54*$diametro; $V3=$V2*$V2;    $con_pi=($pi/4)*$V3;
                                
                $V4=$V1/$con_pi;    $V5 =$V4/0.07;  $V5=round($V5,0);
                $Val2 = ($V5/$resist_dise)*100; $Val2 = round($Val2,0);
                $Aux3.="<td>$V5</td><td>$Val2%</td>";
                if(!$V5){$V5="0";}  if(!$Val2){$Val2="0";}
                $listado_cil[$cont]=$V5; $cont++; $listado_cil[$cont]=$Val2; $cont++;
                
                
               // echo "lista = ".$listado_cil[1]."<br>";
                if($ban==0){
                    $encab.="<td>R ".$cilindro->dias." DIAS</td><td>%</td>";
                }
                if($ban1==0){
                    $cabeza[]="R ".$cilindro->dias." DIAS"; $cabeza[]="%";
                }
               
                if(!isset($list_encab[$cilindro->dias])) $list_encab[$cilindro->dias] ="<td>R ".$cilindro->dias." DIAS</td><td>%</td>";
                //echo "prom=$prom v1=$V1 v2=$V2 V3=$V3 con_pi=$con_pi V4=$V4 V5=$V5 Val=$Val2<br>";
               
            }
            $ban=1; $ban1=1;
            if(!$muestra->descripcion){$muestra->descripcion="-";}
            $Aux4.="<tr><td>$sum_cilindros</td><td>".$muestra->descripcion."</td>".$Aux3."</tr>";
            if(!$sum_cilindros){$sum_cilindros="0";}
            //echo "sum_cilindros=".$sum_cilindros."<br>";
            $list_muestra[]=array("id"=>$muestra->id,"n_cils"=>$sum_cilindros,"descrip"=>$muestra->descripcion,"datos"=>$listado_cil);
        }
       
            $NumCols=count($list_encab)*2;
       
            //echo "$Aux";
            $Aux4 = "<table border='1'>
                    <tr>
                        <td rowspan='2'><span style='writing-mode: vertical-lr;transform: rotate(180deg);'># Cilindros</span></td> 
                        <td rowspan='2'>Descripción</td><td colspan='$NumCols'>RESULTADO A COMPRESION (PSI)</td>
                    </tr>
                    <tr align='center'>$encab</tr>
                ".$Aux4."</table>";
                echo $Aux4;
                //print_r($list_muestra);
                /*return [
                    //"avance"=>$Aux4,
                    "NumCols"=>$NumCols,
                    "cils" =>$list_muestra,
                    "cabeza" =>$cabeza,
                    "Aux4" => $Aux4
                ];*/
    //print_r($listado);
       

    }
    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $proyecto = new FabProyectos();
        $proyecto->nom_proyecto = $request->nom_proyecto;
        $proyecto->cliente = $request->cliente;
        $proyecto->fecha = $request->fecha;
        $proyecto->ubicacion = $request->ubicacion;       
        $proyecto->condicion = '1';
        $proyecto->save();
    }
    public function update(Request $request)
    {
        //if (!$request->ajax()) return redirect('/');
        $proyecto = FabProyectos::findOrFail($request->id);
        $proyecto = new FabProyectos();
        $proyecto->nom_proyecto = $request->nom_proyecto;
        $proyecto->cliente = $request->cliente;
        $proyecto->fecha = $request->fecha;   
        $proyecto->ubicacion = $request->ubicacion;            
        $proyecto->save();
    }
    
    public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $proyecto = FabProyectos::findOrFail($request->id);
        $proyecto->condicion = '0';
        $proyecto->save();
    }

    public function activar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $proyecto = FabProyectos::findOrFail($request->id);
        $proyecto->condicion = '1';
        $proyecto->save();
    }

    
}
