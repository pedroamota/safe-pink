import 'package:flutter/material.dart';

class TextFormFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  String? Function(String?)? validator;
  bool isRed;

  TextFormFieldComponent({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //keyboardType: TextInputType.emailAddress,
      //obscureText: true,
      decoration: InputDecoration(
        errorStyle: TextStyle(
            color:
                isRed ? const Color.fromARGB(255, 239, 7, 96) : Colors.white),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      controller: controller,
      validator: validator,
    );
  }
}
