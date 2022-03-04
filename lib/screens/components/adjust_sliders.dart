import 'package:blue_app/style/colors/colors.dart';
import 'package:blue_app/style/texts/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdjustSlider extends ConsumerStatefulWidget {
  const AdjustSlider({
    required this.minSliderValue,
    required this.maxSliderValue,
    required this.onDoneAdjusting,
    this.watchValue,
    this.adaptiveColor = true,
  });

  final double minSliderValue;
  final double maxSliderValue;
  final double? watchValue;
  final bool adaptiveColor;
  final Function(double) onDoneAdjusting;

  @override
  ConsumerState<AdjustSlider> createState() => _AdjustSliderState();
}

class _AdjustSliderState extends ConsumerState<AdjustSlider> {
  double? _valueHolder;
  @override
  Widget build(BuildContext context) {
    _valueHolder = _valueHolder ?? widget.watchValue ?? widget.maxSliderValue;
    return Column(
      children: [
        GeneralPurposeText(
          widget.watchValue == null
              ? "Sem dados"
              : "${(widget.watchValue! / widget.maxSliderValue * 100).toStringAsFixed(0)} %",
          adaptiveColor: widget.adaptiveColor,
        ),
        Slider.adaptive(
          activeColor: AppColors.standardRed,
          min: widget.minSliderValue,
          max: widget.maxSliderValue,
          value: _valueHolder!,
          onChanged: (value) {
            setState(() {
              _valueHolder = value;
            });
          },
          onChangeEnd: widget.onDoneAdjusting,
          divisions: 100,
          label:
              "${(_valueHolder! / widget.maxSliderValue * 100).toStringAsFixed(0)} %",
        ),
      ],
    );
  }
}
