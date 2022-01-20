import 'package:admin/controllers/CurrentPageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

import '../../../constants.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Home",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              Provider.of<CurrentPageController>(context, listen: false).setCurrentPage(0);
              Navigator.pushNamed(context, "/");
            },
            pageNumber: 0,
          ),
          DrawerListTile(
            title: "Clients",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {},
            pageNumber: 1,
          ),
          /*DrawerListTile(
            title: "Task",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Documents",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Store",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),*/
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              Provider.of<CurrentPageController>(context, listen: false).setCurrentPage(2);
              Navigator.pushNamed(context, "/newClient");
            },
            pageNumber: 2,
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
            pageNumber: 3,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.pageNumber,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    int currentNumber = Provider.of<CurrentPageController>(context, listen: false).getCurrentPage;
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: currentNumber == pageNumber ? secondaryColor : Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: currentNumber == pageNumber ? secondaryColor : Colors.white54),
      ),
      selected: currentNumber == pageNumber,
      selectedTileColor: primaryColor,
    );
  }

}
