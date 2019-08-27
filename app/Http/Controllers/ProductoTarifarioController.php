<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\ProductoTarifario;
use App\ConTarifario;
use App\Articulo;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

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
        // if (!$request->ajax()) return redirect('/');
        $id_tarifario = $request->id_tarifario;
        $id_empresa = $request->session()->get('id_empresa');

        $conTarifario = '';
        if($id_tarifario!=''){$conTarifario=' AND productos_tarifarios.id_tarifario='.$id_tarifario;}

        $cons = "SELECT productos_tarifarios.id, productos_tarifarios.id_tarifario, productos_tarifarios.id_producto, productos_tarifarios.valor, productos_tarifarios.asociado,productos_tarifarios.idPresentacionAsociada, articulos.nombre as nom_articulo,presentacion.nombre as nom_presentacion, con_tarifarios.nombre as nom_tarifario FROM articulos,productos_tarifarios,con_tarifarios,presentacion WHERE productos_tarifarios.id_producto=articulos.id AND productos_tarifarios.id_tarifario=con_tarifarios.id ".$conTarifario." AND productos_tarifarios.asociado=0  AND articulos.id_presentacion=presentacion.id ORDER BY articulos.id DESC";

        $articulos = DB::select($cons);

        $total = [];
        if(!empty($articulos))
        {
            foreach($articulos as $a)
            {
                $total[] = $a;

                $cons2 = "SELECT productos_tarifarios.id, productos_tarifarios.id_tarifario, productos_tarifarios.id_producto, productos_tarifarios.valor, productos_tarifarios.asociado,productos_tarifarios.idPresentacionAsociada, articulos.nombre as nom_articulo,presentacion.nombre as nom_presentacion, con_tarifarios.nombre as nom_tarifario FROM articulos,productos_tarifarios,con_tarifarios,presentacion WHERE productos_tarifarios.id_producto=articulos.id AND productos_tarifarios.id_tarifario=con_tarifarios.id ".$conTarifario." AND productos_tarifarios.asociado=".$a->id_producto." AND articulos.id_presentacion=productos_tarifarios.idPresentacionAsociada ORDER BY articulos.id DESC";

                $articulos2 = DB::select($cons2);

                if(!empty($articulos2))
                {
                    foreach($articulos2 as $a2)
                    {
                        $total[] = $a2;
                    }
                }
            }
        }

        $producto_tarifario = ProductoTarifario::leftJoin('articulos','productos_tarifarios.id_producto','articulos.id')
        ->select('productos_tarifarios.id_producto','articulos.nombre as nom_articulo','productos_tarifarios.valor')
        ->where('id_tarifario','=',$id_tarifario)
        ->get();
        
        return ['producto_tarifario' => $articulos];
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
    
    public function cargarPreciosTarifarios(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $id_empresa = $request->session()->get('id_empresa');

        $arrayDetalles = json_decode($request->arrayDetalle);

        $cadena = '';
        foreach($arrayDetalles as $ad)
        {
            $cadena .= ','.$ad->id;
        }
        $cadena = substr($cadena,1);

        $cons = 'SELECT id,id_tarifario,id_producto,valor FROM productos_tarifarios WHERE id_producto IN ('.$cadena.') AND id_tarifario='.$request->id_tarifario;

        $valores = DB::select($cons);
        
        return ['cadena'=>$cons,'producto_tarifario' => $valores];
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
