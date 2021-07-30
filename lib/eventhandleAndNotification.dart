import 'package:flutter/material.dart';
/*

  Pointer事件处理 
  本节先来介绍⼀下原始指针事件(Pointer Event，在移动设备上通常为触摸事件)，下⼀节再介绍⼿势处理。 
  在移动端，各个平台或UI系统的原始指针事件模型基本都是⼀致，即：⼀次完整的事件分为三个阶段：⼿指按下、⼿指 移动、和⼿指抬起，⽽更⾼级别的⼿势（如点击、双击、拖动等）都是基于这些原始事件的。 
  当指针按下时，Flutter会对应⽤程序执⾏命中测试(Hit Test)，以确定指针与屏幕接触的位置存在哪些widget， 指针按下 事件（以及该指针的后续事件）然后被分发到由命中测试发现的最内部的widget，
  然后从那⾥开始，事件会在widget树 中向上冒泡，这些事件会从最内部的widget被分发到到widget根的路径上的所有Widget，这和Web开发中浏览器的事件 冒泡机制相似， 但是Flutter中没有机制取消或停⽌冒泡过程，⽽浏览器的冒泡是可以停⽌的。注意，只有通过命中测试 的Widget才能触发事件。
   Flutter中可以使⽤Listener widget来监听原始触摸事件，它也是⼀个功能性widget。
   Listener({ 
     Key key, 
   this.onPointerDown, //⼿指按下回调 
   this.onPointerMove, //⼿指移动回调 
   this.onPointerUp,//⼿指抬起回调 this.onPointerCancel,//触摸事件取消回调 
   this.behavior = HitTestBehavior.deferToChild, //在命中测试期间如何表现 
   Widget child 
   })
*/

class eventhandleAndNotification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _eventhandleAndNotificationState();
  }
}

class _eventhandleAndNotificationState
    extends State<eventhandleAndNotification> {
  @override
  Widget build(BuildContext context) {
    PointerEvent? _event;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("事件处理与通知"),
      ),
      body: Listener(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 300.0,
          height: 150.0,
          child: Text(
            _event?.toString() ?? "",
            style: TextStyle(color: Colors.white),
          ),
        ),
        onPointerDown: (PointerDownEvent event) => setState(()=>_event=event),
        onPointerMove: (PointerMoveEvent event) => setState(()=>_event=event),
        onPointerUp: (PointerUpEvent event) => setState(()=>_event=event),
      ),
    );
  }
}
/*
  
*/