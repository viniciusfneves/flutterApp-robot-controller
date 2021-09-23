import 'dart:convert';
import 'package:blue_app/communications/json/json_handler.dart';
import 'package:blue_app/communications/wifi/websocket_handler.dart';
import 'package:blue_app/screen_template/screen_template.dart';
import 'package:flutter/material.dart';

class TelemetryPage extends StatefulWidget {
  @override
  State<TelemetryPage> createState() => _TelemetryPageState();
}

class _TelemetryPageState extends State<TelemetryPage> {
  void initState() {
    websocketData.listen((data) {
      Map<String, dynamic> json = jsonDecode(data);
      processJsonMessage(context, json);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      bodyWidget: Center(
        child: Text(
          'Telemetria',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
