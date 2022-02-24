import 'package:blue_app/global/websocket.dart';
import 'package:blue_app/style/colors/colors.dart';
import 'package:flutter/material.dart';

class RequestButton extends StatelessWidget {
  const RequestButton({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        child: AspectRatio(
          aspectRatio: 3 / 1,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(color),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            onPressed: () =>
                {ws.sink.add('{"event_request": "${text.toLowerCase()}"}')},
          ),
        ),
      ),
    );
  }
}

class DisengageRequestButton extends StatelessWidget {
  const DisengageRequestButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AspectRatio(
        aspectRatio: 4.7 / 1,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.standardRed),
          ),
          child: const Text(
            "Disengage",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onPressed: () => {ws.sink.add('{"event_request":"disengage"}')},
        ),
      ),
    );
  }
}
