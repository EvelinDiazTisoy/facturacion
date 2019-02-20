<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class FabCilindros extends Model
{
    protected $table = "fab_cilindros";
    protected $filleable = ['id_proyecto','id_muestra','nom_cilindro','res_cilindro','dias','fecha_cilindro','condicion','nom_cilindro2','res_cilindro2','nom_cilindro3','res_cilindro3','nom_cilindro4','res_cilindro4','nom_cilindro5','res_cilindro5','nom_cilindro6','res_cilindro6','num_cilindros'];

}
