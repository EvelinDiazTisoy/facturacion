<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateConfFormatosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('conf_formatos', function (Blueprint $table) {
            $table->increments('id');
            $table->string('tipo',20);
            $table->boolean('retencion');
            $table->string('no_inicio',20);
            $table->boolean('cierre');
            $table->boolean('acarreo');
            $table->boolean('depreciacion');
            $table->boolean('fiscal');
            $table->boolean('niif');
            $table->string('nombre','300');
            $table->boolean('condicion');
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
        Schema::dropIfExists('conf_formatos');
    }
}
