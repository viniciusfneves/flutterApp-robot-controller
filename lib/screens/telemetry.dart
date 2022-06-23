import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robot_controller/providers/providers.dart';
import 'package:robot_controller/style/colors.dart';
import 'package:robot_controller/style/texts.dart';

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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OpSensor(
                          robotTelemetry
                              .select((telemetry) => telemetry.OPleftSide),
                          vertical: true,
                        ),
                        OpSensor(
                          robotTelemetry
                              .select((telemetry) => telemetry.OPrightSide),
                          vertical: true,
                        )
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: SizedBox(),
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
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12.0,
                      left: 12,
                      right: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EdgeSensor(
                          robotTelemetry
                              .select((telemetry) => telemetry.EDGErearLeft),
                        ),
                        EdgeSensor(
                          robotTelemetry
                              .select((telemetry) => telemetry.EDGErearRight),
                        ),
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
    this.vertical = false,
  }) : super(key: key);

  final bool vertical;
  final ProviderListenable<bool?> watchValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(watchValue);
    return Flexible(
      child: Visibility(
        visible: isActive != null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Transform.rotate(
            angle: vertical ? pi / 2 : 0,
            child: Container(
              width: 70,
              height: 35,
              decoration: BoxDecoration(
                color: (isActive ?? false)
                    ? AppColors.lightRed
                    : AppColors.unselectedColor,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
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

  final ProviderListenable<bool?> watch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(watch);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: isActive != null,
        child: ClipOval(
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: (isActive ?? false)
                  ? AppColors.standardAmbar
                  : AppColors.unselectedColor,
            ),
          ),
        ),
      ),
    );
  }
}
