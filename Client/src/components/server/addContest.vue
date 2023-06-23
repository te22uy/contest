<template>
  <el-form :model="form" ref="form" label-width="120px" :rules="formrule">
    <el-form-item label="竞赛名称" prop="name">
      <el-input v-model="form.name" clearable />
    </el-form-item>
    <el-form-item label="主办方" prop="Organizer">
      <el-input v-model="form.Organizer" clearable />
    </el-form-item>
    <el-form-item label="承办方" prop="undertaker">
      <el-input v-model="form.undertaker" clearable />
    </el-form-item>
    <el-form-item label="竞赛时间" prop="date">
      <el-col :span="11">
        <el-date-picker value-format="YYYY-MM-DD" v-model="form.date" type="daterange" unlink-panels
          range-separator="To" start-placeholder="开始时间" end-placeholder="结束时间" :shortcuts="shortcuts" :size="size" />
      </el-col>
    </el-form-item>
    <el-form-item label="竞赛类别" prop="category">
      <el-select v-model="form.category" placeholder="请选择你的竞赛类别">
        <el-option v-for="category in option" :key="category.id" :label="category.label" :value="category.index">
        </el-option>

      </el-select>
    </el-form-item>

    <el-form-item label="竞赛级别" prop="level">
      <el-select v-model="form.level" placeholder="请选择你的竞赛级别">
        <el-option v-for="level in options" :key="level.id" :label="level.label" :value="level.index">
        </el-option>
      </el-select>
    </el-form-item>

    <el-form-item label="竞赛封面" prop="fileLis">
      <el-upload :file-list="form.fileLis" class="upload-demo" action="/api/admin/upload" :on-remove="handleRemove"
        :on-change="befor" ref="docUpload" list-type="picture" :auto-upload="false" :limit="1" :on-success="upsuccess">
        <el-button type="primary">点击上传</el-button>
        <template #tip>
          <div class="el-upload__tip">
            图片不能超过500kb
          </div>
        </template>
      </el-upload>
    </el-form-item>

    <el-form-item label="竞赛详情">
      <textarea id="file" style="flex: 0 0 auto;width: 100%;"></textarea>
    </el-form-item>

    <el-form-item>
      <el-button type="primary" @click="onSubmit('form')">确认</el-button>
      <el-button>清空</el-button>
    </el-form-item>

  </el-form>

</template>

<script>
import axios from "axios";
import { reactive, ref } from "vue";
import { ElMessage } from "element-plus";
export default {
  data() {
    return {
      option: [],
      options: [],
      form: reactive({
        name: "",
        fileLis: [],
        category: "",
        undertaker: "",
        level: "",
        Organizer: "",
        date: "",
        delivery: false,
      }),
      formrule: {
        name: [{ required: true, message: "请输入竞赛名称" }],
        fileLis: [{ required: true, message: "请添加竞赛封面" }],
        Organizer: [{ required: true, message: "请输入主办方" }],
        undertaker: [{ required: true, message: "请输入承办方" }],
        date: [{ required: true, message: "请输入竞赛时间" }],
        category: [{ required: true, message: "请选择竞赛类别" }],
        level: [{ required: true, message: "请选择竞赛级别" }],
      },
    };
  },
  methods: {
    onSubmit(form) {
      console.log(this.form.date);
      this.$refs[form].validate((validate) => {
        if (validate) {
          this.$refs.docUpload.submit();
        }
      });
    },
    handleRemove(file) {
      console.log(file);
      this.form.fileLis.pop();
    },
    befor(file) {
      this.form.fileLis.push(file);
    },
    upsuccess(file) {
      console.log(file.data.name);
      console.log(this.form.date[0]);
      axios
        .post("/api/admin/addContest", {
          params: {
            text: tinymce.activeEditor.getContent(),
            form: this.form,
            file: file.data.name,
          },
        })
        .then((res) => {
          if (res.data.code === 200) {
            ElMessage({
              showClose: true,
              message: "添加成功",
              type: "success",
            });
            this.$refs["form"].resetFields();
            tinyMCE.activeEditor.setContent("");
          }
        });
    },
    category() {
      axios.get("/api/admin/category").then((res) => {
        console.log(res.data);
        for (var i = 0; i < res.data.length; i++) {
          var obj = {
            index: res.data[i].index,
            label: res.data[i].index,
          };
          this.option.push(obj);
        }
      });
    },
    level() {
      axios.get("/api/admin/level").then((res) => {
        console.log(res.data);
        for (var i = 0; i < res.data.length; i++) {
          var obj = {
            index: res.data[i].index,
            label: res.data[i].index,
          };
          this.options.push(obj);
        }
      });
    },
  },
  mounted() {
    this.level(), this.category(), tinymce.remove("#file");
    tinymce.init({
      selector: "textarea#file",
      language: "zh-Hans",
      plugins: "image ",
      toolbar:
        "undo redo | link image | alignleft | aligncenter | alignright | bold | italic",
      image_title: true,
      automatic_uploads: true,
      file_picker_types: "image",
      promotion: false,
      branding: false,
      file_picker_callback: (cb, value, meta) => {
        const input = document.createElement("input");
        input.setAttribute("type", "file");
        input.setAttribute("accept", "image/*");

        input.addEventListener("change", (e) => {
          const file = e.target.files[0];

          const reader = new FileReader();
          reader.addEventListener("load", () => {
            const id = "blobid" + new Date().getTime();
            const blobCache = tinymce.activeEditor.editorUpload.blobCache;
            const base64 = reader.result.split(",")[1];
            const blobInfo = blobCache.create(id, file, base64);
            blobCache.add(blobInfo);
            cb(blobInfo.blobUri(), { title: file.name });
          });
          reader.readAsDataURL(file);
        });

        input.click();
      },
      content_style:
        "body { font-family:Helvetica,Arial,sans-serif; font-size:16px }",
    });
  },
};
</script>
<style scoped>

</style>
