import 'package:blue_app/communications/WiFi/websocket_handler.dart';
import 'package:blue_app/providers/widget_states_provider.dart';
import 'package:provider/provider.dart';
import 'package:blue_app/screen_template/screen_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigurationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      bodyWidget: Center(
          child: Column(
        children: [
          // Display de estado
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 32,
                height: 32,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: context.watch<RobotWidgetState>().readystate),
              ),
              Container(
                width: 32,
                height: 32,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: context.watch<RobotWidgetState>().fightstate),
              ),
              Container(
                width: 32,
                height: 32,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: context.watch<RobotWidgetState>().disabledstate),
              )
            ],
          ),

          // Botões de controle de estado
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 120,
                height: 80,
                child: ElevatedButton(
                    child: Text(
                      "Start",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: getStyle(Color.fromARGB(255, 25, 150, 25)),
                    onPressed: () {
                      websocket.sink.add('{"event_request": "start"}');
                      context.read<RobotWidgetState>().setFightState();
                    }),
              ),
              Container(
                width: 135,
                height: 80,
                child: ElevatedButton(
                    child: Text(
                      "Disengage",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: getStyle(Color.fromARGB(255, 200, 25, 25)),
                    onPressed: () {
                      websocket.sink.add('{"event_request": "terminate"}');
                      context.read<RobotWidgetState>().setDisabledState();
                    }),
              ),
              Container(
                width: 90,
                height: 80,
                child: ElevatedButton(
                    child: Text(
                      "Arm",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: getStyle(Color.fromARGB(255, 190, 150, 0)),
                    onPressed: () {
                      websocket.sink.add('{"event_request": "reset"}');
                      context.read<RobotWidgetState>().setReadyState();
                    }),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

ButtonStyle getStyle(Color color) {
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(color),
      padding:
          MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(18)));
}
