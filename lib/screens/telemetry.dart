import 'package:blue_app/style/colors/colors.dart';
import 'package:flutter/material.dart';

class TelemetryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
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
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const OpSensor(),
          const OpSensor(),
          const OpSensor(),
          const OpSensor(),
          const OpSensor(),
          const OpSensor(),
          const OpSensor(),
        ],
      ),
    );
  }
}

class OpSensor extends StatelessWidget {
  const OpSensor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 45,
      child: SizedBox(
        width: 60,
        height: 35,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.brightRed,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
