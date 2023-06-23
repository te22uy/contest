<template>
    
</template>
<script>
import { ArrowRight } from '@element-plus/icons-vue';

import axios from 'axios';
import { ref } from 'vue';
import { ElMessage } from 'element-plus'
import router from '@/router';
export default{
data(){
    
},
methods:{
    qiow(){
        axios.post(
    'https://api.openai.com/v1/chat/completions',
    // '{\n    "model": "gpt-3.5-turbo",\n    "messages": [{"role": "user", "content": "Hello!"}]\n  }',
    {
        'model': 'gpt-3.5-turbo',
        'messages': [
            {
                'role': 'user',
                'content': 'Hello!'
            }
        ]
    },
    {
        headers: {
            'Content-Type': 'application/json',
            'Authorization': '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'
        }
    }
).then(res=>{console.log(res.data)})
    }
},
mounted(){
    this.qiow();
}

 } 
  </script>
