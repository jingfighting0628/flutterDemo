import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
/*
  ListView ListView是最常⽤的可滚动widget，它可以沿⼀个⽅向线性排布所有⼦widget。我们看看ListView的默认构造函数定义：
  ListView({ 
    ... //可滚动widget公共参数 Axis scrollDirection = Axis.vertical, 
    bool reverse = false,
     ScrollController controller, 
     bool primary, 
     ScrollPhysics physics, 
     EdgeInsetsGeometry padding,
      //ListView各个构造函数的共同参数 
      //double itemExtent, 
      //bool shrinkWrap = false, 
      //bool addAutomaticKeepAlives = true, 
      //bool addRepaintBoundaries = true, 
      //double cacheExtent, 
  //⼦widget列表 List<Widget> 
  //children = const <Widget>[], 
  //}) 

  上⾯参数分为两组：第⼀组是可滚动widget公共参数，前⾯已经介绍过，不再赘述；第⼆组是ListView各个构造函数 
  （ListView有多个构造函数）的共同参数，我们重点来看看这些参数，： 
  itemExtent：该参数如果不为null，则会强制children的"⻓度"为itemExtent的值；这⾥的"⻓度"是指滚动⽅向上⼦ widget的⻓度，即如果滚动⽅向是垂直⽅向，则itemExtent代表⼦widget的⾼度，
  如果滚动⽅向为⽔平⽅向，则 itemExtent代表⼦widget的⻓度。
  在ListView中，指定itemExtent⽐让⼦widget⾃⼰决定⾃身⻓度会更⾼效，这是因 为指定itemExtent后，滚动系统可以提前知道列表的⻓度，⽽不是总是动态去计算，尤其是在滚动位置频繁变化时 （滚动系统需要频繁去计算列表⾼度）。 
  shrinkWrap：该属性表示是否根据⼦widget的总⻓度来设置ListView的⻓度，默认值为 false 。
  默认情况下， ListView的会在滚动⽅向尽可能多的占⽤空间。
  当ListView在⼀个⽆边界(滚动⽅向上)的容器中时，shrinkWrap必须 为 true 。 
  addAutomaticKeepAlives：该属性表示是否将列表项（⼦widget）包裹在AutomaticKeepAlive widget中；
  典型地， 在⼀个懒加载列表中，如果将列表项包裹在AutomaticKeepAlive中，在该列表项滑出视⼝时该列表项不会被GC， 它会使⽤KeepAliveNotification来保存其状态。
  如果列表项⾃⼰维护其KeepAlive状态，那么此参数必须置 为 false 。 
  
  addRepaintBoundaries：该属性表示是否将列表项（⼦widget）包裹在RepaintBoundary中。
  当可滚动widget滚动 时，将列表项包裹在RepaintBoundary中可以避免列表项重绘，但是当列表项重绘的开销⾮常⼩（如⼀个颜⾊块， 或者⼀个较短的⽂本）时，不添加RepaintBoundary反⽽会更⾼效。
  和addAutomaticKeepAlive⼀样，如果列表项 ⾃⼰维护其KeepAlive状态，那么此参数必须置为 false 。

  默认构造函数 默认构造函数有⼀个 children 参数，它接受⼀个Widget列表（List）。
  这种⽅式适合只有少量的⼦widget的情况，因为 这种⽅式需要将所有 children 都提前创建好（这需要做⼤量⼯作），⽽不是等到⼦widget真正显示的时候再创建。
  实 际上通过此⽅式创建的ListView和使⽤SingleChildScrollView+Column的⽅式没有本质的区别。下⾯是⼀个例⼦
  ListView( shrinkWrap: true, 
  adding: const EdgeInsets.all(20.0), 
  children: <Widget>[ ListView
ListViewconst Text('I\'m dedicating every day to you'), 
const Text('Domestic life was never quite my style'), 
const Text('When you smile, you knock me out, I fall apart'), 
const Text('And I thought I was so smart'), ], );

ListView.builder ListView.builder 适合列表项⽐较多（或者⽆限）的情况，因为只有当⼦Widget真正显示的时候才会被创建。
下⾯看⼀ 下ListView.builder的核⼼参数列表：
ListView.builder({
   // ListView公共参数已省略 ... 
   //@required IndexedWidgetBuilder itemBuilder, int itemCount, 
   //... })
   })
   itemBuilder：它是列表项的构建器，类型为IndexedWidgetBuilder，返回值为⼀个widget。
   当列表滚动到具体的 index位置时，会调⽤该构建器构建列表项。 
   itemCount：列表项的数量，如果为null，则为⽆限列表。
*/

class ScrollableWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(
      color: Colors.blue,
    );
    Widget divider2 = Divider(
      color: Colors.green,
    );
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("可滚动Widget2"),
      ),
      body:
          //  ListView(
          //       shrinkWrap: true,
          //       padding: EdgeInsets.all(20.0),
          //       children: [
          //         Text("I am dedicating every day to you"),
          //         Text("'Domestic life was never quite my styleu"),
          //         Text("When you smile, you knock me out, I fall apart"),
          //         Text("And I thought I was so smart"),
          //       ],
          //     ),
          // ListView.builder(
          //   //列表项的数量，如果为null，则为⽆限列表
          //   itemCount: 100,
          //   itemExtent: 50.0, //强制高度为50.0
          //   //它是列表项的构建器，类型为IndexedWidgetBuilder，返回值为⼀个widget。
          //   //当列表滚动到具体的 index位置时，会调⽤该构建器构建列表项
          //   itemBuilder: (BuildContext context, int index) {
          //     return ListTile(title: Text("$index"),);
          //   },
          // ),
          //ListView.separated ListView.separated 可以⽣成列表项之间的分割器，
          //它除了⽐ ListView.builder 多了⼀个 separatorBuilder 参数，
          //该参 数是⼀个分割器⽣成器。
          //下⾯我们看⼀个例⼦：奇数⾏添加⼀条蓝⾊下划线，偶数⾏添加⼀条绿⾊下划线
          // ListView.separated(
          //     itemBuilder: (BuildContext context, int index) {
          //       return ListTile(
          //         title: Text("$index"),
          //       );
          //     },
          //     separatorBuilder: (BuildContext context, int index) {
          //       return index % 2 == 0 ? divider1 : divider2;
          //     },
          //     itemCount: 100),

          InfiniteListView(),
      /*
            本节主要介绍了ListView的⼀些公共参数以及常⽤的构造函数。不同的构造函数对应了不同的列表项⽣成模型，如果需 要⾃定义列表项⽣成模型，可以通过 ListView.custom 来⾃定义，它需要实现⼀个SliverChildDelegate⽤来给ListView⽣ 成列表项widget，更多详情请参考API⽂档
          */
    );
  }
}

class InfiniteListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InfiniteListViewState();
  }
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];
  @override
  void initState() {
    // TODO: implement initState
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
      itemCount: _words.length,
      itemBuilder: (BuildContext context, int index) {
        //如果到了表尾
        if (_words[index] == loadingTag) {
          if (_words.length - 1 < 100) {
            //获取数据
            _retrieveData();
            return Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Text(
                "没有更多了",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
        }
        return ListTile(
          title: Text(_words[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: .0,
        );
      },
      // itemCount: null
    );
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      _words.insertAll(_words.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
    });
    setState(() {});
  }
}
