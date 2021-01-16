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
            thickness: 1,
            color: Color.fromARGB(255, 160, 0, 5),
          ),
          // Botões de Liga e Desliga
          Container(
            child: standardButtons(context),
          ),
          Divider(
            thickness: 1,
            color: Color.fromARGB(255, 160, 0, 5),
          ),
          // Botões de configurações gerais
          Flexible(
            flex: 6,
            child:
                SingleChildScrollView(child: makeMultipleButtons(context, 16)),
          ),
        ],
      ),
    );
  }
}

// Gambiarra para exibir vários ícones
// TO-DO!  criar uma classe separada para exibir cada botão

Widget button(BuildContext context, String title, {bool essencials = false}) {
  double containerWidth;
  EdgeInsetsGeometry buttonPadding;
  if (essencials) {
    containerWidth = 2.08;
    buttonPadding = EdgeInsets.only(top: 4, bottom: 4);
  } else {
    containerWidth = 3.2; // Caso de 4 botões em linha, usar 4.36
    buttonPadding = EdgeInsets.only(top: 4, bottom: 12);
  }

  return Container(
    width: MediaQuery.of(context).size.width / containerWidth,
    child: Padding(
      padding: buttonPadding,
      child: RaisedButton(
        padding: EdgeInsets.only(top:18, bottom: 18),
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
    ),
  );
}

// Botões padrões para ligar e desligar o robô
// Sempre exibidos na parte superior da tela
Widget standardButtons(BuildContext context) {
  return Wrap(
    spacing: 8,
    children: [
      button(context, 'Ligar', essencials: true),
      button(context, 'Desligar', essencials: true)
    ],
  );
}

Widget makeMultipleButtons(BuildContext context, int quantity) {
  List<Widget> buttons = new List<Widget>();
  for (int i = 1; i <= (quantity); i++) {
    buttons.add(button(context, "Função $i"));
  }
  return Wrap(
    spacing: 8,
    children: [
      ...buttons,
    ],
  );
}
