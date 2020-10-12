import 'package:blue_app/utils/screen_base.dart';
import 'package:flutter/material.dart';
import 'package:blue_app/utils/bluetooth.dart';

class ConfigurationPage extends StatefulWidget {
  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final Bluetooth blue = Bluetooth();
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      bodyWidget: Center(
          child: Column(
        children: [
          Text('Configuration'),
        ],
      )),
    );
  }
}
