import 'package:flutter/material.dart';
import 'package:mybonsoir/models/broadcast.dart';
import 'package:mybonsoir/models/broadcast.dart';
import 'package:mybonsoir/models/discovery.dart';
import 'package:provider/provider.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:socket_io_client/socket_io_client.dart';


class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isConnected = false;
    String ready = "";
    String title = "";
    int _count = context.watch<BonsoirDiscoveryPackage>().discoveredServices.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(_count == 0 ? "Bonsoir Application" : "Found $_count device(s)"),
      ),
    );
  }
}

