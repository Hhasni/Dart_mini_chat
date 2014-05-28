library serverchat;

import 'dart:io';
import 'dart:async';
import 'dart:convert';

List<WebSocket> _ws_list = [];

void  handleMsg(msg) {
  print('Message received: $msg');
}

void  main()
{
    HttpServer.bind('127.0.0.1', 4040).then((HttpServer server)
    {
      print("Waiting Server");
      server.serverHeader = "DartChat (1.0) by Hhasni";
      server.listen((HttpRequest request){
        if (WebSocketTransformer.isUpgradeRequest(request)){
          WebSocketTransformer.upgrade(request).then(mywebsocket);
        }
        else {
          print("error\n");
        };
      });
    });
}

void  mywebsocket(WebSocket socket)
{
  _ws_list.add(socket);
  var login = "mylogin";
  print('"$login" connected');
  _ws_list.forEach((v) {
    v.add('"$login" connected');
  });
  socket.listen((String str)
  {
    print('$login : $str');
    _ws_list.forEach((v) {
      v.add('$login : $str');
    });
  },
  onDone: ()
  {
    print('"$login" disconnected (leaving).');
    _ws_list.remove(socket);
    _ws_list.forEach((v) {
      v.add('"$login" disconnected (leaving).');
    });
  });
}

