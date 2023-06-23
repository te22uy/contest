import { createRouter, createWebHashHistory } from 'vue-router'
import login from '@/components/server/login'
import register from '@/components/client/register'
import main from '@/components/server/main'
import addNews from '@/components/server/addNews'
import Homepage from '@/components/client/Homepage'
import race from '@/components/client/race'
import informationList from '@/components/client/informationList'
import applyNews from '@/components/client/applyNews'
import forgotPassword from '@/components/client/forgotPassword'
import information from '@/components/client/information'
import addContest from '@/components/server/addContest'
import Changepass from '@/components/server/Changepass'
import Personalinfo from '@/components/server/Personalinfo'
import addtech from '@/components/server/addtech'
import Changetech from '@/components/server/Changetech'
import enroll from '@/components/server/enroll'
import ResetPass from '@/components/server/ResetPass'
import ChangContest from '@/components/server/ChangContest'
import ChangeNews from '@/components/server/ChangeNews'
import LookContest from '@/components/server/LookContest'
import LookNews from '@/components/server/LookNews'
import pageTop from '@/components/client/pageTop'
import raceDetail from '@/components/client/raceDetail'
import selfinfo from '@/components/server/selfinfo'
import count from '@/components/server/count'
import bank from '@/components/server/bank'
import usercontest from '@/components/server/usercontest'
import exam from '@/components/server/exam'
import lookbank from '@/components/server/lookbank'
import addexam from '@/components/server/addexam'
import lookexam from '@/components/server/lookexam'
const routes = [
  {
    path: '/login',
    name: 'login',
    component: login
  },
  {
    path:'/forgotPassword',
    name:'forgotPassword',
    component:forgotPassword
  }
  ,
  {
    path:'/pageTop',
    name:'pageTop',
    component:pageTop,
    children:[
  {
    path: '/Homepage',
    name: 'Homepage',
    component: Homepage,
  },
      {
        path:'/race',
        name:'race',
        component:race
      }
      ,
      {
        path:'/raceDetail',
        name:'raceDetail',
        component:raceDetail
      },
      {
        path:'/informationList',
        name:'informationList',
        component:informationList,
        
      
      },  {
            path:'/information',
            name:'/information',
            component:information

        },
      {
        path:'/applyNews',
        name:'applyNews',
        component:applyNews
      }
    ]
  }
  ,
  {
    path:'/register',
    name:'register',
    component:register
  },
  {
    path:'/main',
    name:'main',
    component:main,
    children:[
      
      {
        path:'/usercontest',
        name:'usercontest',
        component:usercontest
      },
      {
        path:'/exam',
        name:'exam',
        component:exam
      },
      {
        path:'/bank',
        name:'bank',
        component:bank
      },
      {
        path:'/lookexam',
        name:'lookexam',
        component:lookexam
      },
      {
        path:'/lookbank',
        name:'lookbank',
        component:lookbank
      }, {
        path:'/addexam',
        name:'addexam',
        component:addexam
      },
      {
        path:'/addNews',
        name:'addNews',
        component:addNews
      },
      {
        path:'/addContest',
        name:'addContest',
        component:addContest
      },
      {
        path:'/Changepass',
        name:'Changepass',
        component:Changepass
      },
      {
        path:'/Personalinfo',
        name:'Personalinfo',
        component:Personalinfo
      },
      {
        path:'/addtech',
        name:'addtech',
        component:addtech
      },
      {
        path:'/Changetech',
        name:'Changetech',
        component:Changetech
      },
      {
        path:'/enroll',
        name:'enroll',
        component:enroll
      },
      {
        path:'/ResetPass',
        name:'ResetPass',
        component:ResetPass
      },
      {
        path:'/LookContest',
        name:'LookContest',
        component:LookContest,
          
        
      },
      {
            path:'/ChangContest',
            name:'ChangContest',
            component:ChangContest
          }
          ,
      {
        path:'/ChangeNews',
        name:'ChangeNews',
        component:ChangeNews
      },
      {
        path:'/LookNews',
        name:'LookNews',
        component:LookNews
      },
      {
        path:'/selfinfo',
        name:'selfinfo',
        component:selfinfo
      },
      {
        path:'/count',
        name:'count',
        component:count
      }
    ]
  }
]

const router = createRouter({
  history: createWebHashHistory(process.env.BASE_URL),
  routes
})

export default router
