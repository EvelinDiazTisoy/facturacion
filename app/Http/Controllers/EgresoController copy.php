<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Egreso;
use App\DetalleEgreso;
use App\Stock;
use Illuminate\Support\Facades\Auth;

class EgresoController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        $id_empresa = $request->session()->get('id_empresa');
        
        if ($buscar==''){
            $egresos = Egreso::join('personas','egresos.idproveedor','=','personas.id')
            ->join('users','egresos.idusuario','=','users.id')
            ->select('egresos.id','egresos.tipo_comprobante','egresos.serie_comprobante',
            'egresos.num_comprobante','egresos.tipo_egreso','egresos.fecha_hora','egresos.impuesto','egresos.total',
            'egresos.estado','personas.nombre','users.usuario')
            ->where('egresos.id_empresa','=',$id_empresa)
            ->orderBy('egresos.id', 'desc')->paginate(3);
        }
        else{
            $egresos = Egreso::join('personas','egresos.idproveedor','=','personas.id')
            ->join('users','egresos.idusuario','=','users.id')
            ->select('egresos.id','egresos.tipo_comprobante','egresos.serie_comprobante',
            'egresos.num_comprobante','egresos.tipo_egreso','egresos.fecha_hora','egresos.impuesto','egresos.total',
            'egresos.estado','personas.nombre','users.usuario')
            ->where('egresos.id_empresa','=',$id_empresa)
            ->where('egresos.'.$criterio, 'like', '%'. $buscar . '%')->orderBy('egresos.id', 'desc')->paginate(3);
        }
        
        return [
            'pagination' => [
                'total'        => $egresos->total(),
                'current_page' => $egresos->currentPage(),
                'per_page'     => $egresos->perPage(),
                'last_page'    => $egresos->lastPage(),
                'from'         => $egresos->firstItem(),
                'to'           => $egresos->lastItem(),
            ],
            'egresos' => $egresos
        ];
    }
    public function obtenerCabecera(Request $request){
        if (!$request->ajax()) return redirect('/');
        $id_empresa = $request->session()->get('id_empresa');

        $id = $request->id;
        $egresos = Egreso::join('personas','egresos.idproveedor','=','personas.id')
        ->join('users','egresos.idusuario','=','users.id')
        ->select('egresos.id','egresos.tipo_comprobante','egresos.serie_comprobante',
        'egresos.num_comprobante','egresos.tipo_egreso','egresos.fecha_hora','egresos.impuesto','egresos.total',
        'egresos.estado','personas.nombre','users.usuario')
        ->where('id_empresa','=',$id_empresa)
        ->where('egresos.id','=',$id)
        ->orderBy('egresos.id', 'desc')->take(1)->get();
        
        return ['egreso' => $egresos];
    }
    public function obtenerDetalles(Request $request){
        if (!$request->ajax()) return redirect('/');

        $id = $request->id;
        $detalles = DetalleEgreso::join('articulos','detalle_egresos.idarticulo','=','articulos.id')
        ->select('detalle_egresos.cantidad','detalle_egresos.precio','articulos.nombre as articulo')
        ->where('detalle_egresos.idegreso','=',$id)
        ->orderBy('detalle_egresos.id', 'desc')->get();
        
        return ['detalles' => $detalles];
    }

    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $id_usuario = Auth::user()->id;
        $id_empresa = $request->session()->get('id_empresa');

        try{
            DB::beginTransaction();

            $mytime= Carbon::now('America/Lima');

            $egreso = new Egreso();
            $egreso->idproveedor = $request->idproveedor;
            $egreso->idusuario = \Auth::user()->id;
            $egreso->tipo_comprobante = $request->tipo_comprobante;
            $egreso->serie_comprobante = $request->serie_comprobante;
            $egreso->num_comprobante = $request->num_comprobante;
            $egreso->tipo_egreso = $request->tipo_egreso;
            $egreso->fecha_hora = $mytime->toDateString();
            $egreso->impuesto = $request->impuesto;
            $egreso->total = $request->total;
            $egreso->estado = 'Registrado';
            $egreso->id_empresa = $id_empresa;
            $egreso->save();

            $detalles = $request->data;//Array de detalles
            //Recorro todos los elementos

            foreach($detalles as $ep=>$det)
            {
                $detalle = new DetalleEgreso();
                $detalle->idegreso = $egreso->id;
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

            DB::commit();
        } catch (Exception $e){
            DB::rollBack();
        }
    }

    public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $egreso = Egreso::findOrFail($request->id);
        $egreso->estado = 'Anulado';
        $egreso->save();
    }
}
