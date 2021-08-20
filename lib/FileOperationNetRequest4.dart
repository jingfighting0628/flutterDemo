import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
//**
//Socket 我们之前介绍的Http协议和WebSocket协议都属于应⽤层协议，除了它们，应⽤层协议还有很多如：SMTP、FTP等， 它们都是通过Socket实现的。
//其实，操作系统中提供的原⽣⽹络请求API是标准的，在C语⾔的Socket库中，它主要提 供了端到端建⽴链接和发送数据的基础API，
//⽽⾼级编程语⾔中的Socket库其实都是对操作系统的socket API的⼀个封 装。所以，如果我们需要⾃定义协议或者想直接来控制管理⽹络链接、
//⼜或者我们觉得⾃带的HttpClient不好⽤想重新 实现⼀个，这时我们就需要使⽤Socket。
//Flutter的Socket API在dart io包中，下⾯我们看⼀个使⽤Socket实现简单http 请求的示例，以请求百度⾸⻚为例：
//
// */
/*
  _request() async{ //建⽴连接 var socket=await Socket.connect("baidu.com", 80); 
  //根据http协议，发送请求头 
  socket.writeln("GET / HTTP/1.1"); 
  socket.writeln("Host:baidu.com"); 
  socket.writeln("Connection:close"); 
  socket.writeln(); await socket.flush(); //发送 
  //读取返回内容 
  _response =await socket.transform(utf8.decoder).join(); await socket.close(); 
  }

*/
//可以看到，使⽤Socket需要我们⾃⼰实现Http协议细节，本例只是⼀个简单示例，没有处理重定向、cookie等。
//本示例 完整代码参考示例demo，运⾏后如下：

class SocketTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Socket发送请求"),
      ),
      body: Container(
        child: FlatButton(
          onPressed: () {

          },
          textColor: Colors.blue,
          child: Text("Socket请求"),
        ),
      ),
    );
  }
  _request() async{
    //建⽴连接 
    var socket=await Socket.connect("baidu.com", 80); 
    ////根据http协议，发送请求头 
    socket.writeln("GET / HTTP/1.1"); socket.writeln("Host:baidu.com"); 
    socket.writeln("Connection:close"); socket.writeln(); await socket.flush(); //发送
     //读取返回内容 
    var decoder = utf8.decoder;
      //await socket.transform(decoder).join();
     await socket.close(); }
}
