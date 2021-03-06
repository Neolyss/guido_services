import 'package:admin/constants.dart';
import 'package:admin/controllers/CurrentPageController.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/client/client.dart';
import 'package:admin/screens/clients/clients.dart';
import 'package:admin/screens/command/command.dart';
import 'package:admin/screens/login/login.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/client/new_client_screen.dart';
import 'package:admin/screens/register/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Concierge Panel',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        initialRoute: "/",
        routes: {
          "/" : (context) => MultiProvider(
            child: MainScreen(),
            providers: [
              ChangeNotifierProvider(create: (context) => MenuController(),),
              ChangeNotifierProvider(create: (context) => CurrentPageController(0, "Dashboard")),
            ],
          ),
          "/clients" : (context) => MultiProvider(
            child: ClientsScreen(),
            providers: [
              ChangeNotifierProvider(create: (context) => MenuController(),),
              ChangeNotifierProvider(create: (context) => CurrentPageController(1, "Clients")),
            ],
          ),
          "/client" : (context) => MultiProvider(
            child: ClientScreen(),
            providers: [
              ChangeNotifierProvider(create: (context) => MenuController(),),
              ChangeNotifierProvider(create: (context) => CurrentPageController(1, "Client")),
            ],
          ),
          "/newClient" : (context) => MultiProvider(
            child: NewClientScreen(),
            providers: [
              ChangeNotifierProvider(create: (context) => MenuController(),),
              ChangeNotifierProvider(create: (context) => CurrentPageController(2, "New Client")),
            ],
          ),
          "/register" : (context) => MultiProvider(
            child: Register(),
            providers: [
              ChangeNotifierProvider(create: (context) => CurrentPageController(-1, "Register")),
            ],
          ),
          "/login" : (context) => MultiProvider(
            child: Login(),
            providers: [
              ChangeNotifierProvider(create: (context) => CurrentPageController(-1, "Login")),
            ],
          ),
          "/newCommand" : (context) => MultiProvider(
            child: CommandScreen(),
            providers: [
              ChangeNotifierProvider(create: (context) => MenuController(),),
              ChangeNotifierProvider(create: (context) => CurrentPageController(3, "New Command")),
            ],
          ),
          "/command" : (context) => MultiProvider(
            child: CommandScreen(),
            providers: [
              ChangeNotifierProvider(create: (context) => MenuController(),),
              ChangeNotifierProvider(create: (context) => CurrentPageController(0, "Command")),
            ],
          ),
         },
      );
  }
}
