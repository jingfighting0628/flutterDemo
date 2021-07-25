import 'package:flutter/material.dart';

/*
  当内容超过显示视⼝(ViewPort)时，如果没有特殊处理，Flutter则会提示Overflow错误。
  为此，Flutter提供了多种可滚 动widget（Scrollable Widget）⽤于显示列表和⻓布局。
  在本章中，我们先介绍⼀下常⽤的可滚动widget（如 ListView、GridView等），然后介绍⼀下Scrollable与可滚动widget的原理。
  可滚动Widget都直接或间接包含⼀个 Scrollable widget，因此它们包括⼀些共同的属性，为了避免重复介绍，我们在此统⼀介绍⼀下：
  Scrollable({ 
    ...
    //滚动⽅向
     this.axisDirection = AxisDirection.down,
    /*
      ：此属性接受⼀个ScrollController对象。ScrollController的主要作⽤是控制滚动位置和监听滚动事件。
      默 认情况下，widget树中会有⼀个默认的PrimaryScrollController，
      如果⼦树中的可滚动widget没有显式的指 定 controller 并且 primary 属性值为 true 时（默认就为 true ），
      可滚动widget会使⽤这个默认的 PrimaryScrollController，这种机制带来的好处是⽗widget可以控制⼦树中可滚动widget的滚动，
      例如，Scaffold使 ⽤这种机制在iOS中实现了"回到顶部"的⼿势。我们将在本章后⾯“滚动控制”⼀节详细介绍ScrollController。
    */
    this.controller, 
     //此属性接受⼀个ScrollPhysics对象，它决定可滚动Widget如何响应⽤户操作，
     //⽐如⽤户滑动完抬起⼿指 后，继续执⾏动画；或者滑动到边界时，如何显示。默认情况下，
     //Flutter会根据具体平台分别使⽤不同的 ScrollPhysics对象，应⽤不同的显示效果，
     //如当滑动到边界时，继续拖动的话，在iOS上会出现弹性效果，⽽在 Android上会出现微光效果。
     //如果你想在所有平台下使⽤同⼀种效果，可以显式指定，Flutter SDK中包含了两个 ScrollPhysics的⼦类可以直接使⽤： 
    this.physics,
    @required this.viewportBuilder,//后⾯介绍
    }) 
Scrollbar Scrollbar是⼀个Material⻛格的滚动指示器（滚动条），如果要给可滚动widget添加滚动条，只需将Scrollbar作为可滚 动widget的⽗widget即可，如：
Scrollbar( 
  child: SingleChildScrollView( ... ), 
  );
  Scrollbar和CupertinoScrollbar都是通过ScrollController来监听滚动事件来确定滚动条位置，
  关于ScrollController详细的 内容我们将在后⾯专⻔⼀节介绍

  CupertinoScrollbar 
  CupertinoScrollbar是iOS⻛格的滚动条，如果你使⽤的是Scrollbar，
  那么在iOS平台它会⾃动切换为 CupertinoScrollbar。

  ViewPort视⼝ 在很多布局系统中都有ViewPort的概念，在Flutter中，术语ViewPort（视⼝），
  如⽆特别说明，则是指⼀个Widget的实 际显示区域。
  例如，⼀个ListView的显示区域⾼度是800像素，虽然其列表项总⾼度可能远远超过800像素，但是其 ViewPort仍然是800像素。
  主轴和纵轴 在可滚动widget的坐标描述中，通常将滚动⽅向称为主轴，⾮滚动⽅向称为纵轴。由于可滚动widget的默认⽅向⼀般都 是沿垂直⽅向，
  所以默认情况下主轴就是指垂直⽅向，⽔平⽅向同理。
  SingleChildScrollView SingleChildScrollView类似于Android中的ScrollView，它只能接收⼀个⼦Widget。定义如下：
  SingleChildScrollView({ 
    this.scrollDirection = Axis.vertical, //滚动⽅向，默认是垂直⽅向 
    this.reverse = false, 
    this.padding,
     bool primary,
      this.physics, 
      this.controller, 
      this.child, 
      })
  除了通⽤属性，我们重点看⼀下 reverse 和 primary 两个属性： 
  reverse：该属性API⽂档解释是：是否按照阅读⽅向相反的⽅向滑动，
  如： scrollDirection 值 为 Axis.horizontal ，如果阅读⽅向是从左到右(取决于语⾔环境，阿拉伯语就是从右到左)，
  reverse为 true 时， 那么滑动⽅向就是从右往左。其实此属性本质上是决定可滚动widget的初始滚动位置是在“头”还是“尾”，
   取 false 时，初始滚动位置在“头”，反之则在“尾”，读者可以⾃⼰试验。 primary：指是否使⽤widget树中默认的PrimaryScrollController；
  当滑动⽅向为垂直⽅向（ scrollDirection 值 为 Axis.vertical ）并且 controller 没有指定时， primary 默认为 true .

  示例下⾯是⼀个将⼤写字⺟A-Z沿垂直⽅向显示的例⼦，由于垂直⽅向空间不够，所以使⽤SingleChildScrollView。



*/
class SingleChildScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String str = "ABCDEFGHIJKMNOPQRSTUVWXYZ";
    return Scaffold(
      appBar: AppBar(
        title: Text("可滚动Widget"),
      ),
      body: Scrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: str
                .split("")
                .map((e) => Text(
                      e,
                      textScaleFactor: 2.0,
                    ))
                .toList(),
          ),
        ),
      ),
    ),
    );
  }
}
