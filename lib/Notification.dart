import 'package:flutter/material.dart';
//Notification
//Notification是Flutter中⼀个重要的机制，在Widget树中，每⼀个节点都可以分发通知，通知会沿着当前节点（context） 向上传递，
//所有⽗节点都可以通过NotificationListener来监听通知，Flutter中称这种通知由⼦向⽗的传递为“通知冒 泡”（Notification Bubbling），
//这个和⽤户触摸事件冒泡是相似的，
//但有⼀点不同：通知冒泡可以中⽌，但⽤户触摸事 件不⾏。
// Flutter中很多地⽅使⽤了通知，如可滚动(Scrollable) Widget中滑动时就会分发ScrollNotification，
//⽽Scrollbar正是通过 监听ScrollNotification来确定滚动条位置的。除了ScrollNotification，Flutter中
//还有SizeChangedLayoutNotification、 KeepAliveNotification 、LayoutChangedNotification等。
//下⾯是⼀个监听Scrollable Widget滚动通知的例⼦：

class NotificationTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("通知Notificaiton"),
        ),
        body: NotificationListener(
          onNotification: (noti) {
            switch (noti.runtimeType) {
              case ScrollStartNotification:
                print("开始滚动");
                break;
              case ScrollUpdateNotification:
                print("正在滚动");
                break;
              case ScrollEndNotification:
                print("滚动结束");
                break;
              case OverscrollNotification:
                print("滚动到边界");
                break;
              default:
                break;
            }
            return true;
          },
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("$index"),
              );
            },
          ),
        ));
  }
}
