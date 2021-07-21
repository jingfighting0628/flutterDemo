import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "Flutter Demo",
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new MyHomePage1(title: "Home Page"),
    );
  }
}

/*demo1 计数器示例*/
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() {
    return new _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Text("You have pushed the button this many times"),
              new Text(
                "$_counter",
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: new Icon(
            Icons.add,
          ),
        ));
  }
}

/*demo2路由管理*/
/*实现了⼀个回显字符串的 Echo widget
然后我们可以通过如下方式使用它
Widget build(BuildContext context) { return Echo(text: "hello world"); }
*/
class Echo extends StatelessWidget {
  const Echo({Key? key, required this.title, this.backgroundColor: Colors.grey})
      : super(key: key);
  final String title;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(title),
      ),
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

class MyHomePage1 extends StatefulWidget {
  MyHomePage1({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState1();
  }
}

class _MyHomePageState1 extends State<MyHomePage1> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text("You haved the button this many times"),
            new Text(
              "$_counter",
              style: Theme.of(context).textTheme.display1,
            ),
            /*我们添加了⼀个打开新路由的按钮，并将按钮⽂字颜⾊设置为蓝⾊，点击该按钮后就会打开新的路由⻚⾯*/
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return homePage();
                  //return NewRoute();
                  //return CounterWidget();
                  //return Text("xxx");
                }));
              },
              child: Text("open new Route"),
              textColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
/*demo3 State生命周期*/

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key? key,
    this.initValue: 0,
  }) : super(key: key);
  final initValue;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CounterWidgetState();
  }
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter1 = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _counter1 = widget.initValue;
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('123'),
      ),
      body: Center(
        child: FlatButton(
          child: Text("$_counter1"),
          onPressed: () {
            setState(() {
              _counter1++;
            });
          },
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}
