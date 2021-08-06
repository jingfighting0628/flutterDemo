import 'package:flutter/material.dart';
import 'dart:math';
//对于⼀些复杂或不规则的UI，我们可能⽆法使⽤现有Widget组合的⽅式来实现，⽐如我们需要⼀个正六边形、⼀个渐变 的圆形进度条、⼀个棋盘等，
//当然有时候我们可以使⽤图⽚来实现，但在⼀些需要动态交互的场景静态图⽚是实现不了 的，
//⽐如要实现⼀个⼿写输⼊⾯板。这时，我们就需要来⾃⼰绘制UI外观。 ⼏乎所有的UI系统都会提供⼀个⾃绘UI的接⼝，
//这个接⼝通常会提供⼀块2D画布Canvas，Canvas内部封装了⼀些基本 绘制的API，开发者可以通过Canvas绘制各种⾃定义图形。
//在Flutter中，提供了⼀个CustomPaint Widget，
//它可以结合 ⼀个画笔CustomPainter来实现绘制⾃定义图形。
//CustomPaint
//我们看看CustomPaint构造函数：
/*
  const CustomPaint({ 
    Key key, 
    this.painter, 
    this.foregroundPainter, 
  this.size = Size.zero, 
  this.isComplex = false, 
  this.willChange = false, 
  Widget child, //⼦节点，可以为空 
  })
*/
//painter: 背景画笔，会显示在⼦节点后⾯;
//foregroundPainter: 前景画笔，会显示在⼦节点前⾯
//size：当child为null时，代表默认绘制区域⼤⼩，如果有child则忽略此参数，画布尺⼨则为child尺⼨。
//如果有child 但是想指定画布为特定⼤⼩，可以使⽤SizeBox包裹CustomPaint实现。
//isComplex：是否复杂的绘制，如果是，Flutter会应⽤⼀些缓存策略来减少重复渲染的开销。
//willChange：和isComplex配合使⽤，当启⽤缓存时，该属性代表在下⼀帧中绘制是否会改变。
//可以看到，绘制时我们需要提供前景或背景画笔，两者也可以同时提供。我们的画笔需要继承CustomPainter类，
//我们 在画笔类中实现真正的绘制逻辑。

//注意
//如果CustomPaint有⼦节点，为了避免⼦节点不必要的重绘并提⾼性能，通常情况下都会将⼦节点包裹在 RepaintBoundary Widget中，
//这样会在绘制时创建⼀个新的绘制层（Layer），其⼦Widget将在新的Layer上绘制，⽽⽗ Widget将在原来Layer上绘制，
//也就是说RepaintBoundary ⼦Widget的绘制将独⽴于⽗Widget的绘制，
// RepaintBoundary会隔离其⼦节点和CustomPaint本身的绘制边界。示例如下：
/*
  CustomPaint( size: Size(300, 300), //指定画布⼤⼩ 
  painter: MyPainter(), child: RepaintBoundary(child:...)),
   )
*/
//CustomPainter CustomPainter中提定义了⼀个虚函数 paint ：
//void paint(Canvas canvas, Size size);
//paint 有两个参数:
//Canvas：⼀个画布，包括各种绘制⽅法，我们列出⼀下常⽤的⽅法： |API名称 | 功能 | | ---------- | ------ | | drawLine | 画线 | | drawPoint | 画点 | | drawPath | 画路径 | | drawImage | 画图 像 | |
//drawRect | 画矩形 | | drawCircle | 画圆 | | drawOval | 画椭圆 | | drawArc | 画圆弧 |
//Size：当前绘制区域⼤⼩。

//画笔Paint
//现在画布有了，我们最后还缺⼀个画笔，Flutter提供了Paint类来实现画笔。
//在Paint中，我们可以配置画笔的各种属性 如粗细、颜⾊、样式等。如：
//var paint = Paint() //创建⼀个画笔并配置其属性
//..isAntiAlias = true //是否抗锯⻮
//..style = PaintingStyle.fill //画笔样式：填充
//..color=Color(0x77cdb175);//画笔颜⾊
//更多的配置属性读者可以参考Paint类定义。
//示例：五⼦棋/盘
//下⾯我们通过⼀个五⼦棋游戏中棋盘和棋⼦的绘制来演示⾃绘UI的过程，
//⾸先我们看⼀下我们的⽬标结果：

class CustomPaintRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("CustomPaintAndCanvas示例"),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(300, 300),
          painter: MyPainter(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0x77cdb175);
    canvas.drawRect(Offset.zero & size, paint);

    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black87
      ..strokeWidth = 1.0;
    for (int i = 0; i <= 15; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
    for (int i = 0; i <= 15; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }
    //画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
        Offset(size.width / 2 + eWidth / 2, size.height / 2 - eHeight / 2),
        min(eWidth / 2, eHeight / 2) - 2,
        paint);
    //画一个黑子
    paint ..style = PaintingStyle.fill ..color = Colors.black; 
    canvas.drawCircle( Offset(size.width / 2 - eWidth / 2, 
    size.height / 2 - eHeight / 2), min(eWidth / 2, eHeight / 2) - 2, paint, );


        
  }

  //在实际场景中正确利⽤此回调可以避免重绘开销，本示例我们简单的返回true 
  @override bool shouldRepaint(CustomPainter oldDelegate) => true;

}
//
/*性能*/
//绘制是⽐较昂贵的操作，所以我们在实现⾃绘控件时应该考虑到性能开销，下⾯是两条关于性能优化的建议： 
//尽可能的利⽤好 shouldRepaint 返回值；在UI树重新build时，控件在绘制前都会先调⽤该⽅法以确定是否有必要重 绘；
//加⼊我们绘制的UI不依赖外部状态，那么就应该始终返回false，因为外部状态改变导致重新build时不会影响我 们的UI外观；
//如果绘制依赖外部状态，那么我们就应该在shouldRepaint中判断依赖的状态是否改变，如果已改变 则应返回 true 来重绘，
//反之则应返回 false 不需要重绘。 绘制尽可能多的分层；在上⾯五⼦棋的示例中，我们将棋盘和棋⼦的绘制放在了⼀起，
//这样会有⼀个问题：由于棋 盘始终是不变的，⽤户每次落⼦时变的只是棋⼦，但是如果按照上⾯的代码来实现，
//每次绘制棋⼦时都要重新绘制 ⼀次棋盘，这是没必要的。优化的⽅法就是将棋盘单独抽为⼀个Widget，
//并设置其 shouldRepaint 回调值为false， 
//然后将棋盘Widget作为背景。然后将棋⼦的绘制放到另⼀个Widget中，这样落⼦时只需要绘制棋⼦。

/*总结*/
//⾃绘控件⾮常强⼤，理论上可以实现任何2D图形外观，实际上Flutter提供的所有Widget最终都是调⽤Canvas绘制出来 的，
//只不过绘制的逻辑被封装起来了，读者有兴趣可以查看具有外观样式的Widget的源码，找到其对应的 RenderObject对象，
//如Text Widget最终会通过RenderParagraph对象来通过Canvas实现⽂本绘制逻辑。
// 下⼀节我们再通过实现⼀个⾃绘的圆形渐变进度条的实例来帮助读者加深印象。