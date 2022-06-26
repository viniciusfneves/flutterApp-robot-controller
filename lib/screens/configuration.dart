import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robot_controller/components/adjusts/advanced_adjusts.dart';
import 'package:robot_controller/components/dialog/ws_adress.dart';
import 'package:robot_controller/providers/providers.dart';
import 'package:robot_controller/style/buttons.dart';
import 'package:robot_controller/style/colors.dart';
import 'package:robot_controller/style/texts.dart';

class ConfigurationPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infos = ref.watch(robotInfo);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RobotNameText(infos.name),
          const StrategyController(),
          Visibility(
            visible: infos.isConnected,
            child: const SumoEventDisplay(),
          ),
          Visibility(
            visible: infos.isConnected,
            child: const SumoEventController(),
          ),
        ],
      ),
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
      child: Column(
        children: [
          Visibility(
            visible: !infos.isConnected,
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith(
                  (_) => const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                backgroundColor: MaterialStateColor.resolveWith(
                  (_) => AppColors.standardBlue,
                ),
              ),
              onPressed: () => showCupertinoDialog(
                context: context,
                builder: (_) => const ConnectionAdress(),
              ),
              child: const ConfigButtonText("CONECTAR"),
            ),
          ),
          Visibility(
            visible: infos.isConnected,
            child: const ConfigTitleText("Modo de Operação"),
          ),
          const SizedBox(height: 10),
          ConfigurationController(
            typeOfConfiguration: "mode",
            availableConfigurations: infos.modesAvailable ?? [],
            selectedConfiguration: configs.mode ?? "",
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: configs.mode == "AUTO",
            child: const AutoConfigurations(),
          ),
          Visibility(
            visible: configs.mode == "RC",
            child: const RcConfigurations(),
          ),
          const SizedBox(height: 18),
          Visibility(
            visible: infos.isConnected,
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith(
                  (_) => const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                backgroundColor: MaterialStateColor.resolveWith(
                  (_) => AppColors.standardBlue,
                ),
              ),
              onPressed: () => showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (_) => AdvancedAdjustsModalSheet(),
              ),
              child: const ConfigButtonText("MAIS AJUSTES"),
            ),
          )
        ],
      ),
    );
  }
}

class AutoConfigurations extends ConsumerWidget {
  const AutoConfigurations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infos = ref.watch(robotInfo);
    final configs = ref.watch(robotConfig);
    return Column(
      children: [
        const ConfigTitleText("Estratégia Inicial"),
        const SizedBox(height: 10),
        ConfigurationController(
          typeOfConfiguration: "initial",
          availableConfigurations: infos.initialAvailable ?? [],
          selectedConfiguration: configs.initial ?? "",
        ),
        const SizedBox(height: 10),
        const ConfigTitleText("Estratégia de Busca"),
        const SizedBox(height: 10),
        ConfigurationController(
          typeOfConfiguration: "search",
          availableConfigurations: infos.searchAvailable ?? [],
          selectedConfiguration: configs.search ?? "",
        ),
        const SizedBox(height: 10),
        const ConfigTitleText("Estratégia de Perseguição"),
        const SizedBox(height: 10),
        ConfigurationController(
          typeOfConfiguration: "chase",
          availableConfigurations: infos.chaseAvailable ?? [],
          selectedConfiguration: configs.chase ?? "",
        ),
      ],
    );
  }
}

class RcConfigurations extends ConsumerWidget {
  const RcConfigurations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infos = ref.watch(robotInfo);
    final configs = ref.watch(robotConfig);
    return Column(
      children: [
        const ConfigTitleText("Controle de Comando"),
        const SizedBox(height: 10),
        ConfigurationController(
          typeOfConfiguration: "ctrl_type",
          availableConfigurations: infos.ctrlTypeAvailable ?? [],
          selectedConfiguration: configs.controller?.commander ?? "",
        ),
        const SizedBox(height: 10),
        const ConfigTitleText("Mapa do Controle"),
        const SizedBox(height: 10),
        ConfigurationController(
          typeOfConfiguration: "ctrl_map",
          availableConfigurations: infos.ctrlMapAvailable ?? [],
          selectedConfiguration: configs.controller?.map ?? "",
        ),
        const SizedBox(height: 10),
        const ConfigTitleText("Filtro dos Comandos"),
        const SizedBox(height: 10),
        ConfigurationController(
          typeOfConfiguration: "ctrl_filter",
          availableConfigurations: infos.ctrlFilterAvailable ?? [],
          selectedConfiguration: configs.controller?.filter ?? "",
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
              width: 125,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (_) =>
                        selectedConfiguration.toLowerCase() == availableConfigurations[index].toString().toLowerCase()
                            ? AppColors.selectedColor
                            : AppColors.unselectedColor,
                  ),
                ),
                onPressed: () {
                  ref.read(ws.notifier).sendMessage(
                        "{'$typeOfConfiguration':'${availableConfigurations[index].toString().toLowerCase()}'}",
                      );
                },
                child: ConfigButtonText(
                  availableConfigurations[index].toString().replaceAll("_", " "),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SumoEventController extends StatelessWidget {
  const SumoEventController({
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

class SumoEventDisplay extends ConsumerWidget {
  const SumoEventDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(robotTelemetry.select((r) => r.executionStatus));
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ExecutionLight(
            strategy: "Ready",
            isActive: status == null || status == "ready",
            activeColor: AppColors.standardAmbar,
          ),
          ExecutionLight(
            strategy: "Starting",
            isActive: status == null || status == "starting",
          ),
          ExecutionLight(
            strategy: "Fighting",
            isActive: status == null || status.substring(0, 5) == "exec_",
            activeColor: AppColors.standardGreen,
          ),
          ExecutionLight(
            strategy: "Disabled",
            isActive: status == null || status == "stopped",
            activeColor: AppColors.standardRed,
          ),
        ],
      ),
    );
  }
}

class ExecutionLight extends StatelessWidget {
  const ExecutionLight({
    required this.strategy,
    required this.isActive,
    this.activeColor = AppColors.standardBlue,
    Key? key,
  }) : super(key: key);

  final String strategy;
  final bool isActive;
  final Color activeColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            strategy,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        ClipOval(
          child: Container(
            decoration: BoxDecoration(
              color: isActive ? activeColor : AppColors.unselectedColor,
            ),
            height: 22,
            width: 22,
          ),
        ),
      ],
    );
  }
}
