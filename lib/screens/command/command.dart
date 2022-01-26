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
          // Infos principales
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Infos principales"),
                Row(
                  children: [
                    Expanded(child:
                      Row(
                      children: [
                        Text("Date Commande : "),
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(child:
                          InputDatePickerFormField(
                            lastDate: DateTime(2022, DateTime.december),
                            firstDate: DateTime(2022, DateTime.january),
                            //controller: _firstNameTextController,
                          ),
                        ),
                      ],
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                    Expanded(child:
                      Row(
                      children: [
                        Text("Client : "),
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(child:
                          // Dropdown contenant nom prénom avec en paramètre un id
                          TextFormField(
                            //controller: _firstNameTextController,
                            decoration: const InputDecoration(hintText: 'First name'),
                          ),
                        ),
                      ],
                    ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Adresse
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Adresse"),

              ],
            ),
          ),
          // Livraison
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Livraison"),

              ],
            ),
          ),
          // Produits
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Produits"),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
