import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlinedTextInput extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String? value)? validator;
  final Function(String? value)? onChanged;
  final Widget? prefix;
  final TextAlign textAlign;
  final bool isDense;
  final List<TextInputFormatter> inputFormatters;
  final String? errorMessage;
  final bool obscureText;
  final bool readOnly;
  final FocusNode? focusNode;
  final List<String>? autofillHints;
  final BorderRadius? borderRadius;
  final BorderSide? globalBorderSide;
  final BorderSide? focusedBorderSide;
  final BorderSide? enabledBorderSide;
  final BorderSide? errorBorderSide;
  final BorderSide? errorFocusedBorderSide;
  final TextStyle? errorStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? style;
  final Widget? label;

  const OutlinedTextInput({
    super.key,
    this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefix,
    this.controller,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.isDense = false,
    this.inputFormatters = const [],
    this.errorMessage,
    this.obscureText = false,
    this.readOnly = false,
    this.focusNode,
    this.autofillHints,
    this.borderRadius,
    this.focusedBorderSide,
    this.enabledBorderSide,
    this.errorBorderSide,
    this.errorFocusedBorderSide,
    this.errorStyle,
    this.labelStyle,
    this.label,
    this.hintTextStyle,
    this.globalBorderSide,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      autofillHints: autofillHints,
      focusNode: focusNode,
      readOnly: readOnly,
      obscureText: obscureText,
      textAlign: textAlign,
      controller: controller,
      decoration: InputDecoration(
        label: label,
        helperText: hintText,
        helperStyle: hintTextStyle,
        hintMaxLines: 2,
        errorText: errorMessage,
        labelText: labelText,
        isDense: isDense,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 7.0,
          vertical: 7.0,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(3.0),
          borderSide: focusedBorderSide ??
              globalBorderSide ??
              const BorderSide(
                color: Color(0xFF2E2F30),
                width: 1.0,
              ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(3.0),
          borderSide: enabledBorderSide ??
              globalBorderSide ??
              const BorderSide(
                color: Color(0xFF2E2F30),
                width: 1.0,
              ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(3.0),
          borderSide: errorBorderSide ??
              globalBorderSide ??
              const BorderSide(
                color: Color(0xFF2E2F30),
                width: 1.0,
              ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(3.0),
          borderSide: focusedBorderSide ??
              globalBorderSide ??
              const BorderSide(
                color: Color(0xFF2E2F30),
                width: 1.0,
              ),
        ),
        prefixIcon: prefix,
        errorStyle: errorStyle ?? const TextStyle(color: Colors.red),
        labelStyle: labelStyle ?? const TextStyle(color: Colors.black),
      ),
      textAlignVertical: TextAlignVertical.center,
      onChanged: (input) {
        if (onChanged != null) onChanged!(input);
      },
      onEditingComplete: () {},
      onSaved: (input) {},
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: (String? value) {
        if (validator != null) return validator!(value);
        return null;
      },
    );
  }
}
