import 'dart:async';

import 'package:blue_app/data/robot_configs.dart';
import 'package:blue_app/data/robot_info.dart';
import 'package:blue_app/data/robot_telemetry.dart';
import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/style/colors/colors.dart';
import 'package:blue_app/style/texts/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdvancedSettingsPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController adressController = useTextEditingController();
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
          AdressField(adress: adress, adressController: adressController),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => AppColors.standardRed,
              ),
            ),
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
              ref.read(wsAdress.state).update((_) => "ws://1.1.1.1:41");
              ref.read(ws).sink.close();
              await Future.delayed(const Duration(milliseconds: 500));
              ref.read(wsAdress.state).update((_) => holder);
            },
            child: const Text(
              "Update",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}

class AdressField extends StatelessWidget {
  const AdressField({
    Key? key,
    required this.adress,
    required this.adressController,
  }) : super(key: key);

  final String adress;
  final TextEditingController adressController;

  @override
  Widget build(BuildContext context) {
    adressController.text = adress;
    return TextField(
      style: const TextStyle(fontSize: 18),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      cursorColor: AppColors.standardRed,
      textAlign: TextAlign.center,
      controller: adressController,
    );
  }
}
