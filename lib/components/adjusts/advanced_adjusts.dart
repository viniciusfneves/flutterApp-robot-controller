import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robot_controller/components/adjusts/adjust_slider.dart';
import 'package:robot_controller/providers/providers.dart';
import 'package:robot_controller/style/texts.dart';

class AdvancedAdjustsModalSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final configs = ref.watch(robotConfig);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          height: screenSize.height * 0.8,
          width: screenSize.width,
          decoration: BoxDecoration(
            color: Colors.blueGrey[900]?.withOpacity(0.85),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
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
                  const AdjustTitle(text: "Velocidade do Radar"),
                  AdjustSlider(
                    minSliderValue: 0.3,
                    maxSliderValue: 1,
                    watchValue: configs.radarSpeed?.toDouble(),
                    color: Colors.white,
                    onDoneAdjusting: (value) {
                      ref.read(ws.notifier).sendMessage(
                            "{'radar_speed':'${value.toStringAsFixed(3)}'}",
                          );
                    },
                  ),
                  const AdjustTitle(text: "Velocidade Angular do Arco"),
                  AdjustSlider(
                    minSliderValue: -0.5,
                    maxSliderValue: 0.5,
                    watchValue: configs.arcAngularSpeed?.toDouble(),
                    divisions: 200,
                    color: Colors.white,
                    onDoneAdjusting: (value) {
                      ref.read(ws.notifier).sendMessage(
                            "{'arc_angular_speed':'${value.toStringAsFixed(3)}'}",
                          );
                    },
                  ),
                  const AdjustTitle(text: "Tempo de Execução do Arco"),
                  AdjustSlider(
                    minSliderValue: 0,
                    maxSliderValue: 1200,
                    watchValue: configs.arcTimeout?.toDouble(),
                    divisions: 300,
                    sliderLabelPercentage: false,
                    watchParameterPercentage: false,
                    color: Colors.white,
                    onDoneAdjusting: (value) {
                      ref.read(ws.notifier).sendMessage(
                            "{'arc_timeout':'${value.toInt()}'}",
                          );
                    },
                  ),
                  const AdjustTitle(text: "Ângulo de Rotação do Arco"),
                  AdjustSlider(
                    minSliderValue: -180,
                    maxSliderValue: 180,
                    watchValue: configs.arcAngle?.toDouble(),
                    divisions: 360,
                    watchParameterPercentage: false,
                    sliderLabelPercentage: false,
                    color: Colors.white,
                    onDoneAdjusting: (value) {
                      ref.read(ws.notifier).sendMessage(
                            "{'arc_rot_initial_angle':'${value.toInt()}'}",
                          );
                    },
                  ),
                  const AdjustTitle(
                    text: "Máx Vel Angular em Perseguição",
                  ),
                  AdjustSlider(
                    minSliderValue: 0.245,
                    maxSliderValue: 0.7,
                    watchValue: configs.maxSpeedInChase?.toDouble(),
                    color: Colors.white,
                    onDoneAdjusting: (value) {
                      ref.read(ws.notifier).sendMessage(
                            "{'max_angular_speed_in_chase':'${value.toStringAsFixed(3)}'}",
                          );
                    },
                  ),
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
