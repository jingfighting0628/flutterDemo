import 'package:flutter/material.dart';

//GestureDetector是⼀个⽤于⼿势识别的功能性Widget，
//我们通过它可以来识别各种⼿势，它是指针事件的语义化封 装，接下来我们详细介绍⼀下各种⼿势识别：
//点击、双击、⻓按 我们通过GestureDetector对Container进⾏⼿势识别，触发相应事件后，
//在Container上显示事件名，为了增⼤点击区 域，将Container设置为200×100，代码如下
//注意： 当同时监听 onTap 和 onDoubleTap 事件时，当⽤户触发tap事件时，会有200毫秒左右的延时，
//这是因为当⽤户 点击完之后很可能会再次点击以触发双击事件，所以GestureDetector会等⼀断时间来确定是否为双击事件。
//如果⽤户 只监听了 onTap （没有监听 onDoubleTap ）事件时，则没有延时。
class GestureDetectorTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GestureDetectorTestRouteState();
  }
}

class _GestureDetectorTestRouteState extends State<GestureDetectorTestRoute> {
  String _operation = "No Gesture detected!";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("手势检测(点击、双击、长按)"),
      ),
      body: Center(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200.0,
          height: 100.0,
          child: Text(
            _operation,
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () {
          updateText("Tap");
        },
        onDoubleTap: () {
          updateText("Double Tap");
        },
        onLongPress: () {
          updateText("longpress");
        },
      ),
    ),
    );
    
  }
  void updateText(String text) {
      setState(() {
        _operation = text;
      });
    }
}
//
