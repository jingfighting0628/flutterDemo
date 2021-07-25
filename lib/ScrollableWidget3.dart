import 'package:flutter/material.dart';

class ScrollableWidget3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView示例"),
      ),
      body:   /*
            GridView GridView可以构建⼀个⼆维⽹格列表，其默认构造函数定义如下
            GridView({ 
              Axis scrollDirection = Axis.vertical, 
              bool reverse = false, 
              ScrollController controller, 
              bool primary, 
              ScrollPhysics physics, 
              bool shrinkWrap = false, 
              EdgeInsetsGeometry padding, 
              @required SliverGridDelegate gridDelegate, //控制⼦widget layout的委托 
              bool addAutomaticKeepAlives = true,
               bool addRepaintBoundaries = true, double cacheExtent, 
               List<Widget> children = const <Widget>[], 
               })
               我们可以看到，GridView和ListView的⼤多数参数都是相同的，它们的含义也都相同，如有疑惑读者可以翻阅ListView ⼀节，在此不再赘述。
               我们唯⼀需要关注的是 gridDelegate 参数，类型是SliverGridDelegate，它的作⽤是控制 GridView⼦widget如何排列(layout)，SliverGridDelegate是⼀个抽象类，定义了GridView Layout相关接⼝，
               ⼦类需要通 过实现它们来实现具体的布局算法，
               Flutter中提供了两个SliverGridDelegate的⼦类 SliverGridDelegateWithFixedCrossAxisCount和SliverGridDelegateWithMaxCrossAxisExtent，下⾯我们分别介绍
               SliverGridDelegateWithFixedCrossAxisCount 
               该⼦类实现了⼀个纵轴为固定数量⼦元素的layout算法，其构造函数为：
               SliverGridDelegateWithFixedCrossAxisCount({ 
                 @required double crossAxisCount, 
                 double mainAxisSpacing = 0.0, 
                 double crossAxisSpacing = 0.0, 
                 double childAspectRatio = 1.0, 
                 })
                 crossAxisCount：纵轴⼦元素的数量。此属性值确定后⼦元素在纵轴的⻓度就确定了,即ViewPort纵轴⻓ 度/crossAxisCount。 
                 mainAxisSpacing：主轴⽅向的间距。 crossAxisSpacing：纵轴⽅向⼦元素的间距。 childAspectRatio：⼦元素在纵轴⻓度和主轴⻓度的⽐例。
                 由于crossAxisCount指定后⼦元素纵轴⻓度就确定了， 然后通过此参数值就可以确定⼦元素在主轴的⻓度。 
                 可以发现，⼦元素的⼤⼩是通过crossAxisCount和childAspectRatio两个参数共同决定的。
                 注意，这⾥的⼦元素指的是 ⼦widget的最⼤显示空间，注意确保⼦widget的实际⼤⼩不要超出⼦元素的空间。

          */
          //  GridView(
          //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //    crossAxisCount: 3,
          //    childAspectRatio: 1.0,
          //  ), 
          //  children: [
          //    Icon(Icons.ac_unit),
          //    Icon(Icons.airport_shuttle),
          //    Icon(Icons.all_inclusive),
          //    Icon(Icons.beach_access),
          //    Icon(Icons.cake),
          //    Icon(Icons.free_breakfast)
          //  ],
          // ),
          // GridView.count(
          //   crossAxisCount: 3,
          //   childAspectRatio: 1.0,
          //   children: [
          //     Icon(Icons.ac_unit),
          //     Icon(Icons.airport_shuttle),
          //     Icon(Icons.all_inclusive),
          //     Icon(Icons.beach_access),
          //     Icon(Icons.cake),
          //     Icon(Icons.free_breakfast)
          //   ],)
        //SliverGridDelegateWithMaxCrossAxisExtent 
        //该⼦类实现了⼀个纵轴⼦元素为固定最⼤⻓度的layout算法，其构造函数为：
        /*
          SliverGridDelegateWithMaxCrossAxisExtent({
             double maxCrossAxisExtent, 
             double mainAxisSpacing = 0.0, 
             double crossAxisSpacing = 0.0, 
             double childAspectRatio = 1.0, })
             maxCrossAxisExtent为⼦元素在纵轴上的最⼤⻓度，之所以是“最⼤”⻓度，是因为纵轴⽅向每个⼦元素的⻓度仍然是等 分的，
             举个例⼦，如果ViewPort的纵轴⻓度是450，那么当maxCrossAxisExtent的值在区间(450/4，450/3]内的话，
             ⼦ 元素最终实际⻓度都为150，⽽ childAspectRatio 所指的⼦元素纵轴和主轴的⻓度⽐为最终的⻓度⽐。
             其它参数和 SliverGridDelegateWithFixedCrossAxisCount相同
        */
        // GridView(
        //   padding: EdgeInsets.zero,
        //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: 120.0,
        //     childAspectRatio: 2.0
        //   ),
        //   children: [
        //     Icon(Icons.ac_unit),
        //     Icon(Icons.airport_shuttle),
        //     Icon(Icons.all_inclusive),
        //     Icon(Icons.beach_access),
        //     Icon(Icons.cake),
        //     Icon(Icons.free_breakfast),

        //   ],
        // )

        /*
          GridView.extent GridView.extent构造函数内部使⽤了SliverGridDelegateWithMaxCrossAxisExtent，
          我们通过它可以快速的创建纵轴⼦ 元素为固定最⼤⻓度的的GridView，上⾯的示例代码等价于：
          GridView.extent( 
            maxCrossAxisExtent: 120.0, 
            childAspectRatio: 2.0, 
            children: <Widget>[
               Icon(Icons.ac_unit), 
               Icon(Icons.airport_shuttle), 
               Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                 Icon(Icons.cake), 
                 Icon(Icons.free_breakfast), ], 
                 );
        */

        /*
          GridView.builder 上⾯我们介绍的GridView都需要⼀个Widget数组作为其⼦元素，
          这些⽅式都会提前将所有⼦widget都构建好，所以只适 ⽤于⼦Widget数量⽐较少时，
          当⼦widget⽐较多时，我们可以通过 GridView.builder 来动态创建⼦ Widget。
           GridView.builder 必须指定的参数有两个：
           GridView.builder( 
             ... 
             @required SliverGridDelegate gridDelegate, 
             @required IndexedWidgetBuilder itemBuilder,
              )
          其中itemBuilder为⼦widget构建器。
          示例假设我们需要从⼀个异步数据源（如⽹络）分批获取⼀些Icon，然后⽤GridView来展示：
        */
        InfiniteGridView(),
        //更多Flutter的GridView默认⼦元素显示空间是相等的，
        //但在实际开发中，你可能会遇到⼦元素⼤⼩不等的情况，如下⾯这样 的布局：
        //Pub上有⼀个包“flutter_staggered_grid_view” ，
        //它实现了⼀个交错GridView的布局模型，可以很轻松的实现这种布局， 详情读者可以⾃⾏了解

    );
  }
}

class InfiniteGridView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InfiniteGridViewState();
  }
}
class _InfiniteGridViewState extends State<InfiniteGridView>{

  List<IconData>_icons = [];//保存Icon数据
  @override
  void initState() {
    // TODO: implement initState
    _retrieveIcons();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0
      ), 
      itemBuilder: (BuildContext context,int index){

        //如果显示到最后⼀个并且Icon总数⼩于200时继续获取数据
        //在itemBuilder中，如果显示到最后⼀个时，判断是否需要继续获取数据，然后返回⼀个Icon。
        if(index == _icons.length - 1 && _icons.length < 200){
          _retrieveIcons();
        }

        return Icon(_icons[index]);

      });
  }
  //_retrieveIcons() ：在此⽅法中我们通过 Future.delayed 来模拟从异步数据源获取数据，每次获取数据需要200毫 秒，
  //获取成功后将新数据添加到_icons，然后调⽤setState重新构建。
  void _retrieveIcons(){
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      setState(() {
        _icons.addAll(
        [
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast,
        ]
        );
      });
    });


  }
}
