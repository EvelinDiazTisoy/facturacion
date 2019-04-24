<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Rol;
use Illuminate\Support\Facades\Auth;

class RolController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        
        if ($buscar==''){
            $roles = Rol::orderBy('id', 'desc')->get();
        }
        else{
            $roles = Rol::where($criterio, 'like', '%'. $buscar . '%')->orderBy('id', 'desc')->get();
        }
        
        $roles2 = Rol::select('nombre','estado')->where('estado','=','1')->groupBy('nombre')->orderBy('id','desc')->paginate(6);

        return [
            'pagination' => [
                'total'        => $roles2->total(),
                'current_page' => $roles2->currentPage(),
                'per_page'     => $roles2->perPage(),
                'last_page'    => $roles2->lastPage(),
                'from'         => $roles2->firstItem(),
                'to'           => $roles2->lastItem(),
            ],
            'roles' => $roles,
            'roles2' => $roles2
        ];
    }

    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $id_usuario = Auth::user()->id;

        $modulos = $request->modulos;

        foreach($modulos as $mod)
        {
            $roles = new Rol();
            $roles->nombre = $request->nombre;
            $roles->id_modulo = $mod['id'];
            $ban = 0;

            if(isset($mod['lectura']) && $mod['lectura']==true)
            {
                $roles->lectura = 1;
                $ban = 1;
            }

            if(isset($mod['escritura']) && $mod['escritura']==true)
            {
                $roles->escritura = 1;
                $ban = 1;
            }

            if(isset($mod['edicion']) && $mod['edicion']==true)
            {
                $roles->edicion = 1;
                $ban = 1;
            }

            if(isset($mod['anular']) && $mod['anular']==true)
            {
                $roles->anular = 1;
                $ban = 1;
            }

            if(isset($mod['imprimir']) && $mod['imprimir']==true)
            {
                $roles->imprimir = 1;
                $ban = 1;
            }


            $roles->usu_crea = $id_usuario;

            if($ban==1)
            {
                $roles->save();
            }

        }
    }

    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $id_usuario = Auth::user()->id;

        $roles = Rol::where('nombre','=',$request->nombreAnterior)->delete();

        $modulos = $request->modulos;

        foreach($modulos as $mod)
        {
            $roles = new Rol();
            $roles->nombre = $request->nombre;
            $roles->id_modulo = $mod['id'];
            $ban = 0;

            if(isset($mod['lectura']) && $mod['lectura']==true)
            {
                $roles->lectura = 1;
                $ban = 1;
            }

            if(isset($mod['escritura']) && $mod['escritura']==true)
            {
                $roles->escritura = 1;
                $ban = 1;
            }

            if(isset($mod['edicion']) && $mod['edicion']==true)
            {
                $roles->edicion = 1;
                $ban = 1;
            }

            if(isset($mod['anular']) && $mod['anular']==true)
            {
                $roles->anular = 1;
                $ban = 1;
            }

            if(isset($mod['imprimir']) && $mod['imprimir']==true)
            {
                $roles->imprimir = 1;
                $ban = 1;
            }


            $roles->usu_crea = $id_usuario;

            if($ban==1)
            {
                $roles->save();
            }

        }
    }

    public function selectRol(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $roles = Rol::where('estado', '=', '1')
        ->select('id','nombre')
        ->orderBy('nombre', 'asc')->get();

        return ['roles' => $roles];
    }
}
