import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';

class Bluetooth extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BluetoothState();

  final FlutterBlue flutterBlue = FlutterBlue.instance;

  final _deviceStream = StreamController();

  get deviceStream => _deviceStream.stream;

  void searchDevices() async {
    flutterBlue.scanResults.listen(
      (scanResult) {
        for (ScanResult result in scanResult) {
          _deviceStream.sink.add(result.device);
          print(result.device.id.toString());
        }
      },
    );
    await flutterBlue.startScan(timeout: Duration(seconds: 10));
    _deviceStream.close();
  }
}

class _BluetoothState extends State<Bluetooth> {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
