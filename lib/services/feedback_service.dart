import 'package:flutter/material.dart';
import 'package:hms_system_application/widgets/outlined_text_input.dart';

Future<String?> showBasicInputDialog(
    context, String title, String message) async {
  var controller = TextEditingController();
  // flutter defined function
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text(title),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(builder: (context, setState) {
              return OutlinedTextInput(
                controller: controller,
                hintText: "Enter the order number",
                keyboardType: TextInputType.number,
              );
            })
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.clear();
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Continue"),
          ),
        ],
      );
    },
  );

  return controller.text;
}

Future<void> showBasicAlert(context, String title, String message) async {
  // flutter defined function
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          TextButton(
            child: const Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showLoadingDialog(context) async {
  // flutter defined function
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return const Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text("Please wait..."),
              ),
            ),
          ],
        ),
      );
    },
  );
}
