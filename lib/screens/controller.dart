import 'package:flutter/material.dart';

class ControllerPage extends StatefulWidget {
  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  int _valueHolder = 165;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Velocidade Máxima",
          style: TextStyle(fontSize: 22),
        ),
        const SizedBox(height: 10),
        Slider(
          min: 76,
          max: 255,
          value: _valueHolder.toDouble(),
          onChanged: (value) {
            setState(() {
              _valueHolder = value.toInt();
            });
          },
          onChangeEnd: (finalValue) {},
          divisions: 100,
          label: "${(_valueHolder / 255 * 100).toStringAsFixed(0)} %",
        )
      ],
    );
  }
}
