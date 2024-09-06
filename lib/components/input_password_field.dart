import 'package:flutter/material.dart';
import 'package:hms_system_application/methods/validation_methods.dart';

class InputPasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController inputControllerPassword;
  final Color color;
  final IconData icon;
  final String? Function(String?) validator;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? enabledBorder;

  const InputPasswordTextField({
    required this.hintText,
    required this.inputControllerPassword,
    this.color = Colors.black,
    required this.icon,
    required this.validator,
    this.border = InputBorder.none,
    this.focusedBorder = InputBorder.none,
    this.errorBorder = InputBorder.none,
    this.enabledBorder = InputBorder.none,
    super.key,
  });

  @override
  State<InputPasswordTextField> createState() => _InputPasswordTextFieldState();
}

class _InputPasswordTextFieldState extends State<InputPasswordTextField> {
  bool _visiblePassword = true;

  @override
  Widget build(BuildContext context) {
    const accentColor = Colors.white;
    //const errorColor = Color(0xffEF4444);
    return TextFormField(
      validator: (password) => passwordValidator(password),
      controller: widget.inputControllerPassword,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(fontSize: 15, color: Colors.black),
      obscureText: _visiblePassword,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        prefixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 20.0,
                width: 20.0,
                child: Icon(widget.icon, color: widget.color)),
          ],
        ),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _visiblePassword = !_visiblePassword),
          icon: Icon(
            _visiblePassword ? Icons.visibility : Icons.visibility_off,
            size: 20.0,
            color: widget.color,
          ),
        ),
        labelStyle: TextStyle(color: widget.color),
        filled: true,
        fillColor: accentColor,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        // focusedBorder: widget.focusedBorder,
        // errorStyle: const TextStyle(color: errorColor),
        // errorBorder: widget.errorBorder,
        // enabledBorder: widget.enabledBorder,
      ),
    );
  }
}
