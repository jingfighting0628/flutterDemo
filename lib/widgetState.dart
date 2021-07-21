
import 'package:flutter/material.dart';
/*
  如何决定使⽤哪种管理⽅法？以下原则可以帮助你决定：
  如果状态是⽤户数据，如复选框的选中状态、滑块的位置，则该状态最好由⽗widget管理。 
  如果状态是有关界⾯外观效果的，例如颜⾊、动画，那么状态最好由widget本身来管理。 
  如果某⼀个状态是不同widget共享的则最好由它们共同的⽗widget管理
*/
/*
  Widget管理⾃⼰的state。 
  
*/
class widgetStateManage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("状态管理"),
      ),
      body: TapBoxA(),
    );
  }
}

class TapBoxA extends StatefulWidget {
  TapBoxA({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TapboxAState();
  }
}

class _TapboxAState extends State<TapBoxA> {
  bool _active = false;
  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? "Active":"Inactice",
            style: TextStyle(fontSize: 32.0,color: Colors.white),

          ),
          
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: _active?Colors.lightGreen[700]:Colors.grey[600],
        ),
      ),
    );
  }
}
/*2、⽗widget管理⼦widget状态*/
class parentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<parentWidget> {
  bool _active = false;
  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: TapBoxB(onChanged: _handleTapBoxChanged,active: _active,),
    );
  }
}

class TapBoxB extends StatelessWidget {
  TapBoxB({Key?key, this.active: false, required this.onChanged})
      : super(key: key);
  final bool active;
  final ValueChanged<bool> onChanged;
  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active? "Active":"InActive",
            style: TextStyle(fontSize: 32,color: Colors.white),
            ),
        ),
        width: 200,
        height: 200,
        decoration:  BoxDecoration(
          color: active ? Colors.lightGreen[700]:Colors.grey[500]
        ),
      ),
    
    );
  }
}

/*
    混合管理（⽗widget和⼦widget都管理状态）
*/