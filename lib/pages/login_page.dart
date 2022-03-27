import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login_application/components/app_input.dart';
import 'package:firebase_login_application/pages/register_page.dart';
import 'package:firebase_login_application/utils/fire_auth.dart';
import 'package:firebase_login_application/pages/profile_page.dart';
import 'package:firebase_login_application/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_login_application/assets/app_colors.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Authentication'),
      ),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                const Text('Login'),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      AppInput(hint: "Email", controller: _emailTextController, focusNode: _focusEmail, validator: (value) => Validator.validateEmail(email: value)),
                      const SizedBox(height: 8.0),
                      AppInput(type: "password", hint: "Password", controller: _passwordTextController, focusNode: _focusPassword, validator: (value) => Validator.validatePassword(password: value)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  User? user = await FireAuth.signInUsingEmailPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text,
                                  );
                                  if (user != null) {
                                    Navigator.of(context)
                                        .pushReplacement(
                                      MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
                                    );
                                  }
                                }
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => RegisterPage()),
                                );
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}