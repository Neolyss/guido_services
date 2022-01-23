import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/MenuController.dart';
import '../../responsive.dart';
import '../main/components/side_menu.dart';
import 'component/client_view.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  Future<String> getClient(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = ModalRoute.of(context)!.settings.arguments;
    if(id == null) { // Plus d'id
      id = prefs.getString("clientId") as String;
    } else { // Id existant
      prefs.setString("clientId", id as String);
    }
    return id as String;
  }

  @override
  Widget build(BuildContext context) {
    Future<String> client = getClient(context);
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
              child: FutureBuilder(
                future: client,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if(snapshot.hasData) {
                    return ClientView(client : snapshot.data!);
                  } else if(snapshot.hasError) {
                    return Text("Error please contact a admin");
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
