<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Articulo;
use App\Stock;
use Illuminate\Support\Facades\Auth;

class ArticuloController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        $id_usuario = Auth::user()->id;
        
        if ($buscar==''){
            $articulos = Articulo::join('categorias','articulos.idcategoria','=','categorias.id')
            ->join('und_medidas','articulos.id_und_medida','=','und_medidas.id')
            ->join('concentraciones','articulos.id_concentracion','=','concentraciones.id')
            ->join('presentacion','articulos.id_presentacion','=','presentacion.id')
            ->select('articulos.id','articulos.idcategoria','articulos.codigo','articulos.nombre','categorias.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','und_medidas.nombre as nombre_und_medida','id_und_medida','concentraciones.nombre as nombre_concentracion','id_concentracion','presentacion.nombre as nombre_presentacion','id_presentacion','articulos.cod_invima','articulos.lote','articulos.fec_vence','articulos.minimo','tipo_articulo','iva','articulos.descripcion','articulos.condicion')
            ->orderBy('articulos.id', 'desc')->paginate(3);
        }
        else{
            $articulos = Articulo::join('categorias','articulos.idcategoria','=','categorias.id')
            ->join('und_medidas','articulos.id_und_medida','=','und_medidas.id')
            ->join('concentraciones','articulos.id_concentracion','=','concentraciones.id')
            ->join('presentacion','articulos.id_presentacion','=','presentacion.id')
            ->select('articulos.id','articulos.idcategoria','articulos.codigo','articulos.nombre','categorias.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','und_medidas.nombre as nombre_und_medida','id_und_medida','concentraciones.nombre as nombre_concentracion','id_concentracion','presentacion.nombre as nombre_presentacion','id_presentacion','articulos.cod_invima','articulos.lote','articulos.fec_vence','articulos.minimo','tipo_articulo','iva','articulos.descripcion','articulos.condicion')
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
            'usuario' => $id_usuario
        ];
    }

    public function listarArticulo(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        
        if ($buscar==''){
            $articulos = Articulo::join('categorias','articulos.idcategoria','=','categorias.id')
            ->select('articulos.id','articulos.idcategoria','articulos.codigo','articulos.nombre','categorias.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','articulos.descripcion','articulos.cod_invima','articulos.lote','articulos.minimo','articulos.tipo_articulo','articulos.iva','articulos.condicion')
            ->orderBy('articulos.id', 'desc')->paginate(10);
        }
        else{
            $articulos = Articulo::join('categorias','articulos.idcategoria','=','categorias.id')
            ->select('articulos.id','articulos.idcategoria','articulos.codigo','articulos.nombre','categorias.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','articulos.descripcion','articulos.cod_invima','articulos.lote','articulos.minimo','articulos.tipo_articulo','articulos.iva','articulos.condicion')
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
        
        if ($buscar==''){
            $articulos = Articulo::join('categorias','articulos.idcategoria','=','categorias.id')
            ->select('articulos.id','articulos.idcategoria','articulos.codigo','articulos.nombre','categorias.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','articulos.descripcion','articulos.condicion')
            ->where('articulos.stock','>','0')
            ->orderBy('articulos.id', 'desc')->paginate(10);
        }
        else{
            $articulos = Articulo::join('categorias','articulos.idcategoria','=','categorias.id')
            ->select('articulos.id','articulos.idcategoria','articulos.codigo','articulos.nombre','categorias.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','articulos.descripcion','articulos.condicion')
            ->where('articulos.'.$criterio, 'like', '%'. $buscar . '%')
            ->where('articulos.stock','>','0')
            ->orderBy('articulos.id', 'desc')->paginate(10);
        }
        

        return ['articulos' => $articulos];
    }

    public function buscarArticulo(Request $request){
        if (!$request->ajax()) return redirect('/');

        $filtro = $request->filtro;
        $articulos = Articulo::where('codigo','=', $filtro)
        ->select('id','nombre','precio_venta','stock')->orderBy('nombre', 'asc')->take(1)->get();

        return ['articulos' => $articulos];
    }
    
    public function buscarArticuloVenta(Request $request){
        if (!$request->ajax()) return redirect('/');

        $filtro = $request->filtro;
        $articulos = Articulo::where('codigo','=', $filtro)
        ->select('id','nombre','stock','precio_venta')
        ->where('stock','>','0')
        ->orderBy('nombre', 'asc')
        ->take(1)->get();

        return ['articulos' => $articulos];
    }
    
    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $id_usuario = Auth::user()->id;
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
        $articulo->id_usuario = $id_usuario;
        $articulo->condicion = '1';
        $articulo->save();

        $stock = new Stock();
        $stock->id_producto = $articulo->id;
        $stock->id_usuario = $articulo->id_usuario;
        $stock->cantidad = $articulo->stock;
        $stock->tipo_movimiento = $request->tipo_movimiento;
        $stock->sumatoria = $articulo->stock;
        
        $stock->save();
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
