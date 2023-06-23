<template>
    <p v-for="n in listData.arr"><p v-html="n.content"></p></p>
    </template>
    <script setup>
    import axios from 'axios'
    import { ref,reactive, onBeforeMount } from 'vue';
    import{useRouter,useRoute} from 'vue-router'
  const route=useRoute()
    const router=useRouter()
        let listData = reactive({
            arr:[]
        })
        onBeforeMount(()=>{
            axios.get('api/user/news',{
                params:{
                    id:route.query.id
                }
            })
            .then(res=>{
               listData.arr= res.data
               console.log(listData.arr[0].content.search('<br/>'))
               console.log(listData.arr[0].content)
            })
         })
        
    </script>
    <style scoped>
    p{
        text-indent: 2em;
    }
</style>