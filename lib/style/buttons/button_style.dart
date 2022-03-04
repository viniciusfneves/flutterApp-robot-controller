import 'package:blue_app/providers/providers.dart';
import 'package:blue_app/style/colors/colors.dart';
import 'package:blue_app/style/texts/text_style.dart';
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
