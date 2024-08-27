import 'package:flutter/material.dart';

Future<bool?> showWarning({
  required BuildContext context,
  required String dialogTitle,
  required String dialogBody,
  required Function() onConfirmedPressed,
}) async =>
    showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return ConfirmDialog(
          dialogTitle: dialogTitle,
          dialogBody: dialogBody,
          onConfirmPressed: onConfirmedPressed,
        );
      },
    );

class ConfirmDialog extends StatelessWidget {
  final String dialogTitle;
  final String dialogBody;
  final Function() onConfirmPressed;

  ConfirmDialog(
      {required this.dialogTitle,
      required this.dialogBody,
      required this.onConfirmPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(this.dialogTitle),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(this.dialogBody),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          style: ElevatedButton.styleFrom(
            side: const BorderSide(
              color: Color(0xFFbe1d1f),
            ),
            backgroundColor: Colors.white,
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Color(0xFFbe1d1f)),
          ),
        ),
        ElevatedButton(
          onPressed: onConfirmPressed,
          child: const Text('Confrim'),
        )
      ],
    );
  }
}
