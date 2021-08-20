import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

/*使⽤WebSockets*/
//Http协议是⽆状态的，只能由客户端主动发起，服务端再被动响应，服务端⽆法向客户端主动推送内容，并且⼀旦服务 器响应结束，
//链接就会断开(⻅注解部分)，所以⽆法进⾏实时通信。WebSocket协议正是为解决客户端与服务端实时通 信⽽产⽣的技术，
//现在已经被主流浏览器⽀持，所以对于Web开发者来说应该⽐较熟悉了，Flutter也提供了专⻔的包来 ⽀持WebSocket协议。
/*注意：
Http协议中虽然可以通过keep-alive机制使服务器在响应结束后链接会保持⼀段时间，
但最终还是会断开， keep-alive机制主要是⽤于避免在同⼀台服务器请求多个资源时频繁创建链接，它本质上是⽀持链接复⽤的技 术，
⽽并⾮⽤于实时通信，读者需要知道这两者的区别。*/
//WebSocket协议本质上是⼀个基于tcp的协议，它是先通过HTTP协议发起⼀条特殊的http请求进⾏握⼿后，如果服务端 ⽀持WebSocket协议，则会进⾏协议升级。WebSocket会使⽤http协议握⼿后创建的tcp链接，和http协议不同的是， WebSocket的tcp链接是个⻓链接（不会断开），所以服务端与客户端就可以通过此TCP连接进⾏实时通信。有关 WebSocket协议细节，读者可以看RFC⽂档，下⾯我们重点看看Flutter中如何使⽤WebSocket。
//在接下来例⼦中，我们将连接到由websocket.org提供的测试服务器。服务器将简单地返回我们发送给它的相同消息！
//步骤1. 连接到WebSocket服务器。 2. 监听来⾃服务器的消息。 3. 将数据发送到服务器。 4. 关闭WebSocket连接。
/*
  1. 连接到WebSocket服务器 web_socket_channel package 提供了我们需要连接到WebSocket服务器的⼯具. 该package提供了⼀个 WebSocketChannel 允许我们既可以监听来⾃服务器的消息，⼜可以将消息发送到服务器的⽅法。 在Flutter中，我们可以创建⼀个 WebSocketChannel 连接到⼀台服务器： final channel = new IOWebSocketChannel.connect('ws://echo.websocket.org'); 
  2. 监听来⾃服务器的消息 现在我们建⽴了连接，我们可以监听来⾃服务器的消息，在我们发送消息给测试服务器之后，它会返回相同的消息。 我们如何收取消息并显示它们？在这个例⼦中，我们将使⽤⼀个 StreamBuilder Widget来监听新消息， 并⽤⼀个Text Widget来显示它们。 new StreamBuilder( stream: widget.channel.stream, builder: (context, snapshot) { return new Text(snapshot.hasData ? '${snapshot.data}' : ''); }, ); ⼯作原理 WebSocketChannel 提供了⼀个来⾃服务器的消息Stream 。 WebSocket
该 Stream 类是 dart:async 包中的⼀个基础类。它提供了⼀种⽅法来监听来⾃数据源的异步事件。与 Future 返回单个 异步响应不同， Stream 类可以随着时间推移传递很多事件。 该 StreamBuilder Widget将连接到⼀个Stream， 并在每次收到消息时通知Flutter重新构建界⾯。 
3. 将数据发送到服务器 为了将数据发送到服务器，我们会 add 消息给 WebSocketChannel 提供的sink。 channel.sink.add('Hello!'); ⼯作原理 WebSocketChannel 提供了⼀个 StreamSink ，它将消息发给服务器。 StreamSink 类提供了给数据源同步或异步添加事件的⼀般⽅法。 
4. 关闭WebSocket连接 在我们使⽤ WebSocket 后，要关闭连接： channel.sink.close();
*/

class WebSocketRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WebSocketRouteState();
  }
}

class _WebSocketRouteState extends State<WebSocketRoute> {
  TextEditingController _controller = TextEditingController();
  IOWebSocketChannel? channel;
  String _text = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channel = IOWebSocketChannel.connect("ws://echo.websocket.org");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("WebSocket(内容回显)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: channel!.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  _text = "网络不通";
                } else if (snapshot.hasData) {
                  _text = "echo: ";
                  print("$snapshot");
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(_text),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: "Send message",
        child: Icon(Icons.send),
      ),
    );
  }
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel!.sink.add(_controller.text);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    channel!.sink.close();
    super.dispose();
  }
}
/*
  上⾯的例⼦⽐较简单，不再赘述。我们现在思考⼀个问题，假如我们想通过WebSocket传输⼆进制数据应该怎么做（⽐ 如要从服务器接收⼀张图⽚）？
  我们发现 StreamBuilder 和 Stream 都没有指定接收类型的参数，并且在创建 WebSocket链接时也没有相应的配置，貌似没有什么办法……其实很简单，
  要接收⼆进制数据仍然使 ⽤ StreamBuilder ，因为WebSocket中所有发送的数据使⽤帧的形式发送，⽽帧是有固定格式，
  每⼀个帧的数据类型都 可以通过Opcode字段指定，它可以指定当前帧是⽂本类型还是⼆进制类型（还有其它类型），
  所以客户端在收到帧时 就已经知道了其数据类型，所以flutter完全可以在收到数据后解析出正确的类型，所以就⽆需开发者去关⼼，
  当服务器 传输的数据是指定为⼆进制时， StreamBuilder 的 snapshot.data 的类型就是 List<int> ，是⽂本时，则为 String
*/