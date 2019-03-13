
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

import './bootstrap';

window.Vue = require('vue');

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

Vue.component('categoria', require('./components/Categoria.vue'));
Vue.component('articulo', require('./components/Articulo.vue'));
Vue.component('cliente', require('./components/Cliente.vue'));
Vue.component('proveedor', require('./components/Proveedor.vue'));
Vue.component('rol', require('./components/Rol.vue'));
Vue.component('user', require('./components/User.vue'));
Vue.component('ingreso', require('./components/Ingreso.vue'));
Vue.component('venta', require('./components/Venta.vue'));
Vue.component('plancuentas', require('./components/PlanCuentas.vue'));
Vue.component('conformatos', require('./components/ConFormatos.vue'));
Vue.component('formatos', require('./components/Formatos.vue'));
Vue.component('registroconta', require('./components/RegistroConta.vue'));
Vue.component('terceros', require('./components/Terceros.vue'));
Vue.component('fab_proyectos', require('./components/FabProyectos.vue'));
Vue.component('fab_list_cilindros', require('./components/ListCilindros.vue'));
Vue.component('fab_cils_proyecto', require('./components/CilxProyecto.vue'));
Vue.component('auxiliares_conta', require('./components/AuxiliaresConta.vue'));
Vue.component('presentacion', require('./components/Presentacion.vue'));
Vue.component('und_medida', require('./components/UndMedida.vue'));
Vue.component('concentracion', require('./components/Concentracion.vue'));
Vue.component('stock', require('./components/Stock.vue'));

const app = new Vue({
    el: '#app', 
    data :{
        menu : 0,
        ruta : 'http://localhost:8081/laravel_estudio/sistema/public'
    }
});
