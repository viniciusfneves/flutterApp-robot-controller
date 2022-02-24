import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/routes/app_routes.dart';
import 'package:blue_app/style/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Essa Classe cria uma tela base com toda a navegação e estilo
// seguido por esse aplicativo. Recebe como parâmetro um Widget em
// bodyWidget que será adicionado como corpo da página criada

class AppDrawer extends StatelessWidget {
  const AppDrawer({required this.page});

  final AppRoutes page;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "lib/assets/images/LogoMinerva.svg",
                    width: 75,
                    color: AppColors.standardRed,
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
          DrawerPageLink(
            route: AppRoutes.configuration,
            icon: Icons.miscellaneous_services,
            title: 'Configurações',
            isSelected: page == AppRoutes.configuration,
          ),
          DrawerPageLink(
            route: AppRoutes.telemetry,
            icon: Icons.wifi_tethering,
            title: 'Telemetria',
            isSelected: page == AppRoutes.telemetry,
          ),
          DrawerPageLink(
            route: AppRoutes.controller,
            icon: Icons.control_camera_sharp,
            title: 'Controle Remoto',
            isSelected: page == AppRoutes.controller,
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
  final bool isSelected;

  const DrawerPageLink({
    Key? key,
    required this.icon,
    required this.title,
    required this.route,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(left: 24, top: 8, bottom: 8),
          leading: Icon(icon),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          selected: isSelected,
          selectedColor: Colors.black,
          selectedTileColor: Colors.black12,
          onTap: () {
            ref.read(selectedPage.state).update((_) => route);
            Navigator.of(context).pop();
          },
        ),
        const Divider(height: 0, thickness: 1.2, endIndent: 12, indent: 12)
      ],
    );
  }
}
