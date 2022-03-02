import 'package:blue_app/style/buttons/button_style.dart';
import 'package:blue_app/style/colors/colors.dart';
import 'package:blue_app/style/texts/text_style.dart';
import 'package:flutter/material.dart';

class ConfigurationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(child: StrategyController()),
        EventController(),
      ],
    );
  }
}

class StrategyController extends StatelessWidget {
  const StrategyController({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        width: screenSize.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            children: const [
              SizedBox(height: 4),
              ConfigText("Modo de Operação"),
              SizedBox(height: 8),
              ConfigText("Estratégia Inicial"),
              SizedBox(height: 8),
              ConfigText("Estratégia de Busca"),
              SizedBox(height: 8),
              ConfigText("Estratégia de Perseguição"),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class EventController extends StatelessWidget {
  const EventController({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DisengageRequestButton(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            RequestButton(
              title: "Start",
              color: AppColors.standardGreen,
            ),
            RequestButton(
              title: "Arm",
              color: AppColors.standardAmbar,
            )
          ],
        ),
      ],
    );
  }
}
