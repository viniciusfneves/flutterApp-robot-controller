import 'dart:convert';
import 'package:blue_app/communications/wifi/websocket_handler.dart';
import 'package:blue_app/providers/widget_state_provider.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:blue_app/providers/robot_data_provider.dart';
import 'package:blue_app/communications/WiFi/http_requests.dart';
import 'package:blue_app/screen_template/screen_template.dart';
import 'package:control_pad/control_pad.dart';

class ControlPage extends StatefulWidget {
  ControlPage({Key key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  // void initState() {
  //   super.initState();
  //   websocket.stream.asBroadcastStream().listen((data) {
  //     Map<String, dynamic> json = jsonDecode(data);
  //     if (json.containsKey('robot_name')) {
  //       context.read<WidgetState>().addRobotNameToAppTitle(json['robot_name']);
  //     }
  //   });
  // }

  double valor = 50;

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Velocidade Máxima",
            style: TextStyle(fontSize: 24),
          ),
          Container(
            height: 8,
          ),
          Text(
            "${(context.watch<RobotData>().maxSpeed / 255 * 100).toStringAsFixed(1)} %",
            style: TextStyle(fontSize: 24),
          ),
          Slider(
            min: 35,
            max: 255,
            value: valor,
            onChanged: (newValue) {
              setState(() {
                valor = newValue;
              });
            },
          ),
          Container(
            height: 55,
          ),
          JoystickView(
            size: 320,
            backgroundColor: Colors.black38,
            innerCircleColor: Colors.black45,
            interval: Duration(milliseconds: 500),
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
