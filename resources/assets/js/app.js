
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

Vue.component('rol', require('./components/Rol.vue'));
Vue.component('user', require('./components/User.vue'));
Vue.component('terceros', require('./components/Terceros.vue'));
Vue.component('modulo', require('./components/Modulo.vue'));

const app = new Vue({
    el: '#app', 
    data :{
        menu : 0,
        ruta : 'http://localhost/laravel_estudio/sistema2/public'
    }
});
