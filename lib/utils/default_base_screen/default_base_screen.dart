import 'package:blue_app/utils/app_routes.dart';
import 'package:blue_app/utils/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawer_links.dart';

// Essa Classe cria uma tela base com toda a navegação e estilo
// seguido por esse aplicativo. Recebe como parâmetro um Widget em
// bodyWidget que será adicionado como corpo da página criada

class ScreenBase extends StatelessWidget {
  @required
  final Widget bodyWidget;

  ScreenBase({Key key, this.bodyWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MinervApp'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
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
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
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
            Consumer(
              builder: (BuildContext context, ThemeController controller,
                  Widget child) {
                return ListTile(
                  title: Text('Dark Mode'),
                  leading: Icon(Icons.brightness_2),
                  trailing: Switch(
                    value: Provider.of<ThemeController>(context).isDarkMode,
                    onChanged: (value) {
                      controller.changeTheme();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
      body: this.bodyWidget,
    );
  }
}
