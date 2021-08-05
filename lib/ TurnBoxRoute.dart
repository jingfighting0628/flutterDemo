import 'package:flutter/material.dart';

/*实例：TurnBox */
//我们之前已经介绍过RotatedBox，但是它有两个缺点：⼀是只能将其⼦节点以90度的倍数旋转，⼆是当旋转的⻆度发 ⽣变化时，旋转⻆度更新过程没有动画。
//本节我们将实现⼀个TurnBox，它可以以任意⻆度来旋转其⼦节点，
//并且在⻆度发⽣变化时可以执⾏⼀个动画过渡到新 状态，同时，我们可以⼿动指定动画速度。 TurnBox的完整代码如下：

class TurnBox extends StatefulWidget {
  const TurnBox({Key? key, this.turns = .0, this.speed = 200,required this.child})
      : super(key: key);
  final double turns;
  final int speed;
  final Widget child;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TurnBoxState();
  }
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, lowerBound: double.infinity, upperBound: double.infinity);
    controller!.value = widget.turns;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RotationTransition(
      turns: controller!,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(covariant TurnBox oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      controller!.animateTo(widget.turns,
          duration: Duration(microseconds: widget.speed ?? 200),
          curve: Curves.easeOut);
    }
  }
}
//代码⽐较简单，我们主要是通过包装(组合)RotationTransition来实现的。 
//下⾯我们测试⼀下TurnBox的功能，测试代码如下：