import 'package:flutter/material.dart';
import 'package:flutter_app01/ScrollableWidget.dart';
import 'package:flutter_app01/ScrollableWidget2.dart';
import 'package:flutter_app01/ScrollableWidget3.dart';
import 'package:flutter_app01/ScrollableWidget4.dart';
import 'package:flutter_app01/ScrollableWidget5.dart';
import 'package:flutter_app01/StackDemo.dart';
import 'package:flutter_app01/basicWidget.dart';
import 'package:flutter_app01/basicWidget1.dart';
import 'package:flutter_app01/containerWidget.dart';
import 'package:flutter_app01/containerWidget1.dart';
import 'package:flutter_app01/funtionWidget.dart';
import 'package:flutter_app01/layoutWidget.dart';
import 'package:flutter_app01/project/loginPage.dart';
import 'package:flutter_app01/widgetState.dart';


class homePage extends StatelessWidget {
  final titles = [
    "状态管理",
    "基础Widget",
    "基础Widget1",
    "布局类Widget",
    "层叠布局示例",
    "容器类Widget",
    "容器类Widget1",
     "项目",
    "可滚动Widget1",
    "可滚动Widget2",
    "可滚动Widget3",
    "可滚动Widget4",
    "可滚动Widget5",
    "功能型Widget",
    "事件处理与通知",
    "动画",
    "自定义Widget",
    "文件操作与网络请求",
    "包与插件",
    "国际化",
    "Flutter核心原理",
   
  ];
  final WidgetArray = [
    widgetStateManage(),
    basicWidget(),
    basicWidget1(),
    layoutWidget(),
    StackDemo(),
    containerWidget(),
    containerWidget1(),
    loginPage(),
    SingleChildScrollViewTestRoute(),
    ScrollableWidget2(),
    ScrollableWidget3(),
    ScrollableWidget4(),
    ScrollableWidget5(),
    functionWidget()
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget devider1 = Divider(color: Colors.blue);
    Widget devider2 = Divider(color: Colors.green);
    Widget devider3 = Divider(color: Colors.grey);
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return getItem(index, context);
          },
          separatorBuilder: (context, int index) {
            //return index % 2 == 0 ? devider1 : devider2;
            return devider3;
          },
          itemCount: titles.length),
    );
  }

  Widget getItem(index, context) {
    return GestureDetector(
      child: ListTile(title: Text(titles[index])),
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context) {
          //return NewRoute();
          //return CounterWidget();
          //return Text("xxx");
          return WidgetArray[index];
        }));
      },
    );
  }
}


