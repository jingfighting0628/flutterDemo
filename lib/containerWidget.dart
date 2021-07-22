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
            )
          ],
        ),
      ),
    );
  }
}
