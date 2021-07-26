import 'package:flutter/material.dart';

/*
  功能型Widget
  功能型Widget指的是不会影响UI布局及外观的Widget，它们通常具有⼀定的功能，如事件监听、数据存储等，
  我们之前 介绍过的FocusScope（焦点控制）、PageStorage（数据存储）、NotificationListener（事件监听）都属于功能型 Widget。
  由于Widget是Flutter的⼀等公⺠，功能型Widget⾮常多，我们不会去⼀⼀介绍，本章中主要介绍⼏种常⽤的功 能型Widget。

  /**导航返回拦截WillPopScope**/
  为了避免⽤户误触返回按钮⽽导致APP退出，在很多APP中都拦截了⽤户点击返回键的按钮，
  当⽤户在某⼀个时间段内 点击两次时，才会认为⽤户是要退出（⽽⾮误触）。
  Flutter中可以通过WillPopScope来实现返回按钮拦截，我们看看 WillPopScope的默认构造函数
  const WillPopScope
  ({ 
    ...
     @required WillPopCallback onWillPop, 
     @required Widget child 
  })
  onWillPop是⼀个回调函数，当⽤户点击返回按钮时调⽤（包括导航返回按钮及Android物理返回按钮），
  该回调需要返 回⼀个Future对象，如果返回的Future最终值为 false 时，则当前路由不出栈(不会返回)，
  最终值为 true 时，当前路 由出栈退出。我们需要提供这个回调来决定是否退出。

*/
class functionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("功能型Widget"),
      ),
      //示例
      //为了防⽌⽤户误触返回键退出，我们拦截返回事件，当⽤户在1秒内点击两次返回按钮时，则退出，
      //如果间隔超过1秒则 不退出，并重新记时。代码如下
      body: WillPopScopeTestRoute(),
    );
  }
}

class WillPopScopeTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WillPopScopeTestRouteState();
  }
}

class WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime? lastPressAt; //上次点击时间
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        DateTime lastPressAt1 = lastPressAt as DateTime;
       
        if (lastPressAt == null ||
            DateTime.now().difference(lastPressAt1) > Duration(seconds: 1)) {
          lastPressAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: Container(
        alignment: Alignment.center,
        child: Text("1秒内连续两次返回键退出"),
      ),
    );
  }
}

