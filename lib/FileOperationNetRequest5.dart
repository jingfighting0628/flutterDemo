import 'package:flutter/material.dart';
//Json Model 
//在实战中，后台接⼝往往会返回⼀些结构化数据，如JSON、XML等，如之前我们请求Github API的示例，它返回的数 据就是JSON格式的字符串，
//为了⽅便我们在代码中操作JSON，我们先将JSON格式的字符串转为Dart对象，这个可以 通过 dart:convert 中内置的JSON解码器json.decode() 来实现，
//该⽅法可以根据JSON字符串具体内容将其转为List或 Map，这样我们就可以通过他们来查找所需的值，如：
/*
  //⼀个JSON格式的⽤户列表字符串 
  String jsonStr='[{"name":"Jack"},{"name":"Rose"}]'; 
  //将JSON字符串转为Dart对象(此处是List) 
  List items=json.decode(jsonStr); 
  //输出第⼀个⽤户的姓名 
  print(items[0]["name"]);
*/
//以json_serializable的⽅式创建model类