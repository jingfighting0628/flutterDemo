import 'package:flutter/material.dart';

class WidgetLibrary extends StatelessWidget {
  final title = ["AboutDialog"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("组件库"),
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(title:Text("123"));
        },
      ),
    );
  }
}
