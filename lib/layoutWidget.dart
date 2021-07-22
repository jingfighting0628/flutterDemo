import 'dart:math';

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
            textDirection: TextDirection.ltr,
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
            children: [Text("Hello world"), Text("I am Jack")],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("hello world"), Text("I am Bruce Lee")],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            textDirection: TextDirection.rtl,
            children: [Text("hello world"), Text("I am ningbo")],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: [
              Text(
                "hello world",
                style: TextStyle(color: Colors.blue, fontSize: 30),
              ),
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
                // //有效，外层Colum⾼度为这个Container这个高度
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: Colors.red,
                    child: Column(
                      ////⽆效，内层Colum⾼度为实际⾼度
                      mainAxisSize: MainAxisSize.max,
                      children: [Text("Hello world"), Text("I am Jack")],
                    ),
                  )
                ],
              ),
            ),
          ),
          /*弹性布局*/
          //弹性布局允许⼦widget按照⼀定⽐例来分配⽗容器空间，弹性布局的概念在其UI系统中也都存在，
          //如H5中的弹性盒⼦布 局，Android中的FlexboxLayout。
          //Flutter中的弹性布局主要通过Flex和Expanded来配合实现
          //Flex可以沿着⽔平或垂直⽅向排列⼦widget，如果你知道主轴⽅向，使⽤Row或Column会⽅便⼀些，因为Row和 Column都继承⾃Flex，参数基本相同，
          //所以能使⽤Flex的地⽅⼀定可以使⽤Row或Column。
          //Flex本身功能是很强⼤ 的，它也可以和Expanded配合实现弹性布局，接下来我们只讨论Flex和弹性布局相关的属性(其它属性已经在介绍Row 和Column时介绍过了)
          //Flex继承⾃MultiChildRenderObjectWidget，对应的RenderObject为RenderFlex，RenderFlex中实现了其布局算法。

          //Expanded 可以按⽐例“扩伸”Row、Column和Flex⼦widget所占⽤的空间
          /*
        const Expanded({ int flex = 1, @required Widget child, })
        flex为弹性系数，如果为0或null，则child是没有弹性的，即不会被扩伸占⽤的空间。如果⼤于0，
        所有的Expanded按照 其flex的⽐例来分割主轴的全部空闲空间。下⾯我们看⼀个例⼦
      */
          FlexlayoutTestRoute(),

          /*流式布局*/
          //在介绍Row和Colum时，如果⼦widget超出屏幕范围，则会报溢出错误
          //可以看到，右边溢出部分报错。这是因为Row默认只有⼀⾏，如果超出屏幕不会折⾏。
          //我们把超出屏幕显示范围会⾃动 折⾏的布局称为流式布局。Flutter中通过Wrap和Flow来⽀持流式布局，
          //将上例中的Row换成Wrap后溢出部分则会⾃动 折⾏。下⾯是Wrap的定义:
          //我们可以看到Wrap的很多属性在Row（包括Flex和Column）中也有，
          //如direction、crossAxisAlignment、 textDirection、verticalDirection等，
          //这些参数意义是相同的，我们不再重复介绍，读者可以查阅前⾯介绍Row的部分。
          //读者可以认为Wrap和Flex（包括Row和Column）除了超出显示范围后Wrap会折⾏外，其它⾏为基本相同。
          //下⾯我们看 ⼀下Wrap特有的⼏个属性：
          //spacing：主轴⽅向⼦widget的间距 runSpacing：纵轴⽅向的间距 runAlignment：纵轴⽅向的对⻬⽅式
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            alignment: WrapAlignment.center,
            children: [
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("A"),
                ),
                label: Text("Hamilton"),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("M"),
                ),
                label: Text("Lafayette"),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("H"),
                ),
                label: Text("Mulligan"),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("J"),
                ),
                label: Text("Laurens"),
              )
            ],
          ),
          /*Flow流式布局*/
          //我们⼀般很少会使⽤Flow，因为其过于复杂，需要⾃⼰实现⼦widget的位置转换，在很多场景下⾸先要考虑的是Wrap 是否满⾜需求。
          //Flow主要⽤于⼀些需要⾃定义布局策略或性能要求较⾼(如动画中)的场景。Flow有如下优点：
          //性能好；Flow是⼀个对child尺⼨以及位置调整⾮常⾼效的控件，Flow⽤转换矩阵（transformation matrices）在对 child进⾏位置调整的时候进⾏了优化：
          //在Flow定位过后，如果child的尺⼨或者位置发⽣了变化，在FlowDelegate 中的 paintChildren() ⽅法中调⽤ context.paintChild 进⾏重绘，
          //⽽ context.paintChild 在重绘时使⽤了转换矩阵 （transformation matrices），并没有实际调整Widget位置。 灵活；由于我们需要⾃⼰实现FlowDelegate的 paintChildren() ⽅法，
          //所以我们需要⾃⼰计算每⼀个widget的位 置，因此，可以⾃定义布局策略。
          //缺点：使⽤复杂. 不能⾃适应⼦widget⼤⼩，必须通过指定⽗容器⼤⼩或实现TestFlowDelegate的 getSize 返回固定⼤⼩。
          //示例： 我们对六个⾊块进⾏⾃定义流式布局
          Flow(
            delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
            children: [
              Container(
                width: 80,
                height: 80,
                color: Colors.red,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.green,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.blue,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.yellow,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.brown,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.purple,
              )
            ],
          ),
          
        ],
      ),
    );
  }
}

class FlexlayoutTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 30.0,
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                color: Colors.green,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 100,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30,
                    color: Colors.red,
                  ),
                ),
                //的Spacer的功能是占⽤指定⽐例的空间，
                //实际上它只是Expanded的⼀个包装
                Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

//实现TestFlowDelegate
//可以看到我们主要的任务就是实现 paintChildren ，它的主要任务是确定每个⼦widget位置。
//由于Flow不能⾃适应⼦ widget的⼤⼩，我们通过在 getSize 返回⼀个固定⼤⼩来指定Flow的⼤⼩
class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;
  TestFlowDelegate({required this.margin});
  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
    var x = margin.left;
    var y = margin.top;
    for (var i = 0; i < context.childCount; i++) {
      // Size? size = context.getChildSize(i);
      // double? width = size!.width;
      /*
        The property 'width' can't be unconditionally accessed because the receiver can be 'null'.
      Try making the access conditional (using '?.') or adding a null check to the target ('!')
      报错在context.getChildSize(i)后面加！可解决错误
      */
      var w = context.getChildSize(i)!.width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // TODO: implement getSize
    return Size(double.infinity, 200);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}
