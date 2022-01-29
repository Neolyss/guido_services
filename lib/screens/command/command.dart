import 'package:admin/models/generique.dart';
import 'package:admin/screens/command/components/DateTimeInput.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../controllers/MenuController.dart';
import '../../responsive.dart';
import '../dashboard/components/header.dart';
import '../main/components/side_menu.dart';
import 'components/Product.dart';

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
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommandFormView(),
                            ],
                          ),
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

  late TextEditingController _nomClientController = TextEditingController();
  late TextEditingController _streetNumberTextController = TextEditingController();
  late TextEditingController _streetTextController = TextEditingController();
  late TextEditingController _streetComplementTextController = TextEditingController();
  late TextEditingController _postalCodeTextController = TextEditingController();
  late TextEditingController _cityTextController = TextEditingController();
  late TextEditingController _dateLivraison = TextEditingController();

  late TextEditingController _streetNumberTextControllerFacture = TextEditingController();
  late TextEditingController _streetTextControllerFacture = TextEditingController();
  late TextEditingController _streetComplementTextControllerFacture = TextEditingController();
  late TextEditingController _postalCodeTextControllerFacture = TextEditingController();
  late TextEditingController _cityTextControllerFacture = TextEditingController();

  late DateTime _dateCommande;
  late String _numCommande = '';

  bool _siAdresseFactureDiff = false;

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
                Text("Infos principales", style: TextStyle(fontSize: 20.0),),
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
                            onDateSubmitted: (val) => _dateCommande = val,
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
                            controller: _nomClientController,
                            decoration: const InputDecoration(hintText: 'Numéro de client'),
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
          // Adresse livraison
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Adresse livraison", style: TextStyle(fontSize: 20.0),),
                Wrap(
                  runSpacing: 10,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _siAdresseFactureDiff,
                          onChanged: (value) {
                            setState(() {
                              _siAdresseFactureDiff = !_siAdresseFactureDiff;
                            });
                          },
                        ),
                        Text('Adresse de facturation différente'),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _streetNumberTextController,
                            decoration: const InputDecoration(hintText: 'N° Rue'),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _streetTextController,
                            decoration: const InputDecoration(hintText: 'Rue'),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _streetComplementTextController,
                            decoration: const InputDecoration(hintText: 'Complément'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _postalCodeTextController,
                            decoration: const InputDecoration(hintText: 'Code postal'),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            controller: _cityTextController,
                            decoration: const InputDecoration(hintText: 'Ville'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Livraison
          //Adresse facturation
          if (_siAdresseFactureDiff)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Adresse Facturation", style: TextStyle(fontSize: 20.0),),
                Wrap(
                  runSpacing: 10,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _streetNumberTextControllerFacture,
                            decoration: const InputDecoration(hintText: 'N° Rue'),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _streetTextControllerFacture,
                            decoration: const InputDecoration(hintText: 'Rue'),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _streetComplementTextControllerFacture,
                            decoration: const InputDecoration(hintText: 'Complément'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _postalCodeTextControllerFacture,
                            decoration: const InputDecoration(hintText: 'Code postal'),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            controller: _cityTextControllerFacture,
                            decoration: const InputDecoration(hintText: 'Ville'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Facture
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Livraison", style: TextStyle(fontSize: 20.0),),
                DateTimeInput(controller: _dateLivraison,),
              ],
            ),
          ),
          // Produits
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Produits", style: TextStyle(fontSize: 20.0),),
                Padding(padding: EdgeInsets.all(defaultPadding)),
                ProductLine(create: true, ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  //submitForm();
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  _numCommande = await G.createCommande("To buy", prefs.getString("login").toString(), _nomClientController.value.text);
                }
              },
              child: Text("Valider"),
            ),
          ),
        ],
      ),
    );
  }
}
