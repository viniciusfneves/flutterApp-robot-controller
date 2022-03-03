import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/style/buttons/button_style.dart';
import 'package:blue_app/style/colors/colors.dart';
import 'package:blue_app/style/texts/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class StrategyController extends ConsumerWidget {
  const StrategyController({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configs = ref.watch(robotConfig);
    final infos = ref.watch(robotInfo);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 4),
            const ConfigTitleText("Modo de Operação"),
            const SizedBox(height: 10),
            ConfigurationController(
              typeOfConfiguration: "mode",
              availableConfigurations: infos.modesAvailable,
              selectedConfiguration: configs.mode,
            ),
            const SizedBox(height: 10),
            const ConfigTitleText("Estratégia Inicial"),
            const SizedBox(height: 10),
            ConfigurationController(
              typeOfConfiguration: "initial",
              availableConfigurations: infos.initialAvailable,
              selectedConfiguration: configs.initial,
            ),
            const SizedBox(height: 10),
            const ConfigTitleText("Estratégia de Busca"),
            const SizedBox(height: 10),
            ConfigurationController(
              typeOfConfiguration: "search",
              availableConfigurations: infos.searchAvailable,
              selectedConfiguration: configs.search,
            ),
            const SizedBox(height: 10),
            const ConfigTitleText("Estratégia de Perseguição"),
            const SizedBox(height: 10),
            ConfigurationController(
              typeOfConfiguration: "chase",
              availableConfigurations: infos.chaseAvailable,
              selectedConfiguration: configs.chase,
            ),
            const SizedBox(height: 10),
          ],
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

class ConfigurationController extends ConsumerWidget {
  const ConfigurationController({
    required this.typeOfConfiguration,
    required this.availableConfigurations,
    required this.selectedConfiguration,
  });

  final String typeOfConfiguration;
  final List<dynamic> availableConfigurations;
  final String selectedConfiguration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 52,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: availableConfigurations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: 120,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => selectedConfiguration.toLowerCase() ==
                            availableConfigurations[index]
                                .toString()
                                .toLowerCase()
                        ? AppColors.selectedColor
                        : AppColors.unselectedColor,
                  ),
                ),
                onPressed: () {
                  ref.read(ws).sink.add(
                        "{'$typeOfConfiguration':'${availableConfigurations[index].toString().toLowerCase()}'}",
                      );
                },
                child: ConfigButtonText(
                  availableConfigurations[index]
                      .toString()
                      .replaceAll("_", " "),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
