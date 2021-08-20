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
/*
  示例
  发起 GET 请求 : Response response; response=await dio.get("/test?id=12&name=wendu") print(response.data.toString()); 对于 GET 请求我们可以将query参数通过对象来传递，上⾯的代码等同于： response=await dio.get("/test",data:{"id":12,"name":"wendu"}) print(response.data.toString()); 
  发起⼀个 POST 请求: response=await dio.post("/test",data:{"id":12,"name":"wendu"}) 
  发起多个并发请求: response= await Future.wait([dio.post("/info"),dio.get("/token")]); 
  下载⽂件: response=await dio.download("https://www.google.com/",_savePath); H
  ttp请求-Dio package
Http请求-Dio package 发送 FormData: FormData formData = new FormData.from({ "name": "wendux", "age": 25, }); response = await dio.post("/info", data: formData) 如果发送的数据是FormData，则dio会将请求header的 contentType 设为“multipart/form-data”。
 通过FormData上传多个⽂件: FormData formData = new FormData.from({ "name": "wendux", "age": 25, "file1": new UploadFileInfo(new File("./upload.txt"), "upload1.txt"), "file2": new UploadFileInfo(new File("./upload.txt"), "upload2.txt"), // ⽀持⽂件数组上传 "files": [ new UploadFileInfo(new File("./example/upload.txt"), "upload.txt"), 
 new UploadFileInfo(new File("./example/upload.txt"), "upload.txt") ] }); response = await dio.post("/info", data: formData) 值得⼀提的是，dio内部仍然使⽤HttpClient发起的请求，所以代理、请求认证、证书校验等和HttpClient是相同的，我们 可以在 onHttpClientCreate 回调中设置，
 例如： dio.onHttpClientCreate = (HttpClient client) { //设置代理 client.findProxy = (uri) { return "PROXY 192.168.1.2:8888"; };//校验证书 httpClient.badCertificateCallback=(X509Certificate cert, String host, int port){ if(cert.pem==PEM){ return true; //证书⼀致，则允许发送数据 }return false; }; }; 
 注意， onHttpClientCreate 会在当前dio实例内部需要创建HttpClient时调⽤，所以通过此回调配置HttpClient会对整个 dio实例⽣效，如果你想针对某个应⽤请求单独的代理或证书校验策略，可以创建⼀个新的dio实例即可。 怎么样，是不是很简单，
 除了这些基本的⽤法，dio还⽀持请求配置、拦截器等，官⽅资料⽐较详细，故本书不再赘 述，详情可以参考dio主⻚：https://github.com/flutterchina/dio 。

*/
