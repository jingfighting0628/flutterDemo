import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app01/project/testVerifyCode.dart';
import 'package:flutter_app01/project/verifyCodeDemo.dart';
// import 'package:hb_check_code/hb_check_code.dart';

class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("项目"),
      ),
      body: loginWidget(),
    );
  }
}

class loginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, left: 15),
          // color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("国网商旅云",
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
              Text("账号密码登录",
                  style: TextStyle(fontSize: 12.0, color: Colors.grey)),
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "请输入手机号码",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                      border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      suffixIcon: Icon(Icons.close),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0))),
                ),
                decoration: BoxDecoration(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextField(
                  enabled: true,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "请输入密码",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    )),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                // child: TextField(
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(
                //       hintText: "请输入图形验证码",
                //       focusedBorder: UnderlineInputBorder(
                //           borderSide: BorderSide(
                //         color: Colors.grey,
                //         width: 1.0,
                //       ))),
                // ),
                child: testVerifyCode(),
              ),
              Container(
                margin:
                    const EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
                width: ScreenUtil.getScreenW(context) - 30.0,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: RaisedButton(
                  child: Text(
                    "登  录",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {

                    // }));
                    login();
                  },
                  color: Color(0xFF80CBC4),
                ),
              )
            ],
          ),
        ),
        // Container(),
        // Container()
      ],
    );
  }

  void login() {
    print("login登录事件");
  }
}

// class CodeTestWidget extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _CodeTestWidgetState();
//   }
// }

// class _CodeTestWidgetState extends State<CodeTestWidget> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     String code = "";
//     for (var i = 0; i < 6; i++) {
//       code = code + Random().nextInt(9).toString();
//     }
//     return Container(
//       child: HBCheckCode(
//       code: code,
//     ),
//     );
//   }
// }
