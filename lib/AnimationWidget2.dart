import 'package:flutter/material.dart';

//动画监听
//上⾯说过，我们可以通过Animation的 addStatusListener() ⽅法来添加动画状态改变监听器。
//Flutter中，有四种动画状 态，在AnimationStatus枚举类中定义，下⾯我们逐个说明：
/*
枚举值            含义
dismissed    动画在起始点停⽌ 
forward      动画正在正向执⾏ 
reverse      动画正在反向执⾏ 
completed    动画在终点停⽌
*/

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Image.asset(
        "image/duola.jpeg",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class ScaleAnimationRoute2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScaleAnimationRouteState2();
  }
}

class _ScaleAnimationRouteState2 extends State<ScaleAnimationRoute2>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    //图片从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller!);
    animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执⾏结束时反向执⾏动画
        //要在controller加上强制解包，因为controller是可选值
        controller!.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执⾏动画（正向）
        controller!.forward();
      }
    });
    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("动画2"),
        ),
        body: GrowTransition(
          child: Image.asset("image/duola.jpeg"),
          animation: animation!,
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({required this.child, required this.animation});
  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (ctx, child) {
          return Container(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
      ),
    );
  }
}
