import 'package:flutter/material.dart';

class FormRegisterWidget extends StatefulWidget {
  const FormRegisterWidget({Key? key}) : super(key: key);

  @override
  _FormRegisterWidgetState createState() => _FormRegisterWidgetState();
}

class _FormRegisterWidgetState extends State<FormRegisterWidget> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final _pseudoTextController = TextEditingController();
    final _emailTextController = TextEditingController();
    final _nomTextController = TextEditingController();
    final _prenomTextController = TextEditingController();
    final _passwordTextController = TextEditingController();

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
                    Text("Register"),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        TextFormField(
                          controller: _pseudoTextController,
                          decoration: const InputDecoration(hintText: 'Pseudo'),
                        ),
                        TextFormField(
                          controller: _emailTextController,
                          decoration: const InputDecoration(hintText: 'Email'),
                        ),
                        TextFormField(
                          controller: _nomTextController,
                          decoration: const InputDecoration(hintText: 'Nom'),
                        ),
                        TextFormField(
                          controller: _prenomTextController,
                          decoration: const InputDecoration(hintText: 'Prénom'),
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
