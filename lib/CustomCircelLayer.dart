import 'package:flutter/material.dart';
import 'dart:math';
//实例：圆形渐变进度条(⾃绘) 本节我们实现⼀个圆形渐变进度条，它⽀持： 1. ⽀持多种渐变⾊。
//2. 任意弧度；整个进度可以不是整圆。
// 3. 可以⾃定义粗细、两端是否圆⻆等样式。
// 可以发现要实现这样的⼀个进度条是⽆法通过现有组件组合⽽成的，所以我们通过⾃绘⽅式实现。
// 实现代码如下：

class GradientCicularProgressIndicator extends StatelessWidget {
  GradientCicularProgressIndicator(
      {this.stokeWidth = 2.0,
      required this.radius,
      required this.colors,
      this.stops,
      this.stroleCapRound = false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.totalAngle = 2 * pi,
      this.value});

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
  final List<double> stops;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double _offet = .0;
    // 如果两端为圆⻆，则需要对起始位置进⾏调整，否则圆⻆部分会偏离起始位置 // 下⾯调整的⻆度的计算公式是通过数学⼏何知识得出，读者有兴趣可以研究⼀下为什么是这样 
    if (strokeCapRound) { 
      _offset = asin(stokeWidth / (radius * 2 - stokeWidth));
    }
  }
}
