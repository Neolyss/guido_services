import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../dashboard/components/header.dart';

class ClientView extends StatefulWidget {
  const ClientView({Key? key, required this.client}) : super(key: key);

  final String client;

  @override
  _ClientViewState createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  @override
  Widget build(BuildContext context) {
    // id => Client
    return SafeArea(
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
              child: ClientWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class ClientWidget extends StatefulWidget {
  const ClientWidget({Key? key}) : super(key: key);

  @override
  _ClientWidgetState createState() => _ClientWidgetState();
}

class _ClientWidgetState extends State<ClientWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Client"),
      ],
    );
  }
}
