import 'dart:math';

import 'package:flutter/material.dart';

class ScrollableWidget5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("ScrollableWidget5"),
        ),
        /*
        滚动监听及控制 
        在前⼏节中，我们介绍了Flutter中常⽤的可滚动Widget，也说过可以⽤ScrollController来控制可滚动widget的滚动位 置，
        本节先介绍⼀下ScrollController，然后以ListView为例，展示⼀下ScrollController的具体⽤法。
        最后，再介绍⼀下 路由切换时如何来保存滚动位置。
        ScrollController 构造函数： ScrollController({ 
          double initialScrollOffset = 0.0, //初始滚动位置 
          this.keepScrollOffset = true,//是否保存滚动位置 ... 
          })
          offset ：可滚动Widget当前滚动的位置。 
          jumpTo(double offset) 、 animateTo(double offset,...) ：
          这两个⽅法⽤于跳转到指定的位置，它们不同之处在 于，
          后者在跳转时会执⾏⼀个动画，⽽前者不会。
          ScrollController还有⼀些属性和⽅法，我们将在后⾯原理部分解释。
          滚动监听 ScrollController间接继承⾃Listenable，我们可以根据ScrollController来监听滚动事件。
          如： controller.addListener(()=>print(controller.offset))
      */
        //示例我们创建⼀个ListView，当滚动位置发⽣变化时，我们先打印出当前滚动位置，
        //然后判断当前位置是否超过1000像素， 如果超过则在屏幕右下⻆显示⼀个“返回顶部”的按钮，
        //该按钮点击后可以使ListView恢复到初始位置；如果没有超过 1000像素，则隐藏“返回顶部”按钮。代码如下：
        body: //ScrollControllerTestRoute(),
            //由于列表项⾼度为50像素，当滑动到第20个列表项后，右下⻆“返回顶部”按钮会显示，
            //点击该按钮，ListView会在返回 顶部的过程中执⾏⼀个滚动动画，
            //动画时间是200毫秒，动画曲线是Curves.ease，关于动画的详细内容我们将在后 ⾯“动画”⼀章中详细介绍

            /*
      
        /***滚动位置恢复***/ 
        PageStorage是⼀个⽤于保存⻚⾯(路由)相关数据的Widget，它并不会影响⼦树的UI外观，
        其实，PageStorage是⼀个 功能型Widget，它拥有⼀个存储桶（bucket），⼦树中的Widget可以通过指定不同的PageStorageKey来存储各⾃的数 据或状态。 
        每次滚动结束，Scrollable Widget都会将滚动位置 offset 存储到PageStorage中，
        当Scrollable Widget 重新创建时再 恢复。如果 ScrollController.keepScrollOffset 为 false 
        ，则滚动位置将不会被存储，Scrollable Widget重新创建时会 
        使⽤ ScrollController.initialScrollOffset ； ScrollController.keepScrollOffset 为 true 时，
        Scrollable Widget在第 ⼀次创建时，
        会滚动到 initialScrollOffset 处，因为这时还没有存储过滚动位置。在接下来的滚动中就会存储、恢复 滚动位置，
        ⽽ initialScrollOffset 会被忽略。 当⼀个路由中包含多个Scrollable Widget时，
        如果你发现在进⾏⼀些跳转或切换操作后，滚动位置不能正确恢复，这时 你可以通过显式指定PageStorageKey来分别跟踪不同Scrollable Widget的位置，如：
        ListView(key: PageStorageKey(1), ... ); ... ListView(key: PageStorageKey(2), ... );
        不同的PageStorageKey，需要不同的值，这样才可以区分为不同Scrollable Widget保存的滚动位置。

        注意：⼀个路由中包含多个Scrollable Widget时，如果要分别跟踪它们的滚动位置，并⾮⼀定就得给他们分别提 供PageStorageKey。
        这是因为Scrollable本身是⼀个StatefulWidget，它的状态中也会保存当前滚动位置，
        所 以，只要Scrollable Widget本身没有被从树上detach掉，那么其State就不会销毁(dispose)，滚动位置就不会丢 失。
        只有当Widget发⽣结构变化，导致Scrollable Widget的State销毁或重新构建时才会丢失状态，
        这种情况就需 要显式指定PageStorageKey，通过PageStorage来存储滚动位置，⼀个典型的场景是在使⽤TabBarView时，
        在 Tab发⽣切换时，Tab⻚中的Scrollable Widget的State就会销毁，这时如果想恢复滚动位置就需要指定 PageStorageKey。
        ScrollPosition ⼀个ScrollController可以同时被多个Scrollable Widget使⽤，
        ScrollController会为每⼀个Scrollable Widget创建⼀个 ScrollPosition对象，
        这些ScrollPosition保存在ScrollController的 positions 属性中（List）。
        ScrollPosition是真正保存 滑动位置信息的对象， offset 只是⼀个便捷属性：
        double get offset => position.pixels;
        ⼀个ScrollController虽然可以对应多个Scrollable Widget，
        但是有⼀些操作，如读取滚动位置 offset ，则需要⼀对⼀， 但是我们仍然可以在⼀对多的情况下，通过其它⽅法读取滚动位置，
        举个例⼦，假设⼀个ScrollController同时被两个 Scrollable Widget使⽤，那么我们可以通过如下⽅式分别读取他们的滚动位置
        controller.positions.elementAt(0).pixels 
        controller.positions.elementAt(1).pixels
        ⽅法
        ScrollPosition有两个常⽤⽅法： animateTo() 和 jumpTo() ，
        它们是真正来控制跳转滚动位置的⽅法，ScrollController 的这两个同名⽅法，内部最终都会调⽤ScrollPosition的。

        /****ScrollController控制原理***/
        我们来介绍⼀下ScrollController的另外三个⽅法：
        ScrollPosition createScrollPosition( 
          ScrollPhysics physics,
           ScrollContext context, 
           ScrollPosition oldPosition); 
        void attach(ScrollPosition position) ; 
        void detach(ScrollPosition position) ;
        当ScrollController和Scrollable Widget关联时，
        Scrollable Widget⾸先会调⽤ScrollController 的 createScrollPosition() ⽅法来创建⼀个ScrollPosition来存储滚动位置信息，
        接着，Scrollable Widget会调 ⽤ attach() ⽅法，将创建的ScrollPosition添加到ScrollController的 positions 属性中，
        这⼀步称为“注册位置”，只有注 册后 animateTo() 和 jumpTo() 才可以被调⽤。当Scrollable Widget销毁时，
        会调⽤ScrollController的 detach() ⽅法， 将其ScrollPosition对象从ScrollController的 positions 属性中移除，
        这⼀步称为“注销位置”，注销后 animateTo() 和 jumpTo() 将不能再被调⽤。 
        需要注意的是，ScrollController的 animateTo() 和 jumpTo() 内部会调⽤所有ScrollPosition的 animateTo() 和 jumpTo() ，
        以实现所有和该ScrollController关联的Scrollable Widget都滚动到指定的位置
      */

            /*
        滚动监听 
        Flutter Widget树中⼦Widget可以通过发送通知（Notification）与⽗(包括祖先)Widget通信。
        ⽗Widget可以通过 NotificationListener Widget来监听⾃⼰关注的通知，这种通信⽅式类似于Web开发中浏览器的事件冒泡，
        我们在Flutter 中沿⽤“冒泡”这个术语。Scrollable Widget在滚动时会发送ScrollNotification类型的通知，
        ScrollBar正是通过监听滚动通 知来实现的。
        通过NotificationListener监听滚动事件和通过ScrollController有两个主要的不同： 
        1. 通过NotificationListener可以在从Scrollable Widget到Widget树根之间任意位置都能监听。
        ⽽ScrollController只能和 具体的Scrollable Widget关联后才可以。 
        2. 收到滚动事件后获得的信息不同；NotificationListener在收到滚动事件时，通知中会携带当前滚动位置和ViewPort 的⼀些信息，
        ⽽ScrollController只能获取当前滚动位置。

        NotificationListener NotificationListener是⼀个Widget，
        模板参数T是想监听的通知类型，如果省略，则所有类型通知都会被监听，如果指定 特定类型，则只有该类型的通知会被监听。
        NotificationListener需要⼀个onNotification回调函数，⽤于实现监听处理逻 辑，该回调可以返回⼀个布尔值，代表是否阻⽌该事件继续向上冒泡，
        如果为 true 时，则冒泡终⽌，事件停⽌向上传 播，如果不返回或者返回值为 false 时，则冒泡继续。
      
      */
            ScrollNotificationTestRoute());
  }
}

class ScrollControllerTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScrollControllerTestRouteState();
  }
}

class ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {
  ScrollController _controller = ScrollController();
  bool showToTopBtn = false;
  @override
  void initState() {
    // TODO: implement initState
    _controller.addListener(() {
      print(_controller.offset);
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      body: Scrollbar(
        child: ListView.builder(
          itemCount: 100,
          itemExtent: 50.0, //列表项⾼度固定时，显式指定⾼度是⼀个好习惯(性能消耗⼩)
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
            );
          },
        ),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                //返回到顶部时执⾏动画
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 300), curve: Curves.ease);
              },
            ),
    );
  }
}
//滚动监听的示例代码

class ScrollNotificationTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScrollNotificationTestRouteState();
  }
}

class _ScrollNotificationTestRouteState
    extends State<ScrollNotificationTestRoute> {
  String _progress = "0%";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scrollbar(
      //进度条
      //监听滚动通知
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          setState(() {
            _progress = "${(progress * 100).toInt()}";
          });
          return false;
          //return true;
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView.builder(
              itemCount: 100,
              itemExtent: 50.0,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                );
              },
            ),
            CircleAvatar(
              radius: 30.0,
              child: Text(_progress),
              backgroundColor: Colors.black54,
            )
          ],
        ),
      ),
    );
  }
}
