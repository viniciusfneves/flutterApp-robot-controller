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
    final infos = ref.watch(robotInfo);
    final connection = ref.watch(ws.notifier);
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
            data: connection.adress,
          ),
          SetConfigButton(
            text: "Update",
            onPressed: () {
              ref
                  .read(ws.notifier)
                  .changeConnectionAdress(adressController.text);
              ref.read(robotConfig.notifier).update((_) => RobotConfigs());
              ref.read(robotInfo.notifier).update((_) => RobotInfos());
              ref.read(robotTelemetry.notifier).update((_) => RobotTelemetry());
            },
          ),
          const SizedBox(height: 16),
          const ConfigTitleText("Debug Message"),
          const ConfigTitleText("(JSON)"),
          ConfigTextField(controller: debugMessageController),
          SetConfigButton(
            onPressed: () {
              ref.read(ws.notifier).sendMessage(debugMessageController.text);
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
