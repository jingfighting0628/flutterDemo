import 'package:flutter/material.dart';

//单⼀⽅向拖动 在本示例中，是可以朝任意⽅向拖动的，但是在很多场景，我们只需要沿⼀个⽅向来拖动，
//如⼀个垂直⽅向的列表， GestureDetector可以只识别特定⽅向的⼿势事件，我们将上⾯的例⼦改为只能沿垂直⽅向拖动：
//这样就只能在垂直⽅向拖动了，如果只想在⽔平⽅向滑动同理。
class GestureDetectorTestRoute2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GestureDetectorTestRoute2State();
  }
}

class _GestureDetectorTestRoute2State extends State<GestureDetectorTestRoute2> {
  double _top = 0.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("单⼀⽅向拖动"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: _top,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text("A"),
              ),
              onVerticalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _top += details.delta.dy;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
