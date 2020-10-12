import 'package:blue_app/utils/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer_link.dart';

// Essa Classe cria uma tela base com toda a navegação e estilo
// seguido por esse aplicativo. Recebe como parâmetro um Widget em
// bodyWidget que será adicionado como corpo da página criada

class ScreenBase extends StatefulWidget {
  @required
  final Widget bodyWidget;

  const ScreenBase({Key key, this.bodyWidget}) : super(key: key);

  @override
  _ScreenBaseState createState() => _ScreenBaseState();
}

class _ScreenBaseState extends State<ScreenBase> {
  bool isDarkTheme = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MinervApp'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(children: <Widget>[
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'lib/assets/images/minerva_logo.jpg',
                  height: 80,
                ),
                Text(
                  'Minerva Bluetooth App',
                  style: TextStyle(fontSize: 18),
                  overflow: TextOverflow.fade,
                  softWrap: true,
                ),
              ],
            ),
          ),
          DrawerLink(
            icon: Icons.bluetooth,
            title: 'Conections',
            pageRoute: AppRoutes.Connection,
          ),
          DrawerLink(
            icon: Icons.account_tree_outlined,
            title: 'Configuration',
            pageRoute: AppRoutes.Configuration,
          ),
          DrawerLink(
            icon: Icons.blur_circular,
            title: 'Controls',
            pageRoute: AppRoutes.Control,
          ),
          // Dark Mode Switch
          DrawerLink(
            icon: Icons.brightness_2,
            title: 'Dark Mode',
            trailing: Switch(
              value: isDarkTheme,
              onChanged: (bool value) {
                setState(() {
                  isDarkTheme = value;
                });
              },
            ),
          )
        ]),
      ),
      body: this.widget.bodyWidget,
    );
  }
}
