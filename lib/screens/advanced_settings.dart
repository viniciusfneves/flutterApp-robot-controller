import 'dart:async';

import 'package:blue_app/data/robot_configs.dart';
import 'package:blue_app/data/robot_info.dart';
import 'package:blue_app/data/robot_telemetry.dart';
import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/style/buttons.dart';
import 'package:blue_app/style/colors.dart';
import 'package:blue_app/style/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdvancedSettingsPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController adressController = useTextEditingController();
    final TextEditingController debugMessageController =
        useTextEditingController();
    final adress = ref.watch(wsAdress);
    final infos = ref.watch(robotInfo);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RobotNameText(infos.name),
          const SizedBox(
            height: 50,
          ),
          const ConfigTitleText("Connection Adress"),
          ConfigTextField(
            controller: adressController,
            data: adress,
          ),
          SetConfigButton(
            text: "Update",
            onPressed: () {
              if (adressController.text == adress) return;
              ref.read(ws).sink.close();
              ref.read(wsAdress.state).update((_) => adressController.text);
              ref.read(robotConfig.notifier).update((_) => RobotConfigs());
              ref.read(robotInfo.notifier).update((_) => RobotInfos());
              ref.read(robotTelemetry.notifier).update((_) => RobotTelemetry());
            },
            onLongPress: () async {
              final holder = adressController.text;
              ref.read(ws).sink.close();
              ref.read(wsAdress.state).update((_) => "ws://1.1.1.1:41");
              ref.read(ws).sink.close();
              await Future.delayed(const Duration(milliseconds: 500));
              ref.read(wsAdress.state).update((_) => holder);
            },
          ),
          const SizedBox(height: 16),
          const ConfigTitleText("Debug Message"),
          const ConfigTitleText("(JSON)"),
          ConfigTextField(controller: debugMessageController),
          SetConfigButton(
            onPressed: () {
              ref.read(ws).sink.add(debugMessageController.text);
            },
            text: "Send",
          ),
        ],
      ),
    );
  }
}

class ConfigTextField extends StatelessWidget {
  const ConfigTextField({
    Key? key,
    this.data,
    required this.controller,
  }) : super(key: key);

  final String? data;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    controller.text = data ?? "";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: TextField(
        style: const TextStyle(fontSize: 18),
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.standardRed),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.standardRed, width: 2),
          ),
        ),
        cursorColor: AppColors.standardRed,
        textAlign: TextAlign.center,
        controller: controller,
      ),
    );
  }
}
