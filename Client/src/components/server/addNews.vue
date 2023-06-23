<template>
  <el-form :model="form" label-width="120px">
    <el-form-item label="标题">
      <el-input v-model="Newname" />
    </el-form-item>
    <el-form-item label="内容">
      <textarea id="file-picker" style="flex: 0 0 auto;width: 100%;"></textarea>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="onSubmit">发布</el-button>
      <el-button @click="onCancel">取消</el-button>
    </el-form-item>

  </el-form>
</template>
  
<script>
import { ref } from 'vue'
import Cookies from 'js-cookie'
import { ElMessage } from 'element-plus'
import axios from 'axios';
export default {

  data() {
    return {
      Newname: ref(''),
      user: JSON.parse(localStorage.getItem('usersinfo')),
    }
  },

  methods: {
    onSubmit() {
      axios.post('/api/admin/AddNew', {
        params: {
          text: tinymce.activeEditor.getContent(),
          newname: this.Newname,
          author: this.user.name,
        }
      }).then(res => {
        if (res.data.code === 200) {
          ElMessage({
            showClose: true,
            message: '添加成功',
            type: 'success',
          })
          this.$refs['form'].resetFields()
        }
      })
    }
  },
  mounted() {
    tinymce.remove('#file-picker')
    tinymce.init({
      selector: 'textarea#file-picker',
      language: 'zh-Hans',
      plugins: 'image ',
      toolbar: 'undo redo | link image | alignleft | aligncenter | alignright | bold | italic',
      image_title: true,
      automatic_uploads: true,
      file_picker_types: 'image',
      promotion: false,
      branding: false,
      file_picker_callback: (cb, value, meta) => {
        const input = document.createElement('input');
        input.setAttribute('type', 'file');
        input.setAttribute('accept', 'image/*');

        input.addEventListener('change', (e) => {
          const file = e.target.files[0];

          const reader = new FileReader();
          reader.addEventListener('load', () => {
            const id = 'blobid' + (new Date()).getTime();
            const blobCache = tinymce.activeEditor.editorUpload.blobCache;
            const base64 = reader.result.split(',')[1];
            const blobInfo = blobCache.create(id, file, base64);
            blobCache.add(blobInfo);
            cb(blobInfo.blobUri(), { title: file.name });
          });
          reader.readAsDataURL(file);
        });

        input.click();
      },
      content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:16px }'
    });
  }
}
</script>
<style scoped>
#file-picker {
  width: auto;
  height: 500px;
}

.el-form-item__content {
  width: 100%;
}
</style>
