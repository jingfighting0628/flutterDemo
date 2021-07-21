import 'package:flutter/material.dart';

class basicWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("基础Widget1"),
      ),
      body: basicWidgetBody(),
    );
  }
}

class basicWidgetBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _basicWidgetState();
  }
}

class _basicWidgetState extends State<basicWidgetBody> {
  /*
    获取输⼊内容 获取输⼊内容有两种⽅式： 1. 定义两个变量，⽤于保存⽤户名和密码，然后在onChange触发时，各⾃保存⼀下输⼊内容。 
    2. 通过controller直接获取
  */
  TextEditingController _unameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    /*
     监听文本变化第二种方式,
     两种⽅式相⽐，onChanged是专⻔⽤于监听⽂本变化，
     ⽽controller的功能却多⼀些，除了能监听⽂本变化外，它还可 以设置默认值、选择⽂本
    */
    //设置默认值hello world
    _unameController.text = "Hello world";
    //从第三个字符开始选中后⾯的字符
    _unameController.selection = TextSelection(
        baseOffset: 2, extentOffset: _unameController.text.length);
    _unameController.addListener(() {
      print(_unameController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        //TextField
        /*
              textField属性如下
              const TextField({ 
                编辑框的控制器，
              通过它可以设置/获取编辑框的内容、选择编辑内容、
              监听编辑⽂本改变事件。⼤多 数情况下我们都需要显式提供⼀个controller来与⽂本框交互。
              如果没有提供controller，则TextField内部会⾃动创 建⼀个
              TextEditingController controller, 
              ⽤于控制TextField是否占有当前键盘的输⼊焦点。它是我们和键盘交互的⼀个handle
              FocusNode focusNode, 
              
              ⽤于控制TextField的外观显示，如提示⽂本、背景颜⾊、边框等 
              TextInputType keyboardType, 
              ⽤于设置该输⼊框默认的键盘输⼊类型，取值如下
              text | ⽂本输⼊键盘 
              | | multiline | 
              多⾏⽂本，需和maxLines配合使⽤(设为null或⼤于1) 
              | | number | 数字；会弹出数字键盘 | | 
              phone | 优化 后的电话号码输⼊键盘；会弹出数字键盘并显示"* #" | | 
              datetime | 优化后的⽇期输⼊键盘；Android上会显示“: -” | | 
              emailAddress | 优化后的电⼦邮件地址；会显示“@ .” | | 
              url | 优化后的url输⼊键盘； 会显示“/ .
              InputDecoration decoration = const InputDecoration(),
              

              TextInputAction textInputAction, 
              TextStyle style, 正在编辑的⽂本样式
              TextAlign textAlign = TextAlign.start,  输⼊框内编辑⽂本在⽔平⽅向的对⻬⽅式
              bool autofocus = false, 是否⾃动获取焦点
              bool obscureText = false, 是否隐藏正在编辑的⽂本，如⽤于输⼊密码的场景等，⽂本内容会⽤“•”替换
              int maxLines = 1, 输⼊框的最⼤⾏数，默认为1；如果为 null ，则⽆⾏数限制

              maxLength代表输⼊框⽂本的最⼤⻓度，设置后输⼊框右下⻆会显示输⼊的⽂ 本计数。
              maxLengthEnforced决定当输⼊⽂本⻓度超过maxLength时是否阻⽌输⼊，为true时会阻⽌输⼊，为false 时不会阻⽌输⼊但输⼊框会变红
              int maxLength, 
              bool maxLengthEnforced = true, 
              输⼊框内容改变时的回调函数；注：内容改变事件也可以通过controller来监听
              ValueChanged<String> onChanged, 
              VoidCallback onEditingComplete,
               ValueChanged<String> onSubmitted, 
               List<TextInputFormatter> inputFormatters, 
               bool enabled, 

               这三个属性是⽤于⾃定义输⼊框光标宽度、圆⻆和颜⾊的
               this.cursorWidth = 2.0, 
               this.cursorRadius, 
               this.cursorColor, ... })
            */
        Container(
          child: TextField(
            autofocus: true,
            controller: _unameController,
            decoration: InputDecoration(
                labelText: "用户名",
                hintText: "用户名或邮箱",
                prefixIcon: Icon(Icons.person)),
            /*
          监听⽂本变化 监听⽂本变化也有两种⽅式：
          1. 设置onChange回调，如：
          */
            onChanged: (value) {
              print("userNameTextFieldonChange:$value");
            },
          ),
        ),
        Container(
          child: TextField(
            decoration: InputDecoration(
                labelText: "密码",
                hintText: "您的登录密码",
                prefixIcon: Icon(Icons.password)),
            obscureText: true,
          ),
        ),
        /*控制焦点
  焦点可以通过FocusNode和FocusScopeNode来控制，默认情况下，焦点由FocusScope来管理，它代表焦点控制范 围，可以在这个范围内可以通过FocusScopeNode在输⼊框之间移动焦点、设置默认焦点等。我们可以通 过 FocusScope.of(context) 来获取widget树中默认的FocusScopeNode。
  下⾯看⼀个示例，在此示例中创建两个 TextField，第⼀个⾃动获取焦点，然后创建两个按钮：
  */
        FocusTestRoute(),
        //Form表单
        //Form继承⾃StatefulWidget对象，它对应的状态类为FormState
        FormTestRoute()
      ],
    );
  }
}

class FocusTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FocusTestRouteState();
  }
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode focusNode1 = FocusNode();

  FocusNode focusNode2 = FocusNode();
  FocusScopeNode focusScopeNode = FocusScopeNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //通过FocusNode可以监听焦点的改变事件
    focusNode1.addListener(() {
      //获得焦点时 focusNode.hasFocus值为true
      //失去焦点时为 false
      print(focusNode1.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            child: TextField(
              autofocus: true,
              focusNode: focusNode1,
              decoration: InputDecoration(
                  labelText: "input1",
                  hintText: "输入账号",
                  hintStyle: TextStyle(color: Colors.red, fontSize: 13.0),
                  // border: UnderlineInputBorder(
                  //   borderSide: BorderSide(
                  //     color: Colors.red
                  //   )
                  // )
                  //隐藏下划线
                  border: InputBorder.none),
            ),
            // 下滑线浅灰⾊，宽度1像素
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
            ),
          ),
          TextField(
            focusNode: focusNode2,
            decoration: InputDecoration(
              labelText: "input2",
              hintText: "请输入密码",
              hintStyle: TextStyle(color: Colors.red, fontSize: 13.0),
            ),
            //是否输入可见，密码设为不可见
            obscureText: true,
          ),
          Builder(
            builder: (context) {
              return Column(
                children: [
                  RaisedButton(
                    child: Text("移动焦点"),
                    onPressed: () {
                      //首先要根据context获取focusScopeNode
                      focusScopeNode = FocusScope.of(context);
                      //然后再用focusScopeNode请求要移动的焦点
                      focusScopeNode.requestFocus(focusNode2);
                    },
                  ),
                  //RaiseButton is ElevatedButton instead
                  RaisedButton(
                    child: Text("隐藏键盘"),
                    onPressed: () {
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class FormTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FormTestRouteState();
  }
}

/*
  使用Form表单
  1. ⽤户名不能为空，如果为空则提示“⽤户名不能为空”。 
  2. 密码不能⼩于6位，如果⼩于6为则提示“密码不能少于6位”。
*/
class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Form(
        key: _formKey,
        autovalidate: true, //开启自动校验
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              controller: _unameController,
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  icon: Icon(Icons.person)),
              validator: (v) {
                //这里需要把参数强制转为String,因为trim()是String的方法
                return (v as String).trim().length > 0 ? null : "用户名不能为空";
              },
            ),
            TextFormField(
              controller: _pwdController,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  icon: Icon(Icons.password)),
              obscureText: true,
              validator: (v) {
                //这里需要把参数强制转为String,因为trim()是String的方法
                return (v as String).trim().length > 5 ? null : "密码不能少于6位";
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      child: Text("登 录"),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                          //在这⾥不能通过此⽅式获取FormState，context不对 //print(Form.of(context)); // 通过_formKey.currentState 获取FormState后，
                          // 调⽤validate()⽅法校验⽤户名密码是否合法，校验 
                          // 通过后再提交数据。
                        if((_formKey.currentState as FormState).validate()){ 
                          //验证通过提交数据
                        }
                      },
                      
                    ),
                    
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
