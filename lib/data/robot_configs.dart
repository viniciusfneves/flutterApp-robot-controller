class RobotConfigs {
  RobotConfigs({
    required this.startTime,
    required this.maxSpeed,
    required this.pid,
    required this.controller,
    required this.mode,
    required this.initial,
    required this.search,
    required this.chase,
  });

  final int startTime;
  final int maxSpeed;
  final PID pid;
  final Controller controller;
  final String mode;
  final String initial;
  final String search;
  final String chase;
}

class PID {
  PID({required this.kp, required this.ki, required this.kd});

  final num ki;
  final num kp;
  final num kd;
}

class Controller {
  Controller(this.commander, this.map, this.filter);

  final String commander;
  final String map;
  final String filter;
}
