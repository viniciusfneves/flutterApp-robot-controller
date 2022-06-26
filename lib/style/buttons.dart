import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robot_controller/providers/providers.dart';
import 'package:robot_controller/style/colors.dart';
import 'package:robot_controller/style/texts.dart';

class RequestButton extends ConsumerWidget {
  const RequestButton({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        child: AspectRatio(
          aspectRatio: 3 / 1,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(color),
            ),
            onPressed: () => ref.read(ws.notifier).sendMessage("{'event_request':'${title.toLowerCase()}'}"),
            child: EventRequestText(title),
          ),
        ),
      ),
    );
  }
}

class DisengageRequestButton extends ConsumerWidget {
  const DisengageRequestButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AspectRatio(
        aspectRatio: 5.4 / 1,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.standardRed),
          ),
          onPressed: () => ref.read(ws.notifier).sendMessage("{'event_request':'disengage'}"),
          child: const EventRequestText("Disengage"),
        ),
      ),
    );
  }
}

class SetConfigButton extends StatelessWidget {
  const SetConfigButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith(
            (_) => const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          ),
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => AppColors.standardRed,
          ),
        ),
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
