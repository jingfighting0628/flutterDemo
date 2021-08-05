import 'dart:convert';
import 'dart:math';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
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
                    Login();
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

  void login() async {
    print("login登录事件");
    var httpClient = HttpClient();

    var uri = Uri.http("192.168.70.63:8086", "/api/token/v3", {
      "password": "1234qwer@",
      "mobile": "18518315321",
      "checkImgCode": "07020",
      "riskFlag": "Y",
      "constId":
          "a5JzP5Ep38jZ9XOhKD98HWGDzgav_Du6FiZd2INmg9xwKOxirKL21Ab-prkBvsXdqBoclLIQqFP703m90BgshEW3yOvNDHMOGri8Ggbk2hgn1hyhRH-_w8XQ7_yHYoTnT5kmme5pVMosGCj2jcVu_pN5YE5C6n7SV8X_kXiPe1CkNro1S1xlhgwOsYulo9RdpL9621BHKn5w3OibI1IBiIqbGi9l0bM7YA5ShLmnwmwRjTMrbyOxnAUNfYWrdAc09a0jJ3PykMbVKQHDgiC1kmFG0md6cA5gWPfa1glBCcQCqQlIOf5XLN6Iekx2wVj8PT1BB-ogrOTnChBxaQK35b9V-QhxWlk6Sv9K6jBhJWUOUg8RFD5iu5dMHkG3FzzsIHgpsxeYLimOsKWU-EMD0toTndZFIHWha6nKrzaEcWdDYSl0QZF2y0gDuzxOfUm4pew1Z0sO3TmQwzAWFLuQjXT-r7QzLCoCoVrpvQAacRPVhdBhDxQXbZEwV--VA-kEJrz_Fg85qpX0ToLowe-oml8FrMEtbqZHFtGsuNYySV7h3Zkodk50wvZsFsd_b9BayPef58zqHLdiaz91qQPXxtmGAVTx8vpSjRsMq5KqqKZg7GkJVNYKVYD5Ax3YovWtcRHBtOQfPlJrMzTokAFLqCrD3tciO6mNcYpLzY2CkTIjFRH_uMck1EmNdqcrtD87VtzNSBx7GjB9ouBP1Nxt3ppnUe6ERC5g6k7t60TmBkThxFOgU9ZRCYXmCjpX8zbPYC0fsdw-i_vIDp09Ryi9Vg4A7RHHBTTtGYNSOhTXZw-Iv1NzwPQY6HxTqHpa9DItpLKmLNbCTJBT3PC_Xt-R-gwVm-KSVPpNporspJr3scfbgaQYJLRDUOB9XwyWbzj0NeEqFuGy4jJVhqL4jMnN0kUlcWmo1zCXUSXIhNNbbElen2f6CJ6joGICg7s4CeTAJhHS1kEYGBNhIlJfAVRAmr_yqrdtjdcclZHBlME2EgNjnjbPHhMNK3MsxZlJqx_YYCXiKiCVOX0ChEOuwZS8lHYGTLlKQOM-iCe3g5llkA_Q0HU5ZmdoJmHZ37Wpkk7MxjOZo9eftYIUV31pbltFJYaoAlB9cvtzsF_5hHT0A68frQIOURkiprPnseJ94oEycS0Z25XtCEjbgRzf-U1aLv03STXX8AO31M4tPeLGfQHZY_cxoOXa8-7PRo16Yt8csNhSAJhkuGdey_ok4NgRCYHrGdnR0TG_XnXRH79JdMh3DD7es8DyrMPi6fNOWwMS_4bvfA!784435f22329f782473b34e0e8e02bf8!fcbb6881730c89f165dd1e2dbaed09e0!5.6.1"
    });
    //http://192.168.70.63:8086/api/ads
    //http://192.168.70.63:8086/api/example/splash/check

    /*
      {
	Content-Type = "application/jsonx";
	version-code = "473";
	grayversion = "2.4.7.1";
	encFlag = "2";
	uuid = "E015C6AB-6E64-45F8-9993-0612BCF244B2";
	version = "2.5.2";
	appType = "0";
	uniID = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzZXNzaW9uSWQiOiI1YWNiNmUzNy04Y2Q4LTRiMmEtYTVkOS0yNzY5NDdmYzJmZDUiLCJ0aW1lIjoxNjI3OTczMDkyMzE0LCJzZXEiOjMxLCJleHAiOjE2Mjc5NzY5OTIsIm5iZiI6MTYyNzk3MzA5Mn0.V45MivBzsyUrUCvbaLFNT6Sib3HSxMRZpD8aOUJaMhk";
} 
    */
    var request = await httpClient.postUrl(uri);
    request.headers.add("Content-Type", "application/jsonx");
    request.headers.add("version-code", "473");
    request.headers.add("grayversion", "2.4.7.1");
    request.headers.add("encFlag", "2");
    request.headers.add("uuid", "E015C6AB-6E64-45F8-9993-0612BCF244B2");
    request.headers.add("version", "2.5.2");
    request.headers.add("appType", "0");
    request.headers.add("uniID",
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzZXNzaW9uSWQiOiI1YWNiNmUzNy04Y2Q4LTRiMmEtYTVkOS0yNzY5NDdmYzJmZDUiLCJ0aW1lIjoxNjI3OTczMDkyMzE0LCJzZXEiOjMxLCJleHAiOjE2Mjc5NzY5OTIsIm5iZiI6MTYyNzk3MzA5Mn0.V45MivBzsyUrUCvbaLFNT6Sib3HSxMRZpD8aOUJaMhk");
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();

    print("responseBody:$responseBody");
  }

  void getAccessToken() async {
    //UE9DGuUDwsXtMvWOGyGJbOug6Jx97q09
    var httpClient = HttpClient();
    var uri = Uri.http("192.168.70.63:8086", "/api/ads",
        {"adSecret": "UE9DGuUDwsXtMvWOGyGJbOug6Jx97q09", "adClientId": "ios"});
    /*
      Content-Type = "application/jsonx";
      version-code = "473";
	grayversion = "2.4.7.1";
	encFlag = "2";
	uuid = "E015C6AB-6E64-45F8-9993-0612BCF244B2";
	version = "2.5.2";
	appType = "0";
    */
    var request = await httpClient.postUrl(uri);
    request.headers.add("Content-Type", "application/json");
    request.headers.add("version-code", "473");
    request.headers.add("grayversion", "2.4.7.1");
    request.headers.add("encFlag", "2");
    request.headers.add("uuid", "E015C6AB-6E64-45F8-9993-0612BCF244B2");
    request.headers.add("version", "2.5.2");
    request.headers.add("appType", "0");
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    print("responseBody:$responseBody");
  }

  void getAccessToken1() async {
    Options options = Options();
    Map<String, dynamic>? headers = Map();

    ///请求header的配置
    options.contentType = "application/jsonx";
    headers["version-code"] = 473;
    headers["encFlag"] = "2";
    headers["grayversion"] = "2.4.7.1";
    headers["uuid"] = "E015C6AB-6E64-45F8-9993-0612BCF244B2";
    headers["version"] = "2.5.2";
    headers["appType"] = "0";
    options.method = "POST";
    options.sendTimeout = 30000;
    options.headers = headers;
    Dio dio = Dio();

    Response response;
    response = await dio.post("http://192.168.70.63:8086/api/ads",
        options: options,
        queryParameters: {
          "adSecret": "UE9DGuUDwsXtMvWOGyGJbOug6Jx97q09",
          "adClientId": "ios"
        });

    //eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzZXNzaW9uSWQiOiJmYjQ0ODhkZi1jZmRkLTRkZTYtYmRmNS0xOTBlMjFhNzdmYTIiLCJ0aW1lIjoxNjI3OTc3Mzc5NDcxLCJzZXEiOjM1LCJleHAiOjE2Mjc5ODEyNzksIm5iZiI6MTYyNzk3NzM3OX0.
    //lsxRsd_k7igJx3zHHOvpHl-cNhzLA9vrAAnRcsCz18w
    print("data:($response.data)");
  }

  void Login() async {
    Response response;

    response = await Dio().post(
        "http://218.12.25.203:8008/api/app/Login?ver=1.8.7&plf=0",
        data: {"pwd":",,,,,,","username":"yuhaibo"});

    print("data:($response.data)");
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
