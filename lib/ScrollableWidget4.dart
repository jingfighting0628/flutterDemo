import 'package:flutter/material.dart';

class ScrollableWidget4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("CustomScrollView"),
        ),
        body:
            /*
        CustomScrollView CustomScrollView是可以使⽤sliver来⾃定义滚动模型（效果）的widget。
        它可以包含多种滚动模型，举个例⼦，假设 有⼀个⻚⾯，顶部需要⼀个GridView，底部需要⼀个ListView，
        ⽽要求整个⻚⾯的滑动效果是统⼀的，即它们看起来是 ⼀个整体，
        如果使⽤GridView+ListView来实现的话，就不能保证⼀致的滑动效果，因为它们的滚动效果是分离的，
        所 以这时就需要⼀个"胶⽔"，把这些彼此独⽴的可滚动widget（Sliver）"粘"起来，
        ⽽CustomScrollView的功能就相当于“胶 ⽔”

        Sliver
        有细⽚、⼩⽚之意，在Flutter中，Sliver通常指具有特定滚动效果的可滚动块。可滚动widget，
        如ListView、 GridView等都有对应的Sliver实现如SliverList、SliverGrid等。对于⼤多数Sliver来说，
        它们和可滚动Widget最主要的区 别是Sliver不会包含Scrollable Widget，也就是说Sliver本身不包含滚动交互模型 ，正因如此，
        CustomScrollView才可以 将多个Sliver"粘"在⼀起，这些Sliver共⽤CustomScrollView的Scrollable，最终实现统⼀的滑动效果。
        Sliver系列Widget⽐较多，我们不会⼀⼀介绍，读者只需记住它的特点，需要时再去查看⽂档即可。
        上⾯之所以 说“⼤多数“Sliver都和可滚动Widget对应，是由于还有⼀些如SliverPadding、SliverAppBar等是和可滚动Widget⽆ 关的，
        它们主要是为了结合CustomScrollView⼀起使⽤，这是因为CustomScrollView的⼦widget必须都是 Sliver。
      */
            CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Demo"),
                background: Image.asset(
                  "image/duola.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: new SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 4.0),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    //创建子Widget

                    return Container(
                      alignment: Alignment.center,
                      color: Colors.cyan[100 * (index % 9)],
                      child: Text("grid item $index"),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ),
            SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  //创建列表项
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text("list item $index"),
                  );
                },
                //50个列表项
                childCount: 50
                ),
                itemExtent: 50.0
                )
          ],
        )
        //代码分为三部分： 
        //头部SliverAppBar：SliverAppBar对应AppBar，两者不同之处在于SliverAppBar可以集成到CustomScrollView。 SliverAppBar可以结合FlexibleSpaceBar实现Material Design中头部伸缩的模型，具体效果，读者可以运⾏该示例 查看。 
        //中间的SliverGrid：它⽤SliverPadding包裹以给SliverGrid添加补⽩。SliverGrid是⼀个两列，宽⾼⽐为4的⽹格，它 有20个⼦widget。 
        //底部SliverFixedExtentList：它是⼀个所有⼦元素⾼度都为50像素的列表
        
        );
  }
}
