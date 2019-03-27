<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Facturacion;
use App\DetalleFacturacion;
use Illuminate\Support\Facades\Auth;

class FacturacionController extends Controller
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
            $facturacion = Facturacion::join('personas', 'facturacion.id_tercero','=','personas.id')
            ->select('facturacion.id','facturacion.num_factura','facturacion.id_tercero','personas.nombre as nom_tercero','facturacion.id_usuario','facturacion.fec_crea','facturacion.fec_edita','facturacion.usu_edita','facturacion.subtotal','facturacion.valor_iva','facturacion.total','abono','facturacion.saldo','facturacion.detalle','facturacion.descuento','facturacion.fec_registra','facturacion.fec_envia','facturacion.fec_anula','facturacion.usu_registra','facturacion.usu_envia','facturacion.usu_anula','facturacion.fecha','facturacion.estado')
            ->orderBy('id', 'desc')
            ->paginate(3);
        }
        else{
            $facturacion = Facturacion::join('personas', 'facturacion.id_tercero','=','personas.id')
            ->select('facturacion.id','facturacion.num_factura','facturacion.id_tercero','personas.nombre as nom_tercero','facturacion.id_usuario','facturacion.fec_crea','facturacion.fec_edita','facturacion.usu_edita','facturacion.subtotal','facturacion.valor_iva','facturacion.total','abono','facturacion.saldo','facturacion.detalle','facturacion.descuento','facturacion.fec_registra','facturacion.fec_envia','facturacion.fec_anula','facturacion.usu_registra','facturacion.usu_envia','facturacion.usu_anula','facturacion.fecha','facturacion.estado')
            ->where($criterio, 'like', '%'. $buscar . '%')
            ->orderBy('id', 'desc')
            ->paginate(3);
        }
        
        
        return [
            'pagination' => [
                'total'        => $facturacion->total(),
                'current_page' => $facturacion->currentPage(),
                'per_page'     => $facturacion->perPage(),
                'last_page'    => $facturacion->lastPage(),
                'from'         => $facturacion->firstItem(),
                'to'           => $facturacion->lastItem(),
            ],
            'facturacion' => $facturacion
        ];
    }

    public function buscarFacturacion(Request $request){
        if (!$request->ajax()) return redirect('/');

        $filtro = $request->filtro;
        $facturacion = Facturacion::join('personas', 'facturacion.id_tercero','=','personas.id')
        ->select('facturacion.id','facturacion.num_factura','facturacion.id_tercero','personas.nombre as nom_tercero','facturacion.id_usuario','facturacion.fec_crea','facturacion.fec_edita','facturacion.usu_edita','facturacion.subtotal','facturacion.valor_iva','facturacion.total','abono','facturacion.saldo','facturacion.detalle','facturacion.descuento','facturacion.fec_registra','facturacion.fec_envia','facturacion.fec_anula','facturacion.usu_registra','facturacion.usu_envia','facturacion.usu_anula','facturacion.fecha','facturacion.estado')
        ->where('facturacion.id','=', $filtro)
        ->get();

        return ['facturacion' => $facturacion];
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
        $id_usuario = Auth::user()->id;
        $facturacion = new Facturacion();
        $facturacion->num_factura = $request->num_factura;
        $facturacion->id_tercero = $request->id_tercero;
        $facturacion->id_usuario = $id_usuario;
        $facturacion->fec_edita = null;
        $facturacion->usu_edita = null;
        $facturacion->subtotal = $request->subtotal;
        $facturacion->valor_iva = $request->valor_iva;
        $facturacion->total = $request->total;
        $facturacion->abono = $request->abono;
        $facturacion->saldo = $request->saldo;
        $facturacion->detalle = $request->detalle;
        $facturacion->descuento = $request->descuento;
        $facturacion->fec_registra = null;
        $facturacion->fec_envia = null;
        $facturacion->fec_anula = null;
        $facturacion->usu_registra = null;
        $facturacion->usu_envia = null;
        $facturacion->usu_anula = null;
        $facturacion->fecha = $request->fecha;
        $facturacion->estado = '1';
        $facturacion->save();

        $detalles = $request->data;//Array de detalles
            //Recorro todos los elementos

        foreach($detalles as $ep=>$det)
        {
            $detalle = new DetalleFacturacion();
            $detalle->id_factura = $facturacion->id;
            $detalle->id_producto = $det['idarticulo'];
            $detalle->valor_venta = $det['precio'];
            $detalle->cantidad = $det['cantidad'];
            $detalle->valor_iva = $det['valor_iva'];
            $detalle->valor_descuento = $det['valor_descuento'];
            $detalle->porcentaje_iva = $det['iva'];
            $detalle->valor_subtotal = $det['valor_subtotal'];  
            $detalle->valor_final = $det['valor_subtotal']+$det['valor_iva'];
            $detalle->save();

            // $stock = new Stock();
            // $stock->id_producto = $det['idarticulo'];
            // $stock->id_usuario = $id_usuario;
            // $stock->cantidad = $det['cantidad'];
            // $stock->tipo_movimiento = $request->tipo_movimiento;
            // $stock->sumatoria = $request->sumatoria;
            // $stock->save();
        }
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
        $id_usuario = Auth::user()->id;
        $facturacion = new Facturacion();
        $facturacion->num_factura = $request->num_factura;
        $facturacion->id_tercero = $request->id_tercero;
        $facturacion->fec_edita = $request->id_tercero;
        $facturacion->id_usuario = $request->id_usu;
        $facturacion->usu_edita = $id_usuario;
        $facturacion->subtotal = $request->subtotal;
        $facturacion->valor_iva = $request->valor_iva;
        $facturacion->total = $request->total;
        $facturacion->abono = $request->abono;
        $facturacion->saldo = $request->saldo;
        $facturacion->detalle = $request->detalle;
        $facturacion->descuento = $request->descuento;
        $facturacion->fec_registra = null;
        $facturacion->fec_envia = null;
        $facturacion->fec_anula = null;
        $facturacion->usu_registra = null;
        $facturacion->usu_envia = null;
        $facturacion->usu_anula = null;
        $facturacion->fecha = $request->fecha;
        $facturacion->estado = '1';
        $facturacion->save();

        $detalles = $request->data;//Array de detalles
            //Recorro todos los elementos

        foreach($detalles as $ep=>$det)
        {
            $detalle = new DetalleIngreso();
            $detalle->idingreso = $ingreso->id;
            $detalle->idarticulo = $det['idarticulo'];
            $detalle->cantidad = $det['cantidad'];
            $detalle->precio = $det['precio'];  
            $detalle->id_usuario = $id_usuario;        
            $detalle->save();

            $stock = new Stock();
            $stock->id_producto = $det['idarticulo'];
            $stock->id_usuario = $id_usuario;
            $stock->cantidad = $det['cantidad'];
            $stock->tipo_movimiento = $request->tipo_movimiento;
            $stock->sumatoria = $request->sumatoria;
            $stock->save();
        }
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
