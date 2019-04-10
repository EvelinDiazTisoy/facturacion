<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Configuraciones;

class ConfiguracionesController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        
        if ($buscar==''){
            $configuraciones = Configuraciones::orderBy('id', 'desc')->paginate(6);
        }
        else{
            $configuraciones = Configuraciones::where($criterio, 'like', '%'. $buscar . '%')->orderBy('id', 'desc')->paginate(6);
        }
        

        return [
            'pagination' => [
                'total'        => $configuraciones->total(),
                'current_page' => $configuraciones->currentPage(),
                'per_page'     => $configuraciones->perPage(),
                'last_page'    => $configuraciones->lastPage(),
                'from'         => $configuraciones->firstItem(),
                'to'           => $configuraciones->lastItem(),
            ],
            'configuraciones' => $configuraciones
        ];
    }

    public function selectConfiguraciones(Request $request){
        if (!$request->ajax()) return redirect('/');
        $configuraciones = Configuraciones::select('id','lugar')->orderBy('lugar', 'asc')->get();
        
        return ['configuraciones' => $configuraciones];
    }

    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $configuraciones = new Configuraciones();
        $configuraciones->lugar = $request->lugar;
        $configuraciones->save();
    }

    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $configuraciones = Configuraciones::findOrFail($request->id);
        $configuraciones->lugar = $request->lugar;
        $configuraciones->save();
    }
}
