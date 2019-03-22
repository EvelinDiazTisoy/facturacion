<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Articulo extends Model
{
    protected $table = 'articulos';
    protected $fillable =[
        'id','idcategoria','codigo','nombre','precio_venta','stock','cod_invima','lote','fec_vence','id_und_medida','id_concentracion','id_presentacion','descripcion','condicion'
    ];
    public function categoria(){
        return $this->belongsTo('App\Categoria');
    }

    public function und_medida(){
        return $this->belongsTo('App\UndMedida');
    }

    public function consentracion(){
        return $this->belongsTo('App\Concentracion');
    }

    public function presentacion(){
        return $this->belongsTo('App\Presentacion');
    }
    public function detalle_factura(){
        return $this->belongsTo('App\DetalleFacturacion');
    }
}
