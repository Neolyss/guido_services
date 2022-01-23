import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';

Future<List<CountryCode>> fetchCountryCodes() async {
  final String response = await rootBundle.loadString('json/CountryCodes.json');
  Map<String, dynamic> json = await jsonDecode(response);
  List<CountryCode> codes = [];
  json["codes"].map((i) => CountryCode.fromJson(i)).forEach((e) => codes.add(e));
  return codes;
}

class CountryCode {
  /*
  * "name": "Afghanistan",
  * "dial_code": "+93",
  * "code": "AF"
  */
  final String name;
  final String dialCode;
  final String code;

  CountryCode({
    required this.name,
    required this.dialCode,
    required this.code,
  });

  factory CountryCode.fromJson(Map<String,dynamic> json) {
    return CountryCode(name: json["name"], dialCode: json["dial_code"], code: json["code"],);
  }
}