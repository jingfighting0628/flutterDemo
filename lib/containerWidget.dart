import 'package:flutter/material.dart';

class containerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("容器类Widget"),
      ),
      body: Center(
        child: Container(
          child: Text("容器类Widget"),
        ),
      ),
    );
  }
}
