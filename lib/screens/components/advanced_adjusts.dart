import 'dart:ui';

import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/screens/components/adjust_sliders.dart';
import 'package:blue_app/style/texts/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdvancedAdjustsModalSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final configs = ref.watch(robotConfig);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
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
            color: Colors.blueGrey[900]?.withOpacity(0.95),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const AdjustTitleText("AJUSTE DE PARÂMETROS"),
                const AdjustBlockDisplay(text: "Velocidade Angular do Arco"),
                AdjustSlider(
                  minSliderValue: -0.5,
                  maxSliderValue: 0.5,
                  adaptiveColor: false,
                  watchValue: configs.arcAngularSpeed?.toDouble(),
                  onDoneAdjusting: (value) {
                    ref.read(ws).sink.add(
                          "{'arcAngularSpeed':'${value.toStringAsFixed(5)}'}",
                        );
                  },
                ),
                const AdjustBlockDisplay(text: "Velocidade do Radar"),
                AdjustSlider(
                  minSliderValue: 0.3,
                  maxSliderValue: 1,
                  adaptiveColor: false,
                  watchValue: configs.radarSpeed?.toDouble(),
                  onDoneAdjusting: (value) {
                    ref.read(ws).sink.add(
                          "{'radarSpeed':'${value.toStringAsFixed(5)}'}",
                        );
                  },
                ),
                const AdjustBlockDisplay(
                  text: "Max Velocidade Angular em Perseguição",
                ),
                AdjustSlider(
                  minSliderValue: 0.25,
                  maxSliderValue: 0.7,
                  adaptiveColor: false,
                  watchValue: configs.maxSpeedInChase?.toDouble(),
                  onDoneAdjusting: (value) {
                    ref.read(ws).sink.add(
                          "{'maxAngularSpeedInChase':'${value.toStringAsFixed(5)}'}",
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdjustBlockDisplay extends StatelessWidget {
  const AdjustBlockDisplay({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(color: Colors.white),
        ),
        AdjustTitleText(text),
        const SizedBox(height: 8),
      ],
    );
  }
}
