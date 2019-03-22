<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DetalleFacturacion;

class DetalleFacturacionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        
        if ($buscar==''){
            $detalle_facturacion = DetalleFacturacion::join('facturacion', 'detalle_facturacion.id_factura','=','facturacion.id')
            ->join('articulos', 'detalle_facturacion.id_producto','=','articulos.id')
            ->select('detalle_facturacion.id','detalle_facturacion.id_factura','facturacion.num_factura as num_factura','detalle_facturacion.id_producto','articulos.codigo as codigo_articulo','articulos.nombre as nombre_articulo','detalle_facturacion.valor_venta','detalle_facturacion.cantidad','detalle_facturacion.valor_iva','detalle_facturacion.valor_descuento','detalle_facturacion.porcentaje_iva','detalle_facturacion.valor_subtotal','detalle_facturacion.valor_final')
            ->orderBy('id', 'desc')
            ->paginate(3);
        }
        else{
            $detalle_facturacion = DetalleFacturacion::join('facturacion', 'detalle_facturacion.id_factura','=','facturacion.id')
            ->join('articulos', 'detalle_facturacion.id_producto','=','articulos.id')
            ->select('detalle_facturacion.id','detalle_facturacion.id_factura','facturacion.num_factura as num_factura','detalle_facturacion.id_producto','articulos.codigo as codigo_articulo','articulos.nombre as nombre_articulo','articulos.precio_venta','detalle_facturacion.valor_venta','detalle_facturacion.cantidad','detalle_facturacion.valor_iva','detalle_facturacion.valor_descuento','detalle_facturacion.porcentaje_iva','detalle_facturacion.valor_subtotal','detalle_facturacion.valor_final')
            ->where($criterio, 'like', '%'. $buscar . '%')
            ->orderBy('id', 'desc')
            ->paginate(3);
        }
        

        return [
            'pagination' => [
                'total'        => $detalle_facturacion->total(),
                'current_page' => $detalle_facturacion->currentPage(),
                'per_page'     => $detalle_facturacion->perPage(),
                'last_page'    => $detalle_facturacion->lastPage(),
                'from'         => $detalle_facturacion->firstItem(),
                'to'           => $detalle_facturacion->lastItem(),
            ],
            'detalle_facturacion' => $detalle_facturacion
        ];
    }

    public function buscarDetalleFacturacion(Request $request){

        if (!$request->ajax()) return redirect('/');

        $id_factura = $request->id_factura;
        $detalle_facturacion = DetalleFacturacion::join('facturacion', 'detalle_facturacion.id_factura','=','facturacion.id')
        ->join('articulos', 'detalle_facturacion.id_producto','=','articulos.id')
        ->select('detalle_facturacion.id','detalle_facturacion.id_factura','facturacion.num_factura as num_factura','detalle_facturacion.id_producto','articulos.id as id_articulo','articulos.codigo as codigo_articulo','articulos.nombre as articulo','articulos.precio_venta','articulos.stock','detalle_facturacion.valor_venta','detalle_facturacion.cantidad','detalle_facturacion.valor_iva','detalle_facturacion.valor_descuento','detalle_facturacion.porcentaje_iva','detalle_facturacion.valor_subtotal','detalle_facturacion.valor_final')
        ->where('detalle_facturacion.id_factura','=', $id_factura)
        ->get();

        return ['detalle_facturacion' => $detalle_facturacion];
    }
    
    public function redirect_log(){
        return redirect('/');
    }
    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $categoria = new Facturacion();
        $categoria->nombre = $request->nombre;
        $categoria->descripcion = $request->descripcion;
        $categoria->condicion = '1';
        $categoria->save();
    }
  

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $categoria = Facturacion::findOrFail($request->id);
        $categoria->nombre = $request->nombre;
        $categoria->descripcion = $request->descripcion;
        $categoria->condicion = '1';
        $categoria->save();
    }

    public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $categoria = Facturacion::findOrFail($request->id);
        $categoria->condicion = '0';
        $categoria->save();
    }

    public function activar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $categoria = Facturacion::findOrFail($request->id);
        $categoria->condicion = '1';
        $categoria->save();
    }

    
}
