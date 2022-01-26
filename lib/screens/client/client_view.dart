import 'package:flutter/material.dart';

import '../../constants.dart';
import '../dashboard/components/header.dart';
import 'dart:developer' as developer;

class ClientView extends StatefulWidget {
  const ClientView({Key? key, required this.client}) : super(key: key);

  final Future<Map<String, dynamic>> client;

  @override
  _ClientViewState createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: widget.client,
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if(snapshot.hasData) {
            return ClientWidget(client: snapshot.data!);
          } else if(snapshot.hasError) {
            return Text("Error please contact a admin");
          } else {
            return Container();
          }
       },
    );
  }
}

class ClientWidget extends StatefulWidget {
  const ClientWidget({Key? key, required this.client}) : super(key: key);

  final Map<String, dynamic> client;

  @override
  _ClientWidgetState createState() => _ClientWidgetState();
}

class _ClientWidgetState extends State<ClientWidget> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> client = widget.client;
    developer.log(client.toString());
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(defaultPadding),
          child: Wrap(
            spacing: 20,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              Text("Nom : ${client["nom_client"]}"),
              Text("Prénom : ${client["prenom_client"]}"),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(defaultPadding),
          child: Wrap(
            spacing: 20,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              Text("Email : ${client["email_client"]}"),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(defaultPadding),
          child: Wrap(
            spacing: 20,
            direction: Axis.horizontal,
            children: [
              Text("Numero : ${client["adresse"]["numero"] ?? "Aucun"}"),
              Text("Nom Adresse : ${client["adresse"]["nom"] ?? "Aucun"}"),
              Text("${client["adresse"]["complement"] != null ? "Complément : ${client["adresse"]["complement"]}" : ""}"),
            ],
          ),
        ),
        if(client["adresse"]["ville"] != null)
          Padding(padding: EdgeInsets.all(defaultPadding),
            child: Wrap(
              spacing: 20,
              children: [
                Text("Location : ${client["adresse"]["code_postal"]} ${client["adresse"]["ville"]}"),
              ],
            ),
          ),
        if(client["adresse"]["telephone"] != null)
          Padding(padding: EdgeInsets.all(defaultPadding),
            child: Wrap(
              spacing: 20,
              children: [
                Text("Téléphone : ${client["adresse"]["code_pays_telephone"]} ${client["adresse"]["telephone"]}"),
              ],
            ),
          ),
      ],
    );
  }
}
