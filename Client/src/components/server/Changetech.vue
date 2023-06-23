<template>
  <div style="text-align: center;">
    <el-input
      v-model="input"
      placeholder="搜索"
      class="input-with-select"
      style="width: 300px;"
      clearable
    >
      <template #append>
        <el-button :icon="Search" @click="search()" />
      </template>
    </el-input>
  </div>
    <el-table
      ref="filterTable"
      :data="tables.slice((currentPage-1)*pageSize,currentPage*pageSize)"
      border
      @filter-change="filterTagTable"
      style="width: 100%"
      v-loading.fullscreen.lock="loading"
        element-loading-text="加载中"
        element-loading-spinner="el-icon-loading"
        element-loading-background="rgba(0, 0, 0, 0.8)"
    height="500">
    <el-table-column prop="number" label="账号" width="120" />
    <el-table-column prop="name" label="姓名" width="70" />
    <el-table-column prop="sex" label="性别" width="60" />
    <el-table-column prop="age" label="年龄" width="130" />
    <el-table-column prop="job_title" label="职称" width="80" />
    <el-table-column prop="phone" label="电话" width="180" />
    <el-table-column prop="school" label="就职学校" width="150" />
    <el-table-column prop="email" label="e-mail" width="200" />
    <el-table-column label="操作">
      <template #empty>
      <el-empty description="暂无数据" />
    </template>
      <template v-slot="scope">
        <el-tooltip
        class="box-item"
        effect="dark"
        content="修改信息"
        placement="top"
      >
      <el-button type="primary" :icon="Edit" circle @click="dialogFormVisible =true,handleEdit(scope.$index, scope.row)"/>
      </el-tooltip>
      <el-tooltip
        class="box-item"
        effect="dark"
        content="删除教师"
        placement="top"
      >
      <el-button type="danger" :icon="Delete" circle  @click="DeleteId(scope.row.techid)"/>
      </el-tooltip>
      <el-tooltip
        class="box-item"
        effect="dark"
        content="重置密码"
        placement="top"
      >
      <el-button type="warning" :icon="Refresh" circle @click="RefreshId(scope.row.techid)" />
      </el-tooltip>
</template>
    </el-table-column>
      </el-table>
      <div class="block">
        <el-pagination align='center'
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="currentPage"
        :page-sizes="[5,10,20]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="tables.length">
        </el-pagination>
      </div>
  <el-dialog v-model="dialogFormVisible" title="个人详情">
      <el-form :model="form" ref="form" :rules="formrule">
        <el-form-item :label-width="formLabelWidth" label="老师编号">
          <el-input v-model="form.number" disabled auto-complete="off"/>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth" label="姓名">
          <el-input v-model="form.name" disabled auto-complete="off"/>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth" label="就职院校" prop="school">
          <el-input v-model="form.school" auto-complete="off"/>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth" label="职称" prop="job">
          <el-select v-model="form.job" style="width:290px">
        <el-option label="助教" value="助教" />
        <el-option label="讲师" value="讲师" />
        <el-option label="副教授" value="副教授" />
        <el-option label="教授" value="教授" />
      </el-select>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth" label="电子邮箱" prop="email">
          <el-input v-model="form.email" auto-complete="off"/>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth" label="电话号码" prop="phone">
          <el-input v-model="form.phone" auto-complete="off"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="updateBattery('form')">确 定</el-button>
      </div>
    </el-dialog>
</template>
<script>
import {Search,Edit,Delete,CircleClose,Refresh} from '@element-plus/icons-vue';
import { ref,reactive,  } from 'vue';
import axios from 'axios';
import { ElMessage } from 'element-plus'
export default{
    data(){
        return{
          currentPage: 1,
      pageSize: 10,
          scope:ref(''),
          input:ref(''),
            Search,Edit,Delete,CircleClose,Refresh,
            listter : reactive({
        arr:[]
    }),
    dialogFormVisible: false,
      formLabelWidth: '120px',
      form: reactive({
        number:'',
        name:'',
        school:'',
        job:'',
        email:'',
        phone:''
      }),
      formrule:{
        school:[{required: true,message:'不能为空'}],
        job:[{required: true,message:'不能为空'}],
        phone:[{required: true,message:'请输入手机号'},{type:"number",message:'手机号格式不对',transform: (value) => Number(value)},{pattern:/^1[3456789]\d{9}$/, message: "手机号格式不对",}],
        email:[{required: true,message:'不能为空'},{type:"email",message:'电子邮箱格式不对'}]
      }
        }
    },
    methods:{
      handleSizeChange (val) {
      this.pageSize = val
    },
    handleCurrentChange (val) {
      this.currentPage = val
    },
    filterTag (value, row) {
      return row.category === value
    },
    filterHandler (value, row, column) {
      const property = column['property']
      return row[property] === value
    },
      getUserList(){
         axios.get('api/admin/tec',).then(res=>{
            this.listter.arr= res.data
            this.loading = false
        })
         
      },
      async DeleteId (therid) {
      // 弹框询问用户是否删除数据
      const confirmResult = await this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'error'
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        })
      })

      if (confirmResult !== 'confirm') {
        return this.$message.info('已取消删除')
      } 
      this.loading=true
      axios.delete('api/admin/tecdelete',{
        params:{
          therid:therid
        }
      }).then(res=>{
        if(res.data.code === 200)
      {
        this.$message.success('删除用户成功！')
      this.getUserList()
      }
      else{
        this.$message.success('删除用户失败！')
      this.getUserList()
      }
      this.loading=false
      })
      
    },
    async RefreshId(therid){
      const confirmResult = await this.$confirm('此操作将重置用户密码, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消重置'
        })
      })

      if (confirmResult !== 'confirm') {
        return this.$message.info('已取消重置')
      } 
      this.loading=true
      axios.put('api/admin/tecreset',{
        params:{
          therid:therid,
          password:'111111'
        }
      }).then(res=>{
        if(res.data.code === 200)
      {
        this.$message.success('重置密码成功！')
      this.getUserList()
      }
      else{
        this.$message.success('重置密码成功！')
      this.getUserList()
      }
      this.loading=false
      })
    },
    handleEdit(index, row) {
      console.log(index, row)
      //row是该行tableData对应的一行
      this.form = row
    },
    updateBattery(form){
      this.loading=true
      this.$refs[form].validate(validate=>{
        if(validate){
          axios.put('/api/admin/Changtech',{
            params:{
              number:this.form.number,
              phone:this.form.phone,
              email:this.form.email,
              school:this.form.school,
              job:this.form.job,
            }
          }).then(res=>{
            if(res.data.code===200){
              this.dialogFormVisible = false;
              this.getUserList();
              ElMessage({
              showClose: true,
              message: '修改成功',
              type: 'success',
            })
            }
            else{
              this.dialogFormVisible = false;
              ElMessage({
              showClose: true,
              message: '修改失败',
              type: 'error',
            })
            }
            this.loading=false
          })
          
        }
      })
    },
    search(){
      
    }
    },
    created(){
      this.getUserList();
      this.loading=true
    },
    mounted(){
    },
    computed: {
			tables() {
				const input = this.input
				if (input) {
					console.log("input输入的搜索内容：" + this.input)
					return this.listter.arr.filter(data => {
						console.log("object:" + Object.keys(data))
						return Object.keys(data).some(key => {
							return String(data[key]).toLowerCase().indexOf(input) > -1
						})  
					})
          
				}
				return  this.listter.arr
			}

		}
}
</script>
