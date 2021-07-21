import 'package:flutter/material.dart';

class basicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('基础Widget'),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.blue,
              // overflow属性有三个值 visible、ellipsis、fade
              child: Text(
                'Hello World hello World',
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
                overflow: TextOverflow.visible,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    height: 1.2,
                    fontFamily: "Courier",
                    background: new Paint()..color = Colors.yellow,
                    decorationStyle: TextDecorationStyle.dashed,
                    decoration: TextDecoration.underline),
              ),
              height: 55,
            ),
            Container(
              child: Text.rich(TextSpan(children: [
                TextSpan(text: "home"),
                TextSpan(
                    text: "https://flutterchina.club",
                    style: TextStyle(color: Colors.blue)
                    // recognizer: null
                    ),
              ])),
            ),
            //RaisedButton
            Container(
              child: RaisedButton(
                child: Text("nomal"),
                onPressed: () {
                  print("RaisedButtonClick");
                },
              ),
            ),
            //FlatButton
            Container(
              child: FlatButton(
                child: Text("nomal"),
                onPressed: () {
                  print("FlatButtonClick");
                },
              ),
            ),
            //OutlineButton
            Container(
              child: OutlineButton(
                child: Text("normal"),
                onPressed: () {
                  print("OutlineButtonClick");
                },
              ),
            ),
            //IconButton
            Container(
              child: IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () {
                  print("IconButtonClick");
                },
              ),
            ),
            //自定义按钮
            Container(
              child: FlatButton(
                color: Colors.blue,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                child: Text("Submit"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {
                  print("自定义FlatbuttonClick");
                },
              ),
            ),
            //图片
            Container(
              child: Image(
                image: AssetImage("image/duola.jpeg"),
                width: 100,
                height: 100,
              ),
            ),
            //加载图片另一种方法
            Container(
              child: Image.asset("image/duola.jpeg"),
              width: 100,
              height: 100,
            ),
            //从网络加载图片

            Expanded(
                child: Container(
              child: Image(
                image: NetworkImage(
                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fztd00.photos.bdimg.com%2Fztd%2Fw%3D700%3Bq%3D50%2Fsign%3Df7af64f9a651f3dec3b2bb64a4d58122%2Fb21bb051f81986185cc343b743ed2e738bd4e679.jpg&refer=http%3A%2F%2Fztd00.photos.bdimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629370476&t=f6d320b9338319bd27b7f305dbab7383"),
                width: 100,
                height: 100,
              ),
            )),
            //从网络加载图片快捷构造方法
            Expanded(
                child: Container(
              child: Image.network(
                  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.people.com.cn%2Fmediafile%2Fpic%2F20140904%2F85%2F27067424198611485.jpg&refer=http%3A%2F%2Fwww.people.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629370476&t=8eaa2f66f4b465f972c7c4898f5aae1f"),
              width: 100,
            )),
            //自定义图片样式
            Expanded(
                child: Container(
              child: Image(
                width: 100,
                height: 200,
                color: Colors.red,
                //colorBlendMode: ,//混合模式
                alignment: Alignment.centerLeft,
                repeat: ImageRepeat.noRepeat,
                image: NetworkImage(
                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Ffriendoprod.blob.core.windows.net%2Fmissionpics%2Fimages%2F4334%2Fmember%2Fe3656de4-9b49-4eac-a642-0b28bb9238e4.jpg&refer=http%3A%2F%2Ffriendoprod.blob.core.windows.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629370476&t=341c51de2937a5474016a0121426e652"),
              ),
            )),
            Container(
              child: SwithcAndCheckBoxTestRoute(),
            ),
          
          ],
        ));
  }
}
/*
通过Switch和Checkbox我们可以看到，虽然它们本身是与状态（是否选中）关联的，
但它们却不是⾃⼰来维护状态， ⽽是需要⽗widget来管理状态，
然后当⽤户点击时，再通过事件通知给⽗widget，这样是合理的，
因为Switch和 Checkbox是否选中本就和⽤户数据关联，
⽽这些⽤户数据也不可能是它们的私有状态。
我们在⾃定义widget时也应该 思考⼀下哪种状态的管理⽅式最为合理。  
*/
class SwithcAndCheckBoxTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SwitchAndCheckBoxTestRouteState();
  }
}

class _SwitchAndCheckBoxTestRouteState
    extends State<SwithcAndCheckBoxTestRoute> {
  bool _switchSelected = true;
  bool _checkboxSelected = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Switch(
            value: _switchSelected,
            onChanged: (value) {
              setState(() {
                _switchSelected = value;
              });
            }),
        Checkbox(
            value: _checkboxSelected,
            activeColor: Colors.red,
            onChanged: (value1) {
              setState(() {
                //直接给_checkboxSelected赋值的化会隐式转换失败了。解决方案是在报错的位置人为进行强转
                _checkboxSelected = value1 as bool;
              });
            })
      ],
    );
  }
}
