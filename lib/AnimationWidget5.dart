import 'package:flutter/material.dart';

//交错动画
//有些时候我们可能会需要⼀些复杂的动画，这些动画可能由⼀个动画序列或重叠的动画组成，
//⽐如：有⼀个柱状图，需 要在⾼度增⻓的同改变颜⾊，等到增⻓到最⼤⾼度后，我们需要在X轴上平移⼀段距离。这时我们就需要使⽤交错动画
//（Stagger Animation）。交错动画需要注意以下⼏点：
//1. 要创建交错动画，需要使⽤多个动画对象
//2. ⼀个AnimationController控制所有动画
//3. 给每⼀个动画对象指定间隔（Interval） 所有动画都由同⼀个AnimationController驱动，⽆论动画实时持续多⻓时间，控制器的值必须介于0.0和1.0之间，
//⽽每 个动画的间隔（Interval）介于0.0和1.0之间。对于在间隔中设置动画的每个属性，请创建⼀个Tween。
//Tween指定该 属性的开始值和结束值。也就是说0.0到1.0代表整个动画过程，我们可以给不同动画指定起始点和终⽌点来决定它们的 开始时间和终⽌时间。
//示例下⾯我们看⼀个例⼦，实现⼀个柱状图增⻓的动画： 1. 开始时⾼度从0增⻓到300像素，同时颜⾊由绿⾊渐变为红⾊；这个过程占据整个动画时间的60%。
//2. ⾼度增⻓到300后，开始沿X轴向右平移100像素；这个过程占⽤整个动画时间的40%。 我们将执⾏动画的Widget分离出来：

    
/*
class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key? key,  this.controller}) : super(key: key) {
    height = Tween<double>(
      begin: 0,
      end: 300.0,
    ).animate(CurvedAnimation(parent: controller!, curve: Interval(
       //间隔，前60%的动画时间
      0.0,0.6,
      curve: Curves.ease
    )));
    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(CurvedAnimation(parent: controller!, curve: Interval(
      //间隔，前60%的动画时间
      0.0,0.6,
      curve: Curves.ease
    )));
    padding = Tween<EdgeInsets>(
            begin: EdgeInsets.only(left: .0), end: EdgeInsets.only(left: 100.0))
        .animate(CurvedAnimation(
      parent: controller!,
      curve: Interval(
        //间隔，后40%的动画时间
        0.6, 1.0, 
        curve: Curves.ease
        ),
    ));
  }
  final Animation<double>? controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color?> color;
  
  Widget _buildAnimation(BuildContext context,Widget? child){
  return Container(
        alignment: Alignment.bottomCenter,
        padding: padding.value,
        child: Container(
          color: color.value,
          width: 50.0,
          height: height.value,
        ),
      );
}
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
        builder: _buildAnimation(),
        animation: controller!,
      ),
  }
  
}
*/

