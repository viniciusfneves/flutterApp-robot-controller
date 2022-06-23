import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robot_controller/providers/providers.dart';
import 'package:robot_controller/routes/app_routes.dart';
import 'package:robot_controller/style/colors.dart';
import 'package:robot_controller/style/texts.dart';

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
            title: 'Controle',
            isSelected: page == AppRoutes.controller,
          ),
          const Expanded(child: SizedBox()),
          const DesignInformations(),
          const Divider(height: 0, thickness: 1.2),
          const ThemeSwitch(),
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
          selectedColor: ref.read(themeIsDark.notifier).state
              ? Colors.white
              : Colors.black,
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

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeIsDark);
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 24, top: 8, bottom: 8),
      leading: const Icon(Icons.dark_mode_sharp),
      title: const Text(
        "DarkMode",
        style: TextStyle(fontSize: 16),
      ),
      trailing: Switch.adaptive(
        value: theme,
        onChanged: (newState) {
          ref.read(themeIsDark.notifier).state = newState;
        },
      ),
    );
  }
}

class DesignInformations extends StatelessWidget {
  const DesignInformations();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        GeneralPurposeText(
          "Coded by Vinícius F. Neves",
          fontSize: 14,
          padding: EdgeInsets.all(8),
        ),
      ],
    );
  }
}
