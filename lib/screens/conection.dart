import 'package:blue_app/utils/bluetooth.dart';
import 'package:blue_app/utils/screen_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ConectionPage extends StatefulWidget {
  @override
  _ConectionPageState createState() => _ConectionPageState();
}

class _ConectionPageState extends State<ConectionPage> {
  final Bluetooth blue = Bluetooth();

  List<BluetoothDevice> alreadyDiscoveredDevices = new List<BluetoothDevice>();

  List<Widget> devicesWidget = new List<Widget>();

  get getDevicesWidget {
    return devicesWidget;
  }

  @override
  void initState() {
    super.initState();
    blue.searchDevices();
  }

  void _buildDevicesListView(BluetoothDevice device) {
    if (!alreadyDiscoveredDevices.contains(device))
      devicesWidget.add(
        ListTile(
          title: device.name != '' ? Text(device.name) : Text('Unknow Name'),
          subtitle: Text(device.id.toString()),
          trailing: RaisedButton(
            child: Text('Conect'),
            onPressed: () {
              device.connect();
              print('Trying to connect to device.\nid: ${device.id}');
            },
          ),
        ),
      );
    alreadyDiscoveredDevices.add(device);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      bodyWidget: Center(
        child: StreamBuilder(
          stream: blue.deviceStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) _buildDevicesListView(snapshot.data);
            if (snapshot.connectionState == ConnectionState.done)
              return Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        child: Text(
                          'Busca Finalizada',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 190, 0, 0),
                  ),
                  ...getDevicesWidget,
                ],
              );
            if (snapshot.connectionState == ConnectionState.active)
              return Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Buscando Dispositivos',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 190, 0, 0),
                  ),
                  ...getDevicesWidget,
                ],
              );
            else
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Color.fromARGB(255, 200, 0, 0)),
                ),
              );
          },
        ),
      ),
    );
  }
}
