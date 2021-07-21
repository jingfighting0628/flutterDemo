import 'package:flutter/material.dart';

class layoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("布局类Widget"),
      ),
      body: Center(
        child: Container(
          child: Text("布局类Widget"),
        ),
      ),
    );
  }
}
