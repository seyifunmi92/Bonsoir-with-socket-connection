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
  late BonsoirDiscovery myDiscovery;
  late StreamSubscription<BonsoirBroadcastEvent> subscription;
  bool isDiscovered = false;
  bool get _isDiscovered => isDiscovered;
  //In order to show the list of discovered devices
  List<ResolvedBonsoirService> discoveredDevices = [];
  List<ResolvedBonsoirService> get discoveredServices =>
      List.of(discoveredDevices);
  BonsoirDiscoveryPackage() {
    startDiscovery();
  }
  Future<void> startDiscovery({bool notifier = false}) async {
    if (myDiscovery == null || myDiscovery.isStopped) {
      myDiscovery =
          BonsoirDiscovery(type: await MybonsoirService.getBonsoirService();
      await myDiscovery.ready;
    }
    await myDiscovery.start();
    subscription = myDiscovery.eventStream?.listen(eventOccured)
        as StreamSubscription<BonsoirBroadcastEvent>;
  }
  void stopDiscovery({bool notifier = false}) {
    subscription.cancel();
    subscription == null;
    myDiscovery.stop();
  }
  void eventOccured(BonsoirBroadcastEvent event) {
    if (event.service == null || !event.isServiceResolved) {
      return;
    }
    if (event.type == BonsoirDiscoveryEventType.DISCOVERY_SERVICE_RESOLVED) {
      discoveredDevices.add(event.service);
      notifyListeners();
    } else if (event.type == BonsoirDiscoveryEventType.DISCOVERY_SERVICE_LOST) {
      discoveredDevices.remove(event.service);
      notifyListeners();
    }
  }
  @override
  void dispose() {
    stopDiscovery();
    super.dispose();
  }
}
