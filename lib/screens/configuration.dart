import 'package:blue_app/utils/default_base_screen/default_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:blue_app/services/bluetooth.dart';
import 'package:blue_app/utils/theme_controller.dart';
import 'package:provider/provider.dart';

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
          // Chat
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
          // Divider
          Divider(
            color: Color.fromARGB(255, 160, 0, 5),
          ),
          // Buttons
          Flexible(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                standardButtons(context),
                makeMultipleButtons(context, 16)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Gambiarra para exibir vários ícones
// TO-DO!  criar uma classe separada para exibir cada botão

Widget button(BuildContext context, String title, {int qtd = 4}) {
  double containerWidth;
  if (qtd == 2) {
    containerWidth = 2.07;
  } else {
    containerWidth = qtd + 0.25;
  }
  return Container(
    width: MediaQuery.of(context).size.width / containerWidth,
    child: RaisedButton(
      color: Provider.of<ThemeController>(context).isDarkMode
          ? Color.fromARGB(200, 160, 0, 5)
          : Colors.red[900],
      onPressed: () {},
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
        overflow: TextOverflow.fade,
      ),
    ),
  );
}

Widget standardButtons(BuildContext context) {
  return Wrap(
    alignment: WrapAlignment.spaceAround,
    children: [
      button(context, 'Ligar', qtd: 2),
      button(context, 'Desligar', qtd: 2)
    ],
  );
}

Widget makeMultipleButtons(BuildContext context, int quantity) {
  List<Widget> buttons = new List<Widget>();
  for (int i = 1; i <= (quantity); i++) {
    buttons.add(button(context, "Função $i"));
  }
  return Wrap(
    alignment: WrapAlignment.spaceAround,
    children: [
      ...buttons,
    ],
  );
}
