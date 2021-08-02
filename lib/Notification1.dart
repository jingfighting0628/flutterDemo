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
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义通知"),
      ),
      body: NotificationListener<MyNotification>(
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
                  MyNotification("Hi  ").dispatch(context);
                },
                child: Text("Send Notification"),
              );
            }),
            Text(_msg),
          ],
        ),
      ),
    ),
    );
  }
}
//上⾯代码中，我们每点⼀次按钮就会分发⼀个 MyNotification 类型的通知，我们在Widget根上监听通知，
//收到通知后 我们将通知通过Text显示在屏幕上。 
//注意：代码中注释的部分是不能正常⼯作的，
//因为这个 context 是根Context，⽽NotificationListener是监听的⼦ 树，
//所以我们通过 Builder 来构建RaisedButton，来获得按钮位置的context。