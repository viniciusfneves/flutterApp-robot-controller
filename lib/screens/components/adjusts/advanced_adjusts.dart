import 'dart:ui';

import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/screens/components/adjusts/adjust_field.dart';
import 'package:blue_app/screens/components/adjusts/adjust_slider.dart';
import 'package:blue_app/style/buttons.dart';
import 'package:blue_app/style/colors.dart';
import 'package:blue_app/style/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdvancedAdjustsModalSheet extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kpController = useTextEditingController();
    final kiController = useTextEditingController();
    final kdController = useTextEditingController();
    final startTimeController = useTextEditingController();
    final screenSize = MediaQuery.of(context).size;
    final configs = ref.watch(robotConfig);
    final isDarkTheme = ref.watch(themeIsDark);
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
          height: screenSize.height * 0.8,
          width: screenSize.width,
          decoration: BoxDecoration(
            color: Colors.blueGrey[900]?.withOpacity(0.9),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const AdjustTitleText("AJUSTE DE PARÂMETROS"),
                  const AdjustTitle(text: "Velocidade Angular do Arco"),
                  AdjustSlider(
                    minSliderValue: -0.5,
                    maxSliderValue: 0.5,
                    adaptiveColor: false,
                    watchParameterPercentage: false,
                    watchValue: configs.arcAngularSpeed?.toDouble(),
                    onDoneAdjusting: (value) {
                      ref.read(ws).sink.add(
                            "{'arc_angular_speed':'${value.toStringAsFixed(3)}'}",
                          );
                    },
                  ),
                  const AdjustTitle(text: "Velocidade do Radar"),
                  AdjustSlider(
                    minSliderValue: 0.3,
                    maxSliderValue: 1,
                    adaptiveColor: false,
                    watchParameterPercentage: false,
                    watchValue: configs.radarSpeed?.toDouble(),
                    onDoneAdjusting: (value) {
                      ref.read(ws).sink.add(
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
                    adaptiveColor: false,
                    watchParameterPercentage: false,
                    watchValue: configs.maxSpeedInChase?.toDouble(),
                    onDoneAdjusting: (value) {
                      ref.read(ws).sink.add(
                            "{'max_angular_speed_in_chase':'${value.toStringAsFixed(3)}'}",
                          );
                    },
                  ),
                  const AdjustTitle(text: "PID"),
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
                    text: "Start Time",
                    removeDivider: true,
                  ),
                  AdjustField(
                    controller: startTimeController,
                    watchValue: configs.startTime?.toString(),
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
                      if (startTimeController.text.contains(",") ||
                          startTimeController.text.contains(".")) {
                        showDialog(
                          context: context,
                          builder: (_) => Center(
                            child: Container(
                              width: screenSize.width * 0.9,
                              height: screenSize.width * 0.35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.blueGrey,
                              ),
                              child: const Center(
                                child: Text(
                                  'StartTime precisa ser inteiro',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                        return;
                      }

                      ref.read(ws).sink.add(
                            "{'start_time':'${startTimeController.text}','pid':{'kp':'${kpController.text}','ki':'${kiController.text}','kd':'${kdController.text}'}}",
                          );
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
