<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateFacturacionTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('facturacion', function (Blueprint $table) {
            $table->increments('id');

            $table->integer('num_factura')->unique();
            $table->integer('id_tercero')->unsigned();
            $table->integer('id_usuario')->unsigned();
            $table->dateTime('fec_crea')->timestamp();
            $table->dateTime('fec_edita')->nullable();
            $table->integer('usu_edita');
            $table->double('subtotal', 15, 2);
            $table->double('valor_iva', 15, 2);
            $table->double('total', 15, 2);
            $table->double('abono', 15, 2);
            $table->double('saldo', 15, 2);
            $table->text('detalle')->nullable();
            $table->double('descuento', 15, 2);
            $table->dateTime('fec_registra')->nullable();
            $table->dateTime('fec_envia')->nullable();
            $table->dateTime('fec_anula')->nullable();
            $table->integer('usu_registra')->unsigned()->nullable();
            $table->integer('usu_envia')->unsigned()->nullable();
            $table->integer('usu_anula')->unsigned()->nullable();
            $table->date('fecha');
            $table->boolean('estado')->default(1);
            

            $table->foreign('id_tercero')->references('id')->on('personas');
            $table->foreign('id_usuario')->references('id')->on('users');
            $table->foreign('usu_registra')->references('id')->on('users');
            $table->foreign('usu_envia')->references('id')->on('users');
            $table->foreign('usu_anula')->references('id')->on('users');

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
        Schema::dropIfExists('facturacion');
    }
}
