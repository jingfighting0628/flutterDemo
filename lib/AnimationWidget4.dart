import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//Hero动画
//Hero指的是可以在路由(⻚⾯)之间“⻜⾏”的widget，简单来说Hero动画就是在路由切换时，有⼀个共享的Widget可以在 新旧路由间切换，
//由于共享的Widget在新旧路由⻚⾯上的位置、外观可能有所差异，所以在路由切换时会逐渐过渡，这 样就会产⽣⼀个Hero动画。
//你可能多次看到过 hero 动画。例如，⼀个路由中显示待售商品的缩略图列表，选择⼀个条⽬会将其跳转到⼀个新路 由，新路由中包含该商品的详细信息和“购买”按钮。
//在Flutter中将图⽚从⼀个路由“⻜”到另⼀个路由称为hero动画，尽 管相同的动作有时也称为 共享元素转换。
//下⾯我们通过⼀个示例来体验⼀下hero 动画。 示例假设有两个路由A和B，他们的内容交互如下：
//A：包含⼀个⽤户头像，圆形，点击后跳到B路由，可以查看⼤图。
//B：显示⽤户头像原图，矩形；
//在AB两个路由之间跳转的时候，⽤户头像会逐渐过渡到⽬标路由⻚的头像上，接下来我们先看看代码，然后再解析：

class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero动画"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: InkWell(
          child: Hero(
            tag: "Avatar",
            child: ClipOval(
              child: Image.asset(
                "image/duola.jpeg",
                width: 50.0,
              ),
            ),
          ),
          onTap: () {
            Navigator.push(context, PageRouteBuilder(pageBuilder:
                (BuildContext context, Animation<double> animation,
                    Animation SecondAnimation) {
              return FadeTransition(
                opacity: animation,
                child: CupertinoPageScaffold(
                  child: HeroAnimationRouteB(),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero动画"),
      ),
      body: Center(
      child: Hero(
        tag: "Avatar",
        child: Image.asset("image/duola.jpeg"),
      ),
    ),
    );
  }
}
//我们可以看到，实现Hero动画只需要⽤Hero Widget将要共享的Widget包装起来，并提供⼀个相同的tag即可，中间的过 渡帧都是Flutter Framework⾃动完成的。
//必须要注意， 前后路由⻚的共享Hero的tag必须是相同的，Flutter Framework 内部正式通过tag来对应新旧路由⻚Widget的对应关系的。 
//Hero动画的原理⽐较简单，Flutter Framework知道新旧路由⻚中共享元素的位置和⼤⼩，
//所以根据这两个端点，在动 画执⾏过程中求出过渡时的插值即可，幸运的是，这些事情Flutter已经帮我们做了。
