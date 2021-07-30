import 'package:flutter/material.dart';

class GestureDetectorTestRoute1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GestureDetectorTestRouteState1();
  }
}

class _GestureDetectorTestRouteState1 extends State<GestureDetectorTestRoute1> {
  double _top = 0.0;
  double _left = 0.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("拖动、滑动"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text("A"),
              ),
              //手指按下时会触发此回调
              onPanDown: (DragDownDetails e) {
                //打印⼿指按下的位置(相对于屏幕)
                print("⽤户⼿指按下：${e.globalPosition}");
              },
              onPanUpdate: (DragUpdateDetails e) {
                //⽤户⼿指滑动时，更新偏移，重新构建
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
              },
              onPanEnd: (DragEndDetails e) {
                //打印滑动结束时在x、y轴上的速度 
                print(e.velocity);
              },
            ),
          )
        ],
      ),
    );
  }
}
