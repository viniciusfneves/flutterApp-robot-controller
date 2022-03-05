import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/style/colors.dart';
import 'package:blue_app/style/texts.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
            onPressed: () => ref
                .read(ws)
                .sink
                .add("{'event_request':'${title.toLowerCase()}'}"),
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
        aspectRatio: 5 / 1,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.standardRed),
          ),
          onPressed: () =>
              ref.read(ws).sink.add("{'event_request':'disengage'}"),
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
    return ElevatedButton(
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
    );
  }
}
