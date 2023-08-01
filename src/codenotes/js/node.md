---
title: Node
icon: gears
order: 3
category:
  - Node
tag:
  - Node

navbar: false
sidebar: false

breadcrumb: false
pageInfo: false
contributors: false
editLink: false
lastUpdated: false
prev: false
next: false
comment: false
footer: false

backtotop: false
---

# Node学习

## node基础

### 1.读取文件

```js
const fs = require('fs');
fs.readFile('./2.txt',function(err, data){
    //console.log(data);   //文件存储都为二进制 
    //这里是16进制<Buffer 68 65 6c 6c 6f 20 32 2e 6a 73>
    console.log(data.toString());
})
```

#### toString()

可以通过toString()把进制数据转换成我们认识的字符



### 2.写入文件

```js
const fs = require('fs');
//第一个参数：文件路径
//第二个参数：文件内容
//第三个参数：回调函数
fs.writeFile('./3.txt','这里是测试node内容2',function(err, data){
    console.log('写入成功');
});


```

#### 追加写入

```js
//追加写入
fs.appendFile('./1.txt','123',err=>{
    if(err){
        console.log(err);
        return
    }
})
fs.appendFileSync('./1.txt','12333333',err=>{
    if(err){
        console.log(err);
        return
    }
})
fs.writeFile('./3.txt','这里是测试node内容2'{flag:'a'},function(err, data){
    console.log('写入成功');
});
```

#### 流式写入

```
const fs =require('fs');

const ws =fs.createWriteStream('./2.txt')
ws.write('123')
ws.write('456')
ws.write('789')

ws.end()
```



### 3.http服务简单启动

```js
//node 提供一个专门的核心模块：http
//http这个模块是专门来帮你创建服务器的

//1. 加载http核心模块
var http = require("http");

//2. 使用http.createServer()方法创建一个web服务器
// 返回一个server 实例
var server = http.createServer();

//3. 服务器
//当客户端请求过来，就会自动触发服务器的request请求事件，然后执行第二个参数:回调处理函数
server.on("request", function () {
    console.log('收到请求了')
});

//4. 绑定端口号，启动服务器

server.listen(3000, function () {
    console.log('Starting,可以通过 http://localhost:3000/ 或者http://192.168.1.66:3000/ 访问')
})

```

![image-20220830110822454](C:\Users\admin\AppData\Roaming\Typora\typora-user-images\image-20220830110822454.png)



### 4.http数据响应

```js
var http = require("http");

var server = http.createServer();

//request 请求事件处理函数，需要接收两个参数:
//  Request 请求对象
//    请求对象可以用来获取客户端的一些请求信息，例如请求路径
//  Response 响应对象
//    响应对象可以用来给客户端发送响应消息
server.on("request", function (request, response) {
    console.log('收到请求了，请求路径是：'+request.url)
    //response 对象有一个方法：write 可以用来给客户端发送响应数据
    //write 可以使用多次，但是最后一定使用end 来结束响应，否则客户端会一直等待
    response.write('hello world')

    //数据结束
    response.end()
});

server.listen(3000, function () {
    console.log('Starting,可以通过 http://localhost:3000/ 或者http://192.168.1.66:3000/ 访问')
})
```

![image-20220830113537395](C:\Users\admin\AppData\Roaming\Typora\typora-user-images\image-20220830113537395.png)

![image-20220830113441690](C:\Users\admin\AppData\Roaming\Typora\typora-user-images\image-20220830113441690.png)



### 5.http数据响应深入

```js
var http = require("http");

var server = http.createServer();

server.on("request", function (req, res) {
  console.log("收到请求了，请求路径是：" + req.url);

  //方式比较麻烦
  // res.write('hello world')
  // //数据结束
  // res.end()

  //推荐使用 end同时直接返回结果
  let url = req.url;
  if (url === "/") {
    res.end("index page");
  } else if (url === "/login") {
    res.end("login page");
  }else if(url ==='/products'){
    let product=[
        {
            name:'苹果14',
            price:8888
        },
        {
            name:'菠萝',
            price:5888
        },
    ]
    res.end(JSON.stringify(product));
  } else {
    res.end("404 Not Found");
  }
});

server.listen(3000, function () {
  console.log(
    "Starting,可以通过 http://localhost:3000/ 或者http://192.168.1.66:3000/ 访问"
  );
});
```

![image-20220830141732935](C:\Users\admin\AppData\Roaming\Typora\typora-user-images\image-20220830141732935.png)

### 6.node api链接

https://nodejs.org/dist/latest-v18.x/docs/api/http.html

最新的可以去官网查找



### 7.http响应数据转译Content-Type

```js
var http = require('http');

var server = http.createServer();

server.on('request', function (req, res) {
    // res.setHeader('Content-Type', 'application/json');
    //转译成普通文本
    if(req.url==='/nihao'){
        res.setHeader('Content-Type', 'text/plain;charset=utf8');
    res.end('hello world! 你好世界');
    }else if(req.url==='/html'){
        //转译成html文本
        res.setHeader('Content-Type', 'text/html;charset=utf8');
        res.end('<p>你好<a href="">点击</a></p>'); 
    }
})

server.listen(3000, function (){
    console.log('server is running on port 3000....')
})
```

#### 端口占用

```
HTTP 协议默认占用80   HTTPS 默认占用443
```



### 8.content-type对照表

https://tool.oschina.net/commons

### 9.http请求不同类型文件案例

```js
var http = require("http");
var fs = require("fs");

var server = http.createServer();

server.on("request", function (req, res) {
  if (req.url === "/") {
    fs.readFile("./resource/index.html", function (err, data) {
        if(err){
            res.setHeader("Content-Type", "TEXT/plain;CHARSET=utf8");
            res.end('文件读取失败，请稍后重试'+err)
        }else{
            res.setHeader("Content-Type", "TEXT/html;CHARSET=utf8");
            res.end(data)
        }
    });
  }else if(req.url==='/a'){
    fs.readFile("./resource/ceshi.jpg", function (err, data) {
      if(err){
          res.setHeader("Content-Type", "TEXT/plain;CHARSET=utf8");
          res.end('文件读取失败，请稍后重试'+err)
      }else{
          res.setHeader("Content-Type", "image/jpeg");
          res.end(data)
      }
  });
  }
});

server.listen(3000, function () {
  console.log("server is running on port 3000....");
});
```



### 10.exports  抛出

```js
//A页面
var exp = require('./B');

console.log(exp.add(10,20))

//B页面

console.log('hello 8')

//exports抛出别的页面使用
exports.add= function(x,y){
return x+y
}
```



### 11.读取文件夹fs.readdir

```js
var fs = require('fs');

fs.readdir('./stay', function(err, data){
    if(err){
        return console.log('目录不存在')
    }
    console.log(data)
})
```



### 12.模板引擎

```js
//引入 npm install art-template


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=s, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script src="./day2/node_modules/art-template/lib/template-web.js"></script>
    <script type="text/template" id="tel">
        你好呀 {{name}}
        {{each hobbies}}{{$value}}{{/each}}
    </script>
    <script>
        var ret = template('tel',{
            name:'jack',
            hobbies:[
                '写代码',
                '打游戏',
                '唱歌'
            ]
        })

        console.log(ret);
    </script>
</body>
</html>
```

![image-20220831154513358](C:\Users\admin\AppData\Roaming\Typora\typora-user-images\image-20220831154513358.png)



### 13服务端渲染和客户端渲染区别

- 客户端渲染不利于SEO搜索引擎优化
- 服务点渲染是可以被爬虫抓取到的，客户端异步渲染是很难被爬虫抓取到的
- 所以真正好的网站既不是纯异步也不是纯服务端渲染出来的
- 是二者结合的



### 14node代码测试

`cmd 输入node`

![image-20220902114943108](C:\Users\admin\AppData\Roaming\Typora\typora-user-images\image-20220902114943108.png)

## node模块系统

### 模块简介

使用Node编写应用程序主要就是在使用

- EcmaScript语言
  - 和浏览器不一样，node没有BOM,DOM
- 核心模块
  - 文件操作的fs
  - http服务的http
  - url路径操作模块
  - path路径处理模块
  - os操作系统信息
- 第三方模块
  - art-template模块
- 自己编写的模块



### 模块系统

在Node中的	JavaSript还有一个很重要的概念，模块系统。

- 模块作用域
- 使用require方法用来加载模块
- 使用exports接口对象用来导出模块中的成员

```js
//A.js
var foo= require('./B');

console.log(foo);

//B.js

var foo = 'bar';

function add(x,y){
   return x+y;
}

module.exports = {
    foo,
    add
}

//node 输出   { foo: 'bar', add: [Function: add] }
```



## node框架Express

### 安装

```js
npm init-y

npm install --save express
```

### hello world

```js
const express = require("express");

const app = express();

//只要这么使用，就可以直接通过/public/xx的方式访问public目录的所以资源了
app.use('/public', express.static('./public'))

const port = 3000;

app.get("/", (req, res) => {
  res.send("hello world");
});

app.listen(port, () => {
  console.log("listening on port " + port);
});
```

基础路由

get：

```js
app.get("/", (req, res) => {
  res.send("hello world");
});
```



post：

```js
app.post("/", (req, res) => {
  res.send("hello world post");
});
```



### 静态服务

```js
//两种获取方法

app.use(express.static('./public'))

app.use('/publick',express.static('./public'))
```

### 在Express中配置使用`art-template`模板引擎

- [art-template-github仓库](https://github.com/aui/art-template)
- [art-template官网](https://aui.github.io/art-template/zh-cn/index.html)

安装

```shell
npm install --save art-template
npm install --save express-art-template
```

配置

```shell
app.engine('html', require('express-art-template'));
```

使用

```shell
//访问路径默认是views  如想修改则可以
//app.set('views',render函数的默认路径);

app.get("/", (req, res) => {
  // res.send("hello world");
  res.render('404.html')
});
```

### 在Express获取表单GET请求数据

express内置了一个api，可以通过`req.query`来获取

```
req.query
```



### 在Express获取表单POST请求数据

在express中没有内置获取表单post请求体的api，这里我们需要使用第三方的包：`body-parser`

安装：

```shell
npm install --save body-parser
```

配置：

```js
var express = require('express')
//1.引包 
var bodyParser = require('body-parser')

var app = express()

//配置 body-parser
//只要加入这个配置则在req请求对象上会多出来一个属性：body
//则可以通过req.body获取参数
// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))

// parse application/json
app.use(bodyParser.json())

app.use(function (req, res) {
  res.setHeader('Content-Type', 'text/plain')
  res.write('you posted:\n')
  //可以通过req.body来获取表单post请求数据
  res.end(JSON.stringify(req.body, null, 2))
})
```

​	
