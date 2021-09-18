import 'package:blue_app/screens/screen_template/screen_template.dart';
import 'package:flutter/material.dart';

class ConfigurationPage extends StatefulWidget {
  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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

// Cria Widget para cada botão do ação do APP
// Caso essencials = 2, exibe 2 botões por linha, do contrário, exibe 3 botões por linha
Widget button(BuildContext context, String title, {bool essencials = false}) {
  double containerWidth;
  EdgeInsetsGeometry buttonPadding;
  if (essencials) {
    containerWidth = 2.07;
    buttonPadding = EdgeInsets.only(top: 20, bottom: 8);
  } else {
    containerWidth = 3.3; // Caso de 4 botões em linha, usar 4.36
    buttonPadding = EdgeInsets.only(top: 4, bottom: 0);
  }

  return Container(
    width: MediaQuery.of(context).size.width / containerWidth,
    child: Padding(
      padding: buttonPadding,
      child: RaisedButton(
        padding: EdgeInsets.only(top: 18, bottom: 18),
        color: Color.fromARGB(200, 160, 0, 5),
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

// Gambiarra para exibir vários ícones
Widget makeMultipleButtons(BuildContext context, int quantity) {
  List<Widget> buttons = new List<Widget>();
  for (int i = 1; i <= (quantity); i++) {
    buttons.add(button(context, "Função $i"));
  }
  return Wrap(
    spacing: 16,
    runSpacing: 12,
    children: [
      ...buttons,
    ],
  );
}

Widget chat(BuildContext context) {
  return Flexible(
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
  );
}
