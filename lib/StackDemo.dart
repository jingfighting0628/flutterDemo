import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Stack层叠布局示例"),
      ),
      body: //Stack层叠布局
          /*
            层叠布局和Web中的绝对定位、Android中的Frame布局是相似的，⼦widget可以根据到⽗容器四个⻆的位置来确定本 身的位置。
            绝对定位允许⼦widget堆叠（按照代码中声明的顺序）。Flutter中使⽤Stack和Positioned来实现绝对定位， Stack允许⼦widget堆叠，
            ⽽Positioned可以给⼦widget定位（根据Stack的四个⻆）
            Stack({ 
              //此参数决定如何去对⻬没有定位（没有使⽤Positioned）或部分定位的⼦widget。
              //所谓部分定位，在这 ⾥特指没有在某⼀个轴上定位：
              //left、right为横轴，top、bottom为纵轴，只要包含某个轴上的⼀个定位属性就算在 该轴上有定位。
               this.alignment = AlignmentDirectional.topStart,
              /*
               和Row、Wrap的textDirection功能⼀样，都⽤于决定alignment对⻬的参考系即：textDirection的值 为 TextDirection.ltr ，
               则alignment的 start 代表左， end 代表右；textDirection的值为 TextDirection.rtl ，
               则 alignment的 start 代表右， end 代表左
               */
                this.textDirection, 
                /*
                此参数⽤于决定没有定位的⼦widget如何去适应Stack的⼤⼩。 
               StackFit.loose 表示使⽤⼦widget的⼤ ⼩， 
               StackFit.expand 表示扩伸到Stack的⼤⼩
               */

               this.fit = StackFit.loose, 
              /*
                此属性决定如何显示超出Stack显示空间的⼦widget，
                值为 Overflow.clip 时，超出部分会被剪裁（隐 藏），
                值为 Overflow.visible 时则不会。
              */
               this.overflow = Overflow.clip, 
               List<Widget> children = const <Widget>[], 
               })
          */

          //Positioned
          /*
            const Positioned({ Key key, 
            this.left, 
            this.top, 
            this.right, 
            this.bottom, 
            this.width, 
            this.height, 
            @required Widget child, 
            })
            left、top 、right、 bottom分别代表离Stack左、上、右、底四边的距离。
            width和height⽤于指定定位元素的宽度和⾼ 度，注意，此处的width、height 和其它地⽅的意义稍微有点区别，
            此处⽤于配合left、top 、right、 bottom来定位 widget，
            举个例⼦，在⽔平⽅向时，你只能指定left、right、width三个属性中的两个，
            如指定left和width后，right会⾃动 算出(left+width)，如果同时指定三个属性则会报错，垂直⽅向同理
          */
          //通过ConstrainedBox来确保Stack占满屏幕
          // ConstrainedBox(
          //   constraints: BoxConstraints.expand(),
          //   child: Stack(
          //     alignment: Alignment.center,
          //     children: [
          //       Container(
          //         child: Text("Hello world"),
          //         color: Colors.red,
          //       ),
          //       Positioned(
          //         left: 18.0,
          //         child: Text("I am Jack"),
          //       ),
          //       Positioned(
          //         top: 18.0,
          //         child: Text("Your friend"),
          //       )
          //     ],
          //   ),
          // ),
          /*
            由于第⼀个⼦widget Text("Hello world")没有指定定位，并且alignment值为 Alignment.center ，所以，它会居中显示。 
            第⼆个⼦widget Text("I am Jack")只指定了⽔平⽅向的定位(left)，所以属于部分定位，即垂直⽅向上没有定位，
            那么它 在垂直⽅向对⻬⽅式则会按照alignment指定的对⻬⽅式对⻬，即垂直⽅向居中。
            对于第三个⼦widget Text("Your friend")，和第⼆个Text原理⼀样，只不过是⽔平⽅向没有定位，则⽔平⽅向居中。
          */
          //我们给上例中的Stack指定⼀个fit属性，然后将三个⼦widget的顺序调整⼀下：
          Stack(
            alignment: Alignment.center,
            // //未定位的widget占满Stack整个空间
            fit: StackFit.expand,
            children: [
              Positioned(
                left: 18.0,
                child: Text("I am Jack"),
              ),
              //Container未定位所以占满了整个空间
              Container(
                child: Text("hello world",style: TextStyle(color: Colors.white),),
                color: Colors.red,
              ),
              Positioned(
                top: 18.0,
                child: Text("Your friend"),
              )
              //由于第⼆个⼦widget没有定位，所以 fit 属性会对它起作⽤，就会占满Stack。
              //有Stack⼦元素是堆叠的，所 以第⼀个⼦Widget被第⼆个遮住了，
              //⽽第三个在最上层，所以可以正常显示
            ],
          )

        
    );
  }
}

