import 'package:flutter/material.dart';
import 'dart:math' as math;

class containerWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("容器类WIdget1"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 64,
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            //默认原点为左上⻆，左移20像素，向上平移5像素
            child: Transform.translate(
              offset: Offset(-20.0, -5.0),
              child: Text("Hello world"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.rotate(
              angle: math.pi / 2,
              child: Text("Hello world"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.scale(
              scale: 1.5,
              child: Text("Hellow world"),
            ),
          ),
          /*
          Transform的变换是应⽤在绘制阶段，⽽并不是应⽤在布局(layout)阶段，所以⽆论对⼦widget应⽤何种变化，
          其占 ⽤空间的⼤⼩和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。下⾯我们具体说明：
          */
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.red
                ),
                child: Transform.scale(
                  scale: 1.5,
                  child: Text("Hello world"),
                ),
              ),
              Text("你好",style: TextStyle(color: Colors.green,fontSize: 18.0),)
            ],
            //由于第⼀个Text应⽤变换(放⼤)后，其在绘制时会放⼤，
            //但其占⽤的空间依然为红⾊部分，所以第⼆个text会紧挨着 红⾊部分，最终就会出现⽂字有重合部分
            //由于矩阵变化只会作⽤在绘制阶段，所以在某些场景下，在UI需要变化时，可以直接通过矩阵变化来达到视觉上的 UI改变，
            //⽽不需要去重新触发build流程，这样会节省layout的开销，所以性能会⽐较好。如之前介绍的Flow widget，
            //它内部就是⽤矩阵变换来更新UI，除此之外，Flutter的动画widget中也⼤量使⽤了Transform以提⾼性能。

            

          ),
          //RotatedBox
            //RotatedBox和Transform.rotate功能相似，它们都可以对⼦widget进⾏旋转变换，但是有⼀点不同：RotatedBox的变换 是在layout阶段，会影响在⼦widget的位置和⼤⼩。
            //我们将上⾯介绍Transform.rotate时的示例改⼀下
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.red
                ),
                child: RotatedBox(
                  quarterTurns: 1,//旋转90度(1/4圈)
                  child: Text("Hello world",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                ),
              ),
              Text("你好",style: TextStyle(color: Colors.green,fontSize: 18.0),)
            ],
          ),
          //由于RotatedBox是作⽤于layout阶段，所以widget会旋转90度（⽽不只是绘制的内容），
          //decoration会作⽤到widget所 占⽤的实际空间上，所以就是上图的效果。
          //读者可以和前⾯Transform.rotate示例对⽐理解。



          //Container 
          //Container是我们要介绍的最后⼀个容器类widget，它本身不对应具体的RenderObject，
          //它是DecoratedBox、 ConstrainedBox、Transform、Padding、Align等widget的⼀个组合widget。
          //所以我们只需通过⼀个Container可以实现 同时需要装饰、变换、限制的场景。下⾯是Container的定义
          /*
            Container({ 
              this.alignment, 
              this.padding, //容器内补⽩，属于decoration的装饰范围 
              Color color, // 背景⾊ 
              Decoration decoration, // 背景装饰
               Decoration foregroundDecoration, //前景装饰 
               double width,//容器的宽度 
               double height, //容器的⾼度 
               BoxConstraints constraints, //容器⼤⼩的限制条件 
               this.margin,//容器外补⽩，不属于decoration的装饰范围 
               this.transform, //变换 
               this.child, 
               })
               ⼤多数属性在介绍其它容器时都已经介绍过了，不再赘述，但有两点需要说明： 容器的⼤⼩可以通过 width 、 height 属性来指定，
               也可以通过 constraints 来指定，如果同时存在 时， width 、 height 优先。
               实际上Container内部会根据 width 、 height 来⽣成⼀个 constraints 。 
               color 和 decoration 是互斥的，实际上，当指定color时，Container内会⾃动创建⼀个decoration
          */
          Container(
            margin: EdgeInsets.only(top: 50.0,left: 120.0), //容器外补⽩
            constraints: BoxConstraints.tightFor(width: 200.0,height: 150.0),//卡片大小
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.red,Colors.orange],
                center: Alignment.center,
                radius: .98
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0,2.0),
                  blurRadius: 4.0
                )
              ]
            ),
            //Matrix4是⼀个4D矩阵
            transform: Matrix4.rotationZ(.2),
            alignment: Alignment.center,
            child: Text(
              "5.20",
              style: TextStyle(color: Colors.white,fontSize:40.0 ),
            ),
          ),
          //可以看到Container通过组合多种widget来实现复杂强⼤的功能，
          //在Flutter中，这也正是组合优先于继承的实例。


          //Padding和Margin
          //接下来我们看看Container的ma
          Container(
            margin: EdgeInsets.all(20.0),
            color: Colors.orange,
            child: Text("Hello world"),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.blueAccent,
            child: Text("Hello world"),
          ),
          //可以发现，直观的感觉就是margin的补⽩是在容器外部，⽽padding的补⽩是在容器内部，读者需要记住这个差异。
          //事 实上，Container内 margin 和 padding 都是通过Padding widget来实现的，上⾯的示例代码实际上等价于
          /*
          ...
            Padding( padding: EdgeInsets.all(20.0),
             child: DecoratedBox( decoration: BoxDecoration(color: Colors.orange), 
             child: Text("Hello world!"), ), ),DecoratedBox(decoration: BoxDecoration(color: Colors.orange), 
             child: Padding( padding: const EdgeInsets.all(20.0), child: Text("Hello world!"),
              ),),
          ...
          */
          SizedBox(
            height: 35,
          ),
          Container(
            color: Colors.black,
            child: Transform(
              alignment: Alignment.topRight,
              transform: Matrix4.skewY(0.3),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.deepOrange,
                child: Text("Apartment for rent!"),
              ),
            ),
          ),
          



        ],
      ),
    );
  }
}
