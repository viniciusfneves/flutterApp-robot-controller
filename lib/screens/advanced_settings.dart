import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robot_controller/providers/providers.dart';
import 'package:robot_controller/screens/components/adjusts/adjust_field.dart';
import 'package:robot_controller/screens/components/dialog/error_dialog.dart';
import 'package:robot_controller/style/buttons.dart';
import 'package:robot_controller/style/colors.dart';
import 'package:robot_controller/style/texts.dart';

class AdvancedSettingsPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startTimeController = useTextEditingController();
    final kpController = useTextEditingController();
    final kiController = useTextEditingController();
    final kdController = useTextEditingController();
    final angleBiasController = useTextEditingController();
    final speedBiasController = useTextEditingController();
    final List<TextEditingController> paramControllers = [
      startTimeController,
      kpController,
      kiController,
      kdController,
      angleBiasController,
      speedBiasController,
    ];

    final TextEditingController debugMessageController =
        useTextEditingController();
    final infos = ref.watch(robotInfo);
    final configs = ref.watch(robotConfig);
    return SingleChildScrollView(
      child: Column(
        children: [
          RobotNameText(infos.name),
          ConfigSwitch(
            parameterName: "Inverter Roda Esquerda",
            parameterId: "invert_left_wheel",
            data: configs.leftWheelInverted,
          ),
          ConfigSwitch(
            parameterName: "Inverter Roda Direita",
            parameterId: "invert_right_wheel",
            data: configs.rightWheelInverted,
          ),
          ConfigSwitch(
            parameterName: "Inverter Direção",
            parameterId: "invert_angular_axis",
            data: configs.angularAxisInverted,
          ),
          ConfigSwitch(
            parameterName: "Inverter Sensor de Oponente",
            parameterId: "invert_op_sensors",
            data: configs.opReadingInverted,
          ),
          Visibility(
            visible: infos.name != null,
            child: const AdjustTitle(
              text: "Start Time",
              removeDivider: true,
            ),
          ),
          AdjustField(
            controller: startTimeController,
            watchValue: configs.startTime?.toString(),
          ),
          Visibility(
            visible: infos.name != null,
            child: const AdjustTitle(
              text: "PID",
              removeDivider: true,
            ),
          ),
          Row(
            children: [
              Flexible(
                child: AdjustField(
                  controller: kpController,
                  optionalDescriptionText: "KP",
                  watchValue: configs.pid?.kp.toString(),
                ),
              ),
              Flexible(
                child: AdjustField(
                  controller: kiController,
                  optionalDescriptionText: "Ki",
                  watchValue: configs.pid?.ki.toString(),
                ),
              ),
              Flexible(
                child: AdjustField(
                  controller: kdController,
                  optionalDescriptionText: "kd",
                  watchValue: configs.pid?.kd.toString(),
                ),
              ),
            ],
          ),
          Visibility(
            visible: infos.name != null,
            child: const AdjustTitle(
              text: "Rotation Bias",
              removeDivider: true,
            ),
          ),
          Row(
            children: [
              Flexible(
                child: AdjustField(
                  controller: angleBiasController,
                  optionalDescriptionText: "Angle Bias",
                  watchValue: configs.rotateAngleBias?.toString(),
                ),
              ),
              Flexible(
                child: AdjustField(
                  controller: speedBiasController,
                  optionalDescriptionText: "Speed Bias",
                  watchValue: configs.rotateSpeedBias?.toString(),
                ),
              ),
            ],
          ),
          Visibility(
            visible: infos.name != null,
            child: SetConfigButton(
              text: 'SET',
              onPressed: () {
                // Preparação dos textos de configuração
                for (final controller in paramControllers) {
                  controller.text = controller.text.replaceAll(",", ".");
                }
                if (startTimeController.text.contains(".")) {
                  final floatIndex = startTimeController.text.indexOf('.');
                  startTimeController.text =
                      startTimeController.text.substring(0, floatIndex);
                  showCupertinoDialog(
                    context: context,
                    builder: (_) => ErrorDialog(
                      message: "Start Time precisa ser inteiro",
                      obs:
                          "Start Time definido como ${startTimeController.text}",
                    ),
                  );
                }

                // Envio das informações para o robô
                ref.read(ws.notifier).sendMessage(
                      "{'start_time':'${startTimeController.text}'}",
                    );
                ref.read(ws.notifier).sendMessage(
                      "{'pid':{'kp':'${kpController.text}','ki':'${kiController.text}','kd':'${kdController.text}'}}",
                    );
                ref.read(ws.notifier).sendMessage(
                      "{'rotate_angle_bias':'${angleBiasController.text}','rotate_speed_bias':'${speedBiasController.text}'}",
                    );
              },
            ),
          ),
          ConfigTextField(
            parameterName: "Debug Message (JSON)",
            controller: debugMessageController,
          ),
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
    this.parameterName,
    this.data,
    required this.controller,
  }) : super(key: key);

  final String? parameterName;
  final String? data;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    controller.text = data ?? "";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: parameterName != null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ConfigTitleText(parameterName ?? ""),
          ),
        ),
        Flexible(
          child: TextField(
            cursorHeight: 28,
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
        ),
      ],
    );
  }
}

class ConfigSwitch extends ConsumerWidget {
  const ConfigSwitch({
    Key? key,
    this.parameterName,
    this.parameterId,
    required this.data,
  }) : super(key: key);

  final String? parameterName;
  final String? parameterId;
  final bool? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: data != null,
      child: ListTile(
        leading: ConfigTitleText(parameterName ?? "..."),
        trailing: Switch.adaptive(
          value: data ?? false,
          onChanged: (value) {
            ref.read(ws).sink.add("{'$parameterId':$value}");
          },
        ),
      ),
    );
  }
}

class AdjustTitle extends StatelessWidget {
  const AdjustTitle({required this.text, this.removeDivider = false});

  final String text;
  final bool removeDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: !removeDivider ? const Divider(color: Colors.white) : null,
        ),
        AdjustTitleText(
          text,
          color: null,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
