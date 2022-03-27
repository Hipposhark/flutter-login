import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_login_application/assets/app_colors.dart';

class AppInput extends StatelessWidget {
  final String? type; // general, password
  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?)? validator;

  const AppInput({required this.hint, required this.controller, required this.focusNode, required this.validator, this.type});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: type == null ? false : true,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(
            color: red,
          ),
        ),
      ),
    );
  }
}


