import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

abstract class CRUDAll {
  dynamic create();
  void read(var id);
  void update();
  void delete();
  dynamic readAll();
}

class ObjectParamUnimplementedError implements UnimplementedError {
  String error() => 'Le paramette n\'a pas été implementé corectement';

  @override
  String? get message => throw UnimplementedError();

  @override
  StackTrace? get stackTrace => throw UnimplementedError();
}

class RequeteHttp {
  // static Response methodeGet (String param) {
  //   //...
  //   return null;
  // }
  static Future<Response> methodePost (String url, var paramJson)  async {
    return await Dio().post(url,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(paramJson),
    );
  }
}