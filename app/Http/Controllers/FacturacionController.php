<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Facturacion;
use App\DetalleFacturacion;
use App\Stock;
use App\Articulo;
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
        $id_empresa = $request->session()->get('id_empresa');

        $numFacturaFiltro = $request->numFacturaFiltro;
        $estadoFiltro = $request->estadoFiltro;
        $idTerceroFiltro = $request->idTerceroFiltro;
        $ordenFiltro = $request->ordenFiltro;
        $desdeFiltro = $request->desdeFiltro;
        $hastaFiltro = $request->hastaFiltro;
        $idVendedorFiltro = $request->idVendedorFiltro;

        $facturacion = Facturacion::join('personas', 'facturacion.id_tercero','=','personas.id')
        ->join('zona', 'facturacion.lugar','=','zona.id')
        ->select('facturacion.id','facturacion.num_factura','facturacion.id_tercero','personas.nombre as nom_tercero','facturacion.id_usuario','facturacion.fec_crea','facturacion.fec_edita','facturacion.usu_edita','facturacion.subtotal','facturacion.valor_iva','facturacion.total','abono','facturacion.saldo','facturacion.detalle','facturacion.lugar','zona.zona as nom_lugar','facturacion.descuento','facturacion.fec_registra','facturacion.fec_envia','facturacion.fec_anula','facturacion.usu_registra','facturacion.usu_envia','facturacion.usu_anula','facturacion.fecha','facturacion.estado');

        if($numFacturaFiltro!='' && $numFacturaFiltro!='0')
        {
            $facturacion = $facturacion->where('facturacion.num_factura','=',$numFacturaFiltro);
        }
        if($estadoFiltro!='' && $estadoFiltro!='0')
        {
            $facturacion = $facturacion->Where('facturacion.estado','=',$estadoFiltro);
        }
        if($idTerceroFiltro!='' && $idTerceroFiltro!='0')
        {
            $facturacion = $facturacion->Where('facturacion.id_tercero','=',$idTerceroFiltro);
        }
        if($idVendedorFiltro!='' && $idVendedorFiltro!='0')
        {
            $facturacion = $facturacion->Where('facturacion.id_usuario','=',$idVendedorFiltro);
        }
        if($desdeFiltro!='' && $hastaFiltro!='')
        {
            $facturacion = $facturacion->whereBetween('facturacion.fecha', [$desdeFiltro, $hastaFiltro]);
        }
        if($ordenFiltro!='')
        {
            $orden='';
            if($ordenFiltro=='num_factura')
                $orden='desc';
            else
                $orden='asc';
            $facturacion = $facturacion->orderBy($ordenFiltro,$orden);
        }
        else
        {
            $facturacion = $facturacion->orderBy('id', 'desc');
        }
        $facturacion = $facturacion->where('facturacion.id_empresa','=',$id_empresa)->paginate(6);
        
        
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
        $id_empresa = $request->session()->get('id_empresa');

        $filtro = $request->filtro;
        $facturacion = Facturacion::join('personas', 'facturacion.id_tercero','=','personas.id')
        ->select('facturacion.id','facturacion.num_factura','facturacion.id_tercero','personas.nombre as nom_tercero','facturacion.id_usuario','facturacion.fec_crea','facturacion.fec_edita','facturacion.usu_edita','facturacion.subtotal','facturacion.valor_iva','facturacion.total','abono','facturacion.saldo','facturacion.detalle','facturacion.lugar','facturacion.descuento','facturacion.fec_registra','facturacion.fec_envia','facturacion.fec_anula','facturacion.usu_registra','facturacion.usu_envia','facturacion.usu_anula','facturacion.fecha','facturacion.estado')
        ->where('id_empresa','=',$id_empresa)
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
        $id_empresa = $request->session()->get('id_empresa');

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
        $facturacion->lugar = $request->lugar;
        $facturacion->descuento = $request->descuento;
        $facturacion->fec_registra = null;
        $facturacion->fec_envia = null;
        $facturacion->fec_anula = null;
        $facturacion->usu_registra = null;
        $facturacion->usu_envia = null;
        $facturacion->usu_anula = null;
        $facturacion->fecha = $request->fecha;
        $facturacion->id_empresa = $id_empresa;
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

            $stock = new Stock();
            $stock->id_producto = $det['idarticulo'];
            $stock->id_usuario = $id_usuario;
            $stock->id_facturacion = $facturacion->id;
            $stock->cantidad = $det['cantidad'];
            $stock->tipo_movimiento = $request->tipo_movimiento;
            $stock->sumatoria = $request->sumatoria;
            $stock->save();
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
        
        $facturacion = Facturacion::findOrFail($request->id);
        $facturacion->num_factura = $request->num_factura;
        $facturacion->id_tercero = $request->id_tercero;
        $facturacion->fec_edita = $request->fec_edita;
        $facturacion->usu_edita = $id_usuario;
        $facturacion->subtotal = $request->subtotal;
        $facturacion->valor_iva = $request->valor_iva;
        $facturacion->total = $request->total;
        $facturacion->abono = $request->abono;
        $facturacion->saldo = $request->saldo;
        $facturacion->detalle = $request->detalle;
        $facturacion->lugar = $request->lugar;
        $facturacion->descuento = $request->descuento;
        $facturacion->fec_registra = null;
        $facturacion->fec_envia = null;
        $facturacion->fec_anula = null;
        $facturacion->usu_registra = null;
        $facturacion->usu_envia = null;
        $facturacion->usu_anula = null;
        $facturacion->fecha = $request->fecha;
        $facturacion->estado = $request->estado;
        $facturacion->save();

        $borrar_detalles = DetalleFacturacion::where('id_factura','=',$request->id)->delete();

        $detalles = $request->data;//Array de detalles
            //Recorro todos los elementos

        foreach($detalles as $ep=>$det)
        {
            $detalle = new DetalleFacturacion();
            $detalle->id_factura = $request->id;
            $detalle->id_producto = $det['idarticulo'];
            $detalle->valor_venta = $det['precio'];
            $detalle->cantidad = $det['cantidad'];
            $detalle->valor_iva = $det['valor_iva'];
            $detalle->valor_descuento = $det['valor_descuento'];
            $detalle->porcentaje_iva = $det['iva'];
            $detalle->valor_subtotal = $det['valor_subtotal'];  
            $detalle->valor_final = $det['valor_subtotal']+$det['valor_iva'];
            $detalle->save();

            $articulo = Articulo::findOrFail($det['idarticulo']);
            $stock = Stock::where('id_facturacion','=',$request->id)->where('id_producto','=',$det['idarticulo'])->get();
            
            if(!empty($stock))
            {
                $stockTablaStock = $stock[0]->cantidad;
                $stockTablaArticulo = $articulo->stock;
                $nuevoStock = $stockTablaArticulo+$stockTablaStock;
                $articulo->stock = $nuevoStock;
                $articulo->save();
                $stock2 = Stock::findOrFail($stock[0]->id);
                $stock2->delete();
            }

            $stock = new Stock();
            // $stock=Stock::findOrFail($det['idarticulo']);
            $stock->id_producto = $det['idarticulo'];
            $stock->id_facturacion = $facturacion->id;
            $stock->id_usuario = $id_usuario;
            $stock->cantidad = $det['cantidad'];
            $stock->tipo_movimiento = $request->tipo_movimiento;
            $stock->sumatoria = $request->sumatoria;
            $stock->save();

            $articulo->stock = $articulo->stock-$stock->cantidad;
            $articulo->save();
        }
    }

    public function cambiarEstado(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $facturacion = Facturacion::findOrFail($request->id);
        $facturacion->estado = $request->estado;
        if($request->estado==2 && $request->num_factura)
        {
            $facturacion->num_factura=$request->num_factura;
        }
        $facturacion->save();
    }

    public function buscarNumFacturaSugerida(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        
        $facturacion = Facturacion::select('num_factura')
        ->where('num_factura','!=',null)
        ->orderBy('num_factura', 'desc')
        ->take(1)
        ->get();
        
        return [
            'facturacion' => $facturacion
        ];
    }

    public function obtenerCabecera(Request $request){
        if (!$request->ajax()) return redirect('/');

        $id = $request->id;
        $facturacion = Facturacion::join('personas','facturacion.id_tercero','=','personas.id')
        ->join('users','facturacion.id_usuario','=','users.id')
        ->select('facturacion.id','facturacion.num_factura','facturacion.id_tercero','facturacion.fec_crea','facturacion.fec_edita','facturacion.usu_edita','facturacion.subtotal','facturacion.valor_iva','facturacion.total','facturacion.abono','facturacion.abono as abono2','facturacion.saldo','facturacion.detalle','facturacion.lugar','facturacion.descuento','facturacion.fec_registra','facturacion.fec_envia','facturacion.fec_anula','facturacion.usu_registra','facturacion.usu_envia','facturacion.usu_anula','facturacion.fecha','facturacion.estado','personas.nombre as nom_tercero','users.usuario')
        ->where('facturacion.id','=',$id)
        ->orderBy('facturacion.id', 'desc')->take(1)->get();
        
        return ['facturacion' => $facturacion];
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
