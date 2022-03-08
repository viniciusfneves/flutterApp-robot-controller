import 'dart:ui';

import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/screens/components/adjusts/adjust_field.dart';
import 'package:blue_app/screens/components/adjusts/adjust_slider.dart';
import 'package:blue_app/screens/components/dialog/error_dialog.dart';
import 'package:blue_app/style/buttons.dart';
import 'package:blue_app/style/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdvancedAdjustsModalSheet extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startTimeController = useTextEditingController();
    final kpController = useTextEditingController();
    final kiController = useTextEditingController();
    final kdController = useTextEditingController();
    final angleBiasController = useTextEditingController();
    final speedBiasController = useTextEditingController();
    final screenSize = MediaQuery.of(context).size;
    final configs = ref.watch(robotConfig);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          height: screenSize.height * 0.8,
          width: screenSize.width,
          decoration: BoxDecoration(
            color: Colors.blueGrey[900]?.withOpacity(0.85),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 8,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const AdjustTitleText("AJUSTE DE PARÂMETROS"),
                  const AdjustTitle(text: "Velocidade Angular do Arco"),
                  AdjustSlider(
                    minSliderValue: -0.5,
                    maxSliderValue: 0.5,
                    textAdaptiveColor: false,
                    watchParameterPercentage: false,
                    watchValue: configs.arcAngularSpeed?.toDouble(),
                    onDoneAdjusting: (value) {
                      ref.read(ws.notifier).sendMessage(
                            "{'arc_angular_speed':'${value.toStringAsFixed(3)}'}",
                          );
                    },
                  ),
                  const AdjustTitle(text: "Ângulo de Rotação do Arco"),
                  AdjustSlider(
                    minSliderValue: -180,
                    maxSliderValue: 180,
                    textAdaptiveColor: false,
                    watchParameterPercentage: false,
                    watchValue: configs.arcAngle?.toDouble(),
                    onDoneAdjusting: (value) {
                      ref.read(ws.notifier).sendMessage(
                            "{'arc_rot_initial_angle':'${value.toInt()}'}",
                          );
                    },
                  ),
                  const AdjustTitle(text: "Velocidade do Radar"),
                  AdjustSlider(
                    minSliderValue: 0.3,
                    maxSliderValue: 1,
                    textAdaptiveColor: false,
                    watchParameterPercentage: false,
                    watchValue: configs.radarSpeed?.toDouble(),
                    onDoneAdjusting: (value) {
                      ref.read(ws.notifier).sendMessage(
                            "{'radar_speed':'${value.toStringAsFixed(3)}'}",
                          );
                    },
                  ),
                  const AdjustTitle(
                    text: "MáxVel Angular em Perseguição",
                  ),
                  AdjustSlider(
                    minSliderValue: 0.245,
                    maxSliderValue: 0.7,
                    textAdaptiveColor: false,
                    watchParameterPercentage: false,
                    watchValue: configs.maxSpeedInChase?.toDouble(),
                    onDoneAdjusting: (value) {
                      ref.read(ws.notifier).sendMessage(
                            "{'max_angular_speed_in_chase':'${value.toStringAsFixed(3)}'}",
                          );
                    },
                  ),
                  const AdjustTitle(text: "Start Time"),
                  AdjustField(
                    controller: startTimeController,
                    watchValue: configs.startTime?.toString(),
                  ),
                  const AdjustTitle(
                    text: "PID",
                    removeDivider: true,
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
                  const AdjustTitle(
                    text: "Rotation Bias",
                    removeDivider: true,
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
                  SetConfigButton(
                    text: 'SET',
                    onPressed: () {
                      kpController.text =
                          kpController.text.replaceAll(",", ".");
                      kiController.text =
                          kiController.text.replaceAll(",", ".");
                      kdController.text =
                          kdController.text.replaceAll(",", ".");
                      angleBiasController.text =
                          angleBiasController.text.replaceAll(",", ".");
                      speedBiasController.text =
                          speedBiasController.text.replaceAll(",", ".");
                      if (startTimeController.text.contains(",") ||
                          startTimeController.text.contains(".")) {
                        startTimeController.text =
                            configs.startTime?.toString() ?? "---";
                        kpController.text = configs.pid?.kp.toString() ?? "---";
                        kiController.text = configs.pid?.ki.toString() ?? "---";
                        kdController.text = configs.pid?.kd.toString() ?? "---";
                        angleBiasController.text =
                            configs.rotateAngleBias?.toString() ?? "---";
                        speedBiasController.text =
                            configs.rotateSpeedBias?.toString() ?? "---";
                        showDialog(
                          context: context,
                          builder: (_) => ErrorDialog(
                            message: "Start Time precisa ser inteiro",
                            screenSize: MediaQuery.of(context).size,
                          ),
                        );
                      } else {
                        ref.read(ws.notifier).sendMessage(
                              "{'start_time':'${startTimeController.text}'}",
                            );
                        ref.read(ws.notifier).sendMessage(
                              "{'pid':{'kp':'${kpController.text}','ki':'${kiController.text}','kd':'${kdController.text}'}}",
                            );
                        ref.read(ws.notifier).sendMessage(
                              "{'rotate_angle_bias':'${angleBiasController.text}','rotate_speed_bias':'${speedBiasController.text}'}",
                            );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
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
        AdjustTitleText(text),
        const SizedBox(height: 8),
      ],
    );
  }
}
