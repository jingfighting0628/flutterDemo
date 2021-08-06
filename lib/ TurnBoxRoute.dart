import 'package:flutter/material.dart';
import 'package:flutter_app01/TurnBox.dart';

class TurnBoxRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TurnBoxRouteState();
  }
}

class _TurnBoxRouteState extends State<TurnBoxRoute> {
  double _turns = .0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("TurnBox实例"),
      ),
      body: Center(
        child: Column(
        children: [
          TurnBox(
            turns: _turns,
            speed: 500,
            child: Icon(
              Icons.refresh,
              size: 50.0,
            ),
          ),
          TurnBox(
            turns: _turns,
            speed: 1000,
            child: Icon(
              Icons.refresh,
              size: 150.0,
            ),
          ),
          RaisedButton(
            child: Text("顺时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns += .2;
              });
            },
          ),
          RaisedButton(
            child: Text("逆时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns -= .2;
              });
            },
          )
        ],
      ),
      )
    );
  }
}
