import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key? key,
    required this.message,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: screenSize.width * 0.9,
        height: screenSize.width * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.blueGrey,
        ),
        child: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
