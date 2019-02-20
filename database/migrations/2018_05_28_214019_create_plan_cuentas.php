<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePlanCuentas extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        //
        Schema::create('plan_cuentas',function(Blueprint $table){
            $table->increments('id');            
            $table->string('codigo',50);
            $table->text('nombre');
            $table->string('naturaleza',50);
            $table->string('tipo',50);
            $table->integer('corriente')->default('0')->nullable();
            $table->integer('banco')->default('0')->nullable();
            $table->boolean('diferido')->default('0')->nullable();
            $table->boolean('tercero')->nullable('0');
            $table->string('niif',50);
            $table->boolean('condicion')->default('1');
            $table->integer('anio');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
