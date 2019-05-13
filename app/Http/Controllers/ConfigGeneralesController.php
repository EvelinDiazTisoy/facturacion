<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\ConfigGenerales;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ConfigGeneralesController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;
        
        if ($buscar==''){
            $configgenerales = ConfigGenerales::orderBy('id', 'desc')->paginate(6);
        }
        else{
            $configgenerales = ConfigGenerales::where($criterio, 'like', '%'. $buscar . '%')->orderBy('id', 'desc')->paginate(6);
        }
        return [
            'pagination' => [
                'total'        => $configgenerales->total(),
                'current_page' => $configgenerales->currentPage(),
                'per_page'     => $configgenerales->perPage(),
                'last_page'    => $configgenerales->lastPage(),
                'from'         => $configgenerales->firstItem(),
                'to'           => $configgenerales->lastItem(),
            ],
            'configgenerales' => $configgenerales,
        ];
    }

    public function store(Request $request)
    {
        // if (!$request->ajax()) return redirect('/');
        $id_usuario = Auth::user()->id;
        $id_empresa = $request->session()->get('id_empresa');

        $carpetaEmpresa = $id_empresa .'_empresa'; 
        $dirEmpresa = public_path("logos/$carpetaEmpresa");
        if (!file_exists($dirEmpresa)) mkdir($dirEmpresa, 0777);

        if(is_uploaded_file($_FILES['logo']['tmp_name']))
        {
            $nombreLogo = $_FILES['logo']['name'];
            if($_FILES['logo']['type'] == "image/jpg" || $_FILES['logo']['type'] == "image/jpeg" || $_FILES['logo']['type'] == "image/png")
            {
                copy($_FILES['logo']['tmp_name'],$dirEmpresa.'/'.$_FILES['logo']['name']);

                $archivo = [
                    'nombre' => $request->nombre,
                    'logo' => $nombreLogo,
                    'repre_legal' => $request->repre_legal,
                    'nit' => $request->nit,
                    'nombre' => $request->nombre,
                    'res_fact_elect' => $request->res_fact_elect,
                    'res_fact_pos' => $request->res_fact_pos,
                    'correo' => $request->correo,
                    'celular' => $request->celular,
                    'telefono' => $request->telefono,
                    'usu_crea' => $id_usuario,
                ];

                ConfigGenerales::create($archivo);
            }
        }
    }

    public function update(Request $request)
    {
        // if (!$request->ajax()) return redirect('/');
        $id_usuario = Auth::user()->id;
        $id_empresa = $request->session()->get('id_empresa');

        $carpetaEmpresa = '1_empresa'; 
        $dirEmpresa = public_path("logos/$carpetaEmpresa");
        if (!file_exists($dirEmpresa)) mkdir($dirEmpresa, 0777);

        if(is_uploaded_file($_FILES['logo']['tmp_name']))
        {
            $nombreLogo = $_FILES['logo']['name'];
            if($_FILES['logo']['type'] == "image/jpg" || $_FILES['logo']['type'] == "image/jpeg" || $_FILES['logo']['type'] == "image/png")
            {
                copy($_FILES['logo']['tmp_name'],$dirEmpresa.'/'.$_FILES['logo']['name']);

                $archivo = [
                    'nombre' => $request->nombre,
                    'logo' => $nombreLogo,
                    'repre_legal' => $request->repre_legal,
                    'nit' => $request->nit,
                    'nombre' => $request->nombre,
                    'res_fact_elect' => $request->res_fact_elect,
                    'res_fact_pos' => $request->res_fact_pos,
                    'correo' => $request->correo,
                    'celular' => $request->celular,
                    'telefono' => $request->telefono,
                ];

                $config = ConfigGenerales::findOrFail($request->id);
                $config->update($archivo);
            }
        }
    }

    public function listarPermisos(Request $request){
        // if (!$request->ajax()) return redirect('/');

        $id_rol = $request->id_rol;
        
        $total = array();
        $modu = array();
        $permi = array();
        $permisos = array();

        $modulos = Modulo::join('users','modulos.usu_crea','=','users.id')
        ->select('modulos.id','modulos.nombre','modulos.descripcion','modulos.componente','modulos.menu','modulos.tipo','modulos.icono','modulos.template','modulos.padre','modulos.estado')
        ->where('tipo','=','1')
        ->where('estado','=','1')
        ->orderBy('nombre', 'asc')
        ->get();

        foreach($modulos as $mod)
        {
            $total[] = $mod;
            $modulos2= Modulo::where('tipo','=','2')
            ->where('padre','=',$mod['id'])
            ->where('estado','=','1')
            ->orderBy('nombre','asc')
            ->get();
            foreach($modulos2 as $mod2)
            {
                $total[] = $mod2;
            }
        }

        if($id_rol!='' && $id_rol!=null && $id_rol!=0)
        {
            foreach($total as $t)
            {
                $modu = array(
                    'id' => $t['id'],
                    'nombre' => $t['nombre'],
                    'id_rol' => $id_rol,
                    'tipo' => $t['tipo'],
                );

                $permisos = RolPermisos::where('id_rol','=',$id_rol)
                ->where('id_modulo', '=', $t['id'])
                ->get();
                
                if(count($permisos)!=0)
                {
                    foreach($permisos as $pe)
                    {
                        $permi = array(
                            'lectura' => $pe['lectura'],
                            'escritura' => $pe['escritura'],
                            'edicion' => $pe['edicion'],
                            'anular' => $pe['anular'],
                            'imprimir' => $pe['imprimir'],
                        );
                    }
                }
                else
                {
                    $permi = array(
                        'lectura' => '',
                        'escritura' => '',
                        'edicion' => '',
                        'anular' => '',
                        'imprimir' => '',
                    );
                }

                $respuesta[] = array_merge($modu, $permi);
            }
        }
        else
        {
            $respuesta = $total;
        }
        
        
        return [
            'permisos' => $respuesta,
        ];
    }

    public function selectRol(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $roles = ConfigGenerales::where('estado', '=', '1')
        ->select('id','nombre')
        ->orderBy('nombre', 'asc')->get();

        return ['roles' => $roles];
    }

    public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $roles = ConfigGenerales::findOrFail($request->id);
        $roles->estado = '0';
        $roles->save();
    }

    public function activar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $roles = ConfigGenerales::findOrFail($request->id);
        $roles->estado = '1';
        $roles->save();
    }
}
