import 'package:blue_app/providers/robot_data_provider.dart';
import 'package:blue_app/providers/widget_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void processJsonMessage(BuildContext context, Map<String, dynamic> json) {
  if (json.containsKey("robot_name")) {
    context.read<WidgetState>().addRobotNameToAppTitle(json["robot_name"]);
  }

  if (json.containsKey("robot_status")) {
    switch (json["robot_status"]) {
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

  // ["available_opponent_sensors"] ["available_edge_sensors"]

  if (json.containsKey("available_opponent_sensors")) {
    context
        .read<RobotData>()
        .setAvailableOP(json["available_opponent_sensors"]);
  }

  if (json.containsKey("available_edge_sensors")) {
    context.read<RobotData>().setAvailableEdge(json["available_edge_sensors"]);
  }

  if (json.containsKey("configurations")) {
    context
        .read<RobotData>()
        .setStartTime(json["configurations"]["settings"]["start_time"]);
    context
        .read<RobotData>()
        .setMaxSpeed(json["configurations"]["settings"]["max_speed"]);
    context.read<RobotData>().setPID(
        json["configurations"]["settings"]["pid"]["kp"].toDouble(),
        json["configurations"]["settings"]["pid"]["ki"].toDouble(),
        json["configurations"]["settings"]["pid"]["kd"].toDouble());
    context.read<RobotData>().setMode(json["configurations"]["mode"]);
    context
        .read<RobotData>()
        .setInitialMove(json["configurations"]["initial_move"]);
    context.read<RobotData>().setSearch(json["configurations"]["search"]);
    context.read<RobotData>().setChase(json["configurations"]["chase"]);
  }

  if (json.containsKey("readings")) {
    context.read<RobotData>().setOpponentSensors(json["readings"]["opponent"]);
    context.read<RobotData>().setEdgeSensors(json["readings"]["edge"]);
    context.read<RobotData>().setWheelPower(
        json["readings"]["motors"][0], json["readings"]["motors"][1]);
  }
}
