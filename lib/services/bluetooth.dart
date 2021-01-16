import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';

class Bluetooth {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  final StreamController<BluetoothDevice> _deviceStream =
      new StreamController<BluetoothDevice>();

  Stream<BluetoothDevice> get deviceStream => _deviceStream.stream;

  void searchDevices() async {
    flutterBlue.scanResults.listen(
      (scanResult) {
        for (ScanResult result in scanResult) {
          _deviceStream.sink.add(result.device);
          print('Found Device! ID: ${result.device.id.toString()}');
        }
      },
    );
    await flutterBlue.startScan(
        timeout: Duration(seconds: 12), scanMode: ScanMode.balanced);
    _deviceStream.close();
  }
}
