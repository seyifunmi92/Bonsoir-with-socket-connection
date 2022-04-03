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

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.white,
        primaryColor: Colors.white,
        brightness: Brightness.light,
      ),
      home: const Mybonsoir(),
      initialRoute: '/',
      routes: const {},
    ));
class Mybonsoir extends StatefulWidget {
  const Mybonsoir({Key? key}) : super(key: key);
  @override
  _MybonsoirState createState() => _MybonsoirState();
}
class _MybonsoirState extends State<Mybonsoir> {
  File seyisFiles = File("seyisFiles.txt");
  // seyisFiles.rename("myNewFile.txt").then((mine){
  //   print("File has been renamed");
  // });
  bool isConnected = true;
  bool isAvailable = true;
  bool errorConnecting = true;
  String errorCheck = "Error connecting to device";
  String deviceFound = "";
  TextEditingController userC = TextEditingController();
  TextEditingController passC = TextEditingController();
  webSocket() async {
    var server = await HttpServer.bind('127.0.0.1', 4040);
    server.listen((HttpRequest request) async {
      if (request.uri.path == '/') {
        var mysocket = await WebSocketTransformer.upgrade(request);
        mysocket.listen((event) {});
      }
    });
  }
  void checkUser() async {
    String _user = (await SharedPreferences.getInstance() as String);
    SharedPreferences sharedPreferences = _user as SharedPreferences;
    String _response =
        (sharedPreferences.getString("Shared Result") != null) as String;
    String response =
        (sharedPreferences.getString("Shared Password") != null) as String;
    if (sharedPreferences.getString("Shared Result") != null) {
      userC.text = sharedPreferences.getString("Shared Result")!;
      passC.text = sharedPreferences.getString("Shared Password")!;
      setState(() {
        isConnected = true;
        isAvailable = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BonsoirBroadcastPackage>(
            create: (context) => BonsoirBroadcastPackage()),
        ChangeNotifierProvider<BonsoirDiscoveryPackage>(
            create: (context) => BonsoirDiscoveryPackage()),
      ],
      builder: (context, child) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: const TitleWidget(),
            actions: const [BroadcastWidget()],
          ),
          body: const ServiceWidget(),
        ),
      ),
    );
  }
}
