<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Configuraciones extends Model
{
    protected $table = 'configuraciones';
    protected $fillable = ['id','lugar'];

    // public function articulos()
    // {
    //     return $this->hasMany('App\Articulo');
    // }
}
