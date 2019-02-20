<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Concentracion;

class ConcentracionController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        
        if ($buscar==''){
            $concentracion = Concentracion::orderBy('id', 'desc')->paginate(3);
        }
        else{
            $concentracion = Concentracion::where($criterio, 'like', '%'. $buscar . '%')->orderBy('id', 'desc')->paginate(3);
        }
        

        return [
            'pagination' => [
                'total'        => $concentracion->total(),
                'current_page' => $concentracion->currentPage(),
                'per_page'     => $concentracion->perPage(),
                'last_page'    => $concentracion->lastPage(),
                'from'         => $concentracion->firstItem(),
                'to'           => $concentracion->lastItem(),
            ],
            'concentracion' => $concentracion
        ];
    }

    public function selectConcentracion(Request $request){
        if (!$request->ajax()) return redirect('/');
        $concentracion = Concentracion::select('id','nombre')->orderBy('nombre', 'asc')->get();
        
        return ['concentracion' => $concentracion];
    }

    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $concentracion = new Concentracion();
        $concentracion->nombre = $request->nombre;
        $concentracion->save();
    }

    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $concentracion = Concentracion::findOrFail($request->id);
        $concentracion->nombre = $request->nombre;
        $concentracion->save();
    }
}
