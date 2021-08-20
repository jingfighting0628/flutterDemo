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