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
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(24)),
            ),
            Container(
              alignment: Alignment.center,
              width: 50,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(top: 135, left: 14),
              child: Text(
                255.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 50,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(top: 135, left: 230),
              child: Text(
                255.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
