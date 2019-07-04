<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\ProductoTarifario;
use App\ConTarifario;
use App\Articulo;
use Illuminate\Support\Facades\Auth;

class ProductoTarifarioController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        $id_empresa = $request->session()->get('id_empresa');
        
        if ($buscar==''){
            $producto_tarifario = ProductoTarifario::where('id_empresa','=',$id_empresa)->orderBy('id', 'desc')->paginate(3);
        }
        else{
            $producto_tarifario = ProductoTarifario::where('id_empresa','=',$id_empresa)->where($criterio, 'like', '%'. $buscar . '%')->orderBy('id', 'desc')->paginate(3);
        }
        

        return [
            'pagination' => [
                'total'        => $producto_tarifario->total(),
                'current_page' => $producto_tarifario->currentPage(),
                'per_page'     => $producto_tarifario->perPage(),
                'last_page'    => $producto_tarifario->lastPage(),
                'from'         => $producto_tarifario->firstItem(),
                'to'           => $producto_tarifario->lastItem(),
            ],
            'producto_tarifario' => $producto_tarifario
        ];
    }

    public function selectProductoTarifario(Request $request){
        if (!$request->ajax()) return redirect('/');
        $id_tarifario = $request->id_tarifario;
        $id_empresa = $request->session()->get('id_empresa');

        $producto_tarifario = ProductoTarifario::leftJoin('articulos','productos_tarifarios.id_producto','articulos.id')
        ->select('productos_tarifarios.id_producto','articulos.nombre as nom_articulo','productos_tarifarios.valor')
        ->where('id_tarifario','=',$id_tarifario)
        ->get();
        
        return ['producto_tarifario' => $producto_tarifario];
    }

    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $id_empresa = $request->session()->get('id_empresa');
        $id_usuario = Auth::user()->id;

        $producto_tarifario = new ProductoTarifario();
        $producto_tarifario->id_producto = $request->id_producto;
        $producto_tarifario->id_tarifario = $request->id_tarifario;
        $producto_tarifario->valor = $valor;
        $producto_tarifario->save();
    }

    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $producto_tarifario = ProductoTarifario::findOrFail($request->id);
        $producto_tarifario->nombre = $request->nombre;
        $producto_tarifario->descripcion = $request->descripcion;
        $producto_tarifario->save();
    }

    public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $producto_tarifario = ProductoTarifario::findOrFail($request->id);
        $producto_tarifario->estado = '0';
        $producto_tarifario->save();
    }

    public function activar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $concentracion = ProductoTarifario::findOrFail($request->id);
        $concentracion->estado = '1';
        $concentracion->save();
    }
}
