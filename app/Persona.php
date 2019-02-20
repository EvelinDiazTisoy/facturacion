<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Persona extends Model
{
    protected $fillable = ['nombre','tipo_documento','num_documento','direccion','telefono','email','sexo','fec_nac','regimen','reside','representante','tipo_persona','nombre1','nombre2','apellido1','apellido2','digito_verif','entidad','num_verif'];

    public function provedor()
    {
        return $this->hasOne('App\Proveedor');
    }

    public function user()
    {
        return $this->hasOne('App\User');
    }


}
