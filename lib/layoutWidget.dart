import 'package:flutter/material.dart';
/*
  布局类Widget都会包含⼀个或多个⼦widget，不同的布局类Widget对⼦widget排版(layout)⽅式不同。
  我们在前⾯说过 Element树才是最终的绘制树，Element树是通过widget树来创建的（通过 Widget.createElement() ），
  widget其实就是 Element的配置数据。Flutter中，根据Widget是否需要包含⼦节点将Widget分为了三类，分别对应三种Element，
  如下 表


  注意，Flutter中的很多Widget是直接继承⾃StatelessWidget或StatefulWidget，然后在 build() ⽅法中构建真正 的RenderObjectWidget，
  如Text，它其实是继承⾃StatelessWidget，然后在 build() ⽅法中通过RichText来构 建其⼦树，⽽RichText才是继承⾃LeafRenderObjectWidget。
  所以为了⽅便叙述，我们也可以直接说Text属于 LeafRenderObjectWidget（其它widget也可以这么描述），这才是本质。
  读到这⾥我们也会发现，其实 StatelessWidget和StatefulWidget就是两个⽤于组合Widget的基类，
  它们本身并不关联最终的渲染对象 （RenderObjectWidget）。
  布局类Widget就是指直接或间接继承(包含)MultiChildRenderObjectWidget的Widget，它们⼀般都会有⼀个children属性 
  ⽤于接收⼦Widget。我们看⼀下继承关系 Widget > RenderObjectWidget > (Leaf/SingleChild/MultiChild)RenderObjectWidget 。RenderObjectWidget类中定义了创建、更新RenderObject的⽅ 法，⼦类必须实现他们，
  关于RenderObject我们现在只需要知道它是最终布局、渲染UI界⾯的对象即可，也就是说，对 于布局类Widget来说，其布局算法都是通过对应的RenderObject对象来实现的，所以读者如果对接下来介绍的某个布 局类Widget原理感兴趣，可以查看其RenderObject的实现，⽽在本章中，为了让读者对布局类Widget有个快速的认 识，所以我们不会深⼊到RenderObject的细节中区。
  在学习本章时，读者的重点是掌握不同布局类Widget的布局特 点，具体原理和细节我们会在后⾯⾼级部分介绍
  线性布局Row和Column 所谓线性布局，即指沿⽔平或垂直⽅向排布⼦Widget。Flutter中通过Row和Column来实现线性布局，类似于Android中 的LinearLayout控件。
  Row和Column都继承⾃Flex，我们将在弹性布局⼀节中详细介绍Flex。
  主轴和纵轴 
  对于线性布局，有主轴和纵轴之分，如果布局是沿⽔平⽅，那么主轴就指是⽔平⽅向，⽽纵轴即垂直⽅向；如果布局沿 垂直⽅向，那么主轴就是指垂直⽅向，⽽纵轴就是⽔平⽅向。
  在线性布局中，有两个定义对⻬⽅式的枚举类 MainAxisAlignment和CrossAxisAlignment，分别代表主轴对⻬和纵轴对⻬。
*/
class layoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("布局类Widget"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //表示⽔平⽅向⼦widget的布局顺序(是从左往右还是从右往左)，
            //默认为系统当前Locale环境的⽂本⽅ 向(如中⽂、英语都是从左往右，⽽阿拉伯语是从右往左)
            textDirection:TextDirection.ltr ,
            //表示Row在主轴(⽔平)⽅向占⽤的空间，默认是 MainAxisSize.max ，表示尽可能多的占⽤⽔平⽅向 的空间，
            //此时⽆论⼦widgets实际占⽤多少⽔平空间，Row的宽度始终等于⽔平⽅向的最⼤宽度； ⽽ MainAxisSize.min 
            //表示尽可能少的占⽤⽔平空间，当⼦widgets没有占满⽔平剩余空间，则Row的实际宽度等于 所有⼦widgets占⽤的的⽔平空间
            mainAxisSize: MainAxisSize.max,
            //表示⼦Widgets在Row所占⽤的⽔平空间内对⻬⽅式，如果mainAxisSize值 为 MainAxisSize.min ，则此属性⽆意义，
            //因为⼦widgets的宽度等于Row的宽度。只有当mainAxisSize的值 为 MainAxisSize.max 时，此属性才有意义，
            // MainAxisAlignment.start 表示沿textDirection的初始⽅向对⻬，如 textDirection取值为 TextDirection.ltr 时，
            //则 MainAxisAlignment.start 表示左对⻬，textDirection取值 为 TextDirection.rtl 时表示从右对⻬。
            //⽽ MainAxisAlignment.end 和 MainAxisAlignment.start 正好相 反； 
            //MainAxisAlignment.center 表示居中对⻬。读者可以这么理解：textDirection是mainAxisAlignment的参考系
            mainAxisAlignment: MainAxisAlignment.center,
            //表示Row纵轴（垂直）的对⻬⽅向，默认是 VerticalDirection.down ，表示从上到下。
            verticalDirection: VerticalDirection.down,
            //：表示⼦Widgets在纵轴⽅向的对⻬⽅式，Row的⾼度等于⼦Widgets中最⾼的⼦元素⾼度，它 的取值和MainAxisAlignment⼀样(包含 start 、 end 、 center 三个值)，
            //不同的是crossAxisAlignment的参考系是 verticalDirection，即verticalDirection值为 VerticalDirection.down 时 crossAxisAlignment.start 指顶部对⻬， 
            //verticalDirection值为 VerticalDirection.up 时， crossAxisAlignment.start 指底部对⻬； 
            //⽽ crossAxisAlignment.end 和 crossAxisAlignment.start 正好相反
            crossAxisAlignment: CrossAxisAlignment.start,
            //⼦Widgets数组
            children: [
              Text("这是第一行"),
              Text("这是第二行"),
              Text("这是第三行"),
              Text("这是第四行"),
              Text("这是第五行"),
              Text("这是第六行")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello world"),
              Text("I am Jack")
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("hello world"),
              Text("I am Bruce Lee")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            textDirection: TextDirection.rtl,
            children: [
              Text("hello world"),
              Text("I am ningbo")
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: [
              Text("hello world",style: TextStyle(color: Colors.blue,fontSize: 30),),
              Text("I am haha")
            ],
          ),
          //Column Column可以在垂直⽅向排列其⼦widget。参数和Row⼀样，
          //不同的是布局⽅向为垂直，主轴纵轴正好相反，读者可类 ⽐Row来理解，在此不再赘述
          //特殊情况 如果Row⾥⾯嵌套Row，或者Column⾥⾯再嵌套Column，
          //那么只有对最外⾯的Row或Column会占⽤尽可能⼤的空 间，⾥⾯Row或Column所占⽤的空间为实际⼤⼩，
          //下⾯以Column为例说明
          Container(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // //有效，外层Colum⾼度为整个屏幕
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: Colors.red,
                    child: Column(
                      ////⽆效，内层Colum⾼度为实际⾼度
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Hello world"),
                        Text("I am Jack")
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      
    );
  }
}
