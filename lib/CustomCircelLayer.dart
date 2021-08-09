import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_app01/TurnBox.dart';
//实例：圆形渐变进度条(⾃绘) 本节我们实现⼀个圆形渐变进度条，它⽀持： 1. ⽀持多种渐变⾊。
//2. 任意弧度；整个进度可以不是整圆。
// 3. 可以⾃定义粗细、两端是否圆⻆等样式。
// 可以发现要实现这样的⼀个进度条是⽆法通过现有组件组合⽽成的，所以我们通过⾃绘⽅式实现。
// 实现代码如下：

class GradinetCircularProgressRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GradinetCircularProgressRouteState();
  }
}

class _GradinetCircularProgressRouteState
    extends State<GradinetCircularProgressRoute> with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    bool isForword = true;
    animationController!.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForword = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForword) {
          animationController!.reverse();
        } else {
          animationController!.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForword = false;
      }
    });
    animationController!.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("圆形进度条示例(自绘)"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: animationController!,
              builder: (ctx, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 16.0,
                        children: [
                          GradientCicularProgressIndicator(
                              radius: 50.0,
                              colors: [Colors.red, Colors.orange],
                              stokeWidth: 3.0,
                              value: animationController!.value,
                              backgroundColor: Colors.black,),
                          GradientCicularProgressIndicator(
                            radius: 50.0 , 
                            stokeWidth: 3.0,
                            colors: [Colors.red,Colors.orange], 
                            value: animationController!.value,
                            backgroundColor: Colors.black,),
                          GradientCicularProgressIndicator(
                            radius: 50.0, 
                            stokeWidth: 5.0,
                            colors: [Colors.red,Colors.orange], 
                            value: animationController!.value,
                            backgroundColor: Colors.black,),
                            GradientCicularProgressIndicator(
                              radius: 50.0 , 
                              stokeWidth: 5.0,
                              colors: [Colors.teal,Colors.cyan], 
                              value: CurvedAnimation(
                                parent: animationController!,
                                curve: Curves.decelerate
                              ).value,
                              backgroundColor: Colors.black,),
                              TurnBox(
                                turns: 1/8,
                                child: GradientCicularProgressIndicator(
                                  colors: [Colors.red,Colors.orange,Colors.red],
                                  radius: 8.0,
                                  stokeWidth: 5.0,
                                  strokeCapRound: true,
                                  backgroundColor: Colors.black,
                                  totalAngle: 1.5 * pi,
                                  value: CurvedAnimation(
                                    parent: animationController!,
                                    curve: Curves.ease
                                  ).value,
                                  
                                ),
                              ),
                              RotatedBox(
                                quarterTurns: 1,
                                child: GradientCicularProgressIndicator(
                                  colors: [Colors.blue,Colors.blueAccent],
                                  radius: 50.0,
                                  stokeWidth: 3.0,
                                  strokeCapRound: true,
                                  backgroundColor: Colors.orange,
                                  value: animationController!.value,
                                  
                                ),
                              ),
                              GradientCicularProgressIndicator(
                                radius: 50.0,
                                stokeWidth: 5.0, 
                                colors: [
                                  Colors.red,
                                Colors.amber,
                                Colors.cyan,
                                Colors.green,
                                Colors.blue,
                                Colors.red], 
                                strokeCapRound: true,
                                value: animationController!.value,
                                backgroundColor: Colors.black,),
                            GradientCicularProgressIndicator(
                              radius: 100.0,
                              stokeWidth: 20.0, 
                              colors: [Colors.lightBlue,Colors.blueAccent], 
                              value: animationController!.value,
                              backgroundColor: Colors.black,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: GradientCicularProgressIndicator(
                                colors: [Colors.blueAccent,Colors.lightBlue],
                                radius: 100.0,
                                stokeWidth: 20.0,
                                value: animationController!.value,
                                strokeCapRound: true,
                                backgroundColor: Colors.red,
                              ),
                            ),
                            //剪裁半圆
                            ClipRRect(
                              child: Align(
                                alignment: Alignment.topCenter,
                                heightFactor: 5,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: SizedBox(
                                    child: TurnBox(
                                      turns: .75,
                                      child: GradientCicularProgressIndicator(
                                        colors: [Colors.teal,Colors.cyanAccent],
                                        radius: 100.0,
                                        stokeWidth: 8.0,
                                        value: animationController!.value,
                                        totalAngle: pi,
                                        strokeCapRound: true,
                                        backgroundColor: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 104,
                              width: 200.0,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    height: 200.0,
                                    top: .0,
                                    child: TurnBox(
                                      turns: .75,
                                      child: GradientCicularProgressIndicator(
                                        colors: [Colors.teal,Colors.cyan],
                                        radius: 100.0,
                                        stokeWidth: 8.0,
                                        value: animationController!.value,
                                        totalAngle: pi,
                                        strokeCapRound: true,
                                        backgroundColor: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:10.0 ),
                                    child: Text(
                                      "${(animationController!.value * 100).toInt()}%",
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.blueGrey
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class GradientCicularProgressIndicator extends StatelessWidget {
  GradientCicularProgressIndicator(
      {this.stokeWidth = 2.0,
      required this.radius,
      required this.colors,
      this.stops,
      this.strokeCapRound = false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.totalAngle = 2 * pi,
      required this.value});

  ///粗细
  final double stokeWidth;

  /// 圆的半径
  final double radius;

  ///两端是否为圆⻆
  final bool strokeCapRound;
  // 当前进度，取值范围 [0.0-1.0]
  final double value;

  /// 进度条背景⾊
  final Color backgroundColor;

  /// 进度条的总弧度，2*PI为整圆，⼩于2*PI则不是整圆
  final double totalAngle;

  /// 渐变⾊数组
  final List<Color> colors;

  /// 渐变⾊的终⽌点，对应colors属性
  final List<double>? stops;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double _offset = .0;
    // 如果两端为圆⻆，则需要对起始位置进⾏调整，否则圆⻆部分会偏离起始位置 // 下⾯调整的⻆度的计算公式是通过数学⼏何知识得出，读者有兴趣可以研究⼀下为什么是这样
    if (strokeCapRound) {
      _offset = asin(stokeWidth / (radius * 2 - stokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).accentColor;
      _colors = [color, color];
    }
    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
            stokeWidth: stokeWidth,
            backgroundColor: backgroundColor,
            value: value,
            total: totalAngle,
            radius: radius,
            colors: _colors),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter(
      {this.stokeWidth: 10.0,
      this.strokeCapRound: false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      required this.radius,
      this.total = 2 * pi,
      required this.colors,
      this.stops,
      required this.value});

  final double stokeWidth;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double radius;
  final List<double>? stops;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    if (radius != null) {
      size = Size.fromRadius(radius);
    }
    double _offset = stokeWidth / 2.0;
    double _value = (value ?? .0);
    _value = _value.clamp(.0, .1) * total;
    double _start = .0;
    if (strokeCapRound) {
      _start = asin(stokeWidth / (size.width - stokeWidth));
    }
    Rect rect = Offset(_offset, _offset) &
        Size(size.width - stokeWidth, size.height - stokeWidth);

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }
    //再画前景，应用渐变
    if (_value > 0) {
      paint.shader = SweepGradient(
        startAngle: 0.0,
        endAngle: _value,
        colors: colors,
        stops: stops,
      ).createShader(rect);
    }
    canvas.drawArc(rect, _start, _value, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
