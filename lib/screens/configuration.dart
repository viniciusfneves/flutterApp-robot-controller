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
          Flexible(
            flex: 5,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black12,
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
          ),
          Divider(
            thickness: 1,
          ),
          // Buttons
          Flexible(
            flex: 6,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height - 440),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: buttons(context, 24),
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

Widget buttons(BuildContext context, int quantity) {
  List<Widget> buttons = new List<Widget>();
  for (int i = 1; i <= (quantity); i++) {
    buttons.add(
      Container(
        width: MediaQuery.of(context).size.width / 4.22,
        child: RaisedButton(
          color: Colors.red[600],
          onPressed: () {},
          child: Text(
            'Função $i',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
            overflow: TextOverflow.fade,
          ),
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
