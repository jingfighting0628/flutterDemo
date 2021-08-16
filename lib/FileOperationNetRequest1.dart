import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
//通过HttpClient发起HTTP请求 Dart IO库中提供了Http请求的⼀些类，
//我们可以直接使⽤HttpClient来发起请求。使⽤HttpClient发起请求分为五步

class HttpTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HttpTestRouteState();
  }
}

class HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("通过HttpClient发起HTTP请求"),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RaisedButton(
                child: Text("获取百度首页"),
                onPressed: _loading
                    ? null
                    : () async {
                        setState(() {
                          _loading = true;
                          _text = "正在请求...";
                        });
                        try {
                          //创建一个HttpClient
                          HttpClient httpClient = new HttpClient();
                          //打开Http连接
                          HttpClientRequest request = await httpClient
                              .getUrl(Uri.parse("https://www.baidu.com"));
                          //使⽤iPhone的UA
                          request.headers.add("user-agent",
                              "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                          //等待连接服务器（会将请求信息发送给服务器）
                          HttpClientResponse response = await request.close();
                          //读取响应的内容
                          _text = await response.transform(utf8.decoder).join();
                          //输出响应头
                          print(response.headers);
                          //关闭client后，通过该client发起的所有请求都会中⽌。
                          httpClient.close();
                        } catch (e) {
                          _text = "请求失败:$e";
                        } finally {
                          setState(() {
                            _loading = false;
                          });
                        }
                      },
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(_text.replaceAll(new RegExp(r"\s"), "")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
//HttpClient配置 HttpClient有很多属性可以配置，常⽤的属性列表如下：
//属性                   含义
//idleTimeout           对应请求头中的keep-alive字段值，为了避免频繁建⽴连接，httpClient在请求结束 后会保持连接⼀段时间，超过这个阈值后才会关闭连接。
//connectionTimeout     和服务器建⽴连接的超时，如果超过这个值则会抛出SocketException异常。
//maxConnectionsPerHost 同⼀个host，同时允许建⽴连接的最⼤数量。
//autoUncompress        对应请求头中的Content-Encoding，如果设置为true，则请求头中Content- Encoding的值为当前HttpClient⽀持的压缩算法列表，⽬前只有"gzip"
//userAgent             对应请求头中的User-Agent字段。
//可以发现，有些属性只是为了更⽅便的设置请求头，对于这些属性，你完全可以通过HttpClientRequest直接设置 header，
//不同的是通过HttpClient设置的对整个httpClient都⽣效，⽽通过HttpClientRequest设置的只对当前请求⽣效。

/*HTTP请求认证 */
//Http协议的认证（Authentication）机制可以⽤于保护⾮公开资源。如果Http服务器开启了认证，
//那么⽤户在发起请求时 就需要携带⽤户凭据，如果你在浏览器中访问了启⽤Basic认证的资源时，浏览就会弹出⼀个登录框，如
//我们先看看Basic认证的基本过程： 
//1. 客户端发送http请求给服务器，服务器验证该⽤户是否已经登录验证过了，如果没有的话， 
//服务器会返回⼀个401 Unauthozied给客户端，并且在响应header中添加⼀个 “WWW-Authenticate” 字段，例如：
//WWW-Authenticate: Basic realm="admin"
//2. 客户端得到响应码后，将⽤户名和密码进⾏base64编码（格式为⽤户名:密码），设置请求头Authorization，继续 访问 :
//Authorization: Basic YXXFISDJFISJFGIJIJG
//服务器验证⽤户凭据，如果通过就返回资源内容。
//注意，Http的⽅式除了Basic认证之外还有：Digest认证、Client认证、Form Based认证等，
//⽬前Flutter的HttpClient只 ⽀持Basic和Digest两种认证⽅式，这两种认证⽅式最⼤的区别是发送⽤户凭据时，
//对于⽤户凭据的内容，前者只是简 单的通过Base64编码（可逆），⽽后者会进⾏哈希运算，相对来说安全⼀点点，
//但是为了安全起⻅，⽆论是采⽤Basic 认证还是Digest认证，都应该在Https协议下，这样可以防⽌抓包和中间⼈攻击。
//HttpClient关于Http认证的⽅法和属性：
//1. addCredentials(Uri url, String realm, HttpClientCredentials credentials)
//该⽅法⽤于添加⽤户凭据,如： 
//httpClient.addCredentials(_uri, "admin", new HttpClientBasicCredentials("username","password"), //Basic认证凭据 );
//如果是Digest认证，可以创建Digest认证凭据：HttpClientDigestCredentials("username","password")
//2. authenticate(Future<bool> f(Uri url, String scheme, String realm))
//这是⼀个setter，类型是⼀个回调，当服务器需要⽤户凭据且该⽤户凭据未被添加时，httpClient会调⽤此回调，
//在 这个回调当中，⼀般会调⽤ addCredential() 来动态添加⽤户凭证，例如：
/*
httpClient.authenticate=(Uri url, String scheme, String realm) 
async{ if(url.host=="xx.com" && realm=="admin")
{ httpClient.addCredentials(url, "admin", 
new HttpClientBasicCredentials("username","pwd"), );
return true; }return false; 
};*/
//⼀个建议是，如果所有请求都需要认证，那么应该在HttpClient初始化时就调⽤ addCredentials() 来添加全局凭 证，⽽不是去动态添加
/*代理*/
//可以通过 findProxy 来设置代理策略，例如，我们要将所有请求通过代理服务器（192.168.1.2:8888）发送出去：
/*
  client.findProxy = (uri) { // 如果需要过滤uri，可以⼿动判断 return "PROXY 192.168.1.2:8888"; };
*/
//findProxy 回调返回值是⼀个遵循浏览器PAC脚本格式的字符串，详情可以查看API⽂档，如果不需要代理，返 回"DIRECT"即可
//在APP开发中，很多时候我们需要抓包来调试，⽽抓包软件(如charles)就是⼀个代理，这时我们就可以将请求发送到我 们的抓包软件，我们就可以在抓包软件中看到请求的数据了。 有时代理服务器也启⽤了身份验证，
//这和http协议的认证是相似的，HttpClient提供了对应的Proxy认证⽅法和属性
/*
  set authenticateProxy( Future<bool> f(String host, int port, String scheme, String realm)); 
  void addProxyCredentials( String host, int port, String realm, HttpClientCredentials credentials);
*/
//他们的使⽤⽅法和上⾯“HTTP请求认证”⼀节中介绍的 addCredentials 和 authenticate 相同，故不再赘述。
/*证书校验*/ 
//Https中为了防⽌通过伪造证书⽽发起的中间⼈攻击，客户端应该对⾃签名或⾮CA颁发的证书进⾏校验。HttpClient对证 书校验的逻辑如下： 
//1. 如果请求的Https证书是可信CA颁发的，并且访问host包含在证书的domain列表中(或者符合通配规则)并且证书未 过期，则验证通过。
// 2. 如果第⼀步验证失败，但在创建HttpClient时，已经通过SecurityContext将证书添加到证书信任链中，那么当服务 器返回的证书在信任链中的话，则验证通过。 
//3. 如果1、2验证都失败了，如果⽤户提供了 badCertificateCallback 回调，则会调⽤它，如果回调返回 true ，则允 许继续链接，如果返回 false ，则终⽌链接。 
//综上所述，我们的证书校验其实就是提供⼀个 badCertificateCallback 回调，下⾯通过⼀个示例来说明。
//示例
//假设我们的后台服务使⽤的是⾃签名证书，证书格式是PEM格式，我们将证书的内容保存在本地字符串中，那么我们的 校验逻辑如下：
/*
  String PEM="XXXXX";//可以从⽂件读取 
  ... 
  httpClient.badCertificateCallback=(X509Certificate cert, String host, int port){ 
    if(cert.pem==PEM){ return true; //证书⼀致，则允许发送数据 }return false; 
    };
*/
//X509Certificate 是证书的标准格式，包含了证书除私钥外所有信息，读者可以⾃⾏查阅⽂档。
//另外，上⾯的示例没有 校验host，是因为只要服务器返回的证书内容和本地的保存⼀致就已经能证明是我们的服务器了（⽽不是中间⼈）， 
//host验证通常是为了防⽌证书和域名不匹配。 
//对于⾃签名的证书，我们也可以将其添加到本地证书信任链中，这样证书验证时就会⾃动通过，⽽不会再⾛ 到 badCertificateCallback 回调中
/*
  SecurityContext sc=new SecurityContext(); //file为证书路径 
  sc.setTrustedCertificates(file); 
  //创建⼀个HttpClient HttpClient httpClient = new HttpClient(context: sc);
*/
//注意，通过 setTrustedCertificates() 设置的证书格式必须为PEM或PKCS12，如果证书格式为PKCS12，则需将证书 密码传⼊，
//这样则会在代码中暴露证书密码，所以客户端证书校验不建议使⽤PKCS12格式的证书。
/*总结*/
//值得注意的是，HttpClient提供的这些属性和⽅法最终都会作⽤在请求header⾥，我们完全可以通过⼿动去设置header 来实现，之所以提供这些⽅法，
//只是为了⽅便开发者⽽已。另外，Http协议是⼀个⾮常重要的、使⽤最多的⽹络协议， 每⼀个开发者都应该对http协议⾮常熟悉。