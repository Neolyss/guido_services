import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/client/component/form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../dashboard/components/header.dart';
import '../main/components/side_menu.dart';

class NewClientScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            // We want this side menu only for large screen
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        Header(),
                        Padding(padding: EdgeInsets.all(defaultPadding*2)),
                        FormWidget(),
                      ],
                    ),
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
