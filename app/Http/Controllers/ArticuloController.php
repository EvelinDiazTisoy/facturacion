<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Articulo;
use App\Stock;
use App\ProductoTarifario;
use App\IvaProducto;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

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
            $articulos = Articulo::leftJoin('modelo_contable','articulos.idcategoria','=','modelo_contable.id')
            ->leftJoin('presentacion','articulos.id_presentacion','=','presentacion.id')
            ->select('articulos.id','articulos.id as id_articulo','articulos.idcategoria','articulos.idcategoria2','articulos.codigo','articulos.nombre','modelo_contable.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','id_und_medida','id_concentracion','articulos.cod_invima','articulos.lote','articulos.fec_vence','articulos.minimo','tipo_articulo','articulos.descripcion','articulos.condicion','articulos.id_presentacion','articulos.talla','articulos.img','articulos.id_empresa','presentacion.nombre as nom_presentacion')
            ->where('articulos.id_empresa','=',$id_empresa)
            ->orderBy('articulos.id', 'desc')->paginate(3);
        }
        else{
            $articulos = Articulo::leftJoin('modelo_contable','articulos.idcategoria','=','modelo_contable.id')
            ->leftJoin('presentacion','articulos.id_presentacion','=','presentacion.id')
            ->select('articulos.id','articulos.id as id_articulo','articulos.idcategoria','articulos.idcategoria2','articulos.codigo','articulos.nombre','modelo_contable.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','id_und_medida','id_concentracion','articulos.cod_invima','articulos.lote','articulos.fec_vence','articulos.minimo','tipo_articulo','articulos.descripcion','articulos.condicion','articulos.id_presentacion','articulos.talla','articulos.img','articulos.id_empresa','presentacion.nombre as nom_presentacion')
            ->where('articulos.id_empresa','=',$id_empresa)
            ->where('articulos.'.$criterio, 'like', '%'. $buscar . '%')
            ->orWhere('articulos.codigo', 'like', '%'. $buscar . '%')
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
        
        /*$articulos = Articulo::leftJoin('modelo_contable','articulos.idcategoria','=','modelo_contable.id')
        ->leftJoin('categorias','articulos.idcategoria2','=','categorias.id')
        ->leftJoin('productos_iva','articulos.id','=','productos_iva.id_producto')
        ->leftJoin('iva','productos_iva.id_iva','=','iva.id')
        ->leftJoin('presentacion','articulos.id_presentacion','=','presentacion.id')
        ->select('articulos.id','articulos.id as id_articulo','articulos.idcategoria','articulos.idcategoria2','articulos.codigo','articulos.nombre','modelo_contable.nombre as nom_modelo_contable','categorias.nombre as nom_categoria','articulos.precio_venta','articulos.stock','articulos.descripcion','articulos.cod_invima','articulos.lote','articulos.minimo','articulos.tipo_articulo','articulos.condicion','articulos.id_presentacion','articulos.talla','articulos.img','articulos.id_empresa','productos_iva.id_iva','iva.nombre as nombre_iva','iva.porcentaje','productos_iva.tipo_iva','presentacion.nombre as nom_presentacion')
        ->where('articulos.id_empresa','=',$id_empresa)
        ->where('articulos.condicion','=',1)
        ->where('productos_iva.tipo_iva','=','Compra')
        ->orWhere('articulos.'.$criterio, 'like', '%'. $buscar . '%')
        ->orWhere('articulos.codigo', 'like', '%'. $buscar . '%')
        ->groupBy('id')
        ->orderBy('articulos.id', 'desc')->get();*/

        if(isset($request->categoria))
        {
            $cons_categoria = 'AND articulos.idcategoria2='.$request->categoria;
        }
        else
        {
            $cons_categoria = '';
        }
        
        $cons = "SELECT articulos.id,articulos.id as id_articulo,articulos.idcategoria,articulos.idcategoria2,articulos.codigo,articulos.nombre,modelo_contable.nombre as nom_modelo_contable,categorias.nombre as nom_categoria,articulos.precio_venta,articulos.stock,articulos.descripcion,articulos.cod_invima,articulos.lote,articulos.minimo,articulos.tipo_articulo,articulos.condicion,articulos.id_presentacion,articulos.talla,articulos.img,articulos.id_empresa,productos_iva.id_iva,iva.nombre as nombre_iva,iva.porcentaje,productos_iva.tipo_iva,presentacion.nombre as nom_presentacion FROM `articulos`,`modelo_contable`,`categorias`,`presentacion`,`productos_iva`,`iva` WHERE articulos.idcategoria=modelo_contable.id AND articulos.idcategoria2=categorias.id AND articulos.id_presentacion=presentacion.id AND productos_iva.id_producto=articulos.id AND iva.id=productos_iva.id_iva AND productos_iva.tipo_iva='Compra' AND (articulos.nombre LIKE '%".$buscar."%' OR articulos.codigo LIKE '%".$buscar."%') ".$cons_categoria." AND articulos.id_empresa=".$id_empresa." GROUP BY articulos.id ORDER BY articulos.id DESC";
        
        $articulos2 = DB::select($cons);

        return ['cons'=>$cons,'categoria'=>$request->categoria,'articulos' => $articulos2];
    }
 
    public function listarArticuloVenta(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        $id_empresa = $request->session()->get('id_empresa');
        
        if ($buscar==''){
            $articulos = Articulo::join('modelo_contable','articulos.idcategoria','=','modelo_contable.id')
            ->select('articulos.id','articulos.idcategoria','articulos.idcategoria2','articulos.codigo','articulos.nombre','modelo_contable.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','articulos.descripcion','articulos.condicion','articulos.id_presentacion','articulos.talla','articulos.img','articulos.id_empresa')
            ->where('articulos.id_empresa','=',$id_empresa)
            ->where('articulos.stock','>','0')
            ->orderBy('articulos.id', 'desc')->paginate(10);
        }
        else{
            $articulos = Articulo::join('modelo_contable','articulos.idcategoria','=','modelo_contable.id')
            ->select('articulos.id','articulos.idcategoria','articulos.idcategoria2','articulos.codigo','articulos.nombre','modelo_contable.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','articulos.descripcion','articulos.condicion','articulos.id_presentacion','articulos.talla','articulos.img','articulos.id_empresa')
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
        ->select('articulos.id','articulos.id as id_articulo','articulos.idcategoria','articulos.idcategoria2','articulos.codigo','articulos.nombre','modelo_contable.nombre as nombre_categoria','articulos.precio_venta','articulos.stock','articulos.descripcion','articulos.cod_invima','articulos.lote','articulos.minimo','articulos.tipo_articulo','articulos.condicion','articulos.id_presentacion','articulos.talla','articulos.img','articulos.id_empresa','productos_iva.id_iva','iva.nombre as nombre_iva','iva.porcentaje','productos_iva.tipo_iva')
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
    
    /*public function store(Request $request)
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
    }*/

    public function store(Request $request)
    {
        // if (!$request->ajax()) return redirect('/');
        $id_usuario = Auth::user()->id;
        $id_empresa = $request->session()->get('id_empresa');

        $carpetaEmpresa = $id_empresa .'_empresa'; 
        $dirEmpresa = public_path("img_productos/$carpetaEmpresa");
        if (!file_exists($dirEmpresa)) mkdir($dirEmpresa, 0777);

        if(is_uploaded_file($_FILES['img']['tmp_name']))
        {
            $nombreImg = $_FILES['img']['name'];
            if($_FILES['img']['type'] == "image/jpg" || $_FILES['img']['type'] == "image/jpeg" || $_FILES['img']['type'] == "image/png")
            {
                copy($_FILES['img']['tmp_name'],$dirEmpresa.'/'.$_FILES['img']['name']);
            }
        }
        else
        {
            $dirEmpresa = public_path("img_productos");
            $nombreImg = 'default.png';
        }

            $archivo = [
                'idcategoria' => $request->idcategoria,
                'idcategoria2' => $request->idcategoria2,
                'codigo' => $request->codigo,
                'nombre' => $request->nombre,
                'precio_venta' => $request->precio_venta,
                'stock' => $request->stock,
                'descripcion' => $request->descripcion,
                'cod_invima' => $request->cod_invima,
                'lote' => $request->lote,
                'fec_vence' => $request->fec_vence,
                'minimo' => $request->minimo,
                'tipo_articulo' => $request->tipo_articulo,
                'iva' => $request->iva,
                'talla' => $request->talla,
                'id_und_medida' => $request->id_und_medida,
                'id_concentracion' => $request->id_concentracion,
                'id_presentacion' => $request->id_presentacion,
                'id_usuario' => $id_usuario,
                'id_empresa' => $id_empresa,
                'condicion' => '1',
                'img' => $nombreImg,
            ];

            Articulo::create($archivo);

            $tarifarios = $request->arrayTarifarios;
            $tarifarios = json_decode($tarifarios);

            for($i=0; $i<count($tarifarios); $i++)
            {
                $nuevoTarifario = new ProductoTarifario();
                $nuevoTarifario->id_tarifario = $tarifarios[$i]->id;
                $nuevoTarifario->id_producto = $articulo->id;
                if(isset($tarifarios[$i]->valor))
                {
                    $nuevoTarifario->valor = $tarifarios[$i]->valor;
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

    /*public function update(Request $request)
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
    }*/

    public function update(Request $request)
    {
        // if (!$request->ajax()) return redirect('/');
        $id_usuario = Auth::user()->id;
        $id_empresa = $request->session()->get('id_empresa');

        $carpetaEmpresa = $id_empresa .'_empresa'; 
        $dirEmpresa = public_path("img_productos/$carpetaEmpresa");
        if (!file_exists($dirEmpresa)) mkdir($dirEmpresa, 0777);

        if(is_uploaded_file($_FILES['img']['tmp_name']))
        {
            $nombreImg = $_FILES['img']['name'];
            if($_FILES['img']['type'] == "image/jpg" || $_FILES['img']['type'] == "image/jpeg" || $_FILES['img']['type'] == "image/png")
            {
                copy($_FILES['img']['tmp_name'],$dirEmpresa.'/'.$_FILES['img']['name']);
            }
        }
        else
        {
            $dirEmpresa = public_path("img_productos");
            $nombreImg = 'default.png';
        }

        $archivo = [
            'idcategoria' => $request->idcategoria,
            'idcategoria2' => $request->idcategoria2,
            'codigo' => $request->codigo,
            'nombre' => $request->nombre,
            'precio_venta' => $request->precio_venta,
            'stock' => $request->stock,
            'descripcion' => $request->descripcion,
            'cod_invima' => $request->cod_invima,
            'lote' => $request->lote,
            'fec_vence' => $request->fec_vence,
            'minimo' => $request->minimo,
            'tipo_articulo' => $request->tipo_articulo,
            'iva' => $request->iva,
            'talla' => $request->talla,
            'id_und_medida' => $request->id_und_medida,
            'id_concentracion' => $request->id_concentracion,
            'id_presentacion' => $request->id_presentacion,
            'condicion' => '1',
            'img' => $nombreImg,
        ];


        $articulo = Articulo::findOrFail($request->id);
        $articulo->update($archivo);

        $borrarTarifarios = ProductoTarifario::where('id_producto','=',$request->id)->delete();

        $tarifarios = $request->arrayTarifarios;
        $tarifarios = json_decode($tarifarios);

        for($i=0; $i<count($tarifarios); $i++)
        {
            $nuevoTarifario = new ProductoTarifario();
            $nuevoTarifario->id_tarifario = $tarifarios[$i]->id;
            $nuevoTarifario->id_producto = $articulo->id;
            if(isset($tarifarios[$i]->valor))
            {
                $nuevoTarifario->valor = $tarifarios[$i]->valor;
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
