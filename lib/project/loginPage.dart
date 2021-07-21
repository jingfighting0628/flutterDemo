import 'package:flutter/material.dart';

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
            margin: EdgeInsets.only(top: 64,left: 15),
            // color: Colors.blue,
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("123",style: TextStyle(fontSize: 24.0,color: Colors.black,fontWeight: FontWeight.w700 )),
                Text("账号密码登录",style: TextStyle(fontSize: 12.0,color: Colors.grey))
                
              ],
              
            ),
            //  height: 100,
            //  width: 300,
          ),
          Container(

          ),
          Container(

          )
        ],

    )
    ;
  }
}
