import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robot_controller/providers/providers.dart';
import 'package:robot_controller/style/colors.dart';

class RobotNameText extends StatelessWidget {
  const RobotNameText(this.data);

  final String? data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        data ?? "Sem conexão",
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: data == null ? AppColors.standardRed : AppColors.standardGreen,
        ),
      ),
    );
  }
}

class ConfigButtonText extends StatelessWidget {
  const ConfigButtonText(
    this.data, {
    Key? key,
    this.color,
  }) : super(key: key);
  final String data;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      data.toUpperCase(),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}

class ConfigTitleText extends ConsumerWidget {
  const ConfigTitleText(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeIsDark);
    return Text(
      text,
      style: TextStyle(
        color: theme ? Colors.white : Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class AdjustTitleText extends StatelessWidget {
  const AdjustTitleText(
    this.text, {
    this.color = Colors.white,
    Key? key,
  }) : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class EventRequestText extends StatelessWidget {
  const EventRequestText(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class GeneralPurposeText extends StatelessWidget {
  const GeneralPurposeText(
    this.data, {
    Key? key,
    this.fontSize = 20,
    this.color,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final String? data;
  final double fontSize;
  final Color? color;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        data ?? "-",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
        ),
      ),
    );
  }
}
