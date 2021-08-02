import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_app01/funtionWidget1.dart';
//动画
//在任何系统的UI框架中，动画实现的原理都是相同的，即：在⼀段时间内，快速地多次改变UI外观，
//由于⼈眼会产⽣视 觉暂留，最终看到的就是⼀个“连续”的动画，这和电影的原理是⼀样的，
//⽽UI的⼀次改变称为⼀个动画帧，对应⼀次屏 幕刷新，⽽决定动画流畅度的⼀个重要指标就是帧率FPS（Frame Per Second），
//指每秒的动画帧数。很明显，帧率 越⾼则动画就会越流畅。⼀般情况下，对于⼈眼来说，动画帧率超过16FPS，就⽐较流畅了，
//超过32FPS就会⾮常的细 腻平滑，⽽超过32FPS基本就感受不到差别了。由于动画的每⼀帧都是要改变UI输出，
//所以在⼀个时间段内连续的改变 UI输出是⽐较耗资源的，对设备的软硬件系统要求都较⾼，
//所以在UI系统中，动画的平均帧率是重要的性能指标，
//⽽在 Flutter中，理想情况下是可以实现60FPS的，这和原⽣应⽤动画基本是持平的。
//Flutter中动画抽象
//为了⽅便开发者创建动画，不同的UI系统对动画都进⾏了⼀些抽象，⽐如在Android中可以通过XML来描述⼀个动画然 后设置给View。
//Flutter中也对动画进⾏了抽象，主要涉及Tween、Animation、Curve、Controller这些⻆⾊。

//Animation
//Animation对象本身和UI渲染没有任何关系。Animation是⼀个抽象类，它⽤于保存动画的插值和状态；
//其中⼀个⽐较常 ⽤的Animation类是Animation。Animation对象是⼀个在⼀段时间内依次⽣成⼀个区间(Tween)之间值的类。
//Animation 对象的输出值可以是线性的、曲线的、⼀个步进函数或者任何其他曲线函数。 根据Animation对象的控制⽅式，
//动画可 以反向运⾏，甚⾄可以在中间切换⽅向。Animation还可以⽣成除double之外的其他类型值，
//如：Animation\ 或 Animation\。可以通过Animation对象的 value 属性获取动画的当前值。
//动画通知 我们可以通过Animation来监听动画的帧和状态变化：
//1. addListener() 可以给Animation添加帧监听器，在每⼀帧都会被调⽤。帧监听器中最常⻅的⾏为是改变状态后调⽤ setState()来触发UI重建。
//2. addStatusListener() 可以给Animation添加“动画状态改变”监听器；动画开始、结束、正向或反向（⻅ AnimationStatus定义）时会调⽤StatusListener。
// 在后⾯的章节中我们将会举例说明。

//Curve
//动画过程可以是匀速的、加速的或者先加速后减速等。
//Flutter中通过Curve（曲线）来描述动画过程，Curve可以是线性 的(Curves.linear)，也可以是⾮线性的。
//CurvedAnimation 将动画过程定义为⼀个⾮线性曲线

//final CurvedAnimation curve = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
//注: Curves 类类定义了许多常⽤的曲线，也可以创建⾃⼰的，例如：
/*
class ShakeCurve extends Curve 
{ 
  @override double transform(double t) 
  { 
    return math.sin(t * math.PI * 2); 
  } 
}
*/
//CurvedAnimation和AnimationController（下⾯介绍）都是Animation类型。
//CurvedAnimation可以通过包装 AnimationController和Curve⽣成⼀个新的动画对象 。

//AnimationController
//AnimationController⽤于控制动画，它包含动画的启动 forward() 、停⽌ stop() 、反向播放 reverse() 等⽅法。 AnimationController会在动画的每⼀帧，就会⽣成⼀个新的值。默认情况下，AnimationController在给定的时间段内线 性的⽣成从0.0到1.0（默认区间）的数字。
//例如，下⾯代码创建⼀个Animation对象，但不会启动它运⾏：
// final AnimationController controller = new AnimationController(
//   duration: const Duration(milliseconds: 2000),
//   vsync: this);
//AnimationController⽣成数字的区间可以通过 lowerBound 和 upperBound 来指定，如：
/*
final AnimationController controller = new AnimationController( 
  duration: const Duration(milliseconds: 2000), 
  lowerBound: 10.0, upperBound: 20.0, 
  vsync: this 
  );
*/
//AnimationController派⽣⾃Animation，因此可以在需要Animation对象的任何地⽅使⽤。
//但是，AnimationController具 有控制动画的其他⽅法，例如 forward() ⽅法可以启动动画。数字的产⽣与屏幕刷新有关，
//因此每秒钟通常会产⽣60个 数字(即60fps)，在动画的每⼀帧，⽣成新的数字后，每个Animation对象会调⽤其Listener对象回调，
//等动画状态发⽣改 变时（如动画结束）会调⽤StatusListeners监听器。
//duration表示动画执⾏的时⻓，通过它我们可以控制动画的速度。
//注意： 在某些情况下，动画值可能会超出AnimationController的0.0-1.0的范围。
//例如， fling() 函数允许您提供 速度(velocity)、⼒量(force)等，因此可以在0.0到1.0范围之外。
//CurvedAnimation⽣成的值也可以超出0.0到1.0的 范围。根据选择的曲线，CurvedAnimation的输出可以具有⽐输⼊更⼤的范围。
//例如，Curves.elasticIn等弹性曲 线会⽣成⼤于或⼩于默认范围的值。

//Ticker 当创建⼀个AnimationController时，需要传递⼀个 vsync 参数，它接收⼀个TickerProvider类型的对象，
//它的主要职责 是创建Ticker，定义如下：
// abstract class TickerProvider {
// //通过⼀个回调创建⼀个
// Ticker Ticker createTicker(TickerCallback onTick);
// }
//Flutter应⽤在启动时都会绑定⼀个SchedulerBinding，通过SchedulerBinding可以给每⼀次屏幕刷新添加回调，
//⽽Ticker 就是通过SchedulerBinding来添加屏幕刷新回调，这样⼀来，每次屏幕刷新都会调⽤TickerCallback。
//使⽤Ticker(⽽不 是Timer)来驱动动画会防⽌屏幕外动画（动画的UI不在当前屏幕时，如锁屏时）消耗不必要的资源，
//因为Flutter中屏幕 刷新时会通知到绑定的SchedulerBinding，⽽Ticker是受SchedulerBinding驱动的，
//由于锁屏后屏幕会停⽌刷新，所以 Ticker就不会再触发。 通过将SingleTickerProviderStateMixin添加到State的定义中，
//然后将State对象作为 vsync 的值，这在后⾯的例⼦中可 以⻅到。
//Tween 默认情况下，AnimationController对象值的范围是0.0到1.0。如果我们需要不同的范围或不同的数据类型，
//则可以使⽤ Tween来配置动画以⽣成不同的范围或数据类型的值。
//例如，像下⾯示例，Tween⽣成从-200.0到0.0的值：
//final Tween doubleTween = new Tween<double>(begin: -200.0, end: 0.0);
//Tween构造函数需要 begin 和 end 两个参数。Tween的唯⼀职责就是定义从输⼊范围到输出范围的映射。
//输⼊范围通 常为0.0到1.0，但这不是必须的，我们可以⾃定义需要的范围。 Tween继承⾃Animatable，
//⽽不是继承⾃Animation。Animatable与Animation相似，不是必须输出double值。
//例如， ColorTween指定两种颜⾊之间的过渡。
//final Tween colorTween = new ColorTween(begin: Colors.transparent, end: Colors.black54);
//Tween对象不存储任何状态，相反，它提供了 evaluate(Animation<double> animation) ⽅法，
//它可以获取动画当前值。 Animation对象的当前值可以通过 value() ⽅法取到。 evaluate 函数还执⾏⼀些其它处理，
//例如分别确保在动画值为 0.0和1.0时返回开始和结束状态。

//Tween.animate
//要使⽤Tween对象，需要调⽤其 animate() ⽅法，然后传⼊⼀个控制器对象。
//例如，以下代码在500毫秒内⽣成从0到 255的整数值。
/*
final AnimationController controller = new AnimationController( 
duration: const Duration(milliseconds: 500), vsync: this); 
Animation<int> alpha = new IntTween(begin: 0, end: 255).animate(controller
);*/
//注意 animate() 返回的是⼀个Animation，⽽不是⼀个Animatable。
//以下示例构建了⼀个控制器、⼀条曲线和⼀个Tween：
/*
final AnimationController controller = new AnimationController(
    duration: const Duration(microseconds: 800), vsync: this);
final Animation curve =
    CurvedAnimation(parent: controller, curve: Curves.easeOut);

Animation<int> alpha = IntTween(begin: 0, end: 255).animate(curve);
*/
//动画基本结构
//我们通过实现一个图片逐渐放大的示例来演示一下flutter中动画的基本结构

class ScaleAnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScaleAnimationRouteState();
  }
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使⽤TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller!, curve: Curves.bounceIn);
    //图片宽高从0为300
    animation = Tween(
      begin: 0.0,
      end: 300.0,
    ).animate(controller!)
      ..addListener(() {
        setState(() {});
      });
    //启动动画(正向执⾏)
    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("动画"),
      ),
      body: Center(
        child: Image.asset(
          "image/duola.jpeg",
          width: animation!.value,
          height: animation!.value,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }
}
