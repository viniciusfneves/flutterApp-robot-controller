import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';

class Bluetooth extends StatefulWidget {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  State<StatefulWidget> createState() => _BluetoothState();

  Future<List<BluetoothDevice>> getDevices() async {
    List<BluetoothDevice> devices = new List<BluetoothDevice>();
    flutterBlue.scanResults.listen(
      (scanResult) {
        for (ScanResult result in scanResult) {
          if (!devices.contains(result.device)) {
            devices.add(result.device);
          }
        }
      },
    );
    await flutterBlue.startScan(timeout: Duration(seconds: 5));
    print('Scan concluído');
    flutterBlue.stopScan();
    return devices;
  }

  Future<Widget> deviceScreen() async {
    //List view;
    List<BluetoothDevice> availableDevices = await getDevices();
    return Center(child: Text('Descobertos ${availableDevices.length}'),) ;
  }
}

class _BluetoothState extends State<Bluetooth> {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
