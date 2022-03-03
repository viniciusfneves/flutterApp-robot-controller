class RobotInfos {
  RobotInfos({
    required this.name,
    required this.modesAvailable,
    required this.initialAvailable,
    required this.searchAvailable,
    required this.chaseAvailable,
  });

  final String name;
  final List<dynamic> modesAvailable;
  final List<dynamic> initialAvailable;
  final List<dynamic> searchAvailable;
  final List<dynamic> chaseAvailable;
}
