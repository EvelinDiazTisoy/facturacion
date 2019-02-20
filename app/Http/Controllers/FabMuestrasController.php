<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\FabMuestras;
use Illuminate\Support\Facades\DB;

class FabMuestrasController extends Controller
{
    public function index(Request $request)
    {
        $id = $request->id;
            
        $cons="SELECT * from fab_muestras WHERE id_proyecto = $id and condicion = 1 order by id asc ";
       //echo $cons;
        $muestras = DB::select($cons);
        return ['muestras' => $muestras];
    }

    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        //echo "xxxxxx ".$request->id_proyecto; 

        $formatos = DB::table('fab_muestras')->select('num_muestra')->where('id_proyecto','=',$request->id_proyecto)->orderBy('id','desc')->limit(1)->get();
        //print_r($formatos);
        if(isset($formatos[0]))
            $Numero = (int) $formatos[0]->num_muestra + 1;
        else
            $Numero = 1;

        $muestra = new FabMuestras();
        $muestra->id_proyecto = $request->id_proyecto;
        $muestra->num_muestra = $Numero;
        $muestra->leyenda = $request->leyenda;
        $muestra->resist_dise = $request->resist_dise;
        $muestra->diametro_cilindro = $request->diametro_cilindro;       
        $muestra->fec_entra = $request->fec_entra;
        $muestra->fec_muestra = $request->fec_muestra;
        $muestra->medida_resistencia = $request->medida_resistencia;
        $muestra->descripcion = $request->descripcion;
        $muestra->condicion = '1';
        $muestra->save();

    }

    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $muestra = FabMuestras::findOrFail($request->id);
        $muestra->id_proyecto = $request->id_proyecto;        
        $muestra->leyenda = $request->leyenda;
        $muestra->resist_dise = $request->resist_dise;
        $muestra->diametro_cilindro = $request->diametro_cilindro;       
        $muestra->fec_entra = $request->fec_entra;
        $muestra->fec_muestra = $request->fec_muestra;
        $muestra->medida_resistencia = $request->medida_resistencia;
        $muestra->descripcion = $request->descripcion;
        $muestra->condicion = '1';
        $muestra->save();
    }

    public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $muestra = FabMuestras::findOrFail($request->id);
        $muestra->condicion = '0';
        $muestra->save();
    }

    
}
