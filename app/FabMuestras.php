<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class FabMuestras extends Model
{
    protected $table = "fab_muestras";
    protected $filleable = ['num_muestra','leyenda','resist_dise','diametro_cilindro','fec_entra','fec_muestra','condicion','medida_resistencia','descripcion','por_fallar'];

}
