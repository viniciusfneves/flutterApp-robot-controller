import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/style/colors/colors.dart';
import 'package:blue_app/style/texts/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ControllerPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends ConsumerState<ControllerPage> {
  double _valueHolder = 165;
  @override
  Widget build(BuildContext context) {
    final configs = ref.watch(robotConfig);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const GeneralPurposeText("Velocidade Máxima"),
        const SizedBox(height: 10),
        GeneralPurposeText(
          configs.maxSpeed == null
              ? "Sem informação"
              : "${(configs.maxSpeed! / 255 * 100).toStringAsFixed(0)} %",
        ),
        const SizedBox(height: 10),
        Slider.adaptive(
          activeColor: AppColors.standardRed,
          min: 76,
          max: 255,
          value: _valueHolder,
          onChanged: (value) {
            setState(() {
              _valueHolder = value;
            });
          },
          onChangeEnd: (finalValue) {
            ref.read(ws).sink.add("{'max_speed':'${finalValue.toInt()}'}");
          },
          divisions: 100,
          label: "${(_valueHolder / 255 * 100).toStringAsFixed(0)} %",
        )
      ],
    );
  }
}
