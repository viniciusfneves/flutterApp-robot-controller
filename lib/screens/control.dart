import 'package:blue_app/communications/wifi/websocket_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blue_app/providers/robot_data_provider.dart';
//import 'package:blue_app/communications/WiFi/http_requests.dart';
import 'package:blue_app/screen_template/screen_template.dart';

class ControlPage extends StatefulWidget {
  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  int _valueHolder = 165;
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
          Selector<RobotData, int>(
            selector: (_, robotData) => robotData.maxSpeed,
            builder: (_, maxSpeed, __) {
              return Text(
                "${(maxSpeed / 255 * 100).toStringAsFixed(0)} %",
                style: TextStyle(fontSize: 22),
              );
            },
          ),
          Slider(
            min: 76,
            max: 255,
            value: _valueHolder.toDouble(),
            onChanged: (value) {
              setState(() {
                _valueHolder = value.toInt();
              });
            },
            onChangeEnd: (finalValue) {
              websocket.sink.add('{"max_speed":${finalValue.toInt()}}');
            },
            divisions: 100,
            label: "${(_valueHolder / 255 * 100).toStringAsFixed(0)} %",
          )
        ],
      ),
    );
  }
}
