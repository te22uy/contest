const express=require('express');
const pool=require('../pool.js');
const router=express.Router();
const nodemailer=require('nodemailer')
const multer = require("multer");
const fs = require("fs");
const paths=require("path");
const { send } = require('process');
module.exports = router
router.put('/reset',(req,res)=>{
    let obj=req.body.params
    const sql='update `teacher` set  password=? where number=?'
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
//解决multer中文乱码
const uploads=multer({
    dest: "public/image",
    fileFilter(req,file,callback){
        file.originalname = Buffer.from(file.originalname,'latin1').toString('utf-8');
        callback(null,true)
    }
})
//登录接口
router.get('/loginUser',(req,res)=>{
    var username=req.query.uname
    var password=req.query.password
    const sql = 'select * from users where username=? and userpassword=?'
    pool.query(sql,[username,password],(err,result)=>{
        if(err) throw err;
        if(result.length!=0){res.send({code:200,result})}
        else{
            res.send({code:404})
        }
    })

})
router.get('/loginadmin',(req,res)=>{
    // var username=req.query.uname
    // var password=req.query.password
    // const sql = 'select * from teacher where number=? and password=?'
    // pool.query(sql,[username,password],(err,result)=>{
    //     if(err) throw err;
    //     if(result.length!=0){res.send({code:200,result})}
    //     else{
    //         res.send({code:404})
    //     }
    // })
    console.log('aufdsvosdv')
    res.send({code:'usf'})
})
//添加新闻接口
router.post('/AddNew',(req,res)=>{
    let obj=req.body.params
    var name=obj.newname
    var text=obj.text
    var author=obj.author
    const sql='insert into `news`(NewsName,NewAuthor,content,time) value(?,?,?,NOW())'
    pool.query(sql,[name,author,text],(err,result)=>{
        if(err) return console.log(err.message)
        if(result.affectedRows===1){
            res.send({code:200})   
        }
        else{
            res.send({code:404})
        }
    })
})
//删除新闻
router.delete('/newdelete',(req,res)=>{
    var id=req.query.id
    const sql='delete from news where id=? '
    pool.query(sql,id,(err,result)=>{
        if(err) throw err
        if(result.affectedRows!=0){
            res.send({code:200})
        }
        else{
            res.send({code:404})
        }
    })
})
//修改新闻
router.put('/changeNew',(req,res)=>{
    let obj=req.body.params
    const sql='update `news` set  NewsNamed=?,content=? where id=?'
    pool.query(sql,[obj.Newname,obj.text,obj.id],(err,result)=>{
        if(err) throw err
        if(result.affectedRows!=0){
            res.send({code:200})
        }
        else{
            res.send({code:404})
        }
    })
})
//发送验证码
router.get('/getcode',(req,res)=>{
    var touser=req.query.email
    let code = Math.floor(Math.random()*900000)+100000
    //建立一个smtp链接
    let transporter =nodemailer.createTransport({
        host:'smtp.qq.com',
        secureConnection:true,
        port:465,
        auth:{
            user:'2638532721@qq.com',
            pass:'pdkzmcvdmvvreaeg'
        }
    })
    let options={
        from:'2638532721@qq.com',
        to:`2638532721@qq.com,${touser}`,
        subject:'欢迎你',
        html:`<div style="width:600px;margin:30px auto"><h1 style="text-align:center;">欢迎注册学科竞赛管理系统</h1><p>此次验证码如下</p><strong style="font-size:20px;display:block;text-align:center;color:red">${code}</strong><p>验证码15分钟有效，请及时输入</p><i style="color:#00bfff">此邮件为自动发送，请勿回复！若你没有注册，请忽略。</i></div>`
    }
    const sql = 'insert into `milecode` (emile,code,log_time) values (?,?,now())'
    
    pool.query(sql,[touser,code],(err,result)=>{
        if(err) return console.log(err.message)
if(result.affectedRows===1)
{
    res.send({code:200});
    transporter.sendMail(options,function(err,msg){
        if(err)console.log(err)
        else{
        }
        transporter.close()
    })
}
else{
res.send({code:404});
}
    })
    
})
//查询邮箱和账号匹配
router.get('/check',(req,res)=>{
    var name=req.query.uname
    var email=req.query.email
    const sql = 'select * from users where username=?'
    pool.query(sql,name,(err,result)=>{
        if(err) throw err;
        if(result.length!=0){
            const sql1='select * from users where email=?'
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
//注册接口
router.post('/register',(req,res)=>{
    let obj=req.body.params
    var mailcode=obj.mailcode
    var email=obj.email
    var uname=obj.uname
    var password=obj.password
    const sql='select * from milecode where emile=? and code=?'
    pool.query(sql,[email,mailcode],(err,result)=>{
        if (err) throw err
        if(result.length!=0){
            const sql1='insert into `users` (email,username,userpassword) values (?,?,?)'
            pool.query(sql1,[email,uname,password],(err,result)=>{
                if(err) throw err
                if(result.affectedRows===1){
                    res.send({code:200})
                }
                else{
                    console.log('错误')
                }
            })
        }
        else{
            res.send({code:404})
        }
    })
})
//验证验证码是否正确
router.get('/forgot',(req,res)=>{
    var mailcode=req.query.mailcode
    var email=req.query.email 
    const sql='select * from milecode where emile=? and code=?'
    pool.query(sql,[email,mailcode],(err,result)=>{
        if(err) throw err
        if(result.length!=0){
            res.send({code:200})
        }
        else{
            res.send({code:404})
        }
    })
})
//上传图片
router.post("/upload",uploads.array("file", 1),
    function (req, res, next) {
      let files = req.files;
      let file = files[0];
      let fileInfo = {};
      let path = "public/image/" + file.originalname;
      fs.renameSync("./public/image/" + file.filename, path);
      //获取文件基本信息
      fileInfo.type = file.mimetype;
      fileInfo.name = file.originalname;
      fileInfo.size = file.size;
      fileInfo.path = path;
      res.json({
        code: 200,
        msg: "OK",
        data: fileInfo,
      });
    }
);
//删除图片
router.post('/deleteimg',(req,res)=>{
    let obj=req.body.params
    var imgname=obj.imgname
    const dirpath=paths.join(__dirname,'..','public/image')
    fs.unlink(paths.join(dirpath,imgname),(err)=>{
        if(err){
            res.send({code:404})
        }
        else{
            res.send({
                code:200
            })
        }
    })
})
//查看老师信息
router.get('/tec',(req,res)=>{
    const sql='select * from teacher'
    pool.query(sql,(err,result)=>{
        if(err)throw err
        res.send(result)
        console.log(result)
    })
})
//删除老师
router.delete('/tecdelete',(req,res)=>{
    var id=req.query.therid
    console.log(id)
    const sql='delete from teacher where techid=?'
    pool.query(sql,id,(err,result)=>{
        if(err) throw err
        if(result.affectedRows!=0){
            res.send({code:200})
          }
            else{
              res.send({code:404})
            }
    })
})
//添加老师信息
router.post('/addtec',(req,res)=>{
    let obj=req.body.params
    console.log(obj.date)
    const sql='insert into `teacher` (number,name,sex,age,job_title,school,specialized,phone,email) values (?,?,?,?,?,?,?,?,?)'
pool.query(sql,[obj.number,obj.name,obj.sex,obj.date,obj.job,obj.school,obj.specialized,obj.phone,obj.email],(err,result)=>{
    if(err) throw err
    if(result.affectedRows!=0){
        res.send({code:200})
    }
    else{
        res.send({code:404})
    }
})

})
//重置密码
router.put('/tecreset',(req,res)=>{
    let obj=req.body.params
    const sql='update `teacher` set  password=? where techid=?'
    console.log(obj.password)
    pool.query(sql,[obj.password,obj.therid],(err,result)=>{
        if(err) throw err
       if(result.affectedRows!=0){
       res.send({code:200})
     }
       else{
         res.send({code:404})
       }
     })
})
//修改老师信息
router.put('/Changtech',(req,res)=>{
    let obj=req.body.params
    const sql="update `teacher` set phone=?,email=?,school=?,job_title=? where number=?"
    pool.query(sql,[obj.phone,obj.email,obj.school,obj.job,obj.number],(err,result)=>{
        if(err) throw err
        if(result.affectedRows!=0){
            res.send({code:200})
        }
        else{
            res.send({code:404})
        }
    })

})
//学生信息
router.get('/user',(req,res)=>{
    const sql='select * from users'
    pool.query(sql,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
//删除学生
router.delete('/userdelete',(req,res)=>{
    var id=req.query.therid
    console.log(id)
    const sql='delete from users where id=?'
    pool.query(sql,id,(err,result)=>{
        if(err) throw err
        if(result.affectedRows!=0){
            res.send({code:200})
          }
            else{
              res.send({code:404})
            }
    })
})
//修改学生
router.put('/userreset',(req,res)=>{
    let obj=req.body.params
    const sql='update `users` set  userpassword=? where id=?'
    console.log(obj.password)
    pool.query(sql,[obj.password,obj.therid],(err,result)=>{
        if(err) throw err
       if(result.affectedRows!=0){
       res.send({code:200})
     }
       else{
         res.send({code:404})
       }
     })
})
router.get('/usercontest',(req,res)=>{
    var username = req.query.username
    const sql='select * from usercontest where username=?'
    pool.query(sql,username,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
//竞赛信息的接口
//添加竞赛信息
router.post('/addContest',(req,res)=>{
    var obj =req.body.params
    var img = 'image/'+obj.file
    const sql='insert into `contestinfo` (name,Organizer,undertaker,Startdate,Enddate,category,level,detail,contestImg) values (?,?,?,?,?,?,?,?,?)'
pool.query(sql,[obj.form.name,obj.form.Organizer,obj.form.undertaker,obj.form.date[0],obj.form.date[1],obj.form.category,obj.form.level,obj.text,img],(err,result)=>{
    if(err) throw err
    if(result.affectedRows!=0){
        res.send({
            code:200
        })
    }
    else{
        res.send({
            code:404
        })
    }
})
})
//查看所有竞赛信息
router.get('/contest',(req,res)=>{
    const sql='select * from contestinfo'
    pool.query(sql,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
//查看竞赛详情
router.get('/contestinfo',(req,res)=>{
    var contestId=req.query.contestId
    const sql='select * from contestinfo where contestId=?'
    pool.query(sql,contestId,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
//修改竞赛
router.put('/resetcontest',(req,res)=>{
    let obj = req.body.params
    var imgname='image/'+obj.imgname
    let form=obj.form
    const sql='update `contestinfo` set name=?,Organizer=?,category=?,level=?,undertaker=?,Startdate=?,Enddate=?,contestImg=?,detail=? where contestId=?'
    pool.query(sql,[form.name,form.Organizer,form.category,form.level,form.undertaker,form.date[0],form.date[1],imgname,obj.text,obj.contestId],(err,result)=>{
        if(err) throw err
        if(result.affectedRows!=0){
            res.send({code:200})
        }
        else{
            res.send({code:404})
        }
    })
})
//删除竞赛信息
router.delete('/contestdelete',(req,res)=>{
    var contestId=req.query.contestId
    const sql='delete from contestinfo where contestId=?'
    pool.query(sql,contestId,(err,result)=>{
        if(err) throw err
        res.send({code:200})
    })
})
router.get('/adminPersonal',(req,res)=>{
   var number = req.query.number
   const sql = 'select * from teacher where number=?'
   pool.query(sql,number,(err,result)=>{
    if (err) throw err
    res.send(result)
    console.log(result)
   })
})
router.get('/userPersonal',(req,res)=>{
   var username = req.query.username
   const sql='select * from users where username=?'
   pool.query(sql,username,(err,result)=>{
    if (err) throw err
    res.send(result)
    console.log(result)
   })
})
router.delete('/delusercontest',(req,res)=>{
    var contestId=req.query.contestId
    const sql ='delete from usercontest where contestId=?'
    pool.query(sql,contestId,(err,result)=>{
        if (err) throw err
        res.send({code:200})
    })
})
router.put('/changestudent',(req,res)=>{
    var obj=req.body.params
    console.log(obj.qu)
    var address
    if(obj.qu==''){
        address=''
    }
    else{
        address=obj.sheng+','+obj.shi+','+obj.qu
    }
    const sql='update `users` set name=?,sex=?,school=?,department=?,professional=?,grade=?,address=? where username=?'
    pool.query(sql,[obj.form.name,obj.form.sex,obj.form.school,obj.form.department,obj.form.professional,obj.form.grade,address,obj.form.username],(err,result)=>{
        if(err) throw err
        if(result.affectedRows!=0){
            res.send({code:200})
        }
        else{
            res.send({code:404})
        }
    })
})
router.get('/count',(req,res)=>{
    var contestId=req.query.contestId
    const sql="SELECT (CASE WHEN score >=0 AND score < 70 THEN '0-70' WHEN score >= 70 AND score < 90 THEN '70-90' WHEN score >= 90 AND score < 110 THEN '90-110' WHEN score>=110 AND score<130 THEN '110-130' ELSE '130-150' END) AS score,count( NAME ) AS num FROM usercontest where contestId=? GROUP BY(CASE WHEN score >=0 AND score < 70 THEN '0-70' WHEN score >= 70 AND score < 90 THEN '70-90' WHEN score >= 90 AND score < 110 THEN '90-110' WHEN score>=110 AND score<130 THEN '110-130' ELSE '130-150' END)"
    pool.query(sql,contestId,(err,result)=>{
        if(err) throw err
        res.send(result)
        console.log(result)
    })
})
router.put('/changeadminpass',(req,res)=>{
    var obj=req.body.params
    const sql='update `teacher` set password=? where number=? '
    pool.query(sql,[obj.password,obj.number],(err,result)=>{
        if(err) throw err
        if(result.affectedRows!=0){
            res.send({code:200})
        }
        else{res.send({code:404})}
    })
})
router.put('/changeuserpass',(req,res)=>{
    var obj=req.body.params
    const sql='update `users` set userpassword=? where username=? '
    pool.query(sql,[obj.userpassword,obj.username],(err,result)=>{
        if(err) throw err
        if(result.affectedRows!=0){
            res.send({code:200})
        }
        else{res.send({code:404})}
    })
})
router.get('/contestlistname',(req,res)=>{
    const sql="select contestName as 'name', count(DISTINCT username) 'value' from usercontest group by contestName"
    pool.query(sql,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
router.get('/contestlistlevel',(req,res)=>{
    const sql="select Contestlevel as 'name', count(DISTINCT username) 'value' from usercontest group by Contestlevel"
    pool.query(sql,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
router.get('/contestlistcategory',(req,res)=>{
    const sql="select contestcategory as 'name', count(DISTINCT username) 'value' from usercontest group by contestcategory"
    pool.query(sql,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
router.get('/zhu',(req,res)=>{
    const sql="select contestName as 'name',avg(score) as 'avg',MAX(score+0) AS 'max',min(score+0) AS 'min' from usercontest group by contestName"
    pool.query(sql,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
router.get('/qian',(req,res)=>{
    var contestId=req.query.contestId
    const sql="select score,if(@prerk = score,@rk,@rk:=@rk+1) as rank ,@prerk:=score AS haha,`name`from usercontest,(select @rk:=0,@prerk:=NULL) a WHERE contestId=? order by score+0 desc LIMIT 3"
    pool.query(sql,contestId,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
router.get('/hou',(req,res)=>{
    var contestId=req.query.contestId
    const sql="select score,if(@prerk = score,@rk,@rk:=@rk+1) as rank ,@prerk:=score AS haha,`name`from usercontest,(select @rk:=0,@prerk:=NULL) a WHERE contestId=? order by score+0 asc LIMIT 3"
    pool.query(sql,contestId,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
router.get('/ping',(req,res)=>{
    var contestId=req.query.contestId
    const sql="select avg(score) as 'avg' from usercontest where contestId=?"
    pool.query(sql,contestId,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
router.get('/daojishi',(req,res)=>{
    const sql="SELECT * FROM `usercontest` where username=? AND contestid=?"
    var username=req.query.username
    var contestid=req.query.contestId
    pool.query(sql,[username,contestid],(err,result)=>{
        if (err) throw err
        res.send(result)
    })
})
router.put('/begindaojishi',(req,res)=>{
    var obj=req.body.params
    const sql='update `usercontest` set Answertime=now() where username=?'
    pool.query(sql,obj.id,(err,result)=>{
        if(err) throw err
        res.send({code:200})
    })
})
router.get('/wenti',(req,res)=>{
    const sql='SELECT contestid,level,question,answerA,answerB,answerC,answerD,answerE,rightAnswer,score from allquestion,contestquestion where allquestion.questionId=contestquestion.questionId AND contestid=?'
    var contestid=req.query.contestId
    pool.query(sql,contestid,(err,result)=>{
        if(err) throw err
        res.send(result)
    })
})
//用户获得的分数
router.put('/scroe',(req,res)=>{
    var obj=req.body.params
    const sql='update `usercontest` set score=? where contestid=? and username=?'
    pool.query(sql,[obj.score,obj.contestId,obj.username],(err,result)=>{
        if(err) throw err
        if(result.affectedRows!=0){
            res.send({code:200})
        }
        else{
            res.send({code:404})
        }
    })
})
router.get('/level',(req,res)=>{
    const sql='select level AS `index` from `level`'
    pool.query(sql,(err,result)=>{
        if(err) throw err
        res.send(result)
        console.log(result)
    })
})
router.get('/category',(req,res)=>{
    const sql='select category as `index` from category'
    pool.query(sql,(err,result)=>{
        if(err) throw err
        res.send(result)
        console.log(result)
    })
})
router.post('/bank',(req,res)=>{
    var obj=req.body.params
    const sql='insert into `allquestion` (category,level,question,answerA,answerB,answerC,answerD,answerE,rightAnswer) values (?,?,?,?,?,?,?,?,?)'
    pool.query(sql,[obj.form.category,obj.form.level,obj.form.textarea1,obj.form.textarea2,obj.form.textarea3,obj.form.textarea4,obj.form.textarea5,obj.form.textarea6,obj.form.xuanxiang.toString().replace(/,/gi,'')],(err,result)=>{
        if (err) throw err
        if(result.affectedRows!=0){
            res.send({code:200})
        }
        else{
            res.send({code:404})
        }
    })
    console.log(obj.form.xuanxiang.toString().replace(/,/gi,''))
})
router.get('/lookbank',(req,res)=>{
    const sql='select * from allquestion'
    pool.query(sql,(err,result)=>{
        if(err) throw err
        res.send(result)
        console.log(result)
    })
})
router.post('/addexam',(req,res)=>{
    var obj=req.body.params
    var arr=[]
    for(var i=0;i<obj.examid.length;i++){
    arr.push('('+obj.examid[i]+','+obj.subject+','+obj.score+')') 
    }
    
    const sql=`insert into contestquestion (questionId,contestid,score) values ${arr.toString()}`
    pool.query(sql,(err,result)=>{
        console.log(sql)
        if(err) throw err
        console.log(result)
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