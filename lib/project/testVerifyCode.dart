import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app01/project/CustomVertificationCode.dart';

class testVerifyCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _testVerifyCodeState();
  }
}

class _testVerifyCodeState extends State<testVerifyCode> {

  String code = "";
// 调用随机数方法
  _getCode(){
    code = '';
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    for (var i = 0; i < 4; i++) {
      String charOrNum = Random().nextInt(2) % 2 == 0 ? "char" : "num";  
      switch (charOrNum) {
          case "char":
              code += alphabet[Random().nextInt(alphabet.length)];
              break;
          case "num":
              code += Random().nextInt(9).toString();
              break;
      }
      setState(() {
        
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Container(
        padding: const EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 1.0,
              color: Color(0xffC7C7C7)
            )
          )
        ),
        child: CustomVertificationCode(code: code, backgroundColor: Colors.red),
      ),
      onTap: _getCode(),
    );
  }
}
