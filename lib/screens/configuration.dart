import 'package:blue_app/communications/WiFi/websocket_handler.dart';
import 'package:blue_app/providers/robot_data_provider.dart';
import 'package:blue_app/providers/widget_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:blue_app/screen_template/screen_template.dart';
import 'package:flutter/material.dart';

class ConfigurationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      bodyWidget: Column(
        children: [
          robotStateConfigurationWidgets(context),
          Flexible(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Modo de Operação",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Selector<RobotData, String>(
                      selector: (_, robotData) => robotData.modeConfiguration,
                      builder: (ctx, mode, ___) => Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          ...robotStrategyConfigurationButtons(
                            "mode",
                            ["Auto", "RC"],
                            mode,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Estratégia Inicial",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Selector<RobotData, String>(
                      selector: (_, robotData) =>
                          robotData.initialMoveConfiguration,
                      builder: (ctx, initial, ___) => Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          ...robotStrategyConfigurationButtons(
                            "initial",
                            ["None", "Full Frente", "Zig Zag"],
                            initial,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Estratégia de Busca",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Selector<RobotData, String>(
                      selector: (_, robotData) => robotData.searchConfiguration,
                      builder: (ctx, search, ___) => Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          ...robotStrategyConfigurationButtons(
                            "search",
                            ["None", "Radar"],
                            search,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Estratégia de Perseguição",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Selector<RobotData, String>(
                      selector: (_, robotData) => robotData.chaseConfiguration,
                      builder: (ctx, chase, ___) => Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          ...robotStrategyConfigurationButtons(
                            "chase",
                            ["Standard"],
                            chase,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget robotStateConfigurationWidgets(BuildContext context) {
  List<Widget> widgetsToDisplay = [
    // Display de estado
    Consumer<WidgetState>(
      builder: (_, state, ___) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            margin: EdgeInsets.only(bottom: 4, top: 8, left: 20, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: state.robotStateCircle,
            ),
          ),
          Container(
            width: 85,
            child: Text(
              state.robotStateText,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    ),
    Divider(thickness: 2),
    // Botões de controle de estado
    Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.spaceAround,
      children: [
        makeEventRequestButton("Start", "start", Colors.green[800]),
        makeEventRequestButton("Disengage", "terminate", Colors.red[900]),
        makeEventRequestButton("Arm", "reset", Colors.lime[800]),
      ],
    ),
    SizedBox(
      height: 8,
    )
  ];

  return Padding(
    padding: EdgeInsets.only(top: 6),
    child: Column(
      children: [...widgetsToDisplay],
    ),
  );
}

List<Widget> robotStrategyConfigurationButtons(
  String typeOfStrategy,
  List<String> availableStrategys,
  String selectedStrategy,
) {
  List<Widget> strategyButtons = [];

  availableStrategys.forEach(
    (strategyName) {
      if (strategyName.replaceAll(RegExp(' '), '_').toLowerCase() !=
          selectedStrategy) {
        strategyButtons.add(makeStrategyRequestButton(
            strategyName, typeOfStrategy, Colors.blueGrey));
      } else {
        strategyButtons.add(makeStrategyRequestButton(
            strategyName, typeOfStrategy, Colors.deepPurple[800]));
      }
    },
  );

  return strategyButtons;
}

Widget makeEventRequestButton(
  String displayText,
  String requestText,
  Color buttonColor,
) {
  return Container(
    width: 165,
    height: 80,
    child: ElevatedButton(
      child: Text(
        displayText,
        style: TextStyle(
            fontSize: 19, color: Colors.white, overflow: TextOverflow.ellipsis),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(18))),
      onPressed: () {
        websocket.sink.add('{"event_request":"${requestText.toLowerCase()}"}');
      },
    ),
  );
}

Widget makeStrategyRequestButton(
  String displayText,
  String strategyType,
  Color buttonColor,
) {
  return Container(
    width: 112,
    height: 62,
    child: ElevatedButton(
      child: Text(
        displayText,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(18))),
      onPressed: () {
        websocket.sink.add(
            '{"${strategyType.toLowerCase()}":"${displayText.replaceAll(RegExp(' '), '_').toLowerCase()}"}');
      },
    ),
  );
}
