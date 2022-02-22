import 'package:blue_app/colors/colors.dart';
import 'package:blue_app/global/websocket.dart';
import 'package:flutter/material.dart';

class ConfigurationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            EventRequestButton(
              text: "Start",
              color: AppColors.standardGreen,
            ),
            EventRequestButton(
              text: "Disengage",
              color: AppColors.standardRed,
            ),
          ],
        ),
        const EventRequestButton(
          text: "Arm",
          color: AppColors.standardAmbar,
        ),
        Flexible(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: const [
                  SizedBox(height: 4),
                  Text("Modo de Operação"),
                  SizedBox(height: 8),
                  Text("Estratégia Inicial"),
                  SizedBox(height: 8),
                  Text("Estratégia de Busca"),
                  SizedBox(height: 8),
                  Text("Estratégia de Perseguição"),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EventRequestButton extends StatelessWidget {
  const EventRequestButton({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
      child: SizedBox(
        width: screenWidth * 0.45,
        child: AspectRatio(
          aspectRatio: 3 / 1,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(color),
            ),
            child: Text(text),
            onPressed: () =>
                {ws.sink.add('{"event_request": "${text.toLowerCase()}"}')},
          ),
        ),
      ),
    );
  }
}
