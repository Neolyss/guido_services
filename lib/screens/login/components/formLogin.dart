import 'package:admin/controllers/CurrentPageController.dart';
import 'package:admin/models/Client.dart';
import 'package:admin/models/Codes.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import 'dart:developer' as developer;

import '../../../models/generique.dart';

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({Key? key}) : super(key: key);

  @override
  _FormLoginWidgetState createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  final _formKey = GlobalKey<FormState>();

  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  void connect(SharedPreferences value, String pseudo) {
    value.setBool("connected", true);
    value.setString("login", pseudo);
    Navigator.pushNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Login"),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        TextFormField(
                          controller: _usernameTextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(hintText: 'Email'),
                        ),
                        TextFormField(
                          controller: _passwordTextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(hintText: 'Password'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String username = _usernameTextController.text;
                      String password = _passwordTextController.text;
                      String s = "Login = $username $password";
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login"),),
                      );
                      developer.log(s);
                      G.responsableCheck(username, password).then(
                        (value) => {
                          developer.log("r $value"),
                          if(value == 1) {
                            SharedPreferences.getInstance().then((value) => connect(value, username))
                          }
                        }
                      );
                    }
                  },
                  child: Text("Valider"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
