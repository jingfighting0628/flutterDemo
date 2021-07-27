import 'package:flutter/material.dart';

/*

  /**数据共享InheritedWidget**/
  InheritedWidget是Flutter中⾮常重要的⼀个功能型Widget，它可以⾼效的将数据在Widget树中向下传递、共享，
  这在⼀ 些需要在Widget树中共享数据的场景中⾮常⽅便，
  如Flutter中，正是通过InheritedWidget来共享应⽤主题(Theme)和 Locale(当前语⾔环境)信息的。
  InheritedWidget和React中的context功能类似，和逐级传递数据相⽐，它们能实现组件跨级传递数据。 
  InheritedWidget的在Widget树中数据传递⽅向是从上到下的，这和Notification的传递⽅向正好相反。

  didChangeDependencies
  在介绍StatefulWidget时，我们提到State对象有⼀个回调 didChangeDependencies ，
  它会在“依赖”发⽣变化时被Flutter Framework调⽤。⽽这个“依赖”指的就是是否使⽤了⽗widget中InheritedWidget的数据，
  如果使⽤了，则代表有依赖， 如果没有使⽤则代表没有依赖。这种机制可以使⼦组件在所依赖的主题、locale等发⽣变化时有机会来做⼀些事情。 
  我们看⼀下之前“计数器”示例应⽤程序的InheritedWidget版本，需要说明的是，本例主要是为了演示InheritedWidget的 功能特性，
  并不是计数器的推荐实现⽅式。
  
*/
// ⾸先，我们通过继承InheritedWidget，将当前计数器点击次数保存在ShareDataWidget的 data 属性中

class funtionWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("功能型Widget1"),
      ),
      body: TestWidget(),
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({required this.data, required Widget child})
      : super(child: child);
  //需要在⼦树中共享的数据，保存点击次数
  int data;

  static ShareDataWidget of(BuildContext context) {
    //return context.inheritFromWidgetOfExactType(ShareDataWidget);
    //点到BuildContext里面查看，确实没有inheritFromWidgetOfExactType方法
//经过一番查找，发现书写方式变了
//T? dependOnInheritedWidgetOfExactType({ Object? aspect });

    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>()
        as ShareDataWidget;
  }

  @override
  bool updateShouldNotify(ShareDataWidget old) {
    // TODO: implement updateShouldNotify
    return old.data != data;
  }
}

//然后我们实现⼀个⼦widget _TestWidget，在其build⽅法中引⽤ShareDataWidget中的数据；
//同时，在 其 didChangeDependencies() 回调中打印⽇志：
class TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestWidgetState();
  }
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //⽗或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调⽤。
    //如果build中没有依赖InheritedWidget，则此回调不会被调⽤。
    print("didChangeDependencies");
  }
}
//最后，我们创建⼀个按钮，每点击⼀次，就将ShareDataWidget的值⾃增：

class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InheritedWidgetTestRouteState();
  }
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("inheritedWidget"),
      ),
      body: Center(
      child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: TestWidget(),
            ),
            RaisedButton(
              child: Text("Increment"),
              onPressed: () {
                setState(() {
                  count++;
                });
              },
            )
          ],
        ),
      ),
    ),
    );
  }
}

//InheritedWidget 示例2
//创建以一个Model,用于保存当前计数值
class InheritedTestModel {
  final int count;
  const InheritedTestModel(this.count);
}

//创建一个InheritedWidget
class InheritedContext extends InheritedWidget {
  //数据
  final InheritedTestModel inheritedTestModel;
  //点击+号的方法
  final Function() increment;
  //点击-号的方法
  final Function() reduce;
  InheritedContext({
    Key? key,
    required this.inheritedTestModel,
    required this.increment,
    required this.reduce,
    required Widget child,
  }) : super(key: key, child: child);

  static InheritedContext of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedContext>() as InheritedContext;
  }

  //是否重建Widget就取决于数据是否相同
  @override
  bool updateShouldNotify(covariant InheritedContext oldWidget) {
    // TODO: implement updateShouldNotify
    return inheritedTestModel != oldWidget.inheritedTestModel;
  }
}

class TestWidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final inheritedWidget = InheritedContext.of(context);
    // print("inheritedWidget:$inheritedWidget");
    /*
      When the exception was thrown, this was the stack
      #0      InheritedContext.of
              lib/funtionWidget1.dart:150
      #1      TestWidgetA.build
l       ib/funtionWidget1.dart:165       
    */
    final inheritedTestModel = inheritedWidget.inheritedTestModel;
    print("TestWidgetA中count值:${inheritedTestModel.count}");
    return new Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      child: RaisedButton(
        onPressed: inheritedWidget.increment,
        textColor: Colors.black,
        child: Text("+"),
      ),
    );
  }
}

class TestWidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final inheritedWidget = InheritedContext.of(context);
    final inheritedTestModel = inheritedWidget.inheritedTestModel;
    print("TestWidgetB中count值:${inheritedTestModel.count}");
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      child: Text(
        "当前count值:${inheritedTestModel.count}",
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}

class TestWidgetC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final inheritedWidget = InheritedContext.of(context);
    final inheritedTestModel = inheritedWidget.inheritedTestModel;
    print('TestWidgetC中count的值:${inheritedTestModel.count}');
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      child: RaisedButton(
        textColor: Colors.black,
        child: Text("-"),
        onPressed: inheritedWidget.reduce
      ),
    );
  }
}

//4、组合
class InheritedWidgetTestContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InheritedWidgetTestContainerState();
  }
}

class _InheritedWidgetTestContainerState
    extends State<InheritedWidgetTestContainer> {
  InheritedTestModel inheritedTestModel = InheritedTestModel(0);
  _initData() {
    inheritedTestModel = InheritedTestModel(0);
  }

  @override
  void initState() {
    // TODO: implement initState
    _initData();
    super.initState();
  }

  _incrementCount() {
    setState(() {
      inheritedTestModel = InheritedTestModel(inheritedTestModel.count + 1);
    });
  }

  _reduceCount() {
    setState(() {
      inheritedTestModel = InheritedTestModel(inheritedTestModel.count - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InheritedContext(
      inheritedTestModel: inheritedTestModel,
      increment: _incrementCount,
      reduce: _reduceCount,
      child: Scaffold(
        appBar: AppBar(
          title: Text("InheritedWidgetTest"),
        ),
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: new Text(
                '我们常使用的\nTheme.of(context).textTheme\nMediaQuery.of(context).size等\n就是通过InheritedWidget实现的',
                style: new TextStyle(fontSize: 20.0),
              ),
            ),
            TestWidgetA(),
            TestWidgetB(),
            TestWidgetC()
          ],
        ),
      ),
    );
  }
}
/*
  总结
实现InheritedWidget，在updateShouldNotify()方法里写通过什么条件会触发提醒
通过context.dependOnInheritedWidgetOfExactType()方法，既让子 Child 可以访问到数据，同时也起到了把子 Child 自己的 Element 注册到InheritedWidget里。
当数据变更，触发到InheritedWidget实现类的update()方法的时候，它会遍历之前注册进来的 Element 列表，然后调用它们的didChangeDependencies()方法，接着 Framework 会调用build方法

*/