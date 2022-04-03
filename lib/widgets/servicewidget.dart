import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mybonsoir/models/services.dart';
import 'package:mybonsoir/models/discovery.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:socket_io_client/socket_io_client.dart';


class ServiceWidget extends StatefulWidget {
  const ServiceWidget({Key? key}) : super(key: key);

  @override
  _ServiceWidgetState createState() => _ServiceWidgetState();
}
class _ServiceWidgetState extends State<ServiceWidget> {
  @override
  Widget build(BuildContext context) {
    BonsoirDiscoveryPackage _package = context.watch<BonsoirDiscoveryPackage>();
    List discoveredServices = _package.discoveredServices;
    List discoveredDevices = _package.discoveredDevices;
    bool serviceOn = true;
    bool _serviceOff = false;
    int mycounter;
    String deviceCount = "";
    if (discoveredServices.isEmpty) {
      return const Center(
        child: Text("Found no device with type ${MybonsoirService.type}"),
      );
    }
    else {
      return ListView.builder(
      itemCount: discoveredServices.length,
      itemBuilder: (BuildContext context, int index){

        final _results = discoveredDevices[index];
        final _resultson = discoveredDevices[index];
        print("Here we get our results");
        print(_results);
        print(_resultson);
        return MyService(
          service: _results
        );
      },
    );
    }
  }
}
class MyService extends StatelessWidget{
  final ResolvedBonsoirService service;
  const MyService({required this.service});

  @override
  Widget build(BuildContext context){

    bool isCorrect = false;
    String myvalue ="";
    ListTile(
      title:  Text(service!.name),
      subtitle: Text("Type : ${service.type}, ip : ${service!.ip}, port : ${service!.port}"),
    );
  }

}


