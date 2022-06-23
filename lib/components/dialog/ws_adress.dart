import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robot_controller/data/robot_configs.dart';
import 'package:robot_controller/data/robot_info.dart';
import 'package:robot_controller/data/robot_telemetry.dart';
import 'package:robot_controller/providers/providers.dart';
import 'package:robot_controller/screens/advanced_settings.dart';
import 'package:robot_controller/style/buttons.dart';
import 'package:robot_controller/style/colors.dart';

class ConnectionAdress extends HookConsumerWidget {
  const ConnectionAdress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adressController = useTextEditingController();
    final connection = ref.watch(ws.notifier);
    return AlertDialog(
      title: const Text("Robot Address"),
      content: ConfigTextField(
        controller: adressController,
        data: connection.adress,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "OK",
            style: TextStyle(fontSize: 18, color: AppColors.lightRed),
          ),
        ),
        SetConfigButton(
          text: "Update",
          onPressed: () {
            ref.read(robotConfig.notifier).update((_) => RobotConfigs());
            ref.read(robotInfo.notifier).update((_) => RobotInfos());
            ref.read(robotTelemetry.notifier).update((_) => RobotTelemetry());
            ref.read(ws.notifier).changeConnectionAdress(adressController.text);
          },
        )
      ],
    );
  }
}
