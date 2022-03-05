class RobotConfigs {
  RobotConfigs({
    this.startTime,
    this.maxSpeed,
    this.maxSpeedInChase,
    this.rotateAngleBias,
    this.rotateSpeedBias,
    this.arcAngularSpeed,
    this.radarSpeed,
    this.pid,
    this.controller,
    this.mode,
    this.initial,
    this.search,
    this.chase,
  });

  final int? startTime;
  final int? maxSpeed;
  final num? maxSpeedInChase;
  final num? rotateAngleBias;
  final num? rotateSpeedBias;
  final num? arcAngularSpeed;
  final num? radarSpeed;
  final PID? pid;
  final Controller? controller;
  final String? mode;
  final String? initial;
  final String? search;
  final String? chase;
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
