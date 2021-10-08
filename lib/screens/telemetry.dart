import 'package:blue_app/providers/robot_data_provider.dart';
import 'package:blue_app/screen_template/screen_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelemetryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return ScreenBase(
      bodyWidget: Center(
        child: Stack(
          children: [
            Container(
              width: screenWidth * 0.75,
              height: screenWidth * 0.75,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(24)),
            ),
            Container(
              alignment: Alignment.center,
              width: 50,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(top: 135, left: screenWidth*0.045),
              child: Selector<RobotData, int>(
                selector: (_, robotData) =>
                    robotData.powerOnWheels["left-motor"],
                builder: (_, leftWheelPower, ___) => FittedBox(
                  child: Text(
                    leftWheelPower >= 0
                        ? leftWheelPower.toString()
                        : leftWheelPower.toString().substring(1),
                    style: TextStyle(
                      color:
                          leftWheelPower >= 0 ? Colors.lightBlue : Colors.red,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 50,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(top: 135, left: screenWidth*0.585),
              child: Selector<RobotData, int>(
                selector: (_, robotData) =>
                    robotData.powerOnWheels["right-motor"],
                builder: (_, rightWheelPower, ___) => FittedBox(
                  child: Text(
                    rightWheelPower >= 0
                        ? rightWheelPower.toString()
                        : rightWheelPower.toString().substring(1),
                    style: TextStyle(
                      color:
                          rightWheelPower >= 0 ? Colors.lightBlue : Colors.red,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
