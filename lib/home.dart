import 'dart:async';
import 'dart:io';
import 'package:udp/udp.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<home> {
  Timer _timer;
  int i=0;
  var recibido;
  @override
  void initState() {
    _initializeTimer();
    udp();
    super.initState();
  }

  void _initializeTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(const Duration(seconds: 4), initState);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "~~UDP~~",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(25, 5)))),
       /*  body: Center(
          child: Column(
            children: <Widget>[
              Text(
                recibido,
              )
            ],
          ),
        ) */);
  }

  void udp() async {

    var unicastEndpoint = Endpoint.broadcast(/* InternetAddress("255.255.255.255"), */ port: Port(41235));
    //var multicastEndpoint = Endpoint.unicast(InternetAddress("192.168.3.179"), port: Port(41235));
  //  var receiver = await UDP.bind(unicastEndpoint);
    
    try {
      var sender = await UDP.bind(Endpoint.any());
      await sender.send(("HOLA "+ (DateTime.now()).toString()).codeUnits, unicastEndpoint);
    } catch (e) {
       print("ERORORROROROR"+e.toString());
    }
     
     print("Envaido");
/*     print("Listening...");
     receiver.listen((datagram) {
      if (datagram != null) {
        try {
          recibido = String.fromCharCodes(datagram.data);
        //stdout.write(recibido);
        if (recibido != null) {
          final js = json.decode(recibido);
          print(recibido);
         
        }
        } catch (e) {
        print("ERORORROROROR"+e.toString());
        }
                
      }
    }); */ //timeout: Duration(seconds: 3));
  //  await Future.delayed(Duration(seconds: 5));

    //receiver.close();

  }
}
