// ignore_for_file: unrelated_type_equality_checks
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mybonsoir/models/broadcast.dart';
import 'package:mybonsoir/models/broadcast.dart';
import 'package:mybonsoir/models/discovery.dart';
import 'package:mybonsoir/models/services.dart';
import 'package:provider/provider.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:socket_io_client/socket_io_client.dart';

class BonsoirDiscoveryPackage extends ChangeNotifier {
  BonsoirDiscovery? myDiscovery;
  late StreamSubscription<BonsoirDiscoveryEvent> subscription;
  bool isDiscovered = false;
  bool get _isDiscovered => isDiscovered;

  //In order to show the list of discovered devices
  List<ResolvedBonsoirService> discoveredDevices = [];

  List<ResolvedBonsoirService> get discoveredServices =>
      List.of(discoveredDevices);

  BonsoirDiscoveryPackage() {
    //startDiscovery();
  }

  initDiscovery() async {
    if (myDiscovery != null ) {
      myDiscovery!.stop();
    }
    myDiscovery =
        BonsoirDiscovery(type: MybonsoirService.type, printLogs: true);

    myDiscovery!.start();
    subscription = myDiscovery!.eventStream?.asBroadcastStream()
        as StreamSubscription<BonsoirDiscoveryEvent>;
  }

  // Future startDiscovery({bool notifier = false}) async {
  //   if (myDiscovery == null || myDiscovery.isStopped) {
  //     myDiscovery = BonsoirDiscovery(
  //       type: MybonsoirService.type,
  //       printLogs: true,
  //     );
  //     await myDiscovery.ready;
  //   } else if (myDiscovery != null) {
  //     return myDiscovery;
  //   } else {
  //     return null;
  //   }
  //   await myDiscovery.start();
  //   subscription = myDiscovery.eventStream?.listen(eventOccured)
  //       as StreamSubscription<BonsoirBroadcastEvent>;
  // }
  void stopDiscovery({bool notifier = false}) {
    subscription.cancel();
    subscription == null;
    myDiscovery!.stop();
  }
  // void eventOccured(BonsoirBroadcastEvent event) {
  //   if (event.service == null || !event.isServiceResolved) {
  //     return;
  //   }
  //   if (event.type == BonsoirDiscoveryEventType.DISCOVERY_SERVICE_RESOLVED) {
  //     discoveredDevices.add(event);
  //     notifyListeners();
  //   } else if (event.type == BonsoirDiscoveryEventType.DISCOVERY_SERVICE_LOST) {
  //     discoveredDevices.remove(event.service);
  //     notifyListeners();
  //   }
  // }
  @override
  void dispose() {
    stopDiscovery();
    super.dispose();
  }
}
