import 'package:flutter/material.dart';
import 'package:mybonsoir/models/broadcast.dart';
import 'package:mybonsoir/models/broadcast.dart';
import 'package:mybonsoir/models/discovery.dart';
import 'package:mybonsoir/models/services.dart';
import 'package:provider/provider.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io';

// class Client extends StatefulWidget {
//   const Client({Key? key}) : super(key: key);
//
//   @override
//   _ClientState createState() => _ClientState();
// }
// class _ClientState extends State<Client> {
//   @override
//   Widget build(BuildContext context) {
// IO.Socket socket = IO.io('http://localhost:3000');
// socket.onConnect((_) {
// print('connect');
// socket.emit('msg', 'test');
// });
// socket.on('event', (data) => print(data));
// socket.onDisconnect((_) => print('disconnect'));
// socket.on('fromServer', (_) => print(_));
// }
//
//
//   }
//
//
//
// }








