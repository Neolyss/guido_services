// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:admin/models/Client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

import 'package:admin/main.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   //await tester.pumpWidget(MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   //await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  test('Test création d\'un client dans la base de donnée', () async {
    Telephone telephone = Telephone("+33", "0785964585");
    Adresse adresse = Adresse(0, "numeroAdresse", "nomAdresse", "codePostal", "ville", telephone);
    List<ReseauSocial> listReseau = <ReseauSocial>[];
    ReseauSocial("nomReseau", "url");
    TypeClient type = TypeClient(0, "titreTypeClient");
    Client client =  Client("nomClient", "prenomClient", "email@email.fr", adresse, listReseau, type);
    client.create();
    print(client.create().toString());
    print("");
  });
}
