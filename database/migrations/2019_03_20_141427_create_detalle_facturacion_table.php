<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateDetalleFacturacionTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('detalle_facturacion', function (Blueprint $table) {
            $table->increments('id');

            $table->integer('id_factura')->unsigned();
            $table->integer('id_producto')->unsigned();
            $table->double('valor_venta', 15,2);
            $table->integer('cantidad');
            $table->double('valor_iva',15,2);
            $table->double('valor_descuento', 15, 2);
            $table->double('porcentaje_iva', 15,2);
            $table->double('valor_subtotal', 15,2);
            $table->double('valor_final', 15,2);

            $table->foreign('id_factura')->references('id')->on('facturacion');
            $table->foreign('id_producto')->references('id')->on('articulos');

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
        Schema::dropIfExists('detalle_facturacion');
    }
}
