import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../constants.dart';
import '../../controllers/MenuController.dart';
import '../../responsive.dart';
import '../dashboard/components/header.dart';
import '../main/components/side_menu.dart';

class CommandScreen extends StatefulWidget {
  const CommandScreen({Key? key}) : super(key: key);

  @override
  _CommandScreenState createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            // We want this side menu only for large screen
            Expanded(
              flex: 5,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Header(),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommandFormView(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommandFormView extends StatefulWidget {
  const CommandFormView({Key? key}) : super(key: key);

  @override
  _CommandFormViewState createState() => _CommandFormViewState();
}

class _CommandFormViewState extends State<CommandFormView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Infos"),
                Wrap(
                  runSpacing: 10,
                  children: [
                    Row(
                      children: [
                        Text("Nom : "),
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(child:
                        TextFormField(
                          //controller: _lastNameTextController,
                          decoration: const InputDecoration(hintText: 'Last Name'),
                        ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Prénom : "),
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(child:
                        TextFormField(
                          //controller: _firstNameTextController,
                          decoration: const InputDecoration(hintText: 'First name'),
                        ),
                        ),
                      ],
                    ),
                    TextFormField(
                      //controller: _emailTextController,
                      decoration: const InputDecoration(hintText: 'sample.example@gmail.com'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
