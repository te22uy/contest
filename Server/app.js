const express = require('express')
const userRouter = require('./router/user')
const adminRouter = require('./router/admin')
const bodyParse=require('body-parser')
const { Configuration, OpenAIApi } = require("openai")
const app = express()
const port = 5858
app.listen(port,()=>{
    console.log('服务器成功监听端口:'+port)
})
app.use(express.static('./public'))
app.use(bodyParse.urlencoded({ extended:false}));
app.use(bodyParse.json({limit:'9100000kb'}))
app.use('/user',userRouter)
app.use('/admin',adminRouter)