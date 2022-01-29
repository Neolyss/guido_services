import 'dart:io' as io;

import 'package:admin/models/generique.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../models/Bill.dart';
import '../../../models/Commande.dart';
import 'package:excel/excel.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:developer' as developer;

class CommandsView extends StatefulWidget {
  const CommandsView({Key? key}) : super(key: key);

  @override
  _CommandsViewState createState() => _CommandsViewState();
}

class _CommandsViewState extends State<CommandsView> {

  Future<Map<String, dynamic>> getCommands(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return G.commandeInfoAllResponsable(prefs.getString("login"));
  }
  
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
                "Commands",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextButton.icon(
                  onPressed: () => { Navigator.pushNamed(context, "/newCommand"), },
                  icon: Icon(Icons.add),
                  label: Text("New Command"),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(defaultPadding)),
          SizedBox(
            width: double.infinity,
            child: FutureBuilder<Map<String, dynamic>>(
              future: getCommands(context),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                print("snapshot.hasData : "+snapshot.hasData.toString());
                if (snapshot.hasData) {
                  List<Command> commands = Command.getCommandsFromJson(snapshot.data!);
                  return Wrap(
                    runSpacing: 10,
                    children: commands.map((e) => CommandView(command: e)).toList(),
                  );
                } else if(snapshot.hasError) 
                  return Container(child: Text("Error please contact an admin"),);
                else {
                  return Container(child: Text("Loading ..."),);
                }
              },
            )
          ),
        ],
      ),
    );
  }
}

class CommandView extends StatefulWidget {
  const CommandView({Key? key, required this.command,}) : super(key: key);

  final Command command;

  @override
  _CommandViewState createState() => _CommandViewState();
}

class _CommandViewState extends State<CommandView> {
  @override
  Widget build(BuildContext context) {
    Command c = widget.command;
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(c.idCommand),
          Text(c.dateCommand.toString()),
          Text(c.state.name),
          TextButton.icon(
            onPressed: () => { generateBill(c.idCommand), },
            icon: Icon(Icons.account_balance_outlined),
            label: Text("Bill"),
          ),
          Row(children: [
            IconButton(
              onPressed: () => { Navigator.pushNamed(context, "/command"), },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () => { G.deleteCommande(c.idCommand, c.idClient), Navigator.pushNamed(context, "/") },
              icon: Icon(Icons.delete),
            ),
          ],),
        ],
      ),
      //subtitle: Text('Trailing expansion arrow icon'),
      children: <Widget>[
        FutureBuilder<Map<String, dynamic>>(
          future: G.commandeInfo(c.idCommand),
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> json = snapshot.data!;
              var header = json["commande"];
              var livrer = json["livrer"];
              var adresse = json["adresse"];
              var produits = json["produits"];
              return Column(
                children: [
                  Wrap(
                    spacing: 10,
                    children: [
                      Text(header["id_commande"]),
                      Text(header["date_commande"]),
                      Text(header["etat_commande"]),
                      Text(header["id_client"]),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Wrap(
                    spacing: 10,
                    children: [
                      Text(livrer["date_livraison"] ?? "Aucune"),
                      Text(livrer["num_colis"] ?? "Aucun"),
                      Text(livrer["nom_livreur"] ?? "Aucun"),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Wrap(
                    spacing: 10,
                    children: [
                      Text(adresse["numero_adresse"] ?? "Aucune"),
                      Text(adresse["nom_adresse"] ?? "Aucun"),
                      Text(adresse["complement"] ?? "Aucun"),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Wrap(
                    spacing: 10,
                    children: [
                      Text(adresse["code_postal"] ?? "Aucune"),
                      Text(adresse["ville"] ?? "Aucun"),
                      Text(adresse["code_pays_telephone"] ?? "Aucun"),
                      Text(adresse["telephone_adresse"] ?? "Aucun"),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  for(var item in produits) Wrap(children: [
                    Text("PRODUIT : "),
                    Text(item["nom"]),
                    Text(item["modele"]),
                    Text(item["qtt"].toString()),
                    Text(item["prix_unitaire"].toString()),
                    Text(item["etat"]),],spacing: 10,)
                ],
              );
            } else if(snapshot.hasError)
              return Container(child: Text("Error please contact an admin"),);
            else {
              return Container(child: Text("Loading ..."),);
            }
          }
        ),
      ],
    );
  }

  void generateExcel() {
    var excel = Excel.createExcel();
    List<String> columns = [
      "","","","","","",""
    ];
    excel.appendRow("Sheet1" , columns);
    String outputFile = "/excel.xlsx";
    /*excel.encode()?.then((onValue) {
      io.File(outputFile)
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });*/
  }
  
  void generateBill(String commandId) async {
    Map<String, dynamic> json = await G.factureGetCommande(commandId);
    Bill bill = Bill.fromJson(json);
    developer.log("test : "+ bill.toString());
    double sum = 0;
    for (var o in bill.products) {
      sum += o.totalPrice;
    }
    sum += bill.deliveryFee;
    sum += bill.serviceFee;
    sum += bill.promotion;

    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text("Facture"),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Column(
                    children: [
                      pw.Text("N° commande : ${bill.idCommand}"),
                      pw.Text("Date commande : ${bill.commandDate}"),
                      pw.Text("N° facture : ${bill.id}"),
                      pw.Text("Date de facture : ${bill.date}"),
                    ],
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    children: [
                      pw.Text("N° client : ${bill.idClient}"),
                      pw.Text("Adresse : ${bill.address}"),
                      pw.Text("Téléphone : ${bill.phone}"),
                    ],
                  ),
                ],
              ),
              pw.Table(
                children: generateTable(bill),
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text("Montant de la commande: $sum"),
                  pw.Text("Frais de service : ${ bill.serviceFee }"),
                  pw.Text("Frais de livraison : ${ bill.deliveryFee }"),
                  pw.Text("Promotion : ${ bill.promotion }"),
                ],
              ),
            ],
          );
        }
    ));
    io.File file = io.File("facture/bill_${bill.id}");
    file.writeAsBytes(await pdf.save());
  }

  List<pw.TableRow> generateTable(Bill bill) {
    List<pw.TableRow> rows = [];
    rows.add(pw.TableRow(children: [
      pw.Text("Name"),
      pw.Text("Model"),
      pw.Text("Quantity"),
      pw.Text("UnitPrice"),
      pw.Text("TotalPrice"),
    ]));
    bill.products.forEach((element) {
      rows.add(pw.TableRow(children: [
        pw.Text(element.name),
        pw.Text(element.model),
        pw.Text(element.quantity.toString()),
        pw.Text(element.unitPrice.toString()),
        pw.Text(element.state.name),
      ]));
    });
    return rows;
  }
}

