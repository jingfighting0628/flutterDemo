import 'package:flutter/material.dart';

//自定义路由切换动画
//Material库中提供了⼀个MaterialPageRoute，它可以使⽤和平台⻛格⼀致的路由切换动画，如在iOS上会左右滑动切 换，
//⽽在Android上会上下滑动切换。
//如果在Android上也想使⽤左右切换⻛格，可以直接使⽤CupertinoPageRoute, 如：
//Navigator.push(context, CupertinoPageRoute
//(
//builder: (context){ return PageB(); //路由B }
//));
//如果想⾃定义路由切换动画，可以使⽤PageRouteBuilder，
//例如我们想以渐隐渐⼊动画来实现路由过渡：
//Navigator.push(context, PageRouteBuilder(
//transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
//pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation)
//{
//return new
//FadeTransition( //使⽤渐隐渐⼊过渡,
// opacity: animation,
//child: PageB(); //路由B );
//})); }),
//我们可以看到 pageBuilder 有⼀个animation参数，这是Flutter路由管理器提供的，在路由切换时 pageBuilder
//在每个动 画帧都会被回调，因此我们可以通过animation对象来⾃定义过渡动画。
//⽆论是MaterialPageRoute、CupertinoPageRoute，还是PageRouteBuilder，它们都继承⾃PageRoute类
//，⽽ PageRouteBuilder其实只是PageRoute的⼀个包装，我们可以直接继承PageRoute类来实现⾃定义路由，
//上⾯的例⼦可 以通过如下⽅式实现：

class FadeRoute extends PageRoute 
{ FadeRoute
({ required this.builder, 
this.transitionDuration = const Duration(milliseconds: 300), 
this.opaque = true, this.barrierDismissible = false,  required
this.barrierColor,required this.barrierLabel, 
this.maintainState = true, }); 
  final WidgetBuilder builder; 
  @override final Duration transitionDuration;
  @override final bool opaque;
  @override final bool barrierDismissible; 
  @override final Color barrierColor; 
  @override final String barrierLabel; 
  @override final bool maintainState;
  @override Widget buildPage(
    BuildContext context, Animation<double> animation, 
    Animation<double> secondaryAnimation) => builder(context); 
    @override Widget buildTransitions(BuildContext context, Animation<double> animation, 
    Animation<double> secondaryAnimation, Widget child) { 
      return FadeTransition( opacity: animation, child: builder(context), 
    ); 
    } 
}
//使⽤FadeRoute 
//Navigator.push(context, FadeRoute(builder: (context) { return PageB(); 
//}));
//虽然上⾯的两种⽅法都可以实现⾃定义切换动画，但实际使⽤时应考虑优先使⽤PageRouteBuilder，这样⽆需定义⼀个 新的路由类，
//使⽤起来会⽐较⽅便。但是有些时候PageRouteBuilder是不能满⾜需求的，例如在应⽤过渡动画时我们需 要读取当前路由的⼀些属性，
//这时就只能通过继承PageRoute的⽅式了，举个例⼦，假如我们只想在打开新路由时应⽤ 动画，
//⽽在返回时不使⽤动画，那么我们在构建过渡动画时就必须判断当前路由 isActive 属性是否为true，代码如下：
//@override Widget buildTransitions(
//BuildContext context, Animation<double> animation, 
//Animation<double> secondaryAnimation, Widget child) 
//{ //当前路由被激活，是打开新路由 if(isActive) { 
//return FadeTransition( opacity: animation, child: builder(context), ); }
//else{ //是返回，则不应⽤过渡动画 
//return Padding(padding: EdgeInsets.zero); 
//}}