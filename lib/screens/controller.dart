import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/screens/components/adjusts/adjust_slider.dart';
import 'package:blue_app/style/texts.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ControllerPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends ConsumerState<ControllerPage> {
  @override
  Widget build(BuildContext context) {
    final configs = ref.watch(robotConfig);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const GeneralPurposeText("Velocidade Máxima"),
        const SizedBox(height: 10),
        AdjustSlider(
          minSliderValue: 76,
          maxSliderValue: 255,
          watchValue: configs.maxSpeed?.toDouble(),
          onDoneAdjusting: (value) {
            ref
                .read(ws.notifier)
                .sendMessage("{'max_speed':'${value.toInt()}'}");
          },
        ),
      ],
    );
  }
}
