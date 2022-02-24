import 'package:blue_app/models/components/app_drawer.dart';
import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/routes/app_routes.dart';
import 'package:blue_app/screens/configuration.dart';
import 'package:blue_app/screens/controller.dart';
import 'package:blue_app/screens/telemetry.dart';
import 'package:blue_app/style/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerStatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends ConsumerState<MyApp> {
  Widget? body;
  @override
  Widget build(BuildContext context) {
    final page = ref.watch(selectedPage);
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
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MinervApp Wi-Fi Controller Software",
      scrollBehavior: const CupertinoScrollBehavior(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("MinervApp"),
          centerTitle: true,
          backgroundColor: AppColors.standardRed,
        ),
        drawer: AppDrawer(page: page),
        body: body,
      ),
    );
  }
}

void main() {
  runApp(ProviderScope(child: MyApp()));
}
