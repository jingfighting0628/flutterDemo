import 'package:flutter/material.dart';

//上⾯AnimationWidget类示例代码中 addListener() 函数调⽤了 setState() ，所以每次动画⽣成⼀个新的数字时，当前帧被标记为脏(dirty)，
//这 会导致widget的 build() ⽅法再次被调⽤，⽽在 build() 中，改变Image的宽⾼，
//因为它的⾼度和宽度现在使⽤的 是 animation.value ，所以就会逐渐放⼤。
//值得注意的是动画完成时要释放控制器(调⽤ dispose() ⽅法)以防⽌内存泄 漏。
//上⾯的例⼦中并没有指定Curve，所以放⼤的过程是线性的（匀速），下⾯我们指定⼀个Curve，来实现⼀个类似于弹 簧效果的动画过程，
//我们只需要将 initState 中的代码改为下⾯这样即可

//使⽤AnimatedWidget简化 细⼼的读者可能已经发现上⾯示例中通过 addListener() 和 setState() 来更新UI这⼀步其实是通⽤的，
//如果每个动画 中都加这么⼀句是⽐较繁琐的。AnimatedWidget类封装了调⽤ setState() 的细节，
//并允许我们将Widget分离出来，重 构后的代码如下：

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

class ScaleAnimationRoute1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScaleAnimationRouteState1();
  }
}

class _ScaleAnimationRouteState1 extends State<ScaleAnimationRoute1>
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
    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("动画1"),
        ),
        //⽤AnimatedBuilder重构

        //⽤AnimatedWidget可以从动画中分离出widget，
//⽽动画的渲染过程（即设置宽⾼）仍然在AnimatedWidget中，
//假设如 果我们再添加⼀个widget透明度变化的动画，那么我们需要再实现⼀个AnimatedWidget，这样不是很优雅，
//如果我们能 把渲染过程也抽象出来，那就会好很多，⽽AnimatedBuilder正是将渲染逻辑分离出来,
//body的AnimatedImage中的代码可以改 为：
        body:
            // AnimatedImage(
            //   animation: animation!,
            // ),
            //这样，最初的示例就可以改为：
            
            AnimatedBuilder(
          animation: animation!,
          child: Image.asset("image/duola.jpeg"),
          builder: (ctx, child) {
            return Center(
              child: Container(
                height: animation!.value,
                width: animation!.value,
                child: child,
              ),
            );
          },
        )
        
          // GrowTransition(
          //   child: Image.asset("image/duola.jpeg"),
          //   animation: animation!,
          // )
        );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }
}
//上⾯的代码中有⼀个迷惑的问题是， child 看起来像被指定了两次。但实际发⽣的事情是：将外部引⽤child传递给 AnimatedBuilder后AnimatedBuilder再将其传递给匿名构造器， 然后将该对象⽤作其⼦对象。最终的结果是 AnimatedBuilder返回的对象插⼊到Widget树中。 也许你会说这和我们刚开始的示例差不了多少，其实它会带来三个好处：
// 1. 不⽤显式的去添加帧监听器，然后再调⽤ setState() 了，这个好处和AnimatedWidget是⼀样的。
//2. 动画构建的范围缩⼩了，如果没有builder，setState()将会在⽗widget上下⽂调⽤，这将会导致⽗widget的build⽅法 重新调⽤，
//⽽有了builder之后，只会导致动画widget的build重新调⽤，这在复杂布局下性能会提⾼。
//3. 通过AnimatedBuilder可以封装常⻅的过渡效果来复⽤动画。下⾯我们通过封装⼀个GrowTransition来说明，
//它可以 对⼦widget实现放⼤动画：

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
//Flutter中正是通过这种⽅式封装了很多动画，
//如：FadeTransition、ScaleTransition、SizeTransition、 FractionalTranslation等，
//很多时候都可以复⽤这些预置的过渡类。