import 'package:flutter/material.dart';

/*
  主题

  Theme Widget可以为Material APP定义主题数据（ThemeData），
  Material组件库⾥很多Widget都使⽤了主题数据，如 导航栏颜⾊、标题字体、Icon样式等。
  Theme内会使⽤InheritedWidget来为其⼦树Widget共享样式数据。

  ThemeData 
  ThemeData是Material Design Widget库的主题数据，
  Material库的Widget需要遵守相应的设计规范，⽽这些规范可⾃定 义部分都定义在ThemeData，所以我们可以通过ThemeData来⾃定义应⽤主题。
  我们可以通过 Theme.of ⽅法来获取当 前的ThemeData。
  注意，Material Design 设计规范中有些是不能⾃定义的，如导航栏⾼度，ThemeData只包含了可⾃定义部分。
  我们看看ThemeData部分数据：
  ThemeData({ 
  Brightness brightness, //深⾊还是浅⾊ 
  MaterialColor primarySwatch, //主题颜⾊样本，⻅下⾯介绍 
  Color primaryColor, //主⾊，决定导航栏颜⾊ 
  Color accentColor, //次级⾊，决定⼤多数Widget的颜⾊，如进度条、开关等。 
  Color cardColor, //卡⽚颜⾊ 
  Color dividerColor, //分割线颜⾊ 
  ButtonThemeData buttonTheme, //按钮主题 
  Color cursorColor, //输⼊框光标颜⾊ 
  Color dialogBackgroundColor,//对话框背景颜⾊ 
  String fontFamily, //⽂字字体 
  TextTheme textTheme,// 字体主题，包括标题、body等⽂字样式 
  IconThemeData iconTheme, // Icon的默认样式 
  TargetPlatform platform, //指定平台，应⽤特定平台控件⻛格 
  ... 
  })
  上⾯只是ThemeData的⼀⼩部分属性，完整列表读者可以查看SDK定义。
  上⾯属性中需要说明的是 primarySwatch ，它 是主题颜⾊的⼀个"样本"，
  通过这个样本可以在⼀些条件下⽣成⼀些其它的属性，例如，如果没有指定 primaryColor ， 
  并且当前主题不是深⾊主题，那么 primaryColor 就会默认为 primarySwatch 指定的颜⾊，
  还有⼀些相似的属性 如 accentColor 、 indicatorColor 等也会受 primarySwatch 影响。
*/
//示例
//我们实现⼀个路由换肤功能:
class ThemeTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ThemeTestRouteState();
  }
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {
  Color _themeColor = Colors.teal;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
        primaryColor: _themeColor, ////⽤于导航栏、FloatingActionButton的背景⾊等
        iconTheme: IconThemeData(color: _themeColor), //⽤于Icon颜⾊
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("主题测试"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //第⼀⾏Icon使⽤主题中的iconTheme
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                Text("颜色跟随主题")
              ],
            ),
            //为第⼆⾏Icon⾃定义颜⾊（固定为⿊⾊)
            Theme(
              data: themeData.copyWith(
                  iconTheme: themeData.iconTheme.copyWith(color: Colors.black)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("颜色固定黑色")
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _themeColor =
                  _themeColor == Colors.teal ? Colors.blue : Colors.teal;
            });
          },
          child: Icon(Icons.palette),
        ),
      ),
    );
  }
}
//需要注意的有三点： 
//1、可以通过局部主题覆盖全局主题，正如代码中通过Theme为第⼆⾏图标指定固定颜⾊（⿊⾊）⼀样，
//这是⼀种常⽤ 的技巧，Flutter中会经常使⽤这种⽅法来⾃定义⼦树主题。那么为什么局部主题可以覆盖全局主题？
//这主要是因为 Widget中使⽤主题样式时是通过 Theme.of(BuildContext context) 来获取的，我们看看其简化后的代码：
/*
static ThemeData of(BuildContext context, 
{ bool shadowThemeOnly = false }) 
{ // 简化代码，并⾮源码 
return context.inheritFromWidgetOfExactType(_InheritedTheme) 
}
*/
//context.inheritFromWidgetOfExactType 会在widget树中从当前位置向上查找第⼀个类型为 _InheritedTheme 的 Widget。
//所以当局部使⽤Theme后，其⼦树中 Theme.of() 找到的第⼀个 _InheritedTheme 便是该Theme的
//2、本示例是对单个路由换肤，如果相对整个应⽤换肤，可以去修改MaterialApp的theme属性。