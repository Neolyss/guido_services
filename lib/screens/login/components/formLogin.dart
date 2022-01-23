import 'package:admin/models/Client.dart';
import 'package:admin/models/Codes.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'dart:developer' as developer;

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({Key? key}) : super(key: key);

  @override
  _FormLoginWidgetState createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

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
                          controller: _emailTextController,
                          decoration: const InputDecoration(hintText: 'Email'),
                        ),
                        TextFormField(
                          controller: _passwordTextController,
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
                  onPressed: () {  },
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
