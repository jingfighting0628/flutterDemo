import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/*⽂件操作 */
//Dart的IO库包含了⽂件读写的相关类，它属于Dart语法标准的⼀部分，所以通过Dart IO库，
//⽆论是Dart VM下的脚本还 是Flutter，都是通过Dart IO库来操作⽂件的，不过和Dart VM相⽐，
//Flutter有⼀个重要差异是⽂件系统路径不同，这是 因为Dart VM是运⾏在PC或服务器操作系统下，
//⽽Flutter是运⾏在移动操作系统中，他们的⽂件系统会有⼀些差异。
/*APP⽬录*/
//Android和iOS的应⽤存储⽬录不同， PathProvider 插件提供了⼀种平台透明的⽅式来访问设备⽂件系统上的常⽤位 置。该类当前⽀持访问两个⽂件系统位置： 临时⽬录: 可以使⽤ getTemporaryDirectory() 来获取临时⽬录； 系统可随时清除的临时⽬录（缓存）。在iOS 上，这对应于 NSTemporaryDirectory() 返回的值。在Android上，这是 getCacheDir() )返回的值。 ⽂档⽬录: 可以使⽤ getApplicationDocumentsDirectory() 来获取应⽤程序的⽂档⽬录，该⽬录⽤于存储只有⾃⼰可 以访问的⽂件。只有当应⽤程序被卸载时，系统才会清除该⽬录。在iOS上，这对应于 NSDocumentDirectory 。在 Android上，这是 AppData ⽬录。 外部存储⽬录：可以使⽤ getExternalStorageDirectory() 来获取外部存储⽬录，如SD卡；由于iOS不⽀持外部⽬ 录，所以在iOS下调⽤该⽅法会抛出 UnsupportedError 异常，⽽在Android下结果是android SDK 中 getExternalStorageDirectory 的返回值。 ⼀旦你的Flutter应⽤程序有⼀个⽂件位置的引⽤，你可以使⽤dart:ioAPI来执⾏对⽂件系统的读/写操作。
//1、临时⽬录:
//可以使⽤ getTemporaryDirectory() 来获取临时⽬录；
//系统可随时清除的临时⽬录（缓存）。在iOS 上，这对应于 NSTemporaryDirectory() 返回的值。在Android上，这是 getCacheDir() )返回的值。
//2、文档目录
//⽂档⽬录: 可以使⽤ getApplicationDocumentsDirectory() 来获取应⽤程序的⽂档⽬录，该⽬录⽤于存储只有⾃⼰可 以访问的⽂件。
//只有当应⽤程序被卸载时，系统才会清除该⽬录。
//在iOS上，这对应于 NSDocumentDirectory 。在 Android上，这是 AppData ⽬录。
//3、外部存储⽬录：可以使⽤ getExternalStorageDirectory() 来获取外部存储⽬录，
//如SD卡；由于iOS不⽀持外部⽬ 录，所以在iOS下调⽤该⽅法会抛出 UnsupportedError 异常，
//⽽在Android下结果是android SDK 中 getExternalStorageDirectory 的返回值
//⼀旦你的Flutter应⽤程序有⼀个⽂件位置的引⽤，你可以使⽤dart:ioAPI来执⾏对⽂件系统的读/写操作。
//有关使⽤Dart 处理⽂件和⽬录的详细内容可以参考Dart语⾔⽂档，下⾯我们看⼀个简单的例⼦。
//示例我们还是以计数器为例，实现在应⽤退出重启后可以恢复点击次数。
// 这⾥，我们使⽤⽂件来保存数据：
// 1. 引⼊PathProvider插件；在 pubspec.yaml ⽂件中添加如下声明

class FileOpetaionRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FileOperationRouteState();
  }
}

class _FileOperationRouteState extends State<FileOpetaionRoute> {
  int _counter = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //从文件读取点击次数
    _readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _getLocalFile() async {
    //获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  Future<Null> _increnmentCounter() async {
    setState(() {
      _counter++;
    });
    //将点击次数以字符串类型写到文件中
    await (await _getLocalFile()).writeAsString("$_counter");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("文件操作"),
      ),
      body: Center(
        child: Text("点击了 $_counter 次"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increnmentCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
//上⾯代码⽐较简单，不再赘述，需要说明的是，
//本示例只是为了演示⽂件读写，⽽在实际开发中，
//如果要存储⼀些 简单的数据，使⽤shared_preferences插件会⽐较简单。
//注意，Dart IO库操作⽂件的API⾮常丰富，但本书不是介绍Dart语⾔的，故不详细说明，读者需要的话可以 ⾃⾏学习。