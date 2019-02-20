<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\UndMedida;

class UndMedidaController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        
        if ($buscar==''){
            $und_medida = UndMedida::orderBy('id', 'desc')->paginate(3);
        }
        else{
            $und_medida = UndMedida::where($criterio, 'like', '%'. $buscar . '%')->orderBy('id', 'desc')->paginate(3);
        }
        

        return [
            'pagination' => [
                'total'        => $und_medida->total(),
                'current_page' => $und_medida->currentPage(),
                'per_page'     => $und_medida->perPage(),
                'last_page'    => $und_medida->lastPage(),
                'from'         => $und_medida->firstItem(),
                'to'           => $und_medida->lastItem(),
            ],
            'und_medida' => $und_medida
        ];
    }

    public function selectUndMedida(Request $request){
        if (!$request->ajax()) return redirect('/');
        $und_medida = UndMedida::select('id','nombre')->orderBy('nombre', 'asc')->get();
        
        return ['unidades' => $und_medida];
    }

    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $und_medida = new UndMedida();
        $und_medida->nombre = $request->nombre;
        $und_medida->save();
    }

    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $und_medida = UndMedida::findOrFail($request->id);
        $und_medida->nombre = $request->nombre;
        $und_medida->save();
    }
}
