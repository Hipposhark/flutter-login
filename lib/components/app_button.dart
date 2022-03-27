import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_login_application/assets/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function action;

  const AppButton({required this.text, required this.action});


  // final Color turquoise = const Color.fromRGBO(105, 188, 176, 1.0);
  // final Color white = const Color.fromRGBO(244, 244, 244, 1.0);
  // final Color grey = const Color.fromRGBO(108, 128, 127, 1.0);
  // final Color darkGrey = const Color.fromRGBO(40, 54, 55, 1.0);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          text,
          style: const TextStyle(
            color: turquoise,
            fontSize: 24,
          ),
        ),
      ),
      onPressed: () {
        action();
      },

      shape: const CircleBorder(),
      color: white,
      elevation: 0.0,
    );
  }
}


