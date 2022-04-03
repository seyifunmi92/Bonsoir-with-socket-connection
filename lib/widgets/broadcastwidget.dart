import 'package:flutter/material.dart';
import 'package:mybonsoir/models/broadcast.dart';
import 'package:mybonsoir/models/discovery.dart';
import 'package:provider/provider.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:socket_io_client/socket_io_client.dart';


class BroadcastWidget extends StatelessWidget {
  const BroadcastWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isReady = false;
    bool letsBroadcast = false;
    String connect = "";
    BonsoirBroadcastPackage _broadwidget = context.watch<BonsoirBroadcastPackage>();
    return RaisedButton(
      onPressed: (){_onClick(_broadwidget);},
      child: Column(
        children: [
          const Text("Click To Broadcast"),
          const SizedBox(height: 10,),
          Switch(
            value: _broadwidget.isBroadcasting,
            onChanged: (value){_onClick(_broadwidget);},
            activeColor: Colors.white10,
            activeTrackColor: Colors.black45,
          ),
        ],
      ),
    );
  }
}
void _onClick(BonsoirBroadcastPackage _broadwidget){
  if(_broadwidget.isBroadcasting){
    _broadwidget.stopBroadcast();
  }
  else{
    _broadwidget.startBroadcast();
  }

}

