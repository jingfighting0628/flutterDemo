import 'package:flutter/material.dart';

class ScaleTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScaleTestRouteState();
  }
}

class _ScaleTestRouteState extends State<ScaleTestRoute> {
  double _width = 200.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("缩放"),
      ),
      body: Center(
        child: GestureDetector(
          child: Image.asset("image/duola.jpeg",width: _width,),
          onScaleUpdate: (ScaleUpdateDetails details) {
           setState(() {
              //缩放倍数在0.8到10倍之间
            _width = 200 * details.scale.clamp(.8, 10.0);
           });
          },
        ),
      ),
    );
  }
}
