import 'dart:async';

import 'package:blue_app/communications/wifi/websocket_handler.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:blue_app/providers/robot_data_provider.dart';
import 'package:blue_app/communications/WiFi/http_requests.dart';
import 'package:blue_app/screen_template/screen_template.dart';
import 'package:control_pad/control_pad.dart';

class ControlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Velocidade Máxima",
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "${(context.watch<RobotData>().maxSpeed / 255 * 100).toStringAsFixed(0)} %",
            style: TextStyle(fontSize: 22),
          ),
          Slider(
            min: 76,
            max: 255,
            value: context.watch<RobotData>().maxSpeed.toDouble(),
            onChanged: (newValue) {
              Timer(Duration(milliseconds: 22), () {
                websocket.sink.add('{"max_speed":${newValue.toInt()}}');
              });
            },
          ),
          SizedBox(
            height: 92,
          ),
          JoystickView(
            size: 300,
            backgroundColor: Colors.black38,
            innerCircleColor: Colors.black45,
            interval: Duration(milliseconds: 22),
            onDirectionChanged: (degrees, intensity) {
              double rad = degrees * pi / 180;
              sendControllerCommand(intensity * cos(rad), intensity * sin(rad));
            },
          ),
        ],
      ),
    );
  }
}
