<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Presentacion;

class PresentacionController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        
        if ($buscar==''){
            $presentacion = Presentacion::orderBy('id', 'desc')->paginate(3);
        }
        else{
            $presentacion = Presentacion::where($criterio, 'like', '%'. $buscar . '%')->orderBy('id', 'desc')->paginate(3);
        }
        

        return [
            'pagination' => [
                'total'        => $presentacion->total(),
                'current_page' => $presentacion->currentPage(),
                'per_page'     => $presentacion->perPage(),
                'last_page'    => $presentacion->lastPage(),
                'from'         => $presentacion->firstItem(),
                'to'           => $presentacion->lastItem(),
            ],
            'presentacion' => $presentacion
        ];
    }

    public function selectPresentacion(Request $request){
        if (!$request->ajax()) return redirect('/');
        $presentacion = Presentacion::select('id','nombre')->orderBy('nombre', 'asc')->get();
        
        return ['presentacion' => $presentacion];
    }

    public function store(Request $request)
    {
        // if (!$request->ajax()) return redirect('/');
        $presentacion = new Presentacion();
        $presentacion->nombre = $request->nombre;
        $presentacion->save();
    }

    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $presentacion = Presentacion::findOrFail($request->id);
        $presentacion->nombre = $request->nombre;
        $presentacion->save();
    }
}
