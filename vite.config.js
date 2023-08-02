
export default ({
  build: {
    rollupOptions: {
      output: {
        // 设置 HTML 文件的 MIME 类型为 text/html
        html: {
          mime: 'text/html',
        },
      },
    },
  },
});
