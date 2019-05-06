<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Plancuentas_model;


class PlanCuentas extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        $id_empresa = $request->session()->get('id_empresa');
        // echo "criterio=$criterio buscar=$buscar"; exit;     
        if ($buscar==''){
            $planCuenta = Plancuentas_model::where('id_empresa','=',$id_empresa)->orderBy('codigo', 'asc')->paginate(10);
        }
        else{
            $planCuenta = Plancuentas_model::where('id_empresa','=',$id_empresa)->where($criterio, 'like',  $buscar . '%')->orderBy('codigo', 'asc')->paginate(10);
        }
        

        return [
            'pagination' => [
                'total'        => $planCuenta->total(),
                'current_page' => $planCuenta->currentPage(),
                'per_page'     => $planCuenta->perPage(),
                'last_page'    => $planCuenta->lastPage(),
                'from'         => $planCuenta->firstItem(),
                'to'           => $planCuenta->lastItem(),
            ],
            'planCuentas' => $planCuenta
        ];
    }

    public function selectCuenta(Request $request){
        //if (!$request->ajax()) return redirect('/');
        //print_r($request);
        $filtro = $request->filtro;
       // echo "filtro=$filtro";
        if($filtro){
           
            $condicion="codigo"; $valor="$filtro%";
        }
        else{
            $condicion='condicion'; $valor='1';
        }
        $planCuenta = Plancuentas_model::where('condicion','=','1')->where($condicion,'like',$valor)
        ->select('id','codigo','nombre')->orderBy('nombre', 'asc')->get();
        return ['cuentas' => $planCuenta];
    }


    public function selectCuenta2(Request $request){
        //if (!$request->ajax()) return redirect('/');
        //print_r($request);
        $filtro = $request->filtro;
       // echo "filtro=$filtro";
        if($filtro){
           
            $condicion="codigo"; $valor="$filtro%";
        }
        else{
            $condicion='condicion'; $valor='1';
        }
        $planCuenta = Plancuentas_model::where('tipo','=','Detalle')->where('condicion','=','1')->where($condicion,'like',$valor)
        ->select('id','codigo','nombre','tipo','naturaleza')->orderBy('anio', 'desc')->orderBy('nombre', 'asc')->get();
        return ['cuentas' => $planCuenta];
    }

    public function selectCuentaInfo(Request $request){
        //if (!$request->ajax()) return redirect('/');
        //print_r($request);
        $busqueda = $request->busqueda;
        
       // echo "filtro=$filtro";
        
        $planCuenta = Plancuentas_model::where('condicion','=','1')->where('codigo','like',$busqueda.'%')->orWhere('nombre','like','%'.$busqueda.'%')
        ->select('id','codigo','nombre','tipo','naturaleza')->orderBy('nombre', 'asc')->get();
        return ['cuentas' => $planCuenta];
    }
   
    public function store(Request $request)
    {

        if (!$request->ajax()) return redirect('/');
        $planCuenta = new Plancuentas_model();
        $id_empresa = $request->session()->get('id_empresa');
        
       
        //echo "<pre>"; print_r($request); 
        //echo "</pre>";
        
        
        $planCuenta->codigo = $request->codigo;
        $planCuenta->nombre = $request->nombre;
        $planCuenta->naturaleza = $request->naturaleza;
        $planCuenta->tipo = $request->tipo;
        $planCuenta->corriente = $request->corriente;
        $planCuenta->diferido = $request->diferido;
        $planCuenta->tercero = $request->tercero;
        $planCuenta->niif = $request->niif;
        $planCuenta->id_empresa = $id_empresa;
        $planCuenta->anio = $request->anio;        
        $planCuenta->condicion = $request->condicion; 
        if($request->banco)
            $planCuenta->banco = 1; 
        $planCuenta->save();
        //echo "lleggaaaaa ".$request->nombre;
    }
  

  
    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $id_empresa = $request->session()->get('id_empresa');
        $planCuenta = Plancuentas_model::findOrFail($request->id);
        
        //return "request = ".$request->banco; 
        $planCuenta->codigo = $request->codigo;
        $planCuenta->nombre = $request->nombre;
        $planCuenta->naturaleza = $request->naturaleza;
        $planCuenta->tipo = $request->tipo;
        $planCuenta->corriente = $request->corriente;
        $planCuenta->diferido = $request->diferido;
        $planCuenta->tercero = $request->tercero;
        $planCuenta->niif = $request->niif;
        $planCuenta->id_empresa = $id_empresa;
        $planCuenta->anio = $request->anio; 
        if($request->banco == 1) 
            $planCuenta->banco = '1';        
        $planCuenta->condicion = '1';
        $planCuenta->save();
    }

    public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $planCuenta = Plancuentas_model::findOrFail($request->id);
        $planCuenta->condicion = '0';
        $planCuenta->save();
    }

    public function activar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $planCuenta = Plancuentas_model::findOrFail($request->id);
        $planCuenta->condicion = '1';
        $planCuenta->save();
    }
    
}
