import 'package:flutter/material.dart';

/*⾃定义Widget⽅法简介*/
//当Flutter提供的现有Widget⽆法满⾜我们的需求，或者我们为了共享代码需要封装⼀些通⽤Widget，这时我们就需要⾃ 定义Widget。
//在Flutter中⾃定义Widget有三种⽅式：通过组合其它Widget、⾃绘和实现RenderObject，本节我们先分 别介绍⼀下这三种⽅式的特点，
//后⾯章节中则详细介绍它们的细节。

/*组合其它Widget */
//这种⽅式是通过拼装其它低级别的Widget来组合成⼀个⾼级别的Widget，例如我们之前介绍的Container就是⼀个组合 Widget，
//它是由DecoratedBox、ConstrainedBox、Transform、Padding、Align等组成。 在Flutter中，组合的思想⾮常重要，
//Flutter提供了⾮常多的基础Widget，⽽我们的界⾯开发都是按照需要组合这些 Widget来实现各种不同的布局。

/*⾃绘*/
//如果遇到⽆法通过系统提供的现有Widget实现的UI时，如我们需要⼀个渐变圆形进度条，
//⽽Flutter提供的 CircularProgressIndicator并不⽀持在显示精确进度时对进度条应⽤渐变⾊（其 valueColor 属性只⽀持执⾏旋转动画时 变化Indicator的颜⾊），
//这时最好的⽅法就是通过⾃定义Widget绘制逻辑来画出我们期望的外观。Flutter中提供了 CustomPaint和Canvas供我们⾃绘UI外观。
//
/*实现RenderObject*/
//Flutter提供的任何具有UI外观的Widget，如⽂本Text、Image都是通过相应的RenderObject渲染出来的，
//如Text是由 RenderParagraph渲染，⽽Image是由RenderImage渲染。
//RenderObject是⼀个抽象类，它定义了⼀个抽象⽅ 法 paint(...) :
//void paint(PaintingContext context, Offset offset)

//PaintingContext代表Widget的绘制上下⽂，通过 PaintingContext.canvas 可以获得Canvas，绘制逻辑主要是通过 Canvas API来实现。
//⼦类需要实现此⽅法以实现⾃身的绘制逻辑，
//如RenderParagraph需要实现⽂本绘制逻辑，⽽ RenderImage需要实现图⽚绘制逻辑。 可以发现，RenderObject中最终也是通过Canvas来绘制的，
//那么通过实现RenderObject的⽅式和上⾯介绍的通过 CustomPaint和Canvas⾃绘的⽅式有什么区别？其实答案很简单，
//CustomPaint只是为了⽅便开发者封装的⼀个代理 类，它直接继承⾃SingleChildRenderObjectWidget，
//通过RenderCustomPaint的paint⽅法将Canvas和画笔Painter(需 要开发者实现，后⾯章节介绍)连接起来实现了最终的绘制（绘制逻辑在Painter中）。
/*总结*/
//组合是⾃定义组件最简单的⽅法，在任何需要⾃定义的场景下，都应该优先考虑是否能够通过组合来实现。
//⽽⾃绘和通 过实现RenderObject的⽅法本质上是⼀样的，都需要开发者调⽤Canvas API⼿动去绘制UI，缺点时必须了解Canvas API，
//并且得⾃⼰去实现绘制逻辑，⽽优点是强⼤灵活，理论上可以实现任何外观的UI。 在本章接下来的⼩节中，我们将通过⼀些实例来详细介绍⾃定义UI的过程，
//由于后两种⽅法本质是相同的，后续我们只 介绍CustomPaint和Canvas的⽅式，读者如果对⾃定义RenderObject的⽅法好奇，
//可以查看RenderParagraph或 RenderImage源码。

/*1、通过组合现有Widget实现⾃定义Widget*/
//在Flutter中⻚⾯UI通常都是由⼀些低阶别的Widget组合⽽成，当我们需要封装⼀些通⽤Widget时，
//应该⾸先考虑是否可 以通过组合其它Widget来实现，如果可以则应优先使⽤组合，因为直接通过现有Widget拼装会⾮常⽅便、简单、⾼效。
//示例：⾃定义渐变按钮 Flutter Widget库中的按钮默认不⽀持渐变背景，
//为了实现渐变背景按钮，我们⾃定义⼀个GradientButton Widget。我 们先来看看效果：

class GradientButton extends StatelessWidget {
  GradientButton(
      {this.colors, this.width, this.height, this.onTap, required this.child});
  // 渐变⾊数组
  final List<Color>? colors;
  // 按钮宽⾼
  final double? width;
  final double? height;
  final Widget? child;
  //点击回调
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ThemeData themeData = Theme.of(context);
    List<Color> _colors = colors ??
        [
          themeData.primaryColor,
          themeData.primaryColorDark ?? themeData.primaryColor
        ];
    return DecoratedBox(
      decoration: BoxDecoration(gradient: LinearGradient(colors: _colors)),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: colors!.last,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child!,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//可以看到GradientButton是由Padding、Center、InkWell等Widget组合⽽成。当然上⾯的代码只是⼀个示例，
//作为⼀个 按钮它还并不完整，⽐如没有禁⽤状态、不能定义圆⻆等，读者可以根据实际需要来完善。
//使⽤GradientButton

class GradientButtonRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义Widget"),
      ),
      body: Container(
        child: Column(
          children: [
            GradientButton(
              colors: [Colors.orange, Colors.red],
              height: 50.0,
              child: Text("Submit"),
              onTap: onTap,
            ),
            GradientButton(
              height: 50.0,
              colors: [Colors.lightGreen, Color(0xFF388E3C)],
              child: Text("Submit"),
              onTap: onTap,
            ),
            GradientButton(
              height: 50.0,
              colors: [Colors.lightBlue, Colors.blueAccent],
              child: Text("Submit"),
              onTap: onTap,
            )
          ],
        ),
      ),
    );
  }

  onTap() {
    print("button Click");
  }
}
/*总结*/
//通过组合的⽅式定义Widget和我们之前写界⾯并⽆差异，不过在抽离出单独的Widget时我们要考虑代码规范性，
//如必要 参数要⽤ @required 标注，对于可选参数在特定场景需要判空或设置默认值等。这是由于使⽤者⼤多时候可能不了解 Widget的内部细节，
//所以为了保证代码健壮性，我们需要在⽤户错误地使⽤Widget时能够兼容或报错提示（使⽤assert 断⾔函数）。
