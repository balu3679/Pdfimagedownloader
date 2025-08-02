import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController ctrller;
  final String label;
  final bool? isobsure;
  final TextInputAction? textinputaction;
  final TextInputType? textinputtype;
  final FormFieldValidator<String?>? validator;
  final Widget? suffixicon;
  final Widget? prefixicon;

  const CustomTextField({
    super.key,
    required this.ctrller,
    this.isobsure = false,
    required this.label,
    this.textinputaction = TextInputAction.done,
    this.textinputtype = TextInputType.text,
    this.validator,
    this.prefixicon,
    this.suffixicon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrller,
      obscureText: isobsure ?? false,
      textInputAction: textinputaction,
      keyboardType: textinputtype,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: suffixicon,
        prefixIcon: prefixicon,
      ),
      validator: validator,
    );
  }
}
