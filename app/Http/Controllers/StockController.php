<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Stock;

class StockController extends Controller
{
    public function index(Request $request)
    {
        // if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        
        if ($buscar==''){
            $stock = Stock::join('articulos','stock.id_producto','=','articulos.id')
            ->join('users','stock.id_usuario','=','users.id')
            ->select('stock.id','id_producto','id_usuario','articulos.nombre as nombre_producto','users.usuario as nombre_usuario','fec_crea','cantidad','tipo_movimiento','sumatoria','stock.condicion')
            ->orderBy('id', 'desc')->paginate(3);
        }
        else{
            $stock = Stock::join('articulos','stock.id_producto','=','articulos.id')
            ->join('users','stock.id_usuario','=','users.id')
            ->select('stock.id','id_producto','id_usuario','articulos.nombre as nombre_producto','users.usuario as nombre_usuario','fec_crea','cantidad','tipo_movimiento','sumatoria','stock.condicion')
            ->where('stock.'.$criterio, 'like', '%'. $buscar . '%')
            ->orderBy('id', 'desc')->paginate(3);
        }
        

        return [
            'pagination' => [
                'total'        => $stock->total(),
                'current_page' => $stock->currentPage(),
                'per_page'     => $stock->perPage(),
                'last_page'    => $stock->lastPage(),
                'from'         => $stock->firstItem(),
                'to'           => $stock->lastItem(),
            ],
            'stock' => $stock
        ];
    }

    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $articulo = new Articulo();
        $articulo->idcategoria = $request->idcategoria;
        $articulo->codigo = $request->codigo;
        $articulo->nombre = $request->nombre;
        $articulo->precio_venta = $request->precio_venta;
        $articulo->stock = $request->stock;
        $articulo->descripcion = $request->descripcion;
        $articulo->cod_invima = $request->cod_invima;
        $articulo->lote = $request->lote;
        $articulo->fec_vence = $request->fec_vence;
        $articulo->minimo = $request->minimo;
        $articulo->tipo_articulo = $request->tipo_articulo;
        $articulo->iva = $request->iva;
        $articulo->id_und_medida = $request->id_und_medida;
        $articulo->id_concentracion = $request->id_concentracion;
        $articulo->id_presentacion = $request->id_presentacion;
        $articulo->condicion = '1';
        $articulo->save();
    }

    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $articulo = Articulo::findOrFail($request->id);
        $articulo->idcategoria = $request->idcategoria;
        $articulo->codigo = $request->codigo;
        $articulo->nombre = $request->nombre;
        $articulo->precio_venta = $request->precio_venta;
        $articulo->stock = $request->stock;
        $articulo->descripcion = $request->descripcion;
        $articulo->cod_invima = $request->cod_invima;
        $articulo->lote = $request->lote;
        $articulo->fec_vence = $request->fec_vence;
        $articulo->minimo = $request->minimo;
        $articulo->tipo_articulo = $request->tipo_articulo;
        $articulo->iva = $request->iva;
        $articulo->id_und_medida = $request->id_und_medida;
        $articulo->id_concentracion = $request->id_concentracion;
        $articulo->id_presentacion = $request->id_presentacion;
        $articulo->condicion = '1';
        $articulo->save();
    }
}
