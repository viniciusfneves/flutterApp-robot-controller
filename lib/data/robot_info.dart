class RobotInfos {
  RobotInfos({
    this.name,
    this.modesAvailable,
    this.initialAvailable,
    this.searchAvailable,
    this.chaseAvailable,
  });

  final String? name;
  final List<dynamic>? modesAvailable;
  final List<dynamic>? initialAvailable;
  final List<dynamic>? searchAvailable;
  final List<dynamic>? chaseAvailable;
}
