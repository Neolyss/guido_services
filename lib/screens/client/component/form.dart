import 'package:admin/models/Client.dart';
import 'package:admin/models/Codes.dart';
import 'package:admin/models/Reseaux.dart';
import 'package:admin/models/generique.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'dart:developer' as developer;

class FormWidget extends StatefulWidget {
  FormWidget({Key? key, this.client = const {} }) : super(key: key);

  final Map<String, dynamic> client;

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameTextController = TextEditingController();
  late TextEditingController _lastNameTextController = TextEditingController();
  late TextEditingController _emailTextController = TextEditingController();
  late TextEditingController _phoneNumberTextController = TextEditingController();
  late TextEditingController _streetNumberTextController = TextEditingController();
  late TextEditingController _streetTextController = TextEditingController();
  late TextEditingController _streetComplementTextController = TextEditingController();
  late TextEditingController _postalCodeTextController = TextEditingController();
  late TextEditingController _cityTextController = TextEditingController();

  late CountryCode _phoneCode = CountryCode(name: 'France', dialCode: '+33', code: 'FR');
  late String _code = _phoneCode.code;
  late Future<List<CountryCode>> _codes;
  late List<CountryCode> _countryCodes;
  var _links = <Widget>[];

  late Future<Map<String, dynamic>> _futureReseaux;
  late Future<Map<String, dynamic>> _futureType;
  late int _typeIdController;

  void addLink() {
    setState(() {
      _links.add(
        SocialMediaField(links: _links, function: removeLink,),
      );
    });
  }

  void removeLink(SocialMediaField field) {
    developer.log("salted");
    setState(() {
      developer.log(field.toString());
      _links.remove(
        field,
      );
    });
  }

  @override
  void initState() {
    final Map<String, dynamic> client = widget.client;
    if(widget.client.isNotEmpty) {
      _firstNameTextController = TextEditingController(text: client["nom_client"] ?? "");
      _lastNameTextController = TextEditingController(text: client["prenom_client"] ?? "");
      _emailTextController = TextEditingController(text: client["email_client"] ?? "");
      _phoneNumberTextController = TextEditingController(text: client["adresse"]["telephone"] ?? "");
      _streetNumberTextController = TextEditingController(text: client["adresse"]["numero"] ?? "");
      _streetTextController = TextEditingController(text: client["adresse"]["nom"] ?? "");
      _streetComplementTextController = TextEditingController(text: client["adresse"]["complement"] ?? "");
      _postalCodeTextController = TextEditingController(text: client["adresse"]["code_postal"] ?? "");
      _cityTextController = TextEditingController(text: client["adresse"]["ville"] ?? "");
    }
    _futureReseaux = G.getAllReseaux();
    _futureType = G.getAllTypes();
    _typeIdController = 1;
    super.initState();
  }

  void submitForm() {
    final Map<String, dynamic> client = widget.client;
    CountryCode currentCode = _countryCodes.firstWhere((element) => element.code == _code);
    if(client.isEmpty) { // Création
      developer.log("Create new client");
      createClient().then(
        (id) => createAdresse(currentCode, id).then(
          (value) => Navigator.pushNamed(context, "/client", arguments: id)
        )
      );
    } else { // Modif
      String idClient = client["id_client"];
      modificationClient(idClient, client).then((value) => {
        // Check adresse
        if(client["adresse"].isEmpty) {
          developer.log("create adresse"),
          createAdresse(currentCode, idClient).then((value) =>
            Navigator.pushNamed(context, "/client", arguments: idClient)
          )
        } else {
          developer.log("modif adresse"),
          modifAdresse(client, currentCode, idClient).then((value) =>
              Navigator.pushNamed(context, "/client", arguments: idClient)
          )
        },
      });
    }
  }

  Future<void> modifAdresse(Map<String, dynamic> client, CountryCode currentCode, String idClient) {
    return G.modifAdresse(
          client["adresse"]["id"],
          _streetNumberTextController.text,
          _streetTextController.text,
          _streetComplementTextController.text,
          _postalCodeTextController.text,
          _cityTextController.text,
          currentCode.dialCode,
          _phoneNumberTextController.text,
          idClient,
        );
  }

  Future<void> modificationClient(String idClient, Map<String, dynamic> client) {
    return G.modificationClient(
        idClient,
        _emailTextController.text,
        _lastNameTextController.text,
        client["points_fixe"],
        _firstNameTextController.text
    );
  }
  
  Future<String> createClient() {
    return G.createClient(
      _firstNameTextController.text,
      _lastNameTextController.text,
      _emailTextController.text,
      0,
      1,
    );
  }

  Future<void> createAdresse(CountryCode currentCode, String id) {
    return G.createAdresse(
      _streetNumberTextController.text,
      _streetTextController.text,
      _streetComplementTextController.text,
      _postalCodeTextController.text,
      _cityTextController.text,
      currentCode.dialCode,
      _phoneNumberTextController.text,
      id,
    );
  }

  @override
  Widget build(BuildContext context) {
    _codes = fetchCountryCodes();
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
                                controller: _lastNameTextController,
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
                                controller: _firstNameTextController,
                                decoration: const InputDecoration(hintText: 'First name'),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _emailTextController,
                          decoration: const InputDecoration(hintText: 'sample.example@gmail.com'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Adresse",),
                    Wrap(
                      runSpacing: 10,
                      children: [
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Social Medias"),
                    FutureBuilder(
                      future: _futureReseaux,
                      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        if(snapshot.hasData) {
                          return Column(
                            children: _links,
                          );
                        } else if(snapshot.hasError) {
                          return Text("Error please contacr an admin");
                        } else {
                          return Column(
                            children: [],
                          );
                        }
                      }
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: addLink,
                          child: Text("Add Link"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    //Padding(padding: EdgeInsets.all(defaultPadding)),
                    FutureBuilder(
                      future: _codes,
                      builder: (BuildContext context, AsyncSnapshot<List<CountryCode>> snapshot) {
                        List<DropdownMenuItem<String>> dropdowns = [];
                        List<CountryCode>? codes = snapshot.data;
                        if (snapshot.hasData) {
                          _countryCodes = codes!;
                          _countryCodes.map((i) =>
                              DropdownMenuItem<String>(
                                value: i.code,
                                child: FittedBox(fit: BoxFit.cover, child: Text("${i.name} : ${i.dialCode}"),),
                              ),
                          ).forEach((e) => dropdowns.add(e));
                          if(widget.client.isNotEmpty && !widget.client["adresse"].isEmpty) {
                            String dialCode = widget.client["adresse"]["code_pays_telephone"];
                            _phoneCode = codes.firstWhere((element) => element.dialCode == ((dialCode == "") ? "+33" : dialCode));
                            _code = _phoneCode.code;
                          }
                          return Expanded(
                            child: DropdownButtonFormField<String>(
                              onChanged: (value) {
                                _code = value!;
                              },
                              hint: Text("Dial Phone"),
                              value: _phoneCode.code,
                              items: dropdowns,
                              isExpanded: true,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Expanded(child:
                          DropdownButtonFormField<String>(
                            onChanged: (value) {},
                            items: [],
                          ),
                          );
                        } else {
                          return SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    Padding(padding: EdgeInsets.all(defaultPadding)),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _phoneNumberTextController,
                        decoration: const InputDecoration(hintText: 'Phone number'),
                      ),
                    ),
                    //Padding(padding: EdgeInsets.all(defaultPadding)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  runSpacing: defaultPadding,
                  direction: Axis.horizontal,
                  children: [
                    FittedBox(fit: BoxFit.cover, child: Text("Type Client"),),
                    FutureBuilder<Map<String, dynamic>>(
                      future: _futureType,
                      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        if(snapshot.hasData) {
                          List<TypeClient> types = TypeClient.getListTypeClient(snapshot.data!);
                          return DropdownButtonFormField<int>(
                            onChanged: (value) {
                              setState(() {
                                _typeIdController = value!;
                              });
                            },
                            isExpanded: true,
                            value: _typeIdController,
                            items: types.map((e) => DropdownMenuItem<int>(value: e.id,child: Text(e.nom))).toList(),
                          );
                        } else if(snapshot.hasError) {
                          return Text("Error please contacr an admin");
                        } else {
                          return DropdownButtonFormField<String>(
                            isExpanded: true,
                            items: [],
                            onChanged: (Object? value) {  },
                          );
                        }
                    })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submitForm();
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

class SocialMediaField extends StatefulWidget {
  const SocialMediaField({Key? key, required this.links, required this.function}) : super(key: key);

  final List<Widget> links;
  final Function function;

  @override
  _SocialMediaFieldState createState() => _SocialMediaFieldState();
}

class _SocialMediaFieldState extends State<SocialMediaField> {

  @override
  Widget build(BuildContext context) {
    String? _socialController = "Facebook";
    var _socials = [
      "Facebook", "Instagram", "Twitter"
    ];
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            onChanged: (value) {
              setState(() {
                _socialController = value;
              });
            },
            value: _socialController,
            items: _socials.map((element) { return DropdownMenuItem<String>(
                value: element,
                child: FittedBox(fit: BoxFit.cover, child: Text(element),),);
            }).toList(),
          ),
        ),
        Padding(padding: EdgeInsets.all(defaultPadding)),
        Expanded(
          flex: 8,
            child: TextFormField(
              //controller: _firstNameTextController,
              decoration: const InputDecoration(hintText: 'URL'),
            ),
        ),
        Expanded(
          child: IconButton(
            onPressed: () {
              widget.function(this.widget);
            },
            icon: Icon(Icons.clear, color: Colors.red,),
          ),
        ),
      ],
    );
  }
}

