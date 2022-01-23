import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../controllers/MenuController.dart';
import '../../responsive.dart';
import '../main/components/side_menu.dart';
import 'components/clients_view.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //redirect(context);
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
              child: ClientsView(),
            ),
          ],
        ),
      ),
    );
  }
}
