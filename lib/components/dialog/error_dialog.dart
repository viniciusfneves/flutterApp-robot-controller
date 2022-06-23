import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key, required this.message, this.obs})
      : super(key: key);

  final String message;
  final String? obs;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return isIOS
        ? CupertinoAlertDialog(
            title: Text(message),
            content: obs == null ? null : Text(obs!),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Ok"),
              )
            ],
          )
        : AlertDialog(
            title: Text(message),
            content: obs == null ? null : Text(obs!),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Ok"),
              )
            ],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          );
  }
}
