<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Articulo;
use App\Stock;
use App\ProductoTarifario;
use App\IvaProducto;
use Illuminate\Support\Facades\Auth;

class ArticuloController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        $id_usuario = Auth::user()->id;
        $id_empresa = $request->session()->get('id_empresa');
        
        if ($buscar==''){
            $articulos = Articulo::join('modelo_contable','articulos.idcategoria','=','modelo_contable.id')
            ->select('articulos.id','articulos.id as id_articulo','articulos.idcategoria','articulos.idcategoria2','articulos.codigo','articulos.nombre','modelo_contable.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','id_und_medida','id_concentracion','articulos.cod_invima','articulos.lote','articulos.fec_vence','articulos.minimo','tipo_articulo','articulos.descripcion','articulos.condicion','articulos.id_presentacion','articulos.talla')
            ->where('articulos.id_empresa','=',$id_empresa)
            ->orderBy('articulos.id', 'desc')->paginate(3);
        }
        else{
            $articulos = Articulo::join('modelo_contable','articulos.idcategoria','=','modelo_contable.id')
            ->select('articulos.id','articulos.id as id_articulo','articulos.idcategoria','articulos.idcategoria2','articulos.codigo','articulos.nombre','modelo_contable.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','id_und_medida','id_concentracion','articulos.cod_invima','articulos.lote','articulos.fec_vence','articulos.minimo','tipo_articulo','articulos.descripcion','articulos.condicion','articulos.id_presentacion','articulos.talla')
            ->where('articulos.id_empresa','=',$id_empresa)
            ->where('articulos.'.$criterio, 'like', '%'. $buscar . '%')
            ->orderBy('articulos.id', 'desc')->paginate(3);
        }
        

        return [
            'pagination' => [
                'total'        => $articulos->total(),
                'current_page' => $articulos->currentPage(),
                'per_page'     => $articulos->perPage(),
                'last_page'    => $articulos->lastPage(),
                'from'         => $articulos->firstItem(),
                'to'           => $articulos->lastItem(),
            ],
            'articulos' => $articulos,
        ];
    }

    public function listarArticulo(Request $request)
    {
        // if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        $id_empresa = $request->session()->get('id_empresa');
        
        if ($buscar==''){
            $articulos = Articulo::join('modelo_contable','articulos.idcategoria','=','modelo_contable.id')
            ->leftJoin('productos_iva','articulos.id','=','productos_iva.id_producto')
            ->join('iva','productos_iva.id_iva','=','iva.id')
            ->select('articulos.id','articulos.id as id_articulo','articulos.idcategoria','articulos.idcategoria2','articulos.codigo','articulos.nombre','modelo_contable.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','articulos.descripcion','articulos.cod_invima','articulos.lote','articulos.minimo','articulos.tipo_articulo','articulos.condicion','articulos.id_presentacion','articulos.talla','productos_iva.id_iva','iva.nombre as nombre_iva','iva.porcentaje','productos_iva.tipo_iva')
            ->where('articulos.id_empresa','=',$id_empresa)
            ->where('productos_iva.tipo_iva','=','Compra')
            ->orderBy('articulos.id', 'desc')->paginate(10);
        }
        else{
            $articulos = Articulo::join('modelo_contable','articulos.idcategoria','=','modelo_contable.id')
            ->join('productos_iva','articulos.id','=','productos_iva.id_producto')
            ->join('iva','productos_iva.id_iva','=','iva.id')
            ->select('articulos.id','articulos.id as id_articulo','articulos.idcategoria','articulos.idcategoria2','articulos.codigo','articulos.nombre','modelo_contable.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','articulos.descripcion','articulos.cod_invima','articulos.lote','articulos.minimo','articulos.tipo_articulo','articulos.condicion','articulos.id_presentacion','articulos.talla','productos_iva.id_iva','iva.nombre as nombre_iva','iva.porcentaje','productos_iva.tipo_iva')
            ->where('articulos.id_empresa','=',$id_empresa)
            ->where('productos_iva.tipo_iva','=','Compra')
            ->where('articulos.'.$criterio, 'like', '%'. $buscar . '%')
            ->orderBy('articulos.id', 'desc')->paginate(10);
        }
        

        return ['articulos' => $articulos];
    }
 
    public function listarArticuloVenta(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        $id_empresa = $request->session()->get('id_empresa');
        
        if ($buscar==''){
            $articulos = Articulo::join('modelo_contable','articulos.idcategoria','=','modelo_contable.id')
            ->select('articulos.id','articulos.idcategoria','articulos.idcategoria2','articulos.codigo','articulos.nombre','modelo_contable.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','articulos.descripcion','articulos.condicion','articulos.id_presentacion','articulos.talla')
            ->where('articulos.id_empresa','=',$id_empresa)
            ->where('articulos.stock','>','0')
            ->orderBy('articulos.id', 'desc')->paginate(10);
        }
        else{
            $articulos = Articulo::join('modelo_contable','articulos.idcategoria','=','modelo_contable.id')
            ->select('articulos.id','articulos.idcategoria','articulos.idcategoria2','articulos.codigo','articulos.nombre','modelo_contable.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','articulos.descripcion','articulos.condicion','articulos.id_presentacion','articulos.talla')
            ->where('articulos.id_empresa','=',$id_empresa)
            ->where('articulos.'.$criterio, 'like', '%'. $buscar . '%')
            ->where('articulos.stock','>','0')
            ->orderBy('articulos.id', 'desc')->paginate(10);
        }
        

        return ['articulos' => $articulos];
    }

    public function buscarArticulo(Request $request){
        if (!$request->ajax()) return redirect('/');
        $id_empresa = $request->session()->get('id_empresa');

        $filtro = $request->filtro;
        $articulos = Articulo::where('codigo','=', $filtro)
        ->join('modelo_contable','articulos.idcategoria','=','modelo_contable.id')
        ->leftJoin('productos_iva','articulos.id','=','productos_iva.id_producto')
        ->join('iva','productos_iva.id_iva','=','iva.id')
        ->select('articulos.id','articulos.id as id_articulo','articulos.idcategoria','articulos.idcategoria2','articulos.codigo','articulos.nombre','modelo_contable.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','articulos.descripcion','articulos.cod_invima','articulos.lote','articulos.minimo','articulos.tipo_articulo','articulos.condicion','articulos.id_presentacion','articulos.talla','productos_iva.id_iva','iva.nombre as nombre_iva','iva.porcentaje','productos_iva.tipo_iva')
        ->where('articulos.id_empresa','=',$id_empresa)
        // ->select('id','nombre','precio_venta','stock','iva')
        ->orderBy('nombre', 'asc')
        ->take(1)
        ->get();

        return ['articulos' => $articulos];
    }
    
    public function buscarArticuloVenta(Request $request){
        if (!$request->ajax()) return redirect('/');
        $id_empresa = $request->session()->get('id_empresa');

        $filtro = $request->filtro;
        $articulos = Articulo::where('codigo','=', $filtro)
        ->select('id','nombre','stock','precio_venta')
        ->where('id_empresa','=',$id_empresa)
        ->where('stock','>','0')
        ->orderBy('nombre', 'asc')
        ->take(1)->get();

        return ['articulos' => $articulos];
    }
    
    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $id_usuario = Auth::user()->id;
        $id_empresa = $request->session()->get('id_empresa');

        $articulo = new Articulo();
        $articulo->idcategoria = $request->idcategoria;
        $articulo->idcategoria2 = $request->idcategoria2;
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
        $articulo->talla = $request->talla;
        $articulo->id_und_medida = $request->id_und_medida;
        $articulo->id_concentracion = $request->id_concentracion;
        $articulo->id_presentacion = $request->id_presentacion;
        $articulo->id_usuario = $id_usuario;
        $articulo->id_empresa = $id_empresa;
        $articulo->condicion = '1';
        $articulo->save();

        $tarifarios = $request->arrayTarifarios;

        foreach($tarifarios as $ta)
        {
            $nuevoTarifario = new ProductoTarifario();
            $nuevoTarifario->id_tarifario = $ta['id'];
            $nuevoTarifario->id_producto = $articulo->id;
            if(isset($ta['valor']))
            {
                $nuevoTarifario->valor = $ta['valor'];
            } else { $nuevoTarifario->valor = 0;}

            $nuevoTarifario->save();
        }

        $stock = new Stock();
        $stock->id_producto = $articulo->id;
        $stock->id_facturacion = null;
        $stock->id_usuario = $articulo->id_usuario;
        $stock->cantidad = $articulo->stock;
        $stock->tipo_movimiento = $request->tipo_movimiento;
        $stock->sumatoria = $articulo->stock;
        $stock->id_empresa = $id_empresa;
        
        $stock->save();

        $iva_producto = new IvaProducto();
        $iva_producto->id_iva = 0;
        $iva_producto->tipo_iva = 'Compra';
        $iva_producto->id_producto = $articulo->id;
        $iva_producto->usu_crea = $id_usuario;
        $iva_producto->save();

        $iva_producto = new IvaProducto();
        $iva_producto->id_iva = 0;
        $iva_producto->tipo_iva = 'Venta';
        $iva_producto->id_producto = $articulo->id;
        $iva_producto->usu_crea = $id_usuario;
        $iva_producto->save();

        $iva_producto = new IvaProducto();
        $iva_producto->id_iva = 0;
        $iva_producto->tipo_iva = 'Devoluciones compra';
        $iva_producto->id_producto = $articulo->id;
        $iva_producto->usu_crea = $id_usuario;
        $iva_producto->save();

        $iva_producto = new IvaProducto();
        $iva_producto->id_iva = 0;
        $iva_producto->tipo_iva = 'Devoluciones Venta';
        $iva_producto->id_producto = $articulo->id;
        $iva_producto->usu_crea = $id_usuario;
        $iva_producto->save();
    }
    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $articulo = Articulo::findOrFail($request->id);
        $articulo->idcategoria = $request->idcategoria;
        $articulo->idcategoria2 = $request->idcategoria2;
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
        $articulo->talla = $request->talla;
        $articulo->id_und_medida = $request->id_und_medida;
        $articulo->id_concentracion = $request->id_concentracion;
        $articulo->id_presentacion = $request->id_presentacion;
        $articulo->condicion = '1';
        $articulo->save();

        $borrarTarifarios = ProductoTarifario::where('id_producto','=',$request->id)->delete();

        $tarifarios = $request->arrayTarifarios;

        foreach($tarifarios as $ta)
        {
            $nuevoTarifario = new ProductoTarifario();
            $nuevoTarifario->id_tarifario = $ta['id'];
            $nuevoTarifario->id_producto = $articulo->id;
            if(isset($ta['valor']))
            {
                $nuevoTarifario->valor = $ta['valor'];
            } else { $nuevoTarifario->valor = 0;}

            $nuevoTarifario->save();
        }
    }

    public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $articulo = Articulo::findOrFail($request->id);
        $articulo->condicion = '0';
        $articulo->save();
    }

    public function activar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $articulo = Articulo::findOrFail($request->id);
        $articulo->condicion = '1';
        $articulo->save();
    }

}
