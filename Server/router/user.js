const express=require('express');
const pool=require('../pool.js');
const router=express.Router();
const nodemailer=require('nodemailer')
const multer = require("multer");
const fs = require("fs");
module.exports = router
router.get('/check',(req,res)=>{
    var name=req.query.uname
    var email=req.query.email
    const sql = 'select * from teacher where number=?'
    pool.query(sql,name,(err,result)=>{
        if(err) throw err;
        if(result.length!=0){
            const sql1='select * from teacher where email=?'
            pool.query(sql1,email,(error,result1)=>{
                if(error) throw error;
                if(result1.length!=0){
                    res.send({code:200})//用户名和电子邮箱都存在
                }
                else{
                    res.send({code:201})//用户名存在
                }
            })
        }
        else{
            const sql2='select * from users where email=?'
            pool.query(sql2,email,(errors,result2)=>{
                if(errors) throw error;
                if(result2.length!=0){
                    res.send({code:202})//电子邮箱存在
                }
                else{
                    res.send({code:404})//都不存在
                }
            })
        }
    })
})
//解决multer中文乱码
const uploads=multer({
    dest: "public/image",
    fileFilter(req,file,callback){
        file.originalname = Buffer.from(file.originalname,'latin1').toString('utf-8');
        callback(null,true)
    }
})
router.get('/newslist',(req,res)=>{
    const sql='select * from news'
    pool.query(sql,(err,result)=>{
        if(err)throw err
        res.send(result)
    })
})
router.get('/news',(req,res)=>{
    var id=req.query.id
    const sql='select * from news where id=?'
    pool.query(sql,id,(err,result)=>{
        if(err)throw err
        res.send(result)
    })
})
router.put('/reset',(req,res)=>{
    let obj=req.body.params
    const sql='update `users` set  userpassword=? where username=?'
    pool.query(sql,[obj.password,obj.uname],(err,result)=>{
        if(err) throw err
       if(result.affectedRows!=0){
       res.send({code:200})
     }
       else{
         res.send({code:404})
       }
     })
})
router.get('/contest',(req,res)=>{
    const sql='select contestId,contestImg from contestinfo limit 4'
    pool.query(sql,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
router.get('/contestrace',(req,res)=>{
    const sql='select * from contestinfo'
    pool.query(sql,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
router.get('/race',(req,res)=>{
    var id = req.query.id
    const sql = 'select * from contestinfo where contestId=?'
    pool.query(sql,id,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
router.get('/checkoverdue',(req,res)=>{
    var contestId=req.query.contestId
    const sql='SELECT outdated FROM `contestinfo` where contestId=?'
    pool.query(sql,contestId,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
router.get('/checkattend',(req,res)=>{
    console.log(req.query)
    var contestId=req.query.contestId
    var id=req.query.name
    const sql='SELECT * FROM `usercontest` where contestId=? and username=?'
    pool.query(sql,[contestId,id],(err,result)=>{
        if(err) throw err
        if(result.length!=0){
            res.send({code:200})
        }
        else{
            res.send({code:404})
        }
    })
})
router.post('/addusercontest',(req,res)=>{
    var obj =req.body.params
    const sql='insert into `usercontest` (username,name,contestId,contestName,conteststar,contestEnd,contestcategory,Contestlevel) values (?,?,?,?,?,?,?,?)'
    pool.query(sql,[obj.username,obj.name,obj.contestId,obj.contestName,obj.conteststar,obj.contestEnd,obj.contestcategory,obj.Contestlevel],(err,result)=>{
        if(err) throw err
        if(result.affectedRows!=0){
            res.send({code:200})
        }
        else{
            res.send({code:404})
        }
    })
})
router.post("/openai12", async (req, res) => {
    try {
      const { prompt } = req.body;
      const response = await openai.createCompletion({
        model: "text-davinci-003",
        prompt: `
                ${prompt}
        
                The time complexity of this function is
                ###
              `,
        max_tokens: 64,
        temperature: 0,
        top_p: 1.0,
        frequency_penalty: 0.0,
        presence_penalty: 0.0,
        stop: ["\n"],
      });
  
      return res.status(200).json({
        success: true,
        data: response.data.choices[0].text,
      });
    } catch (error) {
      return res.status(400).json({
        success: false,
        error: error.response
          ? error.response.data
          : "There was an issue on the server",
      });
    }
  });