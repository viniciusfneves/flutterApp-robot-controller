import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RobotNameText extends StatelessWidget {
  const RobotNameText(this.data);

  final String? data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data ?? "Sem conexão",
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: data == null ? AppColors.standardRed : AppColors.standardGreen,
      ),
    );
  }
}

class ConfigButtonText extends StatelessWidget {
  const ConfigButtonText(this.data, {Key? key}) : super(key: key);
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data.toUpperCase(),
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
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
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
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
    this.adaptiveColor = true,
    this.fontSize = 20,
    this.color = Colors.white,
  }) : super(key: key);

  final String? data;
  final double fontSize;
  final Color color;
  final bool adaptiveColor;
  @override
  Widget build(BuildContext context) {
    if (adaptiveColor) {
      return Text(
        data ?? "-",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
        ),
      );
    } else {
      return Text(
        data ?? "-",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize, color: color),
      );
    }
  }
}
