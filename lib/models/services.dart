import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:mybonsoir/models/broadcast.dart';
import 'package:mybonsoir/models/broadcast.dart';
import 'package:mybonsoir/models/discovery.dart';
import 'package:provider/provider.dart';
import 'package:bonsoir/bonsoir.dart';

class MybonsoirService{
  static const String type = "mybonsoir._tcp";
  static int port = 4030;
  static BonsoirService? myservice;
  static String? myname;
  String get _type => type;

 static Future<BonsoirService?> getBonsoirService()async{
   if(myservice! != null){
     return myservice!;
   }
   if(Platform.isAndroid){
     myname = (await DeviceInfoPlugin().androidInfo).model;
   }
   else if (Platform.isLinux){
     myname = (await DeviceInfoPlugin().linuxInfo).version;
   }

   else if(Platform.isMacOS){
     myname = (await DeviceInfoPlugin().macOsInfo).model;
   }

   else if (Platform.isWindows){
     myname = (await DeviceInfoPlugin().windowsInfo).computerName;
   }

   else if (Platform.isIOS){
     myname = (await DeviceInfoPlugin().iosInfo).model;
   }
   else{
     myname = "My Device";
   }
   //myname += "Bonsoir";
   myservice = BonsoirService(name: myname!, type: type, port: port);
   return myservice!;
 }

}
