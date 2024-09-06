import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController inputControllerEmail;
  final bool readOnly;
  final String hintText;
  final Function()? onTap;
  final Color color;
  final int maxLines;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final IconData? icon;
  final InputBorder? border;
  final InputBorder? enabledBorder;

  const InputTextField({
    super.key,
    required this.inputControllerEmail,
    required this.hintText,
    required this.onTap,
    required this.readOnly,
    this.maxLines = 1,
    this.color = Colors.black,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.border = InputBorder.none,
    this.enabledBorder = InputBorder.none,
  });

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xffffffff);

    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
      controller: inputControllerEmail,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 15, color: Colors.black),
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        prefixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Icon(icon, color: color),
            )
          ],
        ),
        labelStyle: TextStyle(color: color),
        filled: true,
        fillColor: accentColor,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
