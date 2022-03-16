import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/style/colors.dart';
import 'package:blue_app/style/texts.dart';
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
                  gradient: LinearGradient(
                    stops: const [0.75, 1],
                    colors: [
                      Colors.blueGrey.shade500,
                      Colors.blueGrey.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  ),
                  color: Colors.blueGrey,
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
                          robotTelemetry
                              .select((telemetry) => telemetry.EDGEfrontLeft),
                        ),
                        EdgeSensor(
                          robotTelemetry
                              .select((telemetry) => telemetry.EDGEfrontRight),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OpSensor(
                          robotTelemetry
                              .select((telemetry) => telemetry.OPfarLeft),
                        ),
                        OpSensor(
                          robotTelemetry
                              .select((telemetry) => telemetry.OPleft),
                        ),
                        OpSensor(
                          robotTelemetry
                              .select((telemetry) => telemetry.OPcenter),
                        ),
                        OpSensor(
                          robotTelemetry
                              .select((telemetry) => telemetry.OPright),
                        ),
                        OpSensor(
                          robotTelemetry
                              .select((telemetry) => telemetry.OPfarRight),
                        ),
                      ],
                    ),
                  ),
                  const Flexible(
                    child: FractionallySizedBox(
                      heightFactor: 0.6,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Motor(),
                      MotorDisplay(
                        robotTelemetry
                            .select((telemetry) => telemetry.leftMotor),
                      ),
                      MotorDisplay(
                        robotTelemetry
                            .select((telemetry) => telemetry.rightMotor),
                      ),
                      Motor(),
                    ],
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

class MotorDisplay extends ConsumerWidget {
  const MotorDisplay(
    this.watchValue,
  );
  final ProviderListenable<int?> watchValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(watchValue);
    final Color color;
    if (value == null || value < 0) {
      color = const Color(0xFFDC0000);
    } else {
      color = const Color(0xFF00DC00);
    }
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: GeneralPurposeText(
        value?.abs().toString(),
        color: color,
        adaptiveColor: false,
        fontSize: 32,
      ),
    );
  }
}

class Motor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          width: 68,
          height: 115,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Colors.purple,
                Colors.deepPurple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
        ),
      ),
    );
  }
}

class OpSensor extends ConsumerWidget {
  const OpSensor(
    this.watchValue, {
    Key? key,
  }) : super(key: key);

  final ProviderListenable watchValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(watchValue) as bool;
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
