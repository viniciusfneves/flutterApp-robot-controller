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
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // This container will be the chat with the robot
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height - 100) * 0.4,
            decoration: BoxDecoration(
              color: Colors.lightGreen[100],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Text(
                "Chat",
                style: TextStyle(fontSize: 60),
              ),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          // Buttons
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height - 440),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buttonRow(),
                  buttonRow(),
                  buttonRow(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Gambiarra para exibir vários ícones
// TO-DO!  criar uma classe separada para exibir cada botão

Widget buttonRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      RaisedButton(
        color: Colors.red[600],
        onPressed: () {},
        child: Text(
          'Function 1',
          style: TextStyle(color: Colors.white),
        ),
      ),
      RaisedButton(
        color: Colors.red[600],
        onPressed: () {},
        child: Text(
          'Function 2',
          style: TextStyle(color: Colors.white),
        ),
      ),
      RaisedButton(
        color: Colors.red[600],
        onPressed: () {},
        child: Text(
          'Function 3',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}
