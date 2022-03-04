// ignore_for_file: non_constant_identifier_names

class RobotTelemetry {
  RobotTelemetry({
    this.executionStatus,
    this.leftMotor = 0,
    this.rightMotor = 0,
    this.OPleftSide = false,
    this.OPfarLeft = false,
    this.OPleft = false,
    this.OPcenter = false,
    this.OPright = false,
    this.OPfarRight = false,
    this.OPrightSide = false,
    this.EDGEfrontLeft = false,
    this.EDGEfrontRight = false,
    this.EDGErearLeft = false,
    this.EDGErearRight = false,
  });

  final String? executionStatus;
  final int leftMotor;
  final int rightMotor;
  final bool OPleftSide;
  final bool OPfarLeft;
  final bool OPleft;
  final bool OPcenter;
  final bool OPright;
  final bool OPfarRight;
  final bool OPrightSide;
  final bool EDGEfrontLeft;
  final bool EDGEfrontRight;
  final bool EDGErearLeft;
  final bool EDGErearRight;
}
