import 'dart:convert';
import 'package:blue_app/communications/WiFi/websocket_handler.dart';
import 'package:blue_app/communications/json/json_handler.dart';
import 'package:blue_app/providers/robot_data_provider.dart';
import 'package:blue_app/providers/widget_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:blue_app/screen_template/screen_template.dart';
import 'package:flutter/material.dart';

class ConfigurationPage extends StatefulWidget {
  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  void initState() {
    websocketData.listen((data) {
      Map<String, dynamic> json = jsonDecode(data);
      processJsonMessage(context, json);
    });
    super.initState();
  }

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
                    ...robotStrategyConfigurationWidgets(
                      context,
                      "Modo de Operação",
                      "mode",
                      ["Auto", "RC"],
                      context.watch<RobotData>().modeConfiguration,
                    ),
                    ...robotStrategyConfigurationWidgets(
                      context,
                      "Movimento Inicial",
                      "initial",
                      ["None", "Full Frente", "Zig Zag"],
                      context.watch<RobotData>().initialMoveConfiguration,
                    ),
                    ...robotStrategyConfigurationWidgets(
                      context,
                      "Busca",
                      "search",
                      ["None", "Radar"],
                      context.watch<RobotData>().searchConfiguration,
                    ),
                    ...robotStrategyConfigurationWidgets(
                      context,
                      "Perseguição",
                      "chase",
                      ["Standard"],
                      context.watch<RobotData>().chaseConfiguration,
                    ),
                    SizedBox(
                      height: 10,
                    )
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
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          margin: EdgeInsets.only(bottom: 4, top: 8, left: 20, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: context.watch<WidgetState>().robotStateCircle,
          ),
        ),
        Container(
          width: 85,
          child: Text(
            context.watch<WidgetState>().robotStateText,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ],
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

List<Widget> robotStrategyConfigurationWidgets(
  BuildContext context,
  String textInidication,
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

  return [
    Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 6),
      child: Text(
        textInidication,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    ),
    Wrap(
      alignment: WrapAlignment.center,
      spacing: 14,
      runSpacing: 14,
      children: [...strategyButtons],
    )
  ];
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
