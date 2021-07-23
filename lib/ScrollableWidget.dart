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
*/
class ScrollableWidget extends StatelessWidget {


  
}
