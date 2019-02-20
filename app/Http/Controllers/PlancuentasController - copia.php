<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\PlanCuenta;


class PlancuentasController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        
        if ($buscar==''){
            $planCuenta = PlanCuenta::orderBy('id', 'desc')->paginate(3);
        }
        else{
            $planCuenta = PlanCuenta::where($criterio, 'like', '%'. $buscar . '%')->orderBy('id', 'desc')->paginate(3);
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
        if (!$request->ajax()) return redirect('/');
        $planCuenta = PlanCuenta::where('condicion','=','1')
        ->select('id','codigo','nombre')->orderBy('nombre', 'asc')->get();
        return ['cuentas' => $planCuenta];
    }

   
    public function store(Request $request)
    {
        //if (!$request->ajax()) return redirect('/');
        echo "llega"; 
        
        $planCuenta = new PlanCuenta();
        $planCuenta->codigo = $request->codigo;
        $planCuenta->nombre = $request->nombre;
        $planCuenta->naturaleza = $request->naturaleza;
        $planCuenta->tipo = $request->tipo;
        $planCuenta->corriente = $request->corriente;
        $planCuenta->diferido = $request->diferido;
        $planCuenta->tercero = $request->tercero;
        $planCuenta->niif = $request->niif;
        $planCuenta->anio = $request->anio;        
        $planCuenta->condicion = '1';
        $planCuenta->save();
    }
  

  
    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $planCuenta = PlanCuenta::findOrFail($request->id);
        $planCuenta->codigo = $request->codigo;
        $planCuenta->nombre = $request->nombre;
        $planCuenta->naturaleza = $request->naturaleza;
        $planCuenta->tipo = $request->tipo;
        $planCuenta->corriente = $request->corriente;
        $planCuenta->diferido = $request->diferido;
        $planCuenta->tercero = $request->tercero;
        $planCuenta->niif = $request->niif;
        $planCuenta->anio = $request->anio;        
        $planCuenta->condicion = '1';
        $planCuenta->save();
    }

    public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $planCuenta = PlanCuenta::findOrFail($request->id);
        $planCuenta->condicion = '0';
        $planCuenta->save();
    }

    public function activar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $planCuenta = PlanCuenta::findOrFail($request->id);
        $planCuenta->condicion = '1';
        $planCuenta->save();
    }
    
}
