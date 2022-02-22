import 'package:flutter/material.dart';

class TelemetryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Stack(
        children: [
          Container(
            width: screenWidth * 0.75,
            height: screenWidth * 0.75,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ],
      ),
    );
  }
}
