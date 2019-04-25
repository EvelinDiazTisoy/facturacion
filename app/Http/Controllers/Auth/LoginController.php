<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    public function showLoginForm(){
        return view('auth.login');
    }
    public function index(){
        
        //return redirect('/');
    }
    public function login(Request $request){
        //if(!isset($request->usuario)||$request->password) return redirect('/');
        $menu_usu=array();
		$hijos1=array();
        if (!$request->post()) return redirect('/');
        $this->validateLogin($request);        

        if (Auth::attempt(['usuario' => $request->usuario,'password' => $request->password,'condicion'=>1])){
            $hijos[0] = ["modulo"=>"hijo11","icono"=>"icon-home","menu"=>"7", "lectura"=>1, "escritura"=>1, "editar"=>1, "anular"=>1, "imprimir"=>1,
				"hijos" =>array(),"template_menu"=>"user"];
			$hijos[1] = ["modulo"=>"hijo12","icono"=>"icon-home","menu"=>"2", "lectura"=>1, "escritura"=>1, "editar"=>1, "anular"=>1, "imprimir"=>1,
				"hijos" =>array(),"template_menu"=>"component1"];
			$menu_usu[0] = ["modulo"=>"modulo1","icono"=>"icon-list","menu"=>"", "lectura"=>1, "escritura"=>1, "editar"=>1, "anular"=>1, "imprimir"=>1,
				"hijos" =>$hijos,"template_menu"=>""];
			
			
			$hijos1[0] = ["modulo"=>"hijo21","icono"=>"icon-home","menu"=>"3", "lectura"=>1, "escritura"=>1, "editar"=>1, "anular"=>1, "imprimir"=>1,
				"hijos" =>array(),"template_menu"=>"component1"];
			$hijos1[1] = ["modulo"=>"hijo22","icono"=>"icon-home","menu"=>"4", "lectura"=>1, "escritura"=>1, "editar"=>1, "anular"=>1, "imprimir"=>1,
				"hijos" =>array(),"template_menu"=>"component1"];
			$menu_usu[1] = ["modulo"=>"modulo2","icono"=>"icon-list","menu"=>"", "lectura"=>1, "escritura"=>1, "editar"=>1, "anular"=>1, "imprimir"=>1,
				"hijos" =>$hijos1,"template_menu"=>""];
			
			$request->session()->put('menu_usu', $menu_usu);
            return redirect()->route('main');
        }

        return back()
        ->withErrors(['usuario' => trans('auth.failed')])
        ->withInput(request(['usuario']));

    }

    protected function validateLogin(Request $request){
        $this->validate($request,[
            'usuario' => 'required|string',
            'password' => 'required|string'
        ]);

    }

    public function logout(Request $request){
        Auth::logout();
        $request->session()->invalidate();
        return redirect('/');
    }
}
