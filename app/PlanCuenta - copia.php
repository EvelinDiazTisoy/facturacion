<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PlanCuenta extends Model
{
    protected $table = 'plan_cuentas';
    protected $fillable = [
        'codigo', 'nombre', 'naturaleza', 'tipo', 'corriente', 'banco', 'diferido', 'tercero', 'niif', 'condicion', 'anio' 
    ];
   
}
