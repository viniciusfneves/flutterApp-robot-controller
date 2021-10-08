import 'package:blue_app/app_routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:blue_app/providers/widget_state_provider.dart';
import 'package:flutter/material.dart';

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
        title: Text(context.watch<WidgetState>().mainAppTitle),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 160, 25, 25),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 90,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "lib/assets/images/LogoMinervaVermelho.png"),
                      ),
                    ),
                  ),
                  Text(
                    'Minerva Wi-Fi Controller',
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            DrawerLink(
              icon: Icons.bluetooth,
              title: 'Configurações',
              pageRoute: AppRoutes.Configuration,
            ),
            DrawerLink(
              icon: Icons.ten_k,
              title: 'Telemetria',
              pageRoute: AppRoutes.Telemetry,
            ),
            DrawerLink(
              icon: Icons.blur_circular,
              title: 'Controle Remoto',
              pageRoute: AppRoutes.Control,
            ),
            DrawerLink(
              icon: Icons.blur_circular,
              title: 'Controle Avançado',
              pageRoute: AppRoutes.AdvancedControl,
            ),
          ],
        ),
      ),
      body: this.bodyWidget,
    );
  }
}
