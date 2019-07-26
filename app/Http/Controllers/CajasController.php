<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Cajas;
use Illuminate\Support\Facades\Auth;

class CajasController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        $id_empresa = $request->session()->get('id_empresa');
        
        if ($buscar==''){
            $cajas = Cajas::where('id_empresa','=',$id_empresa)->orderBy('id', 'desc')->paginate(15);
        }
        else{
            $cajas = Cajas::where('id_empresa','=',$id_empresa)->where($criterio, 'like', '%'. $buscar . '%')->orderBy('id', 'desc')->paginate(15);
        }
        

        return [
            'pagination' => [
                'total'        => $cajas->total(),
                'current_page' => $cajas->currentPage(),
                'per_page'     => $cajas->perPage(),
                'last_page'    => $cajas->lastPage(),
                'from'         => $cajas->firstItem(),
                'to'           => $cajas->lastItem(),
            ],
            'cajas' => $cajas
        ];
    }

    public function selectCaja(Request $request){
        if (!$request->ajax()) return redirect('/');
        $id_empresa = $request->session()->get('id_empresa');

        $cajas = Cajas::select('id','nombre')->where('id_empresa','=',$id_empresa)->orderBy('nombre', 'asc')->get();
        
        return ['cajas' => $cajas];
    }

    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $id_empresa = $request->session()->get('id_empresa');
        $id_usuario = Auth::user()->id;

        $cajas = new Cajas();
        $cajas->nombre = $request->nombre;
        $cajas->id_empresa = $id_empresa;
        $cajas->usu_crea = $id_usuario;
        $cajas->save();
    }

    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $cajas = Cajas::findOrFail($request->id);
        $cajas->nombre = $request->nombre;
        $cajas->save();
    }

    public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $cajas = Cajas::findOrFail($request->id);
        $cajas->estado = '0';
        $cajas->save();
    }

    public function activar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $cajas = Cajas::findOrFail($request->id);
        $cajas->estado = '1';
        $cajas->save();
    }
}
