import 'dart:math' as math;

import 'package:flutter/material.dart';

class containerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("容器类Widget"),
      ),
      body: Center(
        /*
          容器类Widget和布局类Widget都作⽤于其⼦Widget，不同的是： 布局类Widget⼀般都需要接收⼀个widget数组（children），
          他们直接或间接继承⾃（或包含） MultiChildRenderObjectWidget ；⽽容器类Widget⼀般只需要接受⼀个⼦Widget（child），
          他们直接或间接继承⾃ （或包含）SingleChildRenderObjectWidget。 
          布局类Widget是按照⼀定的排列⽅式来对其⼦Widget进⾏排列；⽽容器类Widget⼀般只是包装其⼦Widget，
          对其 添加⼀些修饰（补⽩或背景⾊等）、变换(旋转或剪裁等)、或限制(⼤⼩等)。 
          注意，Flutter官⽅并没有对Widget进⾏官⽅分类，我们对其分类主要是为了⽅便讨论和对Widget功能的区分记忆
        */
        //容器类---1、Padding 
        //Padding可以给其⼦节点添加补⽩（填充），
        //我们在前⾯很多示例中都已经使⽤过它了，现在来看看它的定义：
        //Padding({ ... EdgeInsetsGeometry padding, Widget child, })
        //EdgeInsetsGeometry是⼀个抽象类，开发中，我们⼀般都使⽤EdgeInsets，
        //它是EdgeInsetsGeometry的⼀个⼦类，定 义了⼀些设置补⽩的便捷⽅法
        //EdgeInsets
        //我们看看EdgeInsets提供的便捷⽅法： 
        //fromLTRB(double left, double top, double right, double bottom) ：分别指定四个⽅向的补⽩。 
        //all(double value) : 所有⽅向均使⽤相同数值的补⽩。 
        //only({left, top, right ,bottom }) ：可以设置具体某个⽅向的补⽩(可以同时指定多个⽅向)。 
        //symmetric({ vertical, horizontal }) ：⽤于设置对称⽅向的补⽩，vertical指top和bottom，horizontal指left和 right
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text("Hello world"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Text("Your friend"),
                  )
                ],
              ),
            ),
            //ConstrainedBox和SizedBox ConstrainedBox和SizedBox都是通过RenderConstrainedBox来渲染的。
            //SizedBox只是ConstrainedBox⼀个定制，本节 把他们放在⼀起讨论。ConstrainedBox 
            //ConstrainedBox⽤于对⻬⼦widget添加额外的约束。例如，如果你想让⼦widget的最⼩⾼度是80像素，
            //你可以使 ⽤ const BoxConstraints(minHeight: 80.0) 作为⼦widget的约束
           
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: 50.0
              ),
              //可以看到，我们虽然将Container的⾼度设置为5像素，但是最终却是50像素，这正是ConstrainedBox的最⼩⾼度限制⽣ 效了。
              //如果将Container的⾼度设置为80像素，
              //那么最终红⾊区域的⾼度也会是80像素，因为在此示例中， ConstrainedBox只限制了最⼩⾼度，并未限制最⼤⾼度。
              child: Container(
                height: 5.0,
                child:  DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
              
              ),
              ),
            ),
            //SizeBox 
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 80.0,
              height: 80.0,
              child: DecoratedBox(
                 decoration: BoxDecoration(color: Colors.red),
                  )
                 ,
            ),
            SizedBox(
              height: 20,
            ),
            //实际上SizedBox和只是ConstrainedBox⼀个定制，上⾯代码等价于
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                width: 80,
                height: 80
              ),
              child: DecoratedBox(
                 decoration: BoxDecoration(color: Colors.red),
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            //⽽ BoxConstraints.tightFor(width: 80.0,height: 80.0) 等价于：
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 80,
                minHeight: 80
              ),
              child: DecoratedBox(
                 decoration: BoxDecoration(color: Colors.red),
                  ),
            ),
            //⽽实际上ConstrainedBox和SizedBox都是通过RenderConstrainedBox来渲染的，
            //我们可以看到ConstrainedBox和 SizedBox的 createRenderObject() ⽅法都返回的是⼀个RenderConstrainedBox对象：
            /*
              @override RenderConstrainedBox createRenderObject(BuildContext context) 
              { return new RenderConstrainedBox( additionalConstraints: ..., ); }
            */
            //多重限制
            //如果某一个Widget有多个父ConstrainedBox限制，有多重限制时，
            //对于minWidth和minHeight来说，是取⽗⼦中相应数值较⼤的。
            //实际上，只有 这样才能保证⽗限制与⼦限制不冲突
            SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 90,
                minHeight: 20,
                
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 60.0,
                  minHeight: 60.0,
                  
                ),
                child: DecoratedBox(
                 decoration: BoxDecoration(color: Colors.red),
                  ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //UnconstrainedBox
            //UnconstrainedBox不会对⼦Widget产⽣任何限制，它允许其⼦Widget按照其本身⼤⼩绘制。
            //⼀般情况下，我们会很少 直接使⽤此widget，但在"去除"多重限制的时候也许会有帮助，我们看⼀下⾯的代码：
            ConstrainedBox(
              constraints:BoxConstraints(
                minWidth: 60,
                minHeight: 100,
                
              ) ,
              child: UnconstrainedBox(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 90,
                    minHeight: 20,
                  
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                  ),
                ),
              ),/*
                但是，读者请注意，UnconstrainedBox对⽗限制的“去除”并⾮是真正的去除，上⾯例⼦中虽然红⾊区域⼤⼩是90×20， 
                但上⽅仍然有80的空⽩空间。也就是说⽗限制的minHeight(100.0)仍然是⽣效的，只不过它不影响最终⼦元素的⼤⼩， 但仍然还是占有相应的空间，
                可以认为此时的⽗ConstrainedBox是作⽤于⼦ConstrainedBox上，⽽redBox只受⼦ ConstrainedBox限制，这⼀点请读者务必注意。
                那么有什么⽅法可以彻底去除⽗BoxConstraints的限制吗？答案是否定的！所以在此提示读者，在定义⼀个通⽤的 widget时，如果对⼦widget指定限制时⼀定要注意，
                因为⼀旦指定限制条件，⼦widget如果要进⾏相关⾃定义⼤⼩时将 可能⾮常困难，因为⼦widget在不更改⽗widget的代码的情况下⽆法彻底去除其限制条件。
              */
            ),
              //DecoratedBox
              //DecoratedBox可以在其⼦widget绘制前(或后)绘制⼀个装饰Decoration（如背景、边框、渐变等）。
              //DecoratedBox定义 如下
              /*
                const DecoratedBox
                ({ 
                  //代表将要绘制的装饰，它类型为Decoration，Decoration是⼀个抽象类，它定义了⼀个接⼝ createBoxPainter() ，
                  //⼦类的主要职责是需要通过实现它来创建⼀个画笔，该画笔⽤于绘制装饰
                  Decoration decoration, 
                  //此属性决定在哪⾥绘制Decoration，它接收DecorationPosition的枚举类型，
                  //该枚举类两个值： background：在⼦widget之后绘制，即背景装饰。 
                  //foreground：在⼦widget之上绘制，即前景
                  DecorationPosition position = DecorationPosition.background, 
                  Widget child 
                })
              */
              //BoxDecoration 我们通常会直接使⽤ BoxDecoration ，
              //它是⼀个Decoration的⼦类，实现了常⽤的装饰元素的绘制
              /*
                BoxDecoration
                ({ Color color, //颜⾊ 
                DecorationImage image,//图⽚ 
                BoxBorder border, //边框 
                BorderRadiusGeometry borderRadius, //圆⻆ 
                List<BoxShadow> boxShadow, //阴影,可以指定多个 
                Gradient gradient, //渐变
                 BlendMode backgroundBlendMode, //背景混合模式 
                 BoxShape shape = BoxShape.rectangle, //形状 
                 })
              */
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red,Colors.orange]
                  ),
                  borderRadius: BorderRadius.circular(3.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0,2.0),
                      blurRadius: 4.0
                    )
                  ]
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80,vertical: 18),
                  child: Text("Login",style: TextStyle(color: Colors.white),),
                ),
              ),//通过BoxDecoration，我们实现了⼀个渐变按钮的外观，
              //但此示例还不是⼀个标准的按钮，因为它还不能响应 点击事件，我们将在本章末尾来实现⼀个完整的GradientButton。

              //Transform变换
              //Transform可以在其⼦Widget绘制时对其应⽤⼀个矩阵变换（transformation），
              //Matrix4是⼀个4D矩阵，通过它我们可 以实现各种矩阵操作。下⾯是⼀个例⼦：
              //Transform可以在其⼦Widget绘制时对其应⽤⼀个矩阵变换（transformation），
              //'Matrix4是⼀个4D矩阵，通过它我们可 以实现各种矩阵操作。下⾯是⼀个例⼦
              /*
                Container( 
                  color: Colors.black, 
                  child: new Transform( 
                    alignment: Alignment.topRight, //相对于坐标系原点的对⻬⽅式 transform: new Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度 child: new Container( 
                  padding: const EdgeInsets.all(8.0), 
                  color: Colors.deepOrange, 
                  child: const Text('Apartment for rent!'), ), ), )
              */
              //平移
              //Transform.translate接收⼀个offset参数，可以在绘制时沿x、y轴对⼦widget平移指定的距离
              SizedBox(
                height: 20,
              ),
               
              
          ],
        ),
      ),
    );
  }
}
