import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mybonsoir/models/broadcast.dart';
import 'package:mybonsoir/models/discovery.dart';
import 'package:mybonsoir/models/services.dart';
import 'package:mybonsoir/widgets/broadcastwidget.dart';
import 'package:mybonsoir/widgets/servicewidget.dart';
import 'package:mybonsoir/widgets/titlewidget.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'dart:io';

class MyWebSocket extends StatelessWidget{
  const MyWebSocket({Key? key}) : super(key: key);
  webSocket()async{
    var server = await HttpServer.bind('127.0.0.1', 4040);
    server.listen((HttpRequest request) async{
      if(request.uri.path == '/'){
        var mysocket = await WebSocketTransformer.upgrade(request);
        mysocket.listen((event) { });
      }
    });
    var _socket = await WebSocket.connect("ws://127.0.0.1:4040/ws");
    _socket.add("Welcome");
    ServerSocket.bind('127.0.0.1', 4041)
        .then((serverSocket) {
      serverSocket.listen((socket) {
        //socket.transform(utf8.decoder).listen(print);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
