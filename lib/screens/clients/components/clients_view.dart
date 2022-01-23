import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
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
          Text(
            "Clients",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              showCheckboxColumn: false,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("File Name"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
                DataColumn(
                  label: Text("Size"),
                ),
              ],
              rows: [
                clientDataRow(context),
              ],
              /*rows: List.generate(
                demoRecentFiles.length,
                    (index) => recentFileDataRow(demoRecentFiles[index]),
              ),*/
            ),
          ),
        ],
      ),
    );
  }
}

DataRow clientDataRow(BuildContext context/*Client client*/) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            /*SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text("fileInfo.title!"),
            ),
          ],
        ),
      ),
      DataCell(Text("fileInfo.date!")),
      DataCell(Text("fileInfo.size!")),
    ],
    onSelectChanged: (value) {
      developer.log("ez");
      Navigator.pushNamed(context, "/client", arguments: "1");
    },
  );
}
