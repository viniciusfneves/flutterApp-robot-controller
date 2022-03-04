import 'package:blue_app/style/colors/colors.dart';
import 'package:flutter/material.dart';

class TelemetryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Center(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[600],
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Positioned(
            width: screenSize.width,
            top: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                OpSensor(),
                OpSensor(),
                OpSensor(),
                OpSensor(),
                OpSensor(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OpSensor extends StatelessWidget {
  const OpSensor({
    this.isActive = false,
    Key? key,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 25,
      decoration: BoxDecoration(
        color: isActive ? AppColors.lightRed : AppColors.unselectedColor,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
