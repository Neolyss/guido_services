import 'package:flutter/material.dart';

import '../../constants.dart';
import '../dashboard/components/header.dart';

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
            direction: Axis.horizontal,
            children: [
              Text("Numero : ${client["numero_adresse"] ?? "Aucun"}"),
              Text("Nom Adresse : ${client["nom_adresse"] ?? "Aucun"}"),
              Text("${client["complement"] != null ? "Complément : ${client["complement"]}" : ""}"),
            ],
          ),
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Numero : ${client["numero_adresse"] ?? "Aucun"}"),
              Text("Nom Adresse : ${client["nom_adresse"] ?? "Aucun"}"),
              Text("${client["complement"] != null ? "Complément: ${client["complement"]}" : ""}"),
            ],
        ),*/
        if(client["telephone_adresse"] != null)
          Padding(padding: EdgeInsets.all(defaultPadding),
            child: Wrap(
              spacing: 20,
              children: [
                Text("Téléphone : ${client["code_pays_telephone"]} ${client["telephone_adresse"]}"),
              ],
            ),
          ),
        //Text(client["ville"] ?? "Null"),
      ],
    );
  }
}
