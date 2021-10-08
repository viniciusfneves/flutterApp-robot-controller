import 'package:blue_app/providers/robot_data_provider.dart';
import 'package:blue_app/providers/widget_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void processJsonMessage(BuildContext context, Map<String, dynamic> json) {
  if (json.containsKey("info")) {
    context.read<WidgetState>().addRobotNameToAppTitle(json["info"]["robot_name"]);
    context.read<RobotData>().setAvailableOP(json["info"]["available_opponent_sensors"]);
    context.read<RobotData>().setAvailableEdge(json["info"]["available_edge_sensors"]);
  }

  if (json.containsKey("configurations")) {
    context.read<RobotData>().setStartTime(json["configurations"]["start_time"]);
    context.read<RobotData>().setMaxSpeed(json["configurations"]["max_speed"]);
    context.read<RobotData>().setPID(
        json["configurations"]["pid"]["kp"].toDouble(),
        json["configurations"]["pid"]["ki"].toDouble(),
        json["configurations"]["pid"]["kd"].toDouble());
    context.read<RobotData>().setMode(json["configurations"]["mode"]);
    context.read<RobotData>().setInitialMove(json["configurations"]["initial_move"]);
    context.read<RobotData>().setSearch(json["configurations"]["search"]);
    context.read<RobotData>().setChase(json["configurations"]["chase"]);
  }

  if (json.containsKey("readings")) {
    context.read<RobotData>().setOpponentSensors(json["readings"]["opponent"]);
    context.read<RobotData>().setEdgeSensors(json["readings"]["edge"]);
    context.read<RobotData>().setWheelPower(json["readings"]["motor"][0], json["readings"]["motor"][1]);
    switch (json["readings"]["robot_status"]) {
      case "ready":
        context.read<WidgetState>().setReadyState();
        break;
      case "stopped":
        context.read<WidgetState>().setDisabledState();
        break;
      case "starting":
        context.read<WidgetState>().setFightState();
        break;
      default:
        context.read<WidgetState>().setFightState();
        break;
    }
  }
}
