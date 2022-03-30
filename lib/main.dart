import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/routes/app_routes.dart';
import 'package:blue_app/screens/advanced_settings.dart';
import 'package:blue_app/screens/components/dialog/ws_adress.dart';
import 'package:blue_app/screens/components/drawer/app_drawer.dart';
import 'package:blue_app/screens/configuration.dart';
import 'package:blue_app/screens/controller.dart';
import 'package:blue_app/screens/telemetry.dart';
import 'package:blue_app/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget? body;
    ref.watch(robotConnection);
    final page = ref.watch(selectedPage);
    final isDarkTheme = ref.watch(themeIsDark);
    switch (page) {
      case AppRoutes.configuration:
        body = ConfigurationPage();
        break;
      case AppRoutes.telemetry:
        body = TelemetryPage();
        break;
      case AppRoutes.controller:
        body = ControllerPage();
        break;
      case AppRoutes.advancedSettings:
        body = AdvancedSettingsPage();
        break;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MinervApp Wi-Fi Controller Software",
      scrollBehavior: const CupertinoScrollBehavior(),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("MinervApp"),
          centerTitle: true,
          backgroundColor: AppColors.standardRed,
          actions: const [AdvancedConfigsDoor()],
        ),
        drawer: AppDrawer(page: page),
        body: body,
      ),
    );
  }
}

class AdvancedConfigsDoor extends ConsumerWidget {
  const AdvancedConfigsDoor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref.read(selectedPage.state).update((_) => AppRoutes.advancedSettings);
      },
      onLongPress: () {
        showCupertinoDialog(
          context: context,
          builder: (_) => const ConnectionAdress(),
        );
      },
      child: const Icon(
        Icons.settings,
        color: Colors.white,
      ),
    );
  }
}

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
