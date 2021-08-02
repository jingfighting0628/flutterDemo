import 'package:flutter/material.dart';

//自定义通知
//除了flutter内部通知，我们也可以定义通知，下面看看如何定义通知
//1. 定义⼀个通知类，要继承⾃Notification类；
class MyNotification extends Notification {
  MyNotification(this.msg);
  final String msg;
}
//2、分发通知
//Notification有⼀个 dispatch(context) ⽅法，它是⽤于分发通知的，
//我们说过context实际上就是操作Element的⼀ 个接⼝，它与Element树上的节点是对应的，
//通知会从context对应的Element节点向上冒泡。
//

class NotificaionRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotificationRouteState();
  }
}

class _NotificationRouteState extends State<NotificaionRoute> {
  String _msg = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _msg += notification.msg + "";
        });
        return true;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(builder: (context) {
              return RaisedButton(
                onPressed: () {
                  MyNotification("Hi").dispatch(context);
                },
                child: Text("Send Notification"),
              );
            }),
            Text(_msg),
          ],
        ),
      ),
    );
  }
}
