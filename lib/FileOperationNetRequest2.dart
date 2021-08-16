import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

//⽹络操作 
/*Dio http库*/ 
//通过上⼀节介绍，我们可以发现直接使⽤HttpClient发起⽹络请求是⽐较麻烦的，很多事情得我们⼿动处理，
//如果再涉 及到⽂件上传/下载、Cookie管理等就会⾮常繁琐。
//幸运的是，Dart社区有⼀些第三⽅http请求库，⽤它们来发起http请 求将会简单的多，本节我们介绍⼀下⽬前⼈⽓较⾼的dio库。
//dio是⼀个强⼤的Dart Http请求库，⽀持Restful API、FormData、拦截器、请求取消、Cookie管理、⽂件上传/下 载、超时等。

//引⼊
//1、引⼊dio:
//dependencies: dio: ^x.x.x #请使⽤pub上的最新版本
//2、导⼊并创建dio实例：
//import 'package:dio/dio.dart';
// Dio dio = new Dio();
//接下来就可以通过 dio实例来发起⽹络请求了，
//注意，⼀个dio实例可以发起多个http请求，⼀般来说，APP只有⼀个 http数据源时，dio应该使⽤单例模式。