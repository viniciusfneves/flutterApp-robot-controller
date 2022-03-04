import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/style/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TelemetryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[600],
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      left: 12,
                      right: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EdgeSensor(
                          robotTelemetry.select((op) => op.EDGEfrontLeft),
                        ),
                        EdgeSensor(
                          robotTelemetry.select((op) => op.EDGEfrontRight),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OpSensor(robotTelemetry.select((op) => op.OPfarLeft)),
                        OpSensor(robotTelemetry.select((op) => op.OPleft)),
                        OpSensor(robotTelemetry.select((op) => op.OPcenter)),
                        OpSensor(robotTelemetry.select((op) => op.OPright)),
                        OpSensor(robotTelemetry.select((op) => op.OPfarRight)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OpSensor extends ConsumerWidget {
  const OpSensor(
    this.watch, {
    Key? key,
  }) : super(key: key);

  final ProviderListenable watch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(watch) as bool;
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 85,
          height: 35,
          decoration: BoxDecoration(
            color: isActive ? AppColors.lightRed : AppColors.unselectedColor,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}

class EdgeSensor extends ConsumerWidget {
  const EdgeSensor(
    this.watch, {
    Key? key,
  }) : super(key: key);

  final ProviderListenable watch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(watch) as bool;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipOval(
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color:
                isActive ? AppColors.standardAmbar : AppColors.unselectedColor,
          ),
        ),
      ),
    );
  }
}
