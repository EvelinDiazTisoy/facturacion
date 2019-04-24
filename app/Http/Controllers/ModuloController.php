<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Modulo;

class ModuloController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $total = array();
        $modulos = Modulo::where('tipo','=','1')->orderBy('nombre','asc')->get();
        foreach($modulos as $mod)
        {
            $total[] = $mod;
            $modulos2= Modulo::where('tipo','=','2')->where('padre','=',$mod['id'])->orderBy('nombre','asc')->get();
            foreach($modulos2 as $mod2)
            {
                $total[] = $mod2;
            }
        }

        return [
            'modulos' => $total,
        ];
    }
    public function selectModulo(Request $request)
    {
        $modulos = Rol::where('condicion', '=', '1')
        ->select('id','nombre')
        ->orderBy('nombre', 'asc')->get();

        return ['modulos' => $modulos];
    }
}
