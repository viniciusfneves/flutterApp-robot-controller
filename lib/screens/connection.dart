import 'package:blue_app/utils/app_routes.dart';
import 'package:blue_app/utils/theme_controller.dart';
import 'package:blue_app/services/bluetooth.dart';
import 'package:blue_app/utils/default_base_screen/default_base_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ConectionPage extends StatefulWidget {
  @override
  _ConectionPageState createState() => _ConectionPageState();
}

class _ConectionPageState extends State<ConectionPage> {
  final Bluetooth blue = Bluetooth();

  List<BluetoothDevice> alreadyDiscoveredDevices = new List<BluetoothDevice>();

  List<Widget> devicesWidget = new List<Widget>();
  
  @override
  void initState() {
    super.initState();
    blue.searchDevices();
  }

  void _buildDevicesListView(BluetoothDevice device) {
    if (!alreadyDiscoveredDevices.contains(device)) {
      print('Adding Device to List. ID:${device.id}');
      devicesWidget.add(
        ListTile(
          title: device.name != '' ? Text(device.name) : Text('Unknow Device'),
          subtitle: Text(device.id.toString()),
          trailing: Consumer(builder:
              (BuildContext context, ThemeController controller, Widget child) {
            bool darkTheme = Provider.of<ThemeController>(context).isDarkMode;
            return RaisedButton(
              child: Text(
                'Conect',
                style: TextStyle(color: Colors.white),
              ),
              color: darkTheme ? Colors.red[800] : Colors.blue,
              onPressed: () async {
                await device.connect(timeout: Duration(seconds: 10));
                print('Trying to connect to device.\nid: ${device.id}');
              },
            );
          }),
        ),
      );
      alreadyDiscoveredDevices.add(device);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: blue.flutterBlue.isOn,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot isOn) {
        if (isOn.hasData)
          return isOn.data
              ? ScreenBase(
                  bodyWidget: Center(
                    child: StreamBuilder(
                      stream: blue.deviceStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          _buildDevicesListView(snapshot.data);
                        }
                        if (snapshot.connectionState == ConnectionState.done)
                          return Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, bottom: 3),
                                  child: Text(
                                    'Busca Finalizada',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Color.fromARGB(255, 190, 0, 0),
                              ),
                              ...devicesWidget,
                            ],
                          );
                        if (snapshot.connectionState == ConnectionState.active)
                          return Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          'Buscando Dispositivos',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
                                        child: Container(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.black26,
                                            valueColor: AlwaysStoppedAnimation(
                                                Color.fromARGB(255, 200, 0, 0)),
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
                              ...devicesWidget,
                            ],
                          );
                        else
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Container(
                                    width: 72,
                                    height: 72,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          Color.fromARGB(255, 200, 0, 0)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    'Buscando Dispositivos',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                )
                              ],
                            ),
                          );
                      },
                    ),
                  ),
                )
              : ScreenBase(
                  bodyWidget: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                              'Seu bluetooth está desabilitado no momento!'),
                        ),
                        Text(
                            'Habilite-o na barra do sistema e clicke no botão abaixo'),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: RaisedButton(
                            child: Text('Refresh'),
                            onPressed: () => Navigator.pushNamed(
                                context, AppRoutes.Connection),
                          ),
                        )
                      ],
                    ),
                  ),
                );
        else
          return Center(
              child: Container(
            color: Colors.red[800],
          ));
      },
    );
  }
}
