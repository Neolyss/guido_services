import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/client/component/form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../dashboard/components/header.dart';
import '../main/components/side_menu.dart';

class ClientForm extends StatefulWidget {
  const ClientForm({Key? key, required this.client}) : super(key: key);

  final Future<Map<String, dynamic>> client;

  @override
  _ClientFormState createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientForm> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: widget.client,
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if(snapshot.hasData) {
          return FormWidget(client: snapshot.data!);
        } else if(snapshot.hasError) {
          return Text("Error please contact a admin");
        } else {
          return Container();
        }
      },
    );
  }
}
