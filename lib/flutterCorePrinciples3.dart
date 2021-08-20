/*RenderObject和RenderBox */
//在上⼀节我们说过没给Element都对应⼀个RenderObject，我们可以通过 Element.renderObject 来获取。并且我们也说 过RenderObject的主要职责是Layout和绘制，所有的RenderObject会组成⼀棵渲染树Render Tree。
//本节我们将重点介 绍⼀下RenderObject的作⽤。
// RenderObject就是渲染树种的⼀个对象，它拥有⼀个 parent 和⼀个 parentData 插槽（slot），所谓插槽，就是指预留 的⼀个接⼝或位置，这个接⼝和位置是由其它对象来接⼊或占据的，这个接⼝或位置在软件中通常⽤预留变量来表示， ⽽ parentData 正是⼀个预留变量，它正是由 parent 来赋值的， parent 通常会通过⼦RenderObject的 parentData 存 储⼀些和⼦元素相关的数据，如在Stack布局中，RenderStack就会将⼦元素的偏移数据存储在⼦元素的 parentData 中 （具体可以查看Positioned实现）。
// RenderObject类本身实现了⼀套基础的layout和绘制协议，但是并没有定义⼦节点模型（如⼀个节点可以有⼏个⼦节 点，没有⼦节点？⼀个？两个？或者更多？）。 它也没有定义坐标系统（如⼦节点定位是在笛卡尔坐标中还是极坐 标？）和具体的布局协议（是通过宽⾼还是通过constraint和size?，或者是否由⽗节点在⼦节点布局之前或之后设置⼦ 节点的⼤⼩和位置扥等）。
// 为此，Flutter提供了⼀个RenderBox类，它继承⾃RenderObject，
//布局坐标系统采⽤笛卡尔 坐标系，这和Android和iOS原⽣坐标系是⼀致的，都是屏幕的top、left是原点，然后分宽⾼两个轴，
//⼤多数情况下，我 们直接使⽤RenderBox就可以了，除⾮遇到要⾃定义布局模型或坐标系统的情况，
//下⾯我们重点介绍⼀下RenderBox。
//布局过程 Constraints 在 RenderBox 中，有个 size属性⽤来保存控件的宽和⾼。
//RenderBox的layout是通过在组件树中从上往下传 递 BoxConstraints 对象的实现的。 
//BoxConstraints 对象可以限制⼦节点的最⼤和最⼩宽⾼，⼦节点必须遵守⽗节点给 定的限制条件。 在布局阶段，⽗节点会调⽤⼦节点的 layout() ⽅法，
//下⾯我们看看RenderObject中 layout() ⽅法的⼤致实现（删掉了 ⼀些⽆关代码和异常捕获）:
/*
  void layout(Constraints constraints, { bool parentUsesSize = false }) { 
    ... RenderObject relayoutBoundary; 
    if (!parentUsesSize || sizedByParent || constraints.isTight || parent is! RenderObject) { 
      relayoutBoundary = this; } 
      else { final RenderObject parent = this.parent; relayoutBoundary = parent._relayoutBoundary; }... 
      if (sizedByParent) { performResize(); }performLayout(); 
      ... 
      }
*/
//可以看到 layout ⽅法需要传⼊两个参数，第⼀个为constraints，即 ⽗节点对⼦节点⼤⼩的限制，该值根据⽗节点的布 局逻辑确定。
//另外⼀个参数是 parentUsesSize，该值⽤于确定 relayoutBoundary ，该参数表示⼦节点布局变化是否影 响⽗节点，如果为 true ，
//当⼦节点布局发⽣变化时⽗节点都会标记为需要重新布局，如果为 false ，则⼦节点布局发 ⽣变化后则不会影响⽗节点。
//relayoutBoundary
//上⾯ layout() 源码中定义了⼀个 relayoutBoundary 变量，什么是 relayoutBoundary？
//在前⾯介绍Element时，我们讲 过当⼀个Element标记为 dirty 时便会重新build，这时 RenderObject 便会重新布局，
//我们是通过调⽤ markNeedsBuild() 来标记Element为dirty的。在 RenderObject中有⼀个类似的 markNeedsLayout() ⽅法，
//它会将 RenderObject 的布局状态标记为 dirty，这样在下⼀个frame中便会重新layout，
//我们看看RenderObject 的 markNeedsLayout() 的部分源码：
/*
  void markNeedsLayout() { 
    ... assert(_relayoutBoundary != null); 
    if (_relayoutBoundary != this) { markParentNeedsLayout(); 
    } 
    else { _needsLayout = true; if (owner != null) 
    { 
      ... owner._nodesNeedingLayout.add(this); owner.requestVisualUpdate(); 
    } 
  } 
}
*/
//代码⼤致逻辑是先判断⾃身是不是 relayoutBoundary，如果不是就继续向 parent 查找，⼀直向上查找到是 relayoutBoundary 的 RenderObject为⽌，
//然后再将其标记为 dirty 的。这样来看它的作⽤就⽐较明显了，意思就是当⼀ 个控件的⼤⼩被改变时可能会影响到它的 parent，
//因此 parent 也需要被重新布局，那么到什么时候是个头呢？答案就 是 relayoutBoundary，如果⼀个 RenderObject 是 relayoutBoundary，
//就表示它的⼤⼩变化不会再影响到 parent 的⼤ ⼩了，于是 parent 也就不⽤重新布局了。
/*performResize 和 performLayout*/
//RenderBox实际的测量和布局逻辑是在 performResize() 和 performLayout() 两个⽅法中，RenderBox⼦类需要实现他 们来定制⾃身的布局逻辑。
//根据 layout() 源码可以看出只有 sizedByParent 为 true 时， performResize() 才会被调 ⽤，⽽ performLayout() 是每次布局都会被调⽤的。 
//sizedByParent 意为该节点的⼤⼩是否仅通过 parent 传给它的 constraints 就可以确定了，即该节点的⼤⼩与它⾃身的属性和其⼦节点⽆关，⽐如如果⼀个控件永远充满 parent 的⼤ ⼩，那么 sizedByParent 就应该返回 true ，
//此时其⼤⼩在 performResize() 中就确定了，在后⾯的 performLayout() ⽅法中将不会再被修改了，这种情况下 performLayout() 只负责布局⼦节点。 
//在 performLayout() ⽅法中除了完成⾃身布局，也必须完成⼦节点的布局，这是因为只有⽗⼦节点全部完成后布局流程 才算真正完成。
//所以最终的调⽤栈将会变成：layout() > performResize()/performLayout() > child.layout() > ... ，
//如此递 归完成整个UI的布局。 
//RenderBox⼦类要定制布局算法不应该重写 layout() ⽅法，因为对于任何RenderBox的⼦类来说，它的layout流程基本 是相同的，
//不同之处只在具体的布局算法，⽽具体的布局算法⼦类应该通过重写 performResize() 和 performLayout() 两个⽅法来实现，他们会在 layout() 中被调⽤。

/*ParentData*/
//当layout结束后，每个节点的位置（相对于⽗节点的偏移）就已经确定了，RenderObject就可以根据位置信息来进⾏最 终的绘制。
//但是在layout过程中，节点的位置信息怎么保存？对于⼤多数RenderBox⼦类来说如果⼦类只有⼀个⼦节 点，那么⼦节点偏移⼀般都是 Offset.zero ，
//如果有多个⼦节点，则每个⼦节点的偏移就可能不同。⽽⼦节点在⽗节点 的偏移数据正是通过RenderObject的 parentData 属性来保存的。
//在RenderBox中，其 parentData 属性默认是⼀个 BoxParentData对象，该属性只能通过⽗节点的 setupParentData() ⽅法来设置：
/*
  abstract class RenderBox extends RenderObject {
     @override void setupParentData(covariant RenderObject child) { 
    if (child.parentData is! BoxParentData) child.parentData = BoxParentData(); 
    }...
}
*/
//BoxParentData定义如下：
// Parentdata 会被RenderBox和它的⼦类使⽤. 
//class BoxParentData extends ParentData { 
// offset表示在⼦节点在⽗节点坐标系中的绘制偏移 
//Offset offset = Offset.zero; 
//@override String toString() => 'offset=$offset'; 
//}
//⼀定要注意，RenderObject的parentData 只能通过⽗元素设置. 当然，ParentData并不仅仅可以⽤来存储偏移信息，
//通常所有和⼦节点特定的数据都可以存储到⼦节点的ParentData 中，
//如ContainerBoxParentData就保存了指向兄弟节点 的 previousSibling 和 nextSibling ， 
//Element.visitChildren() ⽅法也正是通过它们来实现对⼦节点的遍历。
//再⽐ 如 KeepAlive Widget，它使⽤KeepAliveParentDataMixin（继承⾃ParentData） 来保存⼦节的 keepAlive 状态
/*绘制过程*/
//RenderObject可以通过 paint() ⽅法来完成具体绘制逻辑，流程和布局流程相似，⼦类可以实现 paint() ⽅法来完成 ⾃身的绘制逻辑， paint() 签名如下：
//void paint(PaintingContext context, Offset offset) { }
//通过context.canvas可以取到Canvas对象，接下来就可以调⽤Canvas API来实现具体的绘制逻辑。 
//如果节点有⼦节点，它除了⾃身绘制逻辑之外，还要调⽤⼦节点的绘制⽅法。我们以RenderFlex对象为例说明：
/*
  @override void paint(PaintingContext context, Offset offset) { 
    // 如果⼦元素未超出当前边界，则绘制⼦元素 
    //if (_overflow <= 0.0) { defaultPaint(context, offset); return; }
    // 如果size为空，则⽆需绘制 
    //if (size.isEmpty) return; 
    // 剪裁掉溢出边界的部分 
    //context.pushClipRect(needsCompositing, offset, Offset.zero & size, defaultPaint); assert(() { 
    //final String debugOverflowHints = '...'; //溢出提示内容，省略 // 绘制溢出部分的错误提示样式 Rect overflowChildRect; 
    //switch (_direction) { 
    //case Axis.horizontal: overflowChildRect = Rect.fromLTWH(0.0, 0.0, size.width + _overflow, 0.0); break; 
    //case Axis.vertical: overflowChildRect = Rect.fromLTWH(0.0, 0.0, 0.0, size.height + _overflow); break; }
    //paintOverflowIndicator(context, offset, Offset.zero & size, overflowChildRect, overflowHints: debugOverflowHints); 
    //return true; }()); 
  }

*/
//代码很简单，⾸先判断有⽆溢出，如果没有则调⽤ defaultPaint(context, offset) 来完成绘制，该⽅法源码如下：
/*
  void defaultPaint(PaintingContext context, Offset offset) { 
    ChildType child = firstChild; while (child != null) { 
      final ParentDataType childParentData = child.parentData; //绘制⼦节点， 
  context.paintChild(child, childParentData.offset + offset); 
  child = childParentData.nextSibling; 
  } 
}
*/
//很明显，由于Flex本身没有需要绘制的东⻄，所以直接遍历其⼦节点，然后调⽤ paintChild() 来绘制⼦节点，
//同时将⼦ 节点ParentData中再layout阶段保存的offset加上⾃身偏移作为第⼆个参数传递给 paintChild() 。
//⽽如果⼦节点如果还 有⼦节点时， paintChild() ⽅法还会调⽤⼦节点的 paint() ⽅法，如此递归完成整个节点树的绘制，
//最终调⽤栈为： paint() > paintChild() > paint() ... 。 当需要绘制的内容⼤⼩溢出当前空间时，将会执⾏ paintOverflowIndicator() 来绘制溢出部分提示，
//这个就是我们经常 看到的溢出提示，如：