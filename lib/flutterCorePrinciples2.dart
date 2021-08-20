//进阶我们可以看到Element是Flutter UI框架内部连接Widget和RenderObject的纽带，
//⼤多数时候开发者只需要关注Widget层 即可，但是Widget层有时候并不能完全屏蔽Element细节，
//所以Framework在StatelessWidget和StatefulWidget中通过 build⽅法参数将Element对象也传递给了开发者，
//这样便可以在需要时直接操作Element对象。那么现在笔者提两个问 题，请读者先⾃⼰思考⼀下：
//1. 如果没有Widget层，单靠Element层是否可以搭建起⼀个完成的UI框架？如果可以应该是什么样⼦？
//2. Flutter UI框架能不做成响应式吗？
//对于问题1，答案当然是肯定的，因为我们之前说过Widget树只是Element树的映射，
//我们完全可以直接通过Element来 搭建⼀个UI框架。下⾯举⼀个例⼦：
//我们通过纯粹的Element来模拟⼀个StatefulWidget的功能，假设有⼀个⻚⾯，该⻚⾯有⼀个按钮，按钮的⽂本是1-9 9 个数，点击⼀次按钮，
//则对9个数随机排⼀次序，代码如下
import 'package:flutter/material.dart';

/*进阶*/
//我们可以看到Element是Flutter UI框架内部连接Widget和RenderObject的纽带，⼤多数时候开发者只需要关注Widget层 即可，
//但是Widget层有时候并不能完全屏蔽Element细节，所以Framework在StatelessWidget和StatefulWidget中通过 build⽅法参数将Element对象也传递给了开发者，这样便可以在需要时直接操作Element对象。那么现在笔者提两个问 题，
//请读者先⾃⼰思考⼀下： 1. 如果没有Widget层，单靠Element层是否可以搭建起⼀个完成的UI框架？如果可以应该是什么样⼦？
//2. Flutter UI框架能不做成响应式吗？ 对于问题1，答案当然是肯定的，因为我们之前说过Widget树只是Element树的映射，
//我们完全可以直接通过Element来 搭建⼀个UI框架。下⾯举⼀个例⼦：
//我们通过纯粹的Element来模拟⼀个StatefulWidget的功能，假设有⼀个⻚⾯，该⻚⾯有⼀个按钮，按钮的⽂本是1-9 9 个数，
//点击⼀次按钮，则对9个数随机排⼀次序，代码如下：
class HomeView extends ComponentElement {
  HomeView(Widget widget) : super(widget);
  String text = "123456789";
  @override
  Widget build() {
    // TODO: implement build
    Color primary = Theme.of(this).primaryColor;
    return GestureDetector(
      child: Center(
        child: FlatButton(
          child: Text(
            text,
            style: TextStyle(color: primary),
          ),
          onPressed: () {
            var t = text.split("")..shuffle();
            text = t.join();
            //点击后将该Element标记为dirty，Element将会rebuild
            markNeedsBuild();
          },
        ),
      ),
    );
  }
}
//上⾯build⽅法不接收参数，这⼀点和在StatelessWidget和StatefulWidget中build(BuildContext)⽅法不同。
//代码中 需要⽤到BuildContext的地⽅直接⽤ this 代替即可，如代码注释1处 Theme.of(this) 参数直接传 this 即可，因为 当前对象本身就是Element实例。
// 当 text 发⽣改变时，我们调⽤ markNeedsBuild() ⽅法将当前Element标记为dirty即可，标记为dirty的Element会在 下⼀帧中重建。
//实际上， State.setState() 在内部也是调⽤的 markNeedsBuild() ⽅法。
//上⾯代码中build⽅法返回的仍然是⼀个Widget，这是由于Flutter框架中已经有了Widget这⼀层，并且组件库都已经 是以Widget的形式提供了，
//如果在Flutter框架中所有组件都想示例的HomeView⼀样以Element形式提供，那么就 可以⽤纯Element来构建UI了，
//HomeView的build⽅法返回值类型就可以是Element了。
//如果我们需要将上⾯代码在现有Flutter框架中跑起来，那么还是得提供⼀个”适配器“Widget将HomeView结合到现有框 架中，
//下⾯CustomHome就相当于”适配器“

class CustomeHome extends Widget {
  @override
  Element createElement() {
    // TODO: implement createElement
    return HomeView(this);
  }
}
//现在就可以将CustomHome添加到Widget树了，我们在⼀个新路由⻚创建它，最终效果如下：
//点击按钮则按钮⽂本会随机排序。 对于问题2，答案当然也是肯定的，Flutter engine提供的dart API是原始且独⽴的，
//这个操作系统提供的类似，上层UI 框架设计成什么样完全取决于设计者，完全可以将UI框架设计成Android⻛格或iOS⻛格，
//但这些事Google不会再去 做，当然没有⼗⾜的理由我们也没必要再去搞⼀套，这是因为响应式的思想本身是很棒的，之所以提出这个问题，
//是因 为笔者认为但做与不做是⼀回事，但知道能与不能是另⼀回事，这能反映出我们对知识的掌握程度。 总结本节详细的介绍了Element的⽣命周期，
//以及它与Widget、BuildContext的关系，也介绍了Element在Flutter UI系统中的 ⻆⾊和作⽤，
//我们将在下⼀节介绍Flutter UI系统中另⼀个重要的⻆⾊RenderObject。