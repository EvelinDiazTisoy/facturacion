<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Persona;
use Illuminate\Support\Facades\DB;

class ClienteController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        
        if ($buscar==''){
            $personas = Persona::orderBy('id', 'desc')->paginate(20);
        }
        else{
            $personas = Persona::where($criterio, 'like', '%'. $buscar . '%')->orderBy('id', 'desc')->paginate(20);
        }
        

        return [
            'pagination' => [
                'total'        => $personas->total(),
                'current_page' => $personas->currentPage(),
                'per_page'     => $personas->perPage(),
                'last_page'    => $personas->lastPage(),
                'from'         => $personas->firstItem(),
                'to'           => $personas->lastItem(),
            ],
            'personas' => $personas
        ];
    }

    public function selectCliente(Request $request){
       // if (!$request->ajax()) return redirect('/');

        $filtro = $request->filtro;
        /*$clientes = Persona::Where('num_documento', 'like', '%'. $filtro . '%')
        ->orWhere('nombre', 'like', '%'. $filtro . '%')
        ->select('id','nombre','num_documento')
        ->orderBy('nombre', 'asc')->get();
*/
        $cons="select *,case tipo_persona when 'Juridica' then concat(nombre,' - ',num_documento) when 'Natural' then concat(nombre1,' ',nombre2,' ',apellido1,' ',apellido2,' - ',num_documento) when '' then concat(nombre,' - ',num_documento) end as nom_y_ced from personas where nombre like '%$filtro%' or num_documento like '%$filtro%' or nombre1 like '%$filtro%' or nombre2 like '%$filtro%' or apellido1 like '%$filtro%' or apellido2 like '%$filtro%' 
        or concat(nombre1,' ',nombre2,' ',apellido1,' ',apellido2) like '%$filtro%' or concat(nombre1,' ',apellido1,' ',apellido2) like '%$filtro%' or concat(nombre1,' ',nombre2,' ',apellido1) like '%$filtro%' or concat(nombre1,' ',apellido1) like '%$filtro%' or entidad like '%$filtro%' order by nombre asc";
        //echo $cons;

        $clientes = DB::select($cons);
        
        return ['clientes' => $clientes];
    }
    public function selectCliente2(Request $request){
        // if (!$request->ajax()) return redirect('/');
 
         $id = $request->id;
        
         $cons="select *,case tipo_persona when 'Juridica' then concat(nombre,' - ',num_documento) when 'Natural' then concat(nombre1,' ',nombre2,' ',apellido1,' ',apellido2,' - ',num_documento) when '' then concat(nombre,' - ',num_documento) end as nom_y_ced from personas 
         where id = $id order by nombre asc";
         //echo $cons;
         $clientes = DB::select($cons);
         return ['clientes' => $clientes]; 
     }

    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $persona = new Persona();
        if(!$request->nombre)  $persona->nombre = ''; else    $persona->nombre = $request->nombre;
        $persona->nombre = $request->nombre;
        $persona->tipo_documento = $request->tipo_documento;
        $persona->num_documento = $request->num_documento;
        $persona->direccion = $request->direccion;
        $persona->telefono = $request->telefono;
        $persona->sexo = $request->sexo;
        $persona->regimen = $request->regimen;
        $persona->fec_nac = $request->fec_nac;
        $persona->reside = $request->reside;
        $persona->representante = $request->representante;
        $persona->email = $request->email;
        $persona->tipo_persona = $request->tipo_persona;
        $persona->entidad = $request->entidad;       
        if(!$request->nombre1)  $persona->nombre1 = ''; else    $persona->nombre1 = $request->nombre1;
        if(!$request->nombre2)  $persona->nombre2 = ''; else    $persona->nombre2 = $request->nombre2;
        if(!$request->apellido1)  $persona->apellido1 = ''; else    $persona->apellido1 = $request->apellido1;
        if(!$request->apellido2)  $persona->apellido2 = ''; else    $persona->apellido2 = $request->apellido2;
        if($request->digito_verif) {
            $persona->digito_verif = "1";  
            $persona->num_verif = $request->num_verif;  
        }
        else{
            $persona->digito_verif = "0";  
            $persona->num_verif = "";  
        } 
        

        $persona->save();
    }

    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $persona = Persona::findOrFail($request->id);
        $persona->nombre = $request->nombre;
        $persona->tipo_documento = $request->tipo_documento;
        $persona->num_documento = $request->num_documento;
        $persona->direccion = $request->direccion;
        $persona->telefono = $request->telefono;
        $persona->email = $request->email;
        $persona->sexo = $request->sexo;
        $persona->regimen = $request->regimen;
        $persona->fec_nac = $request->fec_nac;
        $persona->reside = $request->reside;
        $persona->representante = $request->representante;
        $persona->tipo_persona = $request->tipo_persona;
        $persona->nombre1 = $request->nombre1;
        $persona->nombre2 = $request->nombre2;
        $persona->apellido1 = $request->apellido1;
        $persona->apellido2 = $request->apellido2;
        $persona->entidad = $request->entidad;
        //echo "dito=".$request->digito_verif; exit;
        if($request->digito_verif) {
            $persona->digito_verif = "1";  
            $persona->num_verif = $request->num_verif;  
        }
        else{
            $persona->digito_verif = "0";  
            $persona->num_verif = "";  
        } 
        
        $persona->save(); 
    }
}
