import 'package:blue_app/colors/colors.dart';
import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Essa Classe cria uma tela base com toda a navegação e estilo
// seguido por esse aplicativo. Recebe como parâmetro um Widget em
// bodyWidget que será adicionado como corpo da página criada

class AppDrawer extends StatelessWidget {
  const AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    height: 78,
                    width: 78,
                    child: SvgPicture.asset(
                      "lib/assets/images/LogoMinerva.svg",
                      color: AppColors.standardRed,
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Minerva Wi-Fi Controller',
                    style: TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          const DrawerPageLink(
            route: AppRoutes.configuration,
            icon: Icons.miscellaneous_services,
            title: 'Configurações',
          ),
          const DrawerPageLink(
            route: AppRoutes.telemetry,
            icon: Icons.wifi_tethering,
            title: 'Telemetria',
          ),
          const DrawerPageLink(
            route: AppRoutes.controller,
            icon: Icons.control_camera_sharp,
            title: 'Controle Remoto',
          )
        ],
      ),
    );
  }
}

class DrawerPageLink extends ConsumerWidget {
  final IconData icon;
  final String title;
  final AppRoutes route;

  const DrawerPageLink({
    Key? key,
    required this.icon,
    required this.title,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            ref.read(selectedPage.state).update((_) => route);
            Navigator.of(context).pop();
          },
          contentPadding: const EdgeInsets.only(left: 18),
          title: Text(
            title,
            style: const TextStyle(fontSize: 15),
          ),
          leading: Icon(icon),
        ),
        const Divider()
      ],
    );
  }
}
