import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../constants.dart';
import '../../../models/generique.dart';
import '../../dashboard/components/header.dart';
import 'dart:developer' as developer;

class ClientsView extends StatefulWidget {
  const ClientsView({Key? key}) : super(key: key);

  @override
  _ClientsViewState createState() => _ClientsViewState();
}

class _ClientsViewState extends State<ClientsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            GridClientsView(),
          ],
        ),
      ),
    );
  }
}

class GridClientsView extends StatefulWidget {
  const GridClientsView({Key? key}) : super(key: key);

  @override
  _GridClientsViewState createState() => _GridClientsViewState();
}

class _GridClientsViewState extends State<GridClientsView> {

  late List<DataRow> _rows;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Clients",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextButton(
                onPressed: () => { Navigator.pushNamed(context, "/newClient"), } ,
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text("New Client"),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: FutureBuilder<Map<String, dynamic>>(
              future: G.recupAllInfoClients(),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                print("snapshot.hasData client_view :" +snapshot.hasData.toString());
                if (snapshot.hasData) {
                  return DataTable2(
                    columnSpacing: defaultPadding,
                    showCheckboxColumn: false,
                    minWidth: 600,
                    columns: [
                      DataColumn(
                        label: Text("Nom"),
                      ),
                      DataColumn(
                        label: Text("Prenom"),
                      ),
                      DataColumn(
                        label: Text("Email"),
                      ),
                      DataColumn(
                          label: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 50),
                          ),
                      ),
                    ],
                    rows: clientsDataList(context, snapshot.data!),
                    /*rows: List.generate(
                demoRecentFiles.length,
                    (index) => recentFileDataRow(demoRecentFiles[index]),
              ),*/
                  );
                } else if(snapshot.hasError) {
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<DataRow> clientsDataList(BuildContext context, Map<String, dynamic> data) {
  List<DataRow> rows = [];
  data["data"].map((client) => clientDataRow(context, client)).forEach(rows.add);
  return rows;
}

DataRow clientDataRow(BuildContext context, Map<String, dynamic> client) {
  return DataRow(
    cells: [
      DataCell(Text(client["nom_client"])),
      DataCell(Text(client["prenom_client"])),
      DataCell(Text(client["email_client"])),
      DataCell(
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 50), //SET max width
          child: Icon(Icons.delete, color: Colors.red,),
        ),
        onTap: () => {
          G.deleteClient(client["nom_client"]).then((value) => Navigator.pushNamed(context, "/clients"),),
        }
      ),
    ],
    onSelectChanged: (value) {
      Navigator.pushNamed(context, "/client", arguments: client["id_client"]);
    },
  );
}