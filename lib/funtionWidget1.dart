import 'package:flutter/material.dart';

/*

  /**数据共享InheritedWidget**/
  InheritedWidget是Flutter中⾮常重要的⼀个功能型Widget，它可以⾼效的将数据在Widget树中向下传递、共享，
  这在⼀ 些需要在Widget树中共享数据的场景中⾮常⽅便，
  如Flutter中，正是通过InheritedWidget来共享应⽤主题(Theme)和 Locale(当前语⾔环境)信息的。
  InheritedWidget和React中的context功能类似，和逐级传递数据相⽐，它们能实现组件跨级传递数据。 
  InheritedWidget的在Widget树中数据传递⽅向是从上到下的，这和Notification的传递⽅向正好相反。

  didChangeDependencies
  在介绍StatefulWidget时，我们提到State对象有⼀个回调 didChangeDependencies ，
  它会在“依赖”发⽣变化时被Flutter Framework调⽤。⽽这个“依赖”指的就是是否使⽤了⽗widget中InheritedWidget的数据，
  如果使⽤了，则代表有依赖， 如果没有使⽤则代表没有依赖。这种机制可以使⼦组件在所依赖的主题、locale等发⽣变化时有机会来做⼀些事情。 
  我们看⼀下之前“计数器”示例应⽤程序的InheritedWidget版本，需要说明的是，本例主要是为了演示InheritedWidget的 功能特性，
  并不是计数器的推荐实现⽅式。
  
*/
// ⾸先，我们通过继承InheritedWidget，将当前计数器点击次数保存在ShareDataWidget的 data 属性中
class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({required this.data, Widget child}) : super(child: child);
  //需要在⼦树中共享的数据，保存点击次数
  int data;

  static ShareDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(ShareDataWidget);
  }

  @override
  bool updateShouldNotify(ShareDataWidget old) {
    // TODO: implement updateShouldNotify
    return old.data != data;
  }
}
