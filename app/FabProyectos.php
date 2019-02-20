<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class FabProyectos extends Model
{
    protected $table = "fab_proyectos";
    protected $filleable = ['nom_proyecto','cliente','condicion','fecha','ubicacion'];

}
