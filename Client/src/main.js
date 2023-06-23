import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import '@/assets/css.css'
import '@/assets/icon/iconfont.css'
import * as echarts from "echarts";


let app=createApp(App).use(router).use(store).use(ElementPlus).use(echarts);
app.mount('#app')
