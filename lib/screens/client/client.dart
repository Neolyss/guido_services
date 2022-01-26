import 'package:admin/models/generique.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../controllers/MenuController.dart';
import '../../responsive.dart';
import '../dashboard/components/header.dart';
import '../main/components/side_menu.dart';
import 'client_form.dart';
import 'client_view.dart';
import 'dart:developer' as developer;

import 'new_client_screen.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {

  late Future<Map<String, dynamic>> client;
  late IconData icon;
  late String key = "View";

  @override
  void initState() {
    icon = Icons.edit;
    key = "View";
    super.initState();
  }

  Future<Map<String, dynamic>> getClient(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = ModalRoute.of(context)!.settings.arguments;
    if(id == null) { // Plus d'id
      id = prefs.getString("clientId") as String;
    } else { // Id existant
      prefs.setString("clientId", id as String);
    }
    return G.recupAllInfoClient(id.toString());
  }

  @override
  Widget build(BuildContext context) {
    client = getClient(context);
    Map<String,Widget> widgets = {
      "View" : ClientView(client: client,),
      "Modify" : ClientForm(client: client),
    };
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(defaultPadding),
                  child:
                    Column(
                      children: [
                        Header(),
                        SizedBox(height: defaultPadding),
                        Container(
                          padding: EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child :
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton.icon(
                                  icon: Icon(
                                      icon
                                  ),
                                  label: Text((key == "View") ? "Modify" : "View"),
                                  onPressed: () {
                                    setState(() {
                                      icon = (icon == Icons.edit) ? Icons.arrow_back : Icons.edit;
                                      key = (key == "View") ? "Modify" : "View";
                                    });
                                  }
                              ),
                              widgets[key]!
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
