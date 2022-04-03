import 'package:flutter/material.dart';
import 'package:mybonsoir/models/broadcast.dart';
import 'package:mybonsoir/models/broadcast.dart';
import 'package:mybonsoir/models/discovery.dart';
import 'package:mybonsoir/models/services.dart';
import 'package:provider/provider.dart';
import 'package:bonsoir/bonsoir.dart';

class BonsoirBroadcastPackage extends ChangeNotifier {
  late BonsoirBroadcast myBroadcast;
  bool isBroadcasting = false;
  bool get _isBroadcasting => isBroadcasting;
  //Method to start broadcasting

  Future<void> startBroadcast({bool notifier = false}) async {
    if (myBroadcast == null || myBroadcast.isStopped) {
      myBroadcast = BonsoirBroadcast(service: await MybonsoirService.getBonsoirService());
      await myBroadcast.ready;
    }
    await myBroadcast.start();
    isBroadcasting = true;
    if (notifier) {
      notifyListeners();
    }
  }
  void stopBroadcast({bool notifier = false}) async {
    myBroadcast.stop();
    isBroadcasting = false;
    if (notifier) {
      notifyListeners();
    }
  }

@override
  void dispose() {
    startBroadcast();
    super.dispose();
  }
}








