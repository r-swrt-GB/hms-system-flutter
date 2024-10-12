import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String dialogTitle;
  final String dialogBody;

  const ErrorDialog({super.key, required this.dialogTitle, required this.dialogBody});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      title: Text(dialogTitle),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(dialogBody),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Confrim'),
        )
      ],
    );
  }
}
