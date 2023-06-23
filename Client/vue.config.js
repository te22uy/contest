module.exports = {
  publicPath: './',
  devServer: {
    proxy:{
      '/api':{
        target:'http://localhost:5858/',
        changeOrigin:true,
        ws:true,
        secure:true,
        pathRewrite:{
          '^/api':''
        }
      }
    }
  }
};
