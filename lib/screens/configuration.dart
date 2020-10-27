import 'package:blue_app/utils/default_base_screen/default_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:blue_app/services/bluetooth.dart';

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
              child: buttons(6),
            ),
          )
        ],
      ),
    );
  }
}

// Gambiarra para exibir vários ícones
// TO-DO!  criar uma classe separada para exibir cada botão

Widget buttons(int quantity) {
  List<Widget> buttons = new List<Widget>();
  for (int i = 1; i <= (quantity); i++) {
    buttons.add(
      RaisedButton(
        color: Colors.red[600],
        onPressed: () {},
        child: Text(
          'Função $i',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
  return Wrap(
    alignment: WrapAlignment.spaceAround,
    children: [
      ...buttons,
    ],
  );
}
